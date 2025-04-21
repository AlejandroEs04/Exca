import { Client, Land, Project } from "../types";

export type AppActions =
    { type: 'set-lands', paypload: { lands: Land[] } } |
    { type: 'set-clients', paypload: { clients: Client[] } } | 
    { type: 'set-projects', paypload: { projects: Project[] } } 

export type AppState = {
    clients: Client[]
    lands: Land[]
    projects: Project[]
}

export const initialState: AppState = {
    clients: [],
    lands: [], 
    projects: []
}

export const AppReducer = (state: AppState, action: AppActions): AppState => {
    switch (action.type) {
        case 'set-clients':
            return { ...state, clients: action.paypload.clients }
        case 'set-lands':
            return { ...state, lands: action.paypload.lands }
        case 'set-projects':
            return { ...state, projects: action.paypload.projects }
        default:
            return state
    }
}