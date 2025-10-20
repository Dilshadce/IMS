<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfset dd=dateformat('#form.expiredate#', "DD")>
	
<cfif dd greater than '12'>
	<cfset nexpiredate=dateformat('#form.expiredate#',"MM/DD/YYYY")>
<cfelse>
	<cfset nexpiredate=dateformat('#form.expiredate#',"DD/MM/YYYY")>
</cfif>

<h1>Check Customer Type - <cfif chktype eq 1>Contract Expiry<cfelse>No Contract</cfif></h1>
<br><br><hr><br>

<!--- <cfquery name="getct" datasource="#dts#">
	Select type,refno,wos_date,custno,agenno,itemno 
	from ictran 
	where itemno<cfif chktype eq 1>=<cfelse><></cfif>"MAINTENANCE-1Y" and 
	type in ('INV','DO') and toinv='' 
	<cfif chktype neq 1>and (linecode <> 'SV' or linecode is null)</cfif>
	group by custno order by wos_date desc;
</cfquery> --->

<!--- <cfquery name="getct" datasource="#dts#">
	Select type,refno,wos_date,custno,agenno,itemno 
	from 
	(select type,refno,wos_date,custno,agenno,itemno from ictran 
	where itemno<cfif chktype eq 1>=<cfelse><></cfif>"MAINTENANCE-1Y" and 
	type in ('INV','DO') and toinv='' 
	<cfif chktype neq 1>and (linecode <> 'SV' or linecode is null)</cfif>  order by wos_date desc) as a
	
	group by custno
	order by wos_date
</cfquery> --->
<cfquery name="getct" datasource="#dts#">
	Select type,refno,wos_date,custno,agenno,rem10,rem11 
	from 
	(	select type,refno,wos_date,custno,agenno,rem10,rem11 
		from artran 
		where frem9<cfif chktype eq 1>=<cfelse><></cfif>'T' 
		and type = 'INV' order by wos_date desc
	) as a
	group by custno
	order by wos_date
</cfquery>

<cfoutput>
	Current Date : #dateformat(now(),"dd-mm-yyyy")#<br>Check Expire On: #nexpiredate#<br>
	<table align="center" class="data">
		<tr>
			<cfif chktype eq 1>
				<th>Reference</th>
			</cfif>
			<th>Date</th>
			<th>Agent</th>
			<th>Customer No</th>
			<th>Name</th>
			<th>Status</th>
			<cfif chktype eq 1>
				<th>Expire On</th>
			</cfif>
		</tr> 
	
		<cfloop query="getct">
			<cfquery name="getcust" datasource="#dts#">
				Select name,add1,add2,add3,add4,attn,phone  
				from #target_arcust# 
				where custno = "#getct.custno#";
			</cfquery>
			
			<cfif getct.rem10 neq "" and getct.rem11 neq "">
				<cfset duedate=createDate(ListGetAt(getct.rem11,3,"/"),ListGetAt(getct.rem11,2,"/"),ListGetAt(getct.rem11,1,"/"))>
			<cfelse>
				<cfset duedate = DateAdd("d", 372 , wos_date)>
			</cfif>
			<cfset duedate2 = datediff("d", nexpiredate, duedate)>
			
			<cfif duedate2 lt 1 or chktype eq 2>
				<tr>
					<cfif chktype eq 1>
						<td>#getct.refno#</td>
					</cfif>
					<td>#dateformat(getct.wos_date,"dd-mm-yyyy")#</td>
					<td>#getct.agenno#</td>
					<td>#getct.custno#</td>
					<td>#getcust.name#<br>
						#getcust.add1# <br>
						#getcust.add2#<br>
						#getcust.add3#<br>
						#getcust.add4#<br>
						#getcust.attn#<br>
						#getcust.phone#<br><br>
					</td>
					<td>
						<cfif chktype eq 1>
							<strong><h3>EXPIRED</h3></strong>
						<cfelse>
							<strong><h3>NO CONTRACT</h3></strong>
						</cfif>
					</td>
					<cfif chktype eq 1>
						<td>#dateformat(duedate,"dd-mm-yyyy")# - (#duedate2# days)</td>
					</cfif>
				</tr> 
			</cfif>
		</cfloop>
	</table>
</cfoutput>

</body>
</html>