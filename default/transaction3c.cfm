<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfquery name="GetSetting" datasource="#dts#">
SELECT EDControl FROM gsetup 
</cfquery>
<cfquery name="checkPrinted" datasource="#dts#">
SELECT printed,custno FROM artran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#"> and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
</cfquery>

<cfif getSetting.EDControl eq "Y" and checkPrinted.printed eq "Y">
<cfajaximport tags="cfform">
<cfwindow center="true" width="350" height="300" name="exampass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/exampass/exampass.cfm?type=printing" />
<cfelse>
</cfif>
<html>
<head>
	<title>Transaction 3C</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfset cprint="">
<cfif tran eq 'RC' and getpin2.h2106 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'PR' and getpin2.h2205 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'DO' and getpin2.h2306 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'INV' and getpin2.h2405 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'CS' and getpin2.h2505 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'CN' and getpin2.h2605 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'DN' and getpin2.h2705 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'ISS' and getpin2.h2825 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'OAI' and getpin2.h2835 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'OAR' and getpin2.h2845 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'SAM' and getpin2.h2856 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'PO' and getpin2.h2867 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'QUO' and getpin2.h287A eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'SO' and getpin2.h2888 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'TR' and getpin2.h28A5 eq "T">
<cfset cprint="T">
</cfif>

