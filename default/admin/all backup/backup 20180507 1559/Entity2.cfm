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
        
    <table border="1px" cellpadding="10">
        <tr align="center"> 
            <td></td>
            <td>All Transaction</td>
            <td>Billing Date</td>
            <td>Giro Pay Date</td>
        </tr>
        <cfloop query="getBranch">
            <tr>
                <td>#getBranch.entity#</td>
            <!---<cfif #getBranch.total# NEQ 0>--->
                <td>
                    <input type="Submit" name="Submit" value="#getBranch.entity# Entity" id="#getBranch.entity#" onClick="document.form123.action = 'glBurdenReportnew.cfm?entity=#getBranch.entity#';">
                </td>
                
                <td>
                    <input type="Submit" name="Submit" value="28th Payout" id="#getBranch.entity#" onClick="document.form123.action = 'glBurdenReportnew.cfm?entity=#getBranch.entity#&billdate=28';"> &nbsp;&nbsp;
                    
                    <input type="Submit" name="Submit" value=" 7th Payout" id="#getBranch.entity#" onClick="document.form123.action = 'glBurdenReportnew.cfm?entity=#getBranch.entity#&billdate=07';">
                </td>
                
                <td>
                    <input type="Submit" name="Submit" value="28th Payout" id="#getBranch.entity#" onClick="document.form123.action = 'glBurdenReportnew.cfm?entity=#getBranch.entity#&paydate=28';"> &nbsp;&nbsp;
                    
                    <input type="Submit" name="Submit" value=" 7th Payout" id="#getBranch.entity#" onClick="document.form123.action = 'glBurdenReportnew.cfm?entity=#getBranch.entity#&paydate=07';">
                </td>
            <!---<cfelse>
                No Amount For #getBranch.entity# On The Month #MonthAsString(form.month)# <br /> <br />
            </cfif>--->
            </tr>
        </cfloop>
    </table>

</center>    
</cfoutput>
</cfform>
</body>
</html>