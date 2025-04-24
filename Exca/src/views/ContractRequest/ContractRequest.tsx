import { ChangeEvent, useCallback, useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { getConditions } from '../../api/ConditionApi'
import { getProjectLandTypes, updateProject } from '../../api/ProjectApi'
import { registerRequest, updateRequest } from '../../api/LeaseRequestApi'
import { useAppContext } from '../../hooks/AppContext'
import { isNullOrEmpty } from '../../utils'
import { 
  Condition, 
  LeaseRequestConditionCreate, 
  LeaseRequestCreate, 
  LeaseRequestResponse, 
  ProjectCreate, 
  ProjectLandType, 
  ProjectView 
} from '../../types'
import SaveIcon from '../../components/shared/Icons/SaveIcon'
import SendIcon from '../../components/shared/Icons/SendIcon'
import { toast } from 'react-toastify'

export default function ContractRequest() {
    const { projectId } = useParams()
    const { state, dispatch } = useAppContext()
  
    const [requestConditions, setRequestConditions] = useState<LeaseRequestConditionCreate[]>([])
    const [conditions, setConditions] = useState<Condition[]>([])
    const [types, setTypes] = useState<ProjectLandType[]>([])
    const [project, setProject] = useState<ProjectView | null>(null)
    const [request, setRequest] = useState<LeaseRequestResponse | null>(null)
    const [existsRequest, setExistsRequest] = useState(false)
  
    const handleConditionChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value } = e.target
        const isInput = e.target instanceof HTMLInputElement
        const condition = conditions.find(c => c.name === name)
        if (!condition) return
    
        setRequestConditions(prev => {
            const existing = prev.find(c => c.id === condition.id)
            if (isNullOrEmpty(value)) {
                return prev.filter(c => c.id !== condition.id)
            }
            const updated = {
            id: condition.id,
            condition_id: condition.id,
            value,
            is_active: isInput && e.target instanceof HTMLInputElement ? e.target.checked : false
            }
            return existing 
            ? prev.map(c => c.id === condition.id ? updated : c)
            : [...prev, updated]
        })
    
        if (request) {
            setRequest(prev => prev && {
            ...prev,
            conditions: prev.conditions.map(c => 
                c.condition_id === condition.id 
                ? { ...c, value, is_active: isInput && e.target instanceof HTMLInputElement ? e.target.checked : false }
                : c
            )
            })
        }
    }
  
    const handleProjectChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { name, value } = e.target
        if (!project) return
    
        const position = parseInt(name.split('[')[1])
        const attribute = name.split('.')[1]
        const parsedValue = ['area', 'type_id'].includes(attribute) ? +value : value
    
        setProject(prev => prev && {
            ...prev,
            lands: prev.lands.map((land, idx) => 
            idx === position ? { ...land, [attribute]: parsedValue } : land
            )
        })
    }
  
    const getConditionsToSend = useCallback((): LeaseRequestConditionCreate[] => {
        return conditions.map(c => {
            const existingRC = requestConditions.find(rc => rc.condition_id === c.id)
            const existingReq = request?.conditions.find(rc => rc.condition_id === c.id)
            if (existingRC) return existingRC
            if (existingReq) {
                return {
                    id: existingReq.condition_id,
                    condition_id: existingReq.condition_id,
                    value: existingReq.value,
                    is_active: existingReq.is_active
                }
            }
            return null
        }).filter(Boolean) as LeaseRequestConditionCreate[]
    }, [conditions, requestConditions, request])
  
    const handleSubmit = async () => {
        if (!project) return
    
        try {
            const lands = project.lands.map(({ land_id, area, type_id }) => ({ land_id, area, type_id }))
            const updatedProject: ProjectCreate = {
                name: project.name,
                client: project.brand.client.business_name,
                brand: project.brand.name,
                lands
            }
    
            const savedProject = await updateProject(project.id, updatedProject)
    
            dispatch({ 
                type: 'set-projects', 
                paypload: { 
                    projects: state.projects.map(p => p.id === savedProject.id ? savedProject : p) 
                }
            })
    
            const newRequest: LeaseRequestCreate = {
            project_id: project.id,
            conditions: getConditionsToSend()
            }
    
            if (existsRequest && request) {
                const updatedRequest = await updateRequest(request.id, newRequest)
                dispatch({ 
                    type: 'set-lease-request', 
                    paypload: { 
                    requests: state.requests.map(r => r.id === updatedRequest.id ? updatedRequest : r) 
                    }
                })
            } else {
                const createdRequest = await registerRequest(newRequest)
                dispatch({ 
                    type: 'set-lease-request', 
                    paypload: { 
                    requests: state.requests.map(r => r.id === createdRequest.id ? createdRequest : r) 
                    }
                })
            }

            toast.success("Cambios Guardados Correctamente")
        } catch (error) {
            console.error(error)
        }
    }
  
    const getValue = (id: number) => request?.conditions.find(c => c.condition_id === id)?.value
    const getChecked = (id: number) => request?.conditions.find(c => c.condition_id === id)?.is_active

    const getArray = (options: string) : string[] => {
        return JSON.parse(options);
    }
  
    useEffect(() => {
        const fetchData = async () => {
            const [conditionsData, typesData] = await Promise.all([
                getConditions(),
                getProjectLandTypes()
            ])
            if (conditionsData) setConditions(conditionsData)
            if (typesData) setTypes(typesData)
        }
        fetchData()
    }, [])
  
    useEffect(() => {
        if (!projectId) return
        const currentProject = state.projects.find(p => p.id === +projectId)
        if (!currentProject) return
    
        setProject(currentProject)
    
        const foundRequest = state.requests.find(r => r.project_id === +projectId)
        if (foundRequest) {
            setExistsRequest(true)
            setRequest(foundRequest)
        }
    }, [projectId, state.projects, state.requests])
  
    if (!project) return <div>Cargando...</div>

    return (
        <div>
            <h1>Solicitud de contrato</h1>
            <div className='w-full flex g-1'>
                <button onClick={handleSubmit} className='btn btn-primary w-max'>
                    <SaveIcon />
                    Save Changes
                </button>

                <button className='btn btn-success w-max'>
                    <SendIcon />
                    Enviar a firmas
                </button>
            </div>

            <h2 className='mt-1'>Datos del arrendador</h2>
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
            {project.lands.map((land, index) => (
                <>
                    <div className={`${index !== 0 && 'pt-3'} grid grid-cols-2`} key={land.id}>
                        <div className='condition-container'>
                            <label htmlFor="landType">Inmueble a arrendar</label>
                            <select value={land.type_id} onChange={handleProjectChange} name={`land[${index}].type_id`} id="landType">
                                <option value="">Seleccione una opción</option>
                                {types.map(type => (
                                    <option value={type.id} key={type.id}>{type.name}</option>
                                ))}
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
                            <input type="text" id='cadastralFile' disabled readOnly value={land.land.cadastral_file} placeholder='Expediente Catastral' />
                        </div>
                        <div className='condition-container'>
                            <label htmlFor="residentialDevelopment">Domicilio inmueble</label>
                            <input type="text" id='residentialDevelopment' disabled readOnly value={land.land.address} placeholder='Domicilio inmueble' />
                        </div>
                        <div className='condition-container'>
                            <label htmlFor="totalArea">Superficie total</label>
                            <input type="number" disabled readOnly value={land.land.area} id='totalArea' placeholder='Superficie total' />
                        </div>
                        <div className='condition-container'>
                            <label htmlFor="areaForLease">Superficie en arrendamiento</label>
                            <input type="number" onChange={handleProjectChange} name={`land[${index}].area`} value={land.area} id='areaForLease' placeholder='Superficie en arrendamiento' />
                        </div>
                    </div>
                </>
            ))}

            <h2 className='mt-2'>Condiciones Comerciales Autorizadas</h2>
            <div className='conditions-list'>
                {conditions.map(condition => (
                    <div className='condition-container' key={condition.id}>
                        <label htmlFor={condition.id.toString()}>{condition.name}</label>

                        {condition.type_id === 1 && (
                            <input value={getValue(condition.id)} onChange={handleConditionChange} type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                        )}
                        {condition.type_id === 2 && (
                            <input value={getValue(condition.id)} onChange={handleConditionChange} type='number' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                        )}
                        {condition.type_id === 3 && (
                            <input value={getValue(condition.id)} onChange={handleConditionChange} type='date' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                        )}
                        {condition.type_id === 4 && (
                            <div className='checkbox'>
                                <input checked={getChecked(condition.id)} onChange={handleConditionChange} type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                            </div>
                        )}
                        {condition.type_id === 5 && (
                            <select value={getValue(condition.id)} onChange={handleConditionChange} name={condition.name} id={condition.id.toString()}>
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
