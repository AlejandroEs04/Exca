import api from "../lib/axios"
import { isAxiosError } from "axios"
import { ClientRoll, ClientRollCreate } from "../types"

export async function getClientRolls() {
    try {
        const { data } = await api<ClientRoll[]>("/client-rolls")
        return data
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail || error.message);
        }
    }
}

export async function createClientRoll(clientRoll: ClientRollCreate) {
    try {
        const { data } = await api.post<ClientRoll>("/client-rolls", clientRoll)
        return data
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail || error.message);
        }
    }
}