import { BrowserRouter, Route, Routes } from "react-router-dom"
import MainLayout from "./layouts/MainLayout"
import Index from "./views/Index"
import Projects from "./views/Projects/Projects"
import CreateProject from "./views/Projects/CreateProject"
import Lands from "./views/Land/Lands"
import CreateLand from "./views/Land/CreateLand"
import Clients from "./views/Client/Clients"
import CreateClient from "./views/Client/CreateClient"
import EditClient from "./views/Client/EditClient"

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainLayout />}>
          <Route index element={<Index />} />

          <Route path="/projects" element={<Projects />} />
          <Route path="/projects/create" element={<CreateProject />} />

          <Route path="/clients" element={<Clients />} />
          <Route path="/clients/create" element={<CreateClient />} />
          <Route path="/clients/edit/:id" element={<EditClient />} />

          <Route path="/lands" element={<Lands />} />
          <Route path="/lands/create" element={<CreateLand />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}

export default App
