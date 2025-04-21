import { Link } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { useAppContext } from "../../hooks/AppContext"

export default function Projects() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
    ]

    const { state } = useAppContext()
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Proyectos</h1>
            
            <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Fraccionamiento</th>
                        <th>Estatus</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {state.projects.map(project => (
                        <tr>
                            <td>{project.id}</td>
                            <td>{project.name}</td>
                            <td>
                                {project.lands.map(land => land.land.residential_development).join(', ')}
                            </td>
                            <td>{project.stage.name}</td>
                            <td>
                                <div>
                                    <Link to={`/projects/${project.id}`} className="btn btn-secondary">Ver</Link>
                                    <Link to={`/projects/${project.id}/edit`} className="btn btn-secondary">Editar</Link>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
