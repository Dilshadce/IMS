<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">

	<cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
    <cfset completedate = dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>
<cfform name="bi" id="bi" action="claimreportprocess.cfm" method="post" target="_blank">
<table align="center">
<tr>
<th colspan="100%">
<div align="center">Reimbursement Listing</div>
</th>
</tr>
<tr>
<th>Date From</th>
<td><cfinput type="text" name="datefrom" id="datefrom" value="#startdate#" required="yes" validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));"></td>
</tr>
<tr>
<th>Date To</th>
<td><cfinput type="text" name="dateto" id="dateto" value="#completedate#" required="yes" validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));"></td>
</tr>
<tr>
<td colspan="100%"><div align="center"><input type="submit" name="sub_btn" id="sub_Btn" value="Submit"></div></td>
</tr>
</table>
</cfform>
</cfoutput>
