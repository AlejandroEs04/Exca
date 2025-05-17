import { isAxiosError } from "axios"
import api from "../lib/axios"
import { City, LandCreate, Land, ResidentialDevelopment } from "../types"

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
export async function updateLand(land: Land) {
    try {
        const { data } = await api.post<Land>('/land/updateLand', land)
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
export async function getCities () {
    try {
        const { data } = await api<City[]>('/land/cities')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}