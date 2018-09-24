<!--- This may or may not be a bug/feature with MySQL, but if you attempt to create a new entry 
using an identical ID# that belonged to a previously deleted account you will get an error. 
Could do for some error handling in this application to inform the user that is a duplicate ID. --->

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
			checkPerms('create proctor', 'table.cfm');
		</cfscript>
		<h4>Creating new proctor!</h4>
		
		<!--- New proctor form. All values are required. Real world application would have more fields, 
		restrictions on data that can be entered to keep the data clean (ie "male" vs "m" vs "MALE"). 
		Dropdowns or prefilled selectors could be used to achieve this, 
		although I think you would have to use JS/jQuery. CF doesn't seem to offer that functionality. --->
		<cfoutput >
			<cfform name="newProctor">
			ID: <cfinput  type="text"  id="ID" name="id" message = "Please enter a Proctor ID" required = "Yes">
			Name: <cfinput  type="text"  id="Name" name="name" message = "Please enter a Name" required = "Yes">
			Gender: <cfinput  type="text"  id="Gender" name="gender" message = "Please enter a Gender" required = "Yes">
			  <cfinput type="submit" value="Save" name="save">
			  <!--- Pages have a 'go back' button for easier browsing. This is a terrible solution I made 
			  with CF. Ideally, you want to prevent users from creating duplicate/wonky session data somehow
			  by going 'back'. Possibly a redirect to the table. --->
			  <cfinput type="button" value="Back" name="back" onClick="history.go(-1)">
			</cfform>
		</cfoutput>
		
		<!--- Adds a new proctor to the database. --->
		<cfif isDefined("FORM.save") >
       		<cfoutput >
       			<cfquery name="addNewProctor" datasource="proctor">
                   INSERT INTO proctors (id, proctorName, gender) VALUES (
				        <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#FORM.id#" />,
				        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.name#" />,
				        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.gender#" />
				        )
                </cfquery>
                <!--- Redirects the user to the table page after sucessfully adding a new proctor. --->
			    <cflocation url = "table.cfm"/>
       		</cfoutput>
		</cfif>

	</body>
</html>