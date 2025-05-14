import { isAxiosError } from "axios"
import api from "../lib/axios"
import { Area, UserRol, User, UserCreate } from "../types"

export async function getUsers() {
    try {
        const { data } = await api<User[]>('/user')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function createUser(user: UserCreate) {
    try {
        const { data } = await api.post<User>('/user', user)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function getAreas() {
    try {
        const { data } = await api<Area[]>('/area')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

export async function getRoles() {
    try {
        const { data } = await api<UserRol[]>('/rol')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}