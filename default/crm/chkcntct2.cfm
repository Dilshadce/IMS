<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
	
<h1>Check Customer Contract Expiry</h1>
<br><br>
<hr>
<br>
<!--- <cfquery name="getct" datasource="#dts#">
	Select * from ictran where custno = "#custno#" and itemno = "MAINTENANCE-1Y" and type = "INV"
</cfquery> --->
<cfquery name="getct" datasource="#dts#">
	Select * from artran where custno = '#custno#' and frem9 = 'T' and type = 'INV' order by wos_date desc
</cfquery>

<cfquery datasource='#dts#' name="getcust">
	Select name from #target_arcust# where custno = '#custno#'
</cfquery>

<cfoutput>
Current Date : #dateformat(now(),"dd/mm/yyyy")#<br><br>
This customer, #getcust.name# has <br><br>
</cfoutput>

<table align="center" class="data">
	<tr>
		<th>Reference</th>
		<th>Date</th>
		<th>Status</th>
		<th>Expire On</th>
		<th>Action</th>
	</tr> 
		
	<cfoutput query="getct">
		<tr>
			<td>#refno#</td>
			<td>#dateformat(wos_date,"dd/mm/yyyy")#</td>
			<cfif getct.rem10 neq "" and getct.rem11 neq "">
				<cfset duedate=createDate(ListGetAt(getct.rem11,3,"/"),ListGetAt(getct.rem11,2,"/"),ListGetAt(getct.rem11,1,"/"))>
			<cfelse>
				<cfset duedate = DateAdd("d", 372 , wos_date)>
			</cfif>
			<cfset duedate2 = datediff("d", now(), duedate)>
			<td><strong>
				<cfif duedate2 gte 1 >
					<h2>Valid</h2>
				<cfelse>
					<h3>Expired</h3>
				</cfif>
				</strong>
			</td>		
			<td>#dateformat(duedate,"dd/mm/yyyy")# - (#duedate2# days)</td>
			<td><cfif duedate2 gte 1><a href="chkcntct3.cfm?type=#getct.type#&refno=#getct.refno#&custno=#getct.custno#">View</a></cfif></td>
		</tr> 
	</cfoutput>
</table>
</body>
</html>