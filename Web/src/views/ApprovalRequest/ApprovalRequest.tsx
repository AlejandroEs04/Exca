import { useEffect, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { getApprovalRequests, responseApprovalRequest } from "../../api/ApprovalFlowApi"
import { ApprovalRequest as ApprovalRequestType } from "../../types"
import CheckIcon from "../../components/shared/Icons/CheckIcon"
import XMark from "../../components/shared/Icons/XMark"
import { useNavigate } from "react-router-dom"
import { toast } from "react-toastify"
import { useAppContext } from "../../hooks/AppContext"

export default function ApprovalRequest() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Aprobaciones pendientes",url:'/approval-requests'},
    ]
    const [requests, setRequests] = useState<ApprovalRequestType[]>()
    const navigate = useNavigate()
    const { setError, state } = useAppContext()

    const navigateApprovation = (id: number) => {
        const currentRequest = requests?.find(r => r.id === id)
        const leaseRequests = state.projects.map(p => p.lease_request)
        const projectId = leaseRequests.find(l => l?.id === id)?.project_id
        
        switch (currentRequest?.step?.flow_id) {
            case 1: 
                // Lease Request
                navigate(`/contract-request/${projectId}/${currentRequest.item_id}`)
            break;
        }
    }

    const handleResponse = async(id: number, response: boolean) => {
        try {
            await responseApprovalRequest(id, response)

            if (requests) {
                setRequests(requests.map(r => r.id === id ? { ...r, response } : r))
            }
            toast.success("Se mando su respuesta correctamente")
        } catch (error) {
            setError(error)
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

            {requests?.filter(r => r.response === null).length === 0 ? (
                <h3>No tiene aprobaciones pendientes</h3>
            ) : (            
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
                                        <button onClick={() => handleResponse(r.id, true)}>
                                            <CheckIcon color="text-green" />
                                        </button>
                                        <button onClick={() => handleResponse(r.id, false)}>
                                            <XMark color="text-red" />
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            )}
        </>
    )
}
