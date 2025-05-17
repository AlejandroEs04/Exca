import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import InputGroup, { Option, PushEvent } from "../../components/forms/InputGroup"
import { getResidentialDevelopments, registerLand } from "../../api/LandApi"
import { useNavigate } from "react-router-dom"
import { isNullOrEmpty } from "../../utils"
import { useAppContext } from "../../hooks/AppContext"
import { LandCreate } from "../../types"
import { toast } from "react-toastify"
import Loader from "../../components/shared/Loader/Loader"

export default function CreateLand() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Inventarios de terrenos",url:'/lands'},
        {name:"Registrar Terreno",url:'/lands/create'},
    ]

    const [residentialOptions, setResidentialOptions] = useState<Option[]>([])
    const [land, setLand] = useState<LandCreate>({
        cadastral_file: '', 
        area: 0,
        build_area: 0,
        price_per_area: 0, 
        address: '', 
        cadastral_value: 0,
        predial_payment: 0,
        residential_development_name: '',
        city: '',
        state: ''
    })

    const { state, dispatch, isLoading } = useAppContext()

    const navigate = useNavigate()

    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target
    
        setLand({
            ...land, 
            [name]: value
        })
    }

    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()

        try {
            const newLand = await registerLand(land)
            dispatch({ type: 'set-lands', paypload: { lands : [...state.lands, newLand!] } })
            navigate('/lands')

            toast.success("Terreno creado correctamente")
        } catch (error) {
            console.log(error)
        }
    }

    const isDisable = useMemo(() => 
        isNullOrEmpty(land.cadastral_file) || isNullOrEmpty(land.residential_development_name) || isNullOrEmpty(land.address) || +land.area === 0 || +land.price_per_area === 0, [land])

    useEffect(() => {
        const getInfo = async() => {
            const data = await getResidentialDevelopments()
            const options = data!.map(residential => {
                return {
                    label: residential.name,
                    value: residential.id
                }
            })
            setResidentialOptions(options)
        }

        getInfo()
    }, [])

    if(isLoading) return <Loader />

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Terreno</h1>

            <form onSubmit={onSubmit}>
                <button disabled={isDisable} type="submit" className="btn btn-primary">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="grid grid-cols-3 mt-2 g-1">
                    <InputGroup name="cadastral_file" label="Expediente Catastral" value={land.cadastral_file} placeholder="Expediente Catastral" onChangeFnc={onChange} />
                    <InputGroup name="area" label="Superficie en m2" value={land.area} placeholder="Área en m2" onChangeFnc={onChange} type='number' />
                    <InputGroup name="build_area" label="Superficie en constuccion m2" value={land.build_area} placeholder="Superficie en m2" onChangeFnc={onChange} type='number' />
                    <InputGroup name="price_per_area" label="Precio por m2" value={land.price_per_area} placeholder="Precio por m2" onChangeFnc={onChange} type='number' />
                    <InputGroup name="address" label="Dirección" value={land.address} placeholder="Dirección" onChangeFnc={onChange} />
                    <InputGroup name="cadastral_value" label="Valor Catastral" type="number" value={land.cadastral_value!} placeholder="Valor Catastral" onChangeFnc={onChange} />
                    <InputGroup name="predial_payment" label="Pago Predial" type="number" value={land.predial_payment!} placeholder="Pago Predial" onChangeFnc={onChange} />
                </div>

                <h2 className="mt-2">Informacion del fraccionamiento</h2>

                <div className="grid grid-cols-3 g-1 mt-1">
                    <InputGroup name="residential_development_name" label="Fraccionamiento" value={land.residential_development_name} placeholder="Fraccionamiento" onChangeFnc={onChange} />
                    <InputGroup name="state" label="Estado" value={land.state} placeholder="Estado" onChangeFnc={onChange} />
                    <InputGroup name="city" label="Municipio" value={land.city} placeholder="Municipio" onChangeFnc={onChange} />
                </div>
            </form> 
        </>
    )
}
