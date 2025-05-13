import { isAxiosError } from "axios"
import api from "../lib/axios"
import { LeaseRequestCreate, LeaseRequestResponse } from "../types"

export async function registerRequest(request: LeaseRequestCreate) {
    try {
        const { data } = await api.post<LeaseRequestResponse>("/lease-request", request)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function getRequests() {
    try {
        const { data } = await api<LeaseRequestResponse[]>("/lease-request")
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function updateRequest(id: number, request: LeaseRequestCreate) {
    try {
        const { data } = await api.put<LeaseRequestResponse>(`/lease-request/${id}`, request)
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