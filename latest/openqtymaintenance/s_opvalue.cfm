<html>
<head>
<title>Enquiry Opening Value</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<h1>Enquiry Opening Value</h1>		

<cfoutput>
	<form action="s_opvalue.cfm" method="post">
		<h1>Search By :
		<select name="searchType">
			<option value="itemno">Item No</option>
			<option value="desp" <cfif lcase(hcomid) eq "mhca_i">selected</cfif>>Description</option>
			
		</select>
		Search for icitem : 
		<input type="text" name="searchStr" value="">
		</h1>
	</form>

	<cfif isdefined("form.searchStr")>
		<cfquery name="getrecordcount" datasource="#dts#">
			select count(itemno) as totalsimilarrecord 
			from icitem 
			where #searchType# LIKE binary('#searchStr#') <cfif searchType eq "desp"> or despa LIKE binary('#searchStr#') </cfif>
			order by #searchType#
		</cfquery>
		
		<cfif getrecordcount.totalsimilarrecord neq 0>
			<h2>Similar Results</h2>
			<iframe allowtransparency="true" align="middle" scrolling="auto" frameborder="0" width="100%" height="650" src="enquiry_opening_value.cfm?searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#"></iframe>
		<cfelse>
			<h3>No Similar Results Found !</h3>
		</cfif>
	</cfif>


	<h2>Newest 20 Results</h2>

	<iframe allowtransparency="true" align="middle" scrolling="auto" frameborder="0" width="100%" height="650" src="openqtyvalue_newest.cfm?itemno=<cfif isdefined('itemno')>#urlencodedformat(itemno)#</cfif>"></iframe>

    <cfabort>
</cfoutput>

</body>
</html>