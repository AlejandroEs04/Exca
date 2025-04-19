import { ChangeEvent, FormEvent, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import InputGroup from "../../components/forms/InputGroup"
import { registerLand } from "../../api/LandApi"
import { useNavigate } from "react-router-dom"

export default function CreateLand() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Terrenos",url:'/lands'},
        {name:"Registrar Terreno",url:'/lands/create'},
    ]

    const [land, setLand] = useState({
        cadastral_file: '', 
        area: 0,
        price_per_area: 0, 
        address: '', 
        residential_development: ''
    })

    const navigate = useNavigate()

    const onChange = (e: ChangeEvent<HTMLInputElement>) => {
        const { value, name } = e.target
    
        setLand({
            ...land, 
            [name]: value
        })
    }

    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()

        try {
            await registerLand(land)
        } catch (error) {
            console.log(error)
        }
    }

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Terreno</h1>

            <form onSubmit={onSubmit}>
                <button type="submit" className="btn btn-success">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="grid grid-cols-3 mt-2">
                    <InputGroup name="cadastral_file" label="Expediente Catastral" value={land.cadastral_file} placeholder="Expediente Catastral" onChangeFnc={onChange} />
                    <InputGroup name="area" label="Área en m2" value={land.area} placeholder="Área en m2" onChangeFnc={onChange} type='number' />
                    <InputGroup name="price_per_area" label="Precio por m2" value={land.price_per_area} placeholder="Precio por m2" onChangeFnc={onChange} type='number' />
                    <InputGroup name="address" label="Dirección" value={land.address} placeholder="Dirección" onChangeFnc={onChange} />
                    <InputGroup name="residential_development" label="Fraccionamiento" value={land.residential_development} placeholder="Fraccionamiento" onChangeFnc={onChange} />
                </div>
            </form> 
        </>
    )
}
