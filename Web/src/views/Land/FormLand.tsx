// src/pages/lands/CreateOrEditLand.tsx
import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { Link, useLocation, useNavigate, useParams, useSearchParams } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import SaveIcon from "../../components/shared/Icons/SaveIcon";
import InputGroup from "../../components/forms/InputGroup";
import SelectGroup, { Option } from "../../components/forms/SelectGroup";
import { useAppContext } from "../../hooks/AppContext";
import { LandCreate, PropertyTax, ResidentialDevelopment } from "../../types";
import { toast } from "react-toastify";
import Loader from "../../components/shared/Loader/Loader";
import {
  registerLand,
  updateLand,
  getLandById,
  getPropertyTaxesByLandId
} from "../../api/LandApi";
import { getUsers } from "../../api/UserApi";
import { getResidentialDevelopments } from "../../api/ResidentialDevelopmentApi";
import { getLandTypes } from "../../api/LandTypeApi";
import { getLandCategories } from "../../api/LandCategoryApi";
import { getOwners } from "../../api/OwnerApi";
import PlusIcon from "../../components/shared/Icons/PlusIcon";
import EditIcon from "../../components/shared/Icons/EditIcon";
import { handleFormChange } from "../../utils/onChange";
import ComboBox, { OptionCB } from "../../components/forms/ComboBox";


type FormLand = LandCreate & {
  municipality_id?: number;
  state_id?: number;
  residential_development_id: number;
  land_type_id?: number;
  category_id?: number;
  owner_company_id?: number;
  tax_payer_company_id?: number;
  user_last_update_id?: number;
  status_id?: number;
  is_trust_owned: boolean;
  has_water_service: boolean;
  has_drainage_service: boolean;
  has_cfe_service: boolean;
};

