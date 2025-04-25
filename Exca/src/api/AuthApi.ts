import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Auth, AuthResponse, User } from "../types"

export async function login(auth: Auth) {
    try {
        const { data } = await api.post<AuthResponse>('/auth/login', auth)
        return data.access_token
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }        
    }
}

export async function getAuth() {
    try {
        const { data } = await api<User | null>('/auth')
        return data
    } catch (error) {
        if (isAxiosError(error) && error.response) {
            throw new Error(error.response.data.detail)
        }        
    }
}