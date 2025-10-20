
<html>
<head>
<title>Delete Users</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	
	function confirmdelete(){
		
		if(document.form1.dts.value == ''){
			alert('The Company Datasource cannot be empty!');
		}
		else{
			var dbname = document.form1.dts.value;
			if (confirm("Are you sure you want to delete All the users in datasource: " + dbname + "?")) {
 				window.location.href='deleteusers.cfm?action=delete&dbname=' + dbname;
 			}
		}
		
 		
	}	
</script>
</head>

<body>
<form name="form1">
	<H1>Delete All Users</H1>
	Company Datasource:
	<input type="text" name="dts" value="">

	<input type="button" name="btnDelete" value="Delete" onclick="confirmdelete();">
</form>

<cfif isdefined("action") and action eq "Delete">
	
	<cfquery name="check" datasource="main">
		select * from users
		where LOWER(userDept) = '#lcase(dbname)#'
		limit 1
	</cfquery>
	
	<cfif check.recordcount neq 0>
		<cftry>
			<cfquery name="checkexist" datasource="#dbname#">
				select * from gsetup
			</cfquery>
			
		<cfcatch type="database">
			<cfquery name="delete" datasource="main">
				delete from users where LOWER(userDept) = '#lcase(dbname)#'
			</cfquery>
			<h2>All Users for Company <cfoutput>#dbname#</cfoutput> already Deleted.</h2>
		</cfcatch>
		</cftry>
		
	</cfif>
	Complete.
</cfif>
</body>


</html>
