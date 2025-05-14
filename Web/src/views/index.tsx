import styles from './index.module.css'
import { Link, useNavigate } from "react-router-dom"
import { useAppContext } from "../hooks/AppContext"

export default function Index() {
    const { state } = useAppContext()
    const navigate = useNavigate()

    const handleProject = (id: number) => navigate(`/projects/${id}`)

    return (
        <>
            <h1 className={styles.welcomeMessage}>Bienvenido, <span>{state.auth?.full_name}</span></h1>
            <div className={`${styles.dashboardNav} mt-1`}>
                <div className={`${styles.dashboardCard} ${styles.cardBlue}`}>
                    <Link to="/settings/users/create">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor" className={styles.icon}>
                            <path strokeLinecap="round" strokeLinejoin="round" d="M18 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0ZM3 19.235v-.11a6.375 6.375 0 0 1 12.75 0v.109A12.318 12.318 0 0 1 9.374 21c-2.331 0-4.512-.645-6.374-1.766Z" />
                        </svg>
                        Registrar Usuario                    
                    </Link>
                </div>

                <div className={`${styles.dashboardCard} ${styles.cardPurple}`}>
                    <Link to="/lands/create">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor" className={styles.icon}>
                            <path strokeLinecap="round" strokeLinejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                        </svg>
                        Registrar Terrenos
                    </Link>
                </div>

                <div className={`${styles.dashboardCard} ${styles.cardGreen}`}>
                    <Link to="/projects">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className={styles.icon}>
                            <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 21v-7.5a.75.75 0 0 1 .75-.75h3a.75.75 0 0 1 .75.75V21m-4.5 0H2.36m11.14 0H18m0 0h3.64m-1.39 0V9.349M3.75 21V9.349m0 0a3.001 3.001 0 0 0 3.75-.615A2.993 2.993 0 0 0 9.75 9.75c.896 0 1.7-.393 2.25-1.016a2.993 2.993 0 0 0 2.25 1.016c.896 0 1.7-.393 2.25-1.015a3.001 3.001 0 0 0 3.75.614m-16.5 0a3.004 3.004 0 0 1-.621-4.72l1.189-1.19A1.5 1.5 0 0 1 5.378 3h13.243a1.5 1.5 0 0 1 1.06.44l1.19 1.189a3 3 0 0 1-.621 4.72M6.75 18h3.75a.75.75 0 0 0 .75-.75V13.5a.75.75 0 0 0-.75-.75H6.75a.75.75 0 0 0-.75.75v3.75c0 .414.336.75.75.75Z" />
                        </svg>
                        Ver Proyectos
                    </Link>
                </div>

                <div className={`${styles.dashboardCard} ${styles.cardOrange}`}>
                    <Link to="#">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor" className={styles.icon}>
                            <path strokeLinecap="round" strokeLinejoin="round" d="M10.125 2.25h-4.5c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125v-9M10.125 2.25h.375a9 9 0 0 1 9 9v.375M10.125 2.25A3.375 3.375 0 0 1 13.5 5.625v1.5c0 .621.504 1.125 1.125 1.125h1.5a3.375 3.375 0 0 1 3.375 3.375M9 15l2.25 2.25L15 12" />
                        </svg>  

                        Revisar Aprobaciones
                    </Link>
                </div>
            </div>

            <h2 className='mt-3'>Proyectos activos</h2>
            <table className="mt-1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Fraccionamiento</th>
                        <th>Cliente</th>
                        <th>Marca</th>
                        <th>Estatus</th>
                    </tr>
                </thead>
                
                <tbody>
                    {state.projects.map(project => (
                        <tr onClick={() => handleProject(project.id)} key={project.id}>
                            <td>{project.id}</td>
                            <td>
                                {project?.project_lands?.map(land => land.land?.residential_development?.name).join(', ')}
                            </td>
                            <td>{project.brand?.client?.business_name}</td>
                            <td>{project.brand?.name}</td>
                            <td>{project.stage?.name}</td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <h2 className='mt-2'>Cumplimiento de pagos</h2>
        </>
    )
}
