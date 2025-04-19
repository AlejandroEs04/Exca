import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Land, LandCreate } from "../types"

export async function getLands() {
    try {
        const { data } = await api<Land[]>('/land')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function registerLand(land: LandCreate) {
    try {
        const { data } = await api.post<Land>('/land', land)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}