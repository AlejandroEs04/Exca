import { Link } from 'react-router-dom'
import styles from './Header.module.css'
import Bell from '../Icons/Bell'
import ProfileIcon from '../Icons/ProfileIcon'
import { motion } from 'framer-motion'

export default function Header() {
    return (
        <div className={`${styles.headerContainer}`}>
            <div className={styles.title}>
                <h1>GP</h1>
            </div>
            <motion.div 
                initial={{ opacity: 0, x: 100 }}     
                animate={{ opacity: 1, x: 0 }}   
                exit={{ opacity: 0, x: -30 }}   
                transition={{ duration: 0.2, ease: "easeInOut" }}
                className={styles.navContainer}
            >
                <nav>
                    <Link to={'/notifications'}><Bell /></Link>
                    <Link to={'/profile'}><ProfileIcon /></Link>
                </nav>
            </motion.div>
        </div>  
    )
}
