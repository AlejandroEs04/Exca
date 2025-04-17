import { BrowserRouter, Route, Routes } from "react-router-dom"
import MainLayout from "./layouts/MainLayout"
import Index from "./views/Index"
import Projects from "./views/Projects/Projects"
import CreateProject from "./views/Projects/CreateProject"

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainLayout />}>
          <Route index element={<Index />} />

          <Route path="/projects" element={<Projects />} />
          <Route path="/projects/create" element={<CreateProject />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}

export default App
