import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from "react";
import InputGroup, { PushEvent } from "../../components/forms/InputGroup";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import SaveIcon from "../../components/shared/Icons/SaveIcon";
import { useAppContext } from "../../hooks/AppContext";
import { useNavigate, useParams } from "react-router-dom";
import { isNullOrEmpty } from "../../utils";
import { Client } from "../../types";
import { updateClient } from "../../api/ClientApi";

export default function EditClient() {
    const { id } = useParams()

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Clientes",url:'/clients'},
        {name:"Editat Cliente",url:`/clients/edit`},
    ]

    const { state, dispatch } = useAppContext()
    const [client, setClient] = useState<Client>({
        id: 0,
        business_name: '', 
        tax_id: '', 
        email: '', 
        phone_number: '', 
        address: '',
        type_id: 2
    })

    const navigate = useNavigate()

    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target

        setClient({
            ...client, 
            [name]: value
        })
    }

    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()
    
        try {
            const newClient = await updateClient(+id!, client)

            if(!newClient) return

            const newClients = state.clients.map((client) => {
                if(client.id === newClient.id) {
                    return newClient
                }
    
                return client
            })

            dispatch({ type: 'set-clients', paypload: { clients : newClients } })
            navigate('/clients')
        } catch (error) {
            console.error(error)    
        }
    }
    
    const isDisable = useMemo(() => 
        isNullOrEmpty(client.business_name), [client])

    useEffect(() => {
        if(id && state.clients.length > 0) {
            const clientFound = state.clients.find((client) => client.id === +id!)
    
            if(clientFound) {
                setClient(clientFound)
            } else {
                navigate('/clients')
            }
        }
    }, [id, state.clients])

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Cliente</h1>
            
            <form onSubmit={onSubmit}>
                <button disabled={isDisable} className="btn btn-success">
                    <SaveIcon />
                    Guardar
                </button>
            
                <div className="grid grid-cols-3 mt-2">
                    <InputGroup name="business_name" label="Razón social" value={client.business_name} placeholder="Razón social" onChangeFnc={onChange} />
                    <InputGroup type="tel" name="phone_number" label="Número telefonico" value={client.phone_number ?? ''} placeholder="Ej. 81102933829" onChangeFnc={onChange} />
                    <InputGroup type="email" name="email" label="Correo de contacto" value={client.email ?? ''} placeholder="Ej. correo@correo.com" onChangeFnc={onChange} />
                    <InputGroup name="tax_id" label="RFC" value={client.tax_id ?? ''} placeholder="RFC" onChangeFnc={onChange} />
                    <InputGroup name="address" label="Dirección" value={client.address ?? ''} placeholder="Dirección" onChangeFnc={onChange} />
                </div>         
            </form>
        </>
    )
}
