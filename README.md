# User Management System

A full-stack User Management application built with **Adobe ColdFusion 2025, MySQL 8.4, React, TypeScript, and Redux Toolkit**. This project demonstrates REST API development, database integration, frontend-backend communication, asynchronous state management, and CRUD-related operations.

## Project Overview

The application allows users to retrieve all users, search for a user by ID, and create new users through a frontend interface connected to a ColdFusion REST API.

The project is divided into two main parts:

- **Backend:** REST API built using ColdFusion with MySQL for data storage.
- **Frontend:** React application built with TypeScript and Redux Toolkit for UI and state management.

## Tech Stack

### Backend
- Adobe ColdFusion 2025
- CFML (Tag-based)
- MySQL 8.4
- REST API
- SQL
- `cfqueryparam` for parameterized queries and SQL injection protection

### Frontend
- React
- TypeScript
- Redux Toolkit
- React Redux
- Vite
- Fetch API
- CSS

## Features

- Retrieve all users.
- Retrieve a user by ID.
- Create a new user.
- Input validation on the backend.
- Email format validation.
- Duplicate email checking.
- Parameterized SQL queries.
- Structured API responses.
- Asynchronous request handling with Redux Toolkit.
- Loading, success, and error states.
- Display backend validation and error messages.
- Separate state management for individual API operations.

## Architecture

```text
React + TypeScript
        │
        │ Fetch API
        ▼
Redux Toolkit
(createAsyncThunk)
        │
        ▼
ColdFusion REST API
(UserAPI.cfc)
        │
        ▼
UserService.cfc
(Validation & SQL operations)
        │
        ▼
MySQL 8.4
```

## API Endpoints

The API is registered under the `assignment` REST mapping.

| Method | Endpoint | Description |
|---|---|---|
| GET | `/rest/assignment/users` | Retrieve all users |
| GET | `/rest/assignment/users/{id}` | Retrieve a user by ID |
| POST | `/rest/assignment/users` | Create a new user |

### Base API URL (Local)

```text
http://localhost:8500/rest/assignment
```

### Get All Users

```http
GET /users
```

### Get User by ID

```http
GET /users/{id}
```

Example:

```http
GET /users/1
```

### Create User

```http
POST /users
Content-Type: application/json
```

Request body:

```json
{
  "name": "Rahul",
  "email": "rahul@example.com",
  "age": 22
}
```

## API Response Format

The API follows a consistent response structure:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Users retrieved successfully",
  "data": []
}
```

The `data` property contains the requested result, such as an array of users or an individual user object.

## Repository Structure

```text
coldFusion/
│
├── backend/
│   ├── Application.cfc
│   ├── UserAPI.cfc
│   ├── UserService.cfc
│   ├── index.cfm
│   ├── getUser.cfm
│   └── schema.sql
│
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   │   ├── store.ts
│   │   │   └── hooks.ts
│   │   ├── features/
│   │   │   └── users/
│   │   │       ├── usersAPI.ts
│   │   │       ├── usersSlice.ts
│   │   │       └── usersTypes.ts
│   │   ├── App.tsx
│   │   ├── App.css
│   │   ├── index.css
│   │   └── main.tsx
│   │
└── README.md
```

> Adjust the structure above if your actual repository folders or filenames differ.

## Backend Setup

### Requirements

- Adobe ColdFusion 2025
- MySQL 8.4
- Database configured in ColdFusion

### 1. Create the database

Create the MySQL database:

```sql
CREATE DATABASE college_assignment;
```

### 2. Configure the datasource

Configure the MySQL datasource in ColdFusion Administrator or your `Application.cfc` according to your setup.

The application uses the `college_assignment` database.

### 3. Create the table

Run the SQL schema provided in:

```text
backend/schema.sql
```

### 4. Start ColdFusion

Ensure the ColdFusion service is running and the REST API is registered correctly.

Local API:

```text
http://localhost:8500/rest/assignment/users
```

## Frontend Setup

### Requirements

- Node.js
- npm

### 1. Install dependencies

Navigate to the frontend directory:

```bash
cd frontend
npm install
```

### 2. Configure environment variables

Create a `.env` file inside the frontend directory:

```env
VITE_API_BASE_URL=/api
```

### 3. Start the development server

```bash
npm run dev
```

Vite will provide a local development URL, typically:

```text
http://localhost:5173
```

## Development Proxy

During local development, the Vite proxy forwards API requests from the frontend to ColdFusion.

Frontend API base:

```text
/api
```

Proxy target:

```text
http://localhost:8500/rest/assignment
```

The proxy avoids the need for direct cross-origin API requests during local development.

## Redux State Management

Redux Toolkit is used for managing the application state and API request lifecycle.

The application uses:

- `configureStore` to configure the Redux store.
- `createSlice` to manage users state.
- `createAsyncThunk` for asynchronous API operations.
- `extraReducers` to handle pending, fulfilled, and rejected request states.
- Typed Redux hooks for TypeScript integration.

API operations maintain their own status and error state.

## Security & Validation

- SQL queries use `cfqueryparam` to parameterize inputs.
- Backend validation checks user input before inserting records.
- Email format validation is performed by the backend.
- Duplicate email checks help prevent duplicate records.
- Errors are handled without unnecessarily exposing internal server details.

## Deployment

### Frontend

The frontend is deployed on Vercel:

**Live Demo:** https://frontend-8j2w.vercel.app/

### Backend

The ColdFusion backend currently runs locally during development. Public frontend functionality requires the backend to be hosted and accessible over a public URL, with appropriate CORS configuration.

## Future Improvements

- Update and delete user functionality.
- Improved form validation and UX.
- Pagination for larger user lists.
- Improved backend deployment and production configuration.
- Automated testing.

## Author

**Ashish Pathak**

Bachelor of Engineering — Computer Science
