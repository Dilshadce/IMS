<cfquery name="getallassignment" datasource="#dts#">
SELECT refno,placementno FROM assignmentslip WHERE branch = ""
</cfquery>

<cfloop query="getallassignment">
<cfquery name="getposition" datasource="#dts#">
select position,invoicegroup,location,po_no,jobpostype from placement where placementno='#getallassignment.placementno#'
</cfquery>

     <cfquery name="getentity" datasource="#dts#">
	SELECT invnogroup FROM bo_jobtypeinv
	WHERE officecode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getposition.location#">
    AND jobtype = "#getposition.jobpostype#"
</cfquery>

<cfquery name="getaddress" datasource="#dts#">
	SELECT shortcode FROM invaddress
	WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getentity.invnogroup#">
</cfquery>

<cfquery name="updatebranch" datasource="#dts#">
UPDATE assignmentslip SET branch = "#getaddress.shortcode#"
WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallassignment.refno#">
</cfquery>

</cfloop>