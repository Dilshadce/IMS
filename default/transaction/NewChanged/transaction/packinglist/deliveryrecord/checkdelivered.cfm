<cfajaximport tags="cfform">
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
function setID(comid)
{
document.getElementById("hiddentext").value = comid;
}
function vericheck(fieldvar,opvar,valvar)
{

var button1 = fieldvar+valvar;
var button2 = opvar + valvar;
var btnobj1 = document.getElementById(button1);
var btnobj2 = document.getElementById(button2);
if(btnobj1.checked == true)
{
btnobj2.checked = false;
}
}

function closewindow()
{
ajaxFunction1(document.getElementById('ajaxField'),'checkdeliveredajax.cfm?datepackfrom='+document.getElementById('datepackfrom').value+'&datepackto='+document.getElementById('datepackto').value+'&packidfrom='+document.getElementById('packidfrom').value+'&packidto='+document.getElementById('packidto').value);
ColdFusion.Window.hide('deliverlist');
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
    <a href="/default/transaction/packinglist/packingreport.cfm">Packing Report</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">Customer Report</a>
</h4>

<cfquery name="getDriver" datasource="#dts#">
SELECT * FROM driver
</cfquery>
<cfoutput>

<h1>Check Delivered</h1>
<cfquery name="getPackList" datasource="#dts#">
SELECT * FROM packlist where 
(driver <> "")
and 
(delivered_on = "0000-00-00" or delivered_on is null)
and 
(delivered_by is null or delivered_by = "")
order by packid limit 100
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
<tr><td colspan="4" align="center"><input type="button" name="GO" id="GO" value="FILTER" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'checkdeliveredajax.cfm?datepackfrom='+document.getElementById('datepackfrom').value+'&datepackto='+document.getElementById('datepackto').value+'&packidfrom='+document.getElementById('packidfrom').value+'&packidto='+document.getElementById('packidto').value);"  /></td></tr>
</table>
<div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
<form name="assigndriver" id="assigndriver" action="checkdeliveredpro.cfm" method="post">
<table width="800px">
<tr>
<th>DELIVERED DATE</th>
<td>:</td>
<td><input type="text" id="deliverydate" name="deliverydate" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverydate);">&nbsp;(DD/MM/YYYY)</td>
</tr>
</table>
<table width="800px">
<tr>
<th width="100">PACK ID</th>
<th width="150">DATE DELIVER</th>
<th width="150">DELIVER BY</th>
<th width="100">All Delivered</th>
</tr>
</table>
<div id="ajaxField">
<table width="800px">
<cfloop query="getPackList">
<tr onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getPackList.packID#');" onMouseOut="javascript:this.style.backgroundColor='';">
<td width="100"><u><a onMouseOver="style.cursor='hand'" onClick="javascript:ColdFusion.Window.show('deliverlist');">#getPackList.packID#</a></u></td>
<td width="150">#dateformat(getPackList.delivery_on,'YYYY-MM-DD')#</td>
<cfquery name="getdriver" datasource="#dts#">
SELECT Name FROM driver where driverno = "#getPackList.driver#" 
</cfquery>
<td width="150">#getdriver.name#</td>
<td width="100"><input type="checkbox" name="packID" id="packID" value="#getPackList.packID#"  /></td>
</tr>
</cfloop>
<tr><td colspan="4">&nbsp;</td></tr>
<tr><td colspan="4" align="center"><input type="submit" name="SUBMIT" id="SUBMIT" value="Delivered"  /></td></tr>
</table>
</div>
<input type="hidden" name="hiddentext" id="hiddentext" value=""  />
</form>
</cfoutput>
<cfwindow center="true" width="400" height="400" name="deliverlist" refreshOnShow="true"
        title="Delivery List" initshow="false"
        source="/default/transaction/packinglist/deliveryrecord/listdeliver.cfm?packid={hiddentext}" modal="true" />
</body>
</html>
