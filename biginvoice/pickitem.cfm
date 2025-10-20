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
function groupitemfunc()
{
	var refnolist = "";
	var checklistitem = document.getElementById('invlist').checklist;
	var checklen = checklistitem.length;
	for(var i=0;i<checklen;i++)
	{
		if(checklistitem[i].checked == true)
		{
			refnolist = refnolist + checklistitem[i].value;
			if(i != checklen)
			{
				refnolist = refnolist + ',';
			}
		}
	}
	
	if(refnolist == '' || document.getElementById('desp').value  == '')
	{
		alert('Please select at least one item to group and Invoice description should not be empty!');
	}
	else
	{
		document.getElementById('groupitem').disabled = true;
		ajaxFunction(document.getElementById('ajaxfield'),'insertitem.cfm?uuid=#uuid#&refnolist='+escape(refnolist)+'&desp='+escape(encodeURI(document.getElementById('desp').value)));
	}
}
</script>
<cfloop query="getgross">
<cfinclude template="createitemlist.cfm">
</cfloop>
<cfform name="invlist" id="invlist" method="post" action="generateinvoice.cfm">
<input type="hidden" name="combinationtype" id="combinationtype" value="#form.combinationtype#">
<input type="hidden" name="invoicedate" id="invoicedate" value="#form.invoicedate#">
<input type="hidden" name="assignmenttype" id="assignmenttype" value="#form.assignmenttype#">
<input type="hidden" name="custno" id="custno" value="#form.custno#">
<input type="hidden" name="uuid" id="uuid" value="#uuid#">
<input type="hidden" name="listrefno" id="listrefno" value="#form.checklist#">
<div id="ajaxfield">
<table width="1000px" align="center">
<tr>
<th colspan="100%"><div align="left">Invoice Description : <input type="text" name="desp" id="desp" value="" size="100" ></div></th>
</tr>
<tr><th colspan="100%"><div align="center">Assignment Slip List Item</div></th></tr>
<tr>
<th><div align="left">Refno</div></th>
<th><div align="left">Item List</div></th>
</tr>

<cfloop query="getgross">
<tr>
<td>#getgross.refno#</td>
<cfquery name="getitemlist" datasource="#dts#">
SELECT * FROM tempcreatebiitem WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.refno#"> and uuid = "#uuid#" ORDER BY Id
</cfquery>
<td>
<table width="100%">
<tr>
<th width="5%"><div align="left">No</div></th>
<th width="50%"><div align="left">Item Description</div></th>
<th width="5%"><div align="left">Qty</div></th>
<th width="10%"><div align="right">Price</div></th>
<th width="10%"><div align="right">Amount</div></th>
<th width="10%"><div align="left">Action</div></th>
</tr>
<cfloop query="getitemlist">
<tr>
<td>#getitemlist.currentrow#</td>
<td><div align="left">#getitemlist.desp#<cfif getitemlist.desp2 neq ""><br/>#getitemlist.desp2#</cfif></div></td>
<td><div align="left">#val(getitemlist.qty)#</div></td>
<td><div align="right">#numberformat(val(getitemlist.price),'.__')#</div></td>
<td><div align="right">#numberformat(val(getitemlist.amount),'.__')#</div></td>
<td><input type="checkbox" name="checklist" id="checklist" value="#getitemlist.id#"></td>
</tr>
</cfloop>
</table>
</td>
</tr>
</cfloop>
<tr>
<td colspan="100%"><div align="center"><input type="button" name="groupitem" id="groupitem" value="Group Item" onClick="groupitemfunc();"></div></td>
</tr>
</table>
</div>
</cfform>
</cfoutput>
</cfif>