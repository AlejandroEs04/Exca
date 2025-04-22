import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { useAppContext } from '../../hooks/AppContext'
import { ProjectView } from '../../types'
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb'
import { currencyFormat, dateFormat } from '../../utils'

export default function Project() {
    const { id } = useParams()

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${id}`},
    ]

    const { state } = useAppContext()
    const [project, setProject] = useState<ProjectView | null>(null)

    useEffect(() => {
        const project = state.projects.find(project => project.id === +id!)
    
        if(!project) return
    
        setProject(project)
    }, [id, state.projects])

    if (!project) return <div>Cargando...</div>
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>{project?.name}</h1> 
            <p className='date'>Creado el: {dateFormat(project.created_at)}</p>
            <p className='mt-1'>Estatus: {project?.stage.name}</p>

            {project.stage_id === 1 && (
                <Link to={`/contract-request/${id}`} className='btn btn-primary w-max mt-1'>Solicitud de contrato</Link>
            )}

            <h2 className='mt-2'>Datos del arrendatario</h2>
            <table>
                <tbody>
                    <tr>
                        <th>Nombre del arrendatario</th>
                        <td>{project.brand.client.business_name}</td>
                        <th>Giro comercial</th>
                        <td></td>
                    </tr>
                    <tr>
                        <th>Fraccionamiento / Proyecto</th>
                        <td>{project?.lands[0]?.land.residential_development_id}</td>
                        <th>Fecha de solicitud</th>
                        <td>{dateFormat(project.created_at)}</td>
                    </tr>
                </tbody>
            </table>

            <h2 className='mt-2'>Datos del inmueble objeto de arrendamiento</h2>
            <table>
                <thead>
                    <tr>
                        <th>Expediente Catastral</th>
                        <th>Área</th>
                        <th>Precio por Área</th>
                        <th>Renta Mensual</th>
                    </tr>
                </thead>

                <tbody>
                    {project.lands.map(land => (
                        <tr key={land.id}>
                            <td>{land.land.cadastral_file}</td>
                            <td>{land.area}</td>
                            <td>{currencyFormat(land.land.price_per_area)}</td>
                            <td>{currencyFormat(land.area * land.land.price_per_area)}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
