import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { useAppContext } from '../../hooks/AppContext'
import { Condition, Project, ProjectView } from '../../types'
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb'
import { currencyFormat, dateFormat, isNullOrEmpty } from '../../utils'
import Loader from '../../components/shared/Loader/Loader'
import { toast } from 'react-toastify'
import InputGroup, { PushEvent } from '../../components/forms/InputGroup'
import LeaseRequestInformation from '../../components/LeaseRequest/LeaseRequestInformation'
import ListIcon from '../../components/shared/Icons/ListIcon'
import DocumentTextIcon from '../../components/shared/Icons/DocumentTextIcon'
import ActivitiesIcon from '../../components/shared/Icons/ActivitiesIcon'
import { getProjectById } from '../../api/ProjectApi'
import SaveIcon from '../../components/shared/Icons/SaveIcon'
import { getConditions } from '../../api/ConditionApi'
import SendIcon from '../../components/shared/Icons/SendIcon'

export default function FormFacturacion() {
    const { id } = useParams<{ id?: string }>()
    const navigate = useNavigate()
    const { isLoading } = useAppContext()
    const [conditions, setConditions] = useState<Condition[]>([])

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Administración",url:'/administration'},
        {name:"Facturación",url:`/administration/billing/${id}`},
    ]

    const { state } = useAppContext()
    const [project, setProject] = useState<Project>({
        id: 0,
        name: '',
        client: '',
        brand_id: 0,
        stage_id: 0,
        origitnator_id: 0,
        created_at: '',
        updated_at: '',
        lands: [],
        stage: { id: 0, name: '' },
        approvations: []

    })
    
    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()
        return; 
    }
    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target
    
        setProject({
            ...project, 
            [name]: value
        })
    }
    

    useEffect(() => {
        const getinfo = async () => {
            if (id) {
                
                const dataProject = await getProjectById(id)
                if (!dataProject) {
                    toast.error("No existe el proyecto seleccionado: " + id)
                    //navigate("/verify-projects")
                    return
                }
                setProject(dataProject)
                const [conditionsData] = await Promise.all([
                    getConditions()
                ])
                if (conditionsData) setConditions(conditionsData)
                //toast.success('Proyecto: ' + dataProject.id)
            }
        }
        getinfo()
    }, [id])

    if (isLoading || !project) return <Loader />
   return(
    <>
        <Breadcrumb list={list} />
        {id ? <h1>{project.name}</h1> : <h1>Registrar Interesado</h1>}
        <p className='date'>Fecha: {new Date().toLocaleDateString('es-MX', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        })}</p>
        <div>
            <label >¿Facturado?   </label>
            <select id="facturado" name="facturado">
                <option value="">NO</option>
                <option value="si">SI</option>
            </select>
        </div>
      


        <p className='mt-1'>Estatus: Pendiente Formato</p>
        <div className='w-full flex g-1'>
            <button className='btn btn-primary w-max'>
                <SaveIcon />
                Save Changes
            </button>
            <button className='btn btn-primary w-max'>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 24 24">
                    <path d="M5 20h14v-2H5v2zm7-18l-7 7h4v6h6v-6h4l-7-7z"/>
                </svg>
                Descargar Ficha de Primera Renta
            </button>
            <button className='btn btn-primary w-max'>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 24 24">
                    <path d="M5 20h14v-2H5v2zm7-18l-7 7h4v6h6v-6h4l-7-7z"/>
                </svg>
                Descargar Ficha de Seguimiento
            </button >
            <button  className='btn btn-success w-max'>
                <SendIcon />
                Enviar a firmas
            </button>
        </div>
       
        
        <h2 className='mt-2'>I. Generales</h2>
        <div className='grid grid-cols-2'>
            <div className='condition-container'>
                <label htmlFor="owner">Arrendador</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Cesión de Renta</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Razón Social Cliente</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Nombre Comercial</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Fraccionamiento</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Expediente Catastral</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Nombre del Proyecto</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Ubicación</label>
                <input type="text" disabled />
            </div>

        </div>
        <h2 className='mt-2'>II. Datos del Contrato</h2>
        <div className='grid grid-cols-2'>
            <div className='condition-container'>
                <label htmlFor="owner">No. Contrato ENKONTROL</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Fecha de Firma</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Vigencia (Años)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Periodo de Gracia (Meses)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">A partir de la entrega del inmueble</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Inicio de Periodo de gracia (MM/AA)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Final de Periodo de Gracia (MM/AA)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Fecha de Apertura</label>
                <input type="text" disabled />
            </div>
        </div>
        <h2 className='mt-2'>III. Detalle de Arrendamiento</h2>
        <div className='grid grid-cols-2'>
            <div className='condition-container'>
                <label htmlFor="owner">Mes de la primera Factura</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Superficie Arrendada</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Mecánica de Renta</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Mes en que se actualiza</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Mes de INCP</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Renta total sin IVA</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">IVA 16%</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Renta Total con IVA (CONTRATO)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Tipo de renta</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Precio por M2</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Actualización ANUAL a partir de</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Mecánica de incremento</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Factor de Actualización</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Renta actualizada a Facturar sin IVA</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">IVA 16%</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Renta actualizada a facturar con IVA</label>
                <input type="text" disabled />
            </div>
        </div>
        <h2 className='mt-2'>IV. Pagos realizados a la firma</h2>
        <div className='grid grid-cols-2'>
            <div className='condition-container'>
                <label htmlFor="owner">Deposito en Garantía (Meses)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Deposito en Garantía (Pesos)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Fecha de deposito</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Rentas anticipadas (Pesos)</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Fecha del Deposito</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Meses que se cubren con la renta anticipada</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Mes de primer factura</label>
                <input type="text" disabled />
            </div>
        </div>
        <h2 className='mt-2'>V. Contrato</h2>
        <div >
            <button className='btn btn-primary w-max'>
                <SaveIcon />
                Cargar Foto
            </button>
            <div style={{ display: 'flex', alignItems: 'center', marginTop: '1rem', gap: '0.5rem' }}>
                <img src="/test.png" alt="Descripción"  />
                
                <button style={{ background: 'none', border: 'none', cursor: 'pointer', width: '100px' }} title="Eliminar">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#d00000" viewBox="0 0 24 24">
                    <path d="M18.3 5.71L12 12l6.3 6.29-1.41 1.42L12 13.41l-6.29 6.3-1.42-1.42L10.59 12 4.29 5.71 5.71 4.29 12 10.59l6.29-6.3z"/>
                </svg>
                </button>
            </div>
        </div>

        <h2 className='mt-2'>Importe Actualizado del Deposito en Garantía </h2>
        <div>
            <div className='condition-container'>
                <label htmlFor="owner">Importe Actualizado del Deposito en Garantía</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Incremento Por Actualización del Deposito</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Importe Actualizado del Deposito en Garantía</label>
                <input type="text" disabled />
            </div>
            <div className='condition-container'>
                <label htmlFor="owner">Fecha de Deposito</label>
                <input type="text" disabled />
            </div>
        </div>
        <h2 className='mt-2'>Cálculo Historico </h2>
        <div>
            <table>
                <thead>
                <tr>
                    <th>AÑO</th>
                    <th>MES</th>
                    <th>FACTOR</th>
                    <th>INCREMENTO</th>
                    <th>RENTA ACTUALIZADA</th>
                    <th>% COBRO</th>
                    <th>RENTA A COBRAR</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>2022 JULIO</td>
                    <td></td>
                    <td></td>
                    <td >$115,000.00</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>2023 JULIO</td>
                    <td>5.06%</td>
                    <td >$5,819.00</td>
                    <td >$120,819.00</td>
                    <td>80%</td>
                    <td >$96,655.20</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>2024 JULIO</td>
                    <td>4.98%</td>
                    <td >$6,016.79</td>
                    <td >$126,835.79</td>
                    <td>90%</td>
                    <td >$114,152.21</td>
                </tr>
                </tbody>
            </table>
        </div>
        <br/><br/><br/>
    </>
    
   )
    
}
