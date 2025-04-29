import { Link } from "react-router-dom"
import Breadcrumb from "../../components/shared/Breadcrumb/Breadcrumb"
import styles from './Settings.module.css'

export default function Settings() {
    const list = [
        {name:"Dashboard",url:'/'},
        {name:"Configuraciones",url:'/settings'},
    ]

    return (
        <>
            <Breadcrumb list={list} />
            <h1>Configuraciones</h1>

            <nav className={styles.nav}>
                <Link to={'users'}>Usuarios</Link>
                <Link to={'approval-flows'}>Flujos</Link>
            </nav>
        </>
    )
}
