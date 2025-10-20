<html>
<head>
<title>Edit Item Opening Quantity/Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<cfset itemno = URLDecode(url.itemno)>

<script type="text/javascript">
function updateqty(fifofield,updatevalue,fieldtype){
	<cfoutput>
	var itemno="#itemno#";
	var location=document.getElementById('location').value;
	</cfoutput>
	var pattern =/^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;

	if((isNaN(updatevalue) && (fieldtype =="qty" || fieldtype=="price")) || (fieldtype=="date" && pattern.test(updatevalue)!=true) ){
		alert("Please Key In Correct Format!");
	}
	else{
	ajaxFunction(document.getElementById('changefifoAjax'),"fifoopqupdatevalue1.cfm?fifofield="+fifofield+"&itemno="+escape(itemno)+"&location="+escape(location)+"&updatevalue="+updatevalue)
	}
}
</script>

<cfquery name="getlocation" datasource="#dts#">
	select 
	location,
	desp 
	from iclocation 
    where 0=0
    and (noactivelocation='' or noactivelocation is null)
    <cfif Huserloc neq "All_loc">
	and location='#Huserloc#'
	</cfif>
	order by location;
</cfquery>

<cfquery name="checkexist" datasource="#dts#">
	select itemno from fifoopq where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
</cfquery>

<cfif checkexist.recordcount eq 0>
<cfquery name="insertfifoopq" datasource="#dts#">
	insert into fifoopq (itemno) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />)
</cfquery>

</cfif>

<cfquery name="getfifoopq" datasource="#dts#">
	select * from fifoopq where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
</cfquery>

</head>

<body>
<h3>
	<a href="/default/maintenance/openqtymaintenance/openqtymenu.cfm">Opening Quantity Menu</a> >> 
    <a href="/default/maintenance/openqtymaintenance/fifoopq.cfm">Item Opening Quantity</a> >> 
	<a><font size="2">ITEM FIFO QUANITY</font></a>
</h3>
<h2 align="center">
<cfoutput>
<table width="30%" align="center" border="1"  class="data">
<tr>
<th><div align="left">Item No</div></th>
<td>#url.itemno#</td>
</tr>
<tr>
<th><div align="left">Location</div></th>
<td>
<select name="location" id="location" onChange="ajaxFunction1(document.getElementById('fifolocationAjaxField'),'fifoopqnew1body.cfm?itemno=#URLEncodedFormat(itemno)#&location='+escape(this.value))">
<option value="">All Location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
</td>
</tr>
</table>
<br>
<div id="fifolocationAjaxField">
<table border="0" class="data" align="center">
<tr>
<th>Location : </th>
<td>All Location</td>
</tr>
<tr>
<th><div align="left">No</div></th>
<th><div align="left">Quantity</div></th>
<th><div align="left">Unit Price</div></th>
<th><div align="left">Date</div></th>
</tr>
<cfloop from="50" to="11" index="i" step="-1">
<tr>
<td>Oldest #i#</td>
<td><input type="text" name="fifoqty" id="fifoqty" value="#evaluate('getfifoopq.ffq#i#')#" onBlur="updateqty('ffq#i#',this.value,'qty');" size="4"></td>
<td><input type="text" name="fifoprice" id="fifoprice" value="#evaluate('getfifoopq.ffc#i#')#" onBlur="updateqty('ffc#i#',this.value,'price');" size="4"></td>
<td><input type="text" name="fifodate" id="fifodate" value="#evaluate('dateformat(getfifoopq.ffd#i#,"dd/mm/yyyy")')#" size="10" onBlur="updateqty('ffd#i#',this.value,'date');"> (DD/MM/YYYY)</td>
</tr>
</cfloop>
</table>
</div>
<div id="changefifoAjax"></div>
</cfoutput>
</body>
</html>