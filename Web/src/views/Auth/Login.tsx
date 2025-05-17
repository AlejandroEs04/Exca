import { ChangeEvent, FormEvent, useState } from 'react'
import InputGroup, { PushEvent } from '../../components/forms/InputGroup'
import { login } from '../../api/AuthApi'
import { toast } from 'react-toastify'
import { useNavigate } from 'react-router-dom'

export default function Login() {
    const [auth, setAuth] = useState({
        email: '', 
        password: ''
    })
    const navigate = useNavigate()

    const handleChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target

        setAuth({
            ...auth, 
            [name]: value
        })
    }

    const handleSubmit = async(e: FormEvent) => {
        e.preventDefault()
        
        try {
            const token = await login(auth)
            
            if(token)
                localStorage.setItem("token", token)

            navigate('/')
        } catch (error) {
            if (error instanceof Error && error.message)
                toast.error(error.message)
        }
    }

    return (
        <>
            <h1>Iniciar Sesión</h1>
            <p>Ingrese sus credenciales para ingresar al sistema</p>

            <form onSubmit={handleSubmit} className='mt-2'>
                <InputGroup 
                    onChangeFnc={handleChange} 
                    value={auth.email} 
                    label="Correo"
                    id='email'
                    type='email'
                    name='email'
                    placeholder='Ej. correo@gnp.com' />

                <InputGroup 
                    onChangeFnc={handleChange}
                    className={"mt-1"} 
                    value={auth.password} 
                    label="Contraseña"
                    id='password'
                    type='password'
                    name='password'
                    placeholder='Contraseña' />

                <button className='btn btn-primary w-max mt-1'>Iniciar Sesión</button>
            </form>
        </>
    )
}
