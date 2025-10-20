<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "42,300,1099,1320,1870,506,759,29,2121,2161,1375,785,1095,23,6,39,892,403,2151,2160,965,48,67,849,851,11,2154,793,782,664,188,665,666,185,689,667,690,668,673,674,961,835,2151,721,718,719,720,722,723,724,980,692,726,725,727,728,2152,698,960,2153,745,694,748,1782,1849,813,696,814,815,816,817,818,819,820,821,822,697,698,749,106,704,16,702,29,703,40,795,752,441,300,753,506,475,754,759,1692,1358,695,757,65,887,668,781,784,783,892,785,786,787,788,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1716,1717,1288,705,706,10,3,808,848,2155,806,805,804">
<cfinclude template="/latest/words.cfm">


<cfif tran eq "INV">
	<cfset refnoname = words[666]>
<cfelseif tran eq "RC">
	<cfset refnoname = words[664]>
<cfelseif tran eq "PR">
	<cfset refnoname = words[188]>
<cfelseif tran eq "DO">
	<cfset refnoname = words[665]>
<cfelseif tran eq "CS">
	<cfset refnoname = words[185]>
<cfelseif tran eq "CN">
	<cfset refnoname = words[689]>
<cfelseif tran eq "DN">
	<cfset refnoname = words[667]>
<cfelseif tran eq "ISS">
	<cfset refnoname = "Issue">
<cfelseif tran eq "PO">
	<cfset refnoname = words[690]>
<cfelseif tran eq "SO">
	<cfset refnoname = words[673]>
<cfelseif tran eq "QUO">
	<cfset refnoname = words[668]>
<cfelseif tran eq "ASSM">
	<cfset refnoname = "Assembly">
<cfelseif tran eq "TR">
	<cfset refnoname = "Transfer">
<cfelseif tran eq "OAI">
	<cfset refnoname = "Adjustment Increase">
<cfelseif tran eq "OAR">
	<cfset refnoname = "Adjustment Reduce">
<cfelseif tran eq "SAM">
	<cfset refnoname = words[674]>
<cfelseif tran eq "RQ">
	<cfset refnoname = words[961]> 
<!---<cfelseif tran eq "ASSM">
	<cfset refnoname = "Assembly/Disassembly"> --->       
</cfif>


<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<script language="javascript" type="text/javascript">
	function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	} 
	
	function Popupfull(pageURL, title) {
		var left = (screen.width/2);
		var pageheight = (screen.height)-100;
		var targetWin = window.open (pageURL,title, 'scrollbars=yes,'+'width='+screen.width+', height='+pageheight+', top=0, left=0');
	} 
	
	</script>
