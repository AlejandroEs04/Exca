import { useEffect, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { useAppContext } from '../../hooks/AppContext'
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb'
import { currencyFormat, dateFormat } from '../../utils'
import Loader from '../../components/shared/Loader/Loader'
import { toast } from 'react-toastify'
import InputGroup from '../../components/forms/InputGroup'
import LeaseRequestInformation from '../../components/LeaseRequest/LeaseRequestInformation'
import ListIcon from '../../components/shared/Icons/ListIcon'
import DocumentTextIcon from '../../components/shared/Icons/DocumentTextIcon'
import ActivitiesIcon from '../../components/shared/Icons/ActivitiesIcon'
import { Project as ProjectType } from '../../types'

export default function Project() {
    const { id } = useParams()
    const navigate = useNavigate()
    const { isLoading } = useAppContext()

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${id}`},
    ]

    const { state } = useAppContext()
    const [project, setProject] = useState<ProjectType | null>(null)

    useEffect(() => {
        if(state.projects.length) {
            const project = state.projects.find(project => project.id === +id!)
            
            if(!project) {
                toast.error("No existe el proyecto seleccionado")
                navigate("/projects")
                return
            }
        
            setProject(project)
        }
    }, [id, state.projects])

    if(isLoading || !project) return <Loader />
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Proyecto</h1>
            <p className='date'>Creado el: {dateFormat(project.created_at)}</p>
            <p className='mt-1'>Estatus: {project.stage?.name}</p>

            <div className='mt-1 flex g-1'>
                <Link to={`/contract-request/${id}/${project.lease_request !== null ? project.lease_request?.id : ''}`} className='btn btn-primary w-max'>Solicitud de contrato</Link>

                {(project.stage_id === 3) && (
                    <>
                        <Link to={`/technical-case/${id}/${project.cases?.find(c => c.case_type_id === 1)?.id ?? ''}`} className='btn btn-primary w-max'>
                            <ListIcon />
                            Carátula técnica
                        </Link>
                        <Link to={`/legal-case/${id}`} className='btn btn-indigo w-max'>
                            <DocumentTextIcon />
                            Carátula Legal
                        </Link>
                        <Link to={`activities`} className='btn btn-esmerald w-max'>
                            <ActivitiesIcon />
                            Actividades
                        </Link>
                    </>
                )}
                {/* <button className='btn btn-danger'><XMark /> Cerrar</button> */}
            </div>

            <h2 className='mt-2'>Datos del arrendatario</h2>
            <div className='grid grid-cols-3 g-1'>
                <InputGroup label='Empresa' placeholder='Nombre de la empresa' value={project.brand?.client?.business_name!} name='bussiness_name' />
                <InputGroup label='Cliente' placeholder='Nombre del cliente' value={project.brand?.name!} name='brand_name' />
                <InputGroup label='Giro de la empresa' placeholder='Giro de la empresa' value={''} name='business_turn' />
            </div>

            <h2 className='mt-2'>Datos del inmueble objeto de arrendamiento</h2>
            <table>
                <thead>
                    <tr>
                        <th>Expediente Catastral</th>
                        <th>Área</th>
                        <th>Precio por Área</th>
                        <th>Renta Mensual</th>
                        <th>Tipo de arrendamiento</th>
                    </tr>
                </thead>

                <tbody>
                    {project.lands?.map(land => (
                        <tr key={land.id}>
                            <td>{land.land?.cadastral_file}</td>
                            <td>{land.area}</td>
                            <td>{currencyFormat(land.land?.price_per_area!)}</td>
                            <td>{currencyFormat(land.area * land.land?.price_per_area!)}</td>
                            <td>{land.type?.name}</td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <div className='mt-2'>
                {project.lease_request && <LeaseRequestInformation leaseRequest={project.lease_request} />}
                
                <div className='flex items-center g-2'>
                    <h3>Aprobaciones: </h3>
                    {/* {project?.approvations?.filter(a => a.step?.flow_id === 1).map(a => (
                        <div>
                            <p className={`approbation-name ${a.response ? 'text-green' : 'text-red'}`}>{a.step?.signator.full_name}</p>
                        </div>
                    ))} */}
                </div>
                
            </div>
        </>
    )
}
