<cfcomponent rest="true" restpath="users">

    <!--- Get User By id --->
    <cffunction name="getUser"
    access="remote"
    returntype="void"
    httpMethod="GET"
    restPath="{id}"
    produces="application/json"
    hint="Returns a single user by id"
    >


    <cfargument name="id"
    type="any"
    required="true"
    restargsource="Path"
    hint="ID of the user to retrieve" >

    <cftry>
  <!--- Creating service object--->

     <cfset local.UserService  = createObject(
        "component",
        "assignment.backend.UserService"
     )>

      <!--- Get structured respose form service --->
     <cfset local.response = local.userService.getUserById(arguments.id) >

     <cfset restSetResponse({
        status = local.response.statusCode,
        content = serializeJSON(local.response)
     })>

     <cfcatch type="any">
        <cflog
        file="application"
        type="error"
        text="UserAPI getUser failed: #cfcatch.message#">

        <cfset local.errorResponse ={
              "success" = false,
              "statusCode" = 500,
              "message" = "Internal server error",
              "data" = {}
        }>

        <cfset restSetResponse({
            status = 500,
            content = serializeJSON(local.errorResponse)
        })>
            
          </cfcatch>
          
        </cftry>
 </cffunction>


<!--- get allUsers --->      
        <cffunction 
        name="getAllUsers"
        access="remote"
        returntype="void"
        httpMethod="GET"
         restpath=""
         produces="application/json"
         hint="Returns all users" >

        <cftry> 
          <!--- Create service object --->
        <cfset local.userService = createObject(
            "component",
            "assignment.backend.UserService"
        
        ) >
       
        <cfset local.response = local.userService.getAllUsers()>
        
        <cfset restSetResponse({
            status = local.response.statusCode,
          content = serializeJSON(local.response)
        })>

       <cfcatch type="any">
        <cflog 
        file="application"
        type="error"
        text="UserAPI getAllUsers failed: #cfcatch.message#">

        <cfset local.errorResponse = {
            "success" = false,
             "statusCode" = 500,
             "message" = "Internal server error",
             "data" = []
        }>
                <cfset restSetResponse({
                  status = 500,
                  content = serializeJSON(local.errorResponse)
                })>
              </cfcatch>
                    
        </cftry>
     </cffunction>
  
 <!--- Add a new user --->
 <cffunction name="addUser"
 access="remote"
 returntype="void"
 httpMethod="POST"
 restPath=""
 produces="application/json"
 hint="Creates a new user"
  >

<cfset local.requestData = getHTTPRequestData() >

<cfset local.body = deserializeJSON(local.requestData.content) >

    <cftry>
        

    <cfset local.userService = createObject(
      "component",
      "assignment.backend.UserService"
    )>

    <cfset local.response = local.userService.addUser(
      name = local.body.name,
      email = local.body.email,
      age = local.body.age
    )>

    <cfset restSetResponse({
      status = local.response.statusCode,
      content = serializeJSON(local.response)
    })>

    <cfcatch type="any">
      <cflog 
      file="application"
      type="error"
      text="UserAPI addUser failed: #cfcatch.message#" >

      <cfset local.errorResponse = {
        "success" = false,
        "statusCode" = 500,
        "message" = "Internal server error",
        "data" = {}
      }>

      <cfset restSetResponse({
        status = 500,
        content = serializeJSON(local.errorResponse)
      })>
           
        </cfcatch>
      
        </cftry>
  </cffunction>

    </cfcomponent> 