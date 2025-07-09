import styles from '../project.module.css'
import { Link, useParams } from "react-router-dom"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import { ChangeEvent, useEffect, useMemo, useState } from "react"
import InputGroup from "../../../components/forms/InputGroup"
import { Project, TaskCreate, TaskStatus } from "../../../types"
import { handleFormChange } from "../../../utils/onChange"
import { useAppContext } from "../../../hooks/AppContext"
import XMark from '../../../components/shared/Icons/XMark'
import ComboBox from '../../../components/forms/ComboBox'
import { toast } from 'react-toastify'
import { createTask, getTaskStatus, updateTask } from '../../../api/TaskApi'
import { motion, AnimatePresence } from 'framer-motion'
import PlusIcon from '../../../components/shared/Icons/PlusIcon'
import TrashIcon from '../../../components/shared/Icons/TrashIcon'
import EditIcon from '../../../components/shared/Icons/EditIcon'
import { formatDateToInput } from '../../../utils'
import SelectGroup from '../../../components/forms/SelectGroup'
import EyeIcon from '../../../components/shared/Icons/EyeIcon'

export default function Activities() {
    const { id } = useParams()
    const { state, dispatch, setError } = useAppContext()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${id}`},
        {name:"Obligacines",url:`/projects/${id}/tasks`},
    ]
    const initialState = {
        title: '',
        description: '', 
        responsible_id: 0, 
        due_date: '', 
        task_id: null, 
        project_id: +id!, 
        status_id: 1
    }
    const [task, setTask] = useState<TaskCreate>(initialState)
    const [project, setProject] = useState<Project>()
    const [showForm, setShowForm] = useState(false)
    const [taskId, setTaskId] = useState<number | null>(null)
    const [status, setStatus] = useState<TaskStatus[]>([])

    const isDisable = useMemo(() => task.title === '' || task.description === '' || task.responsible_id === 0, [task])

    const handleChange = (e: ChangeEvent<HTMLElement>) => handleFormChange(e, task, setTask)

    const onSelect = (selectedId: string | number, name: string) => {
        setTask({
            ...task, 
            [name]: selectedId
        })
    }

    const onCreate = (_newItemLabel: string, _name: string) => {
        toast.info("No se puede reedirigir a crear un nuevo usuario")
    };

    const handleFillForm = (fillTaskId: number) => {
        const task = project?.tasks.find(t => t.id === fillTaskId)
        setTask({
            title: task?.title ?? '',
            description: task?.description ?? '', 
            responsible_id: task?.responsible_id ?? 0, 
            due_date: task?.due_date ?? '', 
            task_id: task?.task_id ?? null, 
            project_id: task?.project_id ?? +id!, 
            status_id: task?.status_id ?? 1
        })
        setShowForm(true)
        setTaskId(fillTaskId)
    }

    const handleCloseForm = () => {
        setShowForm(false)
        setTaskId(null)
        setTask(initialState)
    }

    const handleSubmit = async() => {
        try {
            if(taskId) {
                console.log(task)
                const response = await updateTask(taskId, task)
                dispatch({ 
                    type: 'set-projects', 
                    payload: { 
                        projects: state.projects.map(p => 
                            p.id !== +id! 
                                ? p 
                                : { 
                                    ...p, 
                                    tasks: p.tasks.map(t => t.id !== taskId ? t : response!)
                                  }
                        ) 
                    } 
                })
                toast.success("Traea Actualizado Correctamente")
            } else {
                const response = await createTask(task)
                dispatch({ 
                    type: 'set-projects', 
                    payload: { 
                        projects: state.projects.map(p => 
                            p.id !== +id! 
                                ? p 
                                : { 
                                    ...p, 
                                    tasks: [...p.tasks, response].filter((t): t is NonNullable<typeof t> => t !== undefined) 
                                  }
                        ) 
                    } 
                })
                toast.success("Traea Creada Correctamente")
            }
            setShowForm(false)
            setTaskId(null)
        } catch (error) {
            setError(error)
        }        
    }

    const handleGetStatusColor = (id: number) => {
        switch(id) {
            case 1:
                return 'red'
            case 2:
                return 'purple'
            case 3:
                return 'blue'
            case 4: 
                return 'orange'
            case 5: 
                return 'green'
        }
    }

    useEffect(() => {
        const getInfo = async() => {
            const taskStatus = await getTaskStatus()
            if(taskStatus) setStatus(taskStatus)
        }
        getInfo()
    }, [])

    useEffect(() => {
        if(id) {
            const project = state.projects.find(p => p.id === +id!)

            if(project)
                setProject(project)
        }
    }, [state.projects, id])

    return (
        <>
            <Breadcrumb list={list} />   
            <h1>Obligaciones</h1>

            <button onClick={() => { setShowForm(true); setTask(initialState) }} className='btn btn-primary w-max'><PlusIcon /> Nueva Obligación</button>
            
            <table className={`mt-1 ${styles.tableActivities}`}>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Titulo</th>
                        <th>Descripcion</th>
                        <th>Estatus</th>
                        <th>Fecha de vencimiento</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {project?.tasks.map(t => (
                        <tr key={t.id}>
                            <td>{t.id}</td>
                            <td>{t.title}</td>
                            <td>{t.description}</td>
                            <td>
                                <div className='flex items-center justify-between'>
                                    {status.find(s => s.id === t.status_id)?.name}
                                    <div className={`dot ${handleGetStatusColor(t.status_id)}`}></div>
                                </div>
                            </td>
                            <td>{formatDateToInput(t.due_date)}</td>
                            <td>
                                <div className='flex g-1'>
                                    <Link to={`${t.id}`} className={`${styles.btnIcon} text-indigo`}><EyeIcon /></Link>
                                    <button onClick={() => handleFillForm(t.id)} className={`${styles.btnIcon} text-blue`}><EditIcon /></button>
                                    <button className={`${styles.btnIcon} text-red`}><TrashIcon /></button>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <AnimatePresence>
                {showForm && (
                    <motion.div 
                        className={styles.formFloat}
                        initial={{ y: 50, opacity: 0 }}
                        animate={{ y: 0, opacity: 1 }}
                        exit={{ y: 50, opacity: 0 }}
                        transition={{ duration: 0.2 }}
                    >
                        <div className='flex justify-end'>
                            <button onClick={handleCloseForm} className='flex items-center text-red'>
                                <XMark color='text-red' />
                                Cerrar
                            </button>
                        </div>
                        <h1>Nueva Obligación</h1>
                        <p>Complete el formulario para agregar una nueva obligación</p>
                        <div className="flex flex-col g-1 mt-2">
                            <InputGroup name="title" value={task.title} onChangeFnc={handleChange} placeholder="Titulo" label="Titulo" />
                            <InputGroup name="description" value={task.description} onChangeFnc={handleChange} placeholder="Descripcion" label="Descripcion" />
                            <InputGroup type='date' name="due_date" value={formatDateToInput(task.due_date)} onChangeFnc={handleChange} placeholder="Fecha de Vencimiento" label="Fecha de vencimiento" />
                            <ComboBox 
                                name='responsible_id' 
                                value={task.responsible_id} 
                                placeholder='Responsable' 
                                options={state.users.map(u => { return { id: u.id, label: u.full_name } })}
                                label='Responsable'
                                onCreate={onCreate}
                                onSelect={onSelect}
                            />

                            {taskId && (
                                <SelectGroup onChangeFnc={handleChange} name='status_id' placeholder='Seleccione un estatus' value={task.status_id} label='Estatus' options={status.map(s => { return { label: s.name, value: s.id } })} />
                            )}

                            <button disabled={isDisable} onClick={handleSubmit} className='btn btn-primary w-max flex text-center'>Guardar Obligación</button>
                            <button onClick={handleCloseForm} className='btn btn-danger w-max flex text-center mt-2'>Cancelar</button>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>

        </>
    )
}
