import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from "react";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import SaveIcon from "../../components/shared/Icons/SaveIcon";
import InputGroup from "../../components/forms/InputGroup";
import { createClient } from "../../api/ClientApi";
import { handleError, isNullOrEmpty } from "../../utils";
import { useAppContext } from "../../hooks/AppContext";
import { useNavigate, useSearchParams } from "react-router-dom";
import { toast } from "react-toastify";
import SelectGroup from "../../components/forms/SelectGroup";
import { ClientCreate, ClientRoll } from "../../types";
import { handleFormChange } from "../../utils/onChange";
import { createClientRoll, getClientRolls } from "../../api/ClientRollApi";
import { label } from "framer-motion/client";
import ComboBox from "../../components/forms/ComboBox";

export default function CreateClient() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Cartera de arrendatarios",url:'/clients'},
        {name:"Registrar arrendatario",url:'/clients/create'},
    ]
    const [searchParams] = useSearchParams();
    const { state, dispatch } = useAppContext()
    const [client, setClient] = useState<ClientCreate>({
        business_name: '', 
        tax_id: '', 
        email: '', 
        phone_number: '', 
        address: {
            client_id: null,
            street: '', 
            city: '', 
            state: '', 
            country: '',
            postal_code: '',
            is_primary: true, 
        },
        turn_id: null,
        type_id: 0,
        roll_id: 0
    })

    const navigate = useNavigate()
    const onChange = (e: ChangeEvent<HTMLElement>) => handleFormChange(e, client, setClient)
    const [rolls, setRolls] = useState<ClientRoll[]>([])

    const onSubmit = async (e: FormEvent) => {
        e.preventDefault();

        try {
            const newClient = await createClient(client);
            dispatch({ type: 'set-clients', payload: { clients : [...state.clients, newClient!] } })

            const returnUrl = searchParams.get('return_url')
            if(returnUrl) {
                navigate(`${returnUrl}?back_create=true&item_name=client&item_id=${newClient?.id}`)
            } else {
                navigate('/clients')
            }

            toast.success("Cliente creado correctamente")
        } catch (error) {
            handleError(error, {
                defaultMessage: "Error al crear el cliente",
                validationMap: {
                    'email': 'Correo electrónico',
                    'turn_id': 'Giro de la empresa',
                    'address.client_id': 'ID de cliente'
                }
            });
        }
    };

    const isDisable = useMemo(() => 
        isNullOrEmpty(client.business_name), [client])

    const handleSelect = (id: string | number, name: string) => {
        setClient({
            ...client, 
            [name] : id
        })
    };
    
    const handleCreate = async(newLabel: string, name: string) => {
        switch(name) {
            case 'roll_id':
                try {
                    const newRoll = await createClientRoll({ name: newLabel })

                    if(!newRoll) return
    
                    setRolls([...rolls, newRoll])
                    setClient({
                        ...client, 
                        [name] : newRoll.id
                    })
                } catch (error) {   
                    console.log(error)
                }
                break;
        }    
    }
    
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

    useEffect(() => {
        const getInfo = async() => {
            const rollsApi = await getClientRolls()

            if(rollsApi) setRolls(rollsApi)
        }

        const nameParam = searchParams.get('business_name')
        
        if(nameParam) {
            setClient({
                ...client, 
                business_name: nameParam
            })
        }

        getInfo()
    }, [])

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Arrendatario</h1>

            <form onSubmit={onSubmit}>
                <div className="grid grid-cols-3 g-1 mt-1">
                    <InputGroup name="business_name" label="Razón social" value={client.business_name} placeholder="Razón social" onChangeFnc={onChange} />
                    <InputGroup type="tel" name="phone_number" label="Número telefonico" value={client.phone_number ?? ''} placeholder="Ej. 81102933829" onChangeFnc={onChange} />
                    <InputGroup type="email" name="email" label="Correo de contacto" value={client.email ?? ''} placeholder="Ej. correo@correo.com" onChangeFnc={onChange} />
                    <InputGroup name="tax_id" label="RFC" value={client.tax_id ?? ''} placeholder="RFC" onChangeFnc={onChange} />
                    <SelectGroup name="type_id" label="Tipo de cliente" value={client.type_id} options={options} onChangeFnc={onChange} placeholder="Seleccione tipo" />
                    <ComboBox 
                        name="roll_id" 
                        value={client.roll_id} 
                        options={rolls.map(r => ({ label: r.name, id: r.id }))} 
                        placeholder="Giro de la empresa" 
                        label="Giro de la empresa" 
                        onCreate={handleCreate}
                        onSelect={handleSelect} />
                </div>         
                
                <h2 className="mt-2">Dirección</h2>
                <div className="grid grid-cols-3 g-1">
                    <InputGroup name="address.street" label="Calle / Avenida" value={client.address.street} placeholder="Calle / Avenida" onChangeFnc={onChange} />
                    <InputGroup name="address.postal_code" label="Código Postal" value={client.address.postal_code} placeholder="Código Postal" onChangeFnc={onChange} />
                    <InputGroup name="address.city" label="Ciudad / Municipio" value={client.address.city} placeholder="Ciudad / Municipio" onChangeFnc={onChange} />
                    <InputGroup name="address.state" label="Estado" value={client.address.state} placeholder="Estado" onChangeFnc={onChange} />
                    <InputGroup name="address.country" label="País" value={client.address.country} placeholder="País" onChangeFnc={onChange} />
                </div>       

                <button disabled={isDisable} className="btn btn-success mt-2">
                    <SaveIcon />
                    Guardar
                </button>  
            </form>
        </>
    )
}
