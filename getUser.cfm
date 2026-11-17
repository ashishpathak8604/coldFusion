 <!--- Deafult to user id 1 if no id is provided in the URL --->
 <cfparam name="url.id" default="1">

<cfset userService = createObject(
    "component",
    "assignment.UserService"
)>
<!--- Passing dynamic user id --->
<cfset response = userService.getUserById(url.id)>

<h2> User Details </h2>
<cfoutput>
    <p>requested ID: #encodeForHTML(url.id)#</p>
    <h2>#encodeForHTML(response.message)#</h2>
    <p>Success: #encodeforHTML(response.success)#</p>
    <p>Status Code: #encodeForHTML(response.statusCode)#</p>
    <cfif response.success>

        <p>Name: #encodeforHTML(response.data.name)#</p>
        <p>Email: #encodeforHTML(response.data.email)#</p>
        <p>Age: #encodeforHTML(response.data.age)#</p>
        <p> Created At: #encodeforHTML(response.data.created_At)# </p>

    </cfif>

</cfoutput>