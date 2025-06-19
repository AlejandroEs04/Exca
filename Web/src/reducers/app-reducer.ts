import { Client, Condition, Individual, Land, NotificationSystem, Project, User } from "../types";

export type AppActions =
    | { type: 'set-lands'; payload: { lands: Land[] } }
    | { type: 'add-land'; payload: Land }
    | { type: 'update-land'; payload: Land }
    | { type: 'set-clients'; payload: { clients: Client[] } }
    | { type: 'set-projects'; payload: { projects: Project[] } }
    | { type: 'set-users'; payload: { users: User[] } }
    | { type: 'set-auth'; payload: { auth: User } }
    | { type: 'set-individual'; payload: { individuals: Individual[] } }
    | { type: 'set-conditions'; payload: { conditions: Condition[] } }
    | { type: 'set-notification-systems'; payload: { notificationSystems: NotificationSystem[] } };

export type AppState = {
    clients: Client[];
    lands: Land[];
    projects: Project[];
    users: User[];
    auth: User | null;
    individuals: Individual[];
    conditions: Condition[];
    notificationSystems: NotificationSystem[];
};

export const initialState: AppState = {
    clients: [],
    lands: [],
    projects: [],
    users: [],
    auth: null,
    individuals: [],
    conditions: [],
    notificationSystems: []
};

export const AppReducer = (state: AppState, action: AppActions): AppState => {
    switch (action.type) {
        case 'set-clients':
            return { ...state, clients: action.payload.clients };
        case 'set-lands':
            return { ...state, lands: action.payload.lands };
        case 'add-land':
            return { ...state, lands: [...state.lands, action.payload] };
        case 'set-projects':
            return { ...state, projects: action.payload.projects };
        case 'set-users':
            return { ...state, users: action.payload.users };
        case 'set-auth':
            return { ...state, auth: action.payload.auth };
        case 'set-individual':
            return { ...state, individuals: action.payload.individuals };
        case 'set-conditions':
            return { ...state, conditions: action.payload.conditions };
        case 'set-notification-systems':
            return { ...state, notificationSystems: action.payload.notificationSystems };
        case 'update-land':
            return {
                ...state,
                lands: state.lands.map(land =>
                    land.id === action.payload.id ? action.payload : land
                )
            };

        default:
            return state;
    }
};
