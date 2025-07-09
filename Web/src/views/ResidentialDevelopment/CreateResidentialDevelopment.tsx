import { ChangeEvent, FormEvent, useEffect, useMemo, useState } from 'react'
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb'
import SelectGroup, { Option } from '../../components/forms/SelectGroup';
import { getStates } from '../../api/StateApi';
import { getCities } from '../../api/CityApi';
import { City } from '../../types';
import { handleFormChange } from '../../utils/onChange';
import InputGroup from '../../components/forms/InputGroup';
import SaveIcon from '../../components/shared/Icons/SaveIcon';
import { handleError, isNullOrEmpty } from '../../utils';
import { createResidentialDevelopment } from '../../api/ResidentialDevelopmentApi';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { toast } from 'react-toastify';

export default function CreateResidentialDevelopment() {
    const breadcrumbList = [
        { name: "Dashboard", url: "/" },
        { name: "Fraccionamientos", url: "/residential-development" },
        { name: "Crear Fraccionamiento", url: "/residential-development/create" },
    ];

    const [searchParams] = useSearchParams();
    const navigate = useNavigate()
    const [states, setStates] = useState<Option[]>([])
    const [cities, setCities] = useState<City[]>([])
    const [citiesOptions, setCitiesOptions] = useState<Option[]>([])
    const [residentialDevelopment, setResidentialDevelopment] = useState({
        name: '', 
        city_id: 0, 
        state_id: 0
    })

    const handleChange = (e : ChangeEvent<HTMLElement>) => handleFormChange(e, residentialDevelopment, setResidentialDevelopment)

    const isDisable = useMemo(() => 
        isNullOrEmpty(residentialDevelopment.name) || +residentialDevelopment.state_id === 0 || +residentialDevelopment.city_id === 0, [residentialDevelopment])

    const handleSubmit = async(e: FormEvent) => {
        e.preventDefault();

        try {
            const newResidentialDevelopment = await createResidentialDevelopment(residentialDevelopment);
        
            const returnUrl = searchParams.get('return_url')

            if(returnUrl) {
                navigate(`${returnUrl}?back_create=true&item_name=residentialDevelopment&item_id=${newResidentialDevelopment?.id}`)
            } else {
                navigate('/residential-development')
            }
            
            toast.success("Cliente creado correctamente")
        } catch (error) {
            handleError(error, {
                defaultMessage: "Error al crear el fraccionamiento",
                validationMap: {
                    'name': 'Nombre del fraccionamiento',
                    'city_id': 'ID de la ciudad',
                    'state_id': 'ID del estado'
                }
            });
        }
    }

    useEffect(() => {
        Promise.all([
            getStates(),
            getCities()
        ]).then(([
            states = [], 
            cities = []
        ]) => {
            setStates(states.map(s => ({ label: s.descripcion, value: s.id })))
            setCities(cities)
        })

        const nameParam = searchParams.get('name')
        if(nameParam) setResidentialDevelopment({ ...residentialDevelopment, name: nameParam })
    }, [])

    useEffect(() => {
        const stateCities = cities.filter(c => c.id_estado === +residentialDevelopment.state_id)
        setCitiesOptions(stateCities.map(c => ({ label: c.descripcion, value: c.id })))
    }, [residentialDevelopment.state_id])

    return (
        <>
            <Breadcrumb list={breadcrumbList} />
            <h1>Crear Fraccionamiento</h1>

            <form onSubmit={handleSubmit}>
                <div className='grid g-1'>
                    <InputGroup id='name' onChangeFnc={handleChange} name='name' label='Nombre del fraccionamiento' value={residentialDevelopment.name} placeholder='Nombre del fraccionamiento' />
                    <SelectGroup id='state_id' onChangeFnc={handleChange} name='state_id' label='Estado' value={residentialDevelopment.state_id} options={states} placeholder='Selecciona un estado' />
                    <SelectGroup disable={+residentialDevelopment.state_id == 0} id='city_id' onChangeFnc={handleChange} name='city_id' label='Ciudad' value={residentialDevelopment.city_id} options={citiesOptions} placeholder='Selecciona una ciudad' />
                </div>

                <button disabled={isDisable} className="btn btn-success mt-1">
                    <SaveIcon />
                    Guardar
                </button>
            </form>
        </>
    )
}
