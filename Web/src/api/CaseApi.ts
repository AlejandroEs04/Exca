import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Case, CaseCreate } from "../types"
import { formatValidationErrors } from "../utils"

export async function createCase(newCase: CaseCreate) {
    try {
        const { data } = await api.post<Case>('/case', newCase)
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

export async function sendCase(id: number) {
    try {
        const { data } = await api.post<Case>(`/case/send/${id}`)
        console.log(data)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function updateCase(id: number, newCase: CaseCreate) {
    try {
        const { data } = await api.put<Case>(`/case/edit/${id}`, newCase)
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