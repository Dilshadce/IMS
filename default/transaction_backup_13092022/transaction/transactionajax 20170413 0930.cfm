<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "48,67,2154,793,782,664,188,665,666,185,689,667,690,668,673,674,961,835,2151,721,718,719,720,722,723,724,980,692,726,725,727,728,2152,698,960,2153,745,694,748,1782,1849,813,696,814,815,816,817,818,819,820,821,822,697,698,749,106,704,16,702,29,703,40,795,752,441,300,753,506,475,754,759,1692,1358,695,757,65,887,668,781,784,783,892,785,786,787,788,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1716,1717,1288,705,706,10,3,808,848,2155,806,805,804">
<cfinclude template="/latest/words.cfm">

<cfparam name="alcreate" default="0">	<!--- Authority to Create New --->
<cfparam name="aledit" default="0">		<!--- Authority to Edit --->
<cfparam name="aldelete" default="0">	<!--- Authority to Delete --->
<cfparam name="alown" default="0">		<!--- Authority to View Own Document --->
<cfparam name="alsimple" default="0">
<cfparam name="alcopy" default="0">

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo1">
	Select * from GSetup
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>
<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>

<cfquery name="getremarkdetail" datasource="#dts#">
	select * 
	from extraremark;
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	select * from displaysetup2
</cfquery>

<cfquery datasource="#dts#" name="getmodule">
	select * from modulecontrol
</cfquery>

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

<cfif lcase(hcomid) eq "ovas_i" and (tran eq "CS" or tran eq "DO" or tran eq "SO" or tran eq "SAM" or tran eq "CN" or tran eq "DN")>
	<cfquery datasource='#dts#' name="gettransaction">
		Select a.*,concat(dr.name,' ',dr.name2) as drivername 
		from artran a
		left join driver dr on a.van=dr.driverno
		where type='#tran#' 
		<cfif alown eq 1>
			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#') 
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
		</cfif> <!--- and fperiod <> '99' ---> 
        and #url.searchType# like '%#url.searchStr#%'
        
		order by 
        <cfif lcase(hcomid) eq "kingston_i">
        wos_date desc,right(refno,'4') desc
        <cfelseif lcase(hcomid) eq "sinlian_i">
        length(refno) desc,refno desc
        <cfelse>
		<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>wos_date desc,refno desc</cfif>
        </cfif>
		limit 20
	</cfquery>
<cfelse>
	<cfquery datasource='#dts#' name="gettransaction">
		Select * 
		from artran 
        <cfif hcomid eq 'Thats_i'>
        left join (select coc_no,no,work from #replace(dts,'_i','_c')#.qa08) q on q.coc_no = artran.refno
        </cfif>
        
		where type='#tran#' 
		<cfif alown eq 1>
			<cfif getGeneralInfo.agentlistuserid eq "Y">and (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%") or ucase(userid)='#ucase(huserid)#')
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentid like "%#ucase(huserid)#%")))  
			</cfif>
		<cfelse>
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Van Sales')>
    	<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif> <!--- and fperiod <> '99' ---> 
        and <cfif url.searchType eq "leftname">name like '#url.searchStr#%'<cfelse>#url.searchType# like '%#url.searchStr#%'</cfif>
		order by 
		<cfif (lcase(hcomid) eq "iel_i" or lcase(hcomid) eq "ielm_i") and tran eq "INV">
			substring_index(refno,'/',-1) desc,substring_index(substring_index(refno,'/',1),'.',-1) desc,substring_index(refno,'.',1) desc
		<cfelse>
		<cfif lcase(hcomid) eq "kingston_i">
        wos_date desc,right(refno,'4') desc
        <cfelseif lcase(hcomid) eq "sinlian_i">
        length(refno) desc,refno desc
        <cfelse>
		<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>wos_date desp,refno desp</cfif>
        </cfif>
		</cfif> 
		limit 20
	</cfquery>
</cfif>


