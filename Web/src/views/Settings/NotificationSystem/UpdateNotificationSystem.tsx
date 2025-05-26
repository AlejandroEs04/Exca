import { useParams } from "react-router-dom"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import { useEffect, useState } from "react"
import { NotificationSystem } from "../../../types"
import { getNotificationSystems } from "../../../api/NotificationSystemApi"
import { useAppContext } from "../../../hooks/AppContext"

export default function UpdateNotificationSystem() {
    const { id } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Sistemas de notificaciones",url:'/settings/notification-systems'},
        {name:"Administrar Sistema",url:`/settings/notification-systems/edit/${id}`}
    ]
    const [notificationSystem, setNotificationSystem] = useState<NotificationSystem>()
    const { state, dispatch } = useAppContext()

    const getData = async() => {
        const notificationSystems = await getNotificationSystems()

        if(notificationSystems) {
            dispatch({ type: 'set-notification-systems', payload: { notificationSystems } })
            localStorage.setItem("notificationSystems", JSON.stringify(notificationSystems))
            setNotificationSystem(notificationSystems.find(n => n.id === +id!))
        }
    }

    useEffect(() => {
        if(state.notificationSystems.length && id) {
            setNotificationSystem(state.notificationSystems.find(n => n.id === +id))
        } else {
            getData()
        }
    }, [])

    return (
        <>
            <Breadcrumb list={list} />
            <h1>{notificationSystem?.name}</h1>
        </>
    )
}
