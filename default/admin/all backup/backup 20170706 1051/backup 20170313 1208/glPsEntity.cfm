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
	Generate According to Entity
</h1>
	<cfquery name="getBranch" datasource="#dts#">
        	SELECT branch
        	FROM assignmentslip 
            WHERE 
        	<cfif isdefined('form.batches')> 
        		batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
        	</cfif>
            GROUP by branch
        </cfquery>
        
    <cfloop query="getBranch">
    	<input type="Submit" name="Submit" value="#getBranch.branch# Entity" onClick="document.form123.action = 'glpsReport.cfm?branch=#getBranch.branch#';">
    </cfloop>
    
    <input type="hidden" name="batches" id="batches" value="#form.batches#">
</center>    
    <!---&nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="GLPS Report" onClick="document.form123.action = 'glpsReport.cfm';">--->
    
</cfoutput>
</cfform>
</body>
</html>