<!DOCTYPE html>
	<cfapplication name="Proctors" 
	sessionmanagement="Yes" 
	sessiontimeout=#CreateTimeSpan(0,0,45,0)#>

	<head>
		<!--- Import jQuery --->
		<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
		
		<title>Proctor Table</title>
	</head>
	
	<body>
		<cfscript>
			checkPerms('view proctor list', 'index.cfm');
		</cfscript>
		<!--- Welcomes the user by name. --->
		<h1><cfoutput>Welcome #Session.username#</cfoutput></h1>
		<cfquery name="listAllProctors" datasource="proctor">
			SELECT id, proctorName from proctors
		</cfquery>
		
		<!--- Displays all of the proctors in the database in a table. Currently only displays name and ID# for privacy reasons. --->
		<h2>Proctor List</h2>
		<cftable query="listAllProctors" htmlTable="true" colHeaders="true" border="true" colspacing="10">
		    <cfcol header="ID:" text="#listAllProctors.id#" align="center" />
		    <cfcol header="Name:" text="#listAllProctors.proctorName#" />
		    <!--- The 'edit' button and the 'delete' button. 
		    'Edit' is double purposed- it lets you view the record as well as update it, satisfying the 'RU' of CRUD. --->
		    <cfcol header="Actions:" text='<button type="button" onclick="loadProctor(''#jsStringFormat(listAllProctors.ID)#'')">edit</button><button type="button" onclick="deleteProctor(''#jsStringFormat(listAllProctors.ID)#'')">delete</button>'/>
		</cftable>
		<!--- New account creation button. --->		
		<button type="button" id="newAccount" onclick="newProctor()" >New Proctor</button>
		
		
		<!--- Fetching locations from the database. --->
		<cfquery name="listAllLocations" datasource="proctor">
			SELECT locationName from locations
		</cfquery>

		<!--- Displays all of the locations in the database in a table. --->
		<h2>Available Locations</h2>
		<cftable query="listAllLocations" htmlTable="true" colHeaders="true" border="true" colspacing="10">
		    <cfcol header="Name:" text="#listAllLocations.locationName#" />
		</cftable>


		<!--- Each proctor function (create, edit, & delete) has its own page, --->
		<script>
			   function loadProctor(proctorId){
					          url = "editproctor.cfm?proctor="+proctorId;
		   					   $( location ).attr("href", url);
					       }
					       	   function deleteProctor(proctorId){
					          url = "deleteproctor.cfm?proctor="+proctorId;
		   					   $( location ).attr("href", url);
					       }
					       	   function newProctor(){
					          url = "newproctor.cfm";
		   					   $( location ).attr("href", url);
					       }
		</script>

	</body>
</html>
