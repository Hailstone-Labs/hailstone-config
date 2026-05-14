# Setting up React + Vite + Tailwind CSS v4 with Bun

This guide outlines how to create a new React application using Vite and Bun, and then integrate Tailwind CSS v4.

## 1. Create a New Project

Use `bun create vite` to initialize a new project:

```bash
bun create vite my-tailwind-app --template react
cd my-tailwind-app
bun install
```

## 2. Install Tailwind CSS

Install `tailwindcss` and the official Vite plugin:

```bash
bun add tailwindcss @tailwindcss/vite
```

## 3. Configure Vite

Add the Tailwind plugin to your `vite.config.js` file:

```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
})
```

## 4. Import Tailwind in your CSS

Open your main CSS entry point (usually `src/index.css`) and add the Tailwind import at the top. You can also remove any default boilerplate styles if you want a clean slate:

```css
@import "tailwindcss";
```

## 5. (Optional) Customization

In v4, configuration is done directly in your CSS using the `@theme` block instead of a `tailwind.config.js` file:

```css
@import "tailwindcss";

@theme {
  --font-display: "Satoshi", "sans-serif";
  --color-brand: oklch(0.6 0.18 117);
}
```

## 6. Verify the Main Entry Point

Ensure that `src/main.jsx` (or `src/main.tsx`) imports the CSS file where you added the Tailwind import:

```javascript
// src/main.jsx
import './index.css'
// ... rest of your code
```

## 7. Start Using Tailwind

You can now use Tailwind's utility classes in your React components. Tailwind v4 automatically scans your project for classes, so no manual content configuration is needed.

```jsx
// src/App.jsx
function App() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-gray-100">
      <h1 className="text-4xl font-extrabold text-blue-600 drop-shadow-md">
        Hello Tailwind v4!
      </h1>
    </div>
  )
}
```

## 8. Run the Development Server

Start your development server to see the changes:

```bash
bun dev
```
