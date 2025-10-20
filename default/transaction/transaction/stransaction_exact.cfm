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
	<cfset tranname = getGeneralInfo.lRQ>
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
	invoneset ,agentlistuserid
	from gsetup;
</cfquery>

<cfquery name="getrecordcount" datasource="#dts#">
	select count(refno) as totalrecord from artran 
	where type='#tran#' and <cfif searchType eq 'brem2'>refno in (select refno from ictran where brem2= binary('#searchstr#') and type='#tran#')<cfelseif searchType eq 'allphone'>
		(rem4 = binary('#searchstr#') or
        frem6 = binary('#searchstr#') or
        phonea = binary('#searchstr#') or
        rem12 = binary('#searchstr#') or
        comm4 = binary('#searchstr#')
        )<cfelse>#searchtype#=binary('#searchstr#') </cfif>
	<cfif alown eq 1>
	<cfif getGeneralInfo.agentlistuserid eq "Y">and (ucase(artran.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%") or ucase(artran.userid)='#ucase(huserid)#')
			<cfelse>
            and (ucase(artran.userid)='#ucase(huserid)#' or ucase(artran.agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentid like "%#ucase(huserid)#%")))  
			</cfif>
	</cfif>
	;
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
	
	<cfform action="stransaction_exact.cfm?tran=#urlencodedformat(tran)#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#" method="post" target="_self">
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
		
		<cfquery datasource='#dts#' name="getjob">
			select 
			artran.type,
			artran.refno,
			artran.refno2,
            artran.job,
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
			artran.agenno,
			artran.wos_date,
            artran.source,
            artran.pono,
            artran.updated_by,
            artran.created_by,
            artran.frem7,
            artran.rem1,
			artran.fperiod,
			artran.custno,
			artran.name,
			artran.userid,
			artran.posted,
			toinv,
			(select phone from #target_table# where custno=artran.custno) as phone 
			from artran 
			where type='#tran#' and <cfif searchType eq 'brem2'>artran.refno in (select refno from ictran where brem2= binary('#searchstr#')  and type='#tran#')<cfelseif searchType eq 'allphone'>
		(rem4 = binary('#searchstr#') or
        frem6 = binary('#searchstr#') or
        phonea = binary('#searchstr#') or
        rem12 = binary('#searchstr#') or
        comm4 = binary('#searchstr#')
        )<cfelse>artran.#searchtype#=binary('#searchstr#') </cfif>
			<cfif alown eq 1>
			<cfif getGeneralInfo.agentlistuserid eq "Y">and (ucase(artran.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%") or ucase(artran.userid)='#ucase(huserid)#')
			<cfelse>
            and (ucase(artran.userid)='#ucase(huserid)#' or ucase(artran.agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentid like "%#ucase(huserid)#%")))  
			</cfif>
			</cfif>
			<!--- and fperiod <> '99' ---> 
			order by artran.wos_date desc ,artran.refno desc 
			limit #start-1#,20;
		</cfquery>

		<cfif start neq 1>
			|| <a target="_self" href="stransaction_exact.cfm?tran=#tran#&start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="stransaction_exact.cfm?tran=#tran#&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
		</div>
		<hr>

		<table align="center" class="data">
  			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td colspan="9"><div align="center"><font color="336699" size="3" face="Arial, Helvetica, sans-serif"><strong>#tranname#</strong></font></div></td>
  			</tr>
            <tr>
            	<cfif getdisplaysetup.bill_refno eq 'Y'>
   	 			<th>#tranname# No</th>
                </cfif>
                <cfif getdisplaysetup.bill_toinv eq 'Y'>
                <th>To Inv</th>
                </cfif>
                <cfif getdisplaysetup.bill_refno2 eq 'Y'>
				<th>Refno2</th>
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
                <cfif getdisplaysetup.bill_PO eq 'Y'>
      			<th>Pono</th>
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
                <cfif getdisplaysetup.custno eq 'Y'>
				<th>
				<cfif tran eq "RC" or tran eq "PR" or tran eq "PO">
					Supplier Name
				<cfelse>
					Customer Name
				</cfif>
				</th>
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
                <cfif getdisplaysetup.bill_user eq 'Y'>
				<th>User</th>
                </cfif>
                <cfif lcase(hcomid) eq "visionlaw_i">
                <th>Edit User</th>
                </cfif>
				<th>Status</th>
				<th>Action</th>
 		 	</tr>
			
			<cfloop query="getjob">
				<tr>
                	<cfif getdisplaysetup.bill_refno eq 'Y'>
      				<td>#getjob.refno#</td>
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
                    <cfif getdisplaysetup.bill_refno eq 'Y'>
                    <td nowrap>#getjob.van#</td>
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
      				<td nowrap>#getjob.custno# - #getjob.name#</td>
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
                    <cfif getdisplaysetup.bill_user eq 'Y'>
      				<td>#getjob.userid#</td>
                    </cfif>
                    <cfif lcase(hcomid) eq "visionlaw_i">
                    <td>#getjob.updated_by#</td>
                    </cfif>
                    
	  				<td align="center">
						<cfif tran eq 'DO' and toinv neq ''>
							Y
						</cfif>
						<cfif (tran eq 'INV' or tran eq 'RC' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN') and getjob.posted neq ''>
							P
						</cfif>
					</td>
          			<td align="right" nowrap>
                    <cfif getmodule.auto eq "1" and tran eq 'INV'>
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('paybill.cfm?type=#type#&refno=#refno#','_blank','height=630,width=700,scrollbar=yes,')">Pay</a>
					</cfif>
		  			<cfif getgeneralinfo.printoption eq 1>
						<a target="_blank" href="transaction3c.cfm?tran=#tran#&nexttranno=#refno#">Print</a>&nbsp;
					<cfelse>
						<a target="_blank" href="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#refno#">Print</a>&nbsp;
					</cfif>
 	  	  			<cfif lcase(hcomid) eq "msd_i" and tran eq "RC" and getpin2.h2101 eq "T">
	  	    			|&nbsp;<a target="_blank" href="../reports/grn_note.cfm?tran=#tran#&nexttranno=#refno#">GRN Note</a>&nbsp;
 		  			</cfif>
		  			<cfif aledit eq 1>
		  				<a target="_parent" href="tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
							<img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit
						</a>
					</cfif>
                    <cfif getpin2.H2890 eq 'T'>
                <img height="18px" width="18px" src="../../images/Copy Icon.jpg" alt="Copy" border="0"><a onMouseOver="this.style.cursor='hand'" onClick="window.open('copyfunction.cfm?refno=#refno#&type=#tran#');">Copy</a>
                </cfif>
            		<cfif aldelete eq 1>
						<a target="_parent" href="transaction1.cfm?tran=#tran#&ttype=Delete&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
							<img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete
						</a>
					</cfif>
                    
				</td>
    		</tr>
  		</cfloop>
		</table>
		<hr>
		<div align="right">
		<cfif start neq 1>
			<a target="_self" href="stransaction_exact.cfm?tran=#tran#&start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="stransaction_exact.cfm?tran=#tran#&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Next</a> ||
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