<cfajaximport tags="cfform">
<cfajaximport tags="cfwindow,cflayout-tab"> 
<html>
<head></head>
<body>

<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
     <script type="text/javascript">
	
	function test_suffix(form,field,value)
{
		
		// require that at least one character be entered
		if (value.length < 3)
		{
		return false;
		}
		
		if (value == '000')
		{
		return false;
		}
		
		return true;
}
	function test_prefix(form,field,value)
	{
		
		
		
		var allNum = "";
		var chkVal = allNum;
		var prsVal = parseInt(allNum);
		
		var item1 = value;
		var item2 = '<cfoutput>#getgsetup.debtorfr#</cfoutput>'; 
		var item3 = '<cfoutput>#getgsetup.debtorto#</cfoutput>'; 		
	
		var checkOK = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		var allValid = true;
		var decPoints = 0;
		var allNum = "";
		
		for (i = 0;  i < item1.length;  i++)
		{
		ch = item1.charAt(i);
		for (j = 0;  j < checkOK.length;  j++)
		if (ch == checkOK.charAt(j))
		break;
		if (j == checkOK.length)
		{
		allValid = false;
		break;
		}
		if (ch != ",")
		allNum += ch;
		
		}
		if (!allValid)
		{
		return false;
		}
				
		for (var i = 0; i<value.length; i++)
		{		
		
    	if (item1.charCodeAt(i) < item2.charCodeAt(i) || item1.charCodeAt(i) > item3.charCodeAt(i)){		

		return false;
		
		}
		} 
		
		return true;
				
	}

	function checkcustno()
{
var custnoStatus = document.getElementById('cust_noApproval').value;

if (custnoStatus == 1)
{
document.CreateCustomer.SubmitButton.disabled = false;
}
else
{
document.CreateCustomer.SubmitButton.disabled = true;
}
}
</script>
    
<cfoutput>
<h1>Search Customer</h1>
<table>
<tr>
<th nowrap>Name/Address/Contact No/Tel/Hp/Email</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="searchcontact" id="searchcontact" value="" size="35" onBlur="ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?contact='+escape(document.getElementById('searchcontact').value));" onKeyUp="ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?contact='+escape(document.getElementById('searchcontact').value));" /> &nbsp; <input  type="button" style="background:none;" name="newcustbtn" id="newcustbtn" onClick="ColdFusion.Window.show('createCustomer');" value="Create New Customer"/><!---<input  type="button" style="background:none;" name="newcustbtn" id="newcustbtn" onclick="ColdFusion.Window.hide('searchmember');ColdFusion.Window.show('createCustomer');" value="New"/> --->
</td>
</tr>
<tr>
<td colspan="3" align="center">
<input type="button" name="search_btn" id="search_btn" value="Search" onClick="ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?contact='+escape(document.getElementById('searchcontact').value));"  />
</td>
</tr>
</table>
<div id="searchmemberajax">
<table>
<tr>
<th width="100px">Customer No</th>
<th width="150px">Name</th>
<th width="100px">Contact</th>
<th width="100px">Tel</th>
<th width="100px">Hp</th>
<th width="100px">Email</th>
<th width="300px">Address</th>
<th width="100px">Action</th>
</tr>
<cfquery name="getlist" datasource="#dts#">
SELECT custno,name,phone,add1,add2,add3,add4,add5,contact,phone,phonea,e_mail FROM #target_arcust# order by custno limit 10
</cfquery>
<cfloop query="getlist">
<tr>
<td>#getlist.custno#</td>
<td>#getlist.name#</td>
<td>#getlist.contact#</td>
<td>#getlist.phone#</td>
<td>#getlist.phonea#</td>
<td>#getlist.e_mail#</td>
<td>
#getlist.add1# #getlist.add2# #getlist.add3# #getlist.add4# #getlist.add5#
</td>
<td align="right">
<a style="cursor:pointer" onClick="ajaxFunction(document.getElementById('searchmemberajax'),'selectmemberajax.cfm?custno=#getlist.custno#');">Select</a>

</td>
</tr>
</cfloop>
</table>
</div>
</cfoutput>
</body>
</html>

<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createCustomer" refreshOnShow="true"
        title="Add New Customer" initshow="false"
        source="/default/maintenance/atccreateCustomerAjax.cfm" />