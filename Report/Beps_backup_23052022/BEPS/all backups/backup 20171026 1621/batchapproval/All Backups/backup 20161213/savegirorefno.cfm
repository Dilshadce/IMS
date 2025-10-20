<cfif isdefined('url.id')>
<cfsetting showdebugoutput="no">
<cfoutput>

<cfset girono = URLDECODE(url.girorefno)>

<cfquery name="getbatchno" datasource="#dts#">
SELECT batchno FROM argiro WHERE id = "#url.id#"
</cfquery>

<cfquery name="updategirorefno" datasource="#dts#">
UPDATE argiro SET girorefno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#girono#"> WHERE id = "#url.id#"
</cfquery>

<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignmentslip SET 
girono = <cfqueryparam cfsqltype="cf_sql_varchar" value="#girono#"> 
WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
</cfquery>

<cfquery name="getemployee" datasource="#dts#">
SELECT empno,paydate FROM assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
</cfquery>

<cfset dts2 = replace(dts,'_i','_p')>

<cfloop query="getemployee">
<cfquery name="updatecheqno" datasource="#dts2#">
UPDATE #getemployee.paydate# SET cheque_no = <cfqueryparam cfsqltype="cf_sql_varchar" value="#girono#">,cheqno_updated_on = now(),cheqno_updated_by = "#getauthuser()#" WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getemployee.empno#">
</cfquery>
</cfloop>
Giro Number Saved -#girono#
</cfoutput>
</cfif>