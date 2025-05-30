import { useParams } from "react-router-dom"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import { ChangeEvent, FormEvent, useEffect, useState } from "react"
import { NotificationSystemCreate } from "../../../types"
import { getNotificationSystems, updateNotificationSystem } from "../../../api/NotificationSystemApi"
import { useAppContext } from "../../../hooks/AppContext"
import SelectGroup from "../../../components/forms/SelectGroup"
import PlusIcon from "../../../components/shared/Icons/PlusIcon"
import TrashIcon from "../../../components/shared/Icons/TrashIcon"
import { toast } from "react-toastify"
import SaveIcon from "../../../components/shared/Icons/SaveIcon"

export default function UpdateNotificationSystem() {
    const { id } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Sistemas de notificaciones",url:'/settings/notification-systems'},
        {name:"Administrar Sistema",url:`/settings/notification-systems/edit/${id}`}
    ]
    const [notificationSystem, setNotificationSystem] = useState<NotificationSystemCreate>({
        name: '', 
        description: '', 
        recipients: [], 
        is_active: true
    })
    const { state, dispatch } = useAppContext()
    const [recipientid, setRecipientId] = useState(0)

    const getData = async() => {
        const notificationSystems = await getNotificationSystems()

        if(notificationSystems) {
            dispatch({ type: 'set-notification-systems', payload: { notificationSystems } })
            localStorage.setItem("notificationSystems", JSON.stringify(notificationSystems))

            const notificationSystem = notificationSystems.find(n => n.id === +id!)

            setNotificationSystem({
                name: notificationSystem?.name ?? '', 
                description: notificationSystem?.description ?? '', 
                recipients: notificationSystem?.recipients ?? [], 
                is_active: notificationSystem?.is_active ?? true
            })
        }
    }

    const handleChangeRecipient = (e: ChangeEvent<HTMLSelectElement>) => setRecipientId(+e.target.value)

    const handleAddUser = () => {
        if(recipientid === 0) return

        const existsUser = notificationSystem.recipients.find(u => u.user_id === recipientid)

        if(!existsUser) {
            setNotificationSystem({
                ...notificationSystem, 
                recipients: [
                    ...notificationSystem.recipients, 
                    {
                        user_id: recipientid
                    }
                ]
            })
        }
    }

    const handleDeleteUser = (id: number) => {
        setNotificationSystem({
            ...notificationSystem, 
            recipients: notificationSystem.recipients.filter(r => r.user_id !== id)
        })
    }

    const handleSubmit = async(e: FormEvent) => {
        e.preventDefault()

        try {
            await updateNotificationSystem(+id!, notificationSystem)
            toast.success("Systema de notificación actualizadó")
        } catch (error) {
            
        }
    }

    useEffect(() => {
        if(state.notificationSystems.length && id) {
            const notificationSystem = state.notificationSystems.find(n => n.id === +id)

            setNotificationSystem({
                name: notificationSystem?.name ?? '', 
                description: notificationSystem?.description ?? '', 
                recipients: notificationSystem?.recipients ?? [], 
                is_active: notificationSystem?.is_active ?? true
            })
        } else {
            getData()
        }
    }, [])

    return (
        <>
            <Breadcrumb list={list} />
            <h1>{notificationSystem?.name}</h1>

            <form onSubmit={handleSubmit}>
                <button className="btn btn-primary"><SaveIcon/> Guardar</button>

                <div className="mt-1">
                    <SelectGroup value={recipientid} onChangeFnc={handleChangeRecipient} label="Seleccione destinatario" placeholder="Seleccione un destinatario" name="recipient_id" options={state.users.map(u => { return { label: u.full_name, value: u.id } })} />
                    <button type="button" onClick={handleAddUser} className="btn btn-success btn-sm mt-1"><PlusIcon /> Agregar</button>

                    <div className="card-list mt-2">
                        {notificationSystem.recipients.map(r => (
                            <div className="card">
                                <div className="card-info">
                                    <p>ID: {r.user_id}</p>
                                    <p className="card-name">Nombre: {state.users.find(u => u.id === r.user_id)?.full_name}</p>
                                </div>

                                <div className="card-actions">
                                    <button onClick={() => handleDeleteUser(r.user_id)} className="text-red"><TrashIcon /></button>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </form>

        </>
    )
}
