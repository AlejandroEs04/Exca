import { Outlet } from "react-router-dom"
import { ToastContainer } from "react-toastify"
import { motion } from "framer-motion"

export default function AuthLayout() {
    return (
        <motion.div
            initial={{ opacity: 0, x: 100 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -100 }}
            transition={{ duration: 0.2, ease: "easeInOut" }}
        >
            <div className="auth-view">
                <div className="bg-auth">
                    {/* <span className="bubble bubble-blue"></span>
                    <span className="bubble bubble-purple"></span>
                    <span className="bubble bubble-green"></span> */}
                </div>
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
        </motion.div>
    )
}
