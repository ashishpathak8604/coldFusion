# ColdFusion User Management REST API

A beginner-friendly REST API project built using **Adobe ColdFusion 2025** and **MySQL 8.4**.

This project demonstrates how to build REST endpoints using CFML, connect ColdFusion to a MySQL database, retrieve user records, validate request parameters, prevent SQL injection, and handle errors using structured JSON responses.

## 🚀 Project Overview

This project implements a basic User Management REST API with the following functionality:

- Fetch all users from the database.
- Fetch an individual user using their ID.
- Validate user IDs before executing database queries.
- Use parameterized SQL queries to prevent SQL injection.
- Handle database and application errors using `cftry` and `cfcatch`.
- Maintain a consistent JSON response structure.
- Use appropriate HTTP status codes.
- Centralize application and datasource configuration.
- Provide local testing pages for retrieving user records.

## 🛠️ Technologies Used

- **Backend:** Adobe ColdFusion 2025 (CFML)
- **Database:** MySQL 8.4
- **Database Connectivity:** ColdFusion Data Source (MySQL)
- **API Testing:** Browser / Postman
- **IDE:** Visual Studio Code

## 📁 Project Structure

```text
assignment/
│
├── Application.cfc
├── UserService.cfc
├── UserAPI.cfc
├── index.cfm
├── getUser.cfm
├── schema.sql
└── README.md
```

### File Descriptions

| File | Description |
|---|---|
| `Application.cfc` | Defines application-level configuration, including the application name and default datasource. |
| `UserService.cfc` | Contains business logic and database operations. Includes functions to retrieve all users and retrieve a user by ID. |
| `UserAPI.cfc` | Exposes service functions as REST API endpoints and returns JSON responses with appropriate HTTP status codes. |
| `index.cfm` | A local testing page that retrieves and displays all users. |
| `getUser.cfm` | A local testing page that retrieves a user by ID and displays the response, including validation and error messages. |
| `schema.sql` | Contains the database and users table definition, along with sample records required to set up the project. |
| `README.md` | Project documentation and setup instructions. |

## 🔗 API Endpoints

### 1. Get All Users

Retrieves all user records from the MySQL database.

**Method:** `GET`

**Endpoint:**

```http
http://localhost:8500/rest/assignment/users
```

[View All Users](http://localhost:8500/rest/assignment/users)

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

| Column | Data Type | Description |
|---|---|---|
| `id` | INT | Unique user ID and primary key |
| `name` | VARCHAR(100) | User's name |
| `email` | VARCHAR(150) | User's email address; unique |
| `age` | INT | User's age |
| `created_at` | TIMESTAMP | Record creation timestamp |

The project uses a MySQL datasource named `college_assignment` configured in ColdFusion Administrator.

The default datasource is declared centrally in `Application.cfc`, avoiding the need to repeat the datasource name in individual database queries.

### Database Setup

The `schema.sql` file contains:

- Database creation statement.
- Users table definition.
- Primary key and unique email constraints.
- Sample user records.

To set up the database, execute `schema.sql` in MySQL Workbench or another MySQL client.

**Note:** The current schema script recreates the users table. Execute it only when setting up a fresh database or when you have backed up any existing data you need.

## 🔐 Validation and Error Handling

The `getUserById()` function performs the following checks:

- **Valid ID:** Accepts a positive integer.
- **Invalid ID:** Returns HTTP 400 for invalid or non-positive IDs.
- **User Not Found:** Returns HTTP 404 if the requested user does not exist.
- **Server Error:** Uses `cftry` and `cfcatch` to handle unexpected database or application errors and returns HTTP 500.

The `getAllUsers()` function also includes error handling to manage unexpected database failures.

The API layer handles unexpected errors while processing requests and preparing HTTP responses.

Error details are logged on the server rather than exposed to API clients.

### SQL Injection Prevention

Database queries use `<cfqueryparam>` to safely pass dynamic values into SQL statements.

Example:

```cfm
<cfquery name="local.qUser">
    SELECT id, name, email, age, created_at
    FROM users
    WHERE id = <cfqueryparam
        value="#arguments.id#"
        cfsqltype="cf_sql_integer">
</cfquery>
```

## 🛡️ Cross-Site Scripting (XSS) Prevention

The local testing pages use ColdFusion output encoding functions such as:

- `encodeForHTML()` for values displayed inside HTML content.
- `encodeForHTMLAttribute()` for values displayed inside HTML attributes.

This helps prevent untrusted database values from being interpreted as executable HTML or script content.

## 📦 API Response Format

All API endpoints follow a consistent JSON response structure with the following keys:

- `success`
- `statusCode`
- `message`
- `data`

### Successful Response — HTTP 200

```json
{
    "success": true,
    "statusCode": 200,
    "message": "User retrieved successfully",
    "data": {
        "id": 2,
        "name": "Rahul",
        "email": "rahul@example.com",
        "age": 24,
        "created_at": "2026-11-17"
    }
}
```

### Error Response — HTTP 404

```json
{
    "success": false,
    "statusCode": 404,
    "message": "User not found",
    "data": {}
}
```

For the all-users endpoint, `data` contains an array of user objects. For an individual-user endpoint, it contains a user object or an empty structure when no user is available.

### HTTP Status Codes

| Status Code | Meaning |
|---|---|
| `200` | Request successful |
| `400` | Invalid user ID |
| `404` | User not found |
| `500` | Internal server error |

## ⚙️ Running the Project Locally

### Prerequisites

1. Install Adobe ColdFusion 2025.
2. Install MySQL 8.4.
3. Install Visual Studio Code or another code editor.

### Step 1: Set Up the Database

- Open MySQL Workbench.
- Execute the `schema.sql` file.
- Verify that the `college_assignment` database and `users` table have been created.

### Step 2: Configure the ColdFusion Datasource

- Open ColdFusion Administrator.
- Navigate to Data Sources.
- Create a MySQL datasource named `college_assignment`.
- Configure the MySQL connection details.
- Verify that the datasource connection succeeds.

### Step 3: Configure the Application

Place the project folder inside the ColdFusion web root.

Ensure that `Application.cfc` is present in the `assignment` directory and defines the application name and default datasource.

### Step 4: Register the REST Application

Ensure that the REST application is registered in ColdFusion Administrator under the REST Services section.

Use the `assignment` REST mapping.

### Step 5: Start the ColdFusion Server

Ensure that the ColdFusion service is running.

### Step 6: Test the API

Open the following endpoint in your browser or test it using Postman:

```http
http://localhost:8500/rest/assignment/users
```

To retrieve a specific user:

```http
http://localhost:8500/rest/assignment/users/1
```

## 🧪 Local Testing Pages

The project also includes two CFML pages for testing service functionality independently of the REST endpoints.

**User List:**

```text
http://localhost:8500/assignment/index.cfm
```

**User Details:**

```text
http://localhost:8500/assignment/getUser.cfm?id=1
```

The `getUser.cfm` page accepts a dynamic ID through a URL parameter, allowing different scenarios to be tested, including invalid IDs and users that do not exist.

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
- Configuring applications using `Application.cfc`.
- Understanding basic XSS prevention and output encoding.
- Organizing backend code into service and API layers.

---

**Note:** This is a locally hosted learning project. The API URLs work only when the ColdFusion server is running on the local machine. It is not a publicly deployed endpoint.