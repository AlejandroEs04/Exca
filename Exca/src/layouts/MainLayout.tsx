import { Link, Outlet } from 'react-router-dom'

export default function MainLayout() {
    return (
        <div>
            <header>
                <Link to={'/projects'}>Proyectos</Link>
            </header>

            <div className='container'>
                <Outlet />
            </div>
        </div>
    )
}
