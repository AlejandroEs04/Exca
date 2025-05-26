import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from 'react'
import { UserCreate } from '../../types'
import InputGroup, { Option } from '../../components/forms/InputGroup'
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb'
import SaveIcon from '../../components/shared/Icons/SaveIcon'
import { isNullOrEmpty } from '../../utils'
import SelectGroup from '../../components/forms/SelectGroup'
import { createUser, getAreas, getRoles, getTitles } from '../../api/UserApi'
import { useAppContext } from '../../hooks/AppContext'
import { toast } from 'react-toastify'
import { useNavigate } from 'react-router-dom'
import { handleFormChange } from '../../utils/onChange'

export default function CreateUser() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
        {name:"Usuarios",url:'/settings/users'},
        {name:"Registrar User",url:'/settings/users/create'},
    ]

    const { state, dispatch } = useAppContext()
    const navigate = useNavigate()
    const [areaOptions, setAreaOptions] = useState<Option[]>([])
    const [rolOptions, setRolOptions] = useState<Option[]>([])
    const [titleOptions, setTitleOptions] = useState<Option[]>([])
    const [user, setUser] =useState<UserCreate>({
        full_name: '', 
        email: '', 
        area_id: 0, 
        rol_id: 0,
        password: '', 
        user_title_id: 0
    })

    const onChange = (e: ChangeEvent<HTMLElement>) => handleFormChange(e, user, setUser)

    const isDisable = useMemo(() => 
        isNullOrEmpty(user.full_name) || isNullOrEmpty(user.email) || +user.area_id === 0 || +user.rol_id === 0, [user])

    useEffect(() => {
        const getInfo = async() => {
            const areas = await getAreas()
            const roles = await getRoles()
            const titles = await getTitles()

            if(!areas || !roles || !titles) return

            setTitleOptions(titles.map(t => { return { label: t.name, value: t.id } }))
            setAreaOptions(areas.map(a => { return { label: a.name, value: a.id } }))
            setRolOptions(roles.map(r => { return { label: r.name, value: r.id } }))
        }
        getInfo()
    }, [])

    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()
    
        try {
            const newUser = await createUser(user)
            dispatch({ type: 'set-users', payload: { users : [...state.users, newUser!] } })
            navigate('/settings/users')
    
            toast.success("Usuario creado correctamente")
        } catch (error) {
            console.log(error)
        }
    }

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registar Usuario</h1>

            <form onSubmit={onSubmit}>
                <button disabled={isDisable} type="submit" className="btn btn-primary">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="grid grid-cols-3 mt-2 g-1">
                    <InputGroup name="full_name" label="Nombre completo" value={user.full_name} placeholder="Nombre completo" onChangeFnc={onChange} />
                    <InputGroup name="email" label="Correo" value={user.email} placeholder="Ej. correo@correo.com" onChangeFnc={onChange} type='email' />      
                    <SelectGroup name='area_id' label='Área' value={user.area_id} placeholder='Seleccione un área' onChangeFnc={onChange} options={areaOptions} />   
                    <SelectGroup name='rol_id' label='Rol' value={user.rol_id} placeholder='Seleccione un rol' onChangeFnc={onChange} options={rolOptions} />   
                    <SelectGroup name='user_title_id' label='Puesto' value={user.user_title_id} placeholder='Seleccione un puesto' onChangeFnc={onChange} options={titleOptions} />   
                    <InputGroup name="password" label="Contraseña" value={user.password} placeholder="Contraseña" onChangeFnc={onChange} type='password' />      
                </div>
            </form>
        </>
    )
}
