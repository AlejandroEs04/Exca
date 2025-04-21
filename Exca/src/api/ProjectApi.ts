import { isAxiosError } from "axios"
import api from "../lib/axios"
import { ProjectCreate } from "../types"

export async function registerProject (project: ProjectCreate) {
    try {
        const { data } = await api.post('/project', project)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}