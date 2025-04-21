export type Brand = {
    id: number
    name: string 
    client_id: number
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

export type Land = {
    id: number
    cadastral_file: string
    area: number
    price_per_area: number
    address: string
    residential_development: string
}

export type LandCreate = Pick<Land, 'cadastral_file' | 'area' | 'price_per_area' | 'address' | 'residential_development'>

export type Stage = {
    id: number
    name: string
}

export type RentLand = {
    land_id: number
    area: number
}

export type ProjectLand = {
    id: number
    land_id: number
    area: number
    land: Land
}

export type Project = {
    id: number
    name: string
    client: string
    brand: string
    brand_id: number
    stage_id: number
    origitnator_id: number
    created_at: string
    updated_at: string
    lands: ProjectLand[]
    stage: Stage
}

export type ProjectCreate = Pick<Project, 'name' | 'client' | 'brand'> &  {
    lands: RentLand[]
}