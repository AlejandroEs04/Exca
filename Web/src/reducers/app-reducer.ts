import { Client, Land, LeaseRequest, Project, User } from "../types";

export type AppActions =
    { type: 'set-lands', paypload: { lands: Land[] } } |
    { type: 'set-clients', paypload: { clients: Client[] } } | 
    { type: 'set-projects', paypload: { projects: Project[] } } |
    { type: 'set-lease-request', paypload: { requests: LeaseRequest[] } } |
    { type: 'set-users', paypload: { users: User[] } } |
    { type: 'set-auth', paypload: { auth: User } } 

export type AppState = {
    clients: Client[]
    lands: Land[]
    projects: Project[]
    requests: LeaseRequest[]
    users: User[],
    auth: User | null
}

export const initialState: AppState = {
    clients: [],
    lands: [], 
    projects: [], 
    requests: [], 
    users: [], 
    auth: null
}

export const AppReducer = (state: AppState, action: AppActions): AppState => {
    switch (action.type) {
        case 'set-clients':
            return { ...state, clients: action.paypload.clients }
        case 'set-lands':
            return { ...state, lands: action.paypload.lands }
        case 'set-projects':
            return { ...state, projects: action.paypload.projects }
        case 'set-lease-request':
            return { ...state, requests: action.paypload.requests }
        case 'set-users':
            return { ...state, users: action.paypload.users }
        case 'set-auth':
            return { ...state, auth: action.paypload.auth }
        default:
            return state
    }
}