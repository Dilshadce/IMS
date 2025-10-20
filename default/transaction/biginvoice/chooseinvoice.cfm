<cfif isdefined('form.custno')>
<h1>Choose Invoice</h1>
<script type="text/javascript" src="/scripts/ajax.js"></script>

<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfif form.combinationtype eq "gasi">
<cfquery name="getinvlist" datasource="#dts#">
select refno,assignmentslipdate,custno,custname,custtotal,custtotalgross,created_by,empno,empname from assignmentslip where left(refno,1) ="s" and combine <> "Y" and custno = "#form.custno#"
ORDER BY refno,assignmentslipdate
</cfquery>
<cfform name="invlist" id="invlist" method="post" action="generateinvoice.cfm">
<input type="hidden" name="combinationtype" id="combinationtype" value="#form.combinationtype#">
<input type="hidden" name="invoicedate" id="invoicedate" value="#form.invoicedate#">
<input type="hidden" name="assignmenttype" id="assignmenttype" value="#form.assignmenttype#">
<input type="hidden" name="custno" id="custno" value="#form.custno#">
<table align="center">
<cfif form.combinationtype eq "gasi">
<tr>
<th colspan="2">
Invoice Description
</th>
<td colspan="6"><cfinput type="text" name="invdesp" id="invdesp" value="" size="100" required="yes" message="Invoice Description is Required"></td>
</tr>
<tr>
<th colspan="2">
Item Description
</th>
<td colspan="6"><cfinput type="text" name="desp" id="desp" value="" size="100" required="yes" message="Item Description is Required"></td>
</tr>
</cfif>
<tr>
<th align="center" colspan="100%">Choose Invoice To Combine</th>
</tr>
<tr>
<th>No</th>
<th>Refno</th>
<th>Date</th>
<th>Customer</th>
<th>Employee</th>
<th align="right">Gross</th>
<th align="right">Amount</th>
<th>User ID</th>
<th>Action</th>
</tr>
<cfloop query="getinvlist">
<tr <cfif numberformat(getinvlist.custtotal,'.__') eq 0> style="background-color:##FF0"</cfif>>
<td>#getinvlist.currentrow#</td>
<td>#getinvlist.refno#</td>
<td>#dateformat(getinvlist.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getinvlist.custname#</td>
<td>#getinvlist.empno# - #getinvlist.empname#</td>
<td align="right">#numberformat(getinvlist.custtotalgross,'.__')#</td>
<td align="right">#numberformat(getinvlist.custtotal,'.__')#</td>
<td>#getinvlist.created_by#</td>
<td>
<input type="checkbox" name="checklist" id="checklist" value="#getinvlist.refno#">
</td>
</tr>
</cfloop>
<tr>
<th colspan="100%">
<div align="center">
<cfinput type="submit" name="sub_btn" id="sub_btn" value="Create Big Invoice" validate="submitonce" validateat="onsubmit">
</div>
</th>
</tr>
</table>
</cfform>

<cfelseif form.combinationtype eq "mg">

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
		alert('Please select at least one small invoice and description should not be empty!');
	}
	else
	{
		document.getElementById('groupitem').disabled = true;
		ajaxFunction(document.getElementById('ajaxfield'),'insertrow.cfm?uuid=#uuid#&custno=#URLENCODEDFORMAT(form.custno)#&refnolist='+escape(refnolist)+'&desp='+escape(encodeURI(document.getElementById('desp').value)));
	}
}
</script>

<cfquery name="getinvlist" datasource="#dts#">
select refno,assignmentslipdate,custno,custname,custtotal,custtotalgross,created_by,empno,empname from assignmentslip where left(refno,1)="s" and combine <> "Y" and custno = "#form.custno#"
ORDER BY refno,assignmentslipdate
</cfquery>
<cfform name="invlist" id="invlist" method="post" action="generateinvoice.cfm">
<input type="hidden" name="combinationtype" id="combinationtype" value="#form.combinationtype#">
<input type="hidden" name="invoicedate" id="invoicedate" value="#form.invoicedate#">
<input type="hidden" name="assignmenttype" id="assignmenttype" value="#form.assignmenttype#">
<input type="hidden" name="custno" id="custno" value="#form.custno#">
<input type="hidden" name="uuid" id="uuid" value="#uuid#" />
<table align="center" width="1000px">
<tr>
<th><div align="left">Invoice Description&nbsp;&nbsp;&nbsp;<cfinput type="text" name="invdesp" id="invdesp" value="" size="100" required="yes" message="Invoice Description is Required"></div></th>
</tr>
</table>
<div id="ajaxfield">
<table align="center" width="1000px">
<tr>
<th colspan="100%">
<div align="left">Item Description&nbsp;&nbsp;&nbsp;<input type="text" name="desp" id="desp" value="" size="100"></div></th>
</tr>
<tr>
<th align="center" colspan="100%"><div align="center">Choose Invoice To Group & Combine</div></th>
</tr>
<tr>
<th>No</th>
<th>Refno</th>
<th>Date</th>
<th>Customer</th>
<th>Employee</th>
<th align="right">Gross</th>
<th align="right">Amount</th>
<th>User ID</th>
<th>Action</th>
</tr>
<cfloop query="getinvlist">
<tr <cfif numberformat(getinvlist.custtotal,'.__') eq 0> style="background-color:##FF0"</cfif>>
<td>#getinvlist.currentrow#</td>
<td>#getinvlist.refno#</td>
<td>#dateformat(getinvlist.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getinvlist.custname#</td>
<td>#getinvlist.empno# - #getinvlist.empname#</td>
<td align="right">#numberformat(getinvlist.custtotalgross,'.__')#</td>
<td align="right">#numberformat(getinvlist.custtotal,'.__')#</td>
<td>#getinvlist.created_by#</td>
<td>
<input type="checkbox" name="checklist" id="checklist" value="#getinvlist.refno#">
</td>
</tr>
</cfloop>
<tr>
<th colspan="100%">
<div align="center">
<cfif getinvlist.recordcount neq 0>
<input type="button" name="groupitem" id="groupitem" value="Group  as One Invoice Item" onclick="groupitemfunc();" />
</cfif>
<cfinput type="submit" name="sub_btn" id="sub_btn" value="Create Big Invoice" style="display:none" validate="submitonce" validateat="onsubmit">
</div>
</th>
</tr>
</table>
</div>
</cfform>

