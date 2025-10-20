<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "48,67,849,851,11,2154,793,782,664,188,665,666,185,689,667,690,668,673,674,961,835,2151,721,718,719,720,722,723,724,980,692,726,725,727,728,2152,698,960,2153,745,694,748,1782,1849,813,696,814,815,816,817,818,819,820,821,822,697,698,749,106,704,16,702,29,703,40,795,752,441,300,753,506,475,754,759,1692,1358,695,757,65,887,668,781,784,783,892,785,786,787,788,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1716,1717,1288,705,706,10,3,808,848,2155,806,805,804">
<cfinclude template="/latest/words.cfm">

<cfparam name="alcreate" default="0">
<cfparam name="aledit" default="0">
<cfparam name="aldelete" default="0">
<cfparam name="alown" default="0">
<cfparam name="alsimple" default="0">

<cfif not isdefined('form.searchtype')>
<cfset form.searchtype='refno'>
<cfset searchtype='refno'>
</cfif>

<cfif not isdefined('form.searchstr')>
<cfset form.searchstr=''>
<cfset searchstr=''>
</cfif>

<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>
<cfquery datasource="#dts#" name="getGeneralInfo">
	Select *
	from GSetup
</cfquery>

<cfquery name="getremarkdetail" datasource="#dts#">
	select * 
	from extraremark;
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>

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

<cfif tran eq "RC">
  	<cfset tran = "RC">
  	<cfset tranname = words[664]>
  	<cfset trancode = "rcno">
  	<cfset tranarun = "rcarun">

	<cfif getpin2.h2102 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2892 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2103 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2104 eq 'T'>
  		<cfset aldelete = 1>
  	</cfif>

	<cfif getpin2.h2105 eq 'T'>
  		<cfset alown = 1>
  	</cfif>
    
    <cfif getpin2.h2108 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
    
</cfif>

<cfif tran eq "PR">
	<cfset tran = "PR">
	<cfset tranname = words[188]>
	<cfset trancode = "prno">
	<cfset tranarun = "prarun">

	<cfif getpin2.h2201 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
	
    <cfif getpin2.h2893 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
	
	<cfif getpin2.h2202 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2203 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2204 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2207 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "DO">
	<cfset tran = "DO">
	<cfset tranname = words[665]>
	<cfset trancode = "dono">
	<cfset tranarun = "doarun">

	<cfif getpin2.h2301 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2894 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2302 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2303 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2304 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2308 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "INV">
	<cfset tran = "INV">
	<cfset tranname = words[666]>
	<cfset trancode = "invno">
	<cfset tranarun = "invarun">

	<cfif getpin2.h2401 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2891 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2402 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2403 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2404 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2407 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "CS">
	<cfset tran = "CS">
	<cfset tranname = words[185]>
	<cfset trancode = "csno">
	<cfset tranarun = "csarun">

	<cfif getpin2.h2501 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2895 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2502 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2503 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2504 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2507 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "CN">
	<cfset tran = "CN">
	<cfset tranname = words[689]>
	<cfset trancode = "cnno">
	<cfset tranarun = "cnarun">

	<cfif getpin2.h2601 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2896 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2602 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2603 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2604 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2607 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "DN">
	<cfset tran = "DN">
	<cfset tranname = words[667]>
	<cfset trancode = "dnno">
	<cfset tranarun = "dnarun">

	<cfif getpin2.h2701 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2897 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2702 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2703 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2704 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2707 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "PO">
	<cfset tran = "PO">
	<cfset tranname = words[690]>
	<cfset trancode = "pono">
	<cfset tranarun = "poarun">

	<cfif getpin2.h2861 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>

	<cfif getpin2.h2862 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
    
    <cfif getpin2.h2899 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2863 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2864 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2869 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "QUO">
	<cfset tran = "QUO">
	<cfset tranname = words[668]>
	<cfset trancode = "quono">
	<cfset tranarun = "quoarun">

	<cfif getpin2.h2871 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h289B eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2872 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2873 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2874 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h287C eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "SO">
	<cfset tran = "SO">
	<cfset tranname = words[673]>
	<cfset trancode = "sono">
	<cfset tranarun = "soarun">

	<cfif getpin2.h2881 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h289A eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2882 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2883 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2884 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h288A eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "SAM">
	<cfset tran = "SAM">
	<cfset tranname = words[674]>
	<cfset trancode = "samno">
	<cfset tranarun = "samarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h289D eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2852 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2853 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2854 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h2858 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "RQ">
	<cfset tran = "RQ">
	<cfset tranname = words[961]>
	<cfset trancode = "rqno">
	<cfset tranarun = "rqarun">

	<cfif getpin2.h28G1 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2899 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h28G2 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h28G3 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h28G4 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
    
    <cfif getpin2.h28G1 eq 'T'>
  		<cfset alsimple = 1>
  	</cfif>
