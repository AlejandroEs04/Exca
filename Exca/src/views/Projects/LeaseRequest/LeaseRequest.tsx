import { Link, useParams } from "react-router-dom"
import { useAppContext } from "../../../hooks/AppContext"
import { ChangeEvent, useCallback, useEffect, useMemo, useState } from "react"
import InputGroup, { Option, PushEvent } from "../../../components/forms/InputGroup"
import { Condition, LeaseRequestConditionCreate, LeaseRequestCreate, ProjectCreate, ProjectLandType, ProjectView } from "../../../types"
import { isNullOrEmpty } from "../../../utils"
import { getProjectLandTypes, updateProject } from "../../../api/ProjectApi"
import { registerRequest, sendToApprovalRequest } from "../../../api/LeaseRequestApi"
import { getConditionRules } from "../../../utils/conditionsRules"
import { toast } from "react-toastify"
import { getConditions } from "../../../api/ConditionApi"
import { getOnwers } from "../../../api/OwnerApi"
import { getGuaranteeTypes, getIndividuals } from "../../../api/IndividualApi"
import Loader from "../../../components/shared/Loader/Loader"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import SaveIcon from "../../../components/shared/Icons/SaveIcon"
import SendIcon from "../../../components/shared/Icons/SendIcon"
import SelectGroup from "../../../components/forms/SelectGroup"

