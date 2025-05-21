import { Link } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { useEffect, useState } from "react"
import { ApprovalFlow } from "../../types"
import { getFlows } from "../../api/ApprovalFlowApi"
import EditIcon from "../../components/shared/Icons/EditIcon"

export default function ApprovalFlows() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Flujos de aprobaciones",url:'/settings/approval-flows'},
    ]

    const [flows, setFlows] = useState<ApprovalFlow[]>([])

    useEffect(() => {
        const getInfo = async() => {
            try {
                console.log("hola")
                const flows = await getFlows()
                console.log(flows)
                if(!flows) return
                setFlows(flows)
            } catch (error) {   
                console.log(error)
            }
        }
        getInfo()
    }, [])

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Flujos de aprobaciones</h1>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    {flows.map(flow => (
                        <tr key={flow.id}>
                            <td>{flow.id}</td>
                            <td>{flow.name}</td>
                            <td>
                                <div className="table-actions">
                                    <Link to={`edit/${flow.id}`} className="text-blue"><EditIcon /></Link>                                
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