<cfelseif form.combinationtype eq "gnsi">

<cfquery name="getinvlist" datasource="#dts#">
select refno,assignmentslipdate,custno,custname,custtotal,custtotalgross,created_by,empno,empname from assignmentslip where left(refno,1) = "s" and combine <> "Y" and custno = "#form.custno#"
ORDER BY refno,assignmentslipdate
</cfquery>
<cfform name="invlist" id="invlist" method="post" action="pickitem.cfm">
<input type="hidden" name="combinationtype" id="combinationtype" value="#form.combinationtype#">
<input type="hidden" name="invoicedate" id="invoicedate" value="#form.invoicedate#">
<input type="hidden" name="assignmenttype" id="assignmenttype" value="#form.assignmenttype#">
<input type="hidden" name="custno" id="custno" value="#form.custno#">
<table align="center">
<tr>
<th align="center" colspan="100%">Choose Invoice To Combine</th>
</tr>
<tr>
<th>No</th>
<th>Refno</th>
<th>Date</th>
<th>Customer</th>
<th>Employee</th>
<th align="right">Gross</th>
<th align="right">Amount</th>
<th>User ID</th>
<th>Action</th>
</tr>
<cfloop query="getinvlist">
<tr <cfif numberformat(getinvlist.custtotal,'.__') eq 0> style="background-color:##FF0"</cfif>>
<td>#getinvlist.currentrow#</td>
<td>#getinvlist.refno#</td>
<td>#dateformat(getinvlist.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getinvlist.custname#</td>
<td>#getinvlist.empno# - #getinvlist.empname#</td>
<td align="right">#numberformat(getinvlist.custtotalgross,'.__')#</td>
<td align="right">#numberformat(getinvlist.custtotal,'.__')#</td>
<td>#getinvlist.created_by#</td>
<td>
<input type="checkbox" name="checklist" id="checklist" value="#getinvlist.refno#">
</td>
</tr>
</cfloop>
<tr>
<th colspan="100%">
<div align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Pick Invoice">
</div>
</th>
</tr>
</table>
</cfform>


<cfelseif form.combinationtype eq "me">

<cfquery name="getinvlist" datasource="#dts#">
select refno,assignmentslipdate,custno,custname,custtotal,custtotalgross,created_by,empno,empname from assignmentslip where left(refno,1) = "s" and combine <> "Y" and custno = "#form.custno#"
ORDER BY refno,assignmentslipdate
</cfquery>


<cfform name="invlist" id="invlist" method="post" action="manualentry.cfm">
<input type="hidden" name="combinationtype" id="combinationtype" value="#form.combinationtype#">
<input type="hidden" name="invoicedate" id="invoicedate" value="#form.invoicedate#">
<input type="hidden" name="assignmenttype" id="assignmenttype" value="#form.assignmenttype#">
<input type="hidden" name="custno" id="custno" value="#form.custno#">
<table align="center">
<tr>
<th align="center" colspan="100%">Choose Invoice To Combine</th>
</tr>
<tr >
<th>No</th>
<th>Refno</th>
<th>Date</th>
<th>Customer</th>
<th>Employee</th>
<th align="right">Gross</th>
<th align="right">Amount</th>
<th>User ID</th>
<th>Action</th>
</tr>
<cfloop query="getinvlist">
<tr <cfif numberformat(getinvlist.custtotal,'.__') eq 0> style="background-color:##FF0"</cfif>>
<td>#getinvlist.currentrow#</td>
<td>#getinvlist.refno#</td>
<td>#dateformat(getinvlist.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getinvlist.custname#</td>
<td>#getinvlist.empno# - #getinvlist.empname#</td>
<td align="right">#numberformat(getinvlist.custtotalgross,'.__')#</td>
<td align="right">#numberformat(getinvlist.custtotal,'.__')#</td>
<td>#getinvlist.created_by#</td>
<td>
<input type="checkbox" name="checklist" id="checklist" value="#getinvlist.refno#">
</td>
</tr>
</cfloop>
<tr>
<th colspan="100%">
<div align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Pick Invoice">
</div>
</th>
</tr>
</table>
</cfform>

</cfif>
</cfoutput>
</cfif>