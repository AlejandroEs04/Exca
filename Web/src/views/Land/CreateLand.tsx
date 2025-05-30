// src/pages/lands/CreateLand.tsx
import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb";
import SaveIcon from "../../components/shared/Icons/SaveIcon";
import InputGroup from "../../components/forms/InputGroup";
import SelectGroup, { Option } from "../../components/forms/SelectGroup";
import { useAppContext } from "../../hooks/AppContext";
import { LandCreate } from "../../types";
import { toast } from "react-toastify";
import Loader from "../../components/shared/Loader/Loader";
import {
  registerLand,
} from "../../api/LandApi";
import {getUsers,} from "../../api/UserApi";
import {getResidentialDevelopments,} from "../../api/ResidentialDevelopmentApi";
import {getCities,} from "../../api/CityApi";
import {getStates,} from "../../api/StateApi";
import {getLandTypes,} from "../../api/LandTypeApi";
import {getLandCategories,} from "../../api/LandCategoryApi";
import {getOwners,} from "../../api/OwnerApi";
import {getLandStatuses,} from "../../api/LandStatusApi";
// Extend LandCreate for form state including required residential_development_id and checkboxes
type FormLand = LandCreate & {
  municipality_id?: number;
  state_id?: number;
  land_type_id?: number;
  category_id?: number;
  owner_company_id?: number;
  tax_payer_company_id?: number;
  user_last_update_id?: number;
  status_id?: number;
  residential_development_id: number;
  is_trust_owned: boolean;
  has_water_service: boolean;
  has_drainage_service: boolean;
  has_cfe_service: boolean;
};

