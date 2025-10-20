

<html>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery>

<head>
<title>E-Invoicing Submission </title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<cfoutput>
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script type="text/javascript" src="/scripts/ajax.js"></script>

<script type="text/javascript">

function checkalllist(chk)
{
if(document.einvoice.checkall.value=="checkall"){
for (i = 0; i < chk.length; i++)
chk[i].checked = true ;
document.einvoice.checkall.value="uncheckall";
}else{

for (i = 0; i < chk.length; i++)
chk[i].checked = false ;
document.einvoice.checkall.value="checkall";
}
}

function getList()
{
var invfrom = document.getElementById('invfrm').value;
var invto = document.getElementById('invto').value;
var comfrom = document.getElementById('comfrm').value;
var comto = document.getElementById('comto').value;
var periodfrom = document.getElementById('periodfrom').value;
var periodto = document.getElementById('periodto').value;
var datefrom = document.getElementById('datestart').value;
var dateto = document.getElementById('dateend').value;

var urllist = "/default/eInvoicing/eInvoiceListAjax.cfm?";

if (invfrom != "")
{
urllist = urllist + "invfrom=" + invfrom + "&";
}
if (invto != "")
{
urllist = urllist + "invto=" + invto + "&";
}
if (comfrom != "")
{
urllist = urllist + "comfrom=" + comfrom + "&";
}
if (comto != "")
{
urllist = urllist + "comto=" + comto + "&";
}
if (periodfrom != "")
{
urllist = urllist + "periodfrom=" + periodfrom + "&";
}
if (periodto != "")
{
urllist = urllist + "periodto=" + periodto + "&";
}
if (datefrom != "")
{
urllist = urllist + "datefrom=" + datefrom + "&";
}
if (dateto != "")
{
urllist = urllist + "dateto=" + dateto + "&";
}
if(document.getElementById('submitedinvoice').checked == true)
{
urllist = urllist + "showsubmited=true&";
}
if(document.getElementById('excludegeneratedinvoice').checked == true)
{
urllist = urllist + "excludegeneratedinvoice=true&";
}
window.open(urllist, "ajaxField");
ajaxFunction(document.getElementById('ajaxField'),urllist);
}

function periodmonth(fperiod,column)
{
var fperiod = fperiod * 1;
var lyear = #year(getgeneral.lastaccyear)#;
var lmonth = #month(getgeneral.lastaccyear)#;
var nmonth = lmonth + fperiod;
var nyear = lyear;
var m_names = new Array("Jan", "Feb", "Mar", "Apr", "May", "June", "Jul", "Aug", "Sept", "Oct","Nov", "Dec");
while (nmonth > 12)
{
nmonth = nmonth - 12;
nyear = nyear + 1;
}

if (column == "from")
{
document.getElementById('periodfrm').value = m_names[nmonth-1] + " " + nyear;
}

if (column == "to")
{
document.getElementById('prdto').value = m_names[nmonth-1] + " " + nyear;
}

}

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
</script>
</cfoutput>
</head>

<body>

<cfquery name="getInvoice" datasource="#dts#">
SELECT refno FROM artran where type = "INV" 
and fperiod <> 99
and (void = "" or void is null)
<cfif Huserloc neq "All_loc">
and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
</cfif>
<cfif lcase(hcomid) eq "beps_i">
and refno in (select refno from assignmentslip where assignmenttype='einvoice')
</cfif>
</cfquery>

<cfquery name="getCust" datasource="#dts#">
SELECT * from #target_arcust#
</cfquery>



<h1><center>Invoice Submission</center></h1>
<br><br>


<table width="75%" border="0" class="data" align="center">
 <tr>
 <th width="100px">Invoice No From<input type="hidden" name="fromto" id="fromto" value="" /></th>
<td width="20px">:</td>
<td>
<select name="invfrm" id="invfrm">
<option value="">Choose a invoice</option>
<cfoutput query="getInvoice">
<option value="#getInvoice.refno#">#getInvoice.refno#</option>
</cfoutput>
</select>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='frm';ColdFusion.Window.show('findbill');" />
</td>
<th width="100px">Invoice No To</th>
 <td width="20px">:</td>
 <td>
 <select name="invto" id="invto">
 <option value="">Choose a invoice</option>
