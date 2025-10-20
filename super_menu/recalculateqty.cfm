<html>
<head>
<title>QIN QOUT RECALCULATE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" src="../scripts/date_format.js"></script>

<cfparam name="submit" default="">
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','PR','CS','DN','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','PR','CS','DN','ISS','OAR','TROU'">
</cfif>

<body>
<form action="" method="post">
<H1>Recalculate</H1>
<input type="submit" name="submit" value="Submit">
</form>
<cfif submit eq 'Submit'>
	<cfquery name="getictranin" datasource="#dts#">
		select sum(qty) as qin , itemno, fperiod
		from ictran 
		where type in (#PreserveSingleQuotes(intrantype)#)
		and fperiod<>'99' 
		and (void = '' or void is null)
		and (linecode <> 'SV' or linecode is null)  
		group by itemno, fperiod
	</cfquery>

	<!--- <cfquery name="getictranout" datasource="#dts#">
		select sum(qty) as qout , itemno, fperiod
		from ictran 
		where (void = '' or void is null) and fperiod<>'99' 
		and (type in ('INV','PR','CS','DN','ISS','OAR','TROU') or (type = 'DO' and toinv=''))  
		group by itemno, fperiod
	</cfquery> --->
	
	<!--- <cfquery name="getictranout" datasource="#dts#">
		select sum(qty) as qout , itemno, fperiod
		from ictran 
		where (void = '' or void is null) and fperiod<>'99' 
		and (type in ('DO','PR','CS','DN','ISS','OAR','TROU') or 
		(type='INV' and refno not in (select refno from iclink where frtype='DO' and type='INV' group by refno)))  
		group by itemno, fperiod
	</cfquery> --->
	
	<cfquery name="getictranout" datasource="#dts#">
		select sum(qty) as qout , itemno, fperiod
		from ictran as a
		where (void = '' or void is null)
		and (linecode <> 'SV' or linecode is null) 
		and fperiod<>'99' 
		and (type in (#PreserveSingleQuotes(outtrantype)#) or 
		(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))  
		group by itemno, fperiod
	</cfquery>

	<!--- INITIALIZE THE QIN/QOUT IN ICITEM --->
	<cfquery name="InitializeIcitem" datasource="#dts#">
		update icitem 
		set qin11= 0,
		qin12= 0,
		qin13= 0,
		qin14= 0,
		qin15= 0,
		qin16= 0,
		qin17= 0,
		qin18= 0,
		qin19= 0,
		qin20= 0,
		qin21= 0,
		qin22= 0,
		qin23= 0,
		qin24= 0,
		qin25= 0,
		qin26= 0,
		qin27= 0,
		qin28= 0, 
		qout11 = 0,
		qout12 = 0,
		qout13 = 0,
		qout14 = 0,
		qout15 = 0,
		qout16 = 0,
		qout17 = 0,
		qout18 = 0,
		qout19 = 0,
		qout20 = 0,
		qout21 = 0,
		qout22 = 0,
		qout23 = 0,
		qout24 = 0,
		qout25 = 0,
		qout26 = 0,
		qout27 = 0,
		qout28 = 0
	</cfquery>
	
	<cftry>
		<cfloop query="getictranin">
			
			<cfset qname = 'QIN'&(getictranin.fperiod+10)>
			<cfquery name="UpdateIcitem" datasource="#dts#">
				update icitem set #qname#= #getictranin.qin# 
				where itemno = '#getictranin.itemno#'
			</cfquery>
		</cfloop>
		<cfcatch type="any">
			<cfoutput>Failed to update QIN. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
		</cfcatch>
	</cftry>
	
	<cftry>
		<cfloop query="getictranout">
			<cfset qname = 'QOUT'&(getictranout.fperiod+10)>
			<cfquery name="UpdateIcitem" datasource="#dts#">
				update icitem set #qname#= #getictranout.qout# 
				where itemno = '#getictranout.itemno#'
			</cfquery>
		</cfloop>
		<cfcatch type="any">
			<cfoutput>Failed to update QOUT. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
		</cfcatch>
	</cftry>
	
	You have finish the recalculate. 
</cfif>
</body>
</html>