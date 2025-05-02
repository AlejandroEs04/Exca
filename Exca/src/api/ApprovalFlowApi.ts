import { isAxiosError } from "axios"
import api from "../lib/axios"
import { ApprovalFlow, ApprovalFlowCreate, ApprovalRequest } from "../types"

export async function getFlows() {
    try {
        const { data } = await api<ApprovalFlow[]>('/approval-flow')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function updateFlow(id: number, flow: ApprovalFlowCreate) {
    try {
        const { data } = await api.put<ApprovalFlow>(`/approval-flow/${id}`, flow)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function getApprovalRequests() {
    try {
        const { data } = await api<ApprovalRequest[]>('/approval-request')
        console.log(data)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function responseApprovalRequest(id: number, response: boolean) {
    try {
        await api(`/approval-request/response/${id}/${response}`)
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}