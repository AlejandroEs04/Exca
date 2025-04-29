import { useEffect } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { getApprovalRequests } from "../../api/ApprovalFlowApi"

export default function ApprovalRequest() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Aprobaciones pendientes",url:'/approval-requests'},
    ]

    useEffect(() => {
        const getInfo = async() => {
            const requests = await getApprovalRequests()
        }
        getInfo()
    }, [])

    return (
        <>
            <Breadcrumb list={list} /> 
            <h1>Aprobaciones pendientes</h1>
        </>
    )
}