<cfoutput query="getInvoice">
<option value="#getInvoice.refno#">#getInvoice.refno#</option>
</cfoutput>
</select>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findbill');" />
 </td>
 </tr>
 <tr>
 <th>Company No From</th>
 <td>:</td>
 <td><select name="comfrm" id="comfrm">
 <option value="">Choose a company</option>
<cfoutput query="getCust">
<option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
</cfoutput>
</select></td>
 <th>Company No To</th>
 <td>:</td>
 <td><select name="comto" id="comto">
  <option value="">Choose a company</option>
<cfoutput query="getCust">
<option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
</cfoutput>
</select></td>
 </tr>
 <tr>
 <th>Period From</th>
 <td>:</td>
 <td>	<select name="periodfrom" id="periodfrom"  onChange="periodmonth(this.value,'from')">
          		<option value="">Choose a period</option>
          		<option value="1">1</option>
          		<option value="2">2</option>
          		<option value="3">3</option>
          		<option value="4">4</option>
          		<option value="5">5</option>
          		<option value="6">6</option>
          		<option value="7">7</option>
          		<option value="8">8</option>
          		<option value="9">9</option>
          		<option value="10">10</option>
          		<option value="11">11</option>
          		<option value="12">12</option>
         	 	<option value="13">13</option>
          		<option value="14">14</option>
          		<option value="15">15</option>
          		<option value="16">16</option>
          		<option value="17">17</option>
          		<option value="18">18</option>
        	</select>&nbsp;<input type="text" name="periodfrm" id="periodfrm" value="" size="10" readonly></td>
      
  <th>Period To</th>
 <td>:</td>
 <td>	<select name="periodto" id="periodto"  onChange="periodmonth(this.value,'to')">
          		<option value="">Choose a period</option>
          		<option value="1">1</option>
          		<option value="2">2</option>
          		<option value="3">3</option>
          		<option value="4">4</option>
          		<option value="5">5</option>
          		<option value="6">6</option>
          		<option value="7">7</option>
          		<option value="8">8</option>
          		<option value="9">9</option>
          		<option value="10">10</option>
          		<option value="11">11</option>
          		<option value="12">12</option>
         	 	<option value="13">13</option>
          		<option value="14">14</option>
          		<option value="15">15</option>
          		<option value="16">16</option>
          		<option value="17">17</option>
          		<option value="18">18</option>
        	</select>&nbsp;<input type="text" name="prdto" id="prdto" value="" size="10" readonly></td>
 </tr>
 <tr>
 <th>Date From</th>
 <td>:</td>
 <td><input type="text" readonly name="datestart" id="datestart" maxlength="10" size="10">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datestart);">(DD/MM/YYYY)</td>
  <th>Date To</th>
 <td>:</td>
 <td><input type="text" readonly name="dateend" id="dateend" maxlength="10" size="10">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateend);">(DD/MM/YYYY)</td>
 </tr>
 <th>Show Submited Invoice</th>
 <td>:</td>
 <td><input type="checkbox" name="submitedinvoice" id="submitedinvoice" value="show" ></td>
 <th>Exclude Generated Invoice</th>
 <td>:</td>
 <td><input type="checkbox" name="excludegeneratedinvoice" id="excludegeneratedinvoice" value="show" ></td>
 <tr>
 <tr>
 
 </tr>
 <tr>
 <td colspan="6" align="center">
 <input type="button" name="listinvoice" id="listinvoice" value="     List     " onClick="getList()" >
 </td>
 </tr>
</table>
<br/>
<table>
<tr><td>
<iframe name="ajaxField" id="ajaxField" width="1500px" align="center" style="height:350px; overflow:scroll">
</iframe>
</div></td></tr></table>

<cfwindow center="true" width="550" height="400" name="findbill" refreshOnShow="true"
        title="Find Bill" initshow="false"
        source="findbill.cfm?type=Bill&fromto={fromto}" />
</body>
</html>

