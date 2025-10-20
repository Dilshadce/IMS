<cfif isdefined('form.checklist')>
<cfquery name="getgross" datasource="#dts#">
SELECT * FROM assignmentslip WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.checklist#" list="yes" separator=",">) and combine <> "Y" ORDER BY REFNO
</cfquery>

<script type="text/javascript" src="/scripts/ajax.js"></script>




<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<h1>Pick Item To Group</h1>
<cfset uuid = createuuid()>
<script type="text/javascript">
function calamt()
{
	var pricecol = document.getElementById('price').value;
	var qtycol = document.getElementById('qty').value;
	
	document.getElementById('amount').value = (pricecol * qtycol).toFixed(2)
}

function groupitemfunc()
{
	var msg = "";
	if(document.getElementById('desp').value  == '')
	{
		msg = msg+'Item description should not be empty!\n';
	}
	
	if(parseFloat(document.getElementById('balance').value) < parseFloat(document.getElementById('amount').value))
	{
		msg = msg+'Item amount has over the balance!\n';
	}
	
	if(parseFloat(document.getElementById('amount').value) == 0)
	{
		msg = msg+'Amount should not be zero!\n';
	}
	
	if(isNaN(document.getElementById('amount').value) == true)
	{
		msg = msg+'Amount is not valid!\n';
	}
	
	if(msg != '')
	{
		alert(msg);
	}
	else
	{
		document.getElementById('groupitem').disabled = true;
		ajaxFunction(document.getElementById('ajaxfield'),'insertmitem.cfm?invlist=#URLENCODEDFORMAT(form.checklist)#&uuid=#uuid#&qty='+document.getElementById('qty').value+'&price='+document.getElementById('price').value+'&amount='+document.getElementById('amount').value+'&desp='+escape(encodeURI(document.getElementById('desp').value)));
	}
}
</script>
<cfform name="invlist" id="invlist" method="post" action="generateinvoice.cfm">
<input type="hidden" name="combinationtype" id="combinationtype" value="#form.combinationtype#">
<input type="hidden" name="invoicedate" id="invoicedate" value="#form.invoicedate#">
<input type="hidden" name="assignmenttype" id="assignmenttype" value="#form.assignmenttype#">
<input type="hidden" name="custno" id="custno" value="#form.custno#">
<input type="hidden" name="uuid" id="uuid" value="#uuid#">
<input type="hidden" name="listrefno" id="listrefno" value="#form.checklist#">

<table width="1000px" align="center">
<tr>
<th colspan="100%"><div align="left">Invoice Description : <cfinput type="text" name="invdesp" id="invdesp" value="" size="100" required="yes" message="Invoice Description is Required" ></div></th>
</tr>
<tr><th colspan="100%"><div align="center">Assignment Slip List </div></th></tr>
<tr>
<th><div align="left">No</div></th>
<th><div align="left">Refno</div></th>
<th><div align="left">Date</div></th>
<th><div align="left">Customer</div></th>
<th><div align="left">Employee</div></th>
<th><div align="Right">AMOUNT</div></th>
</tr>
<cfset totalamount = 0>
<cfloop query="getgross">
<tr>
<td><div align="left">#getgross.currentrow#</div></td>
<td><div align="left">#getgross.refno#</div></td>
<td><div align="left">#dateformat(getgross.assignmentslipdate,'dd/mm/yyyy')#</div></td>
<td><div align="left">#getgross.custname2#</div></td>
<td><div align="left">#getgross.empname#</div></td>
<td><div align="Right">#numberformat(getgross.custtotalgross,'.__')#</div></td>
</tr>
<cfset totalamount = totalamount + numberformat(getgross.custtotalgross,'.__')>
</cfloop>
<tr>
<th colspan="5">Total Amount</th>
<td><div align="Right"><input type="hidden" name="trantotalamt" id="trantotalamt" value="#numberformat(totalamount,'.__')#" />#numberformat(totalamount,'.__')#</div></td>
</tr>
</table>
<div id="ajaxfield">

<table align="center" width="1000px">
<tr>
<th colspan="3">Balance</th>
<th><input type="text" name="balance" id="balance" value="#numberformat(totalamount,'.__')#" size="20" readonly="readonly" /></th>
</tr>
<tr>
<th><div align="left">Item Description</div></th>
<th><div align="left">Quantity</div></th>
<th><div align="right">Price</div></th>
<th><div align="right">Amount</div></th>
</tr>
<tr>
<td><input type="text" name="desp" id="desp" value="" size="70" maxlength="400"/></td>
<td><input type="text" name="qty" id="qty" value="1" size="10" onkeyup="calamt()" /></td>
<td><input type="text" name="price" id="price" value="0.00" size="20" onkeyup="calamt()" /></td>
<td><input type="text" name="amount" id="amount" value="0.00" size="20" readonly="readonly" /></td>
</tr>
<tr>
<td colspan="100%"><div align="center"><input type="button" name="groupitem" id="groupitem" value="Insert Item" onClick="groupitemfunc();"></div></td>
</tr>
</table>
</div>
</cfform>
</cfoutput>
</cfif>