<cfoutput>
<table align="center" class="data">
	<tr>
    	<td colspan="8">
		<div align="center">
		<font color="##336699" size="3" face="Arial, Helvetica, sans-serif"><strong>#words[2154]# #tranname#</strong></font></div></td>
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

	<cfloop query="gettransaction">
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<cfif getdisplaysetup.bill_refno eq 'Y'>
        <cfif lcase (hcomid) eq "fdipx_i">
      	<td nowrap align="center">
        #gettransaction.refno#
        </td>
        <cfelse>
        <td nowrap>
        <cfif getpin2.h3200 eq "T" and getpin2.h3210 eq "T" and  getpin2.h3220 eq "T" and getpin2.h3230 eq "T" and  getpin2.h3240 eq "T" and  getpin2.h3250 eq "T" and getpin2.h3260 eq "T" and  getpin2.h3270 eq "T" and  getpin2.h32E0 eq "T" and getpin2.h3920 eq "T">
                    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/salesstatus/orderstatus.cfm?refno=#URLEncodedFormat(refno)#&tran=#URLEncodedFormat(type)#')">#gettransaction.refno#</a>
        <cfelse>
        #gettransaction.refno#
        </cfif>
        </td>
        </cfif>
        </cfif>
        <cfif getdisplaysetup.bill_name eq 'Y'>
        <td nowrap>#gettransaction.desp#</td>
        </cfif>
        <cfif getdisplaysetup.bill_toinv eq 'Y'>
        <td nowrap>#gettransaction.toinv#</td>
        </cfif>
        <cfif getdisplaysetup.bill_refno2 eq 'Y'>
		<td nowrap>#gettransaction.refno2#</td>
        </cfif>
        <cfif getdisplaysetup.bill_SO eq 'Y'>
        <cfset sonolist=gettransaction.sono>
        <td><cfloop list="#sonolist#" delimiters="," index="i">#i#<br></cfloop></td>
        </cfif>
        <cfif getdisplaysetup.bill_PO eq 'Y'>
        <cfset ponolist=gettransaction.pono>
        
        <td><cfloop list="#ponolist#" delimiters="," index="i">#i#<br></cfloop></td>
        </cfif>
        <cfif getdisplaysetup.bill_agent eq 'Y'>
	  	<td nowrap>#gettransaction.agenno#</td>
        </cfif>
        <cfif getdisplaysetup.bill_driver eq 'Y'>
        <cfquery name="getvandesp" datasource="#dts#">
       				select name from driver where driverno='#gettransaction.van#'
        			</cfquery>
        <td nowrap>#gettransaction.van#- #getvandesp.name#</td>
        </cfif>
        <cfif getdisplaysetup.bill_project eq 'Y'>
        <td nowrap>#gettransaction.source#</td>
        </cfif>
        <cfif getdisplaysetup.bill_projectdesp eq 'Y'>
        <cfquery name="getprojectdesp" datasource="#dts#">
                    select project from #target_project# where source='#gettransaction.source#' and porj='P'
                    </cfquery>
        <td nowrap>#getprojectdesp.project#</td>
        </cfif>
        
        <cfif getdisplaysetup.bill_job eq 'Y'>
        <td nowrap>#gettransaction.job#</td>
        </cfif>
        <cfif getdisplaysetup.bill_date eq 'Y'>
      	<td nowrap>#dateformat(gettransaction.wos_date,"dd-mm-yyyy")#</td>
        </cfif>
        <cfif getdisplaysetup.bill_period eq 'Y'>
        <cfif lcase (hcomid) eq "fdipx_i">
      	<td align="center">#gettransaction.fperiod#</td>
        <cfelse>
        <td>#gettransaction.fperiod#</td>
        </cfif>
        </cfif>
        <cfif getdisplaysetup.bill_custno eq 'Y'>
		
      		<td nowrap>#gettransaction.custno# - #gettransaction.name# #gettransaction.frem1#</td>

        </cfif>
         <cfif getdisplaysetup.billbody_dadd eq 'Y'>
        <td nowrap>#gettransaction.frem7# #gettransaction.frem8#</td>
        </cfif>
        <cfif getdisplaysetup.bill_b_attn eq 'Y'>
        <td nowrap>#gettransaction.rem2#</td>
        </cfif>
        <cfif getdisplaysetup.bill_created eq 'Y'>
        <td nowrap>#gettransaction.created_by#</td>
        </cfif>
        <cfif getdisplaysetup.bill_currcode eq 'Y'>
        <td nowrap>#gettransaction.currcode#</td>
        </cfif>
        <cfif getdisplaysetup.bill_term eq 'Y'>
        <td nowrap>#gettransaction.term#</td>
        </cfif>
        <cfif getdisplaysetup.bill_totalqty eq 'Y'>
        <cfquery name="gettotalqty" datasource="#dts#">
        select sum(qty) as qty from ictran where refno='#refno#' and type='#tran#'
        </cfquery>
        <td nowrap align="center">#gettotalqty.qty#</td>
        </cfif>
        <cfif getdisplaysetup.bill_grand eq 'Y'>
        <td nowrap>#numberformat(gettransaction.grand_bil,',_.__')#</td>
        </cfif>
        <cfif getdisplaysetup.bill_permitno eq 'Y'>
        <td>#gettransaction.permitno#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem5 eq 'Y'>
        <td>#gettransaction.rem5#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem6 eq 'Y'>
        <td>#gettransaction.rem6#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem7 eq 'Y'>
        <td>#gettransaction.rem7#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem8 eq 'Y'>
        <td>#gettransaction.rem8#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem9 eq 'Y'>
        <td>#gettransaction.rem9#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem10 eq 'Y'>
        <td>#gettransaction.rem10#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem11 eq 'Y'>
        <td>#gettransaction.rem11#</td>
        </cfif>
        
		<cfif getdisplaysetup.bill_rem30 eq 'Y'>
    		<td>#gettransaction.rem30#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem31 eq 'Y'>
        	<td>#gettransaction.rem31#</td>
        </cfif>
        <cfif getdisplaysetup.bill_rem32 eq 'Y'>
        	<td>#gettransaction.rem32#</td>
        </cfif>
        
        <cfif lcase(hcomid) eq "fdipx_i">
        <cfquery name="get1stitem" datasource="#dts#">
        select desp from ictran where refno='#refno#' and type='#tran#' and itemcount = '1'
        </cfquery>
        <cfquery name="gettotalitem" datasource="#dts#">
        select itemno from ictran where refno='#refno#' and type='#tran#'
        </cfquery>
        <td nowrap>#get1stitem.desp#</td>
        <td nowrap align="center">#gettotalitem.recordcount#</td>
        </cfif>        
        <cfif lcase(hcomid) eq "poria_i">
        <td nowrap>#gettransaction.rem1#</td>
        </cfif>
         <cfif getdisplaysetup.bill_b_phone eq 'Y'>
        <td nowrap>#gettransaction.rem4#</td>
