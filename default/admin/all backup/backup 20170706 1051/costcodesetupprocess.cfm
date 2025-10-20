<cfquery name="checkexist" datasource="#dts#">
SELECT companyid FROM costcodesetup
</cfquery>

<cfif checkexist.recordcount eq 0>
<cfquery name="insertcostcode" datasource="#dts#">
INSERT INTO costcodesetup (companyid<cfloop from="0" to="9" index="i">,costcode#i#</cfloop>,costcodedot)
values 
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="IMS">
<cfloop from="0" to="9" index="i">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.costcode#i#')#">
</cfloop>
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.costcodedot#">
)

</cfquery>
<cfelse>

<cfquery name="updatecostcode" datasource="#dts#">
UPDATE costcodesetup SET
companyid=<cfqueryparam cfsqltype="cf_sql_varchar" value="IMS">
<cfloop from="0" to="9" index="i">
,costcode#i#=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.costcode#i#')#">
</cfloop>
,costcodedot=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.costcodedot#">

</cfquery>

</cfif>

<script type="text/javascript">
alert("Cost code has been updated!")
ColdFusion.Window.hide('costcodesetup');
</script>