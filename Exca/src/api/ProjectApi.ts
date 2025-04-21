import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Project, ProjectCreate } from "../types"

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
        const { data } = await api.get<Project[]>('/project')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}