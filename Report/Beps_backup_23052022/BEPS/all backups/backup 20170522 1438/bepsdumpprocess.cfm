<cfinclude template="/object/dateobject.cfm">
<cfquery name="getassignmentslipall" datasource="#dts#">
SELECT * FROM assignmentslip WHERE assignmentslipdate between "#dateformatnew(form.datefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.dateto,'yyyy-mm-dd')#"
</cfquery>
<cfdump var="#getassignmentslipall#">