


<cfif isdefined('url.jobdate')>
<cfset currentdate = createdate(right(url.jobdate,4),mid(url.jobdate,4,2),left(url.jobdate,2))>
<cfset currentassignment = url.assignmentno>
<cfset currentplacement = url.placementno>
<cfset currentpaydate = url.paydate>
<cfset currentempno = url.empno>
<cfquery name="checkclash" datasource="#dts#">
SELECT refno FROM assignmentslip
WHERE
empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currentempno#">
<!--- and paydate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currentpaydate#">  --->
and emppaymenttype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currentassignment#">
and month(Assignmentslipdate) = "#dateformat(currentdate,'m')#"
and year(Assignmentslipdate) = "#dateformat(currentdate,'yyyy')#"
<cfif isdefined('url.newassignment') eq false>
and refno <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfif>
</cfquery>
<cfoutput>
<input type="hidden" id="checkclash" name="checkclash" value="<cfif checkclash.recordcount eq 0>0<cfelse>#checkclash.refno#</cfif>">
</cfoutput>
</cfif>