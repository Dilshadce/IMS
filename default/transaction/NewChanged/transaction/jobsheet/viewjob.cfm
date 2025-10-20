<html>
<head>
<title>Create Job Sheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body>

<cfquery datasource='#dts#' name="getjobs">
	Select * from service_tran order by servicedate desc, apptime desc, csoid
</cfquery>

<h1>Create Job Sheet</h1>
<br>
<h4>
<a href="createjob.cfm?type=Create">Creating New Job Sheet</a> || 
<a href="viewjob.cfm">List all Job Sheet</a> || 
<a href="s_createjob.cfm">Search For Job Sheet</a> ||
</h4>
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
		<th>Invoice No</th>
		<th>Customer</th>
        <th>Vehicle No</th>
		<th>CSO</th>
		<th>Assigned By</th>
		<th>Action</th>
	</tr>
	<cfoutput query="getjobs">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td>#getjobs.serviceid#</td>
			<td>#dateformat(getjobs.servicedate, "dd/mm/yyyy")# - #apptime#</td>
			<td>#getjobs.refno#</td>
			<cfquery datasource='#dts#' name="getcust">
				Select custno,name,rem5 from artran where refno = "#getjobs.refno#" and type='INV'
			</cfquery>
			<td>#getcust.custno# - #getcust.name#</td>
            <td>#getcust.rem5#</td>
			<td>#getjobs.csoid#</td>
			<td>#getjobs.assby#</td>
			<td>
            <a href="/billformat/#dts#/preprintedformatjobsheet.cfm?serviceid=#serviceid#&refno=#refno#" target="_blank">PDF</a>/
				<a href="jobsheet.cfm?serviceid=#serviceid#" target="_blank">Print</a> /
				<a href="updatejob.cfm?serviceid=#serviceid#&refno=#refno#">Update</a>
			</td>
		</tr>
	</cfoutput>
</table>
</body>
</html>
