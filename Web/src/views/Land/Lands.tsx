import { Link } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import PlusIcon from "../../components/shared/Icons/PlusIcon";
import { useAppContext } from "../../hooks/AppContext";
import Loader from "../../components/shared/Loader/Loader";
import EyeIcon from "../../components/shared/Icons/EyeIcon";
import EditIcon from "../../components/shared/Icons/EditIcon";

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

            <Link to={'form-land'} className="btn btn-primary">
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
                        <th>Ex. Catastral</th>
                        <th>Area</th>
                        <th>Area Construida</th>
                        <th>Estatus</th>
                        <th>Acciones</th>

                    </tr>
                </thead>

                <tbody>
                    {state.lands.map((land) => (
                        <tr key={land.id}>
                        <td>{land.id}</td>
                        <td>{land.residential_development?.name}</td>
                        <td>{land.residential_development?.city.descripcion}</td>
                        <td>{land.residential_development?.state.descripcion}</td>
                        <td>{land.cadastral_file}</td>
                        <td>
                            {land.area
                            ?.toLocaleString('en-US', {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2,
                            })}
                            &nbsp;m²
                        </td>
                        <td>
                            {land.built_area
                            ?.toLocaleString('en-US', {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2,
                            })}
                            &nbsp;m²
                        </td>
                        <td>{land.land_status?.description ?? 'Not Found'}</td>
                        <td>
                            <div className="table-actions">
                            
                            <Link to={`form-land/${land.id}`} className="text-indigo">
                                <EditIcon />
                            </Link>
                            </div>
                        </td>
                        </tr>
                    ))}
                    </tbody>

            </table>
        </>
    );
}