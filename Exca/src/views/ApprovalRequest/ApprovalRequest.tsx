import { useEffect, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { getApprovalRequests } from "../../api/ApprovalFlowApi"
import { ApprovalRequest as ApprovalRequestType } from "../../types"
import CheckIcon from "../../components/shared/Icons/CheckIcon"
import XMark from "../../components/shared/Icons/XMark"
import { useNavigate } from "react-router-dom"

export default function ApprovalRequest() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Aprobaciones pendientes",url:'/approval-requests'},
    ]
    const [requests, setRequests] = useState<ApprovalRequestType[]>()
    const navigate = useNavigate()

    const navigateApprovation = (id: number) => {
        const currentRequest = requests?.find(r => r.id === id)

        console.log(currentRequest)
        
        switch (currentRequest?.step?.flow_id) {
            case 1: 
                // Lease Request
                navigate(`/contract-request/${currentRequest.item_id}`)
            break;
        }
    }

    useEffect(() => {
        const getInfo = async() => {
            const requests = await getApprovalRequests()
            if(requests) setRequests(requests)
        }
        getInfo()
    }, [])

    return (
        <>
            <Breadcrumb list={list} /> 
            <h1>Aprobaciones pendientes</h1>

            <table>
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Flow</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {requests?.filter(r => r.response === null).map(r => (
                        <tr key={r.id} onDoubleClick={() => navigateApprovation(r.id)}>
                            <td>{r.id}</td>
                            <td>{r.step?.flow?.name}</td>
                            <td>
                                <div className="table-actions">
                                    <button>
                                        <CheckIcon color="text-green" />
                                    </button>

                                    <button>
                                        <XMark color="text-red" />
                                    </button>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
