import { isAxiosError } from "axios";
import api from "../lib/axios";
import { GuaranteeType, Individual } from "../types";

export async function getIndividuals() {
    try {
        const { data } = await api<Individual[]>('/individual')
        return data
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }        
    }
}

export async function getGuaranteeTypes() {
    try {
        const { data } = await api<GuaranteeType[]>('/individual/guarantee-type')
        return data
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }        
    }
}