</cfif>

<cfif tran eq "SAMM" and lcase(hcomid) eq "hunting_i">
	<cfset tran = "SAMM">
	<cfset tranname = "Sales Order">
	<cfset trancode = "sammno">
	<cfset tranarun = "sammarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>

	<cfif getpin2.h2852 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2853 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2854 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
</cfif>

<html>
<head>
<cfoutput>
<title>Search #tranname#</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery datasource="#dts#" name="getGeneralInfo">
	Select *,#trancode# as tranno
	from GSetup
</cfquery>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">



<body>
	<h1>#words[11]# #tranname#</h1>
	<h4>
	<cfif alcreate eq 1>
			<cfif (lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i") and tran eq 'SAM'>
         			<a href="servicededuction.cfm">Create New #tranname#</a> || 
			<cfelse>
				<cfif getgeneralinfo.invoneset neq '1' and tran eq 'INV'>
					<a href="transaction0.cfm?tran=#tran#">#words[721]#</a>
				<cfelseif getgeneralinfo.rc_oneset neq '1' and tran eq 'RC'>
					<a href="transaction0.cfm?tran=#tran#">#words[718]#</a>
				<cfelseif getgeneralinfo.pr_oneset neq '1' and tran eq 'PR'>
					<a href="transaction0.cfm?tran=#tran#">#words[719]#</a>
				<cfelseif getgeneralinfo.do_oneset neq '1' and tran eq 'DO'>
					<a href="transaction0.cfm?tran=#tran#">#words[720]#</a>
				<cfelseif getgeneralinfo.cs_oneset neq '1' and tran eq 'CS'>
					<a href="transaction0.cfm?tran=#tran#">#words[722]#</a>
				<cfelseif getgeneralinfo.cn_oneset neq '1' and tran eq 'CN'>
					<a href="transaction0.cfm?tran=#tran#">#words[723]#</a>
				<cfelseif getgeneralinfo.dn_oneset neq '1' and tran eq 'DN'>
					<a href="transaction0.cfm?tran=#tran#">#words[724]#</a>
				<cfelseif getgeneralinfo.iss_oneset neq '1' and tran eq 'ISS'>
					<a href="transaction0.cfm?tran=#tran#">#words[980]#</a>
				<cfelseif getgeneralinfo.po_oneset neq '1' and tran eq 'PO'>
					<a href="transaction0.cfm?tran=#tran#">#words[692]#</a>
				<cfelseif getgeneralinfo.so_oneset neq '1' and tran eq 'SO'>
					<a href="transaction0.cfm?tran=#tran#">#words[726]#</a>
				<cfelseif getgeneralinfo.quo_oneset neq '1' and tran eq 'QUO'>
					<a href="transaction0.cfm?tran=#tran#">#words[725]#</a>
				<cfelseif getgeneralinfo.sam_oneset neq '1' and tran eq 'SAM'>
					<a href="transaction0.cfm?tran=#tran#">#words[727]#</a>
                <cfelseif getgeneralinfo.rq_oneset neq '1' and tran eq 'RQ'>
					<a href="transaction0.cfm?tran=#tran#">#words[728]#</a>    
				<cfelse>
					<a href="transaction1.cfm?ttype=create&tran=#tran#&nexttranno=&first=0">#words[2152]# #tranname#</a>
				</cfif> || 
			</cfif>		
		</cfif>
		<a href="stransaction.cfm?tran=#tran#&searchtype=&searchstr=">#words[698]# #tranname#</a>
		<!---<cfif tran eq "SO" and hcomid eq "MSD">
		|| <a href="transaction_report.cfm?type=10">#tranname# Reports</a>
		</cfif>--->
        <cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" <!---or lcase(hcomid) eq "lkatlb_i"--->
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
                <cfelse>
        <cfif tran eq "QUO" or tran eq "SO">
        ||<a href="closequo.cfm?tran=#tran#">#words[960]# #tranname#</a>
        ||<a href="unclosequo.cfm?tran=#tran#">#words[2153]# #tranname#</a>
        </cfif>
        </cfif>
         <cfif lcase(HcomID) eq "solidlogic_i"> || <a href="/default/transaction/printUnprint/printUnprint.cfm?tran=#tran#">Print Unprint #tranname#</a></cfif>

         <cfif getmodule.simpletran eq 1>
         <cfif alsimple eq 1>
         <cfif tran eq 'INV'>

         <cfif getmodule.auto eq "1">
         <cfelse>
         <cfif lcase(HcomID) eq "tranz_i">
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expresstranzplus/index.cfm?first=true&type=#tran#','','fullscreen=yes,scrollbars=yes')">
				#words[745]#
			</a>
         <cfelseif lcase(HcomID) eq "eocean_i">
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expresstraneocean/index.cfm?first=true&type=#tran#','','fullscreen=yes,scrollbars=yes')">
				#words[694]#
			</a>
         <cfelse>
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expresstran/index.cfm?first=true&type=#tran#','','fullscreen=yes,scrollbars=yes')">
				#words[694]#
			</a>
         </cfif>
          </cfif>
         
         <cfelseif lcase(HcomID) eq "ugateway_i" and tran eq "SO">
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expressSO/index.cfm?first=true','','fullscreen=yes,scrollbars=yes')">
				#words[694]# SO
			</a>
         <cfelseif getmodule.auto eq "1" and (tran eq 'SO' or tran eq 'CN')>
         
        
         <cfelse>
         <cfif lcase(HcomID) eq "tranz_i">
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expresstranzplus/index.cfm?first=true&type=#tran#','','fullscreen=yes,scrollbars=yes')">
				#words[745]#
			</a>
         <cfelseif lcase(HcomID) eq "eocean_i">
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expresstraneocean/index.cfm?first=true&type=#tran#','','fullscreen=yes,scrollbars=yes')">
				#words[694]#
			</a>
         <cfelse>
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expresstran/index.cfm?first=true&type=#tran#','','fullscreen=yes,scrollbars=yes')">
				#words[694]#
			</a>
         </cfif>
         </cfif>
         </cfif>
         </cfif>
         
          <cfif (lcase(HcomID) eq "atc2000_i" or lcase(HcomID) eq "atc2005_i") and (tran eq 'SO')>
         || <a href="/default/transaction/expressatc/searchmember.cfm" target="mainFrame">
         Cake Order
         </a></cfif>
         <cfif getmodule.matrixtran eq 1>
         <cfif alcreate eq 1>
         || <a href="transaction.cfm?tran=#tran#" target="mainFrame" onClick="window.open('/default/transaction/matrixexpressbill/index.cfm?first=true&tran=#tran#','','fullscreen=yes,scrollbars=yes')">
				#words[748]#
			</a>
         </cfif>
         </cfif>
         
         
         <cfif getmodule.auto eq "1" and (tran eq 'SO' or tran eq 'INV' or tran eq 'CN')>
         <cfif alsimple eq 1>
         <cfif lcase(HcomID) eq "ltm_i" or lcase(HcomID) eq "netilung_i" or lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i" or lcase(hcomid) eq "netivan_i">
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/vehicletran/index.cfm?first=true&tran=#tran#','','fullscreen=yes,scrollbars=yes')">
			New #tranname#
			</a>
         <cfelse>
         || <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/newvehicletran/index.cfm?first=true&tran=#tran#','','fullscreen=yes,scrollbars=yes')">
			New #tranname#
			</a>
         </cfif>
         </cfif>
         </cfif>

		<cfif tran EQ 'PO' OR tran EQ 'RC' OR tran EQ 'PR' OR
			  tran EQ 'QUO' OR tran EQ 'SO' OR tran EQ 'DO' OR tran EQ 'INV' OR tran EQ 'CS' OR tran EQ 'CN' OR tran EQ 'DN'>
         || <a href="/latest/transaction/simpleTransaction/simpleTransaction.cfm?action=Create&type=#tran#" target="mainFrame" >
            #words[1782]# (Beta!)
            </a>
         </cfif>
         
	</h4>
<br>
<cfif tran eq "DO">
			<cfif getpin2.h2305 eq 'T'>
				<h2><a href="update/update.cfm?t1=DO&t2=INV"><img src="../../images/arrow.png" alt="Update to Invoice" name="updateBtn" border="0">#words[813]#</a></h2>
			</cfif>
  </cfif>
		<cfif tran eq "PO">
		<h2>
			<cfif getpin2.h2865 eq 'T'>
				<a href="update/update.cfm?t1=PO&t2=RC"><img src="../../images/arrow.png" alt="Update to Purchase Receive" name="updateBtn2" border="0">#words[696]#</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</cfif>

			<cfif getpin2.h2866 eq 'T'>
				<a href="update/update.cfm?t1=PO&t2=INV"><img src="../../images/arrow.png" alt="Update to Invoice" name="updateBtn3" border="0">#words[813]#</a>			
			</cfif>
		</h2>
		</cfif>
        <cfif tran eq "RQ">
		<h2>
			<cfif getpin2.h28G5 eq 'T'>
				<a href="update/updateA.cfm?t1=RQ&t2=PO"><img src="../../images/arrow.png" alt="Update to Purchase Order" name="updateBtn4" border="0">#words[814]#</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</cfif>
        </h2>
        </cfif>
        
		<cfif tran eq "SO">
		<h2>
			<cfif getpin2.h2885 eq 'T'>
				<a href="update/update.cfm?t1=SO&t2=DO"><img src="../../images/arrow.png" alt="Update to Delivery Order" name="updateBtn4" border="0">#words[815]#</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</cfif>

			<cfif getpin2.h2886 eq 'T'>
				<cfif lcase(hcomid) eq "solidlogic_i">
					<a href="update/s_update.cfm?t1=SO&t2=INV"><img src="../../images/arrow.png" alt="Update to Invoice" name="updateBtn5" border="0">#words[813]#</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<cfelse>
					<a href="update/update.cfm?t1=SO&t2=INV"><img src="../../images/arrow.png" alt="Update to Invoice" name="updateBtn5" border="0">#words[813]#</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</cfif>
			</cfif>

			<cfif getpin2.h2887 eq 'T'>
			<a href="update/update.cfm?t1=SO&t2=PO"><img src="../../images/arrow.png" alt="Update to Purchase Order" name="updateBtn6" border="0">#words[814]#</a>
            <a href="update/update.cfm?t1=SO&t2=RC"><img src="../../images/arrow.png" alt="Update to Purchase Receive" name="updateBtn6" border="0">#words[696]#</a>
            <a href="update/update.cfm?t1=SO&t2=RQ"><img src="../../images/arrow.png" alt="Update to Purchase requisition " name="updateBtn6" border="0">#words[816]#</a>
            
               
			</cfif>
            <cfif getpin2.h2887 eq 'T' and (lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "atc2005_i") >
            <a href="update/s_update.cfm?t1=SO&t2=SAM"><img src="../../images/arrow.png" alt="Update to Invoice" name="updateBtn5" border="0"> Update To Work Order (Sample)</a>&nbsp;&nbsp;&nbsp;&nbsp;
            </cfif>
            <cfif getpin2.h2887 eq 'T' and (lcase(hcomid) eq "asaiki_i") >
            <a href="update/s_update.cfm?t1=SO&t2=SAM"><img src="../../images/arrow.png" alt="Update to Invoice" name="updateBtn5" border="0"> Update To Packinglist (Sample)</a>&nbsp;&nbsp;&nbsp;&nbsp;
            </cfif>
            
            <cfif getpin2.H2879 eq 'T'>
				<a href="update/update.cfm?t1=SO&t2=CS"><img src="../../images/arrow.png" alt="Update to Cash Sales" name="updateBtn8" border="0">#words[819]#</a>
			</cfif>
		</h2>
		</cfif>
		<cfif tran eq "QUO">
		<h2>
			<cfif getpin2.h2875 eq 'T'>
				<a href="update/update.cfm?t1=QUO&t2=SO"><img src="../../images/arrow.png" alt="Update to Sales Order" name="updateBtn7" border="0">#words[820]#</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</cfif>
			
			<cfif getpin2.H2877 eq 'T'>
				<a href="update/update.cfm?t1=QUO&t2=DO"><img src="../../images/arrow.png" alt="Update to Delivery Order" name="updateBtn8" border="0">#words[815]#</a>
			</cfif>

			<cfif getpin2.h2876 eq 'T'>
				<a href="update/update.cfm?t1=QUO&t2=INV"><img src="../../images/arrow.png" alt="Update to Invoice" name="updateBtn8" border="0">#words[813]#</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</cfif>
			
			<cfif getpin2.H2878 eq 'T'>
				<a href="update/update.cfm?t1=QUO&t2=PO"><img src="../../images/arrow.png" alt="Update to Purchase Order" name="updateBtn8" border="0">#words[814]#</a>
			</cfif>
			
			<cfif getpin2.H2879 eq 'T'>
				<a href="update/update.cfm?t1=QUO&t2=CS"><img src="../../images/arrow.png" alt="Update to Cash Sales" name="updateBtn8" border="0">#words[819]#</a>
			</cfif>
		</h2>
		</cfif>
        <cfif tran eq "SAM">
			<cfif getpin2.H2855 eq 'T'>
				<h2><a href="update/update.cfm?t1=SAM&t2=SO"><img src="/images/arrow.png" alt="Update to Invoice" name="updateBtn" border="0">#words[820]#</a>&nbsp;&nbsp;<a href="update/update.cfm?t1=SAM&t2=DO"><img src="/images/arrow.png" alt="Update to Invoice" name="updateBtn" border="0"> #words[815]#</a></h2>
			</cfif>
		</cfif>
        <cfif tran eq "SAMM">
			<cfif getpin2.H2855 eq 'T'>
				<h2><a href="update/update.cfm?t1=SAMM&t2=QUO"><img src="/images/arrow.png" alt="Update to Quotation" name="updateBtn" border="0">#words[821]#</a><!--- &nbsp;&nbsp;<a href="update/update.cfm?t1=SAM&t2=DO"><img src="/images/arrow.png" alt="Update to Invoice" name="updateBtn" border="0"> Update To #getGeneralInfo1.lDO#</a> ---></h2>
			</cfif>
		</cfif>
        <cfif tran eq "RC" and hcomid eq "asiasoft_i">
        <h2><a href="/default/transaction/rctoinv/list.cfm" target="_blank"><img src="/images/arrow.png" alt="Update to Invoice" name="updateBtn" border="0">#words[813]#</a><!--- &nbsp;&nbsp;<a href="update/update.cfm?t1=SAM&t2=DO"><img src="/images/arrow.png" alt="Update to Invoice" name="updateBtn" border="0"> Update To #getGeneralInfo1.lDO#</a> ---></h2>
        </cfif>
        <cfif lcase(hcomid) eq "fixics_i">
        <cfif tran eq "INV" or tran eq "DO" or tran eq "QUO">
        	<h2><a href="update/Fixicsupdate.cfm?t1=#tran#"><img src="/images/arrow.png" alt="Update to Ticket" name="updateBtn" border="0">#words[822]#</a></h2>
        </cfif>
        </cfif>


<form action="stransaction.cfm" method="post">
	<h1>#words[697]# :
	<select name="searchType" id="searchType" onChange="if(document.getElementById('searchType').options[document.getElementById('searchType').selectedIndex].value=='status'){document.getElementById('searchStr').value='updated'}else{document.getElementById('searchStr').value=''}">
    	<cfif getmodule.auto eq "1">
        <option value="rem5" selected>#words[749]#</option>
        <cfif getGeneralInfo.rem11 neq ''>
        <option value="rem11">#getGeneralInfo.rem11#</option>
        </cfif>
        <option value="refno">#tranname# No</option>
        
		<option value="refno2">#getGeneralInfo.refno2#</option>
		<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
			<option value="custno">#words[106]#</option>
			<option value="name">#words[704]#</option>
		<cfelse>
			<option value="custno">#words[16]#</option>
			<option value="name" >#words[782]#</option>
		</cfif>
        
		<option value="agenno"><cfoutput>#words[29]#</cfoutput></option>
		<option value="fperiod" >#words[703]#</option>
		<option value="rem4" >#words[40]#</option>
        <option value="wos_date" >#words[702]# (DDMMYYYY)</option>
        <option value="pono">#words[795]#</option>
        <option value="sono" >#words[752]#</option>
        <option value="phonea" >#words[441]#</option>
        <option value="frem6" >#words[300]#</option>
        <option value="allphone" >#words[753]#</option>
        <option value="source" >#words[506]#</option>
        <option value="job" >#words[475]#</option>
        <option value="status">#words[754]#</option>
        <option value="created_by" <cfif getGeneralInfo.ddltran eq "created_by">selected</cfif>>#words[759]#</option>
        <cfif lcase(hcomid) eq "ltm_i">
        <option value="rem45">Status</option>
        </cfif>
        
        <cfelse>
        
		<option value="refno" <cfif getGeneralInfo.ddltran eq "Refno">selected</cfif>>#tranname# No</option>
		<option value="refno2" <cfif getGeneralInfo.ddltran eq "Refno2">selected</cfif>>#words[1692]#</option>
		<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
			<option value="custno" <cfif getGeneralInfo.ddltran eq "Supplier/Customer ID">selected</cfif>>#words[106]#</option>
			<option value="name" <cfif getGeneralInfo.ddltran eq "Supplier/Customer Name">selected</cfif>>#words[704]#</option>
		<cfelse>
			<option value="custno" <cfif getGeneralInfo.ddltran eq "Supplier/Customer ID">selected</cfif>>#words[16]#</option>
			<option value="name" <cfif getGeneralInfo.ddltran eq "Supplier/Customer Name">selected</cfif>>#words[782]#</option>
		</cfif>
        <cfif lcase(hcomid) eq 'thats_i'>
        <option value="no">PRC no</option>
        <option value="work">Work Order</option>
        </cfif>
		<option value="agenno" <cfif getGeneralInfo.ddltran eq "Agent">selected</cfif>>#words[29]#</option>
		<option value="fperiod" <cfif getGeneralInfo.ddltran eq "Period">selected</cfif>>#words[703]#</option>
		<option value="rem4" <cfif getGeneralInfo.ddltran eq "Phone">selected</cfif>>#words[40]#</option>
		<cfif checkcustom.customcompany eq "Y">
			<option value="rem5">Permit Number</option>
		</cfif>
        <option value="wos_date" <cfif getGeneralInfo.ddltran eq "Date">selected</cfif>>#words[702]# (DDMMYYYY)</option>
        <option value="pono" <cfif lcase(hcomid) eq "netsource_i" and tran eq "RC">selected</cfif>>#words[795]#</option>
        <option value="quono" >#words[668]#</option>
        <option value="sono" >#words[752]#</option>
        <option value="dono" >#words[793]#</option>
        <option value="phonea" >#words[441]#</option>
        <option value="frem6" >#words[300]#</option>
        <option value="allphone" >#words[753]#</option>
        <option value="source" >#words[506]#</option>
        <option value="job" >#words[475]#</option>
        <option value="void" >#words[695]#</option>
        <option value="van" >#words[1358]#</option>
        <option value="status">#words[754]#</option>
        <option value="LeftName" <cfif getGeneralInfo.ddltran eq "Left Name">selected</cfif>>#words[757]#</option>
        <cfif lcase(hcomid) eq "powernas_i" or lcase(hcomid) eq "acerich_i">
        <option value="brem2">CERTIFICATE NUMBER</option>
        </cfif>
        <cfif lcase(hcomid) eq "ascend_i" or lcase(hcomid) eq "hodaka_i">
        <option value="rem6">#getGeneralInfo.rem6#</option>
        </cfif>
        <option value="rem30">#getremarkdetail.rem30#</option>
        <option value="rem31">#getremarkdetail.rem31#</option>
        <option value="rem32">#getremarkdetail.rem32#</option>
        <option value="created_by" <cfif getGeneralInfo.ddltran eq "created_by">selected</cfif>>#words[759]#</option>
        </cfif>
        
        <cfif tran EQ "CS" AND (dts EQ "Charliecare_i" OR dts EQ "twofitcommunication_i")>
        	<option value="frem2">Delivery Address</option>
        </cfif>
	</select>
		
	<input type="hidden" name="tran" id="tran" value="#tran#"> 
	#words[698]# :

    <input type="text" name="searchStr" id="searchStr" value="">

		<input type="submit" name="submit" value="#words[11]#"> 
    </h1>
</form>

<cfif isdefined("form.searchStr")>	
<cfif form.searchType eq 'wos_date'>
<cfset form.searchStr =right(form.searchStr,4)&'-'&mid(form.searchStr,3,2)&'-'&left(form.searchStr,2)>
</cfif>
	<cfquery name="getrecordcount" datasource="#dts#">
		select count(refno) as totalsimilarrecord
		from artran 
		where type='#tran#' and <cfif form.searchType eq 'brem2'>refno in (select refno from ictran where brem2 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> and type='#tran#')<cfelseif form.searchType eq 'allphone'>
		(rem4 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> or
        frem6 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> or
        phonea like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> or
        rem12 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> or
        comm4 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%">
        )
        <cfelseif form.searchType eq "status"><cfif searchStr eq 'updated'>toinv<>''<cfelseif searchStr eq 'approved'>printstatus ='a3'<cfelse>(toinv='' or toinv is null)</cfif>
		<cfelseif form.searchType eq "leftname">name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.searchStr#%"><cfelse>#searchtype# like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"></cfif>
		<cfif alown eq 1>
		<cfif getGeneralInfo.agentlistuserid eq "Y">and (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%") or ucase(userid)='#ucase(huserid)#')
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
			</cfif>
		</cfif>
	</cfquery>
	
	<cfif getrecordcount.totalsimilarrecord neq 0>
		<h2>#words[851]#</h2>
		<iframe align="middle" scrolling="auto" frameborder="0" width="100%" height="700" src="stransaction_similar.cfm?tran=#urlencodedformat(tran)#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#"></iframe>
	<cfelse>
		<h3>No #words[851]# Found !</h3>
	</cfif>
	
	<h2>#words[849]#</h2>
	<iframe align="middle" scrolling="auto" frameborder="0" width="100%" height="700" src="stransaction_newest.cfm?tran=#urlencodedformat(tran)#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#"></iframe>
<cfelse>
	<h2>#words[849]#</h2>
	<iframe align="middle" scrolling="auto" frameborder="0" width="100%" height="700" src="stransaction_newest.cfm?tran=#urlencodedformat(tran)#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#"></iframe>
</cfif>

</cfoutput>

</body>
</html>