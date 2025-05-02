import { Link, useNavigate } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { useAppContext } from "../../hooks/AppContext"
import EditIcon from "../../components/shared/Icons/EditIcon"
import TrashIcon from "../../components/shared/Icons/TrashIcon"

export default function Projects() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Cartera de interesados",url:'/projects'},
    ]

    const { state } = useAppContext()
    const navigate = useNavigate()

    const handleProject = (id: number) => navigate(`/projects/${id}`)
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Cartera de interesados</h1>
            
            <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Fraccionamiento</th>
                        <th>Cliente</th>
                        <th>Marca</th>
                        <th>Estatus</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {state.projects.map(project => (
                        <tr onDoubleClick={() => handleProject(project.id)} key={project.id}>
                            <td>{project.id}</td>
                            <td>
                                {project.lands.map(land => land.land.residential_development.name).join(', ')}
                            </td>
                            <td>{project.brand.client.business_name}</td>
                            <td>{project.brand.name}</td>
                            <td>{project.stage.name}</td>
                            <td>
                                <div className="table-actions">
                                    <Link to={`/projects/edit/${project.id}`} className="text-blue"><EditIcon /></Link>
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
