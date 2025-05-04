import { Link, useNavigate } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import PlusIcon from "../../components/shared/Icons/PlusIcon";
import { useAppContext } from "../../hooks/AppContext";
import TrashIcon from "../../components/shared/Icons/TrashIcon";
import EditIcon from "../../components/shared/Icons/EditIcon";
import Loader from "../../components/shared/Loader/Loader";

export default function ProjectsToVerify() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Validar Proyectos",url:'/verify-projects'},
    ]
    const statusOptions: Record<number, string> = {
        1: 'PENDIENTE',
        2: 'VALIDADO',
        3: 'INACTIVO'
    };
    

    const { state } = useAppContext()
    const navigate = useNavigate()

    const handleProject = (id: number) => navigate(`/verify-projects/form-project/${id}`)
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Validar Interesados</h1>
            {
                /*
                <Link to={'create'} className="btn btn-primary">
                    <PlusIcon />
                    Registrar
                </Link>
                
                */
            }
            

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
                                    <Link to={`/verify-projects/form-project/${project.id}`} className="text-blue"><EditIcon /></Link>
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
