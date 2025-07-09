import { isAxiosError } from "axios";
import api from "../lib/axios";
import { ProjectLand, ProjectLandCreate } from "../types";

export async function updateProjectLand(id: number, projectLand: ProjectLandCreate) {
    try {
        const { data } = await api.put<ProjectLand>(`/project-land/${id}`, projectLand)
        return data
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }        
    }
}