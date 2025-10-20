<html>
<head>
<title>Placement Selection Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<h1>Placement Selection Page</h1>		
<cfoutput>
  <h4><cfif getpin2.h1H10 eq 'T'><a href="placementleavetable.cfm?type=Create">Creating a Placement Leave</a> </cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="s_placementleave.cfm?type=Placement">Search For Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleave.cfm">Summary Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleave1.cfm">Detail Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleavemarkclaim.cfm">Leave Claim Status Report</a></cfif></h4>
</cfoutput>

<cfoutput>
	<form action="s_placementleave.cfm" method="post">
			<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
				<option value="placementno">Placement no</option>
                <option value="empno">Employee Number</option>
                <option value="empname">Employee Name</option>
			</select>
      Search for Placement : 
      <input type="text" name="searchStr" value=""> </h1>
			</cfoutput>
		</form>

	<cfif isdefined("form.searchStr")>
    
     <cfquery name="getplacementno" datasource="#dts#">
        SELECT placementno FROM placement WHERE #searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#searchStr#%"> order by #searchType#
        </cfquery>
		
		<cfquery name="getrecordcount" datasource="#dts#">
			select count(placementno) as totalsimilarrecord 
			from placementleave 
			where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getplacementno.placementno)#" list="yes" separator=",">) order by placementno desc
            
		</cfquery>
		
		<cfif getrecordcount.totalsimilarrecord neq 0>
			<h2>Similar Results</h2>
			<iframe allowtransparency="true" align="middle" scrolling="auto" frameborder="0" width="100%" height="650" src="splacementleave_similar.cfm?searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#<cfif isdefined('form.left')>&left=1</cfif>"></iframe>
		<cfelse>
			<h3>No Similar Results Found !</h3>
		</cfif>
	</cfif>

	<h2>Newest 20 Results</h2>
	<iframe allowtransparency="true" align="middle" scrolling="auto" frameborder="0" width="100%" height="650" src="splacementleave_newest.cfm"></iframe>
	<cfabort>
</cfoutput>

</body>
</html>