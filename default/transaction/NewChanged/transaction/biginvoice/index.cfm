<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
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
<cfform name="bi" id="bi" method="post" action="chooseinvoice.cfm">
<table align="center">
<tr>
<th align="center" colspan="100%">Big Invoice Generation</th>
</tr>
<tr>
<th>Type of Combination</th>
<td>
<select name="combinationtype" id="combinationtype">
<option value="gasi">Group as single item</option>
<option value="mg">Group with multiple items</option>
<option value="gnsi">Group with item details</option>
<option value="me">Manual entry</option>
</select>
</td>
</tr>
<tr>
<th>Invoice Date</th>
<td>
<cfinput type="text" name="invoicedate" id="invoicedate" value="" required="yes" validateat="onsubmit" validate="eurodate" message="Invoice Date is Required/ Invalid">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('invoicedate'));">
</td>
</tr>
<tr>
<th>Invoice Type</th>
<td>
<select name="assignmenttype" id="assignmenttype">
        <option value="invoice" >Invoice</option>
        <option value="einvoice" >E-Invoice</option>
</select>
</td>
</tr>
<tr>
<th>Customer</th>
<td>
<cfquery name="getcust" datasource="#dts#">
select custno,custname from assignmentslip where assignmenttype = "sinvoice" and combine <> "Y" group by custno order BY custno
</cfquery>
<select name="custno" id="custno">
	<cfloop query="getcust">
	<option value="#getcust.custno#">#getcust.custno# - #getcust.custname#</option>
    </cfloop>
</select>&nbsp;
<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findcustomer');" />
</td>
</tr>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="GO">
</td>
</tr>
</table>
</cfform>
  <cfwindow center="true" width="650" height="500" name="findcustomer" refreshOnShow="true"
        title="Find Customer" initshow="false"
        source="findcustomer.cfm?type=target_arcust&fromto=" />
</cfoutput>