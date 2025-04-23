import { Client, LandResponse, LeaseRequestResponse, ProjectView } from "../types";

export type AppActions =
    { type: 'set-lands', paypload: { lands: LandResponse[] } } |
    { type: 'set-clients', paypload: { clients: Client[] } } | 
    { type: 'set-projects', paypload: { projects: ProjectView[] } } |
    { type: 'set-lease-request', paypload: { requests: LeaseRequestResponse[] } } 

export type AppState = {
    clients: Client[]
    lands: LandResponse[]
    projects: ProjectView[]
    requests: LeaseRequestResponse[]
}

export const initialState: AppState = {
    clients: [],
    lands: [], 
    projects: [], 
    requests: []
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
        default:
            return state
    }
}