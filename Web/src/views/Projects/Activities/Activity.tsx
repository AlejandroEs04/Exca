import { useParams } from "react-router-dom"
import { useAppContext } from "../../../hooks/AppContext"
import { ChangeEvent, useEffect, useMemo, useState } from "react"
import { Task, TaskCreate, TaskStatus } from "../../../types"
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb"
import { createTask, getTaskStatus, sendMessage, updateTask } from "../../../api/TaskApi"
import styles from './Activities.module.css'
import { dateFormat, formatDateToInput, simpleDateFormat } from "../../../utils"
import SendIcon from "../../../components/shared/Icons/SendIcon"
import { toast } from "react-toastify"
import TrashIcon from "../../../components/shared/Icons/TrashIcon"
import EyeIcon from "../../../components/shared/Icons/EyeIcon"
import EditIcon from "../../../components/shared/Icons/EditIcon"
import SelectGroup from "../../../components/forms/SelectGroup"
import InputGroup from "../../../components/forms/InputGroup"
import ComboBox from "../../../components/forms/ComboBox"
import XMark from "../../../components/shared/Icons/XMark"
import { AnimatePresence, motion } from "framer-motion"
import { handleFormChange } from "../../../utils/onChange"
import PlusIcon from "../../../components/shared/Icons/PlusIcon"
import CheckIcon from "../../../components/shared/Icons/CheckIcon"
import { progressDictionary } from "../../../locals/dictionaries"

