<cfcomponent rest="true" restpath="users">
    <cffunction name="getUser"
    access="remote"
    returntype="void"
    httpMethod="GET"
    restPath="{id}"
    produces="application/json"
    >


    <cfargument name="id"
    type="any"
    required="true"
    restargsource="Path" >

     <cfset local.UserService  = createObject(
        "component",
        "assignment.UserService"
     )>

     <cfset local.response = local.userService.getUserById(arguments.id) >

     <cfset restSetResponse({
        status = local.response.statusCode,
        content = serializeJSON(local.response)
     })>
            
        </cffunction>

        
        <cffunction name="getAllUsers"
        access="remote"
        returntype="void"
        httpMethod="GET"
         restpath=""
         produces="application/json"
        >

        <cfset local.userService = createObject(
            "component",
            "assignment.UserService"
        
        ) >
 
        <cfset local.users = local.userService.getAllUsers()>
        <cfset local.response = {
            success = true,
            statusCode = 200,
            message = "Users retrived successfully",
            data = local.users
        } >

        <cfset restSetResponse({
              
            status = local.response.statusCode,
            content = serializeJson(local.response)

        })>
                    
                </cffunction>
    
</cfcomponent>