import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { useAppContext } from '../../hooks/AppContext'
import { Condition, Project, ProjectView } from '../../types'
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb'
import { currencyFormat, dateFormat, isNullOrEmpty } from '../../utils'
import Loader from '../../components/shared/Loader/Loader'
import { toast } from 'react-toastify'
import InputGroup, { PushEvent } from '../../components/forms/InputGroup'
import LeaseRequestInformation from '../../components/LeaseRequest/LeaseRequestInformation'
import ListIcon from '../../components/shared/Icons/ListIcon'
import DocumentTextIcon from '../../components/shared/Icons/DocumentTextIcon'
import ActivitiesIcon from '../../components/shared/Icons/ActivitiesIcon'
import { getProjectById } from '../../api/ProjectApi'
import SaveIcon from '../../components/shared/Icons/SaveIcon'
import { getConditions } from '../../api/ConditionApi'

export default function FormProject() {
    const { id } = useParams<{ id?: string }>()
    const navigate = useNavigate()
    const { isLoading } = useAppContext()
    const [conditions, setConditions] = useState<Condition[]>([])

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Validar Proyectos",url:'/verify-projects'},
        {name:"Proyecto",url:`/verify-projects/form-project/${id}`},
    ]

    const { state } = useAppContext()
    const [project, setProject] = useState<Project>({
        id: 0,
        name: '',
        client: '',
        brand_id: 0,
        stage_id: 0,
        origitnator_id: 0,
        created_at: '',
        updated_at: '',
        lands: [],
        stage: { id: 0, name: '' },
        approvations: []

    })
    
    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()
        return; 
    }
    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target
    
        setProject({
            ...project, 
            [name]: value
        })
    }
    

    useEffect(() => {
        const getinfo = async () => {
            if (id) {
                
                const dataProject = await getProjectById(id)
                if (!dataProject) {
                    toast.error("No existe el proyecto seleccionado: " + id)
                    //navigate("/verify-projects")
                    return
                }
                setProject(dataProject)
                const [conditionsData] = await Promise.all([
                    getConditions()
                ])
                if (conditionsData) setConditions(conditionsData)
                //toast.success('Proyecto: ' + dataProject.id)
            }
        }
        getinfo()
    }, [id])

    if (isLoading || !project) return <Loader />
   return(
    <>
        <Breadcrumb list={list} />
        {id ? <h1>{project.name}</h1> : <h1>Registrar Interesado</h1>}
        <p className='date'>Creado el: {dateFormat(project.created_at)}</p>
        <p className='mt-1'>Estatus: {project?.stage_id}</p>
        <div style={{ display: 'flex', gap: '20px',width: '100%' }}>
            <form onSubmit={onSubmit}>
                <button type="submit" className="btn btn-success mb-4">
                    <SaveIcon />
                    Guardar
                </button>
                <div>
                    <InputGroup name="name" label="Nombre del proyecto" 
                        value={project.name ? project.name : '' } placeholder="Nombre del proyecto" onChangeFnc={onChange} />
                    <InputGroup name="brand_id" label="Marca" 
                        value={project.brand_id ? project.brand_id : '' } placeholder="Marca" onChangeFnc={onChange} />
                    <InputGroup name="stage_id" label="Stage" 
                        value={project.stage_id ? project.stage_id : '' } placeholder="Stage" onChangeFnc={onChange} />
                     {/* Iteración de conditions */}
                    {conditions.map((condition) => (
                        <InputGroup
                        key={condition.id}
                        name={`condition_${condition.id}`} // nombre único
                        label={condition.name}
                        value={''}
                        placeholder={`Ingrese ${condition.name.toLowerCase()}`}
                        onChangeFnc={onChange}
                        />
                    ))}

                </div>
            </form>

        </div>
    </>
    
   )
    
}
