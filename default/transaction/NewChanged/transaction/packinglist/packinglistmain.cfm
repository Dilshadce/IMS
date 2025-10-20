
<html>
<head>
<title>Packing List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
function checkalllist(chk)
{
if(document.packinglist.checkall.value=="checkall"){
for (i = 0; i < chk.length; i++)
chk[i].checked = true ;
document.packinglist.checkall.value="uncheckall";
}else{

for (i = 0; i < chk.length; i++)
chk[i].checked = false ;
document.packinglist.checkall.value="checkall";
}
}
</script>
</head>

<body>
<cfoutput>
<h4>
	<a href="/default/transaction/packinglist/packinglistmain.cfm">Create Packing List</a> || 
	<a href="/default/transaction/packinglist/listpackingmain.cfm">List Packing List</a> || 
	<a href="/default/transaction/packinglist/assigndrivermain.cfm">Assign Driver</a>||
    <a href="/default/transaction/packinglist/deliveryrecord/checkdelivered.cfm">Delivery Record</a>||
    <a href="/default/transaction/packinglist/standardreport.cfm">Delivery Report</a>||
    <a href="/default/transaction/packinglist/packinglistreportmenu.cfm">Packing Report</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">Customer Report</a>
    
</h4>
<div align="center" >  
<h1>Packing List</h1>
<table >
<tr>
<th>Bill Type</th>
<td>:</td>
<td><select name='reftype' id='reftype'>
<option value='PO'>Purchase Order</option>
<option value='SO' selected>Sales Order</option>
<option value='DO'>Delivery Order</option>
<option value='INV'>Invoice</option>
<option value='CS'>Cash Sales</option>
</select>
</td>
<td></td>
<th>Last Used No</th>
<cfquery name="getlas" datasource="#dts#">
SELECT lastusedno,refnoused FROM refnoset WHERE type = "PACK" 
</cfquery>
<td>:</td>
<cfif getlas.refnoused neq "1">
<td><input type="text" name="packno1" id="packno1" maxlength="12" /></td>
<cfelse>
<td>#getlas.lastusedno#</td>
</cfif>
<td></td>
</tr>
<tr>
<th>Date From</th><td>:</td><td><input type="text" id="datefrom" name="datefrom" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">&nbsp;(DD/MM/YYYY)</td> 
<td>&nbsp;

</td>
<th>Date To</th>
<td>:</td>
<td><input type="text" id="dateto" name="dateto" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">&nbsp;(DD/MM/YYYY)</td>
<td>&nbsp;</td>
<td><input type="button" name="Go" id="Go" value="GO" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'packinglistmainajax.cfm?datefrom='+document.getElementById('datefrom').value+'&dateto='+document.getElementById('dateto').value+'&reftype='+document.getElementById('reftype').value);" ></td>
</tr>
</table>
</cfoutput>
<div id="ajaxField">
</div>
<div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
<div id="ajaxField2">
</div>
</div>
</body>
</html>