import { BrowserRouter, Route, Routes } from "react-router-dom"
import MainLayout from "./layouts/MainLayout"
import Index from "./views/Index"
import Projects from "./views/Projects/Projects"
import CreateProject from "./views/Projects/CreateProject"
import Companies from "./views/Company/Companies"
import Lands from "./views/Land/Lands"
import CreateLand from "./views/Land/CreateLand"
import CreateCompany from "./views/Company/CreateCompany"

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainLayout />}>
          <Route index element={<Index />} />

          <Route path="/projects" element={<Projects />} />
          <Route path="/projects/create" element={<CreateProject />} />

          <Route path="/companies" element={<Companies />} />
          <Route path="/companies/create" element={<CreateCompany />} />

          <Route path="/lands" element={<Lands />} />
          <Route path="/lands/create" element={<CreateLand />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}

export default App
