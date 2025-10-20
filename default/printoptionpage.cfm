<cfquery name="getgeneral" datasource="#dts#">
	select printoption from gsetup;
</cfquery>

<cfif getgeneral.printoption neq '1'>
	<cflocation url="general/issformat.cfm?tran=#tran#&nexttranno=#nexttranno#">
</cfif>

<html>
<head>
	<title>PRINT OPTION PAGE</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<table width="50%" border="0" cellspacing="0" cellpadding="0" align="center" class="data">
	<tr>
    	<th height="25">Customized</th>
    	<th>Default</th>
  	</tr>
  	<cfoutput>
  	<tr>
    	<td height="20">
        <cftry>
        	<cfquery name="getformat" datasource="#dts#">
				select * from customized_format
				where type='#tran#'
				order by counter
			</cfquery>
			<cfset thiscount=0>
			<cfset maxcount=getformat.recordcount>
			<cfloop query="getformat">
				<cfset thiscount=thiscount+1>
				<div align="center">
					<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillName=#getformat.file_name#&doption=#getformat.d_option#" target="_blank"><font size="2"><strong>#getformat.display_name#</strong></font></a>
					<cfif thiscount neq maxcount><br><br></cfif>
				</div>
			</cfloop>
        <cfcatch type="any">
            <cfswitch expression="#tran#"> <!--- TR,ISS --->
                <cfcase value="OAI,OAR" delimiters=",">
                    <div align="center">
                        <cfif lcase(hcomid) eq "imk_i">
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillType=MF"><font size="2"><strong>
                            Maintenance Format</strong></font></a>
                            <br>
                            <br>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillType=SF"><font size="2"><strong>
                            Sample Format</strong></font></a>
                            <br>
                            <br>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillType=RDF"><font size="2"><strong>
                            R & D Format</strong></font></a>
                            <br>
                            <br>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillType=LRF"><font size="2"><strong>
                            Loan/Return Format</strong></font></a>
                        </cfif>
                    </div>
                </cfcase> 
                <cfcase value="TR">
                    <div align="center">
                        <cfif lcase(hcomid) eq "ovas_i">
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong>Transfer Note</strong></font></a>
                        </cfif>
                    </div>
                </cfcase>  
            </cfswitch>
        </cfcatch>
        </cftry>
		</td>
    	<td><div align="center"><a href="general/issformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong>View</strong></font></a></div></td>
  	</tr>
</cfoutput>
</table>

</body>
</html>