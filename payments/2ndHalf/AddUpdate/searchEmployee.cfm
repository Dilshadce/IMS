<cfset dts=replace(dts,'_i','_p','all')>

<cfquery name="userpin_qry" datasource="#dts#">
		SELECT pin from userpin where usergroup = "#getHQstatus.userGrpID#"
	</cfquery>
	<cfset Hpin = userpin_qry.pin >
	<cfif getHQstatus.userGrpID eq "super">
		<cfset Hpin = 0>
	</cfif>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">
<cfquery name="gsetup_qry" datasource="payroll_main">
		SELECT ccode from gsetup where comp_id = '#HcomID#'
	</cfquery>
	<cfset HuserCcode = gsetup_qry.ccode>

<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
<table>
<tr>
<td>Empno / Keyword</td>
<td><input type="text" name="search" id="search"/></td>
</tr>
<tr>
<td></td>
<td><input type="submit" name="GO" value="GO" onclick="ajaxFunction(document.getElementById('ajaxField2'),'searchEmployeeAjax.cfm?keyword='+document.getElementById('search').value );"/></td>
</tr>
</table>

<div id="ajaxField2" name="ajaxField2">
<cfquery name="searchKey" datasource="#dts#">
SELECT * FROM pmast WHERE paystatus = "A"  and confid >= #hpin# order by length(empno),empno
</cfquery>

<cfoutput>
<table>
<cfloop query="searchKey">
<tr>
<td>#searchKey.empno#</td>
<td>#searchKey.name#</td>
<td>#searchKey.nricn#</td>
<td><a href="normalPayEditForm.cfm?empno=#searchKey.empno#">SELECT</a></td>
</tr>
</cfloop>
</table>
</cfoutput>
</div>