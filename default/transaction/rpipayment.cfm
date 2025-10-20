<cfquery name="getallrpipayment" datasource="#dts#">
	select * from rpipayment where refno="#url.refno#" and type="#url.type#"
</cfquery>

<cfquery name="getsumrpipayment" datasource="#dts#">
	select sum(paidamount) as sumamt from rpipayment where refno="#url.refno#" and type="#url.type#"
</cfquery>

<cfoutput>
<h2>Add Payment</h2>
<table width="400">
<tr>
<td>Payment Amount</td>
<td><input type="text" name="rpipaidamount" id="rpipaidamount" value="0"></td>
<td></td>

</tr>
<tr>
<td>Paid By</td>
<td>
<select name="rpipaidby" id="rpipaidby">
      <option value="cash">Cash</option>
      <option value="crcd">Credit Card</option>
      <option value="dbcd">Debit Card / Nets</option>
      <option value="voucher">Voucher</option>
      <option value="cheque">Cheque</option>
</select>
</td>
<td></td>

</tr>

<tr>
<td>Remark</td>
<td>
<input type="text" name="rpiremark" id="rpiremark" value="" maxlength="100" />
</td>
<td></td>

</tr>
<tr>
<td colspan="100%" align="center"><input type="button" name="addrpipaybtn" id="addrpipaybtn" value="Add" onClick="if(!isNaN(parseFloat(document.getElementById('rpipaidamount').value))){ajaxFunction1(document.getElementById('rpipaylistAjaxField'),'addrpipayment.cfm?mode=add&amount='+document.getElementById('rpipaidamount').value+'&paidby='+document.getElementById('rpipaidby').value+'&remark='+document.getElementById('rpiremark').value+'&type=#url.type#&refno=#url.refno#')}else{alert('Please Key In Number Only')}"></td>

</tr>
</table>

<div id="rpipaylistAjaxField">
<h2>Payment List</h2>
<table width="600">
<tr>
<td>No.</td>
<td align="right">Paid Amount</td>
<td>Paid By</td>
<td>Remark</td>
<td>Created By</td>
<td>Created On</td>
</tr>
<cfloop query="getallrpipayment">
<tr>
<td>#getallrpipayment.paymentcount#</td>
<td align="right"><cfif getpin2.h9300 eq 'T'><input type="text" name="rpipaidamount2" id="rpipaidamount2" value="#numberformat(getallrpipayment.paidamount,',.__')#" onchange="if(confirm('Confirm Change Payment Amount?')){ajaxFunction1(document.getElementById('rpipaylistAjaxField'),'addrpipayment.cfm?mode=edit&paymentcount=#getallrpipayment.paymentcount#&changefield=paidamount&changefigure='+this.value+'&type=#url.type#&refno=#url.refno#')}" ><cfelse>#numberformat(getallrpipayment.paidamount,',.__')#</cfif></td>
<td>
<cfif getpin2.h9300 eq 'T'>
<select name="rpipaidby2" id="rpipaidby2" onchange="if(confirm('Confirm Change Payment Amount?')){ajaxFunction1(document.getElementById('rpipaylistAjaxField'),'addrpipayment.cfm?mode=edit&paymentcount=#getallrpipayment.paymentcount#&changefield=paidby&changefigure='+this.value+'&type=#url.type#&refno=#url.refno#')}">
      <option value="cash" <cfif getallrpipayment.paidby eq "cash">selected</cfif>>Cash</option>
      <option value="crcd" <cfif getallrpipayment.paidby eq "crcd">selected</cfif>>Credit Card</option>
      <option value="dbcd" <cfif getallrpipayment.paidby eq "dbcd">selected</cfif>>Debit Card / Nets</option>
      <option value="voucher" <cfif getallrpipayment.paidby eq "voucher">selected</cfif>>Voucher</option>
      <option value="cheque" <cfif getallrpipayment.paidby eq "cheque">selected</cfif>>Cheque</option>
</select>
<cfelse>
#getallrpipayment.paidby#
</cfif></td>
<td>
<cfif getpin2.h9300 eq 'T'>
<input type="text" name="rpiremark2" id="rpiremark2" value="#getallrpipayment.remark#" maxlength="100" onblur="if(confirm('Confirm Change Remark?')){ajaxFunction1(document.getElementById('rpipaylistAjaxField'),'addrpipayment.cfm?mode=edit&paymentcount=#getallrpipayment.paymentcount#&changefield=remark&changefigure='+this.value+'&type=#url.type#&refno=#url.refno#')}" />
<cfelse>
#getallrpipayment.remark#
</cfif>
</td>
<td>#getallrpipayment.created_by#</td>
<td>#dateformat(getallrpipayment.created_on,'dd/mm/yyyy')#</td>
</tr>
</cfloop>


</table>
<br>
<h2 align="center"><input type="button" name="rpiclosebtn" id="rpiclosebtn" value="Close" onclick="document.getElementById('deposit').value='#getsumrpipayment.sumamt#';getDepositCount();ColdFusion.Window.hide('rpipaymentwindow');"></h2>

</div>


</cfoutput>