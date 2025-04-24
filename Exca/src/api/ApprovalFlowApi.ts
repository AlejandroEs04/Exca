import { isAxiosError } from "axios"
import api from "../lib/axios"
import { ApprovalFlow, ApprovalFlowCreate } from "../types"

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