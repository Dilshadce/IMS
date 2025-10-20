
<cfoutput>
<cfset datestart = createdate(listlast(form.datefrom,'/'),listgetat(form.datefrom,'2','/'),listfirst(form.datefrom,'/'))>
  <cfset dateend = createdate(listlast(form.dateto,'/'),listgetat(form.dateto,'2','/'),listfirst(form.dateto,'/'))>
  
<cfquery name="getclaimlist" datasource="#dts#">
	SELECT wos_group,desp FROM icgroup ORDER BY wos_group
</cfquery>

<cfquery name="getassign" datasource="#dts#">
SELECT * FROM assignmentslip
WHERE 1=1
and assignmentslipdate BETWEEN "#dateformat(datestart,'yyyy-mm-dd')#" and "#dateformat(dateend,'yyyy-mm-dd')#"
<cfif form.comfrm neq "" and form.comto neq "">
and custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comfrm#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
and empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
<cfif form.placementfrom neq "" and form.placementto neq "">
and Placementno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementto#">
</cfif>
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
ORDER BY empno,placementno,assignmentslipdate
</cfquery>


<cfloop query="getassign">
<cfset dsname = replace(dts,'_i','_p')>
<cfquery name="gettimesheet" datasource="#dsname#">
    SELECT * FROM timesheet WHERE empno = "#getassign.empno#" and tmonth = "#month(getassign.assignmentslipdate)#" ORDER BY tsrowcount
    </cfquery>
<cfif gettimesheet.recordcount neq 0>
<cfset url.empno=getassign.empno>
<cfset url.placementno=getassign.placementno>
<cfset url.yearval=year(getassign.assignmentslipdate)>
<cfset url.monthval=month(getassign.assignmentslipdate)>

<cfinclude template="/default/transaction/assignmentslipnewnew/timesheet.cfm">
<p style="page-break-after:always">
</cfif>
</cfloop>

</cfoutput>
