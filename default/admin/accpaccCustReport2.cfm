<!--- The below format are used after e-invoice --->
<cfoutput>
<cfset uuid = createuuid()>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>
<cfset temp_filename = "#HRootPath#\Excel_Report\MPpostingCust_#timenow#_#uuid#.csv">

<!--- <cfsetting showdebugoutput="yes"> --->

    <cfquery name="getCustno" datasource="#dts#">
        SELECT custno, add1, add2, add3, add4, country, postalcode, agent, phone, term, arrem1, arrem6, created_on, updated_on, name, currency, e_mail, comuen, attn<!---custno, startdate, custname, placementno--->
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

    <cffile action="WRITE" file="#temp_filename#"
    	output="RECTYPE,IDCUST,DATESTART,IDGRP,NAMECUST,TEXTSTRE1,TEXTSTRE2,TEXTSTRE3,TEXTSTRE4,NAMECITY,CODESTTE,CODEPSTL,CODECTRY,NAMECTAC,TEXTPHON1,TEXTPHON2,IDACCTSET,IDBILLCYCL,IDSVCCHRG,CODETERM,CODETAXGRP,BRN" 
        addnewline="yes">


	<cffile action="APPEND" file="#temp_filename#" 
   		output="RECTYPE,IDCUST,OPTFIELD,VALUE"
  		addnewline="Yes">
        
	<cfloop query="getCustno">
    
        <cffile action="APPEND" file="#temp_filename#" 
            output="1,#getCustno.custno#,#lsdateformat(getCustno.updated_on,'yyyymmdd', 'English (Australian)')#,NCA,#getCustno.name#,""#getCustno.add1#"",""#getCustno.add2#"",,,""#getCustno.add3#"",""#getCustno.add4#"",""#getCustno.postalcode#"",""#getCustno.country#"",""#getCustno.attn#"",""#getCustno.phone#"",,Trade,Mthly,INT,""#getCustno.arrem6#"",GST,""#getCustno.comuen#"""
            addnewline="Yes">
                
        <cffile action="APPEND" file="#temp_filename#" 
            output="2,#getCustno.custno#,BRANCHCODE,#getCustno.arrem1#"
            addnewline="Yes">
    
    </cfloop>  

    <!--- <cfabort> --->

	<!---end of write csv file--->

	<!---<cfheader name="Content-Type" value="csv">--->
	<cfset filename = "MPpostingCust_#timenow#.csv">

	<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#temp_filename#">
        
</cfoutput>



