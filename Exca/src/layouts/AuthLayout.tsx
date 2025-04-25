import { Outlet } from "react-router-dom"
import { ToastContainer } from "react-toastify"

export default function AuthLayout() {
    return (
        <>
            <div className="auth-view">
                <div className="bg-auth"></div>
                <div className="auth-form-container">
                    <div className="content">
                        <Outlet />
                    </div>
                </div>
            </div>
            
            <ToastContainer 
                theme='dark'
                position="bottom-right"
            />
        </>
    )
}
