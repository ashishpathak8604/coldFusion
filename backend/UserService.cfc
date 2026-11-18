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
    
</cfcomponent>