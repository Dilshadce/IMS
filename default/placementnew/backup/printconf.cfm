<cfinclude template="/object/dateobject.cfm">
<cfquery name="getdetail" datasource="#dts#">
select empname,empno FROM placement WHERE placementno='#url.placementno#'
</cfquery>

<cfquery name="getGSetup" datasource="#dts#">
  	select compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno from gsetup 
</cfquery>

<cfreport template="conf.cfr" format="PDF" query="getdetail"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="date" value="#dateformatnew(url.date,'dd-mm-yyyy')#">

</cfreport>