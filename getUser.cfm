<cfset userService = createObject(
    "component",
    "assignment.UserService"
)>

<cfset response = userService.getUserById(1)>

<cfoutput>
    <h2>#response.message#</h2>
    <p>Success: #response.success#</p>
    <p>Status Code: #response.statusCode#</p>

    <cfif response.success>

        <p>Name: #response.data.name#</p>
        <p>Email: #response.data.email#</p>
        <p>Age: #response.data.age#</p>

    </cfif>

</cfoutput>