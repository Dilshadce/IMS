
<html>
<head>
<title>Year End Processing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="submit" default="">

<body>
<form action="" method="post">
<H1>Update Old Period</H1>

<cftry>
	<cfquery name="getprevlastaccyear" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year group by LastAccDate,ThisAccDate
	</cfquery>
	
	<table>
		<tr>
			<td>Date Range</td>
			<td>:</td>
			<td>
			<cfoutput>
				<select name="lastaccdaterange">
          			<cfloop query="getprevlastaccyear">
            			<option value="#getprevlastaccyear.LastAccDate#">#dateformat(getprevlastaccyear.LastAccDate,"dd/mm/yyy")# - #dateformat(getprevlastaccyear.ThisAccDate,"dd/mm/yyy")#</option>
          			</cfloop>
				</select>
			</cfoutput>
			</td>
			<td>&nbsp;<input type="submit" name="submit" value="Submit"></td>
		</tr>
	</table>
<cfcatch type="database">
	Sorry. This Function Is Currently Not Available!
</cfcatch>
</cftry>
</form>

<cfif submit eq 'Submit'>
	<cfquery name="getaccyear" datasource="#dts#">
		select LastAccDate,ThisAccDate 
		FROM icitem_last_year
		where LastAccDate = #form.lastaccdaterange#
		limit 1
	</cfquery>
	<cftry>
		<cfquery name="checkexist" datasource="#dts#">
			SELECT OPERIOD FROM artran
		</cfquery>
	<cfcatch type="database">
		<cfquery name="alter" datasource="#dts#">
			alter table artran add column OPERIOD varchar(2)
		</cfquery>
		<cfquery name="alter" datasource="#dts#">
			alter table ictran add column OPERIOD varchar(2)
		</cfquery>
		<cfquery name="alter" datasource="#dts#">
			alter table iserial add column OPERIOD varchar(2)
		</cfquery>
	</cfcatch>
	</cftry>
	
	<cfquery name="getartran" datasource="#dts#">
		select * from artran
		where wos_date > #getaccyear.LastAccDate# 
		and wos_date <= #getaccyear.ThisAccDate#
		and fperiod = '99'
		order by wos_date
	</cfquery>
	
	<cfquery name="getictran" datasource="#dts#">
		select * from ictran
		where wos_date > #getaccyear.LastAccDate# 
		and wos_date <= #getaccyear.ThisAccDate#
		and fperiod = '99'
		order by wos_date
	</cfquery>
	
	<cfquery name="getiserial" datasource="#dts#">
		select * from iserial
		where wos_date > #getaccyear.LastAccDate# 
		and wos_date <= #getaccyear.ThisAccDate#
		and fperiod = '99'
		order by wos_date
	</cfquery>
	
	<cfset lastaccyear = lsdateformat(getaccyear.LastAccDate, 'mm/dd/yyyy')>
	<cfset clsyear = year(lastaccyear)>
	<cfset clsmonth = month(lastaccyear)>
	<cfoutput query="getartran">
		<cfset currentdate = lsdateformat(getartran.wos_date,'mm/dd/yyyy')>
		<cfset tmpYear = year(currentdate)>
		<cfset tmpmonth = month(currentdate)>
		<cfset intperiod = (tmpyear-clsyear)*12+tmpmonth-clsmonth>
		<cfset readperiod = numberformat(intperiod,"00")>
	
		<cfquery name="update" datasource="#dts#">
			update artran
			set operiod = '#readperiod#'
			where type = '#getartran.type#'
			and refno = '#getartran.refno#'
			and operiod is null
		</cfquery>
	</cfoutput>
	
	<cfoutput query="getictran">
		<cfset currentdate = lsdateformat(getictran.wos_date,'mm/dd/yyyy')>
		<cfset tmpYear = year(currentdate)>
		<cfset tmpmonth = month(currentdate)>
		<cfset intperiod = (tmpyear-clsyear)*12+tmpmonth-clsmonth>
		<cfset readperiod = numberformat(intperiod,"00")>
	
		<cfquery name="update" datasource="#dts#">
			update ictran
			set operiod = '#readperiod#'
			where type = '#getictran.type#'
			and refno = '#getictran.refno#'
			and operiod is null
		</cfquery>
	</cfoutput>
	
	<cfoutput query="getiserial">
		<cfset currentdate = lsdateformat(getiserial.wos_date,'mm/dd/yyyy')>
		<cfset tmpYear = year(currentdate)>
		<cfset tmpmonth = month(currentdate)>
		<cfset intperiod = (tmpyear-clsyear)*12+tmpmonth-clsmonth>
		<cfset readperiod = numberformat(intperiod,"00")>
	
		<cfquery name="update" datasource="#dts#">
			update iserial
			set operiod = '#readperiod#'
			where type = '#getiserial.type#'
			and refno = '#getiserial.refno#'
			and operiod is null
		</cfquery>
	</cfoutput>
	<h2>Complete.</h2>
</cfif>
</body>


</html>
