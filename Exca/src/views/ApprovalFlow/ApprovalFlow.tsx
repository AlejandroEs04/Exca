import {
    DndContext,
    closestCenter,
    PointerSensor,
    useSensor,
    useSensors,
} from "@dnd-kit/core";
import {
    arrayMove,
    SortableContext,
    useSortable,
    verticalListSortingStrategy,
} from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { ChangeEvent, useEffect, useState } from "react";
import { User } from "../../types";
import { useAppContext } from "../../hooks/AppContext";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import SaveIcon from "../../components/shared/Icons/SaveIcon";
import { Option } from "../../components/forms/InputGroup";
import SelectGroup from "../../components/forms/SelectGroup";
import TrashIcon from "../../components/shared/Icons/TrashIcon";

const SortableApproverItem = ({ approver, deleteUser }: { approver: User, deleteUser: (id: number) => void }) => {
    const {
        attributes,
        listeners,
        setNodeRef,
        transform,
        transition,
    } = useSortable({ id: approver.id });
  
    const style = {
        transform: CSS.Transform.toString(transform),
        transition,
    };
  
    return (
        <div
            ref={setNodeRef}
            style={style}
            {...attributes}
            {...listeners}
            className="drag-item"
            onDoubleClick={() => deleteUser(approver.id)}
        >
            <div>
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M8.25 15 12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" />
                </svg>
                {approver.full_name}
            </div>
            
            <div>
                <button className="btn text-red"><TrashIcon /></button>
            </div>
        </div>
    );
};

export default function ApprovalFlow() {
    const [approvers, setApprovers] = useState<User[]>([]);
    const [userOprions, setUserOptions] = useState<Option[]>([])
    const [userId, setUserId] = useState(0)
    const { state } = useAppContext()

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Flujos de aprobación",url:'/lands'},
        {name:"Editar Flujo",url:'/lands/create'},
    ]
    
    const sensors = useSensors(useSensor(PointerSensor));
    
    const handleDragEnd = (event: any) => {
        const { active, over } = event;
        if (active.id !== over?.id) {
          const oldIndex = approvers.findIndex((a) => a.id === active.id);
          const newIndex = approvers.findIndex((a) => a.id === over?.id);
          setApprovers((items) => arrayMove(items, oldIndex, newIndex));
        }
    };

    const handleChange = (e: ChangeEvent<HTMLSelectElement>) => {
        setUserId(+e.target.value)
    }

    const addUser = () => {
        const existsUser = approvers.find(u => u.id === userId);
        if(existsUser) return
        
        const newUser = state.users.find(u => u.id === userId);
        if(!newUser) return 
        setApprovers([...approvers, newUser])
    }

    const deleteUser = (id: number) => {
        console.log(id)
        setApprovers(approvers.filter(a => a.id !== id))
    }
    
    const handleSubmit = () => {
        const payload = approvers.map((a, index) => ({
          id: a.id,
          order: index + 1,
        }));
    
        fetch("/api/approval-flow", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ approvers: payload }),
        });
    };
    
    useEffect(() => {
        setUserOptions(state.users.map(u => { return { value: u.id, label: u.full_name } }))
    }, [state.users])
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Editar Flujo</h1>

            <button type="submit" className="btn btn-success">
                <SaveIcon />
                Guardar
            </button>

            <div className="mt-2">
                <SelectGroup value={userId} id="userId" label="Usuario" options={userOprions} onChangeFnc={handleChange} name="userId" placeholder="Seleccione un usuario" />
                <button className="btn btn-primary mt-1" onClick={addUser}>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                        <path strokeLinecap="round" strokeLinejoin="round" d="M18 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0ZM3 19.235v-.11a6.375 6.375 0 0 1 12.75 0v.109A12.318 12.318 0 0 1 9.374 21c-2.331 0-4.512-.645-6.374-1.766Z" />
                    </svg>
                    Agregar
                </button>
            </div>

            <div className="mt-2">
                <h2>Flujo de aprobaciones</h2>
                <p className="mb-1">Arrastra para asignar un flujo, haz doble click para eliminar</p>
                <DndContext sensors={sensors} collisionDetection={closestCenter} onDragEnd={handleDragEnd}>
                    <SortableContext items={approvers.map((a) => a.id)} strategy={verticalListSortingStrategy}>
                        {approvers.map((approver) => (
                            <SortableApproverItem deleteUser={deleteUser} key={approver.id} approver={approver} />
                        ))}
                    </SortableContext>
                </DndContext>
            </div>
        
        </>
    );
}