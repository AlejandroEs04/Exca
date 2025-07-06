import { useParams } from "react-router-dom"
import { useAppContext } from "../../hooks/AppContext"
import { ChangeEvent, useEffect, useMemo, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import InputGroup, { PushEvent, Option } from "../../components/forms/InputGroup"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import SelectGroup from "../../components/forms/SelectGroup"
import { Land,Project, ResidentialDevelopment } from "../../types"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { currencyFormat } from "../../utils"
import { getResidentialDevelopments } from "../../api/LandApi"
import { getProjectLandTypes } from "../../api/ProjectApi"

export default function EditProject() {
    const { id } = useParams()
    
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Editar Proyecto",url:`/projects/edit/${id}`},
    ]

    const { state } = useAppContext()
    const [project, setProject] = useState<Project | null>(null)
    const [rentOptions, setRentOptions] = useState<Option[]>([])
    const [residentialOptions, setResidentialOptions] = useState<Option[]>([])
    const [residentialDevelopments, setResidentialDevelopments] = useState<ResidentialDevelopment[]>([])
    const [lands, setLands] = useState<Land[]>([])
    
    const clientsOptions = state.clients.map(client => {
        return {
            label: client.business_name || '', 
            value: client.id
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
        area: 0,
        type_id: 0
    })

    const onChangeProject = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target
        setProject({
            ...project!, 
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

    const addLand = (newLand: Land) => {
        const landExists = lands.find(land => land.id === newLand.id)

        if (landExists) {
            setLands(lands.map(land => land.id === newLand.id ? newLand : land))
        } else {
            setLands([...lands, newLand])
        }
    }

    const areaDisable = useMemo(() => cadastralFile.land_id === 0, [cadastralFile.land_id])

    useEffect(() => {
        const project = state.projects.find(project => project.id === +id!)

        if(!project) return

        setProject(project)
    }, [id, state.projects])

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

    if(!project) return <div>Cargando...</div>

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Editar Proyecto</h1>

            <form>
                <div className="mt-1">
                    <InputGroup name="name" label="Nombre" value={project.id || ''} placeholder="Nombre del proyecto" onChangeFnc={onChangeProject} />
                </div>
            
                <div className="grid grid-cols-2 mt-2">
                    <InputGroup name="client" label="Razón social" value={project.brand?.client?.business_name || ''} placeholder="Razón social" onChangeFnc={onChangeProject} options={clientsOptions} />
                    <InputGroup name="brand" label="Marca" value={project.brand?.name || ''} placeholder="Nombre de la marca" onChangeFnc={onChangeProject} />
                </div>
            
                <div className="grid grid-cols-2 mt-2">
                    <SelectGroup name="land_id" label="Expediente Catastral" value={cadastralFile.land_id} placeholder="Seleccione un terreno" onChangeFnc={onChangeCadastralFile} options={landsOptions} />
                    <InputGroup name="area" label="Superficie arrendamiento" value={cadastralFile.area} placeholder="Superficie. ej. 180" onChangeFnc={onChangeCadastralFile} disable={areaDisable} /> 
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
                            
                            <th>Metros<sup>2</sup></th>
                            
                        </tr>
                    </thead>
            
                    <tbody>
                        {lands.map(land => (
                            <tr key={land.land_id}>
                                <td>{state.lands.find(l => l.id === land.land_id)?.cadastral_file}</td>
                                <td>{land.area}</td>
                                
                            </tr>
                        ))}

                        {
                            /*
                        project.lands.map(land => (
                            <tr>
                                <td>{land.land.cadastral_file}</td>
                                <td>{land.area}</td>
                            </tr>
                        ))
                            */
                            }
                    </tbody>
                </table>

                <button className="btn btn-success mt-2">
                    <SaveIcon />
                    Guardar
                </button>
            </form>
        </>
    )
}
