<cfoutput>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

<cfsetting showdebugoutput="yes">

    <cfquery name="getCustno" datasource="#dts#">
        SELECT custno, add1, add2, add3, add4, country, postalcode, agent, phone, term, arrem1, arrem6, created_on, name<!---custno, startdate, custname, placementno--->
        FROM arcust 
        WHERE 1=1
        <cfif #form.customerFrom# neq "" AND #form.customerTo# neq "">
			AND custno
			BETWEEN "#form.customerFrom#"
			AND
			"#form.customerTo#"
		 <cfelseif #form.customerFrom# neq "">
			AND custno = "#form.customerFrom#"
		 <cfelseif #form.customerTo# neq "">
			AND custno = "#form.customerTo#"
		</cfif>
    </cfquery>

    <!---Begin to write csv file--->
    
    <cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv"
    	output="RECTYPE,IDCUST,DATESTART,NAMECUST,TEXTSTRE1,TEXTSTRE2,TEXTSTRE3,TEXTSTRE4,NAMECITY,CODEPSTL,CODECTRY,NAMECTAC,TEXTPHON1,TEXTPHON2,IDACCTSET,IDBILLCYCL,IDSVCCHRG,CODETERM,IDGRP,CODETAXGRP" 
        addnewline="yes">

	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv" 
   		output="RECTYPE,IDCUST,OPTFIELD,VALUE"
  		addnewline="Yes">
        
	<cfloop query="getCustno">
    
    	<!---query need to be loop to get correct data--->
    	<!---<cfquery name="getCustno" datasource="#dts#">
            SELECT custno, add1, add2, add3, add4, country, postalcode, agent, phone, term, arrem1, arrem6
            FROM arcust
            WHERE custno = #getCustno.custno#
    	</cfquery>--->
        
      <!---  <cfquery name="getlocation" datasource="#dts#">
        	SELECT location
            FROM placement
            where custno = #getCustno.custno#
            AND placementno = #getCustno.placementno#
        </cfquery>--->
    	<!---end of query--->
    
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv" 
            output="1,#getCustno.custno#,#lsdateformat(getCustno.created_on,'yyyymmdd', 'English (Australian)')#,#getCustno.name#,""#getCustno.add1#"",""#getCustno.add2#"",""#getCustno.add3#"",""#getCustno.add4#"",,""#getCustno.postalcode#"",""#getCustno.country#"",""#getCustno.agent#"",""#getCustno.phone#"",,Trade,Mthly,INT,""#getCustno.arrem6#"",NCA,SST"
            addnewline="Yes">
                
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv" 
            output="2,#getCustno.custno#,BRANCHCODE,#getCustno.arrem1#"
            addnewline="Yes">
    
    </cfloop>  

	<!---end of write csv file--->

	<!---<cfheader name="Content-Type" value="csv">--->
	<cfset filename = "MPpostingCust_#timenow#.csv">

	<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingCust_#timenow#.csv">
        
</cfoutput>



