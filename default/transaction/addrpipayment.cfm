
<cfif mode eq "add">
<cfquery name="insertrpipayment" datasource="#dts#">
	select ifnull(max(paymentcount),0) as paymentcount from rpipayment 
    where refno="#url.refno#" and type="#url.type#"
</cfquery>

<cfquery name="insertrpipayment" datasource="#dts#">
	insert into rpipayment 
(type,refno,paymentcount,paidamount,paidby,remark,created_by,created_on) values
('#url.type#','#url.refno#','#insertrpipayment.paymentcount+1#','#val(url.amount)#','#url.paidby#','#url.remark#','#huserid#',now())
</cfquery>

<cfelse>

<cfquery name="updaterpipayment" datasource="#dts#">
	update rpipayment set
    <cfif url.changefield eq "paidamount">
    paidamount="#val(url.changefigure)#",
    <cfelseif url.changefield eq "paidby">
    paidby="#url.changefigure#",
    <cfelse>
    remark="#url.changefigure#",
    </cfif>
    updated_on=now(),
    updated_by="#huserid#"
    
    where paymentcount="#url.paymentcount#" and
    refno="#url.refno#" and type="#url.type#"
</cfquery>


</cfif>


<cfquery name="getallrpipayment" datasource="#dts#">
	select * from rpipayment where refno="#url.refno#" and type="#url.type#"
</cfquery>

<cfquery name="getsumrpipayment" datasource="#dts#">
	select sum(paidamount) as sumamt from rpipayment where refno='#url.refno#' and type="#url.type#"
</cfquery>

<cfoutput>

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
<td align="right">
<cfif getpin2.h9300 eq 'T'><input type="text" name="rpipaidamount2" id="rpipaidamount2" value="#numberformat(getallrpipayment.paidamount,',.__')#" onchange="if(confirm('Confirm Change Payment Amount?')){ajaxFunction1(document.getElementById('rpipaylistAjaxField'),'addrpipayment.cfm?mode=edit&paymentcount=#getallrpipayment.paymentcount#&changefield=paidamount&changefigure='+this.value+'&type=#url.type#&refno=#url.refno#')}" ><cfelse>#numberformat(getallrpipayment.paidamount,',.__')#</cfif>
</td>
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
</cfif>
</td>
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


</cfoutput>
