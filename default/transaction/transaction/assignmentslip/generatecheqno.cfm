<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<title>Print Claim Cheque</title>
</head>
<body>
<cfoutput>
	<h4>
		<a href="Assignmentsliptable2.cfm?type=Create">Creating a Assignment Slip</a> 
		|| <a href="Assignmentsliptable.cfm?">List all Assignment Slip</a> 
		|| <a href="s_Assignmentsliptable.cfm?type=Assignmentslip">Search For Assignment Slip</a>
        || <a href="printcheque.cfm">Print Claim Cheque</a>
         || <a href="printclaim.cfm">Print Claim Voucher</a>
          || <a href="generatecheqno.cfm">Record Claim Cheque No</a>
          || <a href="definecheqno.cfm">Predefined Cheque No</a>
	</h4>
</cfoutput>
<cfoutput>
<h1>Record Claim Cheque No</h1>
<cfform name="assignment1" id="assignment1" action="generatecheqnoprocess.cfm" method="post">
<cfquery name="getlist" datasource="#dts#">
SELECT "" as refno, "Choose an Assignment With Claim" as desp
UNION ALL
select refno,concat(refno,' - ',empno) as desp from assignmentslip where (
claimadd1 = "Y"
or claimadd2 = "Y"
or claimadd3 = "Y"
or claimadd4 = "Y"
or claimadd5 = "Y"
or claimadd6 = "Y")
and (coalesce(addchargeself,0)+coalesce(addchargeself2,0)+coalesce(addchargeself3,0)+coalesce(addchargeself4,0)+coalesce(addchargeself5,0)+coalesce(addchargeself6,0) > 0)
order by refno
</cfquery>
<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
<tr>
<th>Assignment From</th>
<td>
<cfselect name="assignmentfrom" id="assignmentfrom" query="getlist" value="refno" display="desp"></cfselect>
</td>
</tr>
<tr>
<th>Assignment To</th>
<td><cfselect name="assignmentto" id="assignmentto" query="getlist" value="refno" display="desp"></cfselect></td>
</tr>
<tr>
<td colspan="2"><hr/></td>
</tr>
<cfquery name="getperiod" datasource="#dts#">
SELECT lastaccyear FROM gsetup
</cfquery>
<cfset lastdate = getperiod.lastaccyear>
<tr>
<th>Period From</th>
<td>
<cfselect name="periodfrom" id="periodfrom">
<option value="">Choose a Period</option>
<cfloop from="1" to="18" index="i">
<option value="#val(i)#">#numberformat(i,'00')# - #dateformat(dateadd('m',i,lastdate),'mmm yy')#</option>
</cfloop>
</cfselect>
</td>
</tr>
<tr>
<th>Period To</th>
<td>
<cfselect name="periodto" id="periodto">
<option value="">Choose a Period</option>
<cfloop from="1" to="18" index="i">
<option value="#numberformat(i,'00')#">#numberformat(i,'00')# - #dateformat(dateadd('m',i,lastdate),'mmm yy')#</option>
</cfloop>
</cfselect>
</td>
</tr>
<tr>
<td colspan="2"><hr/></td>
</tr>
<tr>
<th>Date From</th>
<td>
<input type="text" name="datefrom" id="datefrom" value="" />&nbsp;&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));">
</td>
</tr>
<tr>
<th>Date To</th>
<td>
<input type="text" name="dateto" id="dateto" value="" />&nbsp;&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));">
</td>
</tr>
<tr>
<td colspan="2"><hr/></td>
</tr>
<tr>
<th>Empty Cheque No Only</th>
<td>
<input type="checkbox" name="emptycheqno" id="emptycheqno" value="" checked="checked" />
</td>
</tr>
<tr>
<td colspan="2" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Proceed" />
</td>
</tr>
</table>
</cfform>
</cfoutput>
</body>
</html>