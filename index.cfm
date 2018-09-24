<!--- Cold Fusion Application test by Bethany Sokol --->
<!--- Utilizes a MySQL database currently to successfully perform CRUD operations. --->
<!--- The following assumptions were made: 
1. is_authorized knows which users and actions are authorized somehow, because it was passed no arguments per directions given.
 1a. is_authorized returns 1 iff user is both authenticated && authorized for this action, as requirement was vague and used both terms.
2. Test locations must already exist in a database somewhere.
3. No bulk CRUD operations are allowed.
4. There are no max proctors per location, nor do proctors limit how many locations they can be assigned to.
5. CouldFusion would have direct database access. 
6. Manual assigning of ID numbers rather than using a function that randomly generates one. --->
<!DOCTYPE html>
	<cfapplication name="Proctors" 
	<!--- Managing user login for the session, assumption: no 'stay logged in' cross session functunionality is allowed for security reasons.--->
	sessionmanagement="Yes" 
	sessiontimeout=#CreateTimeSpan(0,0,45,0)#>
	
	<head>
		<!--- Import jQuery --->
		<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
		
		<title>Cold Fusion Test</title>
	</head>
	
	<body>
		<!--- Any login name will allow you to login and view the table (including leaving it blank) except the username 'no_access'. 
		Real world use would obviously have username and password fields and restrictions on entry length/min entry length --->
		
		<h4>Please log in.</h4>
		
		<!--- Login form --->
		<cfform name="Login" onSubmit="completeLogin">
			Username: <cfinput type="text" id="uname" name="uname">
	      <cfinput type="submit" value="Login" name="login">
		</cfform> 
		
		<!--- Single user access at a time to prevent multiple people simultaneously editing data.--->
		<cfif isDefined("FORM.login") >
       		<cflock timeout=20 scope="Session" type="Exclusive">
				<cfset Session.username = "#FORM.uname#">
			</cflock>
			<!--- If login is successful, direct them to table of accounts. --->
			<cflocation url = "table.cfm"/>
		</cfif>

	</body>
</html>