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
	Batch Selected: <u>#form.batches#</u>
</h1>

<h1>
	Generate Pay Report According to Entity
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
    	<input type="Submit" name="Submit" value="#getBranch.branch# Entity" id="#getBranch.branch#Pay" onClick="document.form123.action = 'glpsReport.cfm?branch=#getBranch.branch#';">
    </cfloop>
    
<br>
<br>

    <cfquery name="getBurdenBranch" datasource="#dts#">
        SELECT branch
        FROM assignmentslip 
        WHERE 
        <cfif isdefined('form.batches')> 
            batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
        </cfif>
        AND (custcpf != '0' OR custsdf != '0')
        GROUP by branch
    </cfquery>

<cfif #getBurdenBranch.recordcount# eq 0>
	<h2> No Record Found for Burden Report </h2>
<cfelse>

    <h1>
        Generate Burden Report According to Entity
    </h1>
    
    <cfloop query="getBurdenBranch">
        <input type="Submit" name="Submit" value="#getBurdenBranch.branch# Entity" id="#getBurdenBranch.branch#Burden" onClick="document.form123.action = 'glBurdenReport.cfm?branch=#getBurdenBranch.branch#';">
    </cfloop>

</cfif>

    <input type="hidden" name="batches" id="batches" value="#form.batches#">
</center>    
</cfoutput>
</cfform>
</body>
</html>