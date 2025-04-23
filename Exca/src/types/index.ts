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

export type Land = {
    id: number
    cadastral_file: string
    area: number
    price_per_area: number
    address: string
    residential_development_id: number
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
}

export type LeaseRequestCreate = Pick<LeaseRequest, 'project_id'> & {
    conditions: LeaseRequestConditionCreate[]
}

export type LeaseRequestResponse = LeaseRequest & {
    created_at: string
    updated_at: string
    conditions: LeaseRequestCondition[]
}

export type ProjectLandType = {
    id: number
    name: string

}