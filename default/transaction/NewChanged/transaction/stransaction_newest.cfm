<cfparam name="alcreate" default="0">
<cfparam name="aledit" default="0">
<cfparam name="aldelete" default="0">
<cfparam name="alown" default="0">

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
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
	Select *

	from GSetup
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
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
	invoneset,ldriver ,agentlistuserid,poapproval
	
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
			<h3 align="center"><font color="FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
 	</cfif>
	
	<cfform action="stransaction_newest.cfm?tran=#urlencodedformat(tran)#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#" method="post" target="_self">
		<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
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
			|| <a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
		</div>
		<hr>

		<table align="center" class="data">
  			<tr>
				<td colspan="9"><div align="center"><font color="336699" size="3" face="Arial, Helvetica, sans-serif"><strong>#tranname#</strong></font></div></td>
  			</tr>
            <tr>
            	<cfif getdisplaysetup.bill_refno eq 'Y'>
   	 			<th>#tranname# No</th>
                </cfif>
                <cfif getdisplaysetup.bill_name eq 'Y'>
                <th>Description</th>
                </cfif>
                <cfif getdisplaysetup.bill_toinv eq 'Y'>
                <th>To Inv</th>
                </cfif>
                <cfif getdisplaysetup.bill_refno2 eq 'Y'>
                <cfoutput>
				<th>#getGeneralInfo1.refno2#</th>
                </cfoutput>
                </cfif>
                <cfif getdisplaysetup.bill_agent eq 'Y'>
				<cfoutput>
				<th>#getGeneralInfo1.lagent#</th>
        		</cfoutput>
                </cfif>
                <cfif getdisplaysetup.bill_driver eq 'Y'>
                <cfoutput>
                <th>#getGeneralInfo.ldriver#</th>
                </cfoutput>
                </cfif>
                <cfif getdisplaysetup.bill_SO eq 'Y'>
                <th>SO No</th>
                </cfif>
                <cfif getdisplaysetup.bill_PO eq 'Y'>
             <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
        <th> P/O</th>
        <cfelse>
        		<th>Pono</th>
                </cfif>
        		</cfif>
                <cfif getdisplaysetup.bill_project eq 'Y'>
                <th>Project</th>
                </cfif>
                <cfif getdisplaysetup.bill_job eq 'Y'>
                <th>Job</th>
                </cfif>
                <cfif getdisplaysetup.bill_date eq 'Y'>
				<th>Date</th>
                </cfif>
                <cfif getdisplaysetup.bill_period eq 'Y'>
				<th>Period</th>
                </cfif>
                <cfif getdisplaysetup.bill_custno eq 'Y'>
				<th>
				<cfif tran eq "RC" or tran eq "PR" or tran eq "PO">
					Supplier Name
				<cfelse>
					Customer Name
				</cfif>
				</th>
                </cfif>
                <cfif getdisplaysetup.bill_b_attn eq 'Y'>
                <th>B_Attn</th>
                </cfif>
                <cfif getdisplaysetup.bill_created eq 'Y'>
                <th>Created By</th>
                </cfif>
                <cfif getdisplaysetup.bill_currcode eq 'Y'>
                <th>Currency Code</th>
                </cfif>
                <cfif getdisplaysetup.bill_term eq 'Y'>
                <th>Terms</th>
                </cfif>
                <cfif getdisplaysetup.bill_totalqty eq 'Y'>
                <th>Total Qty</th>
                </cfif>
                <cfif getdisplaysetup.bill_grand eq 'Y'>
                <th>Total Amount</th>
                </cfif>
                <cfoutput>
                <cfif getdisplaysetup.bill_rem5 eq 'Y'>
                <th>#getGeneralInfo1.rem5#</th>
                </cfif>
                <cfif getdisplaysetup.bill_rem6 eq 'Y'>
                <th>#getGeneralInfo1.rem6#</th>
                </cfif>
                <cfif getdisplaysetup.bill_rem7 eq 'Y'>
                <th>#getGeneralInfo1.rem7#</th>
                </cfif>
                <cfif getdisplaysetup.bill_rem8 eq 'Y'>
                <th>#getGeneralInfo1.rem8#</th>
                </cfif>
                <cfif getdisplaysetup.bill_rem9 eq 'Y'>
                <th>#getGeneralInfo1.rem9#</th>
                </cfif>
                <cfif getdisplaysetup.bill_rem10 eq 'Y'>
                <th>#getGeneralInfo1.rem10#</th>
                </cfif>
                <cfif getdisplaysetup.bill_rem11 eq 'Y'>
                <th>#getGeneralInfo1.rem11#</th>
                </cfif>
                </cfoutput>
                <cfif lcase(hcomid) eq "fdipx_i">
                <th>Item No</th>
                <th>Total Item</th>
                </cfif>
                <cfif lcase(hcomid) eq "poria_i">
                <th>Delivery Code</th>
                </cfif>
				<th>Phone</th>
                <cfif getdisplaysetup.bill_d_attn eq 'Y'>
				<th>D_Attn</th>
                </cfif>
                <cfif getdisplaysetup.bill_user eq 'Y'>
				<th>User</th>
                </cfif>
                <cfif lcase(hcomid) eq "visionlaw_i">
                <th>Edit User</th>
                </cfif>
                <cfif lcase(hcomid) eq "fixics_i">
                <th>Ticket</th>
        		</cfif>
				<th>Status</th>
				<th>Action</th>
 		 	</tr>
			
			<cfloop query="getjob">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                	<cfif getdisplaysetup.bill_refno eq 'Y'>
      				<td>#getjob.refno#</td>
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
			      		<td nowrap>#getjob.custno# - #getjob.name# #getjob.frem1#</td>
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
							<font color="red"><strong>Void</strong></font>
						</cfif>
                        <cfif lcase(hcomid) eq "ltm_i" and toinv eq ''>
                        #getjob.rem45#
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
                            <a target="_parent" href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
                                <img height="18px" width="18px" src="../../images/PNG-48/Modify.png" alt="Edit" border="0">
                            </a>
						<cfelse>
							<img height="18px" width="18px" src="../../images/PNG-48/iModify.png" alt="Not Allowed to Edit" border="0">
                        </cfif>
                        <cfif aldelete eq 1 and getjob.void eq "">
                            <a target="_parent" href="transaction1.cfm?tran=#tran#&ttype=Delete&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
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
                    	<cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" or lcase(hcomid) eq "lkatlb_i"
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
                             <a target="_blank" href="/billformat/#dts#/preprintedformat.cfm?tran=#tran#&nexttranno=#refno#&BillName=shell_iCBIL_#tran#&doption=0">Print</a>&nbsp;
                        	
                            <cfelse>
						<cfif getgeneralinfo.printoption eq 1>
                            <a target="_blank" href="transaction3c.cfm?tran=#tran#&nexttranno=#refno#">Print</a>&nbsp;
                        <cfelse>
                            <a target="_blank" href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#refno#">Print</a>&nbsp;
                        </cfif>
                        </cfif>
                        
                        <cfif getGeneralInfo.poapproval eq 'Y' and getjob.printstatus neq "a3" and tran eq "PO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>		<input type="hidden" name="samid" id="samid" value="">
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('approvesample');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">Approve</a>
                
				</cfif>
                
                        
                        <!---
                        <cfif hcomid eq 'msd' and tran eq "RC" and getpin2.h2101 eq 'T'>
                            |&nbsp;<a target="_blank" href="../reports/grn_note.cfm?tran=#tran#&nexttranno=#refno#">GRN Note</a>&nbsp;
                        </cfif>--->
                        <cfif aledit eq 1 and getjob.void eq "">
                        	
                            <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i") and tran eq "SO">
							<cfif (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
                            <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0">Edit</a>
                            <cfelseif permitno neq "locked">
                            <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0">Edit</a>
                            <cfelse>
                            <img height="18px" width="18px" src="../../images/edit.ICO" alt="Not Allowed to Edit" border="0">Edit
                            </cfif>
                            <cfelse>
                        	
                            <cfif lcase(hcomid) eq "fixics_i" and ticket neq ''>
                                    <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit
                            <cfelse>
                            
							<cfif getgeneralinfo.editbillpassword eq "1" and (getgeneralinfo.editbillpassword1 eq "" or ListFindNoCase(getgeneralinfo.editbillpassword1,tran))>
                    				<a href="javascript:void(0)" onClick="PopupCenter('editbillcontrol.cfm?tran=#tran#&refno=#refno#&parentpage=no','linkname','200','100');"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
                    		<cfelse>
                            <cfquery name="checkiclink" datasource="#dts#">
                            select refno from iclink where (refno='#refno#' and type='#tran#') or (frrefno='#refno#' and frtype='#tran#')
                            </cfquery>
								<cfif getgeneralinfo.generateQuoRevision eq "1" and tran neq 'INV' and checkiclink.recordcount eq 0 and (getgeneralinfo.generateQuoRevision1 eq "" or ListFindNoCase(getgeneralinfo.generateQuoRevision1,tran))>
									<a href="javascript:void(0)" onClick="PopupCenter('tran_edit2a.cfm?tran=#tran#&refno=#refno#&parentpage=yes','linkname','200','100');"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
								<cfelse>
		                            <a target="_parent" href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
		                                <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit
		                            </a>
							</cfif>
                            </cfif>
                            </cfif>
                            </cfif>
                        <cfelse>
							<img height="18px" width="18px" src="../../images/edit.ICO" alt="Not Allowed to Edit" border="0">Edit
                        </cfif>
                            
							<cfif <!---HUserGrpID eq "super" and---> (tran eq 'SO' or tran eq 'INV' or tran eq 'CN') and lcase(hcomid) eq "ltm_i">
                            <cfif aledit eq 1 and getjob.void eq "">
							<cfif toinv eq ''>
                            <a onMouseOver="JavaScript:this.style.cursor='hand';" target="mainFrame" onClick="window.open('vehicletranedit/index.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0','','fullscreen=yes,scrollbars=yes')">
                            <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit</a>
                            <cfelse>
                            <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit
                            </cfif>
                            <cfelse>
                            <img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit
                            </cfif>
							</cfif>
                        
                        
                        <cfif getpin2.H2890 eq 'T'>
                        <img height="18px" width="18px" src="../../images/Copy Icon.jpg" alt="Copy" border="0"><a onMouseOver="this.style.cursor='hand'" onClick="window.open('copyfunction.cfm?refno=#refno#&type=#tran#');">Copy</a>
                        </cfif>
                        
                        <cfif lcase(hcomid) eq "fixics_i" and ticket neq ''>
                            	<img height="18px" width="18px" src="../../images/delete.ICO" alt="Not Allowed to Delete" border="0">Delete
                        <cfelse>
                        <cfif aldelete eq 1 and getjob.void eq "">
                            <a target="_parent" href="transaction1.cfm?tran=#tran#&ttype=Delete&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
                                <img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete
                            </a>
						<cfelse>
							<img height="18px" width="18px" src="../../images/delete.ICO" alt="Not Allowed to Delete" border="0">Delete
                        </cfif>
                        </cfif>
                        &nbsp;&nbsp;&nbsp;
                        <cfif getmodule.auto eq "1" and tran eq 'INV' and posted eq ''>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#refno#','_blank','height=630,width=700,scrollbar=yes,')">Pay</a>
					</cfif>
                    
                    <cfif getpin2.H2408 eq "T" and tran eq 'INV' and posted eq ''>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#refno#','_blank','height=630,width=700,scrollbar=yes,')">Pay</a>
					</cfif>
                    
                    <cfif getpin2.H288B eq "T" and tran eq 'SO' and posted eq ''>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#refno#','_blank','height=630,width=700,scrollbar=yes,')">Pay</a>
					</cfif>
                    <cfif (hcomid eq "bnbm_i" or hcomid eq "bnbp_i") and tran eq 'QUO'>
                    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/salesstatus/orderstatus.cfm?refno=#refno#')">Status</a>
                    </cfif>
                        
                    </td>
                </cfif>
    		</tr>
  		</cfloop>
		</table>
		<hr>
		<div align="right">
		<cfif start neq 1>
			<a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="stransaction_newest.cfm?tran=#tran#&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Next</a> ||
		</cfif>
		
		Page #page# Of #noOfPage#
		</div>
	</cfform>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>
</cfoutput>

</body>
</html>

<cfif getGeneralInfo.poapproval eq 'Y' and tran eq "PO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
  <cfajaximport tags="cfform">
 <cfwindow name="approvesample" width="400" height="400" source="approvesample.cfm?tran=#tran#&refno={samid}" modal="true" title="Approval" closable="true" draggable="true" center="true" refreshonshow="true" />
  </cfif>
