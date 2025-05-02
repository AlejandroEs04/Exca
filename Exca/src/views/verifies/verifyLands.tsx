import { Link } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import PlusIcon from "../../components/shared/Icons/PlusIcon";
import { useAppContext } from "../../hooks/AppContext";
import TrashIcon from "../../components/shared/Icons/TrashIcon";
import EditIcon from "../../components/shared/Icons/EditIcon";
import Loader from "../../components/shared/Loader/Loader";

export default function LandsToVerify() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Validar Terrenos",url:'/verify-lands'},
    ]

    const { state, isLoading } = useAppContext()

    if(isLoading) return <Loader />
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Validar Terrenos</h1>
            
            {
                /*
                
                <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>
                */

            }

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
                            <td>{land.residential_development.name}</td>
                            <td>
                                <div className="table-actions">
                                    <Link to={`/verify-lands/form-land/${land.id}`} className="text-blue"><EditIcon /></Link>
                                    <button className="text-red"><TrashIcon /></button>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}
