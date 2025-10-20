<cfquery name="getGSetup" datasource="#dts#">
  	select * from gsetup 
</cfquery>

<cfquery name="MyQuery" datasource="#dts#">
select a.*,b.* from repairtran a,repairdet b where a.repairno=b.repairno and a.repairno='#url.repairno#'
</cfquery>

<cfquery name="getcustinfo" datasource="#dts#">
SELECT * FROM #target_arcust# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#MyQuery.custno#">
</cfquery>

<cfreport template="RepairService.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="name" value="#getcustinfo.name#">
    <cfreportparam name="add1" value="#getcustinfo.add1#">
    <cfreportparam name="add2" value="#getcustinfo.add2#">
    <cfreportparam name="add3" value="#getcustinfo.add3#">
    <cfreportparam name="add4" value="#getcustinfo.add4#">
    <cfreportparam name="gstno" value="#getGSetup.gstno#">
    
</cfreport>