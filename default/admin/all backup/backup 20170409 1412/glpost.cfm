<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="submit" default="">

<cfif isdefined("ref")>
	<cfquery name="delglpost" datasource="#dts#">
		delete from glpost9<cfif isdefined('url.ubs')>ubs</cfif> where reference = '#ref#'
	</cfquery>
	
</cfif>

<cfif submit eq 'Clear All'>
	<cfquery name="delglpost" datasource="#dts#">
		delete from glpost9<cfif isdefined('url.ubs')>ubs</cfif> 
	</cfquery>	
</cfif>



<cfquery name="getglpost" datasource="#dts#">
	select reference,date,fperiod from glpost9<cfif isdefined('url.ubs')>ubs</cfif> group by reference
</cfquery>
<cfoutput>
<body>
<!--- <h4> 
	<a href="postingacc.cfm?status=UNPOSTED">View Accounting Post Menu</a>
</h4> --->
<h1 align="center">View Not Exported Bills</h1>
<h3 align="center">
	<a href="postingacc.cfm?status=Unposted<cfif isdefined('url.ubs')>&ubs=yes</cfif>">Unposted Transaction</a>&nbsp;
    <cfif getpin2.h5610 eq 'T'>
    || <a href="postingacc.cfm?status=Posted<cfif isdefined('url.ubs')>&ubs=yes</cfif>">Posted Transaction</a> 
    </cfif>
    <cfif getpin2.h5620 eq 'T'>
    || <a href="postingcheck.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">Posting Check</a> 
    </cfif>
    || 
	<cfif Hlinkams neq "Y" or isdefined('url.ubs')>
		<a href="..\..\..\download\#dts#\ver9.0\glpost9.csv" target="_blank">Download Exported File Accounting Ver 9.0</a> || 
		<a href="..\..\..\download\#dts#\ver9.1\glpost9.csv" target="_blank">Download Exported File Accounting Ver 9.1</a> ||
	</cfif>
    <cfif getpin2.h5630 eq 'T'>
	<a href="glpost.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">List Not Exported</a> </cfif>
    <cfif getpin2.h5640 eq 'T'>|| 
	<a href="unpost.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">Unpost Bill</a>
    </cfif>
    <cfif getpin2.h5650 eq 'T'>
	<cfif Hlinkams eq "Y"  and isdefined('url.ubs') eq false>
		|| <a href="import_to_ams.cfm"><i>Import To AMS</i></a>
	</cfif>
    </cfif>
</h3>
</cfoutput>
<h2 align="center">View the bills in GLPOST9 file which have been posted but haven't 
  exported.</h2>
<form action="" name="form" method="post">
<table width="70%" border="0" cellspacing="0" cellpadding="3" align="center" class="data">
  <tr>
   
    <th>Refno</th>
    <th>Period</th>
    <th>Date</th>
    <th>Delete</th>
  </tr>
  <cfoutput query="getglpost">
  <tr>    
    <td><div align="center">#reference#</div></td>
    <td><div align="center">#ceiling(fperiod)#</div></td>
    <td><div align="center"><cftry>#dateformat(date,"dd-mm-yyyy")#<cfcatch type="any">#date#</cfcatch></cftry></div></td> 
	<td><div align="center"><a href="glpost.cfm?ref=#reference#">Delete</a></div></td>   
  </tr>
  </cfoutput>
</table>
<cfif submit eq 'Clear All'>
<h2 align="center">You have deleted all bills from Glpost9 file successfully.</h2>
</cfif>
<br>
<div align="right">
  <input type="submit" name="submit" value="Clear All">
</div>
</form>
</body>
</html>
