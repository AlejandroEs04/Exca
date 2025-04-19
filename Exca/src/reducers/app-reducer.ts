import { Company, Land } from "../types";

export type AppActions =
    { type: 'set-companies', paypload: { companies: Company[] } } |
    { type: 'set-lands', paypload: { lands: Land[] } }

export type AppState = {
    companies: Company[]
    lands: Land[]
}

export const initialState: AppState = {
    companies: [],
    lands: []
}

export const AppReducer = (state: AppState, action: AppActions): AppState => {
    switch (action.type) {
        case 'set-companies':
            return { ...state, companies: action.paypload.companies }
        case 'set-lands':
            return { ...state, lands: action.paypload.lands }
        default:
            return state
    }
}