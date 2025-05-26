import { Link } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { useAppContext } from "../../hooks/AppContext"
import TrashIcon from "../../components/shared/Icons/TrashIcon"
import EditIcon from "../../components/shared/Icons/EditIcon"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import Loader from "../../components/shared/Loader/Loader"

export default function Users() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Usuarios",url:'/settings/users'},
    ]

    const { state, isLoading } = useAppContext()

    if(isLoading) return <Loader />

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Usuarios</h1>

            <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Titulo</th>
                        <th>Área</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {state.users.map(user => (
                        <tr key={user.id}>
                            <td>{user.id}</td>
                            <td>{user.full_name}</td>
                            <td>{user.email}</td>
                            <td>{user.rol?.name}</td>
                            <td>{user.user_title_id}</td>
                            <td>{user.area?.name}</td>
                            <td>
                                <div className="table-actions">
                                    <Link to={`/settings/users/edit/${user.id}`} className="text-blue"><EditIcon /></Link>
                                    <button className="text-red"><TrashIcon /></button>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
