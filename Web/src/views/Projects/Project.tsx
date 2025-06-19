import { useEffect, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { useAppContext } from '../../hooks/AppContext'
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb'
import { dateFormat } from '../../utils'
import Loader from '../../components/shared/Loader/Loader'
import { toast } from 'react-toastify'
import InputGroup from '../../components/forms/InputGroup'
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
                <Link to={`/contract-request/${id}/${project.lease_request !== null ? project.lease_request?.id : ''}`} className='btn btn-primary w-max'>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                        <path strokeLinecap="round" strokeLinejoin="round" d="M8.25 7.5V6.108c0-1.135.845-2.098 1.976-2.192.373-.03.748-.057 1.123-.08M15.75 18H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08M15.75 18.75v-1.875a3.375 3.375 0 0 0-3.375-3.375h-1.5a1.125 1.125 0 0 1-1.125-1.125v-1.5A3.375 3.375 0 0 0 6.375 7.5H5.25m11.9-3.664A2.251 2.251 0 0 0 15 2.25h-1.5a2.251 2.251 0 0 0-2.15 1.586m5.8 0c.065.21.1.433.1.664v.75h-6V4.5c0-.231.035-.454.1-.664M6.75 7.5H4.875c-.621 0-1.125.504-1.125 1.125v12c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V16.5a9 9 0 0 0-9-9Z" />
                    </svg>
                    Solicitud de contrato
                </Link>

                {(project.stage_id === 3) && (
                    <>
                        <Link to={`/technical-case/${id}/${project.cases?.find(c => c.case_type_id === 1)?.id ?? ''}`} className='btn btn-primary w-max'>
                            <ListIcon />
                            Carátula técnica
                        </Link>
                        <Link to={`/legal-case/${id}/${project.cases?.find(c => c.case_type_id === 2)?.id ?? ''}`} className='btn btn-indigo w-max'>
                            <DocumentTextIcon />
                            Carátula Legal
                        </Link>
                        <Link to={`tasks`} className='btn btn-esmerald w-max'>
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
                        <th>Tipo de arrendamiento</th>
                    </tr>
                </thead>

                <tbody>
                    {project.lands?.map(land => (
                        <tr key={land.id}>
                            <td>{land.land?.cadastral_file}</td>
                            <td>{land.area}</td>
                            <td>{land.type?.name}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
