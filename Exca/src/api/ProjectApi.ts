import { isAxiosError } from "axios"
import api from "../lib/axios"
import { ProjectCreate, ProjectView } from "../types"

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

export async function getProjects () {
    try {
        const { data } = await api.get<ProjectView[]>('/project')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}