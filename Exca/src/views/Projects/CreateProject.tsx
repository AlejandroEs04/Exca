import { ChangeEvent, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import InputGroup, { PushEvent } from "../../components/forms/InputGroup"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import { useAppContext } from "../../hooks/AppContext"

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
        business_name: ''
    })

    const companiesOptions = state.companies.map(company => {
        return {
            label: company.business_name,
            value: company.id
        }
    })

    const [cadastralFile, setCadastralFile] = useState({
        cadastral_file: '', 
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
            [name]: value
        })
    }

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
                    <InputGroup name="business_name" label="Razón social" value={project.business_name} placeholder="Razón social" onChangeFnc={onChangeProject} options={companiesOptions} />
                    <InputGroup name="client" label="Cliente" value={project.client} placeholder="Nombre del cliente" onChangeFnc={onChangeProject} />
                </div>

                <div className="grid grid-cols-2 mt-2">
                    <InputGroup name="cadastralFile" label="Expediente Catastral" value={cadastralFile.cadastral_file} placeholder="Expediente Catastral" onChangeFnc={onChangeCadastralFile} />
                    <InputGroup name="area" label="Superficie m2 de arrendamiento" value={cadastralFile.area} placeholder="Superficie. ej. 180" onChangeFnc={onChangeCadastralFile} /> 
                </div>

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

                    </tbody>
                </table>
            </form>
        </>
    )
}
