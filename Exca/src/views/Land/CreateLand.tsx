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

export default function CreateLand() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Terrenos",url:'/lands'},
        {name:"Registrar Terreno",url:'/lands/create'},
    ]

    const [residentialOptions, setResidentialOptions] = useState<Option[]>([])
    const [land, setLand] = useState<LandCreate>({
        cadastral_file: '', 
        area: 0,
        price_per_area: 0, 
        address: '', 
        residential_development: ''
    })

    const { state, dispatch } = useAppContext()

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
        isNullOrEmpty(land.cadastral_file) || isNullOrEmpty(land.residential_development) || isNullOrEmpty(land.address) || +land.area === 0 || +land.price_per_area === 0, [land])

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

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Terreno</h1>

            <form onSubmit={onSubmit}>
                <button disabled={isDisable} type="submit" className="btn btn-success">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="grid grid-cols-3 mt-2">
                    <InputGroup name="cadastral_file" label="Expediente Catastral" value={land.cadastral_file} placeholder="Expediente Catastral" onChangeFnc={onChange} />
                    <InputGroup name="area" label="Área en m2" value={land.area} placeholder="Área en m2" onChangeFnc={onChange} type='number' />
                    <InputGroup name="price_per_area" label="Precio por m2" value={land.price_per_area} placeholder="Precio por m2" onChangeFnc={onChange} type='number' />
                    <InputGroup name="address" label="Dirección" value={land.address} placeholder="Dirección" onChangeFnc={onChange} />
                    <InputGroup name="residential_development" label="Fraccionamiento" value={land.residential_development} options={residentialOptions} placeholder="Fraccionamiento" onChangeFnc={onChange} />
                </div>
            </form> 
        </>
    )
}
