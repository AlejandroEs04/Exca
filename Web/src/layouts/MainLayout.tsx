// src/layouts/MainLayout.tsx
import { Link, Outlet, useLocation } from 'react-router-dom'
import { ToastContainer } from 'react-toastify'
import { useAppContext } from '../hooks/AppContext'
import { motion } from 'framer-motion'
import Loader from '../components/shared/Loader/Loader'
import { ReactElement, useState } from 'react'
import Home from '../components/shared/Icons/Home'
import List from '../components/shared/Icons/List'
import DocumentTextIcon from '../components/shared/Icons/DocumentTextIcon'
import Build from '../components/shared/Icons/Build'
import CheckListCircle from '../components/shared/Icons/CheckListCircle'
import Calendar from '../components/shared/Icons/Calendar'
import Gear from '../components/shared/Icons/Gear'

type ThemedLinkProps = {
  to: string
  icon: ReactElement
  text: string
}

const ThemedLink = ({ to, icon, text } : ThemedLinkProps) => {
  const { pathname } = useLocation()

  return (
    <Link to={to} className={`${pathname === to ? 'active' : ''}`}>
      {icon}
      <p>{text}</p>
    </Link>
  )
}

export default function MainLayout() {
  const { pathname } = useLocation()
  const { isLoading, handleLogOut } = useAppContext()
  const [catalogsOpen, setCatalogsOpen] = useState(false)

  return (
    <>
      <div className="main-layout">
        <aside className="aside-navigation">
          <div className="nav-container">
            <div>
              <nav className="mt-2">
                <h1>GP Vivienda</h1>
                <ThemedLink to='/' text='Resumen Ejecutivo' icon={<Home />} />
                <ThemedLink to='/lands' text='Inventario de terrenos' icon={<List />} />
                <ThemedLink to='/projects' text='Cartera de Interesados' icon={<DocumentTextIcon />} />
                <ThemedLink to='/clients' text='Cartera de arrendatarios' icon={<Build />} />
                <ThemedLink to='/approval-requests' text='Seguimiento' icon={<CheckListCircle />} />
                <ThemedLink to='/administration' text='Administración' icon={<Calendar />} />
                <a
                  className={catalogsOpen ? 'submenu-toggle active' : 'submenu-toggle'}
                  onClick={() => setCatalogsOpen(open => !open)}
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="icon"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    strokeWidth={1.5}
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      d="M3 7.5A2.25 2.25 0 015.25 5.25h4.5L12 7.5h6.75A2.25 2.25 0 0121 9.75v8.25A2.25 2.25 0 0118.75 20.25H5.25A2.25 2.25 0 013 18V7.5z"
                    />
                  </svg>
                  <p className="link-text">Catálogos</p>
                </a>
                    <div className={`submenu ${catalogsOpen ? 'active' : ''}`}>
                        <Link to="/residential-development" className={pathname.includes('states') ? 'active' : ''}>
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                            <path strokeLinecap="round" strokeLinejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
                          </svg>
                          <span className="link-text">Fraccionamientos</span>
                        </Link>
                        
                        <Link to="/states" className={pathname.includes('states') ? 'active' : ''}>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                              <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 21h19.5m-18-18v18m10.5-18v18m6-13.5V21M6.75 6.75h.75m-.75 3h.75m-.75 3h.75m3-6h.75m-.75 3h.75m-.75 3h.75M6.75 21v-3.375c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21M3 3h12m-.75 4.5H21m-3.75 3.75h.008v.008h-.008v-.008Zm0 3h.008v.008h-.008v-.008Zm0 3h.008v.008h-.008v-.008Z" />
                            </svg>
                            <span className="link-text">Ciudades</span>
                        </Link>
                        <Link to="/states" className={pathname.includes('states') ? 'active' : ''}>
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
                          </svg>
                          <span className="link-text">Estados</span>
                        </Link>
                        <Link to="/land-types" className={pathname.includes('land-types') ? 'active' : ''}>
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25ZM6.75 12h.008v.008H6.75V12Zm0 3h.008v.008H6.75V15Zm0 3h.008v.008H6.75V18Z" />
                          </svg>
                          <span className="link-text">Tipos de Terreno</span>
                        </Link>
                        <Link to="/land-categories" className={pathname.includes('land-categories') ? 'active' : ''}>
                            <svg  className="icon" fill="#none" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" strokeWidth="0"></g><g id="SVGRepo_tracerCarrier" strokeLinecap="round" strokeLinejoin="round"></g><g id="SVGRepo_iconCarrier"><path d="M627.226 581.619c41.324 14.269 69.619 53.31 69.619 97.746 0 57.103-46.28 103.383-103.383 103.383-38.183 0-72.667-20.854-90.712-53.74-5.441-9.916-17.89-13.544-27.807-8.103s-13.544 17.89-8.103 27.807c25.168 45.868 73.336 74.997 126.622 74.997 79.724 0 144.343-64.619 144.343-144.343 0-62.038-39.497-116.535-97.211-136.463-10.691-3.692-22.351 1.983-26.043 12.674s1.983 22.351 12.674 26.043z"></path><path d="M532.582 543.703c0-57.092-46.291-103.383-103.383-103.383s-103.383 46.291-103.383 103.383 46.291 103.383 103.383 103.383 103.383-46.291 103.383-103.383zm40.96 0c0 79.714-64.629 144.343-144.343 144.343s-144.343-64.629-144.343-144.343c0-79.714 64.629-144.343 144.343-144.343s144.343 64.629 144.343 144.343z"></path><path d="M106.544 501.695l385.403-380.262c11.913-11.754 31.079-11.722 42.955.075l382.71 380.14c8.025 7.971 20.992 7.927 28.963-.098s7.927-20.992-.098-28.963l-382.71-380.14c-27.811-27.625-72.687-27.7-100.589-.171L77.775 472.539c-8.051 7.944-8.139 20.911-.194 28.962s20.911 8.139 28.962.194z"></path><path d="M783.464 362.551v517.12c0 16.962-13.758 30.72-30.72 30.72h-481.28c-16.962 0-30.72-13.758-30.72-30.72v-517.12c0-11.311-9.169-20.48-20.48-20.48s-20.48 9.169-20.48 20.48v517.12c0 39.583 32.097 71.68 71.68 71.68h481.28c39.583 0 71.68-32.097 71.68-71.68v-517.12c0-11.311-9.169-20.48-20.48-20.48s-20.48 9.169-20.48 20.48z"></path></g></svg>
                            <span className="link-text">Categorías de Terreno</span>
                        </Link>
                        <Link to="/land-statuses" className={pathname.includes('land-statuses') ? 'active' : ''}>
                            <svg className="icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" strokeWidth="0"></g><g id="SVGRepo_tracerCarrier" strokeLinecap="round" strokeLinejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7 7H8M7 10H8M12 10H13M12 13H13M7 13H8M12 7H13M8 21V18C8 16.8954 8.89543 16 10 16C10.5973 16 11.1335 16.2619 11.5 16.6771M16 15V4.6C16 4.03995 16 3.75992 15.891 3.54601C15.7951 3.35785 15.6422 3.20487 15.454 3.10899C15.2401 3 14.9601 3 14.4 3H5.6C5.03995 3 4.75992 3 4.54601 3.10899C4.35785 3.20487 4.20487 3.35785 4.10899 3.54601C4 3.75992 4 4.03995 4 4.6V21H11.5M15 19L17 21L21 17" stroke="#000000" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"></path> </g></svg>
                            <span className="link-text">Estatus de Terrenos</span>
                        </Link>
                        
                    </div>
                    <ThemedLink text='Configuraciones' to='settings' icon={<Gear />} />
              </nav>
            </div>

            <div className="p-nav mb-2">
              <button onClick={handleLogOut} className="btn btn-primary w-full">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                  className="icon"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M8.25 9V5.25A2.25 2.25 0 0 1 10.5 3h6a2.25 
                       2.25 0 0 1 2.25 2.25v13.5A2.25 2.25 0 0 1 
                       16.5 21h-6a2.25 2.25 0 0 1-2.25-2.25V15m-3 
                       0-3-3m0 0 3-3m-3 3H15"
                  />
                </svg>
                <span className="link-text">Cerrar Sesión</span>
              </button>
            </div>
          </div>
        </aside>

        <div className="main-container">
          <main className="container">
            {isLoading ? (
              <Loader />
            ) : (
              <motion.div
                initial={{ opacity: 0, x: 100 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -30 }}
                transition={{ duration: 0.2, ease: 'easeInOut' }}
              >
                <Outlet />
              </motion.div>
            )}
          </main>
        </div>
      </div>

      <ToastContainer position="top-right" />
    </>
  )
}
