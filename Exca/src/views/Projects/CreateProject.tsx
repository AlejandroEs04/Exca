import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import InputGroup, { Option, PushEvent } from "../../components/forms/InputGroup"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import { useAppContext } from "../../hooks/AppContext"
import SelectGroup from "../../components/forms/SelectGroup"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { currencyFormat } from "../../utils"
import { getResidentialDevelopments } from "../../api/LandApi"
import { ProjectCreate, RentLand, ResidentialDevelopment } from "../../types"
import { getProjectLandTypes, registerProject } from "../../api/ProjectApi"
import { useNavigate } from "react-router-dom"
import { toast } from "react-toastify"

export default function CreateProject() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Registrar Proyecto",url:'/projects/create'},
    ]

    const { state, dispatch } = useAppContext()
    const [project, setProject] = useState({
        name: '', 
        client: '',
        brand: ''
    })
    const [lands, setLands] = useState<RentLand[]>([])
    const [residential, setResidential] = useState('')
    const [residentialOptions, setResidentialOptions] = useState<Option[]>([])
    const [residentialDevelopments, setResidentialDevelopments] = useState<ResidentialDevelopment[]>([])
    const [landOptions, setLandOptions] = useState<Option[]>([])
    const [rentOptions, setRentOptions] = useState<Option[]>([])
    const navigate = useNavigate()

    const clientsOptions = state.clients.map(client => {
        return {
            label: client.business_name,
            value: client.id
        }
    })

    const [cadastralFile, setCadastralFile] = useState({
        land_id: 0, 
        area: 0,
        type_id: 0, 
        initial_area: 0
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

    const onChangeResidential = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value } = e.target
        if(lands.length > 0) return
        setResidential(value.toString())
        const currentResidential = residentialDevelopments.find(residential => residential.id === +value);

        if (currentResidential) {
            const optionsLands = state.lands.filter(land => land.residential_development_id === currentResidential.id)

            if(optionsLands) {
                const options = optionsLands.map(land => {
                    return {
                        label: land.cadastral_file,
                        value: land.id
                    }
                })
                setLandOptions(options)
            }
        }
        else {
            setLandOptions([])
        }
    }

    const addLand = (newLand: RentLand) => {
        const landExists = lands.find(land => land.land_id === newLand.land_id)

        if (landExists) {
            setLands(lands.map(land => land.land_id === newLand.land_id ? newLand : land))
        } else {
            setLands([...lands, {...newLand}])
        }
    }

    const areaDisable = useMemo(() => cadastralFile.land_id === 0, [cadastralFile.land_id])
    const landsSelectDisable = useMemo(() => landOptions.length === 0, [landOptions])
    const submitDisable = useMemo(() => {
        return project.name === '' || project.client === '' || project.brand === '' || lands.length === 0
    }, [project, lands])

    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()

        try {
            const projectObj : ProjectCreate = {
                name: project.name,
                client: project.client,
                brand: project.brand,
                lands
            }

            const newProject = await registerProject(projectObj!)
            dispatch({ type: 'set-projects', paypload: { projects: [...state.projects, newProject] }})
            navigate('/projects')

            toast.success("Projecto creado correctamente")
        } catch (error) {
            console.log(error)
        }
    }

    useEffect(() => {
        setCadastralFile({
            ...cadastralFile, 
            area: state.lands.find(land => +land.id === +cadastralFile.land_id)?.area || 0, 
            initial_area: state.lands.find(land => +land.id === +cadastralFile.land_id)?.area || 0, 
        })
    }, [cadastralFile.land_id])

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
            setResidentialDevelopments(data!)

            const rentTypes = await getProjectLandTypes()
            const rentOptions = rentTypes!.map(t => {
                return {
                    label: t.name, 
                    value: t.id
                }
            })
            setRentOptions(rentOptions)
        }
    
        getInfo()
    }, [])

    console.log(rentOptions)

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Proyecto</h1>

            <form onSubmit={onSubmit}>
                <button disabled={submitDisable} className="btn btn-success">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="mt-1">
                    <InputGroup name="name" label="Nombre" value={project.name} placeholder="Nombre del proyecto" onChangeFnc={onChangeProject} />
                </div>

                <div className="grid grid-cols-2 mt-2">
                    <InputGroup name="client" label="Razón social" value={project.client} placeholder="Razón social" onChangeFnc={onChangeProject} options={clientsOptions} />
                    <InputGroup name="brand" label="Marca" value={project.brand} placeholder="Nombre de la marca" onChangeFnc={onChangeProject} />
                </div>

                <div className="mt-2">
                    <SelectGroup value={residential} name="residentialId" label="Fraccionamiento" placeholder="Seleccione un fraccionamiento" onChangeFnc={onChangeResidential} options={residentialOptions} />
                </div>

                <div className="grid grid-cols-3 g-1 mt-2">
                    <SelectGroup disable={landsSelectDisable} name="land_id" label="Expediente Catastral" value={cadastralFile.land_id} placeholder="Seleccione un terreno" onChangeFnc={onChangeCadastralFile} options={landOptions} />
                    <InputGroup limit={cadastralFile.initial_area} name="area" label="Superficie arrendamiento" value={cadastralFile.area} placeholder="Superficie. ej. 180" onChangeFnc={onChangeCadastralFile} disable={areaDisable} /> 
                    <SelectGroup disable={areaDisable} name="type_id" label="Tipo de arrendamiento" value={cadastralFile.type_id} placeholder="Seleccione un tipo" onChangeFnc={onChangeCadastralFile} options={rentOptions} />
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
                            <th>Tipo</th>
                        </tr>
                    </thead>

                    <tbody>
                        {lands.map(land => (
                            <tr key={land.land_id}>
                                <td>{state.lands.find(l => l.id === land.land_id)?.cadastral_file}</td>
                                <td>{currencyFormat(state.lands.find(l => l.id === land.land_id)?.price_per_area!)}</td>
                                <td>{land.area}</td>
                                <td>{currencyFormat(+((state.lands.find(l => l.id === land.land_id)?.price_per_area || 0) * land.area).toFixed(2))}</td>
                                <td>{rentOptions.find(r => r.value === land.type_id)?.label}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </form>
        </>
    )
}
