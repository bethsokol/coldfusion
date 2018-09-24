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
			checkPerms('edit/view details on proctor', 'table.cfm');
		</cfscript>
		<cfset proctor = url.proctor/>
		<!--- Informs the user by ID# what entry they are currently editing. --->
		<h4>Now Editing ID#: <cfoutput>#proctor#</cfoutput></h4>
	
		<!--- Fetches matching proctor entry from the database. --->
		<cfquery name="getProctor" datasource="proctor">
			SELECT * from proctors WHERE id=#proctor#
		</cfquery>
		<!--- Fetches locations from the database. By default the proctor is assigned to none upon creation. --->
		<cfquery name="getLocations" datasource="proctor">
			SELECT l.id, l.locationName, COUNT(IF(pl.proctorID = #proctor#, 1, NULL)) 'assigned'
			from locations l
			LEFT JOIN proctor_locations pl ON l.id = pl.locationID
			GROUP BY l.id
		</cfquery>
		<!--- Form for editing a proctor account. ID# is not allowed to be changed. --->
		<cfform name="editProctor">
			Name: <cfinput  type="text"  id="name" name="name" message = "Please enter a First Name" required = "Yes" value="#getProctor.proctorName#">
			Gender: <cfinput  type="text"  id="gender" name="gender" message = "Please enter a Gender" required = "Yes" value="#getProctor.gender#">
			<cfloop query="getLocations">
				<!--- Locations can be added or removed by the user checking or unchecking a checkbox. This was the best solution I could
				find using CF. I would have prefered something like a dropdown with an 'add' button and a displayed list in jQuery. --->
				<cfInput name="assigned_#getLocations.id#" type="Checkbox" checked="#getLocations.assigned is 1#"><cfoutput >#getLocations.locationName#</cfoutput>
			</cfloop>
			<cfinput type="submit" value="Save" name="save">
			<cfinput type="button" value="Back" name="back" onClick="history.go(-1)">
		</cfform>
		
		<cfif isDefined("FORM.save") >
       		<cfoutput >
       			<!--- Updates the proctor entry in database. --->
       			<cfquery name="updateProctor" datasource="proctor">
                   UPDATE proctors SET 
                       proctorName=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.name#" />,
        		       gender=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.gender#" />
        		   WHERE id=#proctor#
        		</cfquery>
        		<!--- Update locations on check boxes. If box is checked it's a 1, otherwise it's a 0. --->
    			<cfloop query="getLocations">
    				<cfset tempNewVal= (isDefined("Form.assigned_#getLocations.id#") && Evaluate("Form.assigned_#getLocations.id#") IS 'on' ? 1 : 0)/>
    				<cfif #tempNewVal# IS NOT #getLocations.assigned#>
        				<!--- If 1, add location to that proctor's entry in database. --->	
        				<cfif #tempNewVal# GT 0>
			        		<cfquery name="assignProctorLocation" datasource="proctor">
			                    INSERT INTO proctor_locations (locationID, proctorID) VALUES (
							        <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getLocations.id#" />,
							        <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#proctor#" />
							        )
			        		</cfquery>
        				</cfif>
        				<!--- If 0, remove that location from the proctor's entry in database.--->
        				<cfif #tempNewVal# lte 0>
        					<cfquery name="updateProctorLocation" datasource="proctor">
			                   DELETE FROM proctor_locations WHERE 
			                       proctorID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#proctor#" />
			                       AND locationID=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getLocations.id#" />
			        		</cfquery>
        				</cfif>
    				</cfif>
			
				</cfloop>
				
				<!--- On successful update, redirect user to the table. --->
			    <cflocation url = "table.cfm"/>
        		
       		</cfoutput>
		</cfif>
					
	</body>
</html>