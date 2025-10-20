<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body>

<cfparam name="serviceid" default="">
<cfparam name="custno" default="">
<cfparam name="custname" default="">
<cfparam name="datefrom" default="">
<cfparam name="dateto" default="">

<cfif datefrom neq "">
	<cfset date1 = createDate(ListGetAt(datefrom,3,"/"),ListGetAt(datefrom,2,"/"),ListGetAt(datefrom,1,"/"))>
<cfelse>
	<cfset date1 = createDate(year(now()),month(now()),day(now()))>
</cfif>

<cfif dateto neq "">
	<cfset date2 = createDate(ListGetAt(dateto,3,"/"),ListGetAt(dateto,2,"/"),ListGetAt(dateto,1,"/"))>
<cfelse>
	<cfset date2 = createDate(year(now()),month(now()),day(now()))>
</cfif>

<!--- <cfquery datasource='#dts#' name="getjobs">
	Select * from service_tran 
	where (s_status = "1" or s_status = "2" or s_status = "4")
	<cfif serviceid neq "" and serviceid neq "Service ID">
		and serviceid like '%#serviceid#%'
	</cfif>
	<cfif custno neq "" and custno neq "Customer No">
		and custno like '%#custno#%'
	</cfif>
	<cfif datefrom neq "" and dateto neq "">
		and servicedate between #date1# and #date2#
	</cfif>
	order by servicedate desc, apptime desc, csoid
</cfquery> --->
<cfquery datasource='#dts#' name="getjobs">
	Select a.* 
	from service_tran a
	<cfif custname neq "" and custname neq "Customer Name">
		,#target_arcust# b
	</cfif>
	where (a.s_status = "1" or a.s_status = "2" or a.s_status = "4")
	<cfif custname neq "" and custname neq "Customer Name">
		and a.custno=b.custno
		and b.name like '#custname#%'
	</cfif>
	<cfif serviceid neq "" and serviceid neq "Service ID">
		and a.serviceid like '%#serviceid#%'
	</cfif>
	<cfif trim(custno) neq "" and custno neq "Customer No">
		and a.custno like '%#trim(custno)#%'
	</cfif>
	<cfif datefrom neq "" and dateto neq "">
		and a.servicedate between #date1# and #date2#
	</cfif>
	order by a.servicedate desc, a.apptime desc, a.csoid
</cfquery>
<table align="center" class="data" width="100%">							
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
