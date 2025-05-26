import { useNavigate, useSearchParams } from "react-router-dom";
import { useAppContext } from "../../../hooks/AppContext";
import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { IndividualCreate } from "../../../types";
import { handleFormChange } from "../../../utils/onChange";
import Breadcrumb from "../../../components/shared/Breadcrumb/Breadcrumb";
import InputGroup from "../../../components/forms/InputGroup";
import SaveIcon from "../../../components/shared/Icons/SaveIcon";
import { handleError } from "../../../utils";
import { toast } from "react-toastify";
import { createIndividuals } from "../../../api/IndividualApi";

export default function CreateIndividual() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Cartera de arrendatarios",url:'/clients'},
        {name:"Registrar arrendatario",url:'/clients/create'},
    ]
    const [searchParams] = useSearchParams();
    const { state, dispatch } = useAppContext()
    const [individual, setIndividual] = useState<IndividualCreate>({
        full_name: '', 
        tax_id: '',
        client_id: 0,
        address: {
            client_id: null,
            street: '', 
            city: '', 
            state: '',
            postal_code: '', 
            country: '', 
            is_primary: false
        }
    })

    const navigate = useNavigate()

    const handleChange = (e: ChangeEvent<HTMLElement>) => handleFormChange(e, individual, setIndividual)

    const handleSubmit = async(e: FormEvent) => {
        e.preventDefault()

        try {
            const newIndividual = await createIndividuals(individual);
            dispatch({ type: 'set-individual', payload: { individuals : [...state.individuals, newIndividual!] } })
        
            const returnUrl = searchParams.get('return_url')
            if(returnUrl) {
                navigate(`${returnUrl}?back_create=true&item_name=guarantee&item_id=${newIndividual?.id}`)
            } else {
                navigate(-1)
            }
        
            toast.success("Garantía creada correctamente")
        } catch (error) {
            handleError(error, {
                defaultMessage: "Error al crear el cliente",
                validationMap: {
                    'full_name': 'Nombre es obligatorio',
                    'tax_id': 'RFC es obligatorio'
                }
            });
        }
    }

    useEffect(() => {
        const clientId = searchParams.get('client_id')
        const fullName = searchParams.get('full_name')

        if(!clientId) navigate(-1)

        setIndividual({
            ...individual, 
            client_id: +clientId!,
            full_name: fullName ?? ''
        })
    }, [])

    return (
        <>
            <Breadcrumb list={list} />   
            <h1>Registrar Garantía</h1>
            
            <form onSubmit={handleSubmit}>
                <button className="btn btn-success">
                    <SaveIcon />
                    Guardar
                </button>
        
                <div className="grid grid-cols-3 mt-2 g-1">
                    <InputGroup name="full_name" label="Nombre completo" value={individual.full_name} placeholder="Nombre completo" onChangeFnc={handleChange} />
                    <InputGroup type="text" name="tax_id" label="RFC" value={individual.tax_id ?? ''} placeholder="RFC" onChangeFnc={handleChange} />
                </div>         
                            
                <h2 className="mt-2">Dirección del fraccionamiento</h2>
                    <div className="grid grid-cols-3 g-1">
                        <InputGroup name="address.street" label="Calle / Avenida" value={individual.address.street} placeholder="Calle / Avenida" onChangeFnc={handleChange} />
                        <InputGroup name="address.postal_code" label="Código Postal" value={individual.address.postal_code} placeholder="Código Postal" onChangeFnc={handleChange} />
                        <InputGroup name="address.city" label="Ciudad / Municipio" value={individual.address.city} placeholder="Ciudad / Municipio" onChangeFnc={handleChange} />
                        <InputGroup name="address.state" label="Estado" value={individual.address.state} placeholder="Estado" onChangeFnc={handleChange} />
                        <InputGroup name="address.country" label="País" value={individual.address.country} placeholder="País" onChangeFnc={handleChange} />
                    </div>         
                </form>
        </>
    )
}