export default function Activity() {
    const { id, taskId } = useParams()
    const { state, dispatch, setError } = useAppContext()
    const [task, setTask] = useState<Task>()
    const [status, setStatus] = useState<TaskStatus[]>([])
    const [title, setTitle] = useState("")
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${id}`},
        {name:"Obligaciones",url:`/projects/${id}/tasks`},
        {name: title,url:`/projects/${id}/tasks/${taskId}`},
    ]
    const initialState = {
        title: '',
        description: '', 
        responsible_id: 0, 
        due_date: '', 
        task_id: +taskId!, 
        project_id: +id!, 
        status_id: 1
    }
    const [messsage, setMessage] = useState('')
    const [subTask, setSubTask] = useState<TaskCreate>(initialState)
    const [showForm, setShowForm] = useState(false)
    const [subTaskId, setSubTaskId] = useState<number | null>(null)
    let lastName = 0

    const handleChange = (e: ChangeEvent<HTMLElement>) => handleFormChange(e, subTask, setSubTask)
    const isDisable = useMemo(() => subTask.title === '' || subTask.description === '' || subTask.responsible_id === 0, [subTask])

    const handleSendMessage = async() => {
        try {
            const newMessage = await sendMessage(+taskId!, messsage)

            dispatch({
                type: 'set-projects',
                payload: {
                    projects: state.projects.map(project => project.id !== +id! ? project : {
                        ...project, 
                        tasks: project.tasks.map(task => task.id !== +taskId! ? task : {
                            ...task, 
                            messages: [...task.messages, newMessage!]
                        })
                    })
                }
            })

            toast.success("Mensaje enviado correctamente")
            setMessage('')
        } catch (error) {
            setError(error)
        }
    }

    const handleShowName = (id: number) : boolean => {
        if(id === lastName) return false;

        lastName = id
        return true
    }

    const onSelect = (selectedId: string | number, name: string) => {
        setSubTask({
            ...subTask, 
            [name]: selectedId
        })
    }

    const onCreate = (_newItemLabel: string, _name: string) => {
        toast.info("No se puede reedirigir a crear un nuevo usuario")
    };

    const handleFillForm = (fillTaskId: number) => {
        const project = state.projects.find(p => p.id === +id!)
        const task = project?.tasks.find(t => t.id === fillTaskId)
        setSubTask({
            title: task?.title ?? '',
            description: task?.description ?? '', 
            responsible_id: task?.responsible_id ?? 0, 
            due_date: task?.due_date ?? '', 
            task_id: task?.task_id ?? null, 
            project_id: task?.project_id ?? +id!, 
            status_id: task?.status_id ?? 1
        })
        setShowForm(true)
        setSubTaskId(fillTaskId)
    }

    const handleCloseForm = () => {
        setShowForm(false)
        setSubTaskId(null)
        setSubTask(initialState)
    }

    const handleSubmit = async() => {
        try {
            if(subTaskId) {
                const response = await updateTask(subTaskId, subTask)

                if(response) 
                    if (task) {
                        setTask({
                            ...task,
                            subtasks: task.subtasks.map(subtask => subtask.id !== response.id ? subtask : response)
                        });
                    }
                toast.success("Traea Actualizado Correctamente")
            } else {
                const response = await createTask(subTask)
                if(response) {
                    if(task) {
                        setTask({
                            ...task, 
                            subtasks: [...task.subtasks, response]
                        })
                    }
                }
                toast.success("Traea Creada Correctamente")
            }
            setShowForm(false)
            setSubTaskId(null)
        } catch (error) {
            setError(error)
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
        if(taskId && state.projects.length) {
            const currentProject = state.projects.find(p => p.id === +id!)
            const task = currentProject?.tasks.find(t => t.id === +taskId!)

            if(task) {
                setTask(task)
                setTitle(task.title)
            }
        }
    }, [state.projects, taskId])
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>{task?.title}</h1>
            <p className={styles.infoGray}>Fecha de creación: <span>{dateFormat(task?.created_at ?? '')}</span></p>
            <p className={styles.infoGray}>Estatus: <span>{status.find(s => s.id === task?.status_id)?.name}</span></p>

            <div className="flex g-1 mt-1">
                <button className="btn btn-success"><CheckIcon /> Finalizar</button>
                <button className="btn btn-indigo"><XMark /> Cancelar</button>
            </div>
        
            <div className={`flex g-4 mt-2`}>
                <div className={styles.infoContainer}>
                    <div>
                        <h2>Información General</h2>
                        <table>
                            <tr>
                                <td>Responsable:</td>
                                <td>{state.users.find(u => u.id === task?.responsible_id)?.full_name}</td>
                            </tr>
                            <tr>
                                <td>Descripción:</td>
                                <td>{task?.description}</td>
                            </tr>
                            <tr>
                                <td>Vencimiento:</td>
                                <td>{dateFormat(task?.due_date ?? '')}</td>
                            </tr>
                        </table>
                    </div>

                    <h2 className="mt-2">Subtareas</h2>
                    <button onClick={() => { setShowForm(true); setSubTask(initialState) }} className='btn btn-primary w-max'><PlusIcon /> Nueva Actividad</button>
                    <div>
                        {task?.subtasks.length ? (
                            <>
                                <table className={`mt-1`}>
                                    <thead>
                                        <tr>
                                            <th>Descripcion</th>
                                            <th>Estatus</th>
                                            <th>Fecha de vencimiento</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        {task.subtasks.map(t => (
                                            <tr key={t.id}>
                                                <td>{t.description}</td>
                                                <td>
                                                    <div className='progress-container'>
                                                        <div
                                                            style={{
                                                                width: progressDictionary[`${t.status_id}`],
                                                                height: '100%'
                                                            }}
                                                            className={`
                                                                progress-bar
                                                                ${t.status_id === 1 && 'bg-red'}
                                                                ${t.status_id === 2 && 'bg-yellow'}
                                                                ${t.status_id === 3 && 'bg-blue'}
                                                                ${t.status_id === 4 && 'bg-orange'}
                                                                ${t.status_id === 5 && 'bg-green complete'}
                                                                `}
                                                        ></div>
                                                        <span className='progress-text'>{t.status.name}</span>
                                                    </div>
                                                </td>
                                                <td>{simpleDateFormat(t.due_date)}</td>
                                                <td>
                                                    <div className='table-actions'>
                                                        <button className={`${styles.btnIcon} text-indigo`}><EyeIcon /></button>
                                                        <button onClick={() => handleFillForm(t.id)} className={`${styles.btnIcon} text-blue`}><EditIcon /></button>
                                                        <button className={`${styles.btnIcon} text-red`}><TrashIcon /></button>
                                                    </div>
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </>
                        ) : (
                            <p className="mt-1">No hay ninguna subtarea ingresada</p>
                        )}
                    </div>
                </div>

                <div className={styles.chatContainer}>
                    <div className={styles.messages}>
                        <h2>Chat</h2>
                        <div className={styles.chat}>
                            {task?.messages.length ? task.messages.map(message => (
                                <div className={`${styles.message} ${message.originator_id === state.auth?.id ? styles.right : styles.left}`}>
                                    {handleShowName(message.originator_id) ? <p className={styles.originator}>{state.users.find(u => u.id === message.originator_id)?.full_name}</p> : ''}
                                    <div className={styles.messageContent}>
                                        <p className={styles.message}>{message.message}</p>
                                    </div>
                                    <p className={styles.date}>{dateFormat(message.submitted_at ?? '')}</p>
                                </div>
                            )) : (
                                <p className={styles.alertMessage}>No hay ningún mensaje</p>
                            )}
                        </div>
                    </div>

                    <div className={`${styles.messageTextBox} mt-1`}>
                        <input value={messsage} onChange={(e) => setMessage(e.target.value)} type="text" placeholder="Ingrese el mensaje..." />
                        <button disabled={messsage === ''} className="text-blue" onClick={handleSendMessage}><SendIcon /></button>
                    </div>
                </div>
            </div>

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
                        <h1>Nueva Subtarea</h1>
                        <p>Complete el formulario para agregar una nueva tarea</p>
                        <div className="flex flex-col g-1 mt-2">
                            <InputGroup name="title" value={subTask.title} onChangeFnc={handleChange} placeholder="Titulo" label="Titulo" />
                            <InputGroup name="description" value={subTask.description} onChangeFnc={handleChange} placeholder="Descripcion" label="Descripcion" />
                            <InputGroup type='date' name="due_date" value={formatDateToInput(subTask.due_date)} onChangeFnc={handleChange} placeholder="Fecha de Vencimiento" label="Fecha de vencimiento" />
                            <ComboBox 
                                name='responsible_id' 
                                value={subTask.responsible_id} 
                                placeholder='Responsable' 
                                options={state.users.map(u => { return { id: u.id, label: u.full_name } })}
                                label='Responsable'
                                onCreate={onCreate}
                                onSelect={onSelect}
                            />

                            {taskId && (
                                <SelectGroup onChangeFnc={handleChange} name='status_id' placeholder='Seleccione un estatus' value={subTask.status_id} label='Estatus' options={status.map(s => { return { label: s.name, value: s.id } })} />
                            )}

                            <button disabled={isDisable} onClick={handleSubmit} className='btn btn-primary w-max flex text-center'>Guardar Actividad</button>
                            <button onClick={handleCloseForm} className='btn btn-danger w-max flex text-center mt-2'>Cancelar</button>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </>
    )
}
