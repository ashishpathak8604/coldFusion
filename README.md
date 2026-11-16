# ColdFusion User Management REST API

A beginner-friendly REST API project built using **Adobe ColdFusion 2025** and **MySQL 8.4**. This project demonstrates how to create REST endpoints, connect ColdFusion to a MySQL database, retrieve user records, validate request parameters, and handle errors using CFML.

## 🚀 Project Overview

This project implements a basic User Management API that retrieves user information from a MySQL database.

It includes:
- Fetching all users from the database.
- Fetching an individual user using their ID.
- Validating user IDs before executing database queries.
- Using parameterized SQL queries to prevent SQL injection.
- Handling errors with `cftry` and `cfcatch`.
- Returning structured JSON responses with appropriate HTTP status codes.

## 🛠️ Technologies Used

- **Backend:** Adobe ColdFusion 2025 (CFML)
- **Database:** MySQL 8.4
- **Database Connectivity:** ColdFusion Data Source (MySQL)
- **API Testing:** Browser / REST client
- **IDE:** Visual Studio Code

## 📁 Project Structure

```text
assignment/
│
├── UserService.cfc
├── UserAPI.cfc
├── index.cfm
├── getUser.cfm
└── README.md
```

### File Descriptions

| File | Description |
|---|---|
| `UserService.cfc` | Contains the business logic and database operations. Includes functions to retrieve all users and retrieve a user by ID. |
| `UserAPI.cfc` | Exposes the service functions as REST API endpoints and returns JSON responses with appropriate HTTP status codes. |
| `index.cfm` | A simple testing page that retrieves and displays all users from the database. |
| `getUser.cfm` | A testing page that retrieves a user by ID and displays the response, including validation and error messages. |
| `README.md` | Documentation for the project. |

## 🔗 API Endpoints

### 1. Get All Users

Retrieves all user records from the MySQL database.

**Method:** `GET`

**Endpoint:**

```http
http://localhost:8500/rest/assignment/users
```

**Check the API response:**

[Click here to view all users](http://localhost:8500/rest/assignment/users)

### 2. Get User by ID

Retrieves an individual user using their database ID.

**Method:** `GET`

**Endpoint:**

```http
http://localhost:8500/rest/assignment/users/{id}
```

**Example:**

```http
http://localhost:8500/rest/assignment/users/2
```

Replace `2` with the ID of the user you want to retrieve.

## 🗄️ Database Structure

**Database:** `college_assignment`

**Table:** `users`

| Column | Description |
|---|---|
| `id` | Unique user ID |
| `name` | User's name |
| `email` | User's email address |
| `age` | User's age |
| `created_at` | Record creation timestamp |

The project uses a ColdFusion datasource named `college_assignment` to connect to MySQL.

## 🔐 Validation and Error Handling

The `getUserById()` function performs the following checks:

- **Valid ID:** Accepts a positive integer.
- **Invalid ID:** Returns HTTP 400 for invalid or non-positive IDs.
- **User Not Found:** Returns HTTP 404 if the requested user does not exist.
- **Server Error:** Uses `cftry` and `cfcatch` to handle unexpected errors and returns HTTP 500.

### SQL Injection Prevention

Database queries use `<cfqueryparam>` to safely pass dynamic values into SQL statements.

Example:

```cfm
<cfquery name="local.qUser" datasource="college_assignment">
    SELECT id, name, email, age, created_at
    FROM users
    WHERE id = <cfqueryparam
        value="#arguments.id#"
        cfsqltype="cf_sql_integer">
</cfquery>
```

## 📦 API Response Format

The API returns a consistent JSON response structure:

```json
{
    "success": true,
    "statusCode": 200,
    "message": "User retrieved successfully",
    "data": {
        "id": 2,
        "name": "Rahul",
        "email": "rahul@gmail.com",
        "age": 22
    }
}
```

Possible HTTP status codes:

| Status Code | Meaning |
|---|---|
| `200` | Request successful |
| `400` | Invalid user ID |
| `404` | User not found |
| `500` | Internal server error |

## ⚙️ Running the Project Locally

1. Install Adobe ColdFusion 2025.
2. Install MySQL 8.4.
3. Create a database named `college_assignment`.
4. Create the `users` table and insert sample records.
5. Configure a MySQL datasource named `college_assignment` in ColdFusion Administrator.
6. Place the project folder inside the ColdFusion web root.
7. Ensure the REST application is registered and accessible under the `assignment` REST mapping.
8. Start the ColdFusion server.
9. Open the API endpoint in your browser or test it using Postman.

**Local API URL:**

http://localhost:8500/rest/assignment/users

## 🎯 Learning Objectives

Through this project, I practised:

- Understanding ColdFusion components (`.cfc`) and templates (`.cfm`).
- Creating reusable service functions.
- Connecting ColdFusion with a MySQL database.
- Writing SQL queries using `<cfquery>`.
- Preventing SQL injection using `<cfqueryparam>`.
- Validating API parameters.
- Handling exceptions using `<cftry>` and `<cfcatch>`.
- Building REST endpoints in ColdFusion.
- Returning structured JSON responses.

---

**Note:** This is a locally hosted learning project. The API URL works only when the ColdFusion server is running on the same machine. It is not a publicly deployed endpoint.
