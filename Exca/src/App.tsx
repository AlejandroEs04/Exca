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
import Project from "./views/Projects/Project"
import EditProject from "./views/Projects/EditProject"
import ContractRequest from "./views/ContractRequest/ContractRequest"

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainLayout />}>
          <Route index element={<Index />} />

          <Route path="/projects" element={<Projects />} />
          <Route path="/projects/:id" element={<Project />} />
          <Route path="/projects/create" element={<CreateProject />} />
          <Route path="/projects/edit/:id" element={<EditProject />} />

          <Route path="/clients" element={<Clients />} />
          <Route path="/clients/create" element={<CreateClient />} />
          <Route path="/clients/edit/:id" element={<EditClient />} />

          <Route path="/lands" element={<Lands />} />
          <Route path="/lands/create" element={<CreateLand />} />

          <Route path="/contract-request/:projectId" element={<ContractRequest />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}

export default App
