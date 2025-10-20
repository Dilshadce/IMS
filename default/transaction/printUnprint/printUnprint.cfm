
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
<div align="center" >  
<h1>Print Unprint #ucase(url.Tran)#</h1>
<table >
<tr>
<th>Date From</th><td>:</td><td><input type="text" id="datefrom" name="datefrom" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">&nbsp;(DD/MM/YYYY)</td> 
<td>&nbsp;

</td>
<th>Date To</th>
<td>:</td>
<td><input type="text" id="dateto" name="dateto" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">&nbsp;(DD/MM/YYYY)</td>
<td>&nbsp;</td>
<td><input type="button" name="Go" id="Go" value="GO" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'printUnprintAjax.cfm?datefrom='+document.getElementById('datefrom').value+'&dateto='+document.getElementById('dateto').value+'&tran=#url.Tran#');" ></td>
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