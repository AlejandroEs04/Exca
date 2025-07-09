import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'

// https://vite.dev/config/
export default defineConfig({
  server: {
    allowedHosts: ['potentia.ddns.net'],
    host: true,        // Permite acceso externo (0.0.0.0)
    port: 5173,        // O el puerto que estés usando
  },
  plugins: [react()],
})
