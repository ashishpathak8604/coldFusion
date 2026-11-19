<cfcomponent>
    <!--- Get All Users --->
    
    <cffunction name = "getAllUsers" access = "public" returntype = "struct" output = "false"
                hint = "Retrieves all users from the database">
    
        <cfset local.users = []>
        <!--- adding error handling --->
        <cftry>
            <cfquery name = "local.qUsers" >
            
                SELECT
                id,
                name,
                email,
                age,
                created_at
                FROM users
                ORDER BY id ASC
            </cfquery>
        
            <cfloop query = "local.qUsers">
            
                <cfset arrayAppend(local.users, {"id" = local.qUsers.id, "name" = local.qUsers.name, "email" = local.qUsers.email, "age" = local.qUsers.age, "created_at" = local.qUsers.created_at})>
            </cfloop>
        
            <cfreturn {"success" = true, "statusCode" = 200, 
                                   "message" = "Users retrieved successfully","data" = local.users}>
        
        <cfcatch type = "any">
            <cflog file = "application" type = "error" text = "getAllUser failed: #cfcatch.message#">
        
            <cfreturn {"success" = false, "statusCode" = 500, "message" = "Internal server error", 
                                   "data" = []}>
        </cfcatch>
        
        </cftry>
    </cffunction>
    
    <!--- Get USER BY ID --->
    <cffunction name = "getUserById" 
    access = "public" 
    returntype = "struct" 
    output = "false"
    hint="Retrieves a single user usign their ID">
    
        <cfargument name = "id" type = "any" 
        required = "true"
        hint="user ID to retrieve">
    
        <cftry>
            <!--- validate Id --->
            <cfif Not isValid("integer", arguments.id) OR arguments.id LTE 0>
                <cfreturn {
                    "success" = false, 
                    "statusCode" = 400, 
                    "message" = "Invalid user ID", 
                    "data" = {}
                }>
            </cfif>
         
            <!--- Query Database --->
            <cfquery name = "local.quser" >
                SELECT
                id,
                name,
                email,
                age,
                created_at
                FROM users
                WHERE id = <cfqueryparam 
                value = "#arguments.id#" 
                cfsqltype = "cf_sql_integer">
            </cfquery>
           
           <!--- check whether he user exsits --->
            <cfif local.qUser.recordCount GT 0>
                <cfreturn {
                "success" = true, 
                "statusCode" = 200, 
                "message" = "User retrieved successfully",
             "data" = {"id" = local.qUser.id[1],
              "name" = local.qUser.name[1], 
              "email" = local.qUser.email[1],
               "age" = local.qUser.age[1],
                "created_at" = local.qUser.created_at[1]}}>
            <cfelse>
                <cfreturn {"success" = false, "statusCode" = 404, "message" = "User not found", 
                                           "data" = {}}>
            </cfif>
        
        <cfcatch type = "any">
            <cflog file = "application" type = "error" 
                   text = "getUserById failed: #cfcatch.message#">
            <cfreturn {success = false, statusCode = 500, message = "Internal server error", 
                                   data = {}}>
        </cfcatch>
        
        </cftry>
    
    </cffunction>
    
    <!--- Add a new user to the database --->
<cffunction name="addUser"
access="public"
returntype="struct"
output="false"
hint="Validates and a creates a new user" >

<cfargument name="name" type="any" required="true" >
<cfargument name="email" type="any" required="true" >
<cfargument name="age" type="any" required="true" >

<cftry>
     
    <!--- vlaidates name --->
    <cfif NOT isSimpleValue(arguments.name) OR NOT len(trim(toString(arguments.name)))>

        <cfreturn {
            "success" = false,
            "statusCode" = 400,
            "message" = "Name is required",
            "data" = {}
        }>
    </cfif>

    <!--- validates email --->
    <cfif NOT isSimpleValue(arguments.email)
    OR NOT isValid("email", trim(toString(arguments.email)))>
      <cfreturn {
        "success" = false,
        "statusCode" = 400,
        "message" = "Please provide a vlaid email address",
        "data" = {}
      }> 
</cfif>

<!--- validate the age --->

<cfif NOT isSimpleValue(arguments.age)
OR NOT isValid("integer", arguments.age)
OR val(arguments.age) LT 1
OR val(arguments.age) GT 120>
     
<cfreturn {
    "success" = false,
    "statusCode" = 400,
    "message" = "Age must be an integer between 1 and 120",
    "data" = {}
} >
</cfif>

<!--- Check if the email already exists --->
<cfquery name="local.qExistingUser">
   SELECT id
   FROM users
   WHERE email = <cfqueryparam 
   value="#trim(arguments.email)#"
   cfsqltype="cf_sql_varchar">
</cfquery>
<cfif local.qExistingUser.recordCount GT  0 > 
    <cfreturn {
    success = false,
    statusCode = 409,
    message = "A user with this email already exists",
    data = {}    
}>
</cfif>

<!--- Insert the new value in the database --->
<cfquery name="local.qInsert" result="local.insertResult">
 INSERT INTO users (name, email, age)
    VALUES (
        <cfqueryparam 
        value="#trim(toString(arguments.name))#"
        cfsqltype="cf_sql_varchar">,

        <cfqueryparam 
        value="#trim(toString(arguments.email))#"
        cfsqltype="cf_sql_varchar">,

        <cfqueryparam 
        value="#val(arguments.age)#"
        cfsqltype="cf_sql_integer"
        >
    )
</cfquery>

<!--- retrives the new added data --->
<cfquery name="local.qUser">
SELECT id, name, email, age, created_at
FROM users
WHERE id = <cfqueryparam 
 value="#local.insertResult.generatedKey#"
 cfsqltype="cf_sql_integer"
>
</cfquery>

<cfreturn {
    "success" = true,
    "statusCode" = 201,
    "message" = "User created successfully",
    "data" = {
        "id" = local.qUser.id[1],
        "name" = local.qUser.name[1],
        "email" = local.qUser.email[1],
        "age" = local.qUser.age[1],
        "created_at" = local.qUser.created_at[1]
    }
}>

<cfcatch type="any">

    <cflog 
    file="application"
    type="error"
    text="addUser failed: #cfcatch.message#" >

    <cfreturn {
        "success" = false,
        "statusCode" = 500,
        "message" = "internal server error",
        "data" = {}
    }>

</cfcatch>

</cftry>
    
</cffunction>

</cfcomponent>