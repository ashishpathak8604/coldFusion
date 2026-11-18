import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],

  // frontend api request to the backend//
  server: {
    proxy : {
      "/api": {
        target: "http://localhost:8500/rest/assignment",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
      },
    },
  },
});


