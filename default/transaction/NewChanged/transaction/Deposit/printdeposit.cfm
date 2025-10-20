<cfquery name="getGSetup" datasource="#dts#">
  	select compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno,comuen from gsetup 
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>
    
 <cfquery name="MyQuery" datasource="#dts#">
 select * from deposit where depositno='#url.depositno#'
</cfquery>

 <cfquery name="getcustdetail" datasource="#dts#">
 select * from #target_arcust# where custno='#MyQuery.custno#'
</cfquery>

<cfif lcase(hcomid) eq "ltm_i">
<cfreport template="ltmprintdeposit.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="gstno" value="#getGSetup.gstno#">
    <cfreportparam name="comuen" value="#getGSetup.comuen#">
    <cfreportparam name="dts" value="#dts#">
	<cfreportparam name="name" value="#getcustdetail.name#">
	<cfreportparam name="name2" value="#getcustdetail.name2#">
	<cfreportparam name="add1" value="#MyQuery.add1#">
	<cfreportparam name="add2" value="#MyQuery.add2#">
	<cfreportparam name="add3" value="#MyQuery.add3#">
	<cfreportparam name="add4" value="#MyQuery.add4#">
    
</cfreport>

<cfelse>

<cfreport template="printdeposit.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="dts" value="#dts#">
    
</cfreport>
</cfif>