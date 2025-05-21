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
    checkToken: () => Promise<void>
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

            dispatch({ type: 'set-auth', payload: { auth: response } });
        } catch (error) {
            navigate('/login');
        } finally {
            setIsLoading(false)
        }
    };

const getInitials = async () => {
        setIsLoading(true)

        try {
            // Carga los datos importantes primero
            const [
                projects,
                clients,
                lands,
                users,
                individuals
            ] = await Promise.all([
                getProjects(),
                getClient(),
                getLands(),
                getUsers(),
                getIndividuals()
            ])

            if(!clients || !lands || !projects || !users || !individuals) return 

            dispatch({ type: 'set-clients', payload: { clients } })
            dispatch({ type: 'set-lands', payload: { lands } })
            dispatch({ type: 'set-projects', payload: { projects } })
            dispatch({ type: 'set-users', payload: { users } })
            dispatch({ type: 'set-individual', payload: { individuals } })

            // Después carga las condiciones sin bloquear la interfaz
            getConditions().then((conditions) => {
                if(conditions)
                    dispatch({ type: 'set-conditions', payload: { conditions } })
            }).catch((error) => {
                console.error("Error loading conditions:", error)
            })
        } catch (error) {
            handleError(error)
        } finally {
            setIsLoading(false)
        }
    }

    useEffect(() => {
        if(state.auth) getInitials()
    }, [state.auth])

    useEffect(() => {
        const getAuth = async() => await checkToken();

        getAuth()
    }, [])

    return (
        <AppContext.Provider value={{ state, dispatch, isLoading, setIsLoading, setError, handleLogOut, checkToken }}>
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