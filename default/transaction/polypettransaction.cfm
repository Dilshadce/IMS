<cfparam name="alcreate" default="0">	<!--- Authority to Create New --->
<cfparam name="aledit" default="0">		<!--- Authority to Edit --->
<cfparam name="aldelete" default="0">	<!--- Authority to Delete --->
<cfparam name="alown" default="0">		<!--- Authority to View Own Document --->
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo1">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<cfif tran eq "RC">
  	<cfset tran = "RC">
  	<cfset tranname = getGeneralInfo1.lRC>
  	<cfset trancode = "rcno">
  	<cfset tranarun = "rcarun">

	<cfif getpin2.h2102 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "PR">
	<cfset tran = "PR">
	<cfset tranname = getGeneralInfo1.lPR>
	<cfset trancode = "prno">
	<cfset tranarun = "prarun">

	<cfif getpin2.h2201 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "DO">
	<cfset tran = "DO">
	<cfset tranname = getGeneralInfo1.lDO>
	<cfset trancode = "dono">
	<cfset tranarun = "doarun">

	<cfif getpin2.h2301 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "INV">
	<cfset tran = "INV">
	<cfset tranname = getGeneralInfo1.lINV>
	<cfset trancode = "invno">
	<cfset tranarun = "invarun">

	<cfif getpin2.h2401 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "CS">
	<cfset tran = "CS">
	<cfset tranname = getGeneralInfo1.lCS>
	<cfset trancode = "csno">
	<cfset tranarun = "csarun">

	<cfif getpin2.h2501 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "CN">
	<cfset tran = "CN">
	<cfset tranname = getGeneralInfo1.lCN>
	<cfset trancode = "cnno">
	<cfset tranarun = "cnarun">

	<cfif getpin2.h2601 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "DN">
	<cfset tran = "DN">
	<cfset tranname = getGeneralInfo1.lDN>
	<cfset trancode = "dnno">
	<cfset tranarun = "dnarun">

	<cfif getpin2.h2701 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "PO">
	<cfset tran = "PO">
	<cfset tranname = getGeneralInfo1.lPO>
	<cfset trancode = "pono">
	<cfset tranarun = "poarun">

	<cfif getpin2.h2861 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>

	<cfif getpin2.h2862 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>

	<cfif getpin2.h2863 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>

	<cfif getpin2.h2864 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfif tran eq "QUO">
	<cfset tran = "QUO">
	<cfset tranname = getGeneralInfo1.lQUO>
	<cfset trancode = "quono">
	<cfset tranarun = "quoarun">

	<cfif getpin2.h2871 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "SO">
	<cfset tran = "SO">
	<cfset tranname = getGeneralInfo1.lSO>
	<cfset trancode = "sono">
	<cfset tranarun = "soarun">

	<cfif getpin2.h2881 eq 'T'>
  		<cfset alcreate = 1>
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
</cfif>

<cfif tran eq "SAM">
	<cfset tran = "SAM">
	<cfset tranname = getGeneralInfo1.lSAM>
	<cfset trancode = "samno">
	<cfset tranarun = "samarun">

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
	<title><cfoutput>#tranname#</cfoutput> Main Page</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<script language="javascript" type="text/javascript">
	function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	} 
	</script>
</head>

<cfquery datasource="#dts#" name="getGeneralInfo">
	Select #trancode# as tranno,delinvoice, #tranarun#, invsecure,printoption,
	invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,ldriver,agentlistuserid,poapproval,rem5
	
		,generateQuoRevision,revStyle,generateQuoRevision1,ddltran

	from GSetup
</cfquery>

<!--- Add On 11-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
</cfquery>

<!--- <cfquery datasource="main" name="getRefnoset">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where userDept = '#dts#'
	and type = '#tran#'
	and counter = 1
</cfquery> --->

<cfquery datasource="#dts#" name="getRefnoset">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where type = '#tran#'
	and counter = 1
</cfquery>

<!--- ADD ON 29-04-2009 --->
<cfif lcase(HcomID) eq "mhca_i" and tran eq "INV">
	<cfquery datasource="#dts#" name="getRefnoset2">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#tran#'
		and counter = 2
	</cfquery>
