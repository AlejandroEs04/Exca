import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Brand, BrandCreate, Client, ClientCreate } from "../types"
import { formatValidationErrors } from "../utils"

export async function getClient() {
    try {
        const { data } = await api<Client[]>('/client')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function createClient(client: ClientCreate) {
    try {
        const { data } = await api.post<Client>('/client', client)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            const errorData = error.response.data;
      
            if (Array.isArray(errorData.detail)) {
                const formattedErrors = formatValidationErrors(errorData.detail);
                throw new Error(JSON.stringify(formattedErrors));
            }
            
            throw new Error(errorData.detail || 'Error al crear el cliente');
        }
    }
}

export async function deleteClient(id: number) {
    try {
        await api.delete(`/client?id=${id}`)
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function updateClient(id: number, client: ClientCreate) {
    try {
        const { data } = await api.put<Client>(`/client?id=${id}`, client)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function createBrand(brand: BrandCreate) {
    try {
        const { data } = await api.post<Brand>('/client/brand', brand)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            const errorData = error.response.data;
      
            if (Array.isArray(errorData.detail)) {
                const formattedErrors = formatValidationErrors(errorData.detail);
                throw new Error(JSON.stringify(formattedErrors));
            }
            
            throw new Error(errorData.detail || 'Error al crear el nombre comercial');
        }
    }
}