<cfoutput>
<cfquery name="ab" datasource="#dts#">
select CPRICE from taftc_i.PROJECT 
</cfquery>

<cfdump var="#ab#">


<cfquery name="ab" datasource="#dts#">
select CPRICE from taftc_a.PROJECT 
</cfquery>

<cfdump var="#ab#">


</cfoutput>
<!---   <cfquery name="ab" datasource="#dts#">
SELECT * FROM intune_ava
</cfquery> 

<cfloop query="ab">
<cfquery name="abc" datasource="#dts#">
update taftc_a.project set wsq = '#wsq#' where PORJ ='P' and source = '#source#'
</cfquery>
</cfloop>

<cfdump var="#ab#">
  <cfquery name="ab" datasource="#dts#">
SELECT * FROM intune_crsDay
</cfquery> 

<cfdump var="#ab#">
  <cfquery name="ab" datasource="#dts#">
SELECT * FROM intune_crs
</cfquery> 

<cfdump var="#ab#">
  <cfquery name="ab" datasource="#dts#">
SELECT * FROM intune_assign
</cfquery> 

<cfdump var="#ab#">

 --->