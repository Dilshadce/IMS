<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfset thisPath = ExpandPath("/billformat/#dts#/*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>
<cfif DirectoryExists(thisDirectory) eq 'NO'>
<cftry>
	<cfdirectory action="create" directory="#thisDirectory#">
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/preprintedformat.cfm")#" destination="#thisDirectory#">
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/transactionformat.cfm")#" destination="#thisDirectory#">
    
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CN.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CS.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CS.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DN.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DO.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/INV.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_INV.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/PR.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_PR.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/QUO.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_QUO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/RC.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_RC.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/SO.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_SO.cfr">
    
	
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.0/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.1/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
	<cfoutput><p>Company directory has been created.</p></cfoutput>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>

<cfquery name="GetSetting" datasource="#dts#">
SELECT EDControl,printapprove,lQUO,lSO,priceminctrlemail FROM gsetup 
</cfquery>
<cfquery name="checkPrinted" datasource="#dts#">
SELECT printed,custno,printstatus,permitno,currrate FROM artran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#"> and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
</cfquery>
<cfif lcase(hcomid) eq "simplysiti_i">
<cfif url.tran eq "DO">
<cfif checkprinted.printed eq "Y">
<cfoutput>
<script type="text/javascript">
		alert('You Have Printed This Delivery Note Before')
</script>
</cfoutput>
</cfif>
</cfif>
</cfif>

<cfif lcase(hcomid) eq "hunting_i" and checkPrinted.printstatus eq ''>
<cfif url.tran eq 'QUO' or url.tran eq 'SO'>

<cfquery name="getbillstatus" datasource="#dts#">
select printstatus,created_by,grand,grand_bil,currcode,custno,name,CREATED_ON from artran where type='#url.tran#' and refno='#url.nexttranno#'
</cfquery>

<cfquery name="getgeneralmail" datasource="main">
select useremail from users where userDept = "#dts#" and userGrpId="admin" and useremail <> ""
</cfquery>

<cfset email1=''>
<cfloop query="getgeneralmail">
<cfset email1=email1&getgeneralmail.useremail>
<cfif getgeneralmail.recordcount neq getgeneralmail.currentrow>
<cfset email1=email1&",">
</cfif>
</cfloop>

<cfif email1 neq ''>

<cfif url.tran eq 'SO'>
<cfset reftypename=GetSetting.lSO>
<cfelse>
<cfset reftypename=GetSetting.lQUO>
</cfif>
<cfoutput>

<cftry>
<cfmail from="noreply@mynetiquette.com" to="#email1#" 
			subject="#url.tran#-#url.nexttranno# has been created"
		>
This message was sent by an automatic mailer built with cfmail:
= = = = = = = = = = = = = = = = = = = = = = = = = = =

Bill Type : #reftypename#
Bill No : #url.nexttranno#
Customer Name:#getbillstatus.name#
Total Amount: #getbillstatus.currcode# #getbillstatus.grand_bil#
Created By : #getbillstatus.created_by#

</cfmail>
<cfcatch>
</cfcatch>
</cftry>
</cfoutput>

</cfif>

<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='1' where type='#url.tran#'and refno='#url.nexttranno#'
</cfquery>
</cfif>

</cfif>

<cfif GetSetting.printapprove eq 'Y' and checkPrinted.printstatus neq 'a3' and url.tran eq 'PO'>
<cfajaximport tags="cfform">
        <cfwindow center="true" width="350" height="300" name="printpass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/printpass/printpass.cfm?type=#url.tran#&refno=#url.nexttranno#" />
<cfelse>

<cfif getSetting.EDControl eq "Y" and checkPrinted.printed eq "Y">
<cfajaximport tags="cfform">
<cfwindow center="true" width="350" height="300" name="exampass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/exampass/exampass.cfm?type=printing" />
<cfelse>
</cfif>
</cfif>

<cfif getSetting.priceminctrlemail eq '1' and checkPrinted.printstatus neq 'a3' and url.tran eq 'QUO'>

<cfset pricemincontrol=0>
<cfquery name="getbillitem" datasource="#dts#">
select amt_bil/qty as price_bil,itemno from ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#"> and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
</cfquery>

<cfquery name="getitemlist" datasource="#dts#">
SELECT price_min,fprice_min,itemno FROM icitem WHERE itemno in 
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbillitem.itemno)#" separator="," list="yes">)
</cfquery>

<cfloop query="getbillitem">
<cfquery name="getitemminprice" dbtype="query">
SELECT price_min,fprice_min FROM getitemlist WHERE UPPER(itemno)= '#ucase(getbillitem.itemno)#'
</cfquery>
<cfif checkPrinted.currrate eq 1>
<cfif getbillitem.price_bil lt getitemminprice.price_min>
<cfset pricemincontrol=1>
</cfif>
<cfelse>
<cfif getbillitem.price_bil lt getitemminprice.fprice_min>
<cfset pricemincontrol=1>
</cfif>
</cfif>
</cfloop>

