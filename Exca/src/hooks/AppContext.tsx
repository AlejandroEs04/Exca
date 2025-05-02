import React, { createContext, useContext, ReactNode, useReducer, Dispatch, useEffect, useState } from 'react';
import { AppActions, AppReducer, AppState, initialState } from "../reducers/app-reducer";
import { getLands } from '../api/LandApi';
import { getClient } from '../api/ClientApi';
import { getProjects } from '../api/ProjectApi';
import { getRequests } from '../api/LeaseRequestApi';
import { getUsers } from '../api/UserApi';
import { toast } from 'react-toastify';

interface AppContextProps {
    state: AppState
    dispatch: Dispatch<AppActions>
    isLoading: boolean
    setIsLoading: React.Dispatch<React.SetStateAction<boolean>>
    setError: (error: any) => void
}

const AppContext = createContext<AppContextProps | undefined>(undefined);

export const AppProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
    const [state, dispatch] = useReducer(AppReducer, initialState)
    const [isLoading, setIsLoading] = useState(false)

    const setError = (error: any) => {
        if (error instanceof Error) {
            toast.error(error.message)
        } else {
            toast.error("An unexpected error occurred")
        }
    }

    useEffect(() => {
        const getInitials = async() => {
            setIsLoading(true)

            try {
                const clients = await getClient()
                const lands = await getLands()
                const projects = await getProjects()
                const requests = await getRequests()
                const users = await getUsers()
    
                if (!clients || !lands || !projects || !requests || !users) return
    
                dispatch({ type: 'set-clients', paypload: { clients } })
                dispatch({ type: 'set-lands', paypload: { lands } })
                dispatch({ type: 'set-projects', paypload: { projects } })
                dispatch({ type: 'set-lease-request', paypload: { requests } })
                dispatch({ type: 'set-users', paypload: { users } })
            } catch(error) {
                console.log(error)
            } finally {
                setIsLoading(false)
            }
        }

        getInitials()
    }, [])

    return (
        <AppContext.Provider value={{ state, dispatch, isLoading, setIsLoading, setError }}>
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