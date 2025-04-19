import React, { createContext, useContext, ReactNode, useReducer, Dispatch, useEffect } from 'react';
import { AppActions, AppReducer, AppState, initialState } from "../reducers/app-reducer";
import { getCompanies } from '../api/CompanyApi';
import { getLands } from '../api/LandApi';

interface AppContextProps {
    state: AppState
    dispatch: Dispatch<AppActions>
}

const AppContext = createContext<AppContextProps | undefined>(undefined);

export const AppProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
    const [state, dispatch] = useReducer(AppReducer, initialState)

    useEffect(() => {
        const getInitials = async() => {
            const companies = await getCompanies()
            const lands = await getLands()

            if (!companies || !lands) return

            dispatch({ type: 'set-companies', paypload: { companies } })
            dispatch({ type: 'set-lands', paypload: { lands } })
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