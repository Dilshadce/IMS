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

<cfquery name="gs_qry" datasource="#dts_main#">
SELECT *
FROM gsetup
WHERE comp_id = "#HcomID#"
</cfquery>

<cfset keyword = url.keyword >

<cfquery name="searchKey" datasource="#dts#">
SELECT * FROM pmast WHERE paystatus = "A" and empno LIKE "%#keyword#%" or name LIKE "%#keyword#%" 
and confid >= #hpin# <cfif gs_qry.t1 eq 0>
        <cfif gs_qry.bp_payment eq "2">
        and (nppm = "2" or nppm = "0") 
		<cfelse>
        and nppm = "2"
		</cfif>
		</cfif>
order by length(empno), empno
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
