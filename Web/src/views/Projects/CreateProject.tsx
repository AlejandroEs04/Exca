import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import InputGroup, { Option, PushEvent } from "../../components/forms/InputGroup"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import { useAppContext } from "../../hooks/AppContext"
import SelectGroup from "../../components/forms/SelectGroup"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { currencyFormat } from "../../utils"
import { getResidentialDevelopments } from "../../api/LandApi"
import { ProjectCreate, ProjectLandCreate, ResidentialDevelopment } from "../../types"
import { getProjectLandTypes, registerProject } from "../../api/ProjectApi"
import { useLocation, useNavigate, useSearchParams } from "react-router-dom"
import { toast } from "react-toastify"
import Loader from "../../components/shared/Loader/Loader"
import ComboBox, { OptionCB } from "../../components/forms/ComboBox"
import { createBrand } from "../../api/ClientApi"

export default function CreateProject() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Registrar Proyecto",url:'/projects/create'},
    ]

    const { state, dispatch, isLoading } = useAppContext()
    const [project, setProject] = useState<ProjectCreate>({
        brand_id: undefined,
        lands: []
    })
    const [clientId, setClientId] = useState(0)
    const [residential, setResidential] = useState('')
    const [residentialOptions, setResidentialOptions] = useState<Option[]>([])
    const [residentialDevelopments, setResidentialDevelopments] = useState<ResidentialDevelopment[]>([])
    const [landOptions, setLandOptions] = useState<Option[]>([])
    const [rentOptions, setRentOptions] = useState<Option[]>([])
    const [brands, setBrands] = useState<OptionCB[]>([])
    const navigate = useNavigate()
    const { pathname } = useLocation()
    const [searchParams] = useSearchParams();

    const clientsOptions = state.clients.map(client => {
        return {
            label: client.business_name,
            id: client.id
        }
    })

    const [cadastralFile, setCadastralFile] = useState<ProjectLandCreate>({
        land_id: 0, 
        area: 0,
        type_id: 0, 
        build_area: 0
    })

    const onChangeCadastralFile = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target

        setCadastralFile({
            ...cadastralFile, 
            [name]: +value
        })
    }

    const onChangeResidential = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value } = e.target
        if(project.lands.length > 0) return
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

    const addLand = (newLand: ProjectLandCreate) => {
        const landExists = project.lands.find(land => land.land_id === newLand.land_id)

        if (landExists) {
            setProject({
                ...project, 
                lands: project.lands.map(land => land.land_id === newLand.land_id ? newLand : land)
            })
        } else {
            setProject({
                ...project, 
                lands: [...project.lands, {...newLand}]
            })
        }
    }

    const areaDisable = useMemo(() => cadastralFile.land_id === 0, [cadastralFile.land_id])
    const landsSelectDisable = useMemo(() => landOptions.length === 0, [landOptions])
    const submitDisable = useMemo(() => {
        return project.brand_id === 0 || project.lands.length === 0
    }, [project])

    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()

        try {
            const newProject = await registerProject(project)
            dispatch({ type: 'set-projects', payload: { projects: [...state.projects, newProject] }})
            navigate('/projects')

            toast.success("Projecto creado correctamente")
        } catch (error) {
            console.log(error)
        }
    }

    const handleSelect = (id: string | number, name: string) => {
        switch (name) {
            case 'client':
                setClientId(+id)
                break;
            case 'brand':
                setProject({
                    ...project, 
                    brand_id: +id
                })
        }
    };

    const handleCreate = async(newLabel: string, name: string) => {
        switch (name) {
            case 'client':
                localStorage.setItem('createProjectLocal', JSON.stringify(project))

                navigate(`/clients/create?business_name=${newLabel}&return_url=${pathname}`)
                break;
            case 'brand':
                const newBrand = await createBrand({ name: newLabel, client_id: clientId })

                if(newBrand) {
                    dispatch({ type: 'set-clients', payload: { clients: state.clients.map(c => c.id === clientId ? { ...c, brands: [...c.brands!, newBrand] } : c) } })

                    setProject({
                        ...project, 
                        brand_id: newBrand.id
                    })
                }
                break;
        }
    };

    useEffect(() => {
        setCadastralFile({
            ...cadastralFile, 
            area: state.lands.find(land => +land.id === +cadastralFile.land_id)?.area || 0, 
            build_area: state.lands.find(land => +land.id === +cadastralFile.land_id)?.area || 0, 
        })
    }, [cadastralFile.land_id])

    useEffect(() => {   
        const clientSelected = state.clients.find(c => c.id === clientId)

        const brandsOptions : OptionCB[] = clientSelected?.brands?.map(b => {
            return {
                id: b.id, 
                label: b.name
            }
        }) ?? []

        setBrands(brandsOptions)
    }, [clientId, state.clients])

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
        const backCreate = searchParams.get('back_create')

        if(backCreate) {
            const itemSavedStr = localStorage.getItem('createProjectLocal')

            if(itemSavedStr) {
                setProject(JSON.parse(itemSavedStr))

                const itemName = searchParams.get('item_name')
                const itemId = searchParams.get('item_id')

                if(itemName && itemId) {
                    switch(itemName) {
                        case 'client':
                            setClientId(+itemId)
                            break;
                    }
                }
            }
        }
    
        getInfo()
    }, [])

    if(isLoading) return <Loader />

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Registrar Proyecto</h1>

            <form onSubmit={onSubmit}>
                <button disabled={submitDisable} className="btn btn-primary">
                    <SaveIcon />
                    Guardar
                </button>

                <div className="grid grid-cols-2 mt-2 g-1">
                    <ComboBox 
                        name="client" 
                        value={clientId} 
                        options={clientsOptions} 
                        placeholder="Razón social" 
                        label="Razón social" 
                        onCreate={handleCreate}
                        onSelect={handleSelect} />
                    <ComboBox 
                        disabled={clientId === 0}
                        name="brand" 
                        value={project.brand_id ?? 0} 
                        options={brands} 
                        placeholder="Nombre comercial" 
                        label="Nombre comercial" 
                        onCreate={handleCreate}
                        onSelect={handleSelect} />
                </div>

                <div className="mt-2">
                    <SelectGroup value={residential} name="residentialId" label="Fraccionamiento" placeholder="Seleccione un fraccionamiento" onChangeFnc={onChangeResidential} options={residentialOptions} />
                </div>

                <div className="grid grid-cols-3 g-1 mt-2">
                    <SelectGroup disable={landsSelectDisable} name="land_id" label="Expediente Catastral" value={cadastralFile.land_id} placeholder="Seleccione un terreno" onChangeFnc={onChangeCadastralFile} options={landOptions} />
                    <InputGroup limit={cadastralFile.area} name="area" label="Superficie arrendamiento" value={cadastralFile.area} placeholder="Superficie. ej. 180" onChangeFnc={onChangeCadastralFile} disable={areaDisable} /> 
                    <SelectGroup disable={areaDisable} name="type_id" label="Tipo de arrendamiento" value={cadastralFile.type_id!} placeholder="Seleccione un tipo" onChangeFnc={onChangeCadastralFile} options={rentOptions} />
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
                        {project.lands.map(land => (
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
