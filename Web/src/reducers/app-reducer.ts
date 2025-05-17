import { Client, Condition, Individual, Land, Project, User } from "../types";

export type AppActions =
    { type: 'set-lands', paypload: { lands: Land[] } } |
    { type: 'set-clients', paypload: { clients: Client[] } } | 
    { type: 'set-projects', paypload: { projects: Project[] } } |
    { type: 'set-users', paypload: { users: User[] } } |
    { type: 'set-auth', paypload: { auth: User } } |
    { type: 'set-individual', paypload: { individuals: Individual[] } } | 
    { type: 'set-conditions', paypload: { conditions: Condition[] } } 

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
            return { ...state, clients: action.paypload.clients }
        case 'set-lands':
            return { ...state, lands: action.paypload.lands }
        case 'set-projects':
            return { ...state, projects: action.paypload.projects }
        case 'set-users':
            return { ...state, users: action.paypload.users }
        case 'set-auth':
            return { ...state, auth: action.paypload.auth }
        case 'set-individual':
            return { ...state, individuals: action.paypload.individuals }
        case 'set-conditions':
            return { ...state, conditions: action.paypload.conditions }
        default:
            return state
    }
}