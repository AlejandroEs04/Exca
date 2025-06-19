import { useEffect, useState } from "react"
import Loader from "../../../components/shared/Loader/Loader"
import { sendTechnicalCase } from "../../../api/TechnicalCaseApi"
import { useAppContext } from "../../../hooks/AppContext"
import { useNavigate, useParams } from "react-router-dom"
import { Project, CaseCreate, CaseConditionCreate } from "../../../types"
import { toast } from "react-toastify"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import SaveIcon from "../../../components/shared/Icons/SaveIcon"
import SendIcon from "../../../components/shared/Icons/SendIcon"
import InputGroup from "../../../components/forms/InputGroup"
import ConditionsContainer from "../../../components/ConditionsContainer/ConditionsContainer"
import { formatDateToInput } from "../../../utils"
import { createCase, updateCase } from "../../../api/CaseApi"

export default function TechnicalCase() {
    const { projectId, caseId } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Carátula técnica",url:`/technical-case/${projectId}`},
    ]

    const { state, isLoading, setError, dispatch } = useAppContext()
    const navigate = useNavigate()
    const [project, setProject] = useState<Project | null>(null)
    const [newConditions, setNewConditions] = useState<CaseConditionCreate[]>([])

    const handleSubmit = async() => {
        try {
            const newTechnicalCase : CaseCreate = {
                project_id: +projectId!, 
                case_type_id: 1, 
                title: 'Cáratula Técnica',
                description: '', 
                conditions: newConditions
            }
            
            let response;

            if(caseId) {
                response = await updateCase(+caseId!, newTechnicalCase)
            } else {
                response = await createCase(newTechnicalCase)
            }
            toast.success("Guardado correctamente")
        } catch (error) {
            setError(error)
        }
    }

    const handleSend = async() => {
        try {
            await handleSubmit()
            const response = await sendTechnicalCase(+projectId!)
            dispatch({ 
                type: 'set-projects', 
                payload: { projects: state.projects.map(project => project.id !== +projectId! ? project : { ...project, technical_case: response! }) } 
            })
            toast.success("Enviado correctamente")
        } catch (error) {
            setError(error)
        }
    }

    const handleGetValue = (id: number) => {
        const conditionValue = project?.cases?.find(c => c.case_type_id === 1)?.conditions?.find(c => c.condition_id === id)
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
        if(state.projects.length) {
            const currentProject = state.projects.find(p => p.id === +projectId!) ?? null
            if(!currentProject) navigate("/projects")
            setProject(currentProject)
            setNewConditions(currentProject?.cases?.find(c => c.case_type_id === 1)?.conditions ?? [])
        }
    }, [state.projects, projectId])

    if(isLoading) return <Loader />
    
    return (
        <>
            <Breadcrumb list={list} />   
            <h1>Carátula Técnica</h1>

            {!project?.cases?.find(c => c.case_type_id === 1)?.sended_at && (
                <div className="flex g-1">
                    <button className="btn btn-primary" onClick={handleSubmit}>
                        <SaveIcon />
                        Guardar
                    </button>
                    
                    <button className="btn btn-success" onClick={handleSend}>
                        <SendIcon />
                        Enviar
                    </button>
                </div>
            )}

            <div className="mt-1">
                <InputGroup disable value={project?.brand?.client?.business_name!} label="Arrendamiento" name="business_name" placeholder="Nombre de la empresa" />

                <div className="mt-1 grid grid-cols-2 g-1">
                    <InputGroup disable value={project?.lands?.[0]?.land?.cadastral_file ?? ''} placeholder="Experiente Catastral" name="cadastral_file" label="Expediente Catastral" />
                    <InputGroup disable value={project?.lands?.[0]?.type?.name ?? ''} placeholder="Tipo de arrendamiento" name="type" label="Tipo de Arrendamiento" />
                </div>

                <form className="mt-4">

                    <div className="grid grid-cols-2 g-2">
                        <div>
                            <h2>Aspectos Técnicos de Arrendamiento</h2>
                            <ConditionsContainer
                                isNotGrid
                                handleGetValue={handleGetValue}
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={state.conditions.filter(c => c.category_id === 10)} 
                                project={project!} />
                        </div>
                        
                        <div>
                            <h2>Servicios de Electricidad</h2>
                            <ConditionsContainer
                                isNotGrid
                                handleGetValue={handleGetValue}
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={state.conditions.filter(c => c.category_id === 7)} 
                                project={project!} />
                        </div>
                        
                        <div>
                            <h2>Servicios de Agua y Drenaje</h2>
                            <ConditionsContainer
                                isNotGrid
                                handleGetValue={handleGetValue}
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={state.conditions.filter(c => c.category_id === 8)} 
                                project={project!} />
                        </div>
                        
                        <div>
                            <h2>Gestiones requeridas</h2>
                            <ConditionsContainer
                                isNotGrid
                                isChecked
                                handleGetValue={handleGetValue}
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={state.conditions.filter(c => c.category_id === 9)} 
                                project={project!} />
                        </div>
                    </div>
                </form>
            </div>
        </>
    )
}
