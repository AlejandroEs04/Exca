import { isAxiosError } from "axios";
import api from "../lib/axios";
import { Condition } from "../types";

export async function getConditions() {
    try {
        const { data } = await api<Condition[]>('/condition')
        return data
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }        
    }
}