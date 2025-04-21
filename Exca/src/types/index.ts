export type Client = {
    id: number
    name: string 
    company_id: number
}

export type Company = {
    id: number 
    business_name: string
    email?: string
    phone_number?: string
    tax_id?: string
    address?: string
    type_id?: number
    clients: Client[]
}

export type CompanyCreate = Pick<Company, 'business_name' | 'email' | 'address' | 'phone_number' | 'tax_id' | 'type_id'>

export type Land = {
    id: number
    cadastral_file: string
    area: number
    price_per_area: number
    address: string
    residential_development: string
}

export type LandCreate = Pick<Land, 'cadastral_file' | 'area' | 'price_per_area' | 'address' | 'residential_development'>

export type RentLand = {
    land_id: number
    area: number
}

export type Project = {
    id: number
    name: string
    client: string
    brand: string
    lands: RentLand[]
}

export type ProjectCreate = Pick<Project, 'name' | 'client' | 'brand' | 'lands'> 