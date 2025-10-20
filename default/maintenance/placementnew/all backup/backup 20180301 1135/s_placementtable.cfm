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
  <h4><!--- <cfif getpin2.h1H10 eq 'T'><a href="Placementtable2.cfm?type=Create">Creating a Placement</a> </cfif> ---><cfif getpin2.h1H20 eq 'T'><a href="Placementtable.cfm?">List 
    all Placement</a> </cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="s_Placementtable.cfm?type=Placement">Search For Placement</a>|| <a href="p_Placement.cfm">Placement Listing Report</a></cfif></h4>
</cfoutput>

<cfoutput>
	<form action="s_Placementtable.cfm" method="post">
			<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
				<option value="placementno">Placement no</option>
                <option value="placementdate">Date</option>
				<option value="placementtype">Type</option>
                <option value="location">Location</option>
                <option value="custno">Customer No</option>
		<option value="custname">Customer Name</option>
                <option value="empno">empno No</option>
                <option value="empname">Employee Name</option>
                <option value="clienttype">Rate Type</option>
                <option value="created_by">User ID</option>
			</select>
      Search for Placement : 
      <input type="text" name="searchStr" value=""> </h1>
			</cfoutput>
		</form>
	<cfif isdefined('form.status')>
    <h3>#form.status#</h3>
	</cfif>
	<cfif isdefined("form.searchStr")>
		
		<cfquery name="getrecordcount" datasource="#dts#">
			select count(placementno) as totalsimilarrecord 
			from placement 
			where (#searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#searchStr#%"> )
			order by #searchType#
            
		</cfquery>
		
		<cfif getrecordcount.totalsimilarrecord neq 0>
			<h2>Similar Results</h2>
			<iframe allowtransparency="true" align="middle" scrolling="auto" frameborder="0" width="100%" height="650" src="splacement_similar.cfm?searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#<cfif isdefined('form.left')>&left=1</cfif>"></iframe>
		<cfelse>
			<h3>No Similar Results Found !</h3>
		</cfif>
	</cfif>

	<h2>Newest 20 Results</h2>
	<iframe allowtransparency="true" align="middle" scrolling="auto" frameborder="0" width="100%" height="650" src="splacement_newest.cfm"></iframe>
	<cfabort>
</cfoutput>

</body>
</html>