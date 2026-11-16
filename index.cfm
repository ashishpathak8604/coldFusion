<cfset userService = createObject(
    "component",
    "assignment.UserService"
    )>

<cfset users = userService.getAllUsers() >

<h1>College Assignment - User list </h1>
<cfoutput >
    <cfloop array="#users#" index="user">
       <h3>#user.name#</h13>
        <p>Email: #user.email#<p>
            <p>Age: #user.age# </p>
            <hr>
</cfloop>
</cfoutput>
