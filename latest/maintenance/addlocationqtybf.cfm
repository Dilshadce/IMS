<cfsetting showdebugoutput="no">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfset itemno=urldecode(url.itemno)>

<cfquery name="getitem" datasource="#dts#">
	SELECT * FROM icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfquery name="getlocqdbf" datasource="#dts#">
	SELECT * FROM locqdbf where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
    order by location
</cfquery>

<script type="text/javascript">
	function validatefield()
	{
	var totallocationqty = 0;
	<cfoutput query="getlocqdbf">
	totallocationqty = totallocationqty+(document.getElementById("qtybf_#getlocqdbf.currentrow#").value*1)
	</cfoutput>
	if(totallocationqty == document.getElementById("qtybf").value)
	{
		return true;
	}
	else{
		alert("Location Qty B/F And Item Qty B/F does not tally!");	
	}
	return false;
	}
</script>

<cfoutput>
<h1>Update Location Qty B/F</h1>

<cfform action="addlocationqtybfprocess.cfm" method="post" onsubmit="return validatefield();">
<input type="hidden" name="itemno" id="itemno" value="#itemno#" />
<input type="hidden" name="qtybf" id="qtybf" value="#getitem.qtybf#" />
<table width="500px" align="center" >
<tr><th align="left" width="150px">Item No</th><td width="5px">:</td><td width="245px">#itemno#</td></tr>
<tr><th align="left">Description</th><td>:</td><td>#getitem.desp# #getitem.despa#</td></tr>
<tr><th align="left">Qty B/F</th><td>:</td><td>#getitem.qtybf#</td>
</table>
<br />


<table width="500px" border="1" align="center">
<tr><th colspan="100%"><div align="center">Location QTY B/F</div></th></tr>
<tr><th><div align="center">Location</div></th><th><div align="center">Qty B/F</div></th></tr>
<cfloop query="getlocqdbf">
<tr><td><div align="center">#getlocqdbf.location#</div><input type="hidden" name="location_#getlocqdbf.currentrow#" id="location_#getlocqdbf.currentrow#" value="#getlocqdbf.location#" /></td><td><div align="center"><input type="text" name="qtybf_#getlocqdbf.currentrow#" id="qtybf_#getlocqdbf.currentrow#" value="#getlocqdbf.locqfield#" max="10" size="5"/></div></td></tr>
</cfloop>
</table>
<br />

<div align="center">
<input type="submit" name="submit" id="submit" value="Save" />
</div>
</cfform>
</cfoutput>