<cfif pricemincontrol eq 1>



<cfajaximport tags="cfform">
        <cfwindow center="true" width="350" height="300" name="printpass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/printpass/minpriceprint.cfm?type=#url.tran#&refno=#url.nexttranno#" />
</cfif>
</cfif>

<cfif checkPrinted.printstatus neq 'a3' and url.tran eq 'QUO' and lcase(hcomid) eq 'net_i'>
<cfajaximport tags="cfform">
        <cfwindow center="true" width="350" height="300" name="printpass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/printpass/printpassnet.cfm?type=#url.tran#&refno=#url.nexttranno#" />
<cfelse>

</cfif>


<html>
<head>
	<title>Transaction 3C</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    
    <script language="javascript" type="text/javascript">
	function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	} 
	
	</script>
    
    <cfquery datasource="#dts#" name="getGeneralInfo">
	Select * from GSetup
	</cfquery>
    
</head>

<body>
<cfquery name="getmodule" datasource="#dts#">
        SELECT * FROM modulecontrol
        </cfquery>

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
<cfif tran eq 'SAMM' and getpin2.h2856 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'PO' and getpin2.h2867 eq "T">
<cfset cprint="T">
</cfif>
<cfif tran eq 'RQ' and getpin2.h28G6 eq "T">
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
    	<th <cfif lcase(hcomid) eq "SDC_i">style="visibility:hidden"</cfif>>Default</th>
  	</tr>
	
  	<cfoutput>
  	<tr>
    	<td height="20">
        <cfif lcase(hcomid) eq "billformat_i">
        <cfquery name="getlistbill" datasource="#dts#">
        SELECT * FROM BILLFORMATLIST
        </cfquery>
        
        <cfloop query="getlistbill">
        <h1>#UCASE(getlistbill.company)#</h1>
        <cfquery name="getformat" datasource="#getlistbill.company#">
				select * from customized_format
				where type='#tran#'
				order by counter
			</cfquery>
			<cfset thiscount=0>
			<cfset maxcount=getformat.recordcount>
			<cfloop query="getformat">
				<cfset thiscount=thiscount+1>
				<div align="center">
					<a href="/billformat/#dts#/#getlistbill.company#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillName=#getformat.file_name#&doption=#getformat.d_option#&counter=#getformat.counter#" target="_blank" <cfif getSetting.EDControl eq "Y"> onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif> ><font size="2"><strong><cfif getmodule.auto eq '1'>Print </cfif>#getformat.display_name#</strong></font></a>
					<cfif thiscount neq maxcount><br><br></cfif>
				</div>
			</cfloop>
        </cfloop>
        <cfelse>
        
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
                <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>
                <cfquery name="getweikenproject" datasource="#dts#">
                	select source from artran where refno='#url.nexttranno#' and type='#url.tran#'
                </cfquery>
                <cfquery name="getweikenplanning" datasource="#replace(dts,'_i','_c','all')#">
				SELECT * FROM planning WHERE project_id='#getweikenproject.source#'
                </cfquery>
                <cfif getweikenplanning.recordcount eq 0>
                <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="alert('Project has no planning')">
                    <font size="2"><strong><cfif getmodule.auto eq '1'>Print </cfif>#getformat.display_name#</strong></font></a>
                <cfelse>
                <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillName=#getformat.file_name#&doption=#getformat.d_option#&counter=#getformat.counter#" target="_blank" <cfif getSetting.EDControl eq "Y"> onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif> >
                    
                    
                    <font size="2"><strong><cfif getmodule.auto eq '1'>Print </cfif>#getformat.display_name#</strong></font></a>
                </cfif>
                <cfelse>
					<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillName=#getformat.file_name#&doption=#getformat.d_option#&counter=#getformat.counter#" target="_blank" <cfif getSetting.EDControl eq "Y"> onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif> >
                    
                    
                    <font size="2"><strong><cfif getmodule.auto eq '1'>Print </cfif>#getformat.display_name#</strong></font></a>
                    </cfif>
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
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&deposit=1" target="_blank"><font size="2"><strong>
	              		Tax Invoice(Deposit)</strong></font></a>
						<br>
						<br>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&int=1" target="_blank"><font size="2"><strong>
	              		Tax Invoice(INT)</strong></font></a>
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
                        <br>
                        <br>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=Weldasia" target="_blank"><font size="2"><strong>
	              		Weld Asia</strong></font></a>
                        <br>
                        <br>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=taxinv2" target="_blank"><font size="2"><strong>
	              		Tax Inv 2</strong></font></a>
                        <br>
                        <br>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=taxinv4" target="_blank"><font size="2"><strong>
	              		Tax Inv(Deposit 2)</strong></font></a>
                        <br>
                        <br>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=waga" target="_blank"><font size="2"><strong>
	              		Weld Asia Global Advisory</strong></font></a>
			<br>
                        <br>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Agent=inte" target="_blank"><font size="2"><strong>
	              		WELD ASIA INTERNATIONAL (HK) LIMITED</strong></font></a>
                        
					<cfelseif lcase(hcomid) eq "ovas_i">
                   
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
                        <br/><br/>
                        <!---<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=MALAYSIA&company=veillux" target="_blank"><font size="2"><strong>
	              		Veillux Tax Invoice (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=SINGAPORE&company=veillux" target="_blank"><font size="2"><strong>
	              		Veillux Tax Invoice (SINGAPORE)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=MALAYSIA&company=veillux" target="_blank"><font size="2"><strong>
	              		Veillux Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=SINGAPORE&company=veillux" target="_blank"><font size="2"><strong>
	              		Veillux Delivery Order (SINGAPORE)</strong></font></a>
                        <br/><br/>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=MALAYSIA&company=art" target="_blank"><font size="2"><strong>
	              		Art Gallery Tax Invoice (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=SINGAPORE&company=art" target="_blank"><font size="2"><strong>
	              		Art Gallery Tax Invoice (SINGAPORE)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=MALAYSIA&company=art" target="_blank"><font size="2"><strong>
	              		Art Gallery Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=SINGAPORE&company=art" target="_blank"><font size="2"><strong>
	              		Art Gallery Delivery Order (SINGAPORE)</strong></font></a>
                        
                        <br/><br/>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=MALAYSIA&company=All" target="_blank"><font size="2"><strong>
	              		All Logo Tax Invoice (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&Location=SINGAPORE&company=All" target="_blank"><font size="2"><strong>
	              		All Logo Tax Invoice (SINGAPORE)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=MALAYSIA&company=All" target="_blank"><font size="2"><strong>
	              		All Logo Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=INVDO&Location=SINGAPORE&company=All" target="_blank"><font size="2"><strong>
	              		All Logo Delivery Order (SINGAPORE)</strong></font></a>--->
                        
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
                        <cfif lcase(hcomid) eq "net_i">
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=NONTAXWUOM" target="_blank"><font size="2"><strong>
		              			Invoice (With UOM)</strong></font></a>
                                <br>
                                <br>
							</cfif>
							<cfif lcase(hcomid) neq "net_i">
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=NONTAX" target="_blank"><font size="2"><strong>
		              			Invoice</strong></font></a>
							</cfif>
							<cfif lcase(hcomid) eq "tmt_i">
								<br>
								<br>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=EF" target="_blank"><font size="2"><strong>
	              				Enrolment Form</strong></font></a>
							</cfif>
                           
                           <cfif lcase(hcomid) eq "net_i">
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=PDFFC" target="_blank"><font size="2"><strong>
	              				Tax Invoice PDF (FC)</strong></font></a>
							
                            
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
                        <br/><br/>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA&company=veillux" target="_blank"><font size="2"><strong>
	              		Veillux Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE&company=veillux" target="_blank"><font size="2"><strong>
	              		Veillux Delivery Order (SINGAPORE)</strong></font></a>
                        <br/><br/>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA&company=art" target="_blank"><font size="2"><strong>
	              		Art Gallery Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE&company=art" target="_blank"><font size="2"><strong>
	              		Art Gallery Delivery Order (SINGAPORE)</strong></font></a>
						
                        <br/><br/>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA&company=All" target="_blank"><font size="2"><strong>
	              		All Logo Delivery Order (MALAYSIA)</strong></font></a>
						<br>
						<br>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE&company=All" target="_blank"><font size="2"><strong>
	              		All Logo Delivery Order (SINGAPORE)</strong></font></a>
		        	<cfelse>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO" target="_blank"><font size="2"><strong>
	              		Delivery Order</strong></font></a>
						<br>
						<br>
                                       
                        <cfif lcase(hcomid) neq "floprints2010_i" and lcase(hcomid) neq "alliancepack_i">
	 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=PLIST" target="_blank"><font size="2"><strong>
	              		Packing List</strong></font></a>
                        </cfif>
                        <br><br>
                         <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO2" target="_blank"><font size="2"><strong>
	              			Delivery Order 2</strong></font></a>
                            <br><br>
                              <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&&billformat=KW_ICBil_DO" target="_blank"><font size="2"><strong>
	              			Delivery Order (PDF)</strong></font></a>
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
                        <cfif lcase(hcomid) eq "ovas_i">
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=SG" target="_blank"><font size="2"><strong>Credit Note(SINGAPORE)</strong></font></a>
                        <br>
                        <br>
                        <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=MY" target="_blank"><font size="2"><strong>Credit Note(MALAYSIA)</strong></font></a>
                        <cfelse>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>Credit Note</strong></font></a>
                            </cfif>
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
                            <cfif tran eq 'QUO'>
                            <br>
							<br>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=AMK&total=1" target="_blank"><font size="2"><strong>
		              		#tran# (AMK) W/O Total</strong></font></a>
							<br>
							<br>
		 	        		<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&location=GL&total=1" target="_blank"><font size="2"><strong>
		              		#tran# (GL) W/O Total</strong></font></a>
                            </cfif>
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
                        <cfif lcase(hcomid) eq "ovas_i">
                        <cfif tran neq "cs">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong><cfif tran eq 'PO'>Purchase Order<cfelseif tran eq 'CN'>Credit Note<cfelseif tran eq 'DN'>Tax Invoice (MALAYSIA)<cfelseif tran eq 'SO'>Sales Order<cfelseif tran eq 'QUO'>Quotation<cfelse>View</cfif></strong></font></a>
                            <br/><br/>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&company=Veillux"><font size="2"><strong><cfif tran eq 'PO'>Veillux Purchase Order<cfelseif tran eq 'CN'>Veillux Credit Note<cfelseif tran eq 'DN'>Tax Invoice (SINGAPORE)<cfelseif tran eq 'SO'>Veillux Sales Order<cfelseif tran eq 'QUO'>Veillux Quotation<cfelse>Veillux View</cfif></strong></font></a>
                            <br/><br/>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&company=Art"><font size="2"><strong><cfif tran eq 'PO'>Art Gallery Purchase Order<cfelseif tran eq 'CN'>Art Gallery Credit Note<cfelseif tran eq 'DN'>Delivery Order (MALAYSIA)<cfelseif tran eq 'SO'>Art Gallery Sales Order<cfelseif tran eq 'QUO'>Art Gallery Quotation<cfelse>Art Gallery View</cfif></strong></font></a>
                            
                            <br/><br/>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&company=All"><font size="2"><strong><cfif tran eq 'PO'>All Logo Purchase Order<cfelseif tran eq 'CN'>All Logo Credit Note<cfelseif tran eq 'DN'>Delivery Order (SINGAPORE)<cfelseif tran eq 'SO'>All Logo Sales Order<cfelseif tran eq 'QUO'>All Logo Quotation<cfelse>All Logo View</cfif></strong></font></a>
                            </cfif>
                        <cfelse>
                           
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong><cfif tran eq 'PO'>Purchase Order<cfelseif tran eq 'CN'>Credit Note<cfelseif tran eq 'DN'>Debit Note<cfelseif tran eq 'SO'>Sales Order<cfelseif tran eq 'QUO'>Quotation<cfelse>View</cfif></strong></font></a>
			

                        </cfif>
						</cfif>
			    		<!--- <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#"><font size="2"><strong>View</strong></font></a> --->
						<cfif (lcase(hcomid) eq "floprints_i" or lcase(hcomid) eq "floprints2010_i" or lcase(hcomid) eq "alliancepack_i") and tran eq "SO">
							<br/><br/>
							<a href="../../billformat/#dts#/joborder.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>Printing Job Order</strong></font></a>
						</cfif>
						<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq "CS" or tran eq "SAM")>
							<cfif tran neq "SAM">
								<cfif lcase(hcomid) neq "ovas_i"><br/><br/></cfif>
                                <cfif lcase(hcomid) neq "ovas_i">
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=MALAYSIA" target="_blank"><font size="2"><strong>#tran# (MALAYSIA)</strong></font></a>
								<br/><br/>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=SINGAPORE" target="_blank"><font size="2"><strong>#tran# (SINGAPORE)</strong></font></a>
								</cfif>
                                <cfif lcase(hcomid) eq "ovas_i">
                                <cfif tran neq 'CS'>
                                <br/><br/>
                                <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=MALAYSIA&company=veillux" target="_blank"><font size="2"><strong>Veillux #tran# (MALAYSIA)</strong></font></a>
								<br/><br/>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=SINGAPORE&company=veillux" target="_blank"><font size="2"><strong>Veillux #tran# (SINGAPORE)</strong></font></a>
                                <br/><br/>
                                <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=MALAYSIA&company=art" target="_blank"><font size="2"><strong>Art Gallery #tran# (MALAYSIA)</strong></font></a>
								<br/><br/>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=SINGAPORE&company=art" target="_blank"><font size="2"><strong>Art Gallery #tran# (SINGAPORE)</strong></font></a>
                                </cfif>
                                <br/><br/>
                                <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=MALAYSIA&company=All" target="_blank"><font size="2"><strong>#tran# (MALAYSIA)</strong></font></a>
								<br/><br/>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=SINGAPORE&company=All" target="_blank"><font size="2"><strong>#tran# (SINGAPORE)</strong></font></a>
                                
                                <cfif tran eq "CS" and lcase(hcomid) eq "ovas_i">
                                <br/><br/>
                                <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=MALAYSIA&company=All&chinese=1" target="_blank"><font size="2"><strong>#tran# (MALAYSIA) (Chinese)</strong></font></a>
								<br/><br/>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&Location=SINGAPORE&company=All&chinese=1" target="_blank"><font size="2"><strong>#tran# (SINGAPORE) (Chinese)</strong></font></a>
                                </cfif>
                                </cfif>
							</cfif>
                            <cfif tran neq "CS" and lcase(hcomid) neq "ovas_i">
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA" target="_blank"><font size="2"><strong>Delivery Order (MALAYSIA)</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE" target="_blank"><font size="2"><strong>Delivery Order (SINGAPORE)</strong></font></a>
                            </cfif>
                            
                            <cfif lcase(hcomid) eq "ovas_i">
                            <cfif tran neq 'CS'>
                            <br/><br/>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA&company=veillux" target="_blank"><font size="2"><strong>Veillux Delivery Order (MALAYSIA)</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE&company=veillux" target="_blank"><font size="2"><strong>Veillux Delivery Order (SINGAPORE)</strong></font></a>
                            <br/><br/>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA&company=art" target="_blank"><font size="2"><strong>Art Gallery Delivery Order (MALAYSIA)</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE&company=art" target="_blank"><font size="2"><strong>Art Gallery Delivery Order (SINGAPORE)</strong></font></a>
                            </cfif>
                            <br/><br/>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA&company=All" target="_blank"><font size="2"><strong>Delivery Order (MALAYSIA)</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE&company=All" target="_blank"><font size="2"><strong>Delivery Order (SINGAPORE)</strong></font></a>
                            
                            <cfif tran eq "CS" and lcase(hcomid) eq "ovas_i">

                            <br/><br/>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=MALAYSIA&company=All&chinese=1" target="_blank"><font size="2"><strong>Delivery Order (MALAYSIA) (Chinese)</strong></font></a>
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=DO&Location=SINGAPORE&company=All&chinese=1" target="_blank"><font size="2"><strong>Delivery Order (SINGAPORE) (Chinese)</strong></font></a>
                            
                            </cfif>
                            
                            </cfif>
						</cfif>
						<cfif lcase(hcomid) eq "mhca_i" and tran eq "PO">
							<br><br>
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillFormat=Excel" target="_blank"><font size="2"><strong>#tran# (EXCEL)</strong></font></a>
						</cfif>
                       <cfif lcase(hcomid) eq "net_i"  and tran eq "QUO">
						<br><br>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=WUOM" target="_blank"><font size="2"><strong>
		              			Quotation (With UOM)</strong></font></a>
                                
							</cfif>

			<cfif lcase(hcomid) eq "net_i" and tran eq "SO">
			<br><br>
								<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=WUOM" target="_blank"><font size="2"><strong>
		              			Proforma Invoice</strong></font></a>
			</cfif>
					</div>
				</cfdefaultcase>  
	      	</cfswitch> 
		</cfcatch>
		</cftry>
         <cfif lcase(hcomid) eq "kawah_i" and tran eq "INV">
							<br>
                              <div align="center">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=1&biltype=&billformat=KW_ICBil_INV" target="_blank"><font size="2"><strong>Invoice(PDF)</strong></font></a>
                            <br>
                            <br>
                            <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=2&biltype=&billformat=KW_ICBil_INV2" target="_blank"><font size="2"><strong>Invoice2(PDF)</strong></font></a>
                            </div>
						</cfif>
                         <cfif lcase(hcomid) eq "kawah_i" and tran eq "QUO">
                         <br>
                          <div align="center">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=3&biltype=&billformat=KW_ICBil_QUO" target="_blank"><font size="2"><strong>QUOTATION(PDF)</strong></font></a></div>
                         </cfif>
                          <cfif lcase(hcomid) eq "kawah_i" and tran eq "RC">
                         <br>
                          <div align="center">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=4&biltype=&billformat=KW_ICBil_RC" target="_blank"><font size="2"><strong>Purchase Receive(PDF)</strong></font></a></div>
                         </cfif>
                          <cfif lcase(hcomid) eq "kawah_i" and tran eq "PO">
                         <br>
                          <div align="center">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=4&biltype=&billformat=KW_ICBil_PO" target="_blank"><font size="2"><strong>Purchase Order(PDF)</strong></font></a></div>
                         </cfif>
                         
                         <cfif lcase(hcomid) eq "kawah_i" and tran eq "CN">
                         <br>
                          <div align="center">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=4&biltype=&billformat=KW_ICBil_CN" target="_blank"><font size="2"><strong>Credit Note(PDF)</strong></font></a></div>
                         </cfif>
                          <cfif lcase(hcomid) eq "kawah_i" and tran eq "CS">
                         <br>
                          <div align="center">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=4&biltype=&billformat=KW_ICBil_CS" target="_blank"><font size="2"><strong>Cash Sales(PDF)</strong></font></a></div>
                         </cfif>
                          <cfif lcase(hcomid) eq "kawah_i" and tran eq "PR">
                         <br>
                          <div align="center">
							<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&PDF=4&biltype=&billformat=KW_ICBil_PR" target="_blank"><font size="2"><strong>Purchase Return(PDF)</strong></font></a></div>
                         </cfif>
                         
        <cfif lcase(hcomid) eq "tafc_i" and tran eq "INV">
        <br>
        <div align="center"> 
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=TAXINV&excel=1" target="_blank"><font size="2"><strong>
	              		Tax Invoice (Excel)</strong></font></a>
                        </div>
						<br>
         </cfif>  
         <cfif lcase(hcomid) eq "tafc_i" and tran eq "QUO">
        <br>
        <div align="center"> 
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BilType=#tran#&excel=1" target="_blank"><font size="2"><strong>
	              		Quotation (Excel)</strong></font></a>
                        </div>
						<br>
         </cfif>              
         <cfif lcase(hcomid) eq "verjas_i" and tran eq "DO">
                     <div align="center">   <br>
		<a href="../../billformat/#dts#/excelformat_bill.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>#tran# (Excel)</strong></font></a>
		</div></cfif>
        </cfif>
        <cfif tran eq "DO">
        <cfif lcase(hcomid) neq "fdipx_i" and lcase(hcomid) neq "ugateway_i" and lcase(hcomid) neq "eocean_i" and lcase(hcomid) neq "eocean_i">
        <br>
       <div align="center"> <a href="../../billformat/default/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&format=2" target="_blank"><font size="2"><strong>Default DO Format</strong></font></a></div>
        </cfif>
        </cfif>
        <cfif lcase(hcomid) eq "demo_i">
        <br>
       <div align="center"> <a onMouseOver="this.style.cursor='hand'" onClick="ColdFusion.Window.show('chooseformat');"><font size="2"><strong>Email Format</strong></font></a></div>
        </cfif>
		</td>
    	<td <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i" or lcase(hcomid) eq "SDC_i")>style="visibility:hidden"</cfif>><div align="center"><a href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#nexttranno#" <cfif getSetting.EDControl eq "Y">onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif>><font size="2"><strong><cfif tran eq 'PO'>Purchase Order<cfelseif tran eq 'CN'>Credit Note<cfelseif tran eq 'DN'>Debit Note<cfelseif tran eq 'SO'>Sales Order<cfelseif tran eq 'QUO'>Quotation<cfelse>View</cfif></strong></font></a>
        <br/>
        <a href="../../billformat/default/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>PDF Format</strong></font></a>
        <br/>
        <a href="../../billformat/default/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&tax=1" target="_blank"><font size="2"><strong>PDF Format W/O Tax</strong></font></a>
        <br/>
        <cfif lcase(hcomid) eq "bnbm_i" or lcase(hcomid) eq "bnbp_i" or lcase(hcomid) eq "jctpl_i" or lcase(hcomid) eq "fixics_i">
        <a href="/default/transaction/emailformat.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>Email Format</strong></font></a>
        </cfif>
        </div>
        
        </td>
        
  	</tr>
    <tr>
    <td colspan="100%"><hr></td>
    </tr>
    <tr align="center">
    <td>
    <cfif lcase(HcomID) eq "supervalu_i">
    <a href="transactionProfile.cfm?menuID=10000&tran=#tran#" target="_self" >
					<font size="2"><b>#tran# Menu</b></font>
				</a>
    <cfelse>
    <a href="transactionProfile.cfm?menuID=10000&tran=#tran#" target="_self" >
					<font size="2"><b>#tran# Menu</b></font>
				</a>
    </cfif>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <cfset aledit = 0>
<cfif tran eq "RC">
	<cfif getpin2.h2103 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "PR">

	<cfif getpin2.h2202 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "DO">

	<cfif getpin2.h2302 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "INV">

	<cfif getpin2.h2402 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "CS">

	<cfif getpin2.h2502 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "CN">

	<cfif getpin2.h2602 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "DN">

	<cfif getpin2.h2702 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "PO">

	<cfif getpin2.h2862 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "RQ">

	<cfif getpin2.h28G2 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "QUO">
	<cfif getpin2.h2872 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
</cfif>

<cfif tran eq "SO">

	<cfif getpin2.h2882 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

</cfif>

<cfif tran eq "SAM">

	<cfif getpin2.h2852 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

</cfif>
                	<cfif aledit eq 1>
                    <cfif getgeneralinfo.editbillpassword eq "1" and (getgeneralinfo.editbillpassword1 eq "" or ListFindNoCase(getgeneralinfo.editbillpassword1,tran))>
                    <a href="javascript:void(0)" onClick="PopupCenter('editbillcontrol.cfm?ttype=Edit&tran=#tran#&refno=#nexttranno#&parentpage=no','linkname','300','150');"><font size="2"><b>Edit</b></font></a>
                    <cfelse>
                    <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i") and tran eq "SO">
                    <cfif (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#nexttranno#&custno=#URLEncodedFormat(checkPrinted.custno)#<!--- &bcode=&dcode= --->&first=0"><font size="2"><b>Edit</b></font></a>
                    <cfelseif checkPrinted.permitno neq "locked">
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#nexttranno#&custno=#URLEncodedFormat(checkPrinted.custno)#<!--- &bcode=&dcode= --->&first=0"><font size="2"><b>Edit</b></font></a>
                    </cfif>
                    <cfelse>
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#nexttranno#&custno=#URLEncodedFormat(checkPrinted.custno)#<!--- &bcode=&dcode= --->&first=0"><font size="2"><b>Edit</b></font></a>
                    </cfif>
                    </cfif>
                    <cfif <!---HUserGrpID eq "super" and---> (tran eq 'SO' or tran eq 'INV' or tran eq 'CN') and lcase(hcomid) eq "ltm_i">
                         &nbsp;&nbsp;&nbsp;<a href="vehicletranedit/index.cfm?tran=#tran#&ttype=Edit&refno=#nexttranno#&custno=#URLEncodedFormat(checkPrinted.custno)#&first=0"><font size="2"><b>New Edit</b></font></a>
                    </cfif>
                    
                    </cfif>
                    
                    
                </td>
         <cfif lcase(hcomid) eq "net_i" or lcase(hcomid) eq "demo_i" or lcase(hcomid) eq "trialhk_i">
         <td><a href="/#HDir#/report-email/bill_emailreport.cfm?tran=#url.tran#"><font size="2"><b>Report Email</b></font></a></td>
    </cfif>
    </tr>
</cfoutput>
</table>
</cfif>
<cfoutput>
<cfquery name="gettransactiondetail" datasource="#dts#">
select * from artran where refno='#url.nexttranno#' and type='#url.tran#'
</cfquery>
<cfif url.tran eq 'PO' or url.tran eq 'RC' or url.tran eq 'PR' or url.tran eq 'RQ'>
<cfquery name="getcustadd" datasource="#dts#">
select * from #target_apvend# where custno='#gettransactiondetail.custno#'
</cfquery>
<cfelse>
<cfquery name="getcustadd" datasource="#dts#">
select * from #target_arcust# where custno='#gettransactiondetail.custno#'
</cfquery>
</cfif>
<br>
<table width="50%" border="0" cellspacing="0" cellpadding="5" align="center" class="data">
<tr>
<th colspan="2"><div align="center"><font size="+1"><strong>Transaction Detail</strong></font></div></th>
</tr>
<tr>
<th colspan="2"><hr></th>
</tr>
<tr>
<th width="250">Reference No</th>
<td>#gettransactiondetail.refno#</td>
</tr>
<tr>
<th width="250">Currency Code</th>
<td>#gettransactiondetail.currcode#</td>
</tr>
<tr>
<th>Customer Code</th>
<td>#gettransactiondetail.custno#</td>
</tr>
<tr>
<th>Name</th>
<td>#gettransactiondetail.name#</td>
</tr>

 <cfif (lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i")>
<tr>
<th>Description</th>
<td>#gettransactiondetail.desp#<cfif gettransactiondetail.despa neq ''><br>#gettransactiondetail.despa#</cfif>
</td>
</tr>

</cfif>
<tr>
<th>Address</th>
<td>#gettransactiondetail.frem2# #gettransactiondetail.frem3# <br> #gettransactiondetail.frem4# #gettransactiondetail.frem5# #gettransactiondetail.rem13#</td>
</tr>
<tr>
<th>Postalcode</th>
<td>#gettransactiondetail.postalcode#</td>
</tr>
<tr>
<th>Attn</th>
<td>#gettransactiondetail.rem2#</td>
</tr>
<th>Tel</th>
<td>#gettransactiondetail.rem4#</td>
</tr>
<tr>
<th>HP</th>
<td>#getcustadd.phonea#</td>
</tr>
</tr>
<tr>
<th>Fax</th>
<td>#gettransactiondetail.frem6#</td>
</tr>
<cfif url.tran eq 'PR' or url.tran eq 'PO' or url.tran eq 'RC' or url.tran eq 'RQ'>
<cfif getpin2.h1360 eq 'T'>
<tr>
<th>Gst</th>
<td>#numberformat(gettransactiondetail.tax_bil,',_.__')#</td>
</tr>
<tr>
<th>Net Amount</th>
<td>#numberformat(gettransactiondetail.grand_bil,',_.__')#</td>
</tr>
<tr>
<th>Currency Rate</th>
<td>#numberformat(gettransactiondetail.currrate,',_.__')#</td>
</tr>
<tr>
<th>Local Amount</th>
<td>#numberformat(gettransactiondetail.grand,',_.__')#</td>
</tr>
</cfif>
<cfelse>
<cfif getpin2.h1361 eq 'T'>
<tr>
<th>Gst</th>
<td>#numberformat(gettransactiondetail.tax_bil,',_.__')#</td>
</tr>
<tr>
<th>Net Amount</th>
<td>#numberformat(gettransactiondetail.grand_bil,',_.__')#</td>
</tr>
<tr>
<th>Currency Rate</th>
<td>#numberformat(gettransactiondetail.currrate,',_.__')#</td>
</tr>
<tr>
<th>Local Amount</th>
<td>#numberformat(gettransactiondetail.grand,',_.__')#</td>
</tr>
</cfif>
</cfif>
<tr>
<th>Project</th>
<td>#gettransactiondetail.source#</td>
</tr>
<tr>
<th>Created By</th>
<td>#gettransactiondetail.created_by#</td>
</tr>
<tr>
<th>Agent</th>
<td>#gettransactiondetail.agenno#</td>
</tr>
<tr>
<th>Voucher No</th>
<td>#gettransactiondetail.voucher#</td>
</tr>
<cfif hcomid eq "asiasoft_i" and url.tran eq "SO">
<tr>
<th>Profit</th>
<td>
<cfset dts2 = replace(dts,"_i","_c")>
<cfquery name="getprofit" datasource="#dts2#">
select sum(coalesce(brem2,0) * qty_bil) as modal,sum(price_bil * qty_bil) as sales from ictran where type = "#url.tran#" and refno = "#url.nexttranno#"
</cfquery>
<cfif getprofit.recordcount eq 0>
0.00
<cfelse>
#numberformat(val(getprofit.sales)-val(getprofit.modal),',.__')#
</cfif>
</td>
</tr>
<tr>
<th>Margin</th>
<td>
<cfif getprofit.recordcount eq 0>
0%
<cfelse>
<cfif val(getprofit.sales) neq 0>
#numberformat((1 - (val(getprofit.modal)/val(getprofit.sales)))*100,'.__')# %
</cfif>
</cfif>
</td>
</tr>

</cfif>
 <cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
<cfquery name="gettransactiondetail2" datasource="#dts#">
select * from ictran where refno='#url.nexttranno#' and type='#url.tran#' and itemcount = '1'
</cfquery>
<tr>
<th>Item Desp</th>
<td>#gettransactiondetail2.desp#</td>
</tr>
</cfif>
<cfif lcase(hcomid) eq "simplysiti_i">
 <tr>
<th>Last Print By</th>
<td>#gettransactiondetail.rem48#</td>
</tr>
 <tr>
<th>Last Print On</th>
<td><cfif isdate(gettransactiondetail.rem49)>#dateformat(gettransactiondetail.rem49,'dd/mm/yyyy')#</cfif></td>
</tr>
</cfif>

</table>

</cfoutput>
<cfif lcase(hcomid) eq "simplysiti_i" and (url.tran eq 'INV' or url.tran eq 'DO' or url.tran eq 'CS')>
<cfoutput>
<div align="center">
<iframe src="tran3c_simplysiti.cfm?nexttranno=#url.nexttranno#&tran=#url.tran#" name="simpltsiti" scrolling="no" width="900" height="250">
</iframe>
</div>
</cfoutput>
</cfif>
<div id="ajaxField">
</div> 
<cfwindow center="true" width="250" height="150" name="chooseformat" refreshOnShow="true" closable="true" modal="false" title="Choose Format" initshow="false"
        source="/default/transaction/emailformat.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" />
</body>
</html>
