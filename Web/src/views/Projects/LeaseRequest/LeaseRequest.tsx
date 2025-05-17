import { useLocation, useNavigate, useParams, useSearchParams } from "react-router-dom"
import { useAppContext } from "../../../hooks/AppContext"
import { ChangeEvent, useEffect, useMemo, useState } from "react"
import InputGroup, { Option } from "../../../components/forms/InputGroup"
import { CaseConditionCreate, Individual, LeaseRequestCreate, Project, ProjectLandType } from "../../../types"
import { getProjectLandTypes } from "../../../api/ProjectApi"
import { getOnwers } from "../../../api/OwnerApi"
import { getGuaranteeTypes } from "../../../api/IndividualApi"
import Loader from "../../../components/shared/Loader/Loader"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import SaveIcon from "../../../components/shared/Icons/SaveIcon"
import SendIcon from "../../../components/shared/Icons/SendIcon"
import SelectGroup from "../../../components/forms/SelectGroup"
import ConditionsContainer from "../../../components/ConditionsContainer/ConditionsContainer"
import ComboBox, { OptionCB } from "../../../components/forms/ComboBox"
import { formatDateToInput, handleError } from "../../../utils"
import { createRequest, sendToApprovalRequest, updateRequest } from "../../../api/LeaseRequestApi"
import { toast } from "react-toastify"

