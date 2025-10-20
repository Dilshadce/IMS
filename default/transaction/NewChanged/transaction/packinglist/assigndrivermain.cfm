<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfif isdefined('url.result')>
<cfif url.result eq "success">
<cfset msg = "Assign Driver Success!">
<cfelseif url.result eq "no">
<cfset msg = "No Packing List Selected">
<cfelseif url.result eq "fail">
<cfset msg = "Assign Driver Fail!">
<cfelse>
<cfset msg = "">
</cfif>
<script type="text/javascript">
<cfoutput>alert('#msg#');</cfoutput>
</script>
</cfif>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
function checkalllist(chk)
{
if(document.assigndriver.checkall.value=="checkall"){
for (i = 0; i < chk.length; i++)
chk[i].checked = true ;
document.assigndriver.checkall.value="uncheckall";
}else{

for (i = 0; i < chk.length; i++)
chk[i].checked = false ;
document.assigndriver.checkall.value="checkall";
}
}
</script>
<title>List Packing List</title>
</head>

<body style="width:1000px; margin: 0 auto; text-align:left">
<h4>
	<a href="/default/transaction/packinglist/packinglistmain.cfm">Create Packing List</a> || 
	<a href="/default/transaction/packinglist/listpackingmain.cfm">List Packing List</a> || 
	<a href="/default/transaction/packinglist/assigndrivermain.cfm">Assign Driver</a>||
   <a href="/default/transaction/packinglist/deliveryrecord/checkdelivered.cfm">Delivery Record</a>||
    <a href="/default/transaction/packinglist/standardreport.cfm">Delivery Report</a>||
    <a href="/default/transaction/packinglist/packinglistreportmenu.cfm">Packing Report</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">Customer Report</a>
</h4>

<cfquery name="getDriver" datasource="#dts#">
SELECT * FROM driver
</cfquery>
<cfoutput>

<h1>ASSIGN DRIVER</h1>
<cfquery name="getPackList" datasource="#dts#">
SELECT * FROM packlist where driver is null or driver = "" order by created_on 
</cfquery>
<br/>
<table width="800px">
<tr>
<th>FILTER BY</th>
</tr>
<tr>
<td>PACK ID FROM</td>
<td>
<select name="packidfrom" id="packidfrom">
<option value="">SELECT PACK ID</option>
<cfloop query="getPackList">
<option value="#getPackList.packID#">#getPackList.packID#</option>
</cfloop>
</select>
</td>
<td>DATE PACKED FROM (DD/MM/YYYY)</td>
<td>
<input type="text" id="datepackfrom" name="datepackfrom" value="" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datepackfrom);">
</td>
</tr>
<td>PACK ID TO</td>
<td><select name="packidto" id="packidto">
<option value="">SELECT PACK ID</option>
<cfloop query="getPackList">
<option value="#getPackList.packID#">#getPackList.packID#</option>
</cfloop>
</select></td>
<td>DATE PACKED TO (DD/MM/YYYY)</td>
<td>
<input type="text" id="datepackto" name="datepackto" value="" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datepackto);">
</td>
<tr><td colspan="4" align="center"><input type="button" name="GO" id="GO" value="FILTER" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'assigndrivermainAjax.cfm?datepackfrom='+document.getElementById('datepackfrom').value+'&datepackto='+document.getElementById('datepackto').value+'&packidfrom='+document.getElementById('packidfrom').value+'&packidto='+document.getElementById('packidto').value);"  /></td></tr>
</table>
<div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
<form name="assigndriver" id="assigndriver" action="/default/transaction/packinglist/assigndriverprocess.cfm" method="post">
<table width="800px">
<tr>
<th>DRIVER</th>
<td>:</td>
<td>
<select name="driver" id="driver">
<cfloop query="getDriver">
<option value="#getDriver.DRIVERNO#">#getDriver.DRIVERNO#-#getDriver.NAME#</option>
</cfloop>
</select>
</td>
<th>DELIVERY DATE</th>
<td>:</td>
<td><input type="text" id="deliverydate" name="deliverydate" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverydate);">&nbsp;(DD/MM/YYYY)</td>
<th>TRIP</th>
<td><input type="text" id="trip" name="trip" value=""></td>
</tr>
</table>
<table width="800px">
<tr>
<th width="100">PACK ID</th>
<th width="150">DATE PACKED</th>
<th width="150">PACKED BY</th>
<th width="100"><input type="checkbox" name="checkall" id="checkall" onClick="checkalllist(document.assigndriver.packID)" value="checkall"  >ASSIGN</th>
</tr>
</table>
<div id="ajaxField">
<table width="800px">
<cfloop query="getPackList">
<tr>
<td width="100">#getPackList.packID#</td>
<cfif getPackList.Created_on lt getPackList.updated_on >
<cfset datepacked = getPackList.updated_on>
<cfelse>
<cfset datepacked = getPackList.Created_on>
</cfif>
<td width="150">#datepacked#</td>
<cfif getPackList.updated_by neq "">
<cfset packedby = getPackList.updated_by>
<cfelse>
<cfset packedby = getPackList.created_by>
</cfif>
<td width="150">#packedby#</td>
<td width="100"><input type="checkbox" name="packID" id="packID" value="#getPackList.packID#"  /></td>
</tr>
</cfloop>
<tr><td colspan="4">&nbsp;</td></tr>
<tr><td colspan="4" align="center"><input type="submit" name="SUBMIT" id="SUBMIT" value="ASSIGN"  /></td></tr>
</table>
</div>
</form>
</cfoutput>
</body>
</html>