<cfif cprint eq 'T'>
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
					<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillName=#getformat.file_name#&doption=#getformat.d_option#" target="_blank" <cfif getSetting.EDControl eq "Y"> onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif> ><font size="2"><strong>#getformat.display_name#</strong></font></a>
					<cfif thiscount neq maxcount><br><br></cfif>
				</div>
			</cfloop>
		<cfcatch type="any">
			<cfswitch expression="#tran#"> 
			  	<!--- MODIFIED ON 030608: ADD THE TARGET='_BLANK' FOR ALL THE LINK --->
	        	<cfcase value="INV"> 
	 	      		<div align="center">
					<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn08_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=NONTAX&country=&format=" target="_blank"><font size="2"><strong>
	              		US Open Purchase Invoice</strong></font></a>&nbsp;/&nbsp;
	              		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=NONTAX&country=&format=excel" target="_blank"><font size="2"><strong>
	              		Excel Format</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Country=USA&format=" target="_blank"><font size="2"><strong>
	              		US Port Service Invoice</strong></font></a>&nbsp;/&nbsp;
	              		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=USA&format=excel" target="_blank"><font size="2"><strong>
	              		Excel Format</strong></font></a>
						<br>
						<br>
	 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Country=FRENCH&format=" target="_blank"><font size="2"><strong>
	              		French Tax Invoice</strong></font></a>&nbsp;/&nbsp;
	              		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=FRENCH&format=excel" target="_blank"><font size="2"><strong>
	              		Excel Format</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Country=MISC&format=" target="_blank"><font size="2"><strong>
	              		Misc. Invoice</strong></font></a>&nbsp;/&nbsp;
	              		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=MISC&format=excel" target="_blank"><font size="2"><strong>
	              		Excel Format</strong></font></a>
					<cfelseif lcase(hcomid) eq "topsteel_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&location=AMK" target="_blank"><font size="2"><strong>
	              		Tax Invoice (AMK)</strong></font></a>
						<br>
						<br><!--- 
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&location=AMK2" target="_blank"><font size="2"><strong>
	              		Tax Invoice 2 (AMK)</strong></font></a>
						<br>
						<br> --->
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&location=GL" target="_blank"><font size="2"><strong>
	              		Tax Invoice (GL)</strong></font></a>
					<cfelseif lcase(hcomid) eq "mhca_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=&printer=" target="_blank"><font size="2"><strong>
	              		Tax Invoice</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=US&printer=" target="_blank"><font size="2"><strong>
	              		Tax Invoice (Foreign)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=&printer=EPSON" target="_blank"><font size="2"><strong>
	              		Tax Invoice (EPSON)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=US&printer=EPSON" target="_blank"><font size="2"><strong>
	              		Tax Invoice (Foreign) (EPSON)</strong></font></a>
					<cfelseif lcase(hcomid) eq "mhdemo_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=" target="_blank"><font size="2"><strong>
	              		Tax Invoice</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&country=US" target="_blank"><font size="2"><strong>
	              		Tax Invoice (Foreign)</strong></font></a>
					<cfelseif lcase(hcomid) eq "hkdemo_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV" target="_blank"><font size="2"><strong>
	              		Tax Invoice</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=Karen" target="_blank"><font size="2"><strong>
	              		Karen</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=Fastmove" target="_blank"><font size="2"><strong>
	              		Fastmove</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=CharterLane" target="_blank"><font size="2"><strong>
	              		CharterLane</strong></font></a>
					<cfelseif lcase(hcomid) eq "ovas_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV" target="_blank"><font size="2"><strong>
	              		Tax Invoice</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=MALAYSIA" target="_blank"><font size="2"><strong>
	              		Tax Invoice (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=SINGAPORE" target="_blank"><font size="2"><strong>
	              		Tax Invoice (SINGAPORE)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=MALAYSIA" target="_blank"><font size="2"><strong>
	              		Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=SINGAPORE" target="_blank"><font size="2"><strong>
	              		Delivery Order (SINGAPORE)</strong></font></a>
					<cfelseif lcase(hcomid) eq "winbells_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Option=LCL" target="_blank"><font size="2"><strong>
	              		Invoice - Shipping LCL</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Option=Air" target="_blank"><font size="2"><strong>
	              		Invoice - Shipping By Air</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Option=Transport" target="_blank"><font size="2"><strong>
	              		Invoice - Transport</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Option=Warehouse" target="_blank"><font size="2"><strong>
	              		Invoice - Warehouse</strong></font></a>
					<cfelse>
						<cfif lcase(hcomid) neq "pnp_i">
		        			<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV" target="_blank"><font size="2"><strong>
	              			Tax Invoice</strong></font></a>
							<br>
							<br>
						</cfif>
						<cfif lcase(hcomid) neq "avent_i" and lcase(hcomid) neq "floprints2010_i" and lcase(hcomid) neq "alliancepack_i">
							<cfif lcase(hcomid) neq "net_i">
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=NONTAX" target="_blank"><font size="2"><strong>
		              			Invoice</strong></font></a>
							</cfif>
							<cfif lcase(hcomid) eq "tmt_i">
								<br>
								<br>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=EF" target="_blank"><font size="2"><strong>
	              				Enrolment Form</strong></font></a>
	              			<cfelseif lcase(hcomid) eq "net_i">
								<a href="../../billformat/#dts#/transactionformat1.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=FC" target="_blank"><font size="2"><strong>
	              				Tax Invoice (FC)</strong></font></a>
							</cfif>
						<cfelse>
                        <cfif lcase(hcomid) neq "floprints2010_i" and lcase(hcomid) neq "alliancepack_i">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=FOREIGNTAX" target="_blank"><font size="2"><strong>
	              			Foreign Tax Invoice</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO" target="_blank"><font size="2"><strong>
	              			Delivery Order</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=PLIST" target="_blank"><font size="2"><strong>
	              			Packing List</strong></font></a>
                            </cfif>
						</cfif>
						<cfif lcase(hcomid) eq "idi_i">
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV_HK" target="_blank"><font size="2"><strong>
	              			Proforma Invoice</strong></font></a>
						</cfif>
					</cfif>
			  		</div>
	        	</cfcase>
				<cfcase value="DO"> 
	 	      		<div align="center">
					<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn08_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&country=USA" target="_blank"><font size="2"><strong>
	              		Delivery Order (US)</strong></font></a>
						<br>
						<br>
	 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&country=OTHERS" target="_blank"><font size="2"><strong>
	              		Delivery Order (FOREIGN)</strong></font></a>
					<cfelseif lcase(hcomid) eq "topsteel_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&location=AMK" target="_blank"><font size="2"><strong>
	              		Delivery Order (AMK)</strong></font></a>
						<br>
						<br>
	 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&location=GL" target="_blank"><font size="2"><strong>
	              		Delivery Order (GL)</strong></font></a>
	                <cfelseif lcase(hcomid) eq "ovas_i">
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA" target="_blank"><font size="2"><strong>
	              		Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE" target="_blank"><font size="2"><strong>
	              		Delivery Order (SINGAPORE)</strong></font></a>
		        	<cfelse>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO" target="_blank"><font size="2"><strong>
	              		Delivery Order</strong></font></a>
						<br>
						<br>
                        <cfif lcase(hcomid) neq "floprints2010_i" and lcase(hcomid) neq "alliancepack_i">
	 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=PLIST" target="_blank"><font size="2"><strong>
	              		Packing List</strong></font></a>
                        </cfif>
					</cfif>
			  		</div>
	        	</cfcase>
				<cfcase value="CN">
					<div align="center">
						<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn08_i">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&country=" target="_blank"><font size="2"><strong>
							Credit Invoice</strong></font></a>
							<br>
							<br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&country=USA" target="_blank"><font size="2"><strong>
							USA Tax Credit Invoice</strong></font></a>
							<br>
							<br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&country=FRENCH" target="_blank"><font size="2"><strong>
							French Tax Credit Invoice</strong></font></a>
						<cfelseif lcase(hcomid) eq "topsteel_i">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=AMK" target="_blank"><font size="2"><strong>
		              		#tran# (AMK)</strong></font></a>
							<br>
							<br>
		 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=GL" target="_blank"><font size="2"><strong>
		              		#tran# (GL)</strong></font></a>
						<cfelse>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>Credit Note</strong></font></a>
						</cfif>
					</div>
				</cfcase> 
	        	<cfdefaultcase> 
	 	      		<div align="center">
						<cfif lcase(hcomid) eq "topsteel_i">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=AMK" target="_blank"><font size="2"><strong>
		              		#tran# (AMK)</strong></font></a>
							<br>
							<br>
		 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=GL" target="_blank"><font size="2"><strong>
		              		#tran# (GL)</strong></font></a>
		              	<cfelseif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenn08_i") and tran eq "QUO">
		              		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillFormat=Excel" target="_blank"><font size="2"><strong>Pre-Craft</strong></font></a>
						<cfelseif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenn08_i") and tran eq "SO">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&country=" target="_blank"><font size="2"><strong>
		              		US Open Purchase SO</strong></font></a>
							<br>
							<br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Country=USA" target="_blank"><font size="2"><strong>
		              		US Port Service SO</strong></font></a>
							<br>
							<br>
		 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Country=FRENCH" target="_blank"><font size="2"><strong>
		              		French SO</strong></font></a>
							<br>
							<br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Country=MISC" target="_blank"><font size="2"><strong>
		              		Misc. SO</strong></font></a>
		              	<cfelseif lcase(hcomid) eq "net_i" and tran eq "PO">
		              		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong>Sage on PO print option</strong></font></a>
						<cfelse>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong><cfif tran eq 'PO'>Purchase Order<cfelseif tran eq 'CN'>Credit Note<cfelseif tran eq 'DN'>Debit Note<cfelseif tran eq 'SO'>Sales Order<cfelseif tran eq 'QUO'>Quotation<cfelse>View</cfif></strong></font></a>
						</cfif>
			    		<!--- <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong>View</strong></font></a> --->
						<cfif (lcase(hcomid) eq "floprints_i" or lcase(hcomid) eq "floprints2010_i" or lcase(hcomid) eq "alliancepack_i") and tran eq "SO">
							<br/><br/>
							<a href="../../billformat/#dts#/joborder.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>Printing Job Order</strong></font></a>
						</cfif>
						<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq "CS" or tran eq "SAM")>
							<cfif tran neq "SAM">
								<br/><br/>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=MALAYSIA" target="_blank"><font size="2"><strong>#tran# (MALAYSIA)</strong></font></a>
								<br/><br/>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=SINGAPORE" target="_blank"><font size="2"><strong>#tran# (SINGAPORE)</strong></font></a>
							</cfif>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA" target="_blank"><font size="2"><strong>Delivery Order (MALAYSIA)</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE" target="_blank"><font size="2"><strong>Delivery Order (SINGAPORE)</strong></font></a>
						</cfif>
						<cfif lcase(hcomid) eq "mhca_i" and tran eq "PO">
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillFormat=Excel" target="_blank"><font size="2"><strong>#tran# (EXCEL)</strong></font></a>
						</cfif>
                       
					</div>
				</cfdefaultcase>  
	      	</cfswitch> 
		</cfcatch>
		</cftry>
         <cfif lcase(hcomid) eq "verjas_i" and tran eq "DO">
                     <div align="center">   <br>
		<a href="../../billformat/#dts#/excelformat_bill.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>#tran# (Excel)</strong></font></a>
		</div></cfif>
		</td>
    	<td><div align="center"><a href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#nexttranno#" <cfif getSetting.EDControl eq "Y">onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif>><font size="2"><strong><cfif tran eq 'PO'>Purchase Order<cfelseif tran eq 'CN'>Credit Note<cfelseif tran eq 'DN'>Debit Note<cfelseif tran eq 'SO'>Sales Order<cfelseif tran eq 'QUO'>Quotation<cfelse>View</cfif></strong></font></a>
        <br/>
        <a href="../../billformat/default/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>UBS Format</strong></font></a>
        </div></td>
  	</tr>
    <tr>
    <td colspan="100%"><hr></td>
    </tr>
    <tr align="center">
    <td><a href="transaction.cfm?tran=#tran#" target="_self" >
					<font size="2"><b>#tran# Menu</b></font>
				</a>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                	<a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#nexttranno#&custno=#URLEncodedFormat(checkPrinted.custno)#<!--- &bcode=&dcode= --->&first=0"><font size="2"><b>Edit</b></font></a>
                </td>
    </tr>
</cfoutput>
</table>
</cfif>

<div id="ajaxField">
</div>
</body>
</html>
