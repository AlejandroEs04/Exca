import { isAxiosError } from "axios"
import api from "../lib/axios"
import { LandCreate, LandResponse, ResidentialDevelopment } from "../types"

export async function getLands() {
    try {
        const { data } = await api<LandResponse[]>('/land')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function registerLand(land: LandCreate) {
    try {
        const { data } = await api.post<LandResponse>('/land', land)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function getResidentialDevelopments () {
    try {
        const { data } = await api<ResidentialDevelopment[]>('/land/residential-developments')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}