<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
function validateform()
{
var msg = "";
if(document.getElementById('sono').value == "")
{
msg = msg + "Project is required!\n";
}
if(document.getElementById('itemno').value == "")
{
msg = msg + "Finished Good Item is required!\n";
}
if(document.getElementById('quantity').value == "" || document.getElementById('quantity').value == "0")
{
msg = msg + "Finished Good Quantity is required!\n";
}
if(msg != "")
{
alert(msg);
return false
}
else
{
return true;
}
}
function formsubmit()
{
reinsert.submit();
}

function validateqty(maxqty)
{
var length=maxqty.length;
var desc=maxqty.substr(7,maxqty.length);
if((document.getElementById('usedqty'+desc).value*1) >(document.getElementById('maxqty'+desc).value*1))
{
alert('Qty is over max Qty');
document.getElementById('usedqty'+desc).value=0;
}
}
</script>
 <title>FINISH GOOD</title>
</head>
<body>
<cfform name="update" id="update" action="process.cfm" method="post" onsubmit="return validateform();">

<cfquery name="getgeneral" datasource="#dts#">
	select filterall,displayaitemno from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getlocation">
	select
	location,
	desp 
	from iclocation 
	order by location;
</cfquery>

<cfquery name="getallso" datasource="#dts#">
SELECT "" as source,"Choose a Sales Order" as project
union all
SELECT source, concat(source," - ",project) as project FROM #target_project# where PORJ = "P" and completed = "0" order by source
</cfquery>
<h4>
<a href="index.cfm">Create Finished Goods</a>&nbsp;&nbsp;||&nbsp;&nbsp;<a href="listfinish.cfm">List Finished Goods</a>&nbsp;&nbsp;||&nbsp;&nbsp;<a href="finishedgoodreport.cfm">Finished Goods Report</a>&nbsp;&nbsp;||&nbsp;&nbsp;<a href="finishedgoodreport2.cfm">Finished Goods Summary</a></h4>	
<h1>FINISHED GOODS</h1>
<table>
<tr>
<th>Sales Order</th>
<td>:</td>
<td><cfselect name="sono" id="sono" query="getallso" value="source" display="project" onChange="ajaxFunction(document.getElementById('ajaxfield'),'listitem.cfm?refno='+escape(this.value)+'&itemno='+escape(document.getElementById('itemno').value));"></cfselect></td>
</tr>
</tr>
<tr>
<th>Finished Good Item</th>
<td>:</td>
<cfif getgeneral.displayaitemno eq 'Y'>
<cfquery name="getitem" datasource="#dts#">
SELECT "" as itemno, "Choose an Item" as desp
union all
select itemno, concat(aitemno,' - ',desp) as desp from icitem order by itemno
</cfquery>
<cfelse>
<cfquery name="getitem" datasource="#dts#">
SELECT "" as itemno, "Choose an Item" as desp
union all
select itemno, concat(itemno,' - ',desp) as desp from icitem order by itemno
</cfquery>
</cfif>
<td>
<cfselect name="itemno" id="itemno" bind="cfc:itemno.getitemlist('#dts#',{sono})" value="itemno" display="desp" onChange="ajaxFunction(document.getElementById('ajaxfield'),'listitem.cfm?itemno='+escape(this.value)+'&refno='+escape(document.getElementById('sono').value));"></cfselect>
</td>
</tr>
<tr>
<th>
Finished Good Quantity
</th>
<td>:</td>
<td><cfinput type="text" name="quantity" id="quantity" value="0"  /></td>
</tr>
<tr>
<th>Location</th>
<td>:</td>
<td><cfoutput><cfselect name="location" id="location">
<option value="">Select a Location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</cfselect></cfoutput></td>
</tr>
<tr>
<td colspan="3">
<div id="ajaxfield">
</div>
</td>

<tr>
<td align="center" colspan="3"><div align="center"><input type="submit" name="submitbtn" id="submitbtn" value="Save" <!--- onclick="document.update.action='process.cfm';formsubmit();" --->/><!--- &nbsp;&nbsp;<input type="button" name="submitbtn" id="submitbtn" value="Save & Process" onclick="document.update.action='process.cfm?process=1';formsubmit();" /> ---></div></td>
</tr>
</table>
</cfform>
</body>
</html>
