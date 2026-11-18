<cfset userService = createObject(
    "component",
    "assignment.backend.UserService"
    )>

<cfset response = userService.getAllUsers() >

<h1>College Assignment - User list </h1>
<cfoutput >
    <cfif response.success>
       
    <cfloop array="#response.data#" index="user">
       <h3>#encodeForHTML(user.name)#</h3>
        <p>Email: #encodeForHTML(user.email)#</p>
            <p>Age: #encodeForHTML(user.age)#</p>
            <hr>
</cfloop>
<cfelse>
    <p>#encodeForHTML(response.message)#</p>
</cfif>
</cfoutput>