export default function LeaseRequest() {
    const { projectId, leaseRequestId } = useParams()
    const { pathname } = useLocation()
    const [searchParams] = useSearchParams();
    const { state, isLoading, dispatch } = useAppContext()
    const [guaranteeTypes, setGuaranteeTypes] = useState<Option[]>([])
    const [owners, setOwners] = useState<Option[]>([])
    const [isLocalLoading, setIsLocalLoading] = useState(false)
    const [types, setTypes] = useState<ProjectLandType[]>([])
    const [project, setProject] = useState<Project | null>(null)
    const [individual, setIndividual] = useState<Individual | null>(null)
    const [newConditions, setNewConditions] = useState<CaseConditionCreate[]>([])
    const [individualsOptions, setIndividualsOptions] = useState<OptionCB[]>([])
    const [newRequest, setNewRequest] = useState<LeaseRequestCreate>({
        project_id: 0, 
        guarantee_id: 0,
        guarantee_type_id: 0, 
        owner_id: 0, 
        commission_agreement: false, 
        assignment_income: false, 
        property_file: '',
        conditions: []
    })
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Solicitud de contrato",url:`/contract-request/${projectId}`},
    ]
    const navigate = useNavigate()

    const isDisable = useMemo(() => 
        newRequest.guarantee_type_id === 0 || 
        newRequest.owner_id === 0, [newRequest]) || 
        newConditions.length === 0 ||
        newRequest.guarantee_id === 0

    const handleChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { value, name } = e.target as HTMLInputElement | HTMLSelectElement;
        const checked = (e.target as HTMLInputElement).checked;

        const isChecked = ['commission_agreement', 'assignment_income'].includes(name)

        setNewRequest({
            ...newRequest, 
            [name]: isChecked ? checked : value
        })
    }

    const handleSelect = (id: string | number, name: string) => {
        switch (name) {
            case 'guarantee':
                setNewRequest({
                    ...newRequest, 
                    guarantee_id: +id
                })
        }
    };
    
    const handleCreate = async(newLabel: string, name: string) => {
        switch(name) {
            case 'guarantee':
                localStorage.setItem('leaseRequestLocal', JSON.stringify(newRequest))

                navigate(`/clients/individual/create?full_name=${newLabel}&return_url=${pathname}&client_id=${project?.brand?.client_id}`)
                break;
        }
    };

    const handleSubmit = async() => {
        try {
            let response;
            if(leaseRequestId) {
                response = await updateRequest(+leaseRequestId, {...newRequest, project_id: +projectId!})
            } else {
                response = await createRequest({...newRequest, project_id: +projectId!})
            }
            dispatch({ type: 'set-projects', paypload: { projects: state.projects.map(p => p.id !== response?.project_id ? p : { ...p, lease_request: response }) } })
            toast.success("Cambios Guardados Correctamente")
            navigate(`/projects/${response?.project_id}`)
        } catch (error) {
            handleError(error);
        }
    }

    const handleSend = async() => {
        try {
            await sendToApprovalRequest(+leaseRequestId!)
            toast.success("Cambios Guardados Correctamente")
            navigate(`/projects/${projectId}`)
        } catch (error) {
            handleError(error);
        }
    }

    const handleGetValue = (id: number) => {
        const conditionValue = project?.lease_request?.conditions?.find(c => c.condition_id === id)
        
        switch(conditionValue?.condition?.type_id) {
            case 1:
                return conditionValue.text_value
            case 2:
                return conditionValue.number_value
            case 3:
                return formatDateToInput(conditionValue.date_value!)
            case 4:
                return conditionValue.boolean_value
            case 5:
                return conditionValue.option_id
        }
    }
  
    useEffect(() => {
        const fetchData = async () => {
            setIsLocalLoading(true)
            try {
                const [typesData, ownersData, guaranteeData] = await Promise.all([
                    getProjectLandTypes(),
                    getOnwers(),
                    getGuaranteeTypes(),
                ])

                if (typesData) setTypes(typesData)
                if (ownersData) {
                    const ownerOptions = ownersData.map(o => { return { value: o.id, label: o.name } })
                    setOwners(ownerOptions)
                }
                if(guaranteeData) {
                    const guaranteeOptions = guaranteeData.map(g => { return { value: g.id, label: g.name } })
                    setGuaranteeTypes(guaranteeOptions)
                }
            } catch (error) {
                console.log(error)
            } finally {
                setIsLocalLoading(false)
            }
        }
        const backCreate = searchParams.get('back_create')

        if(backCreate) {
            const itemSavedStr = localStorage.getItem('leaseRequestLocal')

            if(itemSavedStr) {
                setNewRequest(JSON.parse(itemSavedStr))

                const itemName = searchParams.get('item_name')
                const itemId = searchParams.get('item_id')

                if(itemName && itemId) {
                    switch(itemName) {
                        case 'guarantee':
                            setNewRequest({
                                ...newRequest, 
                                guarantee_id: +itemId
                            })
                            break;
                    }
                }
            }
        }

        fetchData()
    }, [])

    useEffect(() => {
        const individualSelected = state.individuals.find(i => i.id === newRequest.guarantee_id)
        if(individualSelected) setIndividual(individualSelected)
    }, [newRequest.guarantee_id])

    useEffect(() => {
        setNewRequest({
            ...newRequest,
            conditions: newConditions
        })
    }, [newConditions])

    useEffect(() => {
        setIndividualsOptions(state.individuals.map(i => {
            return {
                id: i.id, 
                label: i.full_name
            }
        }))
    }, [state.individuals])
  
    useEffect(() => {
        if (!projectId) return
        const currentProject = state.projects.find(p => p.id === +projectId)
        if (!currentProject) return
    
        setProject(currentProject)
    
        const foundRequest = state.requests.find(r => r.project_id === +projectId)
        if (foundRequest) {
            setNewRequest({
                project_id: currentProject.id, 
                guarantee_type_id: foundRequest.guarantee_type_id, 
                owner_id: foundRequest.owner_id, 
                guarantee_id: foundRequest.guarantee_id,
                commission_agreement: foundRequest.commission_agreement, 
                assignment_income: foundRequest.assignment_income, 
                property_file: foundRequest.property_file, 
                conditions: foundRequest.conditions ?? []
            })

            setNewConditions(foundRequest.conditions ?? [])
        }
    }, [projectId, state.projects, state.requests, state.individuals])
  
    if(isLoading || isLocalLoading || !project) return <Loader />

    return (
        <div>
            <Breadcrumb list={list} />
            <h1>Solicitud de contrato</h1>

            <div className='w-full flex g-1'>
                {(project.lease_request === null || project.lease_request?.status_id == 1) && (
                    <>
                        <button disabled={isDisable} onClick={handleSubmit} className='btn btn-primary w-max'>
                            <SaveIcon />
                            Guardar
                        </button>

                        <button disabled={isDisable} onClick={handleSend} className='btn btn-success w-max'>
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
                    <input type="text" value={project.brand?.client?.business_name} readOnly disabled />
                </div>
                <div className='condition-container'>
                    <label htmlFor="owner">Giro Comercial</label>
                    <input type="text" value={project.brand?.client?.type_id} readOnly disabled />
                </div>
                <div className='condition-container'>
                    <label htmlFor="owner">Fraccionamiento / Proyecto</label>
                    <input type="text" readOnly value={project.lands?.[0]?.land?.residential_development?.name ?? ''} disabled />
                </div>
                <div className='condition-container'>
                    <label htmlFor="owner">Fecha de solicitud</label>
                    <input type="date" readOnly disabled />
                </div>
            </div>

            <h3 className='mt-2'>Garantiza arrendamiento con:</h3>
            <div className='grid grid-cols-2'>
                <SelectGroup
                    isHorizontal
                    id='guarantee_type_id' 
                    name='guarantee_type_id' 
                    onChangeFnc={handleChange}
                    value={newRequest.guarantee_type_id}
                    placeholder='Seleccione un tipo'
                    label='Tipo de garantia'
                    options={guaranteeTypes}
                />
                <ComboBox 
                    name='guarantee'
                    value={newRequest?.guarantee_id ?? ''}
                    placeholder='Nombre del obligado solidario'
                    label='Nombre del obligado solidario'
                    onCreate={handleCreate}
                    onSelect={handleSelect}
                    options={individualsOptions}
                />
                <InputGroup 
                    disable
                    isHorizontal
                    name='guarantee_address'
                    value={individual?.address?.state ?? ''}
                    id='guarantee_address'
                    onChangeFnc={handleChange}
                    placeholder='Dirección del obligado solidario'
                    label='Dirección'
                />
                <InputGroup 
                    isHorizontal
                    name='property_file'
                    value={newRequest.property_file}
                    id='property_file'
                    onChangeFnc={handleChange}
                    placeholder='Escritura de la propiedad'
                    label='Escritura'
                />
            </div>

            <h2 className='mt-2'>II. Datos del arrendador</h2>
            <div className='grid grid-cols-2'>
                <SelectGroup  
                    isHorizontal
                    id='owner_id' 
                    name='owner_id' 
                    onChangeFnc={handleChange}
                    value={newRequest.owner_id} 
                    placeholder='Seleccione un arrendador' 
                    label='Propietario inmueble a arrendar'
                    options={owners}
                />
                <div></div>

                <div className='condition-container'>
                    <label htmlFor="commission_agreement">Pacto comisiorio</label>
                    <div className='checkbox'>
                        <input type='checkbox' onChange={handleChange} checked={newRequest.commission_agreement} name='commission_agreement' id='commission_agreement' />
                        <span className="checkmark"></span>
                    </div>
                </div>

                <div className='condition-container'>
                    <label htmlFor="assignment_income">Cesión de renta a FIMSA</label>
                    <div className='checkbox'>
                        <input type='checkbox' onChange={handleChange} checked={newRequest.assignment_income} name='assignment_income' id='assignment_income' />
                        <span className="checkmark"></span>
                    </div>
                </div>
            </div>

            <h2 className='mt-2'>III. Datos inmueble objeto de arrendamiento</h2>
            {project.lands?.map((land, index) => (
                <div key={land.id}>
                    <div className={`${index !== 0 && 'pt-3'} grid grid-cols-2`} key={land.id}>
                        <div className='condition-container'>
                            <label htmlFor="landType">Inmueble a arrendar</label>
                            <select onChange={handleChange} value={land.type_id} name={`land[${index}].type_id`} id="landType">
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
                            <input type="text" id='cadastralFile' disabled readOnly value={land.land?.cadastral_file} placeholder='Expediente Catastral' />
                        </div>
                        <div className='condition-container'>
                            <label htmlFor="residentialDevelopment">Domicilio inmueble</label>
                            <input type="text" id='residentialDevelopment' disabled readOnly value={land.land?.address} placeholder='Domicilio inmueble' />
                        </div>
                        <div className='condition-container'>
                            <label htmlFor="totalArea">Superficie total</label>
                            <input type="number" disabled readOnly value={land.land?.area} id='totalArea' placeholder='Superficie total' />
                        </div>
                        <div className='condition-container'>
                            <label htmlFor="areaForLease">Superficie en arrendamiento</label>
                            <input onChange={handleChange} type="number" name={`land[${index}].area`} value={land.area} id='areaForLease' placeholder='Superficie en arrendamiento' />
                        </div>
                    </div>
                </div>
            ))}

            <h2 className='mt-2'>IV. Condiciones Comerciales Autorizadas</h2>
            <ConditionsContainer
                newConditions={newConditions}
                setNewConditions={setNewConditions} 
                handleGetValue={handleGetValue}
                conditionsList={state.conditions.filter(c => c.category_id === 1)} 
                project={project!} />
        </div>
    )
}
