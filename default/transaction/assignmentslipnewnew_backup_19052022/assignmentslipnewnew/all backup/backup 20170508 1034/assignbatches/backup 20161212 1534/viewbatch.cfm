
<cfif isdefined('url.batchno')>
<cfquery name="getbatches" datasource="#dts#">
SELECT * FROM assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.batchno#"> ORDER BY refno
</cfquery>
<cfoutput>
<div id="ajaxfield">
<table>
<tr>
<th>No.</th>
<th>Ref No.</th>
<th>Customer</th>
<th>Emp No.</th>
<th>Name</th>
<th>Action</th>
</tr>
<cfloop query="getbatches">
<tr>
<td>#getbatches.currentrow#</td>
<td>#getbatches.refno#</td>
<td>#getbatches.custname#</td>
<td>#getbatches.empno#</td>
<td>#getbatches.empname#</td>
<td><cfif getbatches.locked neq "Y"><u><a style="cursor:pointer" onclick="confirmdebatch('delete','#getbatches.refno#','#url.batchno#')" >Debatch</a></u></cfif></td>
</tr>
</cfloop>
</table>
</div>
<cfform name="updatepaydate" id="updatepaydate" method="post" action="/default/transaction/assignmentslipnewnew/assignbatches/updategirodate.cfm">
<input type="hidden" name="girobatch" id="girobatch" value="#url.batchno#" />
<table>
<tr>
<th colspan="100%">Update GIRO Credit Date</th>
</tr>
<tr>
<th>
GIRO Credit Date
</th>
<td><cfinput type="text" name="giropaydate" id="giropaydate" required="yes" message="Giro Pay Date is Required" maxlength="45" value="#dateformat(getbatches.giropaydate,'dd/mm/yyyy')#">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('giropaydate'));"></td>
</tr>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn1" id="sub_btn1" value="UPDATE" />
</td>
</tr>
</table>
</cfform>

<cfif getbatches.locked neq "Y">
<cfform name="lockb" id="lockb" method="post" action="/default/transaction/assignmentslipnewnew/assignbatches/lockbatches.cfm">
<input type="hidden" name="hidbatch" id="hidbatch" value="#url.batchno#" />
<table>
<tr>
<th colspan="100%">Lock Batches</th>
</tr>
<tr>
<th>
GIRO REFNO
</th>
<td><cfinput type="text" name="girorefno" id="girorefno" required="yes" message="Giro Refno is Required" maxlength="45"> </td>
</tr>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="LOCK" />
</td>
</tr>
</table>
</cfform>
<cfelse>
<h1>This bactch has been locked on #dateformat(getbatches.locked_on,'dd/mm/yyyy')# #timeformat(getbatches.locked_on,'hh:mm:ss')# <br />
with GIRO refno of #getbatches.girono#</h1>
</cfif>
</cfoutput>
</cfif>