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
import { ApprovalFlowCreate, ApprovalFlow as ApprovalFlowType, User } from "../../types";
import { useAppContext } from "../../hooks/AppContext";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import SaveIcon from "../../components/shared/Icons/SaveIcon";
import InputGroup, { Option, PushEvent } from "../../components/forms/InputGroup";
import SelectGroup from "../../components/forms/SelectGroup";
import TrashIcon from "../../components/shared/Icons/TrashIcon";
import { useNavigate, useParams } from "react-router-dom";
import Loader from "../../components/shared/Loader/Loader";
import { getFlows, updateFlow } from "../../api/ApprovalFlowApi";
import { toast } from "react-toastify";

const SortableApproverItem = ({ approver, deleteUser, i }: { approver: User, deleteUser: (id: number) => void, i:number }) => {
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
                {i+1 + ' : '}
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
    const [flow, setFlow] = useState<ApprovalFlowType>({
        id: 0,
        name: '', 
        steps: []
    })
    const [userId, setUserId] = useState(0)
    const { state, setIsLoading, isLoading } = useAppContext()
    const { id } = useParams()
    const navigate = useNavigate()

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Flujos de aprobación",url:'/settings/approval-flows'},
        {name:"Editar Flujo",url:`/settings/approval-flows/edit/${id}`},
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

    const handleChange = (e: ChangeEvent<HTMLSelectElement | HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target

        if(name === "userId") {
            setUserId(+value)
            return
        }

        setFlow({
            ...flow, 
            [name]: value
        })
    }

    const addUser = () => {
        const existsUser = approvers.find(u => u.id === userId);
        if(existsUser) return
        
        const newUser = state.users.find(u => u.id === userId);
        if(!newUser) return 
        setApprovers([...approvers, newUser])
    }

    const deleteUser = (id: number) => {
        setApprovers(approvers.filter(a => a.id !== id))
    }
    
    const handleSubmit = async() => {
        const payload = approvers.map((a, index) => ({
            signator_id: a.id,
            order: index + 1,
        }));

        const flowForUpdate : ApprovalFlowCreate = {
            name: flow.name, 
            steps: payload
        }

        try {
            await updateFlow(+id!, flowForUpdate)
            toast.success("Flujo actualizado correctamente")
        } catch (error) {
            console.log(error)
        }
    };
    
    useEffect(() => {
        setUserOptions(state.users.map(u => { return { value: u.id, label: u.full_name } }))
    }, [state.users])

    useEffect(() => {
        if(state.users.length) {
            const stepsById = Object.fromEntries(flow.steps.map(s => [s.id, s]));
            const allNextIds = new Set(flow.steps.map(step => step.next_step_id).filter(id => id !== null));
            const firstStep = flow.steps.find(step => !allNextIds.has(step.id));
    
            const orderedSteps = [];
            let currentStep = firstStep;
    
            while (currentStep) {
                orderedSteps.push(currentStep);
                currentStep = stepsById[currentStep.next_step_id!];
            }
    
            const users = orderedSteps.map(s => {
                return state.users.find(u => u.id === s.signator_id)!
            })
            setApprovers(users)
        }
    }, [state.users, flow])

    useEffect(() => {
        const getInfo = async() => {
            setIsLoading(true)
            try {
                const flows = await getFlows()
                if(!flows) return

                const currentFlow = flows.find(f => f.id === +id!)
                if(!currentFlow) {
                    navigate('/flows')
                    return
                }
                setFlow(currentFlow)
            } catch (error) {
                console.log(error)
            } finally {
                setIsLoading(false)
            }
        }
        getInfo()
    }, [])

    if(isLoading) return <Loader />
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Editar Flujo</h1>

            <button type="button" onClick={handleSubmit} className="btn btn-success">
                <SaveIcon />
                Guardar
            </button>

            <div className="mt-2">
                <InputGroup placeholder="Nombre" label="Nombre" value={flow.name} onChangeFnc={handleChange} name="name" />

                <h2 className="mt-2">Usuarios</h2>
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
                        {approvers.map((approver, i) => (
                            <SortableApproverItem i={i} deleteUser={deleteUser} key={approver.id} approver={approver} />
                        ))}
                    </SortableContext>
                </DndContext>
            </div>
        
        </>
    );
}