<html>
<head>
<title>PERIOD RECALCULATE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" src="../scripts/date_format.js"></script>

<cfparam name="submit" default="">

<body>
<form action="" method="post">
<H1>Recalculate</H1>
<input type="submit" name="submit" value="Submit">
</form>
<cfif submit eq 'Submit'>
	<cfquery name="getgsetup" datasource="#dts#">
		select lastaccyear from gsetup
	</cfquery>
	
	<cfquery datasource="#dts#" name="getartran">
		Select * from artran
		<!---where wos_date > #getgsetup.lastaccyear#--->
	</cfquery>
	
	<cfloop query="getartran">
		<cfset thisdate = dateformat(getartran.wos_date,"yyyy-mm-dd")>
        
		<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#thisdate#" returnvariable="cperiod"/>
		
		<cfquery name="updateperiod" datasource="#dts#">
			update artran set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
		</cfquery>
		<cfif getartran.type eq "TR">
			<cfquery name="updateperiod" datasource="#dts#">
				update ictran set fperiod = '#cperiod#' where type in ('TRIN','TROU') and refno = '#getartran.refno#'
			</cfquery>
			<cfquery name="updateperiod" datasource="#dts#">
				update igrade set fperiod = '#cperiod#' where type in ('TRIN','TROU') and refno = '#getartran.refno#'
			</cfquery>
		<cfelse>
			<cfquery name="updateperiod" datasource="#dts#">
				update ictran set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
			</cfquery>
			<cfquery name="updateperiod" datasource="#dts#">
				update igrade set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
			</cfquery>
		</cfif>		
		<cfquery name="updateperiod" datasource="#dts#">
			update iserial set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
		</cfquery>		
		<cfquery name="updateperiod" datasource="#dts#">
			update artranat set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
		</cfquery>
	</cfloop>
	You have finish the recalculate. 
</cfif>
</body>
</html>