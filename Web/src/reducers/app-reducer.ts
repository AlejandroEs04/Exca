import { Client, Condition, Individual, Land, Project, User } from "../types";

export type AppActions =
    { type: 'set-lands', payload: { lands: Land[] } } |
    { type: 'set-clients', payload: { clients: Client[] } } | 
    { type: 'set-projects', payload: { projects: Project[] } } |
    { type: 'set-users', payload: { users: User[] } } |
    { type: 'set-auth', payload: { auth: User } } |
    { type: 'set-individual', payload: { individuals: Individual[] } } | 
    { type: 'set-conditions', payload: { conditions: Condition[] } } 

export type AppState = {
    clients: Client[]
    lands: Land[]
    projects: Project[]
    users: User[],
    auth: User | null,
    individuals: Individual[]
    conditions: Condition[]
}

export const initialState: AppState = {
    clients: [],
    lands: [], 
    projects: [], 
    users: [], 
    auth: null,
    individuals: [], 
    conditions: []
}

export const AppReducer = (state: AppState, action: AppActions): AppState => {
    switch (action.type) {
        case 'set-clients':
            return { ...state, clients: action.payload.clients }
        case 'set-lands':
            return { ...state, lands: action.payload.lands }
        case 'set-projects':
            return { ...state, projects: action.payload.projects }
        case 'set-users':
            return { ...state, users: action.payload.users }
        case 'set-auth':
            return { ...state, auth: action.payload.auth }
        case 'set-individual':
            return { ...state, individuals: action.payload.individuals }
        case 'set-conditions':
            return { ...state, conditions: action.payload.conditions }
        default:
            return state
    }
}