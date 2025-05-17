import { isAxiosError } from "axios"
import api from "../lib/axios"
import { LeaseRequestCreate, LeaseRequest } from "../types"
import { formatValidationErrors } from "../utils"

export async function createRequest(request: LeaseRequestCreate) {
    try {
        const { data } = await api.post<LeaseRequest>("/lease-request", request)
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

export async function getRequests() {
    try {
        const { data } = await api<LeaseRequest[]>("/lease-request")
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function updateRequest(id: number, request: LeaseRequestCreate) {
    try {
        const { data } = await api.put<LeaseRequest>(`/lease-request/${id}`, request)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function getLeaseByProject(id: number) {
    try {
        const { data } = await api.get(`/lease-request/project/${id}`)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function sendToApprovalRequest(id: number) {
    try {
        const requestData = {
            item_id: id,
            flow_id: 1
        }
        const { data } = await api.post(`/lease-request/send-to-approval`, requestData)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}