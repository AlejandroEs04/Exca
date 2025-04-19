import { Link } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import PlusIcon from "../../components/shared/Icons/PlusIcon";
import { useAppContext } from "../../hooks/AppContext";

export default function Lands() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Terrenos",url:'/lands'},
    ]

    const { state } = useAppContext()

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Proyectos</h1>
            
            <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Expediente Catastral</th>
                        <th>Área en m2</th>
                        <th>Precio por m2</th>
                        <th>Fraccionamiento</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {state.lands.map((land) => (
                        <tr key={land.id}>
                            <td>{land.id}</td>
                            <td>{land.cadastral_file}</td>
                            <td>{land.area}</td>
                            <td>{land.price_per_area}</td>
                            <td>{land.residential_development}</td>
                            <td></td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
