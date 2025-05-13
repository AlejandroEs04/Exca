import { Link } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { useEffect, useState } from "react"
import { ApprovalFlow } from "../../types"
import { useAppContext } from "../../hooks/AppContext"
import { getFlows } from "../../api/ApprovalFlowApi"
import Loader from "../../components/shared/Loader/Loader"
import EditIcon from "../../components/shared/Icons/EditIcon"

export default function ApprovalFlows() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Flujos de aprobaciones",url:'/settings/approval-flows'},
    ]

    const [flows, setFlows] = useState<ApprovalFlow[]>([])
    const { setIsLoading, isLoading } = useAppContext()

    useEffect(() => {
        const getInfo = async() => {
            setIsLoading(true)
            try {
                const flows = await getFlows()
                if(!flows) return
    
                setFlows(flows)
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
                                    <Link to={`edit/${flow.id}`} className="text-blue"><EditIcon /></Link>                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
