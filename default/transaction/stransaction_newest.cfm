<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "972,900,1091,969,971,48,67,2154,793,782,664,188,665,666,185,689,667,690,668,673,674,961,835,2151,721,718,719,720,722,723,724,980,692,726,725,727,728,2152,698,960,2153,745,694,748,1782,1849,813,696,814,815,816,817,818,819,820,821,822,697,698,749,106,704,16,702,29,703,40,795,752,441,300,753,506,475,754,759,1692,1358,695,757,65,887,668,781,784,783,892,785,786,787,788,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1716,1717,1288,705,706,10,3,808,848,2155,806,805,804">
<cfinclude template="/latest/words.cfm">

<cfparam name="alcreate" default="0">
<cfparam name="aledit" default="0">
<cfparam name="aldelete" default="0">
<cfparam name="alown" default="0">
<cfparam name="alcopy" default="0">

<cfquery name="getmodule" datasource="#dts#">
    SELECT * 
    FROM modulecontrol
</cfquery>
<cfswitch expression="#tran#">
	<cfcase value="RC,PR" delimiters=",">
		<cfset target_table= target_apvend>
	</cfcase>
	<cfdefaultcase>
		<cfset target_table= target_arcust>
	</cfdefaultcase>
</cfswitch>

<cfquery datasource="#dts#" name="getGeneralInfo1">
	SELECT *
	FROM GSetup;
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    SELECT * 
    FROM displaysetup
</cfquery>

<cfquery name="getremarkdetail" datasource="#dts#">
	SELECT * 
	FROM extraremark;
</cfquery>

<cfif tran eq "RC">
	<cfset tran = "RC">
	<cfset tranname = getGeneralInfo1.lRC>
	<cfset trancode = "rcno">
	
	<cfif getpin2.h2102 eq "T">
  		<cfset alcreate = 1>
	</cfif>

	<cfif getpin2.h2103 eq "T">
  		<cfset aledit = 1>
	</cfif>
    
    <cfif getpin2.h2892 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>

	<cfif getpin2.h2104 eq "T">
  		<cfset aldelete = 1>
	</cfif>

	<cfif getpin2.h2105 eq "T">
  		<cfset alown = 1>
	</cfif>
</cfif>

<cfif tran eq "PR">
	<cfset tran = "PR">
	<cfset tranname = getGeneralInfo1.lPR>
	<cfset trancode = "prno">
	
	<cfif getpin2.h2201 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2202 eq "T">
  		<cfset aledit = 1>
  	</cfif>
    
    <cfif getpin2.h2893 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h2203 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2204 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "DO">
	<cfset tran = "DO">
	<cfset tranname = getGeneralInfo1.lDO>
	<cfset trancode = "dono">
	
	<cfif getpin2.h2301 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2894 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h2302 eq "T">
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h2303 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2304 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "INV">
	<cfset tran = "INV">
	<cfset tranname = getGeneralInfo1.lINV>
	<cfset trancode = "invno">
	
	<cfif getpin2.h2401 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
    
    <cfif getpin2.h2891 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h2402 eq "T">
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h2403 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2404 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "CS">
	<cfset tran = "CS">
	<cfset tranname = getGeneralInfo1.lCS>
	<cfset trancode = "csno">
	
	<cfif getpin2.h2501 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2502 eq "T">
  		<cfset aledit = 1>
  	</cfif>
    
    <cfif getpin2.h2895 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h2503 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2504 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "CN">
	<cfset tran = "CN">
	<cfset tranname = getGeneralInfo1.lCN>
	<cfset trancode = "cnno">
	
	<cfif getpin2.h2601 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2602 eq "T">
  		<cfset aledit = 1>
  	</cfif>
    
    <cfif getpin2.h2896 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h2603 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2604 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "DN">
	<cfset tran = "DN">
	<cfset tranname = getGeneralInfo1.lDN>
	<cfset trancode = "dnno">
	
	<cfif getpin2.h2701 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2702 eq "T">
  		<cfset aledit = 1>
  	</cfif>
  	
    <cfif getpin2.h2897 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
    
	<cfif getpin2.h2703 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2704 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "PO">
	<cfset tran = "PO">
	<cfset tranname = getGeneralInfo1.lPO>
	<cfset trancode = "pono">
	
	<cfif getpin2.h2861 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2862 eq "T">
  		<cfset aledit = 1>
  	</cfif>
    <cfif getpin2.h2899 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h2863 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2864 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "RQ">
	<cfset tran = "RQ">
	<cfset tranname = getGeneralInfo1.lRQ>
	<cfset trancode = "rqno">
	
	<cfif getpin2.h28G1 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h28G2 eq "T">
  		<cfset aledit = 1>
  	</cfif>
    
    <cfif getpin2.h2899 eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h28G3 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h28G4 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "QUO">
	<cfset tran = "QUO">
	<cfset tranname = getGeneralInfo1.lQUO>
	<cfset trancode = "quono">
	
	<cfif getpin2.h2871 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	<cfif getpin2.h2872 eq "T">
  		<cfset aledit = 1>
  	</cfif>
    <cfif getpin2.h289B eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
    
  	<cfif getpin2.h2873 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	<cfif getpin2.h2874 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "SO">
	<cfset tran = "SO">
	<cfset tranname = getGeneralInfo1.lSO>
	<cfset trancode = "sono">
	
	<cfif getpin2.h2881 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2882 eq "T">
  		<cfset aledit = 1>
  	</cfif>
    
    <cfif getpin2.h289A eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
  	
	<cfif getpin2.h2883 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2884 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "SAM">
	<cfset tran = "SAM">
	<cfset tranname = getGeneralInfo1.lSAM>
	<cfset trancode = "samno">
	<cfset tranarun = "samarun">
	
	<cfif getpin2.h2851 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
    <cfif getpin2.h289D eq 'T'>
  		<cfset alcopy = 1>
  	</cfif>
    
	<cfif getpin2.h2852 eq "T">
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h2853 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2854 eq "T">
  		<cfset alown = 1>
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
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript">
	function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	} 
