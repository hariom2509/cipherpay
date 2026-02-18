import { Routes, Route } from 'react-router-dom'
import Employer from './pages/Employer'
import Employee from './pages/Employee'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Employer />} />
      <Route path="/employee" element={<Employee />} />
    </Routes>
  )
}
