<cfset frgrade=11>
<cfset tograde=160>
<html>
<head>
<title>GRADE QIN QOUT RECALCULATE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" src="../scripts/date_format.js"></script>

<cfparam name="submit" default="">
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'INV','PR','CS','DN','ISS','OAR','TROU','DO','CT'">
<cfelse>
	<cfset outtrantype="'INV','PR','CS','DN','ISS','OAR','TROU','DO'">
</cfif>

<body>
<form action="" method="post">
<H1>Recalculate Grade Qty</H1>
<input type="submit" name="submit" value="Submit">
</form>
<cfif submit eq 'Submit'>
	<cfquery name="getictranin" datasource="#dts#">
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qin#i#,
		</cfloop>
		itemno
		from igrade
		where type in (#PreserveSingleQuotes(intrantype)#)
		and fperiod<>'99' 
		and (void = '' or void is null)  
		and factor2 > 0
		group by itemno
	</cfquery>
	
	<cfquery name="getictranout" datasource="#dts#">
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qout#i#,
		</cfloop>
		itemno
		from igrade 
		where type in (#PreserveSingleQuotes(outtrantype)#) 
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
		group by itemno
	</cfquery>

	<!--- INITIALIZE THE QIN/QOUT IN itemgrd --->
	<cfquery name="InitializeIcitem" datasource="#dts#">
		update itemgrd 
		set 
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			BGRD#i#=0<cfif i neq tograde>,</cfif>
		</cfloop>
	</cfquery>
	
	<cftry>
		<cfloop query="getictranin">
			<cfquery name="updateitemgrd" datasource="#dts#">
				update itemgrd 
				set
				<cfloop from="#frgrade#" to="#tograde#" index="i">
					BGRD#i#=BGRD#i#+#getictranin["qin#i#"][getictranin.currentrow]#<cfif i neq tograde>,</cfif>
				</cfloop>
				where itemno = '#getictranin.itemno#' 
			</cfquery>
		</cfloop>
		<cfcatch type="any">
			<cfoutput>Failed to update QIN. #cfcatch.Message# - #cfcatch.Detail#.</cfoutput>
		</cfcatch>
	</cftry>
	
	<cftry>
		<cfloop query="getictranout">
			<cfquery name="updateitemgrd" datasource="#dts#">
				update itemgrd 
				set
				<cfloop from="#frgrade#" to="#tograde#" index="i">
					BGRD#i#=BGRD#i#-#getictranout["qout#i#"][getictranout.currentrow]#<cfif i neq tograde>,</cfif>
				</cfloop>
				where itemno = '#getictranout.itemno#' 
			</cfquery>
		</cfloop>
		<cfcatch type="any">
			<cfoutput>Failed to update QOUT. #cfcatch.Message# - #cfcatch.Detail#.</cfoutput>
		</cfcatch>
	</cftry>
	
	You have finish the recalculate. 
</cfif>
</body>
</html>