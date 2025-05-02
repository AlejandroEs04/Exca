export type Brand = {
    id: number
    name: string 
    client_id: number
    client: Client
}

export type Client = {
    id: number 
    business_name: string
    email?: string
    phone_number?: string
    tax_id?: string
    address?: string
    type_id?: number
    brands?: Client[]
}

export type ClientCreate = Pick<Client, 'business_name' | 'email' | 'address' | 'phone_number' | 'tax_id' | 'type_id'>

export type ResidentialDevelopment = {
    id: number
    name: string
}

export type City = {
    id: number
    descripcion: string
}

export type Land = {
    id: number
    cadastral_file: string
    area: number
    price_per_area: number
    address: string
    residential_development_id: number
    municipio?: number
    valor_catastral?: number,
    area_construida?: number,
    pago_predial?: number,
    global_status?: number,
    path_predial_file?: string,
    name_last_update?: string
}

export type LandResponse = Land & {
    residential_development: ResidentialDevelopment
}

export type LandCreate = Pick<Land, 'cadastral_file' | 'area' | 'price_per_area' | 'address'> & {
    residential_development: string
}

export type Stage = {
    id: number
    name: string
}

export type RentLand = {
    land_id: number
    area: number
    type_id: number
}

export type ProjectLand = {
    id: number
    land_id: number
    area: number
    type_id: number
    land: LandResponse
    type: ProjectLandType
}

export type Project = {
    id: number
    name: string
    client: string
    brand_id: number
    stage_id: number
    origitnator_id: number
    created_at: string
    updated_at: string
    lands: ProjectLand[]
    stage: Stage
}

export type ProjectCreate = Pick<Project, 'name' | 'client'> &  {
    lands: RentLand[]
    brand: string
}

export type ProjectView = Pick<Project, 'id' | 'name' | 'client' | 'stage_id' | 'origitnator_id' | 'created_at' | 'updated_at'> & {
    brand: Brand
    lands: ProjectLand[]
    stage: Stage
    lease_request: LeaseRequestResponse
}

export type Condition = {
    id: number
    name: string
    type_id: number
    category_id: number
    options: string
}

export type LeaseRequestCondition = {
    id: number
    condition_id: number
    lease_request_id: number
    value: string
    is_active: boolean
    condition: Condition
}

export type LeaseRequestConditionCreate = Pick<LeaseRequestCondition, 'id' | 'condition_id' | 'value' | 'is_active'>

export type LeaseRequest = {
    id: number
    project_id: number
    guarantee_type_id: number
    owner_id: number
    commission_agreement: boolean
    assignment_income: boolean
    property_file: boolean
}

export type LeaseRequestCreate = Omit<LeaseRequest, 'id'> & {
    conditions: LeaseRequestConditionCreate[]
    guarantee: string
    guarantee_address: string
    guarantee_property_file: string
}

export type LeaseRequestResponse = LeaseRequest & {
    created_at: string
    updated_at: string
    conditions: LeaseRequestCondition[]
    guarantee: Individual
    status_id: number
}

export type ProjectLandType = {
    id: number
    name: string
}

export type Rol = {
    id: number
    name: string
}

export type Area = {
    id: number
    name: string
}

export type User = {
    full_name: string
    email: string
    rol_id: number
    area_id: number
    id: number
    area: Area
    rol: Rol
}

export type Auth = {
    email: string
    password: string
}

export type UserCreate = Pick<User, 'full_name' | 'email' | 'area_id' | 'rol_id'> & {
    password: string
}

export type ApprovalStep = {
    id: number
    next_step_id: number | null
    flow_id: number
    signator_id: number
    flow: ApprovalFlow | null
}

export type ApprovalStepCreate = Pick<ApprovalStep, 'signator_id'> & {
    order: number
}

export type ApprovalFlow = {
    id: number
    name: string
    steps: ApprovalStep[]
}

export type ApprovalFlowCreate = Pick<ApprovalFlow, 'name'> & {
    steps: ApprovalStepCreate[]
}

export type ApprovalRequest = {
    id: number
    response: boolean | null
    step_id: number
    item_id: number
    step: ApprovalStep | null
}

export type AuthResponse = {
    access_token: string
    token_type: string
}

export type Individual = {
    id: number
    full_name: string
    tax_id: string
    address: string
}

export type Owner = {
    id: number
    name: string
}

export type GuaranteeType = {
    id: number
    name: string
}

export type Icon = {
    color?: 'text-green' | 'text-red'
}