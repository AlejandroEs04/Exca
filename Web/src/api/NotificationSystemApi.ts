import { isAxiosError } from "axios"
import api from "../lib/axios"
import { formatValidationErrors } from "../utils"
import { NotificationSystem, NotificationSystemCreate } from "../types"

export async function getNotificationSystems() {
    try {
        const { data } = await api<NotificationSystem[]>("/notification-system")
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            const errorData = error.response.data;
             
            if (Array.isArray(errorData.detail)) {
                const formattedErrors = formatValidationErrors(errorData.detail);
                throw new Error(JSON.stringify(formattedErrors));
            }
        } 
    }
}

export async function updateNotificationSystem(id: number, notificationSystem: NotificationSystemCreate) {
    try {
        const { data } = await api.put<NotificationSystem>(`/notification-system/${id}`, notificationSystem)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            const errorData = error.response.data;
             
            if (Array.isArray(errorData.detail)) {
                const formattedErrors = formatValidationErrors(errorData.detail);
                throw new Error(JSON.stringify(formattedErrors));
            }
        } 
    }
}