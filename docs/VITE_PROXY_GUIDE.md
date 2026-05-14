# Vite Reverse Proxy Setup Guide

This guide explains how to configure Vite's development server to act as a reverse proxy. This is primarily used during development to route API requests to a backend server, bypassing CORS issues.

## 1. Basic Configuration

Open your `vite.config.js` file and add the `server.proxy` object.

```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      // Simple proxying: http://localhost:5173/api -> http://localhost:3000/api
      '/api': 'http://localhost:3000',
    }
  }
})
```

## 2. Advanced Options

For more control, you can provide an object with configuration options.

```javascript
export default defineConfig({
  server: {
    proxy: {
      '/api': {
        target: 'http://backend-server.com',
        changeOrigin: true, // Needed for virtual hosted sites
        secure: false,      // If you want to proxy to an HTTPS target with invalid certs
        rewrite: (path) => path.replace(/^\/api/, ''), // Remove /api prefix before sending
      },
    }
  }
})
```

### Key Parameters:
- **`target`**: The destination host.
- **`changeOrigin`**: Changes the origin of the host header to the target URL. Use this if the backend checks the `Origin` or `Host` header.
- **`rewrite`**: A function that allows you to modify the request path.
- **`ws: true`**: Enable this if you need to proxy WebSockets.
- **`configure`**: A function that gives you access to the `proxy` instance (from `http-proxy`) for custom event listeners or logging.

## 3. Using Regular Expressions

You can use regex to match multiple paths or more complex patterns.

```javascript
export default defineConfig({
  server: {
    proxy: {
      // Proxying all requests starting with /api or /auth
      '^/(api|auth)': {
        target: 'http://localhost:3000',
        changeOrigin: true,
      },
    }
  }
})
```

## 4. Troubleshooting

1. **Check the Logs**: If the proxy isn't working, you can add a `configure` block to log requests:
   ```javascript
   configure: (proxy, _options) => {
     proxy.on('error', (err, _req, _res) => {
       console.log('proxy error', err);
     });
     proxy.on('proxyReq', (proxyReq, req, _res) => {
       console.log('Sending Request to the Target:', req.method, req.url);
     });
     proxy.on('proxyRes', (proxyRes, req, _res) => {
       console.log('Received Response from the Target:', proxyRes.statusCode, req.url);
     });
   },
   ```
2. **Path Rewriting**: Ensure your `rewrite` logic matches what the backend expects. If the backend already expects `/api`, don't use `path.replace(/^\/api/, '')`.
3. **Trailing Slashes**: Be mindful of trailing slashes in your `target` URL and proxy keys.

## 5. Security Note

Vite's proxy is **only for development**. For production, you should configure a "real" reverse proxy like Nginx, Apache, or handle it within your cloud provider's load balancer/ingress settings.