export default function CreateOrEditLand() {
  const { id } = useParams();
  const { pathname } = useLocation()
  const isEditing = !!id;

  const breadcrumbList = [
    { name: "Dashboard", url: "/" },
    { name: "Inventario de terrenos", url: "/lands" },
    { name: isEditing ? "Editar Propiedad" : "Registrar Propiedad", url: "#" },
  ];
  const checkboxFields = [
    { name: "is_trust_owned", label: "¿Pertenece al Fideicomiso?" },
    { name: "has_water_service", label: "¿Tiene servicio de agua?" },
    { name: "has_drainage_service", label: "¿Tiene drenaje?" },
    { name: "has_cfe_service", label: "¿Tiene servicio CFE?" },
    ] as const;


  const { state, dispatch, isLoading } = useAppContext();
  const navigate = useNavigate();

  const initial: FormLand = {
    cadastral_file: "",
    block_lot: "",
    address: "",
    area: 0,
    built_area: 0,
    comments: "",
    notes: "",
    incorporation: "",
    incorporation_notes: "",
    residential_development_id: 0,
    municipality_id: undefined,
    state_id: undefined,
    land_type_id: undefined,
    category_id: undefined,
    owner_company_id: undefined,
    tax_payer_company_id: undefined,
    user_last_update_id: undefined,
    status_id: 1,
    is_trust_owned: false,
    has_water_service: false,
    has_drainage_service: false,
    has_cfe_service: false,
  };

  const [searchParams] = useSearchParams();
  const [land, setLand] = useState<FormLand>(initial);
  const [residentialOptions, setResidentialOptions] = useState<OptionCB[]>([]);
  const [typeOptions, setTypeOptions] = useState<Option[]>([]);
  const [categoryOptions, setCategoryOptions] = useState<Option[]>([]);
  const [companyOptions, setCompanyOptions] = useState<Option[]>([]);
  const [userOptions, setUserOptions] = useState<Option[]>([]);
  const [residentials, setResidentials] = useState<ResidentialDevelopment[]>([]);
  const [propertyTaxes, setPropertyTaxes] = useState<PropertyTax[]>([]);

  useEffect(() => {
    Promise.all([
      getResidentialDevelopments(),
      getLandTypes(),
      getLandCategories(),
      getOwners(),
      getUsers(),
    ]).then(([
      residentials = [],
      typesArr = [],
      catsArr = [],
      compsArr = [],
      usersArr = [],
    ]) => {
      setResidentials(residentials);
      setResidentialOptions(residentials.map(r => ({ label: r.name, id: r.id })));
      setTypeOptions(typesArr.map(t => ({ label: t.description, value: t.id })));
      setCategoryOptions(catsArr.map(c => ({ label: c.description, value: c.id })));
      setCompanyOptions(compsArr.map(c => ({ label: c.name, value: c.id })));
      setUserOptions(usersArr.map(u => ({ label: u.full_name, value: u.id })));
    });
  }, []);

  useEffect(() => {
    if (isEditing) {
      getLandById(+id!).then(data => {
        setLand({
          ...initial,
          ...data,
        });
      });
      getPropertyTaxesByLandId(+id).then(data => {
        setPropertyTaxes(data);
      })
    }
  }, [id]);

  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value, type, checked } = e.target;
    setLand(prev => ({
      ...prev,
      [name]: type === "checkbox" ? checked : type === "number" ? +value : value ?? "",
    }));
  };

  const onChange = (e: ChangeEvent<HTMLElement>) => handleFormChange(e, land, setLand)

  const handleSelect = (id: string | number, name: string) => {
    setLand(prev => ({
      ...prev,
      [name]: id,
    }));
  };
  
  const handleCreate = async(newLabel: string, name: string) => {
    switch(name) {
      case 'residential_development_id':
        localStorage.setItem('createLandLocal', JSON.stringify(land))
        navigate(`/residential-development/create?name=${newLabel}&return_url=${pathname}`)  
      break;
    }
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();

    const selectedResidential = residentials.find(r => r.id === land.residential_development_id);

    const payload: LandCreate = {
      ...land,
      municipality_id: selectedResidential?.city?.id,
      state_id: selectedResidential?.state?.id,
      user_last_update_id: state.auth?.id,
    };

    try {
      let result;

      if (isEditing) {
        result = await updateLand({ ...payload, id: +id! });
        toast.success("Terreno actualizado correctamente");
      } else {
        result = await registerLand(payload);
        toast.success("Terreno registrado correctamente");
      }

      if (!result) throw new Error();

      if (isEditing) dispatch({ type: "update-land", payload: result });
      else
      {
        dispatch({ type: "add-land", payload: result });
        navigate("/lands");
      }
      
    } catch {
      toast.error("Error al guardar terreno");
    }
  };
  const formatCurrency = (value: number | null | undefined) =>
    value != null ? new Intl.NumberFormat('es-MX', { style: 'currency', currency: 'MXN' }).format(value) : '-';

  useEffect(() => {
    const backCreate = searchParams.get('back_create')

    if(backCreate) {
      const itemName = searchParams.get('item_name')

      const savedItem = localStorage.getItem("createLandLocal")
      
      if(savedItem) {
        let savedLand : FormLand = JSON.parse(savedItem)

        switch(itemName) {
          case 'residentialDevelopment':
            const value = searchParams.get('item_id')

            console.log(savedLand)

            if(value) {
              savedLand = { ...savedLand, residential_development_id: +value }
            }

            setLand(savedLand)
            break;
        }
      }
    }
  }, [])

  if (isLoading) return <Loader />;

  return (
    <>
      <Breadcrumb list={breadcrumbList} />
      <h1>{isEditing ? "Editar Propiedad" : "Registrar Propiedad"}</h1>

      <form onSubmit={handleSubmit}>
        
        {isEditing && (
          <p><strong>Última actualización por:</strong> {userOptions.find(u => u.value === land.user_last_update_id)?.label ?? ''}</p>
        )}

        <div className="grid grid-cols-2 g-1">
          <InputGroup id="cadastral_file" name="cadastral_file" label="Expediente Catastral" value={land.cadastral_file ?? ""} placeholder="Expediente catastral" onChangeFnc={onChange} />
          <InputGroup id="area" name="area" type="number" label="Superficie terreno (m²)" value={land.area ?? 0} placeholder="0" onChangeFnc={onChange} />
          <InputGroup id="address" name="address" label="Dirección" value={land.address ?? ""} placeholder="Dirección" onChangeFnc={onChange} />
          <InputGroup id="built_area" name="built_area" type="number" label="Superficie construcción (m²)" value={land.built_area ?? 0} placeholder="0" onChangeFnc={onChange} />
          <InputGroup id="block_lot" name="block_lot" label="Manzana/Lote" value={land.block_lot ?? ""} placeholder="Manzana/Lote" onChangeFnc={onChange} />
          <ComboBox 
            name="residential_development_id" 
            value={land.residential_development_id} 
            options={residentialOptions} 
            placeholder="Fraccionamiento" 
            label="Fraccionamiento" 
            onCreate={handleCreate}
            onSelect={handleSelect} />
        </div>

        <hr className="mt-2 mb-2" />

        <div className="grid grid-cols-2 g-1">
          <SelectGroup id="category_id" name="category_id" label="Categoría" value={land.category_id ?? 0} options={categoryOptions} placeholder="Selecciona categoría" onChangeFnc={onChange} />
          <SelectGroup id="owner_company_id" name="owner_company_id" label="Empresa propietaria" value={land.owner_company_id ?? 0} options={companyOptions} placeholder="Selecciona empresa" onChangeFnc={onChange} />
          <SelectGroup id="land_type_id" name="land_type_id" label="Tipo de terreno" value={land.land_type_id ?? 0} options={typeOptions} placeholder="Selecciona tipo" onChangeFnc={onChange} />          
          <SelectGroup id="tax_payer_company_id" name="tax_payer_company_id" label="Empresa contribuyente" value={land.tax_payer_company_id ?? 0} options={companyOptions} placeholder="Selecciona empresa" onChangeFnc={onChange} />
        </div>

        <hr className="mt-2 mb-2" />

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
         {checkboxFields.map(field => (
            <div key={field.name} className="checkbox-group">
                <input
                type="checkbox"
                id={field.name}
                name={field.name}
                checked={land[field.name as keyof FormLand] as boolean}
                onChange={handleChange}
                />
                <label htmlFor={field.name}>{field.label}</label>
            </div>
            ))}
        </div>

        <hr className="mt-2 mb-2" />

        <button type="submit" className="btn btn-primary">
          <SaveIcon /> {isEditing ? "Guardar" : "Registrar"}
        </button>
        {isEditing ?
        <>
            <h2>{"PAGOS DE PREDIALES"}</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              
              <div>
                <p>Año Más Reciente:</p>
                {land.current_tax_year ?? '-'}

              </div>
              <div>
                <p>Valor Catastral: </p>
                
                {formatCurrency(land.current_cadastral_value) ?? '-'}
              </div>
              <div>
                <p>Valor por m²:</p>
                {formatCurrency(land.current_value_per_area) ?? '-'}
              </div>
              <div>
                <p>Valor por m² construido:</p>
                {formatCurrency(land.current_value_per_built_area) ?? '-'}
              </div>
              
            </div>
            <h3 className="mt-2 mb-2">{"Historial de Pagos"}</h3>
             <Link
                to={`/lands/form-land/${id}/property-taxes/form`}
                className="btn btn-primary flex items-center gap-2 mb-4"
              >
                <PlusIcon />
                Registrar
              </Link>
            <table style={{ fontSize: '0.75rem' }}>
            <thead>
              <tr>
                <th>Año Fiscal</th>
                <th>Valor Catastral</th>
                <th>Valor / Área</th>
                <th>Valor / Área Construida</th>
                <th>Impuesto</th>
                <th>Multas</th>
                <th>Otros Cargos</th>
                <th>Total Impuesto</th>
                <th>Descuento</th>
                <th>Bonus</th>
                <th>Otros</th>
                <th>Neto a Pagar</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {propertyTaxes.length === 0 ? (
                <tr>
                  <td colSpan={12} style={{ textAlign: 'center', padding: '1rem' }}>
                    No hay Prediales registrados para esta propiedad
                  </td>
                </tr>
              ) : (
                propertyTaxes.map(pt => (
                  <tr key={pt.id}>
                    <td>{pt.tax_year ?? '-'}</td>
                    <td>{formatCurrency(pt.cadastral_value ?? 0)}</td>
                    <td>{formatCurrency(pt.cadastral_value_per_area ?? 0)}</td>
                    <td>{formatCurrency(pt.cadastral_value_per_built_area ?? 0)}</td>
                    <td>{formatCurrency(pt.tax_amount ?? 0)}</td>
                    <td>{formatCurrency(pt.penalties ?? 0)}</td>
                    <td>{formatCurrency(pt.other_charges ?? 0)}</td>
                    <td>{formatCurrency(pt.total_tax ?? 0)}</td>
                    <td>{formatCurrency(pt.discount ?? 0)}</td>
                    <td>{formatCurrency(pt.bonuses ?? 0)}</td>
                    <td>{formatCurrency(pt.others ?? 0)}</td>
                    <td>{formatCurrency(pt.net_payable ?? 0)}</td>
                    <td>
                      <div className="table-actions">
                                                
                          <Link to={`/lands/form-land/${id}/property-taxes/form/${pt.id}`} className="text-indigo">
                              <EditIcon />
                          </Link>
                      </div>
                      </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        
        </>
         

         :
         <></>
         }
       
        
        
        <br/>
        <br/>
      </form>
    </>
  );
}
