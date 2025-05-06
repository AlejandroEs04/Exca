import { useNavigate, useParams } from "react-router-dom";
import { useAppContext } from "../../../hooks/AppContext";
import { useEffect, useState } from "react";
import { Condition, ConditionCreate, ProjectView } from "../../../types";
import { getConditions } from "../../../api/ConditionApi";
import Loader from "../../../components/shared/Loader/Loader";
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb";
import InputGroup from "../../../components/forms/InputGroup";
import ConditionsContainer from "../../../components/ConditionsContainer/ConditionsContainer";

export default function LegalCase() {
    const { projectId } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Carátula legal",url:`/legal-case/${projectId}`},
    ]

    const { state, isLoading } = useAppContext();
    const navigate = useNavigate();
    const [project, setProject] = useState<ProjectView | null>(null)
    const [conditions, setConditions] = useState<Condition[]>([])
    const [newConditions, setNewConditions] = useState<ConditionCreate[]>([])
    const [isLocalLoading, setIsLocalLoading] = useState(false)

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
                    setConditions(conditionsData.filter(c => c.category_id >= 1 && c.category_id <= 6))
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
            <h1>Carátula Legal</h1>

            <div className="grid grid-cols-3 g-1">
                <InputGroup disable name="cadastral_file" value={project?.lands[0].land.cadastral_file!} placeholder="Expediente Catastral" label="Expediente Catastral" />
                <InputGroup disable name="residential_development" value={project?.lands[0].land.residential_development.name!} placeholder="Fraccionamiento" label="Fraccionamiento" />
                <InputGroup disable name="type" value={project?.lands[0].type.name!} placeholder="Objeto" label="Objeto" />
                <InputGroup disable name="area" value={project?.lands[0].land.area!} placeholder="Superficie en m2" label="Superficie en m2" />
                <InputGroup disable name="buildingArea" value={project?.lands[0].area!} placeholder="Superficie de construccion" label="Superficie de construccion" />
            </div>

            <div className="mt-2">
                <div>
                    <div>
                        <h2>Condiciones Generales</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            setNewConditions={setNewConditions} 
                            conditionsList={conditions.filter(c => c.category_id === 2)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Contencion de riesgos economicos</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            setNewConditions={setNewConditions} 
                            conditionsList={conditions.filter(c => c.category_id === 3)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Contencion de riesgos</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            setNewConditions={setNewConditions} 
                            conditionsList={conditions.filter(c => c.category_id === 4)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Mitigacion de riesgos</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            setNewConditions={setNewConditions} 
                            conditionsList={conditions.filter(c => c.category_id === 5)} 
                            project={project!} />
                    </div>

                    <div className="mt-2">
                        <h2>Construccion por GP</h2>
                        <ConditionsContainer
                            newConditions={newConditions}
                            setNewConditions={setNewConditions} 
                            conditionsList={conditions.filter(c => c.category_id === 6)} 
                            project={project!} />
                    </div>
                </div>
            </div>
        </>
    )
}
