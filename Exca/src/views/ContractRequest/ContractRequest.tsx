import { useEffect, useState } from 'react'
import { getConditions } from '../../api/ConditionApi'
import { Condition, ProjectView } from '../../types'
import { useAppContext } from '../../hooks/AppContext'
import { useParams } from 'react-router-dom'

const initialState = {
    client_id: 0, 
    project_id: 0
}

export default function ContractRequest() {
    const [conditions, setConditions] = useState<Condition[]>([])
    const [project, setProject] = useState<ProjectView | null>(null)
    const { state } = useAppContext()

    const { projectId } = useParams()

    useEffect(() => {
        const getInfo = async() => {
            const data = await getConditions()
            if (data) setConditions(data)
        }

        getInfo()
    }, [])

    const getArray = (options: string) : string[] => {
        return JSON.parse(options);
    }

    useEffect(() => {
        if(projectId && state.projects.length > 0) {
            const currentProject = state.projects.filter(p => p.id === +projectId)[0]

            if(!currentProject) return

            setProject(currentProject)
        }
            
    }, [projectId, state.projects])

    if (project === null) return <div>Cargando...</div>

    return (
        <div>
            <h2>Datos del arrendador</h2>
            <div className='grid grid-cols-2'>
                <div>
                    <div className='condition-container'>
                        <label htmlFor="owner">Propietario inmueble a arrendar</label>
                        <select name="owner" id="owner">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                </div>
            </div>

            <h2 className='mt-2'>Datos inmueble objeto de arrendamiento</h2>
            <div className='grid grid-cols-2'>
                <div className='condition-container'>
                    <label htmlFor="landType">Inmueble a arrendar</label>
                    <select name="landType" id="landType">
                        <option value="">Seleccione una opción</option>
                    </select>
                </div>
                <div className='condition-container'>
                    <label htmlFor="type">Escritura en compraventa</label>
                    <div className='checkbox'>
                        <input type='checkbox' name='' id='' />
                    </div>
                </div>
                <div className='condition-container'>
                    <label htmlFor="cadastralFile">Expediente Catastral</label>
                    <input type="text" id='cadastralFile' placeholder='Expediente Catastral' />
                </div>
                <div className='condition-container'>
                    <label htmlFor="residentialDevelopment">Domicilio inmueble</label>
                    <input type="text" id='residentialDevelopment' placeholder='Domicilio inmueble' />
                </div>
                <div className='condition-container'>
                    <label htmlFor="totalArea">Superficie total</label>
                    <input type="number" disabled value={project.lands[0].land.area} id='totalArea' placeholder='Superficie total' />
                </div>
                <div className='condition-container'>
                    <label htmlFor="areaForLease">Superficie en arrendamiento</label>
                    <input type="number" value={project.lands[0].area} id='areaForLease' placeholder='Superficie en arrendamiento' />
                </div>
            </div>

            <h2 className='mt-2'>Condiciones Comerciales Autorizadas</h2>
            <div className='conditions-list'>
                {conditions.map(condition => (
                    <div className='condition-container'>
                        <label htmlFor={condition.id.toString()}>{condition.name}</label>

                        {condition.type_id === 1 && (
                            <input type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                        )}
                        {condition.type_id === 2 && (
                            <input type='number' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                        )}
                        {condition.type_id === 3 && (
                            <input type='date' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                        )}
                        {condition.type_id === 4 && (
                            <div className='checkbox'>
                                <input type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                            </div>
                        )}
                        {condition.type_id === 5 && (
                            <select name={condition.name} id={condition.id.toString()}>
                                <option value="">Selecciona una opción</option>
                                {getArray(condition.options).map(option => (
                                    <option value={option} key={option}>{option}</option>
                                ))}
                            </select>
                        )}
                    </div>
                ))}
            </div>
        </div>
    )
}
