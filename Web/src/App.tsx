import { Route, Routes, useLocation } from "react-router-dom"
import { AnimatePresence } from "framer-motion"
import MainLayout from "./layouts/MainLayout"
import Projects from "./views/Projects/Projects"
import CreateProject from "./views/Projects/CreateProject"
import Lands from "./views/Land/Lands"
import LandsToVerify from "./views/verifies/verifyLands"
import FormLand from "./views/verifies/FormLand"
import CreateLand from "./views/Land/CreateLand"
import Clients from "./views/Client/Clients"
import CreateClient from "./views/Client/CreateClient"
import EditClient from "./views/Client/EditClient"
import Project from "./views/Projects/Project"
import EditProject from "./views/Projects/EditProject"
import Users from "./views/User/Users"
import CreateUser from "./views/User/CreateUser"
import ApprovalFlow from "./views/ApprovalFlow/ApprovalFlow"
import ApprovalFlows from "./views/ApprovalFlow/ApprovalFlows"
import AuthLayout from "./layouts/AuthLayout"
import Login from "./views/Auth/Login"
import ApprovalRequest from "./views/ApprovalRequest/ApprovalRequest"
import Settings from "./views/Settings/Settings"
import Following from "./views/Following/Following"
import Client from "./views/Client/Client"
import Activities from "./views/Projects/Activities"

import Index from "./views"
import ProjectsToVerify from "./views/verifies/verifyProjects"
import FormProject from "./views/verifies/FormProject"
import AdministrationList from "./views/administration/administrationList"
import FormFacturacion from "./views/administration/FormFacturacion"

import Land from "./views/Land/Land"
import EditLand from "./views/Land/EditLand"
import TechnicalCase from "./views/Projects/TechnicalCase/TechnicalCase"
import LeaseRequest from "./views/Projects/LeaseRequest/LeaseRequest"
import LegalCase from "./views/Projects/LegalCase/LegalCase"
import CreateIndividual from "./views/Client/Individual/CreateIndividual"


function App() {
  const location = useLocation()

  return (
    <AnimatePresence mode="wait">
      <Routes location={location} key={location.pathname}>
        <Route path="/" element={<MainLayout />}>
          <Route index element={<Index />} />

          <Route path="/settings" element={<Settings />} />
          <Route path="/settings/users" element={<Users />} />
          <Route path="/settings/users/create" element={<CreateUser />} />

          <Route path="/projects" element={<Projects />} />
          <Route path="/projects/:id" element={<Project />} />
          <Route path="/projects/:id/activities" element={<Activities />} />
          <Route path="/projects/create" element={<CreateProject />} />
          <Route path="/projects/edit/:id" element={<EditProject />} />

          <Route path="/clients" element={<Clients />} />
          <Route path="/clients/:id" element={<Client />} />
          <Route path="/clients/create" element={<CreateClient />} />
          <Route path="/clients/edit/:id" element={<EditClient />} />
          <Route path="/clients/individual/create" element={<CreateIndividual />} />

          <Route path="/lands" element={<Lands />} />
          <Route path="/lands/:id" element={<Land />} />
          <Route path="/lands/create" element={<CreateLand />} />
          <Route path="/lands/edit/:id" element={<EditLand />} />

          <Route path="/contract-request/:projectId" element={<LeaseRequest />} />
          <Route path="/contract-request/:projectId/:leaseRequestId" element={<LeaseRequest />} />

          <Route path="/settings/approval-flows" element={<ApprovalFlows />} />
          <Route path="/settings/approval-flows/edit/:id" element={<ApprovalFlow />} />

          <Route path="/approval-requests" element={<ApprovalRequest />} />

          <Route path="/following" element={<Following />} />

          <Route path="/technical-case/:projectId" element={<TechnicalCase />} />
          <Route path="/technical-case/:projectId/:caseId" element={<TechnicalCase />} />

          <Route path="/verify-lands" element={<LandsToVerify />} />
          <Route path="/verify-lands/form-land/:id?" element={<FormLand />} />

          <Route path="/verify-projects" element={<ProjectsToVerify />} />
          <Route path="/verify-projects/form-project/:id?" element={<FormProject />} />

          <Route path="/administration" element={<AdministrationList />} />
          <Route path="/administration/billing/:id?" element={<FormFacturacion />} />

          <Route path="/legal-case/:projectId" element={<LegalCase />} />
          <Route path="/legal-case/:projectId/:caseId" element={<LegalCase />} />
          
        </Route>

        <Route path="/" element={<AuthLayout />}>
          <Route path="/login" element={<Login />} />
        </Route>
      </Routes>
    </AnimatePresence>
  )
}

export default App