export default function LeaseRequest() {
    const { projectId } = useParams()
    const { state, dispatch, isLoading, setError } = useAppContext()
    const [guaranteeTypes, setGuaranteeTypes] = useState<Option[]>([])
    const [individuals, setIndividuals] = useState<Option[]>([])
    const [owners, setOwners] = useState<Option[]>([])
    const [isLocalLoading, setIsLocalLoading] = useState(false)
    const [requestConditions, setRequestConditions] = useState<LeaseRequestConditionCreate[]>([])
    const [conditions, setConditions] = useState<Condition[]>([])
    const [types, setTypes] = useState<ProjectLandType[]>([])
    const [project, setProject] = useState<ProjectView | null>(null)
    const [newRequest, setNewRequest] = useState<LeaseRequestCreate>({
        project_id: 0, 
        guarantee: '', 
        guarantee_type_id: 0, 
        owner_id: 0, 
        commission_agreement: false, 
        assignment_income: false, 
        property_file: false, 
        conditions: [],
        guarantee_address: '',
        guarantee_property_file: ''
    })
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Solicitud de contrato",url:`/contract-request/${projectId}`},
    ]
  
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
    
        if (project?.lease_request) {
            setProject(prev => prev && {
                ...prev,
                lease_request: {
                    ...prev.lease_request,
                    conditions: prev.lease_request.conditions.map(c => 
                        c.condition_id === condition.id 
                        ? { ...c, value, is_active: isInput && e.target instanceof HTMLInputElement ? e.target.checked : false }
                        : c
                    )
                }
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
            const existingReq = project?.lease_request?.conditions.find(rc => rc.condition_id === c.id)
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
    }, [conditions, requestConditions, project])

    const handleChange = (e: ChangeEvent<HTMLSelectElement | HTMLInputElement> | PushEvent) => {
        const { name, value } = e.target as HTMLInputElement | HTMLSelectElement
        const checked = e.target instanceof HTMLInputElement ? e.target.checked : undefined
        const isNumber = ['owner_id'].includes(name)
        const isCheckbox = ['commission_agreement', 'assignment_income'].includes(name)

        setNewRequest({
            ...newRequest, 
            [name] : isCheckbox ? checked : isNumber ? +value : value
        })
    }
  
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

            newRequest.conditions = getConditionsToSend()
            newRequest.project_id = +projectId!

            const requestUpdated = await registerRequest(newRequest)
            
            if (savedProject) {
                savedProject.lease_request = requestUpdated!;
            }

            dispatch({ 
                type: 'set-projects', 
                paypload: { 
                    projects: state.projects.map(p => p.id === savedProject!.id ? savedProject : p).filter((p): p is ProjectView => p !== undefined)
                }
            })

            toast.success("Cambios Guardados Correctamente")
        } catch (error) {
            setError(error)
        }
    }

    const handleSendToApproval = async() => {
        try {
            await sendToApprovalRequest(project?.id!)
            toast.success("Se envio a firmas correctamente")
        } catch (error) {
            setError(error)
        }
    }
  
    const getValue = (id: number) => {
        const value = getConditionRules(id, conditions, project!).value;
        return typeof value === 'boolean' ? value.toString() : value;
    }
    const getChecked = (id: number) => project?.lease_request?.conditions.find(c => c.condition_id === id)?.is_active

    const isDisable = useMemo(() => 
        newRequest.guarantee === '' || 
        newRequest.guarantee_type_id === 0 || 
        newRequest.guarantee_address === '' || 
        newRequest.owner_id === 0, [newRequest])

    const getArray = (options: string) : string[] => {
        return JSON.parse(options);
    }
  
    useEffect(() => {
        const fetchData = async () => {
            setIsLocalLoading(true)
            try {
                const [conditionsData, typesData, ownersData, guaranteeData, individualsData] = await Promise.all([
                    getConditions(),
                    getProjectLandTypes(),
                    getOnwers(),
                    getGuaranteeTypes(),
                    getIndividuals()
                ])

                if (conditionsData) setConditions(conditionsData.filter(c => c.category_id === 1))
                if (typesData) setTypes(typesData)
                if (ownersData) {
                    const ownerOptions = ownersData.map(o => { return { value: o.id, label: o.name } })
                    setOwners(ownerOptions)
                }
                if(guaranteeData) {
                    const guaranteeOptions = guaranteeData.map(g => { return { value: g.id, label: g.name } })
                    setGuaranteeTypes(guaranteeOptions)
                }
                if(individualsData) {
                    const individualOptions = individualsData.map(i => { return { value: i.id, label: i.full_name } })
                    setIndividuals(individualOptions)
                }
            } catch (error) {
                console.log(error)
            } finally {
                setIsLocalLoading(false)
            }
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
            setNewRequest({
                project_id: foundRequest.id, 
                guarantee: foundRequest.guarantee.full_name, 
                guarantee_type_id: foundRequest.guarantee_type_id, 
                owner_id: foundRequest.owner_id, 
                commission_agreement: foundRequest.commission_agreement, 
                assignment_income: foundRequest.assignment_income, 
                property_file: foundRequest.property_file, 
                conditions: foundRequest.conditions,
                guarantee_address: foundRequest.guarantee.address,
                guarantee_property_file: ''
            })
        }
    }, [projectId, state.projects, state.requests, individuals])
  
    if(isLoading || isLocalLoading || !project) return <Loader />

    return (
        <div>
            <Breadcrumb list={list} />
            <h1>Solicitud de contrato</h1>

            <div className='w-full flex g-1'>
                {(project.lease_request === null || project.lease_request.status_id == 1) && (
                    <>
                        <button disabled={isDisable} onClick={handleSubmit} className='btn btn-primary w-max'>
                            <SaveIcon />
                            Save Changes
                        </button>

                        <button disabled={isDisable} onClick={handleSendToApproval} className='btn btn-success w-max'>
                            <SendIcon />
                            Enviar a firmas
                        </button>
                    </>
                )}
            </div>

            <h2 className='mt-2'>I. Datos del arrendatario</h2>
            <div className='grid grid-cols-2'>
                <div className='condition-container'>
                    <label htmlFor="owner">Nombre del arrendatario</label>
                    <input type="text" value={project.brand.client.business_name} disabled />
                </div>
                <div className='condition-container'>
                    <label htmlFor="owner">Giro Comercial</label>
                    <input type="text" value={project.brand.client.type_id} disabled />
                </div>
                <div className='condition-container'>
                    <label htmlFor="owner">Fraccionamiento / Proyecto</label>
                    <input type="text" value={project?.lands[0]?.land.residential_development.name} disabled />
                </div>
                <div className='condition-container'>
                    <label htmlFor="owner">Fecha de solicitud</label>
                    <input type="date"  disabled />
                </div>
            </div>

            <Link className='btn btn-success w-max btn-sm mt-1' to={`/clients/${project.brand.client.id}`}>Ver cliente</Link>

            <h3 className='mt-2'>Garantiza arrendamiento con:</h3>
            <div className='grid grid-cols-2'>
                <SelectGroup  
                    isHorizontal
                    id='guarantee_type_id' 
                    name='guarantee_type_id' 
                    value={newRequest.guarantee_type_id} 
                    onChangeFnc={handleChange} 
                    placeholder='Seleccione un tipo' 
                    label='Tipo de garantia'
                    options={guaranteeTypes}
                />
                <InputGroup 
                    name='guarantee'
                    value={newRequest.guarantee}
                    id='guarantee'
                    onChangeFnc={handleChange}
                    placeholder='Nombre del obligado solidario'
                    label='Nombre del obligado solidario'
                    isHorizontal
                    options={individuals}
                />
                <InputGroup 
                    name='guarantee_address'
                    value={newRequest.guarantee_address}
                    id='guarantee_address'
                    onChangeFnc={handleChange}
                    placeholder='Dirección del obligado solidario'
                    label='Dirección'
                    isHorizontal
                />
                <InputGroup 
                    name='guarantee_property_file'
                    value={newRequest.guarantee_property_file}
                    id='guarantee_property_file'
                    onChangeFnc={handleChange}
                    placeholder='Escritura de la propiedad'
                    label='Escritura'
                    isHorizontal
                />
            </div>

            <Link className='btn btn-success w-max btn-sm mt-1' to={`/clients/${project.brand.client.id}`}>Ver obligado solidario</Link>

            <h2 className='mt-2'>II. Datos del arrendador</h2>
            <div className='grid grid-cols-2'>
                <SelectGroup  
                    isHorizontal
                    id='owner_id' 
                    name='owner_id' 
                    value={newRequest.owner_id} 
                    onChangeFnc={handleChange} 
                    placeholder='Seleccione un arrendador' 
                    label='Propietario inmueble a arrendar'
                    options={owners}
                />
                <div></div>

                <div className='condition-container'>
                    <label htmlFor="commission_agreement">Pacto comisiorio</label>
                    <div className='checkbox'>
                        <input type='checkbox' checked={newRequest.commission_agreement} onChange={handleChange} name='commission_agreement' id='commission_agreement' />
                        <span className="checkmark"></span>
                    </div>
                </div>

                <div className='condition-container'>
                    <label htmlFor="assignment_income">Cesión de renta a FIMSA</label>
                    <div className='checkbox'>
                        <input type='checkbox' checked={newRequest.assignment_income} onChange={handleChange} name='assignment_income' id='assignment_income' />
                        <span className="checkmark"></span>
                    </div>
                </div>
            </div>

            <h2 className='mt-2'>III. Datos inmueble objeto de arrendamiento</h2>
            {project.lands.map((land, index) => (
                <div key={land.id}>
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
                                <span className="checkmark"></span>
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
                </div>
            ))}

            <h2 className='mt-2'>IV. Condiciones Comerciales Autorizadas</h2>
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
                                <span className="checkmark"></span>
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
