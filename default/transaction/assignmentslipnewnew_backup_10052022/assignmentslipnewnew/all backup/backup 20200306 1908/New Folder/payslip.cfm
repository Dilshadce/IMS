<cfquery name="getGSetup" datasource="#dts#">
  	select compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno from gsetup 
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>

<cfset dts2=replace(dts,'_i','','all')>
      <cfquery name="company_details" datasource="payroll_main">
        SELECT * FROM gsetup WHERE comp_id = "#dts2#"
      </cfquery>
      <cfset payrollperiod=company_details.mmonth>

    
<cfquery name="MyQuery" datasource="#dts#">
    SELECT a.*,b.nric FROM assignmentslip as a
    left join (select nric,empno from placement) as b on a.empno=b.empno
     where 0=0
<cfif form.empfrom neq '' and form.empto neq ''>
and a.empno between '#form.empfrom#' and '#form.empto#'
</cfif>
and a.payrollperiod='#payrollperiod#'
order by a.empno
</cfquery>


<cfset reportname = "payslip.cfr">


<cfreport template="#reportname#" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="dts" value="#dts#">
    <cfreportparam name="gstno" value="#getGSetup.gstno#">
    
</cfreport>