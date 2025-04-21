import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import InputGroup, { PushEvent } from "../../components/forms/InputGroup"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import { useAppContext } from "../../hooks/AppContext"
import SelectGroup from "../../components/forms/SelectGroup"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { currencyFormat } from "../../utils"

type RentLand = {
    land_id: number
    area: number
}

export default function CreateProject() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Registrar Proyecto",url:'/projects/create'},
    ]

    const { state } = useAppContext()
    const [project, setProject] = useState({
        name: '', 
        client: '',
        brand: ''
    })
    const [lands, setLands] = useState<RentLand[]>([])

    const companiesOptions = state.companies.map(company => {
        return {
            label: company.business_name,
            value: company.id
        }
    })

    const landsOptions = state.lands.map(land => {
        return {
            label: land.cadastral_file,
            value: land.id
        }
    })

    const [cadastralFile, setCadastralFile] = useState({
        land_id: 0, 
        area: 0
    })

    const onChangeProject = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target
        setProject({
            ...project, 
            [name]: value
        })
    }

    const onChangeCadastralFile = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target

        setCadastralFile({
            ...cadastralFile, 
            [name]: +value
        })
    }

    const addLand = (newLand: RentLand) => {
        const landExists = lands.find(land => land.land_id === newLand.land_id)

        if (landExists) {
            setLands(lands.map(land => land.land_id === newLand.land_id ? newLand : land))
        } else {
            setLands([...lands, newLand])
        }
    }

    const areaDisable = useMemo(() => cadastralFile.land_id === 0, [cadastralFile.land_id])

    const onSubmit = (e: FormEvent) => {
        e.preventDefault()

        try {
            const newProject = {

            }
        } catch (error) {
            console.log(error)
        }
    }

    useEffect(() => {
        setCadastralFile({
            ...cadastralFile, 
            area: state.lands.find(land => +land.id === +cadastralFile.land_id)?.area || 0
        })
    }, [cadastralFile.land_id])

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Proyecto</h1>

            <form>
                <button className="btn btn-success">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="mt-1">
                    <InputGroup name="name" label="Nombre" value={project.name} placeholder="Nombre del proyecto" onChangeFnc={onChangeProject} />
                </div>

                <div className="grid grid-cols-2 mt-2">
                    <InputGroup name="client" label="Razón social" value={project.client} placeholder="Razón social" onChangeFnc={onChangeProject} options={companiesOptions} />
                    <InputGroup name="brand" label="Marca" value={project.brand} placeholder="Nombre de la marca" onChangeFnc={onChangeProject} />
                </div>

                <div className="grid grid-cols-2 mt-2">
                    <SelectGroup name="land_id" label="Expediente Catastral" value={cadastralFile.land_id} placeholder="Seleccione un terreno" onChangeFnc={onChangeCadastralFile} options={landsOptions} />
                    <InputGroup name="area" label="Superficie arrendamiento" value={cadastralFile.area} placeholder="Superficie. ej. 180" onChangeFnc={onChangeCadastralFile} disable={areaDisable} /> 
                </div>

                <button className="btn btn-sm btn-primary mt-1" onClick={() => addLand(cadastralFile)} type="button">
                    <PlusIcon />
                    Agregar
                </button>

                <table className="mt-1">
                    <thead>
                        <tr>
                            <th>Expediente Catastral</th>
                            <th>Precio/m<sup>2</sup></th>
                            <th>Metros<sup>2</sup></th>
                            <th>Renta mensual</th>
                        </tr>
                    </thead>

                    <tbody>
                        {lands.map(land => (
                            <tr key={land.land_id}>
                                <td>{state.lands.find(l => l.id === land.land_id)?.cadastral_file}</td>
                                <td>{currencyFormat(state.lands.find(l => l.id === land.land_id)?.price_per_area!)}</td>
                                <td>{land.area}</td>
                                <td>{currencyFormat(+((state.lands.find(l => l.id === land.land_id)?.price_per_area || 0) * land.area).toFixed(2))}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </form>
        </>
    )
}