export default function CreateLand() {
  const breadcrumbList = [
    { name: "Dashboard", url: "/" },
    { name: "Inventario de terrenos", url: "/lands" },
    { name: "Registrar Terreno", url: "/lands/create" },
  ];

  const { dispatch, isLoading } = useAppContext();
  const navigate = useNavigate();

  const initial: FormLand = {
    // LandCreate required fields
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
    // optional selects
    municipality_id: undefined,
    state_id: undefined,
    land_type_id: undefined,
    category_id: undefined,
    owner_company_id: undefined,
    tax_payer_company_id: undefined,
    user_last_update_id: undefined,
    status_id: undefined,
    // boolean defaults
    is_trust_owned: false,
    has_water_service: false,
    has_drainage_service: false,
    has_cfe_service: false,
  };

  const [land, setLand] = useState<FormLand>(initial);
  const [residentialOptions, setResidentialOptions] = useState<Option[]>([]);
  const [municipalOptions, setMunicipalOptions] = useState<Option[]>([]);
  const [stateOptions, setStateOptions] = useState<Option[]>([]);
  const [typeOptions, setTypeOptions] = useState<Option[]>([]);
  const [categoryOptions, setCategoryOptions] = useState<Option[]>([]);
  const [companyOptions, setCompanyOptions] = useState<Option[]>([]);
  const [userOptions, setUserOptions] = useState<Option[]>([]);
  const [statusOptions, setStatusOptions] = useState<Option[]>([]);

  useEffect(() => {
    Promise.all([
        getResidentialDevelopments(),
        getCities(),
        getStates(),
        getLandTypes(),
        getLandCategories(),
        getOwners(),
        getUsers(),
        getLandStatuses(),
    ]).then(([
        residentials = [],
        muns = [],
        statesArr = [],
        typesArr = [],
        catsArr = [],
        compsArr = [],
        usersArr = [],
        statusesArr = [],
    ]) => {
        setResidentialOptions(residentials.map(r => ({ label: r.name, value: r.id })));
        setMunicipalOptions(muns.map(m => ({ label: m.descripcion, value: m.id })));
        setStateOptions(statesArr.map(s => ({ label: s.descripcion, value: s.id })));
        setTypeOptions(typesArr.map(t => ({ label: t.description, value: t.id })));
        setCategoryOptions(catsArr.map(c => ({ label: c.description, value: c.id })));
        setCompanyOptions(compsArr.map(c => ({ label: c.name, value: c.id })));
        setUserOptions(usersArr.map(u => ({ label: u.full_name, value: u.id })));
        setStatusOptions(statusesArr.map(st => ({ label: st.description, value: st.id })));
    });
    }, []);


  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value, type, checked } = e.target;
    setLand(prev => ({
      ...prev,
      [name]: type === "checkbox" ? checked : type === "number" ? +value : (value ?? ""),
    }));
  };

  const handleSelect = (e: ChangeEvent<HTMLSelectElement>) => {
    const { name, value } = e.target;
    setLand(prev => ({ ...prev, [name]: Number(value ?? 0) }));
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    const payload: LandCreate = {
      cadastral_file: land.cadastral_file ?? "",
      block_lot: land.block_lot ?? "",
      address: land.address ?? "",
      area: land.area ?? 0,
      built_area: land.built_area ?? 0,
      comments: land.comments ?? "",
      notes: land.notes ?? "",
      incorporation: land.incorporation ?? "",
      incorporation_notes: land.incorporation_notes ?? "",
      residential_development_id: land.residential_development_id,
      municipality_id: land.municipality_id,
      state_id: land.state_id,
      land_type_id: land.land_type_id,
      category_id: land.category_id,
      owner_company_id: land.owner_company_id,
      tax_payer_company_id: land.tax_payer_company_id,
      user_last_update_id: land.user_last_update_id,
      status_id: land.status_id,
      is_trust_owned: land.is_trust_owned,
      has_water_service: land.has_water_service,
      has_drainage_service: land.has_drainage_service,
      has_cfe_service: land.has_cfe_service,
    };

    try {
      const newLand = await registerLand(payload);
      if (!newLand) throw new Error();
      dispatch({ type: "add-land", payload: newLand });
      toast.success("Terreno registrado correctamente");
      navigate("/lands");
    } catch {
      toast.error("Error al registrar terreno");
    }
  };

  if (isLoading) return <Loader />;

  return (
    <>
      <Breadcrumb list={breadcrumbList} />
      <h1>Registrar Terreno</h1>
      <form onSubmit={handleSubmit} className="space-y-4">
  {/* Sección 1: Inputs de texto y número */}
  <div className="grid grid-cols-2 g-1">
    <InputGroup
      id="cadastral_file"
      name="cadastral_file"
      label="Expediente Catastral"
      value={land.cadastral_file ?? ""}
      placeholder="Expediente catastral"
      onChangeFnc={handleChange}
    />
    <InputGroup
      id="area"
      name="area"
      type="number"
      label="Superficie terreno (m²)"
      value={land.area ?? 0}
      placeholder="0"
      onChangeFnc={handleChange}
    />
    <InputGroup
      id="address"
      name="address"
      label="Dirección"
      value={land.address ?? ""}
      placeholder="Dirección"
      onChangeFnc={handleChange}
    />
    
    
    <InputGroup
      id="built_area"
      name="built_area"
      type="number"
      label="Superficie construcción (m²)"
      value={land.built_area ?? 0}
      placeholder="0"
      onChangeFnc={handleChange}
    />
    <InputGroup
      id="block_lot"
      name="block_lot"
      label="Manzana/Lote"
      value={land.block_lot ?? ""}
      placeholder="Manzana/Lote"
      onChangeFnc={handleChange}
    />
  </div>
  <br/>
  <hr />
  <br/>

  {/* Sección 2: Selects */}
  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 g-1">
    <SelectGroup
      id="residential_development_id"
      name="residential_development_id"
      label="Fraccionamiento"
      value={land.residential_development_id ?? 0}
      options={residentialOptions}
      placeholder="Selecciona fraccionamiento"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="municipality_id"
      name="municipality_id"
      label="Municipio"
      value={land.municipality_id ?? 0}
      options={municipalOptions}
      placeholder="Selecciona municipio"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="state_id"
      name="state_id"
      label="Estado"
      value={land.state_id ?? 0}
      options={stateOptions}
      placeholder="Selecciona estado"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="land_type_id"
      name="land_type_id"
      label="Tipo de terreno"
      value={land.land_type_id ?? 0}
      options={typeOptions}
      placeholder="Selecciona tipo"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="category_id"
      name="category_id"
      label="Categoría"
      value={land.category_id ?? 0}
      options={categoryOptions}
      placeholder="Selecciona categoría"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="owner_company_id"
      name="owner_company_id"
      label="Empresa propietaria"
      value={land.owner_company_id ?? 0}
      options={companyOptions}
      placeholder="Selecciona empresa"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="tax_payer_company_id"
      name="tax_payer_company_id"
      label="Empresa contribuyente"
      value={land.tax_payer_company_id ?? 0}
      options={companyOptions}
      placeholder="Selecciona empresa"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="user_last_update_id"
      name="user_last_update_id"
      label="Usuario actualización"
      value={land.user_last_update_id ?? 0}
      options={userOptions}
      placeholder="Selecciona usuario"
      onChangeFnc={handleSelect}
    />
    <SelectGroup
      id="status_id"
      name="status_id"
      label="Estado actual"
      value={land.status_id ?? 0}
      options={statusOptions}
      placeholder="Selecciona estado"
      onChangeFnc={handleSelect}
    />
  </div>
  <br/>
  <hr />
  <br/>
  {/* Sección 3: Checkboxes */}
  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
    <div className="checkbox-group">
      <input
        type="checkbox"
        id="is_trust_owned"
        name="is_trust_owned"
        checked={land.is_trust_owned}
        onChange={handleChange}
      />
      <label htmlFor="is_trust_owned">¿Pertenece al Fideicomiso?</label>
    </div>
    <div className="checkbox-group">
      <input
        type="checkbox"
        id="has_water_service"
        name="has_water_service"
        checked={land.has_water_service}
        onChange={handleChange}
      />
      <label htmlFor="has_water_service">¿Tiene servicio de agua?</label>
    </div>
    <div className="checkbox-group">
      <input
        type="checkbox"
        id="has_drainage_service"
        name="has_drainage_service"
        checked={land.has_drainage_service}
        onChange={handleChange}
      />
      <label htmlFor="has_drainage_service">¿Tiene drenaje?</label>
    </div>
    <div className="checkbox-group">
      <input
        type="checkbox"
        id="has_cfe_service"
        name="has_cfe_service"
        checked={land.has_cfe_service}
        onChange={handleChange}
      />
      <label htmlFor="has_cfe_service">¿Tiene servicio CFE?</label>
    </div>
  </div>
  <br/>

  <button type="submit" className="btn btn-primary">
    <SaveIcon /> Guardar
  </button>
  <br/>
</form>

    </>
  );
}
