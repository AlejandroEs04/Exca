import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Case, CaseCreate } from "../types"

export async function createTechnicalCase(newTechnicalCase: CaseCreate) {
    try {
        const { data } = await api.post<Case[]>('/technical-case', newTechnicalCase)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function sendTechnicalCase(id: number) {
    try {
        const { data } = await api<Case>(`/technical-case/send/${id}`)
        console.log(data)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}