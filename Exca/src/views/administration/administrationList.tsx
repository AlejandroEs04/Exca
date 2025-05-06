import { Link, useNavigate } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import PlusIcon from "../../components/shared/Icons/PlusIcon";
import { useAppContext } from "../../hooks/AppContext";
import TrashIcon from "../../components/shared/Icons/TrashIcon";
import EditIcon from "../../components/shared/Icons/EditIcon";
import Loader from "../../components/shared/Loader/Loader";


export default function AdministrationList() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Administración",url:'/administration'},
    ]
    const statusOptions: Record<number, string> = {
        1: 'PENDIENTE',
        2: 'VALIDADO',
        3: 'INACTIVO'
    };
    

    const { state } = useAppContext()
    const navigate = useNavigate()

    const handleProject = (id: number) => navigate(`/administration/billing/${id}`)
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Administración</h1>
            {
                /*
                <Link to={'create'} className="btn btn-primary">
                    <PlusIcon />
                    Registrar
                </Link>
                
                */
            }
            <h2>Este mes - Junio 2025</h2>
            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Cliente</th>
                        <th>Estatus</th>
                        <th>Facturado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <tr onDoubleClick={() => handleProject(11)} key={11}>
                        <td>1</td>
                        <td>
                            Contrato de Arrendamiento Dollar General / ANZ
                        </td>
                        <td>Femsa S.A. de C.V.</td>
                        <td style={{ backgroundColor: 'lightyellow' }}>Pendiente Formato</td>
                        <td>NO</td>
                        <td>
                            <div className="table-actions">
                                <Link to={`/administration/billing/11`} className="text-blue">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5 text-gray-600">
                                    <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 12s3.75-6.75 9.75-6.75 9.75 6.75 9.75 6.75-3.75 6.75-9.75 6.75S2.25 12 2.25 12z" />
                                    <path strokeLinecap="round" strokeLinejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                </svg>
                                </Link>
                               
                            </div>
                        </td>
                    </tr>
                    <tr onDoubleClick={() => handleProject(11)} key={11}>
                        <td>2</td>
                        <td>
                            Contrato de Arrendamiento 7-ELEVEN Alba
                        </td>
                        <td>Femsa S.A. de C.V.</td>
                        <td style={{ backgroundColor: 'moccasin' }}>Pendiente Autorización</td>
                        <td>NO</td>
                        <td>
                            <div className="table-actions">
                                <Link to={`/administration/billing/11`} className="text-blue">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5 text-gray-600">
                                    <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 12s3.75-6.75 9.75-6.75 9.75 6.75 9.75 6.75-3.75 6.75-9.75 6.75S2.25 12 2.25 12z" />
                                    <path strokeLinecap="round" strokeLinejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                </svg>
                                </Link>
                                
                            </div>
                        </td>
                    </tr>
                    <tr onDoubleClick={() => handleProject(11)} key={11}>
                        <td>3</td>
                        <td>
                            Contrato de Arrendamiento 7-ELEVEN Anáhuac San Patricio
                        </td>
                        <td>Femsa S.A. de C.V.</td>
                        <td style={{ backgroundColor: 'lightgreen' }}>Autorizado</td>
                        <td>SI</td>
                        <td>
                            <div className="table-actions">
                                <Link to={`/administration/billing/11`} className="text-blue">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5 text-gray-600">
                                    <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 12s3.75-6.75 9.75-6.75 9.75 6.75 9.75 6.75-3.75 6.75-9.75 6.75S2.25 12 2.25 12z" />
                                    <path strokeLinecap="round" strokeLinejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                </svg>

                                </Link>

                            </div>
                        </td>
                    </tr>
                   
                </tbody>
            </table>

           
        </>
    )
}
