import { useNavigate, useParams } from "react-router-dom"
import { useAppContext } from "../../hooks/AppContext"
import { useEffect, useState } from "react"
import { LandResponse as LandType } from "../../types"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import { currencyFormat } from "../../utils"

export default function Land() {
    const { id } = useParams()
    const { state } = useAppContext()
    const navigate = useNavigate()
    const [land, setLand] = useState<LandType>()

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Inventarios de terrenos",url:'/lands'},
        {name:"Terreno",url:`/lands/${id}`},
    ]

    useEffect(() => {
        if(state.lands.length) {
            const land = state.lands.find(l => l.id === +id!)
            if(!land) navigate(-1)
            setLand(land)
        }
    }, [state.lands])

    return (
        <>
            <Breadcrumb list={list} /> 
            <h1>Resumen del terreno</h1>
            <h3>Expediente Catastral: {land?.cadastral_file}</h3>  

            <div className="grid-summary mt-2 g-2">
                <div>
                    <h2>Información del predio</h2>
                    <div className="grid grid-cols-2 g-1 mt-1">
                        <div className="summary-info">
                            <p className="title">Superficie del terreno</p>
                            <p>{land?.area} m<sup>2</sup></p>
                        </div>
                        <div className="summary-info">
                            <p className="title">Superficie de construcción</p>
                            <p>{land?.build_area} m<sup>2</sup></p>
                        </div>
                        <div className="summary-info">
                            <p className="title">Precio por superficie</p>
                            <p>{currencyFormat(land?.price_per_area!)}</p>
                        </div>
                    </div>

                    <h2 className="mt-2">Servicios</h2>
                </div>

                <div>
                    <h2>Dirección</h2>
                    <table className="table-summary">
                        <tr>
                            <th>Municipio</th>
                            <td>{land?.city}</td>
                        </tr>
                        <tr>
                            <th>Estado</th>
                            <td>{land?.state}</td>
                        </tr>
                        <tr>
                            <th>Fraccionamiento</th>
                            <td>{land?.residential_development.name}</td>
                        </tr>
                        <tr>
                            <th>Dirección</th>
                            <td>{land?.address}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </>
    )
}
