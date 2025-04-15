import { BrowserRouter, Route, Routes } from "react-router-dom"
import MainLayout from "./layouts/MainLayout"
import Index from "./views"

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainLayout />}>
          <Route index element={<Index />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}

export default App