</script>
</head>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery datasource="#dts#" name="getGeneralInfo">
	select 
	delinvoice,
	invsecure,
	printoption,
	invoneset,ldriver ,agentlistuserid,poapproval,rqapproval
	
		,generateQuoRevision,revStyle,generateQuoRevision1,editbillpassword,editbillpassword1

	from gsetup;
</cfquery>

<!--- Add On 11-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
</cfquery>

<!--- <cfquery name="getrecordcount" datasource="#dts#">
	select count(refno) as totalrecord from artran 
	where type='#tran#' 
	<cfif alown eq 1>
	and (userid='#huserid#' or ucase(agenno)='#ucase(huserid)#')
	</cfif>
	;
</cfquery> --->
<cfquery name="getrecordcount" datasource="#dts#">
	select count(refno) as totalrecord from artran 
	where type='#tran#' 
	<cfif alown eq 1>
		<cfif getGeneralInfo.agentlistuserid eq "Y">and (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%") or ucase(userid)='#ucase(huserid)#')
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
			</cfif>
	<cfelse>
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Van Sales')>
    <cfelse>
		<cfif Huserloc neq "All_loc">
			and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
		</cfif>
    </cfif>
	</cfif>
</cfquery>

<body>

<cfif getrecordcount.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		<cfif getrecordcount.recordcount mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="FF0000">#words[971]#</font></h3>
			<cfabort>
		</cfif>
 	</cfif>
	
	<cfform action="stransaction_newest.cfm?tran=#urlencodedformat(tran)#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#" method="post" target="_self">
		<div align="right">#words[1091]# <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		<input type="submit" name="submit" id="submit" value="go" >
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		
		<cfif getrecordcount.totalrecord mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif isdefined("url.start")>
			<cfset start = url.start>
		</cfif>
		
		<cfif isdefined("form.skeypage")>
			<cfset start = form.skeypage * 20 + 1 - 20>
			<cfif form.skeypage eq "1">
				<cfset start = "1">
			</cfif>
		</cfif>

		<cfset prevTwenty = start -20>
		<cfset nextTwenty = start +20>
		<cfset page = round(nextTwenty/20)>
		
		<cfif lcase(hcomid) eq "ovas_i" and (tran eq "CS" or tran eq "DO" or tran eq "SO" or tran eq "SAM" or tran eq "CN" or tran eq "DN")>
			<cfquery datasource='#dts#' name="getjob">
				select
                artran.rem49, 
				artran.type,
				artran.refno,
                artran.desp,
                artran.sono,
				artran.refno2,
                artran.rem2,
                artran.frem1,
                <cfif lcase(hcomid) eq "fixics_i">
                artran.ticket,
        		</cfif>
                artran.rem3,
                artran.created_by,
				artran.agenno,
                artran.job,
                artran.permitno,
                artran.cs_pm_debt,
            artran.van,
            artran.currcode,
            artran.term,
            artran.grand_bil,
            artran.rem5,
            artran.rem6,
            artran.rem7,
            artran.rem8,
            artran.rem9,
            artran.order_cl,
            artran.rem10,
            artran.rem11,
            artran.rem30,
            artran.rem31,
            artran.rem32,
            	artran.rem45,
                artran.updated_by,
                artran.source,
                artran.pono,
                artran.frem7,
                artran.rem1,
				artran.wos_date,
				artran.fperiod,
				artran.custno,
				artran.name,
				artran.userid,
				artran.posted,
				artran.generated,
				artran.void,
				toinv,
				artran.van,
				concat(dr.name,' ',dr.name2) as drivername,
				dr.phone 
				from artran 
				
				left join driver dr on artran.van=dr.driverno
				
				where type='#tran#' 
				<cfif alown eq 1>
					and (artran.userid='#huserid#' or ucase(artran.agenno)='#ucase(huserid)#')
				<cfelse>	<!--- Add on 141108 --->
                <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    			<cfelse>
					<cfif Huserloc neq "All_loc">
						and (artran.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                </cfif>
				</cfif>
				
				order by 
				<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>wos_date desc ,refno desc</cfif>
				limit #start-1#,20;
			</cfquery>
		<cfelse>
			<cfquery datasource='#dts#' name="getjob">
				select
                artran.rem49,
				artran.type,
				artran.refno,
                artran.desp,
				artran.refno2,
                <cfif lcase(hcomid) eq "fixics_i">
                artran.ticket,
        		</cfif>
                artran.frem1,
                artran.rem2,
                artran.sono,
                artran.rem3,
                artran.created_by,
				artran.agenno,
                artran.source,
                artran.job,
                artran.permitno,
                artran.cs_pm_debt,
                artran.order_cl,
            artran.van,
            artran.currcode,
            artran.term,
            artran.grand_bil,
            artran.rem5,
            artran.rem6,
            artran.rem7,
            artran.rem8,
            artran.rem9,
            artran.rem10,
            artran.rem11,
            artran.rem30,
            artran.rem31,
            artran.rem32,
            	artran.rem45,
                artran.pono,
                artran.updated_by,
                artran.frem7,
                artran.rem1,
				artran.wos_date,
				artran.fperiod,
				artran.custno,
				artran.name,
				artran.userid,
				artran.posted,
				artran.generated,
				artran.void,
				toinv,
                printstatus,
				(select phone from #target_table# where custno=artran.custno) as phone 
				from artran 
				where type='#tran#' 
				<cfif alown eq 1>
					<cfif getGeneralInfo.agentlistuserid eq "Y">
                    and (ucase(artran.agenno) in 
                    (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%") or ucase(userid)='#ucase(huserid)#')
					<cfelse>
                    and (ucase(artran.userid)='#ucase(huserid)#' 
                    or ucase(artran.agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
                    </cfif>
				<cfelse>	<!--- Add on 141108 --->
                <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    			<cfelse>
					<cfif Huserloc neq "All_loc">
						and (artran.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                </cfif>
				</cfif>
                <cfif lcase(husergrpid) eq 'sales' and lcase(hcomid) eq "sosbat_i">
                and refno like '%R%'
                <cfelseif lcase(husergrpid) eq 'workshop' and lcase(hcomid) eq "sosbat_i">
                and refno like '%WS%'
                </cfif>
				<!--- and fperiod <> '99' ---> 
				order by 
				<cfif (lcase(hcomid) eq "iel_i" or lcase(hcomid) eq "ielm_i") and tran eq "INV">
					substring_index(refno,'/',-1) desc,substring_index(substring_index(refno,'/',1),'.',-1) desc,substring_index(refno,'.',1) desc
				<cfelse>
					<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>wos_date desc ,refno desc</cfif>
				</cfif>  
				limit #start-1#,20;
			</cfquery>
		</cfif>

		<cfif start neq 1>
			|| <a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">#words[972]#</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">#words[900]#</a> ||
		</cfif>

		Page #page# Of #noOfPage#
		</div>
		<hr>
		<input type="hidden" name="samid" id="samid" value="">
		<table align="center" class="data">
  			<tr>
				<td colspan="9"><div align="center"><font color="336699" size="3" face="Arial, Helvetica, sans-serif"><strong>#tranname#</strong></font></div></td>
  			</tr>
            <tr>
    	<cfif getdisplaysetup.bill_refno eq 'Y'>
    	<th><div align="center">#tranname# No</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_name eq 'Y'>
        <th><div align="center">#words[65]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_toinv eq 'Y'>
        <th><div align="center">#words[887]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_refno2 eq 'Y'>
        <cfoutput>
		<th><div align="center">#words[1692]#</div></th>
        </cfoutput>
        </cfif>
        <cfif getdisplaysetup.bill_QUO eq 'Y'>
        <th><div align="center">#words[668]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_SO eq 'Y'>
        <th><div align="center">#words[752]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_PO eq 'Y'>
        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
        <th><div align="center">P/O</div></th>
        <cfelse>
        <th><div align="center">#words[795]#</div></th>
        </cfif>
        </cfif>
        <cfif getdisplaysetup.bill_agent eq 'Y'>
		<th><div align="center">#words[29]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_driver eq 'Y'>
		<th><div align="center">#words[1358]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_project eq 'Y'>
        <th><div align="center">#words[506]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_projectdesp eq 'Y'>
        <th><div align="center">#words[781]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_job eq 'Y'>
        <th><div align="center">#words[475]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_date eq 'Y'>
    	<th><div align="center">#words[702]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_period eq 'Y'>
    	<th><div align="center">#words[703]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_custno eq 'Y'>
    	<th><div align="center">
			<cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
				#words[704]#
			<cfelse>
				#words[782]#
			</cfif></div>
		</th>
        </cfif>
        <cfif getdisplaysetup.billbody_dadd eq 'Y'>
        <th><div align="center">#words[783]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_b_attn eq 'Y'>
        <th><div align="center">#words[892]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_created eq 'Y'>
        <th><div align="center">#words[759]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_currcode eq 'Y'>
        <th><div align="center">#words[785]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_term eq 'Y'>
        <th><div align="center">#words[67]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_totalqty eq 'Y'>
        <th><div align="center">#words[786]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_grand eq 'Y'>
        <th><div align="center">#words[787]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_permitno eq 'Y'>
        <th><div align="center">#words[788]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem5 eq 'Y'>
        <th><div align="center">#words[1694]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem6 eq 'Y'>
        <th><div align="center">#words[1695]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem7 eq 'Y'>
        <th><div align="center">#words[1696]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem8 eq 'Y'>
        <th><div align="center">#words[1697]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem9 eq 'Y'>
        <th><div align="center">#words[1698]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem10 eq 'Y'>
        <th><div align="center">#words[1699]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem11 eq 'Y'>
        <th><div align="center">#words[1700]#</div></th>
        </cfif>
        
        <cfif getdisplaysetup.bill_rem30 eq 'Y'>
        	<th><div align="center">#words[1701]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem31 eq 'Y'>
        	<th><div align="center">#words[1702]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem32 eq 'Y'>
        	<th><div align="center">#words[1703]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem45 eq 'Y'>
        	<th><div align="center">#words[1716]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_rem46 eq 'Y'>
        	<th><div align="center">#words[1717]#</div></th>
        </cfif>
        
        <cfif lcase(hcomid) eq "fdipx_i">
        <th><div align="center">Item </div></th>
        <th><div align="center">Total Item</div></th>
        </cfif>
        <cfif lcase(hcomid) eq "poria_i">
        <th><div align="center">Delivery Code</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_d_add eq 'Y'>
    	<th><div align="center">#words[48]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_b_phone eq 'Y'>
        <th><div align="center">#words[40]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_d_attn eq 'Y'>
    	<th><div align="center">#words[1288]#</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_user eq 'Y'>
    	<th><div align="center">#words[705]#</div></th>
        </cfif>
        <cfif lcase(hcomid) eq "visionlaw_i">
        <th><div align="center">Edit User</div></th>
        </cfif>
        <cfif getdisplaysetup.bill_bodystatus eq 'Y'>
        <cfif lcase(hcomid) eq "fdipx_i" and tran eq "QUO">
        <th>SO</th>
        <th>Status</th>
        <cfelseif lcase(hcomid) eq "fdipx_i" and tran eq "SO">
        <th>DO</th>
        <th>INV</th>
        <th>PO</th>
        <th>CS</th>
        <th>Status</th>
        <cfelseif lcase(hcomid) eq "fdipx_i" and tran eq "DO">
        <th>INV</th>
        <cfelseif lcase(hcomid) eq "fdipx_i" and tran eq "INV">
        <th>Status</th>
        <cfelse>
		<th><div align="center">#words[706]#</div></th>
        </cfif>
        </cfif>
        <cfif lcase(hcomid) eq "fixics_i">
        <th><div align="center">Ticket</div></th>
        </cfif>
    	<th><div align="center">#words[10]#</div></th>
  	</tr>
			
			<cfloop query="getjob">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                	<cfif getdisplaysetup.bill_refno eq 'Y'>
      				<td>
                    <cfif getpin2.h3200 eq "T" and getpin2.h3210 eq "T" and  getpin2.h3220 eq "T" and getpin2.h3230 eq "T" and  getpin2.h3240 eq "T" and  getpin2.h3250 eq "T" and getpin2.h3260 eq "T" and  getpin2.h3270 eq "T" and  getpin2.h32E0 eq "T" and getpin2.h3920 eq "T">
                    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/salesstatus/orderstatus.cfm?refno=#URLEncodedFormat(refno)#&tran=#URLEncodedFormat(type)#')">#getjob.refno#</a>
        			<cfelse>
                    #getjob.refno#
                    </cfif>
                    </td>
                    </cfif>
                    <cfif getdisplaysetup.bill_name eq 'Y'>
                    <td>#getjob.desp#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_toinv eq 'Y'>
                    <td>#getjob.toinv#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_refno2 eq 'Y'>
	  				<td>#getjob.refno2#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_agent eq 'Y'>
	  				<td nowrap>#getjob.agenno#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_driver eq 'Y'>
                    <cfif lcase(hcomid) eq "polypet_i">
                    <cfquery name="getvandesp" datasource="#dts#">
       				select name from driver where driverno='#getjob.van#'
        			</cfquery>
                    </cfif>
                    <td nowrap>#getjob.van# <cfif lcase(hcomid) eq "polypet_i"> - #getvandesp.name#</cfif></td>
                    </cfif>
                    <cfif getdisplaysetup.bill_SO eq 'Y'>
                    <cfset sonolist=getjob.sono>
        
        			<td><cfloop list="#sonolist#" delimiters="," index="i">#i#<br></cfloop></td>
                    </cfif>
                    <cfif getdisplaysetup.bill_PO eq 'Y'>
                    <cfset ponolist=getjob.pono>
        
        			<td><cfloop list="#ponolist#" delimiters="," index="i">#i#<br></cfloop></td>
        			</cfif>
                    <cfif getdisplaysetup.bill_project eq 'Y'>
                	<td>#getjob.source#</td>
                	</cfif>
                    <cfif getdisplaysetup.bill_projectdesp eq 'Y'>
                    <cfquery name="getprojectdesp" datasource="#dts#">
                    select project from #target_project# where source='#getjob.source#' and porj='P'
                    </cfquery>
                    <td>#getprojectdesp.project#</td>
                    </cfif>
                    
                    <cfif getdisplaysetup.bill_job eq 'Y'>
                    <td>#getjob.job#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_date eq 'Y'>
        	  		<td nowrap>#dateformat(getjob.wos_date,"dd-mm-yyyy")#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_period eq 'Y'>
      				<td>#getjob.fperiod#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_custno eq 'Y'>
			      		<td <cfif lcase(hcomid) neq "baronad_i">nowrap</cfif>>#getjob.custno# - #getjob.name# #getjob.frem1#</td>
                    <cfif getdisplaysetup.bill_b_attn eq 'Y'>
        <td nowrap>#getjob.rem2#</td>
        </cfif>
                    </cfif>
                    <cfif getdisplaysetup.bill_created eq 'Y'>
                    <td nowrap>#getjob.created_by#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_currcode eq 'Y'>
                    <td nowrap>#getjob.currcode#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_term eq 'Y'>
                    <td nowrap>#getjob.term#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_totalqty eq 'Y'>
                    <cfquery name="gettotalqty" datasource="#dts#">
                    select sum(qty) as qty from ictran where refno='#refno#' and type='#tran#'
                    </cfquery>
                    <td nowrap align="center">#gettotalqty.qty#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_grand eq 'Y'>
                    <td nowrap>#numberformat(getjob.grand_bil,',_.__')#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_permitno eq 'Y'>
                	<td>#getjob.permitno#</td>
                	</cfif>
                    <cfif getdisplaysetup.bill_rem5 eq 'Y'>
                    <td>#getjob.rem5#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem6 eq 'Y'>
                    <td>#getjob.rem6#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem7 eq 'Y'>
                    <td>#getjob.rem7#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem8 eq 'Y'>
                    <td>#getjob.rem8#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem9 eq 'Y'>
                    <td>#getjob.rem9#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem10 eq 'Y'>
                    <td>#getjob.rem10#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem11 eq 'Y'>
                    <td>#getjob.rem11#</td>
                    </cfif>
                    
                    <cfif getdisplaysetup.bill_rem30 eq 'Y'>
                        <td>#getjob.rem30#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem31 eq 'Y'>
                        <td>#getjob.rem31#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_rem32 eq 'Y'>
                        <td>#getjob.rem32#</td>
                    </cfif>
                   
                    <cfif lcase(hcomid) eq "fdipx_i">
                    <cfquery name="get1stitem" datasource="#dts#">
                    select desp from ictran where refno='#refno#' and type='#tran#' and itemcount = '1'
                    </cfquery>
                    <cfquery name="gettotalitem" datasource="#dts#">
                    select itemno from ictran where refno='#refno#' and type='#tran#'
                    </cfquery>
                    <td nowrap>#get1stitem.desp#</td>
                    <td nowrap>#gettotalitem.recordcount#</td>
                    </cfif> 
                    <cfif lcase(hcomid) eq "poria_i">
                    <td nowrap>#getjob.rem1#</td>
                    </cfif>
					<td nowrap>#getjob.phone#</td>
                    <cfif getdisplaysetup.bill_d_attn eq 'Y'>
      				<td>#getjob.rem3#</td>
                    </cfif>
                    <cfif getdisplaysetup.bill_user eq 'Y'>
      				<td>
                    <cfif hcomid eq 'thats_i'>
        #getjob.updated_by#
        <cfelse>
                    #getjob.userid#
                    </cfif>
                    </td>
                    </cfif>
                    <cfif lcase(hcomid) eq "visionlaw_i">
                    <td>#getjob.updated_by#</td>
                    </cfif>
	  				<td align="center">
                    	<cfif tran eq 'SO' and lcase(hcomid) eq "litelab_i" and order_cl neq ''>
                        PO 
                        </cfif>
						<cfif (tran eq 'DO' or tran eq 'PO' or tran eq 'SO' or tran eq 'QUO' or tran eq 'SAMM' or tran eq 'SAM' or tran eq 'RQ') and toinv eq 'C'>
							C<cfelseif (tran eq 'DO' or tran eq 'PO' or tran eq 'SO' or tran eq 'QUO' or tran eq 'SAMM' or tran eq 'SAM' or tran eq 'RQ') and toinv neq ''>
							<cfif lcase(hcomid) eq 'maranroad_i' or lcase(hcomid) eq 'asramaraya_i'>Updated<cfelse>Y</cfif>
						</cfif>
						<cfif (tran eq 'INV' or tran eq 'RC' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'PR') and getjob.posted neq ''>
							P
						</cfif>
                        <cfif lcase(hcomid) eq "hunting_i" and tran eq 'SAM' and toinv eq '' and printstatus eq 'a3'>Approved</cfif>
                        <cfif lcase(hcomid) eq "polypet_i" and tran eq 'SAM'>
                        <cfif printstatus eq '1'>
                        Approved
						<cfelse>
                        Not Approved
						</cfif>
						</cfif>
                        <cfif lcase(hcomid) eq "net_i" and tran eq 'QUO' and toinv eq '' and printstatus eq 'a3'>Approved</cfif>
						<cfif lcase(hcomid) eq "net_i" and tran eq 'QUO' and toinv eq '' and printstatus eq ''>Pending</cfif>
						<cfif getjob.void neq ''>
                        	<cfif (lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i") and getjob.rem49 eq "pending">Pending
                            <cfelse>
							<font color="red"><strong>Void</strong></font>
                            </cfif>
						</cfif>
                        <cfif (lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i") and getjob.rem49 eq "sent">Sent</cfif>
                        <cfif lcase(hcomid) eq "ltm_i" and toinv eq ''>
                        #getjob.rem45#
                        </cfif>
                        <cfif lcase(hcomid) eq "haikhim_i">
						<cfif printstatus eq 'a2'>Pending Approval<cfelseif printstatus eq 'a3'>Approved</cfif>
                        
                        </cfif>
					</td>
                    <cfif lcase(hcomid) eq "fixics_i">
                    <td align="center"><cfif ticket neq ''>#ticket#</cfif><cfif left(toinv,2) eq 'DO'>DO<cfelseif toinv neq ''>INV</cfif></td>
                    </cfif>
                <cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
          			<td align="right" nowrap>
						<cfif getgeneralinfo.printoption eq 1>
                            <a target="_blank" href="transaction3c.cfm?tran=#tran#&nexttranno=#refno#"><img height="18px" width="18px" src="../../images/PNG-48/Print.png" alt="Print" border="0"></a>
                        <cfelse>
                            <a target="_blank" href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#refno#"><img height="18px" width="18px" src="../../images/PNG-48/Print.png" alt="Print" border="0"></a>
                        </cfif>
                        <cfif aledit eq 1 and getjob.void eq "">
                            <a target="_parent" href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
                                <img height="18px" width="18px" src="../../images/PNG-48/Modify.png" alt="Edit" border="0">
                            </a>
						<cfelse>
							<img height="18px" width="18px" src="../../images/PNG-48/iModify.png" alt="Not Allowed to Edit" border="0">
                        </cfif>
                        <cfif aldelete eq 1 and getjob.void eq "">
                            <a target="_parent" href="transaction1.cfm?tran=#tran#&ttype=Delete&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
                                <img height="18px" width="18px" src="../../images/PNG-48/Delete.png" alt="Delete" border="0">
                            </a>
						<cfelse>
							<img height="18px" width="18px" src="../../images/PNG-48/iDelete.png" alt="Not Allowed to Delete" border="0">
                        </cfif>
						<cfif (tran eq "SO" and getpin2.h2886 eq 'T') or (tran eq "QUO" and (getpin2.h2875 eq 'T' or getpin2.h2876 eq 'T'))>
                            <cfif getjob.toinv neq "">
                                <img height="18px" width="18px" src="../../images/PNG-48/Next_disabled.png" alt="Update" border="0">
                            <cfelse>
                                <a href="update2/update.cfm?tran=#tran#&nexttranno=#refno#" target="_parent"><img height="18px" width="18px" src="../../images/PNG-48/Next.png" alt="Update" border="0"></a>
                            </cfif>
                        </cfif>
                    </td>
				<cfelse>
          			<td align="left" nowrap>
                    	<cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" <!---or lcase(hcomid) eq "lkatlb_i"--->
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
                             <a target="_blank" href="/billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#refno#&BillName=shell_iCBIL_#tran#&doption=0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[3]#</cfif></a>&nbsp;
                        	
                <cfelse>
		  		<cfif getgeneralinfo.printoption eq 1>
					<a href="transaction3c.cfm?tran=#tran#&nexttranno=#refno#" target="_blank"><img height="18px" width="18px" src="../../images/print.png" alt="Print" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[3]#</cfif></a>&nbsp;
				<cfelse>
					<a href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#refno#" target="_blank"><img height="18px" width="18px" src="../../images/print.png" alt="Print" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[3]#</cfif></a>&nbsp;
				</cfif>
                </cfif>
                
				<cfif lcase(hcomid) eq "guankeat_i" and getjob.rem49 eq "" and (tran eq "INV" or tran eq "CS")>
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('sendbilltoaps');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[808]#</a>
                
                </cfif>
                <cfif lcase(hcomid) eq "hunting_i" and getjob.printstatus neq "a3" and tran eq "Sam" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>		
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('approvesample');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
                
				</cfif>
                
                <cfif getGeneralInfo.poapproval eq 'Y' and getjob.printstatus neq "a3" and tran eq "PO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>		<input type="hidden" name="samid" id="samid" value="">
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('approvesample');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
                
				</cfif>
                <cfif getGeneralInfo.rqapproval eq 'Y' and getjob.printstatus neq "a3" and tran eq "RQ" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>		<input type="hidden" name="samid" id="samid" value="">
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('approvesample');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
				</cfif>
                <cfif (lcase(hcomid) eq "asiasoft_i" or lcase(hcomid) eq "asaiki_i") and getjob.printstatus neq "a3"  and getjob.printstatus neq "REJECT" and tran eq "SO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super" or HUserGrpID eq "General")><a style="cursor:pointer" onClick="document.getElementById('soid').value='#refno#';ColdFusion.Window.show('approveso');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
                
                </cfif>

				<cfif aledit eq 1 and getjob.void eq "">
                
					
                    <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i") and tran eq "SO">
                    <cfif (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0" target="mainFrame"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                    <cfelseif permitno neq "locked">
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0" target="mainFrame"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                    <cfelse>
                    <img height="18px" width="18px" src="../../images/edit.ICO" alt="Not Allowed to Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif>
                    </cfif>
                    <cfelse>
                    
                    <cfif lcase(hcomid) eq "fixics_i" and ticket neq ''>
                            <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif>
                    <cfelse>
                    
                    <cfif getgeneralinfo.editbillpassword eq "1" and (getgeneralinfo.editbillpassword1 eq "" or ListFindNoCase(getgeneralinfo.editbillpassword1,tran))>
                    		<a href="javascript:void(0)" onClick="PopupCenter('editbillcontrol.cfm?tran=#tran#&refno=#URLEncodedFormat(refno)#&ttype=Edit&parentpage=no','linkname','300','150');"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                    <cfelse>
                    	
						<cfif getgeneralinfo.generateQuoRevision eq "1" and tran neq 'INV' and (getgeneralinfo.generateQuoRevision1 eq "" or ListFindNoCase(getgeneralinfo.generateQuoRevision1,tran))>
                        
                            <cfquery name="checkiclink" datasource="#dts#">
                                select refno from iclink where (refno='#refno#' and type='#tran#') or (frrefno='#refno#' and frtype='#tran#')
                            </cfquery>
                        	<cfif checkiclink.recordcount eq 0>
							<a href="javascript:void(0)" onClick="PopupCenter('tran_edit2a.cfm?tran=#tran#&refno=#URLEncodedFormat(refno)#&parentpage=no','linkname','200','100');"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                            
                            <cfelse>
                            <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0" target="mainFrame"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                            
                            </cfif>
						<cfelse>
							<a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0" target="mainFrame"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                            
						</cfif>
                    </cfif>
					</cfif>
                    </cfif>
                <cfelse>
                	<img height="18px" width="18px" src="../../images/edit.ICO" alt="Not Allowed to Edit" border="0">					
						<cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif>
                </cfif>
                
                <cfif HuserGrpID EQ 'super' OR HcomID EQ 'gaf_i' OR HcomID EQ 'demomsia_i' OR HcomID EQ 'junguan_i'>
			
                      <a href="/latest/transaction/simpleTransaction/simpleTransaction.cfm?action=Update&type=#tran#&refno=#refno#" target="self" >
                        ST (Beta!)
                      </a>
  
                </cfif>
                
                    <!---<cfif aledit eq 1 and getjob.void eq "">
                    	<cfif HUserGrpID eq "super" or lcase(hcomid) eq "eocean_i">
                    		<a onMouseOver="JavaScript:this.style.cursor='hand';" target="mainFrame" onClick="window.open('expresstranedit/index.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0','','fullscreen=yes,scrollbars=yes')">
                			<img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit</a>
                    	</cfif>
                    </cfif>
                    
                    <cfif <!---HUserGrpID eq "super" and---> (tran eq 'SO' or tran eq 'INV' or tran eq 'CN') and lcase(hcomid) eq "ltm_i">
                    <cfif aledit eq 1 and getjob.void eq "" and getjob.posted eq "">
						<cfif toinv eq ''>
                            <a onMouseOver="JavaScript:this.style.cursor='hand';" target="mainFrame" onClick="window.open('vehicletranedit/index.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#&first=0','','fullscreen=yes,scrollbars=yes')">
                            <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit</a>
                        <cfelse>
                            <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit
                        </cfif>
                    <cfelse>
                        <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit
                        </cfif>
					</cfif>--->
                
				<cfif getpin2.H2890 eq 'T' and alcopy eq 1>
               <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('copyfunction.cfm?refno=#refno#&type=#tran#');"><img height="18px" width="18px" src="../../images/Copy Icon.jpg" alt="Copy" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[806]#</cfif></a>
                </cfif>
                
                <cfif lcase(hcomid) eq "fixics_i" and ticket neq ''>
                <img height="18px" width="18px" src="../../images/delete.ICO" alt="Not Allowed to Delete" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[805]#</cfif>
                <cfelseif lcase(hcomid) eq "tcds_i">
                <a href="javascript:void(0)" onClick="PopupCenter('editbillcontrol.cfm?tran=#tran#&refno=#refno#&parentpage=no&ttype=Delete','linkname','500','500');"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[805]#</cfif></a>
                <cfelse>
				<cfif aldelete eq 1 and (getjob.void eq "" or (lcase(hcomid) eq "haikhim_i" and tran eq "RQ"))>
					<a href="transaction1.cfm?tran=#tran#&ttype=Delete&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(getjob.custno)#<!--- &bcode=&dcode= --->&first=0" target="mainFrame"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[805]#</cfif></a>
				<cfelse>
					<img height="18px" width="18px" src="../../images/delete.ICO" alt="Not Allowed to Delete" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[805]#</cfif>
				</cfif>
                </cfif>
                
            <cfif lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i">
            &nbsp;&nbsp;&nbsp;
            <cfif tran eq "PO" and getjob.rem49 eq "pending" and void eq "Y">
            <a href="/customized/hodaka_i/receivebill.cfm?tran=#tran#&refno=#URLEncodedFormat(refno)#">Receive</a>
            </cfif>
            <cfif tran eq "DO" and listfind("hodaka_i,hodakadist_i,hodakams_i,hodakapte_i,motoworld_i,hodakamy_i,hdkiv_i,motoworldvn_i",permitno,",") neq 0 and getjob.rem49 neq "sent">
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/customized/hodaka_i/sendtransferbill.cfm?type=#type#&refno=#URLEncodedFormat(refno)#','_blank','height=630,width=700,scrollbar=yes,')">Send</a>
            </cfif>
            </cfif>
                
            &nbsp;&nbsp;&nbsp;
            <cfif getmodule.auto eq "1" and (tran eq 'INV' or tran eq 'CN' or tran eq 'CS') and posted eq ''>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#URLEncodedFormat(refno)#','_blank','height=630,width=700,scrollbar=yes,')">#words[804]#</a>
            </cfif>
            
            <cfif getpin2.H2408 eq "T" and (tran eq 'INV' or tran eq 'CS') AND posted EQ '' and cs_pm_debt GT 0>
            <cfif lcase(Hcomid) eq "rpi270505_i">
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('RPIpaybill.cfm?type=#type#&refno=#URLEncodedFormat(refno)#','_blank','height=630,width=700,scrollbar=yes,')">#words[804]#</a>
            <cfelse>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#URLEncodedFormat(refno)#','_blank','height=630,width=700,scrollbar=yes,')">#words[804]#</a>
            </cfif>
            </cfif>
            
            <cfif getpin2.H288B eq "T" and tran eq 'SO' and posted eq ''>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#URLEncodedFormat(refno)#','_blank','height=630,width=700,scrollbar=yes,')">#words[804]#</a>
			</cfif>
            <cfif lcase(hcomid) eq "sosbat_i" and tran eq 'RC' and posted eq ''>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#URLEncodedFormat(refno)#','_blank','height=630,width=700,scrollbar=yes,')">#words[804]#</a>
            </cfif>
            <cfif (hcomid eq "bnbm_i" or hcomid eq "bnbp_i") and tran eq 'QUO'>
                    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/salesstatus/orderstatus.cfm?refno=#refno#')">Status</a>
            </cfif>
            <cfif hcomid eq "83dnppl_i" and tran eq 'SAM' and toinv eq "">
                    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="if (confirm('Confirm Update RFQ No : #refno#')){PopupCenter('/customized/83dnppl_i/update/update_to_costing2.cfm?tran=#tran#&refno=#URLEncodedFormat(refno)#','Update','500','500');}else{}">Update To Costing Sheet</a>
            <cfelseif hcomid eq "83dnppl_i" and tran eq 'QUO' and toinv eq "">
                    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="if (confirm('Confirm Update Quotation No : #refno#')){PopupCenter('/customized/83dnppl_i/update/update_to_jobsheet2.cfm?tran=#tran#&refno=#URLEncodedFormat(refno)#','Update','500','500');}else{}">Update To Job Sheet</a>
            </cfif>
            
            
			</td>

		</cfif>
    		</tr>
  		</cfloop>
		</table>
		<hr>
		<div align="right">
		<cfif start neq 1>
			<a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">#words[972]#</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">#words[900]#</a> ||
		</cfif>
		
		#words[1091]# #page# Of #noOfPage#
		</div>
	</cfform>
<cfelse>
	<h3>#words[969]#</h3>
</cfif>
</cfoutput>

</body>
</html>

<cfif getGeneralInfo.poapproval eq 'Y' and tran eq "PO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
  <cfajaximport tags="cfform">
 <cfwindow name="approvesample" width="400" height="400" source="approvesample.cfm?tran=#tran#&refno={samid}" modal="true" title="Approval" closable="true" draggable="true" center="true" refreshonshow="true" />
</cfif>

<cfif getGeneralInfo.rqapproval eq 'Y' and tran eq "RQ" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
  <cfajaximport tags="cfform">
 <cfwindow name="approvesample" width="400" height="400" source="approvesample.cfm?tran=#tran#&refno={samid}" modal="true" title="Approval" closable="true" draggable="true" center="true" refreshonshow="true" />
</cfif>