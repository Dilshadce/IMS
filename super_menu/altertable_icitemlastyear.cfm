<html>
<head>
<title>Update Last Closing Year</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" src="../scripts/date_format.js"></script>

<cfparam name="submit" default="">

<body>
<cfoutput>
<form action="" method="post">
<H1>Update Last Closing Year</H1>
	<table>
		<tr>
			<td>Last Closing Date Before Year End Process</td>
			<td>:</td>
			<td><input type="text" name="lastclosingdate" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"></td>
		</tr>
		<tr><td colspan="3"><input type="submit" name="submit" value="Submit"></td></tr>
	</table>
</form>
</cfoutput>
<cfif submit eq 'Submit'>
	<cfif form.lastclosingdate eq "">
		Please insert the Actual Closing Date!<cfabort>
	</cfif>
	<cfset date3 = createDate(ListGetAt(form.lastclosingdate,3,"/"),ListGetAt(form.lastclosingdate,2,"/"),ListGetAt(form.lastclosingdate,1,"/"))>
	<cftry>
		<cfquery name="check" datasource="#dts#">
			select LastAccDate from icitem_last_year limit 1
		</cfquery>
	<cfcatch type="database">
		<cfquery name="alter1" datasource="#dts#">
			ALTER TABLE icitem_last_year ADD COLUMN LastAccDate Date
		</cfquery>
		<cfquery name="alter1" datasource="#dts#">
			ALTER TABLE icitem_last_year ADD COLUMN ThisAccDate Date
		</cfquery>
	</cfcatch>
	
	</cftry>
	
	<cfquery datasource="#dts#" name="getGeneralInfo">
		Select lastaccyear, year(lastaccyear) as lyear,period from GSetup
	</cfquery>
	<cfset date_diff = DateDiff("m", date3, getGeneralInfo.lastaccyear)>
	<cfif date_diff gt 18>
		The Last Closing Date Not Available! The Last Account Year from Gsetup is <cfoutput>#dateformat(getGeneralInfo.lastaccyear,"dd/mm/yyyy")#</cfoutput><cfabort>
	</cfif>
	<cfquery datasource="#dts#" name="update">
		Update icitem_last_year
		set LastAccDate = #date3#,
		ThisAccDate = #getGeneralInfo.lastaccyear#
		where EDI_ID = '#ListGetAt(form.lastclosingdate,3,"/")#'
	</cfquery>
	<h2>Done.</h2>
</cfif>
</body>
</html>
