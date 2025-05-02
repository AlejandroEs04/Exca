import { useParams } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"

export default function LegalCase() {
    const { projectId } = useParams()
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Proyectos",url:'/projects'},
        {name:"Proyecto",url:`/projects/${projectId}`},
        {name:"Carátula legal",url:`/legal-case/${projectId}`},
    ]
    
    return (
        <>
            <Breadcrumb list={list} />
            <h1>Carátula Legal</h1>

            <div>
                <h2>Carátula Contrato</h2>
                <div>
                    <p>Fecha de Firma: </p>
                </div>
            </div>
        </>
    )
}
