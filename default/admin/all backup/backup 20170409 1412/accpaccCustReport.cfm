<cfoutput>
<cfset uuid = createuuid()>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

<style type="text/css">
    @media print
    {
    	##non-printable { display: none; }

    }
    </style>

<cfsetting showdebugoutput="yes">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">

<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

    <cfquery name="getbatches" datasource="#dts#">
        SELECT custno, startdate, custname, placementno 
        FROM assignmentslip 
        WHERE 
        <cfif isdefined('form.batches')> 
        	batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
        </cfif>
    </cfquery>
          
    <cfquery name="getdata" datasource="#dts#">
        SELECT desp, amt_bil, brem5, refno
        FROM ictran 
        WHERE custno = #getbatches.custno# 
        AND itemno <> "NAME"
        ORDER by desp
    </cfquery>

    <!---Begin to write csv file--->
    
    <cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv"
    	output="RECTYPE,IDCUST,DATESTART,NAMECUST,TEXTSTRE1,TEXTSTRE2,TEXTSTRE3,TEXTSTRE4,NAMECITY,CODEPSTL,CODECTRY,NAMECTAC,TEXTPHON1,TEXTPHON2,IDACCTSET,IDBILLCYCL,IDSVCCHRG,CODETERM,IDGRP,CODETAXGRP" 
        addnewline="yes">

	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv" 
   		output="RECTYPE,IDCUST,OPTFIELD,VALUE"
  		addnewline="Yes">
        
	<cfloop query="getbatches">
    
    	<!---query need to be loop to get correct data--->
    	<cfquery name="getcustno" datasource="#dts#">
            SELECT custno, add1, add2, add3, add4, country, postalcode, agent, phone, term, arrem1, arrem6
            FROM arcust
            WHERE custno = #getbatches.custno#
    	</cfquery>
        
        <cfquery name="getlocation" datasource="#dts#">
        	SELECT location
            FROM placement
            where custno = #getbatches.custno#
            AND placementno = #getbatches.placementno#
        </cfquery>
    	<!---end of query--->
    
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv" 
            output="1,#getcustno.custno#,#dateformat(getbatches.startdate,'dd/mm/yyyy')#,#getbatches.custname#,""#getcustno.add1#"",""#getcustno.add2#"",""#getcustno.add3#"",""#getcustno.add4#"",,""#getcustno.postalcode#"",""#getcustno.country#"",""#getcustno.agent#"",""#getcustno.phone#"",,Trade,Mthly,INT,""#getcustno.arrem6#"",NCA,GST"
            addnewline="Yes">
                
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv" 
            output="2,#getcustno.custno#,BRANCHCODE,#getlocation.location#"
            addnewline="Yes">
    
    </cfloop>  

	<!---end of write csv file--->

	<!---<cfheader name="Content-Type" value="csv">--->
	<cfset filename = "MPpostingCust_#timenow#.csv">

	<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv">
        
</cfoutput>



