<cfcomponent>
      
    <cffunction name="getAllUsers" access="public" returntype="array" output="false">

        <cfset local.users = [] >

        <cfquery name= "local.qUsers" datasource="college_assignment" >
           
           SELECT 
             id,
             name,
             email,
             age,
             created_at
        FROM users
        ORDER BY id ASC
        </cfquery>
            
            <cfloop query="local.qUsers" > 
             
                 <cfset arrayAppend(local.users, {
                   "id" = local.qUsers.id,
                   "name" = local.qUsers.name,
                   "email" = local.qUsers.email,
                   "age" = local.qUsers.age,
                   "created_at" = local.qUsers.created_at
                 })>
            </cfloop>
     

        <cfreturn local.users>
    
    </cffunction>

    <cffunction name="getUserById" access="public" returntype="struct" output="false" >

        <cfargument name="id" type="any" required="true" >

  <cftry>
        <cfif Not isValid("integer",arguments.id) OR arguments.id LTE 0>
            <cfreturn {
                success = false,
                statusCode = 400,
                message = "Invalid user ID",
                
            }>
        </cfif>

        <cfquery name="local.quser"  datasource="college_assignment">
              SELECT 
              id,
              name,
              email,
              age,
              created_at
              FROM users
              WHERE id = <cfqueryparam 
              value="#arguments.id#"
              cfsqltype="cf_sql_integer">
                </cfquery>
       
       <cfif local.qUser.recordCount GT 0>
        <cfreturn {
            "success" = true,
            "statusCode" = 200,
            "message" = "User retrieved successfully",
            "data" = {
                "id" = local.qUser.id[1],
                        "name" = local.qUser.name[1],
                        "email" = local.qUser.email[1],
                        "age" = local.qUser.age[1],
                        "created_at" = local.qUser.created_at[1]
            }
        }>
        <cfelse>
         <cfreturn {
            "success" = false,
            "statusCode" = 404,
            "message" = "User not found",
            "data" = {}
         }>
       
       </cfif>

      
        <cfcatch type="any">
            <flog
            file = "application"
            type = "error"
            text = "getUserById failed: #cfcatch.message#"
            >
            <cfreturn {
                success = false,
                statusCode = 500,
                message = "Internal server error",
                data = {}
            }>
        </cfcatch>

    </cftry>
     
    
            </cffunction>


    </cfcomponent>
