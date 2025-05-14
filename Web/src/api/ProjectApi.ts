import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Project, ProjectCreate, ProjectLandType } from "../types"

export async function registerProject (project: ProjectCreate) {
    try {
        const { data } = await api.post('/project', project)
        return data
    } catch (error) {
        console.log(error)
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function getProjects () {
    try {
        const { data } = await api.get<Project[]>('/project')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function updateProject(id: number, project: ProjectCreate) {
    try {
        const { data } = await api.put<Project>(`/project/${id}`, project)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}

export async function getProjectLandTypes () {
    try {
        const { data } = await api.get<ProjectLandType[]>('/project/rent-type')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
    }
}
export async function  getProjectById (id: string | number) 
{
    try {
        const { data } = await api.get<Project>(`project/get-project/${id}`)
        return data
        
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }
        
    }
    
}