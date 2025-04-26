import { useNavigate, useParams } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { useAppContext } from "../../hooks/AppContext"
import { useEffect, useState } from "react"
import { Condition, ProjectView } from "../../types"
import Loader from "../../components/shared/Loader/Loader"
import InputGroup from "../../components/forms/InputGroup"
import { getConditions } from "../../api/ConditionApi"
import ConditionsContainer from "../../components/ConditionsContainer/ConditionsContainer"

export default function TechnicalCase() {
    const { projectId } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Carátula técnica",url:`/technical-case/${projectId}`},
    ]

    const { state, isLoading } = useAppContext()
    const navigate = useNavigate()
    const [project, setProject] = useState<ProjectView | null>(null)
    const [conditions, setConditions] = useState<Condition[]>([])
    const [isLocalLoading, setIsLocalLoading] = useState(false)

    useEffect(() => {
        if(state.projects.length) {
            const currentProject = state.projects.find(p => p.id === +projectId!) ?? null

            if(!currentProject) navigate("/projects")

            setProject(currentProject)
        }
    }, [state.projects, projectId])

    useEffect(() => {
        const fetchData = async () => {
            setIsLocalLoading(true)
            try {
                const [conditionsData] = await Promise.all([
                    getConditions()
                ])
    
                if (conditionsData) setConditions(conditionsData.filter(c => c.category_id >= 7 || c.category_id <= 10))
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

            <div>
                <InputGroup disable value={project?.brand.client.business_name!} label="Arrendamiento" name="business_name" placeholder="Nombre de la empresa" />

                <div className="mt-1 grid grid-cols-2 g-1">
                    <InputGroup disable value={project?.lands[0].land.cadastral_file!} placeholder="Experiente Catastral" name="cadastral_file" label="Expediente Catastral" />
                    <InputGroup disable value={project?.lands[0].type.name!} placeholder="Tipo de arrendamiento" name="type" label="Tipo de Arrendamiento" />
                </div>

                <form className="mt-4">
                    <h2>Aspectos Técnicos de Arrendamiento</h2>
                    <ConditionsContainer conditions={conditions.filter(c => c.category_id === 10)} project={project!} />

                    <h2>Servicios de Electricidad</h2>
                    <ConditionsContainer conditions={conditions.filter(c => c.category_id === 7)} project={project!} />

                    <h2>Servicios de Agua y Drenaje</h2>
                    <ConditionsContainer conditions={conditions.filter(c => c.category_id === 8)} project={project!} />
                    
                    <h2>Gestiones requeridas</h2>
                    <p>En caso de no ser necesarias, deje el espacio en blanco</p>
                    <ConditionsContainer conditions={conditions.filter(c => c.category_id === 9)} project={project!} />
                </form>
            </div>
        </>
    )
}