</cfif>

	<cfquery datasource='#dts#' name="gettransaction">
		Select * 
		from artran 
		where type='#tran#' 
        
		<cfif alown eq 1>
			<cfif getGeneralInfo.agentlistuserid eq "Y">and (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%") or ucase(userid)='#ucase(huserid)#')
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
        
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
		</cfif> <!--- and fperiod <> '99' ---> 
		order by 
		<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>wos_date desc,refno desc</cfif>

		
	</cfquery>

<body>
 <cfif lcase(hcomid) eq "hunting_i" and tran eq "Sam" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
 <cfajaximport tags="cfform">
 <cfwindow name="approvesample" width="400" height="400" source="approvesample.cfm?tran=#tran#&refno={samid}" modal="true" title="Approval" closable="true" draggable="true" center="true" refreshonshow="true" />
 </cfif>
  <cfif getGeneralInfo.poapproval eq 'Y' and gettransaction.printstatus neq "a3" and tran eq "PO" and (HUserGrpID eq "Admin" or HUserGrpID eq "Super")>
  <cfajaximport tags="cfform">
 <cfwindow name="approvesample" width="400" height="400" source="approvesample.cfm?tran=#tran#&refno={samid}" modal="true" title="Approval" closable="true" draggable="true" center="true" refreshonshow="true" />
  </cfif>
<cfoutput><!---1. Match output at line 38 --->
<cfif husergrpid eq "Muser"><a href="../home2.cfm"><u>Home</u></a></cfif>
	<h1>#tranname# Main Menu</h1>
	<h4>
		<cfif alcreate eq 1>
			<cfif HcomID eq "pnp_i">
				<cfinclude template="../../pnp/get_authorised_multi_invoive.cfm">
			<cfelse>
				<cfif getgeneralinfo.invoneset neq '1' and tran eq 'INV'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.rc_oneset neq '1' and tran eq 'RC'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.pr_oneset neq '1' and tran eq 'PR'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.do_oneset neq '1' and tran eq 'DO'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.cs_oneset neq '1' and tran eq 'CS'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.cn_oneset neq '1' and tran eq 'CN'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.dn_oneset neq '1' and tran eq 'DN'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.iss_oneset neq '1' and tran eq 'ISS'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.po_oneset neq '1' and tran eq 'PO'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.so_oneset neq '1' and tran eq 'SO'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.quo_oneset neq '1' and tran eq 'QUO'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.assm_oneset neq '1' and tran eq 'ASSM'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.tr_oneset neq '1' and tran eq 'TR'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.oai_oneset neq '1' and tran eq 'OAI'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.oar_oneset neq '1' and tran eq 'OAR'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelseif getgeneralinfo.sam_oneset neq '1' and tran eq 'SAM'>
					<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
				<cfelse>
					<a href="transaction1.cfm?ttype=create&tran=#tran#&nexttranno=&first=0">Create New #tranname#</a>
				</cfif> || 
			</cfif>		
		</cfif>
		<!--- <a href="transaction.cfm?tran=#tran#">List All #tranname#</a> || --->
		<a href="stransaction.cfm?tran=#tran#&searchtype=&searchstr=">Search For #tranname#</a>
		<!---<cfif tran eq "SO" and hcomid eq "MSD">
		|| <a href="transaction_report.cfm?type=10">#tranname# Reports</a>
		</cfif>--->
        <cfif tran eq "QUO">
        ||<a href="closequo.cfm">Close #tranname#</a>
        </cfif>
         <cfif lcase(HcomID) eq "solidlogic_i"> || <a href="/default/transaction/printUnprint/printUnprint.cfm?tran=#tran#">Print Unprint #tranname#</a></cfif>
         <cfif lcase(hcomid) eq "polypet_i" and tran eq "CS">
         <cfif getpin2.H2890 eq 'T'>
         || <a href="/default/transaction/polypettransaction.cfm?tran=#tran#">Delivery</a>
         </cfif>
         </cfif>
	</h4>


	<hr>
</cfoutput><!---1. Match output at line 28 --->

<table align="center" class="data">
	<tr>
    	<td colspan="8">
		<div align="center">
		<font color="#336699" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>#tranname#</cfoutput></strong></font></div></td>
  	</tr>
  	<tr>
    	<th><cfoutput>#tranname#</cfoutput> No</th>
        <cfif lcase(hcomid) eq "visionlaw_i" and (tran eq "sam" or tran eq "so" or tran eq "quo")>
        <th>Description</th>
        <cfelse>
        <cfif lcase(hcomid) neq "fdipx_i">
		<th>Refno2</th>
        </cfif>
        </cfif>
        <th>Member</th>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
        <th>Pono</th>
        </cfif>
		<th>Agent</th>
        <cfif lcase(hcomid) eq "mastercare_i" and tran eq "sam">
        <th>Project</th>
        </cfif>
    	<th>Date</th>
    	<th>Period</th>
        <th>Total Amount</th>
    	<th>
			<cfif tran eq "rc" or tran eq "pr" or tran eq "po">
				Supplier Name
			<cfelse>
				<cfif lcase(hcomid) eq "ovas_i" and (tran eq "CS" or tran eq "DO" or tran eq "SO" or tran eq "SAM" or tran eq "CN" or tran eq "DN")><cfoutput>#getGeneralInfo.ldriver#</cfoutput><cfelse>Customer Name</cfif>
			</cfif>
		</th>
        <cfif lcase(hcomid) eq "fdipx_i">
        <th>Item No</th>
        <th>Total Item</th>
        </cfif>
        <cfif lcase(hcomid) eq "poria_i">
        <th>Delivery Code</th>
        </cfif>
    	<th>User</th>
        <cfif lcase(hcomid) eq "visionlaw_i">
        <th>Edit User</th>
        </cfif>
        <cfif lcase(hcomid) eq "fdipx_i" and tran eq "QUO">
        <th>DO</th>
        <th>INV</th>
        <th>PO</th>
        <th>CS</th>
        <cfelse>
		<th>Status</th>
        </cfif>
    	<th>Action</th>
  	</tr>

	<cfoutput query="gettransaction">
    <cfquery name="getitemdelivery" datasource="#dts#">
                select itemno from ictran where refno='#refno#' and type='#tran#' and brem1 = 'Delivery' and brem2 = '' and refno not in (select dono from artran where type='CS')
    </cfquery>
    <cfquery name="getsumdelivery" datasource="#dts#">
                select sum(amt) as amt from ictran where refno='#refno#' and type='#tran#' and brem1 = 'Delivery' and brem2 = '' and refno not in (select dono from artran where type='CS')
    </cfquery>
    <cfif getitemdelivery.recordcount neq 0>
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      	<td nowrap>#gettransaction.refno#</td>
        <cfif lcase(hcomid) eq "visionlaw_i" and (tran eq "sam" or tran eq "so" or tran eq "quo")>
        <td nowrap>#gettransaction.desp#</td>
        <cfelse>
        <cfif lcase(hcomid) neq "fdipx_i">
		<td nowrap>#gettransaction.refno2#</td>
        </cfif>
        </cfif>
        <cfquery name="getvandesp" datasource="#dts#">
        select name from driver where driverno='#gettransaction.van#'
        </cfquery>
        <td nowrap>#gettransaction.van# - #getvandesp.name#</td>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
        <cfset ponolist=gettransaction.pono>
        
        <td><cfloop list="#ponolist#" delimiters="," index="i">#i#<br></cfloop></td>
        </cfif>
	  	<td nowrap>#gettransaction.agenno#</td>
        <cfif lcase(hcomid) eq "mastercare_i" and tran eq "sam">
        <td nowrap>#gettransaction.source#</td>
        </cfif>
      	<td nowrap>#dateformat(gettransaction.wos_date,"dd-mm-yyyy")#</td>
      	<td>#gettransaction.fperiod#</td>
        <td>#numberformat(getsumdelivery.amt,',_.__')#</td>
		<cfif lcase(hcomid) eq "ovas_i" and (tran eq "CS" or tran eq "DO" or tran eq "SO" or tran eq "SAM" or tran eq "CN" or tran eq "DN")>
			<td nowrap>#gettransaction.van# - #gettransaction.drivername#</td>
		<cfelse>
      		<td nowrap>#gettransaction.custno# - #gettransaction.name#</td>
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
        <td nowrap>#gettransaction.rem1#</td>
        </cfif>
      	<td nowrap>#gettransaction.userid#</td>
        <cfif lcase(hcomid) eq "visionlaw_i">
        <td nowrap>#gettransaction.updated_by#</td>
        </cfif>
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
        <td><cfif updateddo eq 1>Y</cfif></td>
        <td><cfif updatedinv eq 1>Y</cfif></td>
        <td><cfif updatedpo eq 1>Y</cfif></td>
        <td><cfif updatedcs eq 1>Y</cfif></td>

        <cfelse>
	  	<td align="center">
			<cfif (tran eq 'DO' or tran eq 'PO' or tran eq 'SO' or tran eq 'QUO' or tran eq 'SAM' or tran eq 'SAMM') and toinv eq 'C'>C<cfelseif (tran eq 'DO' or tran eq 'PO' or tran eq 'SO' or tran eq 'QUO' or tran eq 'SAM' or tran eq 'SAMM') and toinv neq ''>Y</cfif>
			<cfif (tran eq 'INV' or tran eq 'RC' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'PR') and gettransaction.posted neq ''>P</cfif>
			<cfif gettransaction.void neq ''><font color="red"><strong>Void</strong></font></cfif>
            <cfif tran eq 'PO' and toinv eq ''><cfif printstatus eq 'a3'>Approved</cfif></cfif>
            <cfif lcase(hcomid) eq "hunting_i" and tran eq 'SAM' and toinv eq '' and printstatus eq 'a3'>Approved</cfif>
		</td>
        </cfif>
		
	      	<td align="right" nowrap>
                <img height="18px" width="18px" src="../../images/Copy Icon.jpg" alt="Copy" border="0"><a onMouseOver="this.style.cursor='hand'" onClick="window.open('polypetcopyfunction.cfm?refno=#refno#&type=#tran#');">Delivery</a>
                
			</td>

    </tr>
    </cfif>
  	</cfoutput>
</table>
<!--- REMARK ON 180608, MOVE THE LINK TO THE TOP --->
<!--- <p><strong><br>Last Used <cfoutput>#tran#</cfoutput> No :</strong><font color="#FF0000"><strong><cfoutput>#getGeneralInfo.tranno#</cfoutput></strong></font></p> --->

<!---cfif tran eq "DO">
	<cfif getpin2.h2305 eq 'T'>
		<p><br><strong>Update From Delivery Order: </strong><h2><a href="update/update.cfm?t1=DO&t2=INV" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('updateBtn','','../../images/userdefinedmenu/arrow1.png',1)"><img src="../../images/userdefinedmenu/arrow.png" alt="Update to Invoice!" name="updateBtn" border="0"> To Invoice</a></h2><br></p>
	</cfif>
</cfif--->

<!---cfif tran eq "PO">
	<p><br><strong>Update From Purchase Order: </strong>
	<cfif getpin2.h2865 eq 'T'>
		<h2><a href="update/update.cfm?t1=PO&t2=RC" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('updateBtn2','','../../images/userdefinedmenu/tfp_twp26.gif',1)"><img src="../../images/userdefinedmenu/tfp_twp2.gif" alt="Update to Purchase Receive!" name="updateBtn2" border="0"> To Purchase Receive</a>&nbsp;&nbsp;&nbsp;&nbsp;
	</cfif>
	<!--- ADD ON 130608, THE LINK FOR EXPORT THE PO TO DO --->
	<a href="update/updateA.cfm?t1=PO&t2=DO" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('updateBtn3','','../../images/userdefinedmenu/tfp_twp26.gif',1)"><img src="../../images/userdefinedmenu/tfp_twp2.gif" alt="Update to Delivery Order!" name="updateBtn3" border="0"> To Delivery Order</a></h2></p>
</cfif--->

<!---cfif tran eq "SO">
	<cfif getpin2.h2885 eq 'T'>
		<p><br><strong>To Delivery Order from Sales Order: </strong><h2><a href="update/update.cfm?t1=SO&t2=DO">Click Here!</a></h2><br></p>
	</cfif>

	<cfif getpin2.h2886 eq 'T'>
		<p><br><strong>To Invoice from Sales Order: </strong><h2><a href="update/update.cfm?t1=SO&t2=INV">Click Here!</a></h2><br></p>
	</cfif>

	<cfif getpin2.h2887 eq 'T'>
		<p><br><strong>To Purchase Order from Sales Order: </strong><h2><a href="update/update.cfm?t1=SO&t2=PO">Click Here!</a></h2><br></p>
	</cfif>
</cfif--->

<!---cfif tran eq "QUO">
	<cfif getpin2.h2875 eq 'T'>
		<p><br><strong>To Sales Order from Quotation: </strong><h2><a href="update/update.cfm?t1=QUO&t2=SO">Click Here!</a></h2><br></p>
	</cfif>

	<cfif getpin2.h2876 eq 'T'>
		<p><br><strong>To Invoice from Quotation: </strong><h2><a href="update/update.cfm?t1=QUO&t2=INV">Click Here!</a></h2></p>
	</cfif>
</cfif--->

</body>
</html>