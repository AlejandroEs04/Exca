import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Client, ClientCreate } from "../types"

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
            throw new Error(error.response.data.error)
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