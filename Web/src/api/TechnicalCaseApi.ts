import { isAxiosError } from "axios"
import api from "../lib/axios"
import { TechnicalCase, TechnicalCaseCreate } from "../types"

export async function createTechnicalCase(newTechnicalCase: TechnicalCaseCreate) {
    try {
        const { data } = await api.post<TechnicalCase[]>('/technical-case', newTechnicalCase)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function sendTechnicalCase(id: number) {
    try {
        const { data } = await api<TechnicalCase>(`/technical-case/send/${id}`)
        console.log(data)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}