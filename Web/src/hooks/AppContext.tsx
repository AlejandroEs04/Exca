import React, { createContext, useContext, ReactNode, useReducer, Dispatch, useEffect, useState } from 'react';
import { AppActions, AppReducer, AppState, initialState } from "../reducers/app-reducer";
import { getLands } from '../api/LandApi';
import { getClient } from '../api/ClientApi';
import { getProjects } from '../api/ProjectApi';
import { getUsers } from '../api/UserApi';
import { toast } from 'react-toastify';
import { getIndividuals } from '../api/IndividualApi';
import { getConditions } from '../api/ConditionApi';
import { handleError } from '../utils';
import { getAuth } from '../api/AuthApi';
import { useNavigate } from 'react-router-dom';

interface AppContextProps {
    state: AppState
    dispatch: Dispatch<AppActions>
    isLoading: boolean
    setIsLoading: React.Dispatch<React.SetStateAction<boolean>>
    setError: (error: any) => void
    handleLogOut: () => void
}

const AppContext = createContext<AppContextProps | undefined>(undefined);

export const AppProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
    const [state, dispatch] = useReducer(AppReducer, initialState)
    const [isLoading, setIsLoading] = useState(false)
    const navigate = useNavigate()

    const setError = (error: any) => {
        console.log(error.message)
        if (error instanceof Error) {
            toast.error(error.message)
        } else {
            toast.error("An unexpected error occurred")
        }
    }

    const isTokenExpired = (token: string) => {
        try {
            const [, payloadBase64] = token.split('.');
            const payload = JSON.parse(atob(payloadBase64));
            const now = Math.floor(Date.now() / 1000);
            return payload.exp < now;
        } catch (e) {
            return true;
        }
    };

    const handleLogOut = () => {
        localStorage.removeItem('token')
        navigate('/login');
    }

    const checkToken = async () => {
        const token = localStorage.getItem('token');
        if (!token || isTokenExpired(token)) {
            navigate('/login');
            return;
        }

        try {
            setIsLoading(true)

            const response = await getAuth();
            
            if (!response) {
                navigate('/login');
                return
            }

            dispatch({ type: 'set-auth', paypload: { auth: response } });
        } catch (error) {
            navigate('/login');
        } finally {
            setIsLoading(false)
        }
    };

    useEffect(() => {
        const getInitials = async() => {
            await checkToken();
            setIsLoading(true)

            try {
                const clients = await getClient()
                const lands = await getLands()
                const projects = await getProjects()
                const users = await getUsers()
                const individuals = await getIndividuals()
                const conditions = await getConditions()
    
                if (!clients || !lands || !projects || !users || !individuals || !conditions) return
    
                dispatch({ type: 'set-clients', paypload: { clients } })
                dispatch({ type: 'set-lands', paypload: { lands } })
                dispatch({ type: 'set-projects', paypload: { projects } })
                dispatch({ type: 'set-users', paypload: { users } })
                dispatch({ type: 'set-individual', paypload: { individuals } })
                dispatch({ type: 'set-conditions', paypload: { conditions } })
            } catch(error) {
                handleError(error)
            } finally {
                setIsLoading(false)
            }
        }
        getInitials()
    }, [])

    return (
        <AppContext.Provider value={{ state, dispatch, isLoading, setIsLoading, setError, handleLogOut }}>
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