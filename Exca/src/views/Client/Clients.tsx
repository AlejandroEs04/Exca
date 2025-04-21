import { Link, useNavigate } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { useAppContext } from "../../hooks/AppContext"
import EditIcon from "../../components/shared/Icons/EditIcon"
import TrashIcon from "../../components/shared/Icons/TrashIcon"
import { deleteClient } from "../../api/ClientApi"

export default function Clients() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Empresas",url:'/clients'},
    ]

    const { state, dispatch } = useAppContext()

    const onDeleteClient = async(id: number) => {
        try {
            await deleteClient(id)

            const newClients = state.clients.filter((client) => client.id !== id)
            dispatch({ type: 'set-clients', paypload: { clients: newClients } })
        } catch (error) {
            // SET AN ALERT
        }
    }

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Clientes</h1>

            <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Razón Social</th>
                        <th>RFC</th>
                        <th>Contacto</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {state.clients.map((client) => (
                        <tr key={client.id}>
                            <td>{client.id}</td>
                            <td>{client.business_name}</td>
                            <td>{client.tax_id}</td>
                            <td>{client.email}</td>
                            <td>
                                <div className="table-actions">
                                    <Link to={`/clients/edit/${client.id}`} className="text-blue"><EditIcon /></Link>
                                    <button onClick={() => onDeleteClient(client.id)} className="text-red"><TrashIcon /></button>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
