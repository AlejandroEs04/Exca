import { useParams } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { ChangeEvent, useState } from "react"
import InputGroup, { PushEvent } from "../../components/forms/InputGroup"

export default function Activities() {
    const { id } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${id}`},
        {name:"Proyecto",url:`/projects/${id}/activities`},
    ]
    const [newActivity, setNewActivity] = useState({
        description: '', 
        responsible_area_id: 0, 
        responsible_id: 0, 
        due_date: ''
    })

    const handleChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {

    }

    return (
        <>
            <Breadcrumb list={list} />   
            <h1>Actividades</h1>

            <div className="grid grid-cols-2 g-2">
                <div className="flex flex-col g-1">
                    <InputGroup name="description" value={newActivity.description} onChangeFnc={handleChange} placeholder="Descriptión de la tarea" label="Descriptión" />
                    <InputGroup type='date' name="due_date" value={newActivity.due_date} onChangeFnc={handleChange} placeholder="Fecha de Vencimiento" label="Fecha de vencimiento" />
                </div>
            </div>

        </>
    )
}
