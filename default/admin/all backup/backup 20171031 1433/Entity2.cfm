<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Generate according to Entity</title>
</head>

<body>

<cfform action="accpaccInvReport.cfm" method="post" name="form123" id="form123" target="_blank">

<cfoutput>
<center>

<h1>
	<u>Generate Burden Report According To Entity</u>
</h1>

<h1>
	Month: #MonthAsString(form.month)#
</h1>
    
    <input type="hidden" name="monthselected" id="monthselected" value="#form.month#">
    
    <cfquery name="getpayroll" datasource="#dts#">
        SELECT mmonth, myear
        FROM payroll_main.gsetup
        WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
    </cfquery>
    
	<cfquery name="getBranch" datasource="#replace(dts, '_i', '_p')#">
        SELECT SUM(socsocc+epfcc) AS total, entity
        FROM 
        <cfif "#getpayroll.mmonth#" EQ "#form.month#">
            payout_stat
        <cfelse>
            payout_stat_12m
            WHERE tmonth = "#form.month#"
        </cfif> 
        GROUP BY entity
    </cfquery>
        
    <cfloop query="getBranch">
        <!---<cfif #getBranch.total# NEQ 0>--->
            <input type="Submit" name="Submit" value="#getBranch.entity# Entity" id="#getBranch.entity#" onClick="document.form123.action = 'glBurdenReportnew.cfm?entity=#getBranch.entity#';"> <br /><br />
        <!---<cfelse>
            No Amount For #getBranch.entity# On The Month #MonthAsString(form.month)# <br /> <br />
        </cfif>--->
    	
    </cfloop>

</center>    
</cfoutput>
</cfform>
</body>
</html>