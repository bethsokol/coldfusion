<!DOCTYPE html>
	<cfapplication name="Proctors" 
	sessionmanagement="Yes" 
	sessiontimeout=#CreateTimeSpan(0,0,45,0)#>

	<head>
		<!--- Import jQuery --->
		<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

		<title>Cold Fusion Test</title>
	</head>
	
	<body>
		<cfscript>
			checkPerms('delete proctor', 'table.cfm');
		</cfscript>
		
		<h4>WARNING, DELETE IS PERMANENT!</h4>
		
		<cfset proctor = url.proctor/>
		<!--- Deletion confirmation form--->
		<cfoutput >
			<cfform name="confirmDelete">
				<cfinput type="submit" value="YES" name="ok">
				<cfinput type="button" value="CANCEL" name="back" onClick="history.go(-1)">
			</cfform>
		</cfoutput>
	
		<!--- Removes a proctor account from the database. (Locations cannot be deleted from the locations table in the database) --->
		<cfif isDefined("FORM.ok") >
       		<cfoutput >
       			<cfquery name="deleteProctor" datasource="proctor">
                   DELETE FROM proctors WHERE id=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#proctor#" />
                </cfquery>
                <!--- Redirects user to the table after sucessfully deleting an account. --->
			    <cflocation url = "table.cfm"/>
       		</cfoutput>
		</cfif>
				
	</body>
</html>