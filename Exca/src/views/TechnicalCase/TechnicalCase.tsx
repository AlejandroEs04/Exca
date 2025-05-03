import { useNavigate, useParams } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { useAppContext } from "../../hooks/AppContext"
import { useEffect, useState } from "react"
import { Condition, ConditionCreate, ProjectView, TechnicalCaseCreate } from "../../types"
import Loader from "../../components/shared/Loader/Loader"
import InputGroup from "../../components/forms/InputGroup"
import { getConditions } from "../../api/ConditionApi"
import ConditionsContainer from "../../components/ConditionsContainer/ConditionsContainer"
import { createTechnicalCase, sendTechnicalCase } from "../../api/TechnicalCaseApi"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import SendIcon from "../../components/shared/Icons/SendIcon"
import { toast } from "react-toastify"

export default function TechnicalCase() {
    const { projectId } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Carátula técnica",url:`/technical-case/${projectId}`},
    ]

    const { state, isLoading, setError, dispatch } = useAppContext()
    const navigate = useNavigate()
    const [project, setProject] = useState<ProjectView | null>(null)
    const [conditions, setConditions] = useState<Condition[]>([])
    const [newConditions, setNewConditions] = useState<ConditionCreate[]>([])
    const [isLocalLoading, setIsLocalLoading] = useState(false)

    const handleSubmit = async() => {
        try {
            const newTechnicalCase : TechnicalCaseCreate = {
                project_id: +projectId!, 
                conditions: newConditions
            }
            await createTechnicalCase(newTechnicalCase)
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
                paypload: { projects: state.projects.map(project => project.id !== +projectId! ? project : { ...project, technical_case: response! }) } 
            })
            toast.success("Enviado correctamente")
        } catch (error) {
            setError(error)
        }
    }

    useEffect(() => {
        if(state.projects.length) {
            const currentProject = state.projects.find(p => p.id === +projectId!) ?? null
            if(!currentProject) navigate("/projects")
            setProject(currentProject)
        }
    }, [state.projects, projectId])

    useEffect(() => {
        if(conditions.length) {
            const newConditionsArray = conditions.map(c => {
                if(project?.technical_case) {
                    const technicalCondition = project.technical_case.conditions.find(tc => tc.condition_id === c.id)

                    if(technicalCondition) {
                        return {
                            condition_id: technicalCondition.condition_id,
                            is_active: technicalCondition.is_active,
                            value: technicalCondition.value   
                        }
                    }
                }

                return {
                    condition_id: c.id,
                    is_active: false,
                    value: ''
                }
            })
            setNewConditions(newConditionsArray)
        }
    }, [conditions, project])

    useEffect(() => {
        const fetchData = async () => {
            setIsLocalLoading(true)
            try {
                const [conditionsData] = await Promise.all([
                    getConditions()
                ])
    
                if (conditionsData) {
                    setConditions(conditionsData.filter(c => c.category_id >= 7 && c.category_id <= 10))
                }
            } catch (error) {
                console.log(error)
            } finally {
                setIsLocalLoading(false)
            }
        }
        fetchData()
    }, [])

    if(isLoading || isLocalLoading) return <Loader />

    return (
        <>
            <Breadcrumb list={list} />   
            <h1>Carátula Técnica</h1>

            {!project?.technical_case?.sended_at && (
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
                <InputGroup disable value={project?.brand.client.business_name!} label="Arrendamiento" name="business_name" placeholder="Nombre de la empresa" />

                <div className="mt-1 grid grid-cols-2 g-1">
                    <InputGroup disable value={project?.lands[0].land.cadastral_file!} placeholder="Experiente Catastral" name="cadastral_file" label="Expediente Catastral" />
                    <InputGroup disable value={project?.lands[0].type.name!} placeholder="Tipo de arrendamiento" name="type" label="Tipo de Arrendamiento" />
                </div>

                <form className="mt-4">

                    <div className="grid grid-cols-2 g-2">
                        <div>
                            <h2>Aspectos Técnicos de Arrendamiento</h2>
                            <ConditionsContainer
                                isNotGrid
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={conditions.filter(c => c.category_id === 10)} 
                                project={project!} />
                        </div>
                        
                        <div>
                            <h2>Servicios de Electricidad</h2>
                            <ConditionsContainer
                                isNotGrid
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={conditions.filter(c => c.category_id === 7)} 
                                project={project!} />
                        </div>
                        
                        <div>
                            <h2>Servicios de Agua y Drenaje</h2>
                            <ConditionsContainer
                                isNotGrid
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={conditions.filter(c => c.category_id === 8)} 
                                project={project!} />
                        </div>
                        
                        <div>
                            <h2>Gestiones requeridas</h2>
                            <ConditionsContainer
                                isNotGrid
                                isChecked
                                newConditions={newConditions}
                                setNewConditions={setNewConditions} 
                                conditionsList={conditions.filter(c => c.category_id === 9)} 
                                project={project!} />
                        </div>
                    </div>
                </form>
            </div>
        </>
    )
}
