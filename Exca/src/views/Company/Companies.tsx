import { Link } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import PlusIcon from "../../components/shared/Icons/PlusIcon"
import { useAppContext } from "../../hooks/AppContext"

export default function Companies() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Empresas",url:'/companies'},
    ]

    const { state } = useAppContext()

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Clientes</h1>

            <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Razón Social</th>
                        <th>RFC</th>
                        <th>Contacto</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {state.companies.map((company) => (
                        <tr key={company.id}>
                            <td>{company.id}</td>
                            <td>{company.business_name}</td>
                            <td>{company.tax_id}</td>
                            <td>{company.email}</td>
                            <td></td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
