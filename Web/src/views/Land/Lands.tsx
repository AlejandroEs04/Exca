import { Link } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import PlusIcon from "../../components/shared/Icons/PlusIcon";
import { useAppContext } from "../../hooks/AppContext";
import Loader from "../../components/shared/Loader/Loader";
import EyeIcon from "../../components/shared/Icons/EyeIcon";

export default function Lands() {
    const list = [
        { name: "Dashboard", url: '/' },
        { name: "Inventario de terrenos", url: '/lands' },
    ];

    const { state, isLoading } = useAppContext();

    if (isLoading) return <Loader />;

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Inventario de terrenos</h1>

            <Link to={'create'} className="btn btn-primary">
                <PlusIcon />
                Registrar
            </Link>

            <table className="mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Fraccionamiento</th>
                        <th>Ciudad</th>
                        <th>Estado</th>
                        <th>Expediente Catastral</th>
                        <th>Superficie del terreno</th>
                        <th>Estado actual</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    {state.lands.map((land) => (
                        <tr key={land.id}>
                            <td>{land.id}</td>
                            <td>{land.residential_development?.name}</td>
                            <td>{land.residential_development?.city}</td>
                            <td>{land.residential_development?.state}</td>
                            <td>{land.cadastral_file}</td>
                            <td>{land.area}</td>
                            <td>{land.status_id}</td>
                            <td>
                                <div className="table-actions">
                                    <Link to={`/lands/${land.id}`} className="text-indigo"><EyeIcon /></Link>
                                </div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    );
}