import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Owner } from "../types"

export async function getOnwers () {
    try {
        const { data } = await api<Owner[]>('/owner')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}