# React-Redux Setup and Usage Guide

This guide covers the modern way to set up React-Redux using **Redux Toolkit (RTK)**, which is the recommended approach for all Redux applications.

## 1. Installation

Install Redux Toolkit and the React-Redux bindings:

```bash
bun add @reduxjs/toolkit react-redux
```

## 2. Create the Redux Store

Create a file named `src/store.js` (or `src/app/store.js`). This is where you configure your store.

```javascript
import { configureStore } from '@reduxjs/toolkit'
import counterReducer from './features/counter/counterSlice'

export const store = configureStore({
  reducer: {
    counter: counterReducer,
  },
})
```

## 3. Create a Redux State Slice

A "slice" contains the logic for a specific feature. Create a file like `src/features/counter/counterSlice.js`.

```javascript
import { createSlice } from '@reduxjs/toolkit'

const initialState = {
  value: 0,
}

export const counterSlice = createSlice({
  name: 'counter',
  initialState,
  reducers: {
    increment: (state) => {
      // Redux Toolkit allows us to write "mutating" logic in reducers. It
      // doesn't actually mutate the state because it uses the Immer library.
      state.value += 1
    },
    decrement: (state) => {
      state.value -= 1
    },
    incrementByAmount: (state, action) => {
      state.value += action.payload
    },
  },
})

// Action creators are generated for each case reducer function
export const { increment, decrement, incrementByAmount } = counterSlice.actions

export default counterSlice.reducer
```

## 4. Provide the Store to React

Wrap your `<App />` component with the `<Provider />` from `react-redux` in `src/main.jsx`.

```javascript
import React from 'react'
import ReactDOM from 'react-dom/client'
import { Provider } from 'react-redux'
import { store } from './store'
import App from './App'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>
)
```

## 5. Use Redux State and Actions in Components

Use the `useSelector` hook to read data and `useDispatch` to dispatch actions.

```javascript
import React from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { decrement, increment } from './features/counter/counterSlice'

export function Counter() {
  const count = useSelector((state) => state.counter.value)
  const dispatch = useDispatch()

  return (
    <div>
      <div>
        <button
          aria-label="Increment value"
          onClick={() => dispatch(increment())}
        >
          Increment
        </button>
        <span>{count}</span>
        <button
          aria-label="Decrement value"
          onClick={() => dispatch(decrement())}
        >
          Decrement
        </button>
      </div>
    </div>
  )
}
```

## Summary of Core Concepts

- **Store**: The single source of truth for your application state.
- **Slice**: A collection of Redux reducer logic and actions for a single feature.
- **Reducers**: Functions that determine how state changes in response to actions.
- **Actions**: Plain objects that describe *what* happened.
- **Dispatch**: The function used to send actions to the store.
- **Selectors**: Functions used to extract specific pieces of data from the store.
