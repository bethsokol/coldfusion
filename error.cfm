<!DOCTYPE html>
	<cfapplication name="Proctors" 
	sessionmanagement="Yes" 
	sessiontimeout=#CreateTimeSpan(0,0,45,0)#>

	<head>
		<!--- Import jQuery --->
		<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
	</head>
	
	<body>
		<!--- Creates an error message and redirects if the user is not authorized to view the table.--->
		<cfset message = url.message />
		<cfset redirectTo = url.redirectTo />
		<script type="text/javascript" >
			var urlParams = new URLSearchParams(location.search);
			alert(urlParams.get('message'));
			window.location =urlParams.get('redirectTo');
		</script>

	</body>
</html>