</cfif>
        <cfif getdisplaysetup.bill_d_attn eq 'Y'>
      	<td nowrap>#gettransaction.rem3#</td>
        </cfif>
        <cfif getdisplaysetup.bill_user eq 'Y'>
      	<td nowrap>#gettransaction.userid#</td>
        </cfif>
        <cfif lcase(hcomid) eq "visionlaw_i">
        <td nowrap>#gettransaction.updated_by#</td>
        </cfif>
        
		<cfif getdisplaysetup.bill_bodystatus eq 'Y'>

        <cfif lcase(hcomid) eq "fdipx_i" and tran eq "QUO">
        <cfquery name="getupdatedbills" datasource="#dts#">
        select type from iclink where frtype='#tran#' and frrefno='#refno#'
        </cfquery>
        <cfset updateddo=0>
        <cfset updatedinv=0>
        <cfset updatedpo=0>
        <cfset updatedcs=0>
        <cfloop query="getupdatedbills">
        <cfif type eq 'do'><cfset updateddo=1></cfif>
        <cfif type eq 'inv'><cfset updatedinv=1></cfif>
        <cfif type eq 'po'><cfset updatedpo=1></cfif>
        <cfif type eq 'cs'><cfset updatedcs=1></cfif>
        </cfloop>
        <cfif lcase(hcomid) eq "fdipx_i">
        <td align="center"><cfif updateddo eq 1>Y</cfif></td>
        <cfelse>
		<td><cfif updateddo eq 1>Y</cfif></td>

        </cfif>
        <td><cfif updatedinv eq 1>Y</cfif></td>
        <td><cfif updatedpo eq 1>Y</cfif></td>
        <td><cfif updatedcs eq 1>Y</cfif></td>
        <td><cfif toinv eq 'C'>Close</cfif></td>

        <cfelse>
	  	<td align="center">
        	<cfif tran eq 'SO' and lcase(hcomid) eq "litelab_i" and order_cl neq ''>
                        PO 
            </cfif>
			<cfif (tran eq 'DO' or tran eq 'PO' or tran eq 'SO' or tran eq 'QUO' or tran eq 'SAM' or tran eq 'SAMM' or tran eq 'RQ') and toinv eq 'C'>C<cfelseif (tran eq 'DO' or tran eq 'PO' or tran eq 'SO' or tran eq 'QUO' or tran eq 'SAM' or tran eq 'SAMM' or tran eq 'RQ') and toinv neq ''>Y</cfif>
            <!--- <cfif toinv eq 'ticket'> Ticket</cfif> --->
			<cfif (tran eq 'INV' or tran eq 'RC' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'PR') and gettransaction.posted neq ''>P</cfif>
			<cfif gettransaction.void neq ''><cfif (lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i") and rem49 eq "pending">Pending<cfelse><font color="red"><strong>Void</strong></font></cfif></cfif>
            <cfif (lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i") and rem49 eq "sent">Sent</cfif>
            <cfif tran eq 'PO' and toinv eq ''><cfif printstatus eq 'a3'>Approved</cfif></cfif>
            <cfif lcase(hcomid) eq "hunting_i" and tran eq 'SAM' and toinv eq '' and printstatus eq 'a3'>Approved</cfif>
<cfif lcase(hcomid) eq "asiasoft_i" and tran eq 'SO' and toinv eq '' and printstatus eq '' and (HUserGrpID eq "admin" or HUserGrpID eq "super" or HUserGrpID eq "general")>Req 1st App</cfif><cfif lcase(hcomid) eq "asiasoft_i" and tran eq 'SO' and toinv eq '' and printstatus eq 'a2' and (HUserGrpID eq "admin" or HUserGrpID eq "super")>Req Final App</cfif>
<cfif (lcase(hcomid) eq "asiasoft_i" or lcase(hcomid) eq "asaiki_i") and tran eq 'SO' and toinv eq '' and printstatus eq 'a3'>Approved</cfif>
<cfif lcase(hcomid) eq "asiasoft_i" and tran eq 'SO' and toinv eq '' and printstatus eq 'reject'>REJECTED</cfif>
<cfif lcase(hcomid) eq "net_i" and tran eq 'QUO' and toinv eq '' and printstatus eq 'a3'>Approved</cfif>
<cfif lcase(hcomid) eq "net_i" and tran eq 'QUO' and toinv eq '' and printstatus eq ''>Pending</cfif>
<cfif lcase(hcomid) eq "asiasoft_i" and tran eq 'SO'>
<cfdirectory action="list" directory="#HRootPath#\download\#dts#\bill\SO\#gettransaction.refno#" name="file_list">
<cfif file_list.recordcount neq 0>
<font style="color:red">Attached</font>
</cfif>
</cfif>
            
            <cfif lcase(hcomid) eq "polypet_i" and tran eq 'SAM'>
                        <cfif printstatus eq '1'>
                        Approved
						<cfelse>
                        Not Approved
						</cfif>
                        </cfif>
                        <cfif lcase(hcomid) eq "ltm_i" and toinv eq ''>
                        #gettransaction.rem45#
        				</cfif>
                        <cfif lcase(hcomid) eq "haikhim_i">
						<cfif printstatus eq 'a2'>Pending Approval<cfelseif printstatus eq 'a3'>Approved</cfif>
                        
                        </cfif>
						</td></cfif>
		
        </cfif>
        <cfif lcase(hcomid) eq "fixics_i">
                <td align="center"><cfif ticket neq ''>#ticket#</cfif><cfif left(toinv,2) eq 'DO'>DO<cfelseif toinv neq ''>INV</cfif></td>
        		</cfif>
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<td align="right" nowrap>
		  		<cfif getgeneralinfo.printoption eq 1>
					<a href="transaction3c.cfm?tran=#tran#&nexttranno=#refno#" target="_blank"><img height="18px" width="18px" src="../../images/PNG-48/Print.png" alt="Print" border="0"></a>
				<cfelse>
					<a href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#refno#" target="_blank"><img height="18px" width="18px" src="../../images/PNG-48/Print.png" alt="Print" border="0"></a>
				</cfif>
	
				<cfif aledit eq 1 and gettransaction.void eq "">
					<a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0"><img height="18px" width="18px" src="../../images/PNG-48/Modify.png" alt="Edit" border="0"></a>
				<cfelse>
					<img height="18px" width="18px" src="../../images/PNG-48/iModify.png" alt="Not Allowed to Edit" border="0">
				</cfif>
	
				<cfif aldelete eq 1 and gettransaction.void eq "">
					<a href="transaction1.cfm?tran=#tran#&ttype=Delete&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0"><img height="18px" width="18px" src="../../images/PNG-48/Delete.png" alt="Delete" border="0"></a>
				<cfelse>
					<img height="18px" width="18px" src="../../images/PNG-48/iDelete.png" alt="Not Allowed to Delete" border="0">
				</cfif>
				<cfif (tran eq "SO" and getpin2.h2886 eq 'T') or (tran eq "QUO" and (getpin2.h2875 eq 'T' or getpin2.h2876 eq 'T'))>
                	<cfif gettransaction.toinv neq "">
                    	<img height="18px" width="18px" src="../../images/PNG-48/Next_disabled.png" alt="Update" border="0">
					<cfelse>
						<a href="update2/update.cfm?tran=#tran#&nexttranno=#refno#"><img height="18px" width="18px" src="../../images/PNG-48/Next.png" alt="Update" border="0"></a>
					</cfif>
				</cfif>
			</td>
		<cfelse>
        <div id="getdepositajax"></div>
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
                
				<cfif lcase(hcomid) eq "guankeat_i" and gettransaction.rem49 eq "" and (tran eq "INV" or tran eq "CS")>
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('sendbilltoaps');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[808]#</a>
                
                </cfif>
                <cfif lcase(hcomid) eq "hunting_i" and gettransaction.printstatus neq "a3" and tran eq "Sam" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>		
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('approvesample');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
                
				</cfif>
                
                <cfif getGeneralInfo.poapproval eq 'Y' and gettransaction.printstatus neq "a3" and tran eq "PO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>		<input type="hidden" name="samid" id="samid" value="">
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('approvesample');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
                
				</cfif>
                <cfif getGeneralInfo.rqapproval eq 'Y' and gettransaction.printstatus neq "a3" and tran eq "RQ" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>		<input type="hidden" name="samid" id="samid" value="">
                <a style="cursor:pointer" onClick="document.getElementById('samid').value='#refno#';ColdFusion.Window.show('approvesample');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
				</cfif>
                <cfif (lcase(hcomid) eq "asiasoft_i" or lcase(hcomid) eq "asaiki_i") and gettransaction.printstatus neq "a3"  and gettransaction.printstatus neq "REJECT" and tran eq "SO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super" or HUserGrpID eq "General")><a style="cursor:pointer" onClick="document.getElementById('soid').value='#refno#';ColdFusion.Window.show('approveso');"><img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0">#words[848]#</a>
                
                </cfif>

				<cfif aledit eq 1 and gettransaction.void eq "">
                
					
                    <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i") and tran eq "SO">
                    <cfif (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                    <cfelseif permitno neq "locked">
                    <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
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
                            <a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                            
                            </cfif>
						<cfelse>
							<a href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[2155]#</cfif></a>
                            
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
                
                    <!---<cfif aledit eq 1 and gettransaction.void eq "">
                    	<cfif HUserGrpID eq "super" or lcase(hcomid) eq "eocean_i">
                    		<a onMouseOver="JavaScript:this.style.cursor='hand';" target="mainFrame" onClick="window.open('expresstranedit/index.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0','','fullscreen=yes,scrollbars=yes')">
                			<img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">New Edit</a>
                    	</cfif>
                    </cfif>
                    
                    <cfif <!---HUserGrpID eq "super" and---> (tran eq 'SO' or tran eq 'INV' or tran eq 'CN') and lcase(hcomid) eq "ltm_i">
                    <cfif aledit eq 1 and gettransaction.void eq "" and gettransaction.posted eq "">
						<cfif toinv eq ''>
                            <a onMouseOver="JavaScript:this.style.cursor='hand';" target="mainFrame" onClick="window.open('vehicletranedit/index.cfm?tran=#tran#&ttype=Edit&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#&first=0','','fullscreen=yes,scrollbars=yes')">
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
				<cfif aldelete eq 1 and (gettransaction.void eq "" or (lcase(hcomid) eq "haikhim_i" and tran eq "RQ"))>
					<a href="transaction1.cfm?tran=#tran#&ttype=Delete&refno=#URLEncodedFormat(refno)#&custno=#URLEncodedFormat(gettransaction.custno)#<!--- &bcode=&dcode= --->&first=0"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[805]#</cfif></a>
				<cfelse>
					<img height="18px" width="18px" src="../../images/delete.ICO" alt="Not Allowed to Delete" border="0"><cfif lcase(hcomid) neq 'fdipx_i'>#words[805]#</cfif>
				</cfif>
                </cfif>
            
            <cfif lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i">
            &nbsp;&nbsp;&nbsp;
            <cfif tran eq "PO" and rem49 eq "pending" and void eq "Y">
            <a href="/customized/hodaka_i/receivebill.cfm?tran=#tran#&refno=#URLEncodedFormat(refno)#">Receive</a>
            </cfif>
            <cfif tran eq "DO" and listfind("hodaka_i,hodakadist_i,hodakams_i,hodakapte_i,motoworld_i,hodakamy_i,hdkiv_i,motoworldvn_i",permitno,",") neq 0 and rem49 neq "sent">
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
</cfoutput>