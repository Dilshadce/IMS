<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body>

<cfquery datasource='#dts#' name="getjobs">
	Select * from service_tran where s_status = "1" or s_status = "2" or s_status = "4" order by servicedate desc, apptime desc, csoid
</cfquery>


<h1>View Schedule</h1>
<br>

<hr>
<cfif isdefined("form.status")>
	<cfoutput>
	<h2>#form.status#</h2>
	</cfoutput>
</cfif>

<br>
<table align="center" class="data">					
					
		<tr>
			
			<th>Service ID</th>
			<th>Date of Service</th>
			<th>Customer No</th>
			<th>Name</th>
			<th>CSO</th>
			<th>Assigned By</th>
			<th>Status</th>
			<th>Action</th>
		</tr>
		<cfoutput query="getjobs">
		<tr>
			<td>#getjobs.serviceid#</td>
			<td>#dateformat(getjobs.servicedate, "dd/mm/yyyy")# - #apptime#</td>
			<td>#getjobs.custno#</td>
			<cfquery datasource='#dts#' name="getcust">
				Select name from #target_arcust# where custno = "#getjobs.custno#" 
			</cfquery>
			<td>#getcust.name#</td>
			<td>#getjobs.csoid#</td>
			<td>#getjobs.assby#</td>
			<td>
				<cfif s_status eq 1>
					New
				<cfelseif s_status eq 2>
					Follow Up
				<cfelseif s_status eq 4>
					Unsolved
				</cfif>
			</td>
			<td>
				<a href="jobsheet.cfm?serviceid=#serviceid#">Print</a> /
				<a href="updatejob.cfm?serviceid=#serviceid#&custno=#custno#">Update</a>
			</td>
		</tr>
		</cfoutput>
</table>
</body>
</html>
