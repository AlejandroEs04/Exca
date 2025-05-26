import { useEffect } from "react"
import { getNotificationSystems } from "../../../api/NotificationSystemApi"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import { Link } from "react-router-dom"
import EditIcon from "../../../components/shared/Icons/EditIcon"
import { useAppContext } from "../../../hooks/AppContext"

export default function NotificationSystems() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Sistemas de notificaciones",url:'/settings/notification-systems'},
    ]
    const { state, dispatch } = useAppContext()

    useEffect(() => {
        const getData = async() => {
            const notificationsSystemsStorage = localStorage.getItem("notificationSystems")

            if(notificationsSystemsStorage) {
                const storage = JSON.parse(notificationsSystemsStorage)
                dispatch({ type: 'set-notification-systems', payload: { notificationSystems: storage } })
            }

            const notificationSystems = await getNotificationSystems()

            if(notificationSystems) {
                dispatch({ type: 'set-notification-systems', payload: { notificationSystems } })
                localStorage.setItem("notificationSystems", JSON.stringify(notificationSystems))
            }
        }
        getData()
    }, [])

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Sistemas de notificaciones</h1>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Activo</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    {state.notificationSystems.map(notificationSystem => (
                        <tr key={notificationSystem.id}>
                            <td>{notificationSystem.id}</td>
                            <td>{notificationSystem.name}</td>
                            <td>{notificationSystem.description ?? 'N/I'}</td>
                            <td>{notificationSystem.is_active ? 'Activo' : 'Inactivo'}</td>
                            <td>
                                <div className="table-actions">
                                    <Link to={`edit/${notificationSystem.id}`} className="text-blue"><EditIcon /></Link>                                
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
