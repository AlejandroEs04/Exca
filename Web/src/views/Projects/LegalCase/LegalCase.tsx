import { useNavigate, useParams } from "react-router-dom";
import { useAppContext } from "../../../hooks/AppContext";
import { useEffect, useState } from "react";
import { Case, CaseConditionCreate, CaseCreate, Project } from "../../../types";
import Loader from "../../../components/shared/Loader/Loader";
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb";
import InputGroup from "../../../components/forms/InputGroup";
import ConditionsContainer from "../../../components/ConditionsContainer/ConditionsContainer";
import { toast } from "react-toastify";
import { createCase, sendCase, updateCase } from "../../../api/CaseApi";
import { formatDateToInput } from "../../../utils";
import SaveIcon from "../../../components/shared/Icons/SaveIcon";
import SendIcon from "../../../components/shared/Icons/SendIcon";

export default function LegalCase() {
    const { projectId, caseId } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Carátula legal",url:`/legal-case/${projectId}`},
    ]
    const { state, isLoading, setError, dispatch } = useAppContext()
    const navigate = useNavigate()
    const [project, setProject] = useState<Project | null>(null)
    const [newConditions, setNewConditions] = useState<CaseConditionCreate[]>([])

const handleSubmit = async() => {
        try {
            const newTechnicalCase : CaseCreate = {
                project_id: +projectId!, 
                case_type_id: 2, 
                title: 'Cáratula Legal',
                description: '', 
                conditions: newConditions
            }
            let responseData: Case | Case[] | undefined;

            if(caseId) {
                responseData = await updateCase(+caseId!, newTechnicalCase)
            } else {
                responseData = await createCase(newTechnicalCase)
            }

            // Ensure response is a single Case object
            const response = Array.isArray(responseData) ? responseData[0] : responseData;

            if (!response) {
                throw new Error("No case returned from API");
            }
            dispatch({ type: 'set-projects', 
                payload: { projects: state.projects.map(p => p.id !== +projectId! ? p : { ...p, cases: p.cases?.map(c => c.case_type_id !== 2 ? c : response) }) } })
            navigate(`/legal-case/${projectId}/${response.id}`)
            toast.success("Guardado correctamente")
        } catch (error) {
            setError(error)
        }
    }

    const handleSend = async() => {
        try {
            await handleSubmit()
            const response = await sendCase(+caseId!)
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
        const conditionValue = project?.cases?.find(c => c.case_type_id === 2)?.conditions?.find(c => c.condition_id === id)
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
            setNewConditions(currentProject?.cases?.find(c => c.case_type_id === 2)?.conditions ?? [])
        }
    }, [state.projects, projectId])

    if(isLoading) return <Loader />

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Carátula Legal</h1>

            {!project?.cases?.find(c => c.case_type_id === 2)?.sended_at && (
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

            <div className="grid grid-cols-3 g-1 mt-1">
                <InputGroup disable name="cadastral_file" value={project?.lands?.[0]?.land?.cadastral_file ?? ''} placeholder="Expediente Catastral" label="Expediente Catastral" />
                <InputGroup disable name="residential_development" value={project?.lands?.[0]?.land?.residential_development?.name! ?? ''} placeholder="Fraccionamiento" label="Fraccionamiento" />
                <InputGroup disable name="type" value={project?.lands?.[0]?.type?.name ?? ''} placeholder="Objeto" label="Objeto" />
                <InputGroup disable name="area" value={project?.lands?.[0]?.land?.area! ?? ''} placeholder="Superficie en m2" label="Superficie en m2" />
                <InputGroup disable name="buildingArea" value={project?.lands?.[0]?.area! ?? 0} placeholder="Superficie de construccion" label="Superficie de construccion" />
            </div>

            <div className="mt-2">
                <div>
                    <div>
                        <h2>Condiciones Generales</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            handleGetValue={handleGetValue}
                            setNewConditions={setNewConditions} 
                            conditionsList={state.conditions.filter(c => c.category_id === 2)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Contencion de riesgos economicos</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            handleGetValue={handleGetValue}
                            setNewConditions={setNewConditions} 
                            conditionsList={state.conditions.filter(c => c.category_id === 3)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Contencion de riesgos</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            handleGetValue={handleGetValue}
                            setNewConditions={setNewConditions} 
                            conditionsList={state.conditions.filter(c => c.category_id === 4)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Mitigacion de riesgos</h2>
                        <ConditionsContainer
                        handleGetValue={handleGetValue}
                            newConditions={newConditions}
                            setNewConditions={setNewConditions} 
                            conditionsList={state.conditions.filter(c => c.category_id === 5)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Construccion por GP</h2>
                        <ConditionsContainer
                        handleGetValue={handleGetValue}
                            newConditions={newConditions}
                            setNewConditions={setNewConditions} 
                            conditionsList={state.conditions.filter(c => c.category_id === 6)} 
                            project={project!} />
                    </div>
                </div>
            </div>
        </>
    )
}
