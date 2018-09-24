
<cfapplication name="Proctors">
<!--- Datasource is a MySQL database named 'proctor' with 3 tables: proctors, locations, and proctor_locations. --->
<cfset this.datasource = "proctor" />
<cfsetting showdebugoutput="true" />

<!--- If user is not authorized, return 0. (In this case, it's only the ID 'no_access'). --->
<cffunction name="is_authorized" >
	<cfif #Session.username# IS 'no_access'>
		<cfreturn 0>
	</cfif>
<!--- Otherwise, return 1. --->
	<cfreturn 1>
</cffunction>

<cffunction name="checkPerms" >
	<cfargument name="actionName" required="true" type="string" >
	<cfargument name="onFailure" required="true" type="string" >
	
	<!--- If user is unauthorized, display username in an error message (to reduce user confusion in case of typo) and redirect. --->
	<cfif is_authorized() IS NOT 1>
		<cfset err="#Session.username# IS NOT AUTHORIZED TO PERFORM ACTION: #actionName#" />
		<cflocation url="error.cfm?message=#err#&redirectTo=#onFailure#" >
	</cfif>
</cffunction>

</cfapplication>