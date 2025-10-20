<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Generate Tip / Rate Amount</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
    <script type="text/javascript">
    function countrate()
	{
	var tcr = document.getElementById("total_claimable_rate").value;
	var amt = document.getElementById("tip_amount").value;
	var tiprate = amt / tcr;
	tiprate = Math.round(tiprate * 100)/100;
	document.getElementById("tip_rate").value=tiprate;
	}
	
    </script>
	
<body>
	<cfquery name="get_formula_qry" datasource="#dts_main#">
	SELECT * FROM gsetup
	</cfquery>
    <cfset tip_formula=get_formula_qry.tc_cpratio>
    
    <cfset tip_emp_list = ArrayNew(1)>
    <cfset tip_emp_Wday = ArrayNew(1)>
    <cfset tip_emp_dw = ArrayNew(1)>
    <cfset tip_amt = ArrayNew(1)>
	<cfset tip_emp_amt = ArrayNew(1)>
    <cfset total_claimable_tip = 0>
    <cfquery name="num_emp_tip" datasource="#dts#">
    SELECT * FROM paytra1 Where tippoint > 0
    </cfquery>
    
    <cfset num_tip_count=num_emp_tip.recordcount>
    <cfloop query="num_emp_tip">
    <cfset ArrayAppend(tip_emp_list, num_emp_tip.empno)>
    <cfset ArrayAppend(tip_emp_wday, num_emp_tip.wday)>
    <cfset ArrayAppend(tip_emp_dw, num_emp_tip.dw)>
    <cfset ArrayAppend(tip_amt, num_emp_tip.tippoint)>
    </cfloop>
    
    <cfloop from="1" to="#num_tip_count#" index="i">
    <cfset WDAY = #val(tip_emp_wday[#i#])#>
    <cfset DW = #val(tip_emp_dw[#i#])#>
 	<cfset new_tip_formula=#Replace(tip_formula,"="," is ")#>
    <cfset claimable_ratio = #evaluate(#new_tip_formula#)#>
    <cfset claimable_amount = #val(tip_amt[#i#])# * claimable_ratio >
    <cfset ArrayAppend(tip_emp_amt, claimable_amount)>
    <cfset total_claimable_tip=total_claimable_tip + tip_emp_amt[#i#]>
    </cfloop>
    
    <cfquery name="sum_tip" datasource="#dts#">
    SELECT SUM(tippoint) AS TipTotal FROM paytra1
    </cfquery>
    <cfset total_tip=sum_tip.TipTotal>
<cfoutput>
<cfif url.type eq "update">
<cftry>
<cfloop from="1" to="#num_tip_count#" index="j">
<cfset tip_emp_amt_temp = tip_emp_amt[#j#]>
<cfset tip_emp_list_temp = tip_emp_list[#j#]>
<cfquery name="update_tip_amount" datasource="#dts#">
UPDATE paytra1 SET CLTIPOINT=#evaluate(tip_emp_amt_temp)# , TIPRATE = #form.tip_rate# WHERE empno = #evaluate(tip_emp_list_temp)#
</cfquery>
<cfset tip_amt = #evaluate(tip_emp_amt_temp)# * #val(form.tip_rate)# >
<cfquery name="update_tip" datasource="#dts#">
UPDATE paytra1 SET TIPAMT=#val(tip_amt)# , AW112 = #val(tip_amt)# WHERE empno = #evaluate(tip_emp_list_temp)#
</cfquery>
</cfloop>
<cfset status_msg="Success Generate Tip/Rate Amount">
<cfcatch type="database">
<cfset status_msg="Fail To Generate Tip/Rate Amount. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>
</cfif>
</cfoutput>    
<cfoutput>
<div class="mainTitle">Generate Tip / Rate Amount</div>
<font color="red" size="2.5"><cfif isdefined("status_msg")><cfoutput>#status_msg#</cfoutput></cfif></font>
<form name="tForm" action="generateMain.cfm?type=update" method="post">
<div class="tabber">
<table>
	<tr>
		<th colspan="2">Formula For Claimable Point</th>
	</tr>
	<tr>
		<td colspan="2"><input type="text" name="" value="#tip_formula#" size="62" readonly="yes" /></td>
	</tr>
	<tr><td colspan="2">&nbsp</td></tr>
	<tr>
		<th>No. Of Employee With Point</th>
		<td><input type="text" name="" value="#num_tip_count#" size="22" readonly="yes"></td>
	</tr>
	<tr>
		<th>Total No. Of Point</th>
		<td><input type="text" name="" value="#total_tip#" size="22" readonly="yes"></td>
	</tr>
	<tr>
		<th>Total No. Claimable Point</th>
		<td><input type="text" name="" value="#numberformat(total_claimable_tip,'._____')#" id="total_claimable_rate" size="22"></td>
	</tr>
	<tr><td colspan="2">&nbsp</td></tr>
	<tr>
		<th>Enter Tip Amount</th>
		<td><input type="text" name="tip_amount" id="tip_amount" value="#numberformat(0,'.__')#" size="22" onblur="javascript:countrate()"></td>
	</tr>
	<tr><td colspan="2">&nbsp</td></tr>
	<tr>
		<th>Tip Rate</th>
		<td><input type="text" name="tip_rate" id="tip_rate" value="#numberformat(0,'.__')#" size="22" readonly="yes"></td>
	</tr>
</table>

	<center>
		<input type="Submit" name="ok" value="OK" >
		<input type="button" name="cancel" value="Cancel" onclick="window.location.href='tnpList.cfm';">
	</center>
</div>
 </form>

</cfoutput>

</body>
</html>