import { ChangeEvent, FormEvent, useMemo, useState } from "react";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import SaveIcon from "../../components/shared/Icons/SaveIcon";
import InputGroup, { PushEvent } from "../../components/forms/InputGroup";
import { createClient } from "../../api/ClientApi";
import { isNullOrEmpty } from "../../utils";
import { useAppContext } from "../../hooks/AppContext";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import SelectGroup from "../../components/forms/SelectGroup";

export default function CreateClient() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Cartera de arrendatarios",url:'/clients'},
        {name:"Registrar arrendatario",url:'/clients/create'},
    ]

    const { state, dispatch } = useAppContext()
    const [client, setClient] = useState({
        business_name: '', 
        tax_id: '', 
        email: '', 
        phone_number: '', 
        address: '',
        type_id: 0
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
            const newClient = await createClient(client)
            dispatch({ type: 'set-clients', paypload: { clients : [...state.clients, newClient!] } })
            navigate('/clients')

            toast.success("Cliente creado correctamente")
        } catch (error) {
            console.error(error)    
        }
    }

    const isDisable = useMemo(() => 
        isNullOrEmpty(client.business_name), [client])

    const options = [
        {
            label: "Persona Moral", 
            value: 1
        },
        {
            label: "Persona Fisica", 
            value: 2
        },
    ]

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Arrendatario</h1>

            <form onSubmit={onSubmit}>
                <button disabled={isDisable} className="btn btn-success">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="grid grid-cols-3 mt-2">
                    <InputGroup name="business_name" label="Razón social" value={client.business_name} placeholder="Razón social" onChangeFnc={onChange} />
                    <InputGroup type="tel" name="phone_number" label="Número telefonico" value={client.phone_number} placeholder="Ej. 81102933829" onChangeFnc={onChange} />
                    <InputGroup type="email" name="email" label="Correo de contacto" value={client.email} placeholder="Ej. correo@correo.com" onChangeFnc={onChange} />
                    <InputGroup name="tax_id" label="RFC" value={client.tax_id} placeholder="RFC" onChangeFnc={onChange} />
                    <InputGroup name="address" label="Dirección" value={client.address} placeholder="Dirección" onChangeFnc={onChange} />
                    <SelectGroup name="type_id" label="Tipo de cliente" value={client.type_id} options={options} onChangeFnc={onChange} placeholder="Seleccione tipo" />
                </div>         
            </form>
        </>
    )
}
