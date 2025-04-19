import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Company } from "../types"

export async function getCompanies() {
    try {
        const { data } = await api<Company[]>('/company')
        console.log(data)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}