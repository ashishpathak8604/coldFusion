# User Management Frontend

A simple user management application built with **React, TypeScript, Redux Toolkit, and Vite**. The application connects to a ColdFusion REST API to retrieve users, search for a user by ID, and create new users.

## Live Demo

**Frontend:** https://frontend-8j2w.vercel.app/

> The frontend is deployed on Vercel. API functionality in the deployed version requires the backend to be publicly accessible.

## Tech Stack

- React
- TypeScript
- Redux Toolkit
- React Redux
- Vite
- CSS
- Fetch API
- ColdFusion REST API
- MySQL

## Features

- Fetch and display all users.
- Search for a user using their ID.
- Create a new user.
- Form input handling with React state.
- Redux Toolkit for managing application state and API request status.
- Loading, success, and error feedback.
- Backend validation messages displayed in the frontend.
- Separate state handling for different API operations.

## API Integration

The frontend communicates with the ColdFusion REST API using the Fetch API.

### Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | `/users` | Fetch all users |
| GET | `/users/{id}` | Fetch a user by ID |
| POST | `/users` | Create a new user |

### Create User Request

```json
{
  "name": "Rahul",
  "email": "rahul@example.com",
  "age": 22
}
```

## Project Structure

```text
src/
├── app/
│   ├── store.ts
│   └── hooks.ts
│
├── features/
│   └── users/
│       ├── usersAPI.ts
│       ├── usersSlice.ts
│       └── usersTypes.ts
│
├── App.tsx
├── App.css
├── index.css
└── main.tsx
```

### Folder Responsibilities

- **app/** – Redux store configuration and typed Redux hooks.
- **features/users/** – User API functions, Redux logic, and TypeScript types.
- **App.tsx** – Main interface and user interactions.
- **App.css / index.css** – Application styling.
- **main.tsx** – Application entry point and Redux Provider setup.

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/ashishpathak8604/coldFusion.git
```

### 2. Navigate to the frontend directory

```bash
cd coldFusion/frontend
```

> Adjust the directory path if your frontend folder is located elsewhere in the repository.

### 3. Install dependencies

```bash
npm install
```

### 4. Configure environment variables

Create a `.env` file in the frontend root directory:

```env
VITE_API_BASE_URL=/api
```

### 5. Start the development server

```bash
npm run dev
```

Vite will start the development server and provide a local URL, usually:

```text
http://localhost:5173
```

## Development API Proxy

During local development, Vite is configured to proxy API requests to the local ColdFusion server.

The frontend uses `/api` as its base URL, while the Vite proxy forwards requests to:

```text
http://localhost:8500/rest/assignment
```

This allows the frontend and backend to communicate locally without directly configuring CORS for the development environment.

## Available Scripts

| Command | Description |
|---|---|
| `npm run dev` | Start the development server |
| `npm run build` | Type-check and build the production application |
| `npm run preview` | Preview the production build locally |

## State Management

Redux Toolkit is used to manage user data and asynchronous API operations.

The application uses `createAsyncThunk` for API operations and handles the following request states:

- `idle`
- `loading`
- `succeeded`
- `failed`

Separate state is maintained for fetching all users, fetching a user by ID, and creating a user to prevent unrelated API operations from interfering with each other.

## Deployment

The frontend is deployed using Vercel.

Production API communication requires a publicly accessible ColdFusion backend URL. The local Vite development proxy is not available in production.

## Author

Ashish Pathak

