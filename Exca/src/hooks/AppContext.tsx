import React, { createContext, useContext, ReactNode, useReducer, Dispatch, useEffect } from 'react';
import { AppActions, AppReducer, AppState, initialState } from "../reducers/app-reducer";
import { getLands } from '../api/LandApi';
import { getClient } from '../api/ClientApi';
import { getProjects } from '../api/ProjectApi';
import { getRequests } from '../api/LeaseRequestApi';

interface AppContextProps {
    state: AppState
    dispatch: Dispatch<AppActions>
}

const AppContext = createContext<AppContextProps | undefined>(undefined);

export const AppProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
    const [state, dispatch] = useReducer(AppReducer, initialState)

    useEffect(() => {
        const getInitials = async() => {
            const clients = await getClient()
            const lands = await getLands()
            const projects = await getProjects()
            const requests = await getRequests()

            if (!clients || !lands || !projects || !requests) return

            dispatch({ type: 'set-clients', paypload: { clients } })
            dispatch({ type: 'set-lands', paypload: { lands } })
            dispatch({ type: 'set-projects', paypload: { projects } })
            dispatch({ type: 'set-lease-request', paypload: { requests } })
        }

        getInitials()
    }, [])

    return (
        <AppContext.Provider value={{ state, dispatch }}>
            {children}
        </AppContext.Provider>
    );
};

export const useAppContext = (): AppContextProps => {
    const context = useContext(AppContext);
    if (!context) {
        throw new Error('useAppContext must be used within an AppProvider');
    }
    return context;
};