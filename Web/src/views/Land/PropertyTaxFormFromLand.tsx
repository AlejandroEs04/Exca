
// src/pages/PropertyTaxForm.tsx
import { useParams, useNavigate } from 'react-router-dom'
import { useEffect, useState, ChangeEvent, FormEvent } from 'react'
import { getPropertyTaxById, createPropertyTax, updatePropertyTax } from '../../api/PropertyTaxApi'
import type { PropertyTax } from '../../types'
import SelectGroup, { Option } from "../../components/forms/SelectGroup";
import InputGroup from '../../components/forms/InputGroup'
import SaveIcon from '../../components/shared/Icons/SaveIcon'
import {getPropertyTaxStatuses} from '../../api/PropertyTaxStatusApi';
import Loader from '../../components/shared/Loader/Loader';
import { useAppContext } from '../../hooks/AppContext';
import { toast } from 'react-toastify';
import Breadcrumb from '../../components/shared/Breadcrumb/Breadcrumb';

export default function PropertyTaxFormFromLand() {
  const { state, dispatch, isLoading } = useAppContext();
  const { land_id, propertyTaxId } = useParams<{ land_id: string; propertyTaxId?: string }>();
  const navigate = useNavigate();
  const breadcrumbList = [
    { name: "Dashboard", url: "/" },
    { name: "Inventario de propiedades", url: "/lands" },
    { name: land_id ? "Editar Terreno" : "Registrar Terreno", url: `/lands/form-land/${land_id}`},
    { name: propertyTaxId ? "Editar Predial" : "Registrar Predial", url: '#'},
  ];


  const [form, setForm] = useState<Partial<PropertyTax>>({
    tax_year: 0,
    cadastral_value: 0,
    cadastral_value_per_area: 0,
    cadastral_value_per_built_area: 0,
    receipt_file_url: '',
    tax_amount: 0,
    charges: 0,
    penalties: 0,
    other_charges: 0,
    total_tax: 0,
    discount: 0,
    bonuses: 0,
    others: 0,
    net_payable: 0,
    property_tax_estatus_id: undefined,
    verified_user_id: undefined,
  })
   const [propertyTaxStatusOptions, setpropertyTaxStatusOptions] = useState<Option[]>([]);
   useEffect(() => {
       Promise.all([
            getPropertyTaxStatuses(),
       ]).then(([
            statusesArr = [],
       ]) => {
            setpropertyTaxStatusOptions(statusesArr.map(st => ({ label: st.description, value: st.id })));
       });
     }, []);

  useEffect(() => {
    if (propertyTaxId) {
      getPropertyTaxById(+propertyTaxId).then(data => setForm(data))
    }
  }, [propertyTaxId])

  const handleChange = (
    e: ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>
  ) => {
    const { name, value, type } = e.target
    setForm(prev => ({
      ...prev,
      [name]:
        type === 'number'
          ? value === ''
            ? undefined
            : parseFloat(value)
          : value,
    }))
  }
  const handleSelect = (e: ChangeEvent<HTMLSelectElement>) => {
    const { name, value } = e.target;
    setForm(prev => ({ ...prev, [name]: Number(value ?? 0) }));
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault()
    if (!form.property_tax_estatus_id) {
      toast.error("Selecciona un Estatus");
      return;
    }

    
    const payload = {
        ...form,
        verified_user_id: state.auth?.id,
        land_id: +land_id!,
    }

    try {
      if (propertyTaxId) {
        await updatePropertyTax(+propertyTaxId, payload);
        toast.success("Predial actualizado con éxito");
      } else {
        await createPropertyTax({ ...payload, land_id: +land_id! });
        toast.success("Predial creado con éxito");
        navigate(`/lands/form-land/${land_id}`);
      }
    } catch (error: unknown) {
      let errorMessage = 'Error inesperado al crear el impuesto';

      if (error instanceof Error) {
        errorMessage = error.message;
      }

      toast.error(errorMessage);
    }
  }

  if (isLoading) return <Loader />;
  return (
    <div className="max-w-xl mx-auto p-4">
      <Breadcrumb list={breadcrumbList} />
     
      <h2 className="text-xl font-semibold mb-4">
        {propertyTaxId ? 'Editar Predial '  : 'Registrar Nuevo Predial'}

        
      </h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <InputGroup
                id="tax_year"
                name="tax_year"
                type="number"
                label="Año Fiscal"
                value={form.tax_year ?? 0}
                placeholder="AÑO"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="cadastral_value"
                name="cadastral_value"
                type="number"
                label="Valor Catastral"
                value={form.cadastral_value ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="cadastral_value_per_area"
                name="cadastral_value_per_area"
                type="number"
                label="Valor por m²"
                value={form.cadastral_value_per_area ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="cadastral_value_per_built_area"
                name="cadastral_value_per_built_area"
                type="number"
                label="Valor por m² construido"
                value={form.cadastral_value_per_built_area ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />
        </div>
        <hr className='mt-2 mb-2'/>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            
            
            <InputGroup
                id="tax_amount"
                name="tax_amount"
                type="number"
                label="Impuesto"
                value={form.tax_amount ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />
            <InputGroup
                id="charges"
                name="charges"
                type="number"
                label="Sanciones / Cargos"
                value={form.charges ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="penalties"
                name="penalties"
                type="number"
                label="Multas"
                value={form.penalties ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="other_charges"
                name="other_charges"
                type="number"
                label="Otros Cargos"
                value={form.other_charges ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="total_tax"
                name="total_tax"
                type="number"
                label="Total Impuesto"
                value={form.total_tax ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="discount"
                name="discount"
                type="number"
                label="Descuento"
                value={form.discount ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="bonuses"
                name="bonuses"
                type="number"
                label="Bonificaciones"
                value={form.bonuses ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="others"
                name="others"
                type="number"
                label="Otros"
                value={form.others ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />

            <InputGroup
                id="net_payable"
                name="net_payable"
                type="number"
                label="Neto a Pagar"
                value={form.net_payable ?? 0}
                placeholder="0.00"
                onChangeFnc={handleChange}
            />


            <SelectGroup 
            id="property_tax_estatus_id" 
            name="property_tax_estatus_id" 
            label="Estatus actual"
            
            value={form.property_tax_estatus_id ?? 0} 
            options={propertyTaxStatusOptions} 
            placeholder="Selecciona Estatus" 
            onChangeFnc={handleSelect} />
                      

            
            
            </div>
            {
                /*
            <InputGroup
                id="receipt_file_url"
                name="receipt_file_url"
                type="text"
                label="URL de Comprobante"
                value={form.receipt_file_url ?? ''}
                placeholder="https://..."
                onChangeFnc={handleChange}
            />
             */
            }
            {
                /*
                <InputGroup
                id="verified_user_id"
                name="verified_user_id"
                type="number"
                label="Usuario Verificador (ID)"
                value={form.verified_user_id ?? 0}
                placeholder="ID Usuario"
                onChangeFnc={handleChange}
            />
                */
            }

            <br/>
            <button type="submit" className="btn btn-primary">
                  <SaveIcon /> {propertyTaxId ? "Guardar" : "Registrar"}
            </button>
      </form>
    </div>
  )
}
