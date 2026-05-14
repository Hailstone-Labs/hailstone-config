# React Router Setup and Usage Guide

React Router is the standard routing library for React applications. This guide covers the modern approach using **Data APIs** (recommended for version 6.4+).

## 1. Installation

Install React Router:

```bash
bun add react-router-dom
```

## 2. Basic Configuration (Data APIs)

The modern way to define routes is using `createBrowserRouter`.

Create a `src/router.jsx` file:

```javascript
import { createBrowserRouter } from 'react-router-dom'
import Layout from './Layout'
import Home from './pages/Home'
import About from './pages/About'
import Contact from './pages/Contact'

export const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    children: [
      {
        index: true,
        element: <Home />,
      },
      {
        path: 'about',
        element: <About />,
      },
      {
        path: 'contact',
        element: <Contact />,
      },
    ],
  },
])
```

## 3. Providing the Router

In your `src/main.jsx`, use the `RouterProvider`:

```javascript
import React from 'react'
import ReactDOM from 'react-dom/client'
import { RouterProvider } from 'react-router-dom'
import { router } from './router'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
)
```

## 4. Creating a Layout with Outlet

The `Layout` component uses `<Outlet />` to render the child routes.

```javascript
import { Outlet, Link } from 'react-router-dom'

export default function Layout() {
  return (
    <div>
      <nav>
        <ul>
          <li><Link to="/">Home</Link></li>
          <li><Link to="/about">About</Link></li>
          <li><Link to="/contact">Contact</Link></li>
        </ul>
      </nav>
      <main>
        <Outlet />
      </main>
    </div>
  )
}
```

## 5. Dynamic Routing and Parameters

To handle dynamic segments like `/profile/:id`:

```javascript
// In router.jsx
{
  path: 'profile/:id',
  element: <Profile />,
}

// In Profile.jsx
import { useParams } from 'react-router-dom'

export default function Profile() {
  const { id } = useParams()
  return <h1>User Profile ID: {id}</h1>
}
```

## 6. Programmatic Navigation

Use the `useNavigate` hook to navigate via code (e.g., after a form submission).

```javascript
import { useNavigate } from 'react-router-dom'

export function LoginForm() {
  const navigate = useNavigate()

  const handleSubmit = () => {
    // ... login logic
    navigate('/dashboard')
  }

  return <button onClick={handleSubmit}>Login</button>
}
```

## Summary of Core Components

- **`<Link>`**: Used for client-side navigation (prevents page refresh).
- **`<NavLink>`**: Similar to `<Link>` but automatically adds an "active" class when the route matches.
- **`<Outlet>`**: A placeholder for child routes within a parent route.
- **`useParams`**: Hook to access URL parameters.
- **`useNavigate`**: Hook to navigate programmatically.
- **`useLocation`**: Hook to access the current URL location object.
