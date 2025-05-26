// src/layouts/MainLayout.tsx
import { Link, Outlet, useLocation } from 'react-router-dom'
import { ToastContainer } from 'react-toastify'
import { useAppContext } from '../hooks/AppContext'
import { motion } from 'framer-motion'
import Loader from '../components/shared/Loader/Loader'
import { useState } from 'react'

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
              <div className="title">
                <h1>
                  GP <span>Vivienda</span>
                </h1>
              </div>

              <nav className="mt-2">
                <Link className={pathname === '/' ? 'active' : ''} to={'/'}>
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
                      d="m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 
                         9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 
                         1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 
                         1.125-.504 1.125-1.125V9.75M8.25 21h8.25"
                    />
                  </svg>
                  <span className="link-text">Resumen Ejecutivo</span>
                </Link>
                <Link className={pathname.includes('lands') ? 'active' : ''} to={'/lands'}>
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
                      d="M6 6.878V6a2.25 2.25 0 0 1 2.25-2.25h7.5A2.25 
                         2.25 0 0 1 18 6v.878m-12 0c.235-.083.487-.128.75-.128h10.5c.263 
                         0 .515.045.75.128m-12 0A2.25 2.25 0 0 0 4.5 9v.878m13.5-3A2.25 
                         2.25 0 0 1 19.5 9v.878m0 0a2.246 2.246 0 0 0-.75-.128H5.25c-.263 
                         0-.515.045-.75.128m15 0A2.25 2.25 0 0 1 21 12v6a2.25 2.25 0 0 1-2.25 
                         2.25H5.25A2.25 2.25 0 0 1 3 18v-6c0-.98.626-1.813 1.5-2.122"
                    />
                  </svg>
                  <span className="link-text">Inventario de terrenos</span>
                </Link>
                <Link className={pathname.includes('projects') ? 'active' : ''} to={'/projects'}>
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
                      d="M15.75 17.25v3.375c0 .621-.504 1.125-1.125 
                         1.125h-9.75a1.125 1.125 0 0 1-1.125-1.125V7.875c0-.621.504-1.125 
                         1.125-1.125H6.75a9.06 9.06 0 0 1 1.5.124m7.5 10.376h3.375c.621 
                         0 1.125-.504 1.125-1.125V11.25c0-4.46-3.243-8.161-7.5-8.876a9.06 
                         9.06 0 0 0-1.5-.124H9.375c-.621 0-1.125.504-1.125 
                         1.125v3.5m7.5 10.375H9.375a1.125 1.125 0 0 1-1.125-1.125v-9.25"
                    />
                  </svg>
                  <span className="link-text">Cartera de interesados</span>
                </Link>
                <Link className={pathname.includes('clients') ? 'active' : ''} to={'/clients'}>
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
                      d="M2.25 21h19.5m-18-18v18m10.5-18v18m6-13.5V21M6.75 
                         6.75h.75m-.75 3h.75m-.75 3h.75m3-6h.75m-.75 3h.75m-.75 
                         3h.75M6.75 21v-3.375c0-.621.504-1.125 1.125-1.125h2.25c.621 
                         0 1.125.504 1.125 1.125V21M3 3h12m-.75 4.5H21m-3.75 
                         3.75h.008v.008h-.008v-.008Zm0 3h.008v.008h-.008v-.008Zm0 
                         3h.008v.008h-.008v-.008Z"
                    />
                  </svg>
                  <span className="link-text">Cartera Arrendatarios</span>
                </Link>
                <Link
                  className={pathname.includes('approval-requests') ? 'active' : ''}
                  to={'/approval-requests'}
                >
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
                      d="M9 12.75 11.25 15 15 9.75M21 
                         12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 0 1-1.043 
                         3.296 3.745 3.745 0 0 1-3.296 1.043A3.745 3.745 0 0 1 
                         12 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 0 1-3.296-1.043 
                         3.745 3.745 0 0 1-1.043-3.296A3.745 3.745 0 0 1 3 
                         12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 0 1 
                         1.043-3.296 3.746 3.746 0 0 1 3.296-1.043A3.746 3.746 
                         0 0 1 12 3c1.268 0 2.39.63 3.068 
                         1.593a3.746 3.746 0 0 1 3.296 1.043 3.746 3.746 0 0 1 
                         1.043 3.296A3.745 3.745 0 0 1 21 12Z"
                    />
                  </svg>
                  <span className="link-text">Seguimiento</span>
                </Link>
                <Link to={'/administration'}>
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
                      d="M6.75 3v2.25M17.25 
                         3v2.25M3 7.5h18M4.5 21h15a.75.75 0 00.75-.75V6.75A.75.75 
                         0 0019.5 6h-15a.75.75 0 00-.75.75v13.5c0 .414.336.75.75.75z
                         M8.25 10.5h7.5M8.25 13.5h7.5M8.25 16.5h4.5"
                    />
                  </svg>
                  <span className="link-text">Administración</span>
                </Link>
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
                  <span className="link-text">Catálogos</span>
                </a>

                {catalogsOpen && (
                  <div className="submenu">
                    <Link to="/states" className={pathname.includes('states') ? 'active' : ''}>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="icon"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        strokeWidth={2}
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          d="M12 21C15.5 17.4 19 14.1764 19 10.2C19 6.22355 15.866 3 12 3C8.13401 3 5 6.22355 5 10.2C5 14.1764 8.5 17.4 12 21Z"
                        />
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          d="M12 12C13.1046 12 14 11.1046 14 10C14 8.89543 13.1046 8 12 8C10.8954 8 10 8.89543 10 10C10 11.1046 10.8954 12 12 12Z"
                        />
                      </svg>
                      <span className="link-text">Fraccionamientos</span>
                    </Link>

                    <Link to="/states" className={pathname.includes('states') ? 'active' : ''}>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="icon"
                        fill="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path d="M9.70711 4.79289C9.41421 4.5 8.94281 4.5 8 4.5H7.75V3C7.75 2.58579 7.41421 2.25 7 2.25C6.58579 2.25 6.25 2.58579 6.25 3V4.5H6C5.05719 4.5 4.58579 4.5 4.29289 4.79289C4 5.08579 4 5.55719 4 6.5V6.7038C4.20249 6.65059 4.40564 6.61348 4.60559 6.5866C5.25121 6.4998 6.04487 6.49989 6.9105 6.49999H7.0895C7.95513 6.49989 8.74879 6.4998 9.39441 6.5866C9.59436 6.61348 9.79751 6.65059 9.99999 6.7038L10 6.5C10 5.55719 10 5.08579 9.70711 4.79289Z" />
                        <path
                          fillRule="evenodd"
                          clipRule="evenodd"
                          d="M2 21.25C1.58579 21.25 1.25 21.5858 1.25 22C1.25 22.4142 1.58579 22.75 2 22.75H22C22.4142 22.75 22.75 22.4142 22.75 22C22.75 21.5858 22.4142 21.25 22 21.25H21V7.77195C21 6.4311 21 5.76068 20.6439 5.24676C20.2877 4.73283 19.66 4.49743 18.4045 4.02663C15.9492 3.10591 14.7216 2.64555 13.8608 3.2421C13 3.83864 13 5.14974 13 7.77195V10.5L13.0895 10.5C13.9551 10.4999 14.7488 10.4998 15.3944 10.5866C16.1054 10.6822 16.8568 10.9071 17.4749 11.5251C18.0929 12.1432 18.3178 12.8946 18.4134 13.6056C18.5002 14.2512 18.5001 15.0449 18.5 15.9105L18.5 16V21.25H17V16C17 14.1144 17 13.1716 16.4142 12.5858C15.8284 12 14.8856 12 13 12H11C9.11438 12 8.17157 12 7.58579 12.5858C7 13.1716 7 14.1144 7 16V21.25H5.5V16L5.49999 15.9105C5.49989 15.0449 5.4998 14.2512 5.5866 13.6056C5.68219 12.8946 5.90708 12.1432 6.52513 11.5251C7.14317 10.9071 7.89462 10.6822 8.60558 10.5866C9.25121 10.4998 10.0449 10.4999 10.9105 10.5L10.9825 10.5C10.9436 9.56385 10.8183 8.98987 10.4142 8.58579C9.82843 8 8.88562 8 7 8C5.11438 8 4.17157 8 3.58579 8.58579C3 9.17157 3 10.1144 3 12V21.25H2Z"
                        />
                      </svg>
                      <span className="link-text">Ciudades</span>
                    </Link>

                    <Link to="/states" className={pathname.includes('states') ? 'active' : ''}>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="icon"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        strokeWidth={2}
                      >
                        <path strokeLinecap="round" strokeLinejoin="round" d="M12 6H12.01" />
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          d="M9 20L3 17V4L5 5M9 20L15 17M9 20V14M15 17L21 20V7L19 6M15 17V14M15 6.2C15 7.96731 13.5 9.4 12 11C10.5 9.4 9 7.96731 9 6.2C9 4.43269 10.3431 3 12 3C13.6569 3 15 4.43269 15 6.2Z"
                        />
                      </svg>
                      <span className="link-text">Estados</span>
                    </Link>

                    <Link to="/land-types" className={pathname.includes('land-types') ? 'active' : ''}>
                      <svg className="icon"
                      viewBox="0 0 16 16" 
                      fill="none" 
                      xmlns="http://www.w3.org/2000/svg">
                        <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                        <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                        <g id="SVGRepo_iconCarrier"> 
                          <path d="M5 8V6.20711L6.5 4.70711L8 6.20711V8H5Z" fill="#000000"></path> 
                          <path fill-rule="evenodd" clip-rule="evenodd" d="M0 6.5C0 2.91015 2.91015 0 6.5 0C10.0899 0 13 2.91015 13 6.5C13 8.11493 12.4111 9.59231 11.4362 10.7291L14.8536 14.1464L14.1465 14.8535L10.7291 11.4362C9.59237 12.411 8.11496 13 6.5 13C2.91015 13 0 10.0899 0 6.5ZM8.85355 5.64645L6.85355 3.64645C6.65829 3.45118 6.34171 3.45118 6.14645 3.64645L4.14645 5.64645C4.05268 5.74021 4 5.86739 4 6V8.5C4 8.77614 4.22386 9 4.5 9H8.5C8.77614 9 9 8.77614 9 8.5V6C9 5.86739 8.94732 5.74021 8.85355 5.64645Z" fill="#000000"></path> 
                        </g>
                      </svg>
                      <span className="link-text">Tipos de Terrenos</span>
                    </Link>

                    <Link to="/land-categories" className={pathname.includes('land-categories') ? 'active' : ''}>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="icon"
                        fill="currentColor"
                        viewBox="0 0 1024 1024"
                      >
                        <path d="M627.226 581.619c41.324 14.269 69.619 53.31 69.619 97.746 0 57.103-46.28 103.383-103.383 103.383-38.183 0-72.667-20.854-90.712-53.74-5.441-9.916-17.89-13.544-27.807-8.103s-13.544 17.89-8.103 27.807c25.168 45.868 73.336 74.997 126.622 74.997 79.724 0 144.343-64.619 144.343-144.343 0-62.038-39.497-116.535-97.211-136.463-10.691-3.692-22.351 1.983-26.043 12.674s1.983 22.351 12.674 26.043z" />
                        <path d="M532.582 543.703c0-57.092-46.291-103.383-103.383-103.383s-103.383 46.291-103.383 103.383 46.291 103.383 103.383 103.383 103.383-46.291 103.383-103.383zm40.96 0c0 79.714-64.629 144.343-144.343 144.343s-144.343-64.629-144.343-144.343c0-79.714 64.629-144.343 144.343-144.343s144.343 64.629 144.343 144.343z" />
                        <path d="M106.544 501.695l385.403-380.262c11.913-11.754 31.079-11.722 42.955.075l382.71 380.14c8.025 7.971 20.992 7.927 28.963-.098s7.927-20.992-.098-28.963l-382.71-380.14c-27.811-27.625-72.687-27.7-100.589-.171L77.775 472.539c-8.051 7.944-8.139 20.911-.194 28.962s20.911 8.139 28.962.194z" />
                        <path d="M783.464 362.551v517.12c0 16.962-13.758 30.72-30.72 30.72h-481.28c-16.962 0-30.72-13.758-30.72-30.72v-517.12c0-11.311-9.169-20.48-20.48-20.48s-20.48 9.169-20.48 20.48v517.12c0 39.583 32.097 71.68 71.68 71.68h481.28c39.583 0 71.68-32.097 71.68-71.68v-517.12c0-11.311-9.169-20.48-20.48-20.48s-20.48 9.169-20.48 20.48z" />
                      </svg>
                      <span className="link-text">Categorías de Terrenos</span>
                    </Link>

                    <Link to="/land-statuses" className={pathname.includes('land-statuses') ? 'active' : ''}>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="icon"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        strokeWidth={2}
                      >
                        <path strokeLinecap="round" strokeLinejoin="round" d="M7 7H8M7 10H8M12 10H13M12 13H13M7 13H8M12 7H13" />
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          d="M8 21V18C8 16.8954 8.89543 16 10 16C10.5973 16 11.1335 16.2619 11.5 16.6771M16 15V4.6C16 4.03995 16 3.75992 15.891 3.54601C15.7951 3.35785 15.6422 3.20487 15.454 3.10899C15.2401 3 14.9601 3 14.4 3H5.6C5.03995 3 4.75992 3 4.54601 3.10899C4.35785 3.20487 4.20487 3.35785 4.10899 3.54601C4 3.75992 4 4.03995 4 4.6V21H11.5M15 19L17 21L21 17"
                        />
                      </svg>
                      <span className="link-text">Estatus de Terrenos</span>
                    </Link>
                  </div>
                )}
                <Link className={pathname.includes('settings') ? 'active' : ''} to={'/settings'}>
                  
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="icon">
                        <path strokeLinecap="round" strokeLinejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z" />
                        <path strokeLinecap="round" strokeLinejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                    </svg>
                  <span className="link-text">Configuraciones</span>
                </Link>
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
