import { useParams } from "react-router-dom"
import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from "react"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import SaveIcon from "../../components/shared/Icons/SaveIcon"
import InputGroup, { Option, PushEvent } from "../../components/forms/InputGroup"
import { getCities, getResidentialDevelopments, registerLand, updateLand } from "../../api/LandApi"
import { useNavigate } from "react-router-dom"
import { isNullOrEmpty } from "../../utils"
import { useAppContext } from "../../hooks/AppContext"
import { Land } from "../../types"
import { toast } from "react-toastify"
import Loader from "../../components/shared/Loader/Loader"
import SelectGroup from "../../components/forms/SelectGroup"
import { label } from "framer-motion/client"
import { formatToCurrency } from "../../utils"

export default function FormLand() {
    const { id } = useParams<{ id?: string }>()

    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Validar Terrenos",url:'/verify-lands'},
        {name:"Formulario Terreno",url:'/verify-lands/form-land'},
    ]

    const [residentialOptions, setResidentialOptions] = useState<Option[]>([])
    const [cityOptions, setCityOptions] = useState<Option[]>([])
    const [land, setLand] = useState<Land>({
        id: 0,
        cadastral_file: '', 
        area: 0,
        price_per_area: 0, 
        address: '', 
        residential_development_id: 0,
        municipio: 0,
        valor_catastral: 0,
        area_construida: 0,
        pago_predial: 0,
        global_status: 0,
        path_predial_file: '',
        name_last_update: ''
    })

    const { state, dispatch, isLoading } = useAppContext()

    const navigate = useNavigate()

    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        const { value, name } = e.target
    
        setLand({
            ...land, 
            [name]: value
        })
    }

    const onSubmit = async(e: FormEvent) => {
        e.preventDefault()
        land.pago_predial = parseFloat(String(land.pago_predial).replace(/[^0-9.]/g, ''));
        land.price_per_area = parseFloat(String(land.price_per_area).replace(/[^0-9.]/g, ''));
        land.valor_catastral = parseFloat(String(land.valor_catastral).replace(/[^0-9.]/g, ''));

        //toast.success("Sucedió un error al procesar" + land.pago_predial)

        try {
            if(land.id != 0)
            {
                
                const updatedLand = await updateLand(land)
                if (!updatedLand) {
                    toast.success("Sucedió un error al procesar")
                    return;
                }
                dispatch({
                    type: 'set-lands',
                    payload: {
                        lands: state.lands.map(l => l.id === updatedLand.id ? updatedLand : l)
                    }
                });
                //navigate('/lands')
                toast.success("Terreno actualizado correctamente ")
            }else{
                toast.success("Terreno creado correctamente")
            }
        } catch (error) {
            toast.success("Sucedió un error al procesar")
            console.log(error)
        }
    }

    const isDisable = useMemo(() => 
        isNullOrEmpty(land.cadastral_file) || isNullOrEmpty(land.residential_development_id) || isNullOrEmpty(land.address) || +land.area === 0 || +land.price_per_area === 0, [land])
    
    if(id != null)
    {
        useEffect(() => {

            const land = state.lands.find(land => land.id === +id!)
    
            if(!land) return
            
            //console.log(land)
    
            setLand(land)
        }, [id, state.lands])
        
    }
    const statusOptions = (): Option[] => [
        { label: 'PENDIENTE', value: 1 },
        { label: 'VALIDADO', value: 2 },
        { label: 'INACTIVO', value: 3 }
    ];
    //Carga las opciones para los fraccionamientos
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
            const dataCity = await getCities()
            const optionsCity = dataCity!.map(city => {
                return {
                    label: city.descripcion,
                    value: city.id  
                }
            })
            setCityOptions(optionsCity)
        }

        getInfo()
    }, [])
    

    if(isLoading) return <Loader />

    return (
        <>
            <Breadcrumb list={list} />
            {id ? <h1>Actualizar Terreno</h1> : <h1>Registrar Terreno</h1>}
            

            <div style={{ display: 'flex', gap: '20px',width: '100%' }}>
                {/* Formulario a la izquierda */}
                <form onSubmit={onSubmit}>
                    <button disabled={isDisable} type="submit" className="btn btn-success mb-4">
                        <SaveIcon />
                        Guardar
                    </button>
                    <div >
                        <InputGroup name="cadastral_file" label="Expediente Catastral" 
                                    value={land.cadastral_file} placeholder="Expediente Catastral" onChangeFnc={onChange} />
                        <InputGroup name="area" label="Área en m²" 
                                    value={land.area} placeholder="Área en m²" onChangeFnc={onChange} type='number' />
                        <InputGroup name="price_per_area" label="Precio por m²" 
                                    value={land.price_per_area} placeholder="Precio por m²" onChangeFnc={onChange} 
                                    type="currency" />
                        <InputGroup name="address" label="Dirección" 
                                    value={land.address} placeholder="Dirección" onChangeFnc={onChange} />
                        <SelectGroup 
                            name="residential_development_id" 
                            label="Fraccionamiento" 
                            value={land.residential_development_id} 
                            options={residentialOptions} 
                            placeholder="Fraccionamiento" 
                            onChangeFnc={onChange} 
                            />

                        <SelectGroup name="municipio" label="Municipio" 
                                    value={land.municipio ? land.municipio : 404} 
                                    options={cityOptions}
                                    placeholder="Municipio" onChangeFnc={onChange} />
                        
                        <InputGroup name="area_construida" label="Área Construida" 
                                    value={land.area_construida ? land.area_construida : 0} placeholder="Área Construida" onChangeFnc={onChange} />
                        <InputGroup name="valor_catastral" label="Valor Catastral" 
                                    value={land.valor_catastral ? land.valor_catastral : 0} placeholder="Pago Predial" onChangeFnc={onChange} 
                                    type="currency"/>
                        <InputGroup name="pago_predial" label="Pago Predial" 
                                    value={land.pago_predial ? land.pago_predial : 0} placeholder="Pago Predial" onChangeFnc={onChange} 
                                    type="currency"/>
                        <SelectGroup name="global_status" label="Estatus" 
                                    value={land.global_status ? land.global_status : 0} 
                                    options = {statusOptions()}
                                    placeholder="Estatus" onChangeFnc={onChange} />
                    </div>
                </form>

                {/* PDF a la derecha */}
                <div 
                    style={{
                        borderRadius: '8px',
                        overflow: 'hidden',
                        width: '100%',
                        minWidth: '500px', // Puedes ajustar esto si lo deseas
                        flex: 1,
                        minHeight: '500px',
                        display: 'flex',
                        flexDirection: 'column',
                        }}
                >
                    <label className="block mb-1 text-sm font-medium text-gray-700">Archivo Predial</label>
                    
                    {land.path_predial_file ? (
                        <div
                            style={{
                                border: '1px solid #ccc',
                                borderRadius: '8px',
                                overflow: 'hidden',
                                width: '100%',
                                flex: 1,
                                minHeight: '500px',
                                display: 'flex',
                                flexDirection: 'column',
                                position: 'sticky', // Hace que se quede fijo dentro del contenedor
                                top: '0', // Se mantiene en la parte superior del contenedor
                                zIndex: '10',
                            }}
                        >
                            <iframe
                                src={'/' + land.path_predial_file.replace(/\\/g, '/')}
                                title="Archivo PDF"
                                style={{
                                    width: '100%',
                                    height: '100%',
                                    border: 'none',
                                    flex: 1,
                                }}
                            />
                        </div>
                    ) : (
                        <p className="text-gray-500 italic">No contiene archivo ligado</p>
                    )}
                </div>
            </div>


        </>
    )
}
