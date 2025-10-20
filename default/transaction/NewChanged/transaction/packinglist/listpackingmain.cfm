<cfajaximport tags="cfform">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<script type="text/javascript">
function deletePackList(packid)
{
var msg = "Are you sure you want to delete Packing ID: "+packid+" ?";
var answer = confirm(msg);
if (answer)
{

ajaxFunction(document.getElementById('ajaxField10'),'deletePackList.cfm?packID='+packid);
alert("DELETE SUCESS!");
ajaxFunction1(document.getElementById('ajaxField'),'listpackingmainAjax.cfm?packID='+escape(document.getElementById('packidsearch').value)+'&datepacked='+escape(document.getElementById('datepacksearch').value)+'&driver='+escape(document.getElementById('driversearch').value));
}
}

function addSo()
{
var addsonum = document.getElementById("addSO").value;
var com1 = addsonum;

var cb = document.createElement("input"); 
cb.type = "checkbox"; 
cb.name = "packidlist";
cb.checked = cb.defaultChecked = true; 
cb.value = addsonum;
addRow('myTable',com1,cb);
ColdFusion.Window.hide('addSO');
}

function setID(comid)
{
document.getElementById("hiddentext").value = comid;

}


function addRow(id,com1,com2){
    var tbody = document.getElementById(id).getElementsByTagName("TBODY")[0];
    var row = document.createElement("TR")
    var td1 = document.createElement("TD")
    td1.appendChild(document.createTextNode(com1))
    var td2 = document.createElement("TD")
    td2.appendChild (com2)
    row.appendChild(td1);
    row.appendChild(td2);
    tbody.appendChild(row);
  }
</script>

<title>List Packing List</title>
</head>

<body>
<h4>
	<a href="/default/transaction/packinglist/packinglistmain.cfm">Create Packing List</a> || 
	<a href="/default/transaction/packinglist/listpackingmain.cfm">List Packing List</a> || 
	<a href="/default/transaction/packinglist/assigndrivermain.cfm">Assign Driver</a>||
    <a href="/default/transaction/packinglist/deliveryrecord/checkdelivered.cfm">Delivery Record</a>||
    <a href="/default/transaction/packinglist/standardreport.cfm">Delivery Report</a>||
    <a href="/default/transaction/packinglist/packinglistreportmenu.cfm">Packing Report</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">Customer Report</a>
    </h4>
<div align="center">
<h1>Packing List</h1>


<h2>Newest 20 Packing List</h2>
<table>
<tr>
<th>PACK ID</th><td>:</td><td><input type="text" id="packidsearch" name="packidsearch"  /></td>
<th>DATE PACKED</th><td>:</td><td><input type="text" id="datepacksearch" name="datepacksearch"  />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datepacksearch);"></td>
<th>DRIVER</th><td>:</td><td><input type="text" id="driversearch" name="driversearch"  /></td>
<td><input type="button" name="GO" value="GO" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'listpackingmainAjax.cfm?packID='+escape(document.getElementById('packidsearch').value)+'&datepacked='+escape(document.getElementById('datepacksearch').value)+'&driver='+escape(document.getElementById('driversearch').value));" /></td>
</tr>
</table>
<div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
<cfquery name="getPackList" datasource="#dts#">
SELECT * from packlist order by created_on desc,updated_on desc limit 20
</cfquery>
<cfoutput>

<table class="data" align="center">
<tr>
<th width="100px">PACKING ID</th><th width="150px">DATE PACKED</th><th width="100px">PACKED BY</th><th width="100px">DRIVER</th><th width="100px">DELIVER ON</th><th width="200px">ACTION</th>
</tr>
</table>
<div id="ajaxField">
<table class="data" align="center">
<cfloop query="getPackList">

<tr onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getPackList.packID#');" onMouseOut="javascript:this.style.backgroundColor='';">
<td align="left" width="100px">#getPackList.packID#</td>
<cfif getPackList.Created_on lt getPackList.updated_on >
<cfset datepacked = getPackList.updated_on>
<cfelse>
<cfset datepacked = getPackList.Created_on>
</cfif>
<td align="left" width="150px">#dateformat(datepacked,'yyyy-mm-dd')#-#timeformat(datepacked,'HH:MM')#</td>
<cfif getPackList.updated_by neq "">
<cfset packedby = getPackList.updated_by>
<cfelse>
<cfset packedby = getPackList.created_by>
</cfif>
<td align="left" width="100px">#packedby#</td>
<cfif getPackList.driver eq "">
<cfset driverlist = "Not Yet Assign">
<cfelse>
<cfset driverlist = getPackList.driver>
</cfif>
<td align="left" width="100px">#driverlist#</td>
<td align="left" width="100px">#dateformat(getPackList.delivery_on,'yyyy-mm-dd')#</td>
<td align="left" width="200px">
<table>
<tr >
<td align="center" width="30px"><cfif driverlist eq "Not Yet Assign"><a onMouseOver="style.cursor='hand'" onClick="javascript:ColdFusion.Window.show('assigndriver');"><img src="/images/wheel.gif" width="20px" height="20px" /><br/>DRIVER</a></cfif></td>
<td align="center" width="30px"><cfif driverlist eq "Not Yet Assign"><a onMouseOver="style.cursor='hand'" onClick="javascript:ColdFusion.Window.show('editPackList');"><img src="/images/edit.ico" width="20px" height="20px"  /><br />EDIT</a></cfif></td>
<td align="center" width="30px"><a href="/default/transaction/packinglist/printpackinglist.cfm?packno=#URLEncodedFormat(getPackList.packID)#" target="_blank"><img src="/images/printRpt.gif" width="20px" height="20px" /><br/>Print</a></td>
<td align="center" width="30px"><a onMouseOver="style.cursor='hand'" onClick="deletePackList('#getPackList.packID#')" /><img src="/images/delete.ico" width="20px" height="20px" /><br/>DELETE</a></td>
</tr>
</table>
</td></tr>
</cfloop></table>
</div>
</cfoutput>
</div>
<div id="ajaxField10">
</div>
<cfform name="myform" id="myform" method="post" action="">
<input type="hidden" name="hiddentext" id="hiddentext" value=""  />

</cfform>
<cfwindow center="true" width="520" height="400" name="assigndriver" refreshOnShow="true"
        title="Assign Driver" initshow="false"
        source="/default/transaction/packinglist/assignDriver.cfm?packid={myform:hiddentext}" modal="true" />
<cfwindow center="true" width="520" height="400" name="editPackList" refreshOnShow="true"
        title="Edit Packing List" initshow="false"
        source="/default/transaction/packinglist/editPackingList.cfm?packid={myform:hiddentext}" modal="true" />
<cfwindow center="true" width="250" height="200" name="addSO" refreshOnShow="true"
        title="Add More SO" initshow="false"
        source="/default/transaction/packinglist/addMoreSO.cfm?packid={myform:hiddentext}&reftype=" modal="true" />
</body>
</html>