<cfset thisPath = ExpandPath("/billformat/#dts#/*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>
<cfif DirectoryExists(thisDirectory) eq 'NO'>
<cftry>
	<cfdirectory action="create" directory="#thisDirectory#">
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/preprintedformat.cfm")#" destination="#thisDirectory#">
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/transactionformat.cfm")#" destination="#thisDirectory#">
   
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.0/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.1/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
	<p>Company directory has been created.</p>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>

<cfquery name="GetSetting" datasource="#dts#">
SELECT EDControl,printapprove,lQUO,lSO,priceminctrlemail FROM gsetup 
</cfquery>
<cfquery name="checkPrinted" datasource="#dts#">
SELECT printed,custno,printstatus,permitno,currrate,source FROM artran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#"> and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
</cfquery>




<cfif lcase(hcomid) eq "simplysiti_i">
<cfif url.tran eq "DO">
<cfif checkprinted.printed eq "Y">

<script type="text/javascript">
		alert('You Have Printed This Delivery Note Before')
</script>

</cfif>
</cfif>
</cfif>

<cfif lcase(hcomid) eq "haikhim_i" and url.tran eq "RQ" >
<cfinclude template="haikhimemail.cfm">

</cfif>




<cfquery name="checksendemailsetting" datasource="#dts#">
	SELECT * FROM gsetupemail
</cfquery>

<cfif checksendemailsetting.recordcount eq 0>
<cfquery name="insert" datasource="#dts#">
INSERT INTO gsetupemail (companyid) values ("IMS") 
</cfquery>
</cfif>


<cfif checksendemailsetting.recordcount eq 0 or evaluate('checksendemailsetting.Q#tran#') eq "Y">
<cfajaximport tags="cfform">

<cfwindow center="true" width="350" height="130" name="emailcontrol" refreshOnShow="true" closable="true" modal="true" title="Email Bills" initshow="true"
 source="/default/transaction/emailbills/emailbill.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" />

<cfwindow center="true" width="700" height="500" name="emailcontent" refreshOnShow="true" closable="true" modal="true" title="Email Content" initshow="false"
 source="/default/transaction/emailbills/emailcontent.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" />
<cfelse>

<cfajaximport tags="cfform">

<cfwindow center="true" width="350" height="130" name="emailcontrol" refreshOnShow="true" closable="true" modal="true" title="Email Bills" initshow="false"
 source="/default/transaction/emailbills/emailbill.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" />

<cfwindow center="true" width="700" height="500" name="emailcontent" refreshOnShow="true" closable="true" modal="true" title="Email Content" initshow="false"
 source="/default/transaction/emailbills/emailcontent.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" />

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

<cfif checkPrinted.printstatus neq 'a3' and url.tran eq 'QUO' and (lcase(hcomid) eq 'net_i' or lcase(hcomid) eq 'netindo_i')>
<cfif HuserID NEQ 'ultraprinesh'>
<cfajaximport tags="cfform">
        <cfwindow center="true" width="350" height="300" name="printpass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/printpass/printpassnet.cfm?type=#url.tran#&refno=#url.nexttranno#" />
</cfif>        
<cfelse>

</cfif>

<cfoutput>
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
                <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>
                <cfquery name="getweikenproject" datasource="#dts#">
                	select source from artran where refno='#url.nexttranno#' and type='#url.tran#'
                </cfquery>
                <cfquery name="getweikenplanning" datasource="#replace(dts,'_i','_c','all')#">
				SELECT * FROM planning WHERE project_id='#getweikenproject.source#'
                </cfquery>
                <cfif getweikenplanning.recordcount eq 0>
                <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="alert('Project has no planning')">
                    <font size="2"><strong><cfif getmodule.auto eq '1'>#words[3]# </cfif>#getformat.display_name#</strong></font></a>
                <cfelse>
                <a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&BillName=#getformat.file_name#&doption=#getformat.d_option#&counter=#getformat.counter#" target="_blank" <cfif getSetting.EDControl eq "Y"> onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif> >
                    
                    
                    <font size="2"><strong><cfif getmodule.auto eq '1'>#words[3]# </cfif>#getformat.display_name#</strong></font></a>
                </cfif>
                <cfelse>
               		<cfif dts EQ "ktycsb_i" AND getformat.file_name EQ "kty_i_iCBIL_SO_REP">
                    	<a href="../../billformat/#dts#/preprintedformat2.cfm?tran=#tran#&nexttranno=#nexttranno#&BillName=#getformat.file_name#&doption=#getformat.d_option#&counter=#getformat.counter#" target="_blank" <cfif getSetting.EDControl eq "Y"> onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif> >
                    <cfelse>
						<a href="../../billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#URLEncodedFormat(nexttranno)#&BillName=#getformat.file_name#&doption=#getformat.d_option#&counter=#getformat.counter#" target="_blank" <cfif getSetting.EDControl eq "Y"> onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif> >
                    </cfif>
                    <font size="2"><strong><cfif getmodule.auto eq '1'>#words[3]# </cfif>#getformat.display_name#</strong></font></a>
                    </cfif>
					<cfif thiscount neq maxcount><br><br></cfif>
				</div>
			</cfloop>
		<cfcatch type="any"> 
		</cfcatch>
		</cftry>
     
        <cfif getGeneralInfo.bcurr EQ 'IDR' AND tran eq "INV">
        	<br>
            <div align="center">
            	<a href="../../billformat/default/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&format=faktorPajak" target="_blank">
                	<font size="2"><strong>Faktur Pajak</strong></font>
                </a>
            </div>
            <br>
            <div align="center">
            	<a href="../../billformat/default/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&format=faktorPajakUSD" target="_blank">
                	<font size="2"><strong>Faktur Pajak (USD)</strong></font>
                </a>
            </div>
        </cfif>
		</td>
    	<td><div align="center"><a href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#nexttranno#" <cfif getSetting.EDControl eq "Y">onClick="ajaxFunction(window.document.getElementById('ajaxField'),'/default/transaction/examPass/updatePrint.cfm?tran=#tran#&nexttranno=#nexttranno#');"</cfif>><font size="2"><strong>
		
        <cfquery name="getGsetup" datasource="#dts#">
        	SELECT wpitemtax,compro6,bcurr 
            FROM gsetup
        </cfquery>
        
        <cfif getGsetup.wpitemtax EQ ''> 
            <cfif getGsetup.compro6 EQ 'Malaysia' OR getGsetup.bcurr EQ 'MYR'>
                <a href="../../billformat/default/newDefault/MYR/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&tax=1&GST=N" target="_blank">
                    <font size="2"><strong>PDF Format (NON GST Version)</strong></font>
                </a>
                <br />
            	<a href="../../billformat/default/newDefault/MYR/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&tax=1&GST=Y" target="_blank">
                	<font size="2"><strong>PDF Format (GST Version)</strong></font>
           		</a>
            <cfelse>
            	<a href="../../billformat/default/newDefault/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&tax=1" target="_blank">
                	<font size="2"><strong>PDF Format</strong></font>
            	</a>	    
            </cfif>
        <cfelse>            
            <cfif getGsetup.compro6 EQ 'Malaysia' OR getGsetup.bcurr EQ 'MYR'>
                <a href="../../billformat/default/newDefault/MYR/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&tax=2&GST=N" target="_blank">
                    <font size="2"><strong>PDF Format (NON GST Version)</strong></font>
                </a>
                <br />
            	<a href="../../billformat/default/newDefault/MYR/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&tax=2&GST=Y" target="_blank">
                	<font size="2"><strong>PDF Format (GST Version)</strong></font>
           		</a>
            <cfelse>
             	<a href="../../billformat/default/newDefault/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&tax=2" target="_blank">
                	<font size="2"><strong>PDF Format</strong></font>
            	</a>   
            </cfif>
            
        </cfif>
        <cfif tran eq "CS">
        		<br>
        		<a href="../../billformat/default/newDefault/preprintedformat.cfm?tran=#tran#&nexttranno=#nexttranno#&receipt=1" target="_blank">
                	<font size="2"><strong>Receipt</strong></font>
            	</a>  
        </cfif>
        <br/>
        <cfif lcase(hcomid) eq "bnbm_i" or lcase(hcomid) eq "bnbp_i" or lcase(hcomid) eq "jctpl_i" or lcase(hcomid) eq "fixics_i" or lcase(hcomid) eq "rpi270505_i">
        	<a href="/default/transaction/emailformat.cfm?tran=#tran#&nexttranno=#nexttranno#" target="_blank"><font size="2"><strong>Email Format</strong></font></a>
        </cfif>
        
        
        
        <br>
        
        <a style="cursor:pointer;" onClick="window.open('uploadfile.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>View Document</b></a>
        
        
        </div>
        
        </td>
        
  	</tr>
    <tr>
    <td colspan="100%"><hr></td>
    </tr>
    <tr align="center">
    <td>
    <a href="transaction.cfm?tran=#tran#" target="_self" >
					<font size="2"><b>#refnoname# #words[2151]#</b></font>
				</a>

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
                    <a href="javascript:void(0)" onClick="PopupCenter('editbillcontrol.cfm?tran=#tran#&refno=#nexttranno#&parentpage=no','linkname','300','150');"><font size="2"><b>#words[2155]#</b></font></a>
                    <cfelse>
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#nexttranno#&custno=#URLEncodedFormat(checkPrinted.custno)#<!--- &bcode=&dcode= --->&first=0"><font size="2"><b>#words[2155]#</b></font></a>
                    </cfif>
                    </cfif>
                    
                    
                </td>
          <td>

        	<b><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="ColdFusion.Window.show('emailcontent');"><img src="/images/email.png" height="20" width="20">&nbsp;Email Format</a></b>

           	
          </td> 
    </tr>

</table>
</cfif>

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
<table width="50%" border="0" cellspacing="0" cellpadding="0" align="center" class="data">
<tr>
<th colspan="2"><div align="center"><font size="+1"><strong>#words[2161]#</strong></font></div></th>
</tr>
<tr>
<th colspan="2"><hr></th>
</tr>
<tr>
<th width="250">#words[1375]#</th>
<td>#gettransactiondetail.refno#</td>
</tr>
<tr>
<th width="250">#words[785]#</th>
<td>#gettransactiondetail.currcode#</td>
</tr>
<tr>
<th>#words[1095]#</th>
<td>#gettransactiondetail.custno#</td>
</tr>
<tr>
<th>#words[23]#</th>
<td>#gettransactiondetail.name#</td>
</tr>
<tr>
<th>#words[6]#</th>
<td>#gettransactiondetail.frem2# #gettransactiondetail.frem3# <br> #gettransactiondetail.frem4# #gettransactiondetail.frem5# #gettransactiondetail.rem13#</td>
</tr>
<tr>
<th>#words[39]#</th>
<td>#gettransactiondetail.postalcode#</td>
</tr>
<tr>
<th>#words[892]#</th>
<td>#gettransactiondetail.rem2#</td>
</tr>
<th>#words[40]#</th>
<td>#gettransactiondetail.rem4#</td>
</tr>
<tr>
<th>#words[42]#</th>
<td>#getcustadd.phonea#</td>
</tr>
</tr>
<tr>
<th>#words[300]#</th>
<td>#gettransactiondetail.frem6#</td>
</tr>
<cfif url.tran eq 'PR' or url.tran eq 'PO' or url.tran eq 'RC' or url.tran eq 'RQ'>
<cfif getpin2.h1360 eq 'T'>
<tr>
<th>#words[1099]#</th>
<td>#numberformat(gettransactiondetail.tax_bil,',_.__')#</td>
</tr>
<tr>
<th>#words[1320]#</th>
<td>#numberformat(gettransactiondetail.grand_bil,',_.__')#</td>
</tr>
<tr>
<th>#words[1870]#</th>
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
<th>#words[1099]#</th>
<td>#numberformat(gettransactiondetail.tax_bil,',_.__')#</td>
</tr>
<tr>
<th>#words[1320]#</th>
<td>#numberformat(gettransactiondetail.grand_bil,',_.__')#</td>
</tr>
<tr>
<th>#words[1870]#</th>
<td>#numberformat(gettransactiondetail.currrate,',_.__')#</td>
</tr>
<tr>
<th>Local Amount</th>
<td>#numberformat(gettransactiondetail.grand,',_.__')#</td>
</tr>
</cfif>
</cfif>
<tr>
<th>#words[506]#</th>
<td>#gettransactiondetail.source#</td>
</tr>
<tr>
<th>#words[759]#</th>
<td>#gettransactiondetail.created_by#</td>
</tr>
<tr>
<th>#words[29]#</th>
<td>#gettransactiondetail.agenno#</td>
</tr>
<tr>
<th>#words[2121]#</th>
<td>#gettransactiondetail.voucher#</td>
</tr>
<cfif url.tran eq "CN" or url.tran eq "DN">
<tr>
<th>Reason</th>
<td>#gettransactiondetail.returnreason#</td>
</tr>
</cfif>
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


<cfif lcase(hcomid) eq "simplysiti_i" and (url.tran eq 'INV' or url.tran eq 'DO' or url.tran eq 'CS')>

<div align="center">
<iframe src="tran3c_simplysiti.cfm?nexttranno=#url.nexttranno#&tran=#url.tran#" name="simpltsiti" scrolling="no" width="900" height="250">
</iframe>
</div>

</cfif>
<div id="ajaxField">
</div> 
<cfwindow center="true" width="250" height="150" name="chooseformat" refreshOnShow="true" closable="true" modal="false" title="Choose Format" initshow="false"
        source="/default/transaction/emailformat.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" />
<!---<cfajaximport tags="cfform">
           	<cfwindow center="true" width="700" height="350" name="emailDetails" refreshOnShow="true" closable="true" modal="true" title="Email Details" initshow="false"
        source="" /> --->       
</body>
</html>
</cfoutput>