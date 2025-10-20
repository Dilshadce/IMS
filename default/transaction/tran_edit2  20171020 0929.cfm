<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1827,2159,2152,11,98,1825,1289,440,9,104,902,886,953,955,897,1170,954,23,957,958,890,892,40,38,39,42,300,45,2157,2158,2156,1421,889,1088,58,5,972,900,1091,969,971,48,67,2154,793,782,664,188,665,666,185,689,667,690,668,673,674,961,835,2151,721,718,719,720,722,723,724,980,692,726,725,727,728,2152,698,960,2153,745,694,748,1782,1849,813,696,814,815,816,817,818,819,820,821,822,697,698,749,106,704,16,702,29,703,40,795,752,441,300,753,506,475,754,759,1692,1358,695,757,65,887,668,781,784,783,892,785,786,787,788,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1716,1717,1288,705,706,10,3,808,848,2155,806,805,804">
<cfinclude template="/latest/words.cfm">

<cfset session.hcredit_limit_exceed = "N">
<cfset session.bcredit_limit_exceed = "Y">
<cfset session.customercode = custno>
<cfset session.tran_refno = refno>
<cfajaximport tags="cfform">
<cfajaximport tags="cfwindow,cflayout-tab"> 
<cfparam name="alcreate" default="0">
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ,ldescription,bodyso,bodypo,bodydo

	from GSetup
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * 
    from modulecontrol
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select tran_edit_term 
    from dealer_menu 
    limit 1
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * 
    from displaysetup2
</cfquery>

<cfif tran eq "RC">
  	<cfset tranname = words[664]>
  	<cfset trancode = "rcno">
  	<cfset tranarun = "rcarun">

	<cfif getpin2.h2102 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "PR">
  	<cfset tranname = words[188]>
  	<cfset trancode = "prno">
  	<cfset tranarun = "prarun">

	<cfif getpin2.h2201 eq 'T'>
 		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "DO">
	<cfset tranname = words[665]>
	<cfset trancode = "dono">
    <cfset tranarun = "doarun">

	<cfif getpin2.h2301 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "INV">
  	<cfset tranname = words[666]>

	<cfif isdefined("form.invset")>
  		<cfset trancode = form.invset>
  		<cfset tranarun = form.tranarun>
  	<cfelse>
  		<cfset trancode = "invno">
  		<cfset tranarun = "invarun">
  	</cfif>

	<cfif getpin2.h2401 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "CS">
  	<cfset tranname = words[185]>
  	<cfset trancode = "csno">
  	<cfset tranarun = "csarun">

	<cfif getpin2.h2501 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "CN">
  	<cfset tranname = words[689]>
  	<cfset trancode = "cnno">
  	<cfset tranarun = "cnarun">

	<cfif getpin2.h2601 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "DN">
  	<cfset tranname = words[667]>
  	<cfset trancode = "dnno">
  	<cfset tranarun = "dnarun">

	<cfif getpin2.h2701 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "PO">
  	<cfset tranname = words[690]>
  	<cfset trancode = "pono">
  	<cfset tranarun = "poarun">

	<cfif getpin2.h2861 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "RQ">
  	<cfset tranname = words[961]>
  	<cfset trancode = "rqno">
  	<cfset tranarun = "rqarun">

	<cfif getpin2.h28G1 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "QUO">
  	<cfset tranname = words[668]>
  	<cfset trancode = "quono">
  	<cfset tranarun = "quoarun">

	<cfif getpin2.h2871 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SO">
  	<cfset tranname = words[673]>
  	<cfset trancode = "sono">
  	<cfset tranarun = "soarun">

	<cfif getpin2.h2881 eq 'T'>
 		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SAM">
	<cfset tranname = words[674]>
	<cfset trancode = "samno">
	<cfset tranarun = "samarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SAMM" and lcase(hcomid) eq "hunting_i">
	<cfset tranname = "Sales Order">
	<cfset trancode = "sammno">
	<cfset tranarun = "sammarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfquery name="getGsetup" datasource="#dts#">
  Select ADDONREMARK,#trancode# as tranno, #tranarun# as arun, g.* from GSetup g
</cfquery>

<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
  	<cfquery name="getcustomer" datasource="#dts#">
		select custno,name,name2,currcode from #target_apvend# where custno ='#custno#'
  	</cfquery>

	<cfset ptype = target_apvend>
<cfelse>
  	<cfquery name="getcustomer" datasource="#dts#">
		select custno,name,name2,currcode from #target_arcust# where custno ='#custno#'
  	</cfquery>

	<cfset ptype = target_arcust>
</cfif>

<!--- ADD ON 23-02-2009, PURPOSE: NET_I NEW PO FORMAT --->
<cfif (lcase(hcomid) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "PO">
	<cfquery name="getarcust" datasource="#dts#">
		select custno,name from #target_arcust# order by custno
  	</cfquery>
</cfif>

<cfquery name="currency" datasource="#dts#">
  	select * 
	from #target_currency# 
	where currcode='#getcustomer.currcode#'
</cfquery>

<!--- <cfquery name="getdriver" datasource="#dts#">
	select driverno,attn from driver where customerno = '#custno#' and customerno <>'' order by driverno
</cfquery> --->

<!--- EDITED ON 17-06-2009 --->
<!--- <cfif lcase(hcomid) eq "topsteel_i">
	<cfquery name="getdriver" datasource="#dts#">
		select driverno,name,attn from driver where (customerno = '#custno#' or customerno ='') order by driverno
	</cfquery>
<cfelseif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
	<cfquery name="getdriver" datasource="#dts#">
		select driverno,name,attn from driver order by driverno
	</cfquery>
<cfelse>
	<cfquery name="getdriver" datasource="#dts#">
		select driverno,name,attn from driver where customerno = '#custno#' and customerno <>'' order by driverno
	</cfquery>
</cfif> --->

<cfquery name="getdriver" datasource="#dts#">
	select driverno,name,name2,attn from driver where (customerno = '#custno#' or customerno ='') order by driverno
</cfquery>

<cfquery name="getagent" datasource="#dts#">
  select agent 
  from #target_icagent# 
  where 0=0 
  and (discontinueagent='' or discontinueagent is null) <cfif getpin2.h1B40 eq 'T'>and (agent = '#huserid#' or agentid = '#huserid#' or agentlist like "%#ucase(huserid)#%")</cfif> order by agent
</cfquery>

<cfquery name="getterm" datasource="#dts#">
  select * from #target_icterm# order by term
</cfquery>

<!--- ADD ON 10-12-2009 --->

	<cfquery name="getProject" datasource="#dts#">
	  select * 
      from #target_project# 
      where porj = "P" and completed != 'Y'
      order by source;
	</cfquery>
	
	<cfquery name="getProject2" datasource="#dts#">
	  select * 
      from #target_project# 
      where porj = "J" 
      order by source;
	</cfquery>

<!---
<cfquery name="getGsetup" datasource="#dts#">
  Select #trancode# as tranno, #tranarun# as arun, invoneset, from GSetup
</cfquery>
--->
<!--- REMARK ON 10-12-2009 --->
<!--- <cfquery name="getGsetup" datasource="#dts#">
  Select #trancode# as tranno, #tranarun# as arun, g.* from GSetup g
</cfquery> --->

<cfquery name="getlocation" datasource="#dts#">
	select location,desp from iclocation order by desp
</cfquery>

<cfquery datasource='#dts#' name="getartran">
	select * from artran where refno='#refno#' and type = "#tran#"
</cfquery>

<cfif lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "chemline_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakasia_i" or lcase(hcomid) eq "techpakbill_i">
    <cfquery datasource='#dts#' name="getcomment">
		select * from comments order by code desc 
	</cfquery>
</cfif>

<cfif lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "winbells_i" or lcase(HcomID) eq "iel_i" or 
lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i" or lcase(HcomID) eq "chemline_i" or 
lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i" or lcase(HcomID) eq "probulk_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakasia_i" or lcase(hcomid) eq "techpakbill_i">

	<cfquery datasource='#dts#' name="getartran_remark">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_remark.recordcount neq 0>
		<cfset xremark1=tostring(getartran_remark.remark1)>
		<cfset xremark2=tostring(getartran_remark.remark2)>
		<cfset xremark3=tostring(getartran_remark.remark3)>
		<cfset xremark4=tostring(getartran_remark.remark4)>
		<cfset xremark5=tostring(getartran_remark.remark5)>
		<cfset xremark6=tostring(getartran_remark.remark6)>
		<cfset xremark7=tostring(getartran_remark.remark7)>
		<cfset xremark8=tostring(getartran_remark.remark8)>
		<cfset xremark9=tostring(getartran_remark.remark9)>
		<cfset xremark10=tostring(getartran_remark.remark10)>
		<cfif lcase(HcomID) eq "winbells_i">
			<cfset xremark11=tostring(getartran_remark.remark11)>
			<cfset xremark12=tostring(getartran_remark.remark12)>
			<cfset xremark13=tostring(getartran_remark.remark13)>
			<cfset xremark14=tostring(getartran_remark.remark14)>
			<cfset xremark15=tostring(getartran_remark.remark15)>
			<cfset xremark16=tostring(getartran_remark.remark16)>
			<cfset xremark17=tostring(getartran_remark.remark17)>
		</cfif>
	<cfelse>
		<cfset xremark1 = "">
		<cfset xremark2 = "">
		<cfset xremark3 = "">
		<cfset xremark4 = "">
		<cfset xremark5 = "">
		<cfset xremark6 = "">
		<cfset xremark7 = "">
		<cfset xremark8 = "">
		<cfset xremark9 = "">
		<cfset xremark10 = "">
		<cfif lcase(HcomID) eq "winbells_i">
			<cfset xremark11 = "">
			<cfset xremark12 = "">
			<cfset xremark13 = "">
			<cfset xremark14 = "">
			<cfset xremark15 = "">
			<cfset xremark16 = "">
			<cfset xremark17 = "">
		</cfif>
	</cfif>
</cfif>
<!--- Add on 290608 --->
<!--- <cfif lcase(HcomID) eq "avent_i">
	<!--- <cfquery datasource='#dts#' name="getartran_comment">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_comment.recordcount neq 0>
		<cfset comment = tostring(getartran_comment.remark1)>
		<cfset designation = tostring(getartran_comment.remark2)>
		<cfset fobcif = tostring(getartran_comment.remark3)>
	<cfelse>
		<cfset comment = "">
		<cfset designation = "">
		<cfset fobcif = "">
	</cfif> --->
	<cfquery datasource='#dts#' name="getartran_remark">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_remark.recordcount neq 0>
		<cfset xremark1 = tostring(getartran_remark.remark1)>
		<cfset xremark2 = tostring(getartran_remark.remark2)>
		<cfset xremark3 = tostring(getartran_remark.remark3)>
	<cfelse>
		<cfset xremark1 = "">
		<cfset xremark2 = "">
		<cfset xremark3 = "">
	</cfif>
<cfelseif lcase(HcomID) eq "topsteel_i">
	<cfquery datasource='#dts#' name="getartran_remark">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_remark.recordcount neq 0>
		<cfset xremark1 = tostring(getartran_remark.remark1)>
		<cfset xremark2 = tostring(getartran_remark.remark2)>
	<cfelse>
		<cfset xremark1 = "">
		<cfset xremark2 = "">
	</cfif>
<cfelseif lcase(HcomID) eq "winbells_i">
	<cfquery datasource='#dts#' name="getartran_remark">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_remark.recordcount neq 0>
		<cfset xremark1=tostring(getartran_remark.remark1)>
		<cfset xremark2=tostring(getartran_remark.remark2)>
		<cfset xremark3=tostring(getartran_remark.remark3)>
		<cfset xremark4=tostring(getartran_remark.remark4)>
		<cfset xremark5=tostring(getartran_remark.remark5)>
		<cfset xremark6=tostring(getartran_remark.remark6)>
		<cfset xremark7=tostring(getartran_remark.remark7)>
		<cfset xremark8=tostring(getartran_remark.remark8)>
		<cfset xremark9=tostring(getartran_remark.remark9)>
		<cfset xremark10=tostring(getartran_remark.remark10)>
		<cfset xremark11=tostring(getartran_remark.remark11)>
		<cfset xremark12=tostring(getartran_remark.remark12)>
		<cfset xremark13=tostring(getartran_remark.remark13)>
		<cfset xremark14=tostring(getartran_remark.remark14)>
		<cfset xremark15=tostring(getartran_remark.remark15)>
		<cfset xremark16=tostring(getartran_remark.remark16)>
		<cfset xremark17=tostring(getartran_remark.remark17)>
	<cfelse>
		<cfset xremark1 = "">
		<cfset xremark2 = "">
		<cfset xremark3 = "">
		<cfset xremark4 = "">
		<cfset xremark5 = "">
		<cfset xremark6 = "">
		<cfset xremark7 = "">
		<cfset xremark8 = "">
		<cfset xremark9 = "">
		<cfset xremark10 = "">
		<cfset xremark11 = "">
		<cfset xremark12 = "">
		<cfset xremark13 = "">
		<cfset xremark14 = "">
		<cfset xremark15 = "">
		<cfset xremark16 = "">
		<cfset xremark17 = "">
	</cfif>
<cfelseif lcase(HcomID) eq "iel_i">
	<cfquery datasource='#dts#' name="getartran_remark">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_remark.recordcount neq 0>
		<cfset xremark1 = tostring(getartran_remark.remark1)>
		<cfset xremark2 = tostring(getartran_remark.remark2)>
		<cfset xremark3=tostring(getartran_remark.remark3)>
		<cfset xremark4=tostring(getartran_remark.remark4)>
	<cfelse>
		<cfset xremark1 = "">
		<cfset xremark2 = "">
		<cfset xremark3 = "">
		<cfset xremark4 = "">
	</cfif>
<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
	<cfquery datasource='#dts#' name="getartran_remark">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_remark.recordcount neq 0>
		<cfset xremark1 = tostring(getartran_remark.remark1)>
	<cfelse>
		<cfset xremark1 = "">
	</cfif>
<cfelseif lcase(HcomID) eq "chemline_i">
	<cfquery datasource='#dts#' name="getartran_remark">
		select * from artran_remark where refno='#refno#' and type = "#tran#"
	</cfquery>
    <cfif getartran_remark.recordcount neq 0>
		<cfset xremark1 = tostring(getartran_remark.remark1)>
		<cfset xremark2=tostring(getartran_remark.remark2)>
		<cfset xremark3=tostring(getartran_remark.remark3)>
		<cfset xremark4=tostring(getartran_remark.remark4)>
		<cfset xremark5=tostring(getartran_remark.remark5)>
		<cfset xremark6=tostring(getartran_remark.remark6)>
		<cfset xremark7=tostring(getartran_remark.remark7)>
		<cfset xremark8=tostring(getartran_remark.remark8)>
	<cfelse>
		<cfset xremark1 = "">
		<cfset xremark2 = "">
		<cfset xremark3 = "">
		<cfset xremark4 = "">
		<cfset xremark5 = "">
		<cfset xremark6 = "">
		<cfset xremark7 = "">
		<cfset xremark8 = "">
	</cfif>
</cfif> --->

<!--- Add on 290608 --->
<cfif getpin2.h2E00 eq 'T'>
<cfif dateformat(getartran.wos_date,'YYYY-MM-DD') neq dateformat(now(),'YYYY-MM-DD')>
<h3>Transaction is not created Today</h3>
	<cfabort>
    </cfif>
</cfif>

<cfif getGsetup.alloweditposted neq 'Y'>
	<cfif getartran.posted eq "P">
        <h3>Transaction already posted.</h3>
        <cfabort>
    </cfif>
</cfif>

<cfif HuserID NEQ 'ultraprinesh'>
	<cfif getartran.toinv neq ''>
        <cfif getGsetup.enableedit eq 'Y'>
        <cfelse>
            <h3>Not Allowed to Edit.</h3>
            <cfabort>
        </cfif>
    </cfif>
</cfif>    
<!--- ADD ON 27-03-2009 --->
<cfif HuserID NEQ 'ultraprinesh'>
	<cfif getartran.fperiod eq '99' and getgsetup.allowedityearend neq "Y" >
        <h3>Not Allowed to Edit. Transaction already year-ended.</h3>
        <cfabort>
    <cfelseif getartran.fperiod eq '99' and getgsetup.allowedityearend  eq "Y" and tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM" and tran neq "RC">
    <h3>Not Allowed to Edit. Transaction already year-ended.</h3>
        <cfabort>
    </cfif>
</cfif>

<!--- Add on 06-02-2009 --->
<!--- REMOVE ON 29-07-2009 --->
<!--- <cfif lcase(HcomID) eq "net_i"> --->
<cfif getGsetup.periodalfr neq "01">
	<cfloop from="1" to="#val(getGsetup.periodalfr)-1#" index="a">
		<cfif val(getartran.fperiod) eq val(a)>
			<h3>Period Allowed from <cfoutput>#getGsetup.periodalfr# to 18.</cfoutput></h3>
			<cfabort>
		</cfif>
	</cfloop>
</cfif>
<!--- </cfif> --->

<cfset Bil_Custno=getartran.custno>

<cfif tran eq 'SAM'>
        <cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_apvend# where custno = "#custno#"
                union all
                Select name, name2,currcode,agent from #target_arcust# where custno = "#custno#"
      		</cfquery>
<cfelse>
<cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
	<cfquery datasource="#dts#" name="getcustomere">
		Select name, name2,currcode,agent from #target_apvend# where custno="#custno#"
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getcustomere">
		Select name, name2,currcode,agent from #target_arcust# where custno="#custno#"
	</cfquery>
</cfif>
</cfif>
<cfset name =getartran.name>
<cfset name2 =getartran.frem1>

<!--- Remark on 080808 and replace with the below one --->
<cfif getartran.currcode neq "">
	<cfset xcurrcode = getartran.currcode>
<cfelseif getcustomere.currcode NEQ ''>
	<cfset xcurrcode = getcustomere.currcode>
<cfelse>
    <cfquery name="getCompanyCurrency" datasource="#dts#">
		SELECT bcurr 
        FROM gsetup;
	</cfquery>
    
	<cfset xcurrcode = getCompanyCurrency.bcurr>    
</cfif>

<cfset currrate = getartran.currrate>
<cfset wos_type = getartran.type>
<cfset readpreiod = getartran.fperiod>
<cfset refno2 = getartran.refno2>
<cfset desp = getartran.desp>
<cfset despa = getartran.despa>
<cfset xterm = getartran.term>
<cfset xsource = getartran.source>
<cfset xjob = getartran.job>
<!--- Remark on 06-02-2009 and replace with the below one --->
<cfset xagenno = getartran.agenno>
<!--- <cfset xagenno = getcustomere.agent> --->
<cfset xdriverno = getartran.van>
<cfset pono = getartran.pono>
<cfset dono = getartran.dono>
<cfset sono = getartran.sono>
<cfset quono = getartran.quono>
<cfset nDateCreate = getartran.wos_date>
<cfset nDateCreate2 = getartran.tran_date>
<cfset remark0 = getartran.rem0>
<cfset remark2 = getartran.rem2>
<cfset remark4 = getartran.rem4>
<cfset remark5 = getartran.rem5>
<cfset remark6 = getartran.rem6>
<cfset remark7 = getartran.rem7>
<cfset remark8 = getartran.rem8>
<cfset remark9 = getartran.rem9>
<cfset remark10 = getartran.rem10>
<cfset remark11 = getartran.rem11>
<cfset permitno = getartran.permitno>
<cfset frem0 = getartran.frem0>
<cfset frem1 = getartran.frem1>
<cfset frem2 = getartran.frem2>
<cfset frem3 = getartran.frem3>
<cfset frem4 = getartran.frem4>
<cfset frem5 = getartran.frem5>
<cfset remark13 = getartran.rem13>
<cfset frem6 = getartran.frem6>
<cfset phonea = getartran.phonea>
<cfset e_mail = getartran.e_mail>
<cfset postalcode = getartran.postalcode>
<cfset d_postalcode = getartran.d_postalcode>
<cfset b_gstno = getartran.b_gstno>
<cfset d_gstno = getartran.d_gstno>
<cfset returnbillno = getartran.returnbillno>
<cfset returnreason = getartran.returnreason>
<cfset returndate = getartran.returndate>

<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV'>
	<cfset remark1 = getartran.rem1>
	<cfset remark3 = getartran.rem3>
	<cfset remark12 = getartran.rem12>
	<cfset frem7 = getartran.frem7>
	<cfset frem8 = tostring(getartran.frem8)>
	<cfset frem9 = getartran.frem9>
	<cfset comm0 = getartran.comm0>
	<cfset comm1 = getartran.comm1>
	<cfset comm2 = getartran.comm2>
	<cfset comm3 = getartran.comm3>
	<cfset remark14 = getartran.rem14>
	<cfset comm4 = getartran.comm4>
    <cfset d_phone2 = getartran.d_phone2>
    <cfset d_email = getartran.d_email>
<cfelse>
	<cfset remark1 = getartran.rem1>
	<cfset remark3 = getartran.rem3>
	<cfset remark12 = getartran.rem12>
	<cfset remark14 = getartran.rem14>
	<cfset frem7 = getartran.frem7>
	<cfset frem8 = tostring(getartran.frem8)>
	<cfset frem9 = getartran.frem9>
	<cfset comm0 = getartran.comm0>
	<cfset comm1 = getartran.comm1>
	<cfset comm2 = getartran.comm2>
	<cfset comm3 = getartran.comm3>
	<cfset comm4 = getartran.comm4>
    <cfset d_phone2 = getartran.d_phone2>
    <cfset d_email = getartran.d_email>
</cfif>
<cfif getGsetup.collectaddress eq 'Y'>
	<cfset remark15 = getartran.rem15>
	<cfset remark16 = getartran.rem16>
	<cfset remark17 = getartran.rem17>
	<cfset remark18 = getartran.rem18>
	<cfset remark19 = getartran.rem19>
	<cfset remark20 = getartran.rem20>
	<cfset remark21 = getartran.rem21>
	<cfset remark22 = getartran.rem22>
	<cfset remark23 = getartran.rem23>
	<cfset remark24 = getartran.rem24>
	<cfset remark25 = getartran.rem25>
</cfif>
<cfif lcase(hcomid) eq 'ugateway_i'>
	<cfset via = getartran.via>      
</cfif>
<cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
	<cfset checkno = getartran.checkno> 
</cfif>

<cfset currefno = refno>
<cfset userid = getartran.userid>
<cfset title = "Mode = Edit ">
<cfset button = "Edit">
	
<html>
<head>
	<title><cfoutput>#tranname#</cfoutput></title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link href="../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/stylesheet/style.css"/>
	
	<script src="../../scripts/CalendarControl.js" language="javascript"></script>
	<script type="text/javascript" src="/scripts/prototype.js"></script>
	<script type="text/javascript" src="/scripts/effects.js"></script>
	<script type="text/javascript" src="/scripts/controls.js"></script>
	<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<script language="JavaScript">
	function validatetime(fieldid)
	{
		re = /^(\d{1,2})\/(\d{1,2})\/(\d{4}) (\d{1,2}):(\d{2})$/;
		
		
	<!---if(document.getElementById(fieldid).value != '' && !document.getElementById(fieldid).value.match(re)) {
      alert("Invalid datetime format: " + document.getElementById(fieldid).value);
      document.getElementById(fieldid).focus();
    }---->
	
	if(document.getElementById(fieldid).value != '') {
      if(regs = document.getElementById(fieldid).value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 31) {
          alert("Invalid value for day: " + regs[1]);
          document.getElementById(fieldid).focus();
        }
        // month value between 1 and 12
        if(regs[2] < 1 || regs[2] > 12) {
          alert("Invalid value for month: " + regs[2]);
          document.getElementById(fieldid).focus();
        }
        // year value between 1902 and 2012
        if(regs[3] < 1902 || regs[3] > (new Date()).getFullYear()) {
          alert("Invalid value for year: " + regs[3] + " - must be between 1902 and " + (new Date()).getFullYear());
          document.getElementById(fieldid).focus();
        }
		if(regs[4] > 23) {
            alert("Invalid value for hours: " + regs[4]);
            document.getElementById(fieldid).focus();
          }
		  if(regs[5] > 59) {
          alert("Invalid value for minutes: " + regs[5]);
          document.getElementById(fieldid).focus();
        }
      } else {
        alert("Invalid date format: " + document.getElementById(fieldid).value);
        document.getElementById(fieldid).focus();
      }
	}
	}
	
		function updateDriver(drno,drname){
			myoption = document.createElement("OPTION");
			myoption.text = drno + " - " + drname;
			myoption.value = drno;
			document.invoicesheet.driver.options.add(myoption);
			var indexvalue = document.getElementById("driver").length-1;
			document.getElementById("driver").selectedIndex=indexvalue;
		}
		function updatejob(jobno){
			myoption = document.createElement("OPTION");
			myoption.text = jobno;
			myoption.value = jobno;
			document.invoicesheet.Job.options.add(myoption);
			var indexvalue = document.getElementById("job").length-1;
			document.getElementById("job").selectedIndex=indexvalue;
		}
		function updateProject(Projectno){
			myoption = document.createElement("OPTION");
			myoption.text = Projectno;
			myoption.value = Projectno;
			document.invoicesheet.Source.options.add(myoption);
			var indexvalue = document.getElementById("Source").length-1;
			document.getElementById("Source").selectedIndex=indexvalue;
		}
		function checkupdate(){
			if(document.getElementById("searchdriver").value ==''){
				document.getElementById("driver").value='';
			}
		}
		function selectlist(varval,varattb){		
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++) 
		{
			if (varval==document.getElementById(varattb).options[idx].value) 
			{
				document.getElementById(varattb).options[idx].selected=true;
				
			}
		}
		}
		function updateremark6(){
		selectlist(document.getElementById('remark61').value,'remark6');
		selectlist(document.getElementById('remark71').value,'remark7');
		selectlist(document.getElementById('remark81').value,'remark8');
		selectlist(document.getElementById('remark131').value,'remark13');
		}
		
		function updateascendremark6(){
		setTimeout("document.getElementById('remark6').value=document.getElementById('ascendremark61').value+' To '+document.getElementById('ascendremark62').value;",1500);
		}
		function checkcurrency()
		{
		<cfoutput>
		<cfif lcase(hcomid) eq 'maranroad_i' or lcase(hcomid) eq 'asramaraya_i'>
		var oldrate = #Numberformat(val(listfirst(currrate)), ".__________")#;
		<cfelse>
		var oldrate = #Numberformat(val(listfirst(currrate)), "._______")#;
		</cfif>
		</cfoutput>
		oldrate = oldrate * 1;
		var newrate = document.getElementById('currrate').value * 1;
		var changes = oldrate - newrate;
		var checkedcheck = document.getElementById('itemrate').checked;
		if(changes != 0 && checkedcheck == false)
		{
		var answer = confirm("Are you sure don't want to update item rate?");
		if(answer)
		{
		return true;
		}
		else
		{
		return false;
		}
		}
		else
		{
		return true;
		}
		}
		
		function updateshipvia2()
		{
		setTimeout("document.getElementById('remark10').value=document.getElementById('hidshipvia').value",500);

		}
		
		function getvehicle2(vehino){
				myoption = document.createElement("OPTION");
				myoption.text = vehino;
				myoption.value = vehino;
				document.invoicesheet.remark5.options.add(myoption);
				var indexvalue = document.getElementById("remark5").length-1;
				document.getElementById("remark5").selectedIndex=indexvalue;
		}
		
	</script>
</head>

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<cfif isdefined('url.jsoff') eq false> <script for="feedcontact1" event="ondatasetcomplete">show_info(this.recordset);</script></cfif>

<cfif lcase(HcomID) eq "avt_i">
<body onLoad="textCounter(document.invoicesheet.remark11,document.invoicesheet.remLen,254);">
<cfelse>
<body>
</cfif>

<cfoutput>
<br>
</cfoutput>
<cfif isdefined('url.jsoff')>
<cfset formname = "invoicesheetpost">
<cfset formid = "invoicesheetpost">
<cfelse>
<cfset formname = "invoicesheet">
<cfset formid = "invoicesheet">
</cfif>
<cfform name="#formname#" id="#formid#" action="transaction3.cfm" method="post" onsubmit="return checkcurrency();">

  	<cfoutput>
	<input type="hidden" name="type" id="type" value="Edit">
	<input type="hidden" name="tran" id="tran" value="#tran#">
	<input type="hidden" name="currefno" id="currefno" value="#refno#">
	
	<cfif isdefined("form.invset")>
		<input type="hidden" name="invset" id="invset" value="#listfirst(invset)#">
		<input type="hidden" name="tranarun" id="tranarun" value="#listfirst(tranarun)#">
	</cfif>
	<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
    <cfset permitnodisplay=getdisplaysetup2.permitno_pur>
    <cfset rem5display=getdisplaysetup2.hremark5_pur>
    <cfset rem6display=getdisplaysetup2.hremark6_pur>
    <cfset rem7display=getdisplaysetup2.hremark7_pur>
    <cfset rem8display=getdisplaysetup2.hremark8_pur>
    <cfset rem9display=getdisplaysetup2.hremark9_pur>
    <cfset rem10display=getdisplaysetup2.hremark10_pur>
    <cfset rem11display=getdisplaysetup2.hremark11_pur>
    
    <cfset quodisplay=getdisplaysetup2.quo_pur>
    <cfset sodisplay=getdisplaysetup2.so_pur>
    <cfset dodisplay=getdisplaysetup2.do_pur>
    <cfset podisplay=getdisplaysetup2.po_pur>
    
    <cfset billtoadd_code=getdisplaysetup2.billtoadd_code_pur>
    <cfset deladd_code=getdisplaysetup2.deladd_code_pur>
    <cfset billattn=getdisplaysetup2.billattn_pur>
    <cfset delattn=getdisplaysetup2.delattn_pur>
    <cfset billtel=getdisplaysetup2.billtel_pur>
    <cfset deltel=getdisplaysetup2.deltel_pur>
    
    <cfelse>
    <cfset permitnodisplay=getdisplaysetup2.permitno>
    <cfset rem5display=getdisplaysetup2.hremark5>
    <cfset rem6display=getdisplaysetup2.hremark6>
    <cfset rem7display=getdisplaysetup2.hremark7>
    <cfset rem8display=getdisplaysetup2.hremark8>
    <cfset rem9display=getdisplaysetup2.hremark9>
    <cfset rem10display=getdisplaysetup2.hremark10>
    <cfset rem11display=getdisplaysetup2.hremark11>
    <cfset quodisplay=getdisplaysetup2.quo>
    <cfset sodisplay=getdisplaysetup2.so>
    <cfset dodisplay=getdisplaysetup2.do>
    <cfset podisplay=getdisplaysetup2.po>
    
    <cfset billtoadd_code=getdisplaysetup2.billtoadd_code>
    <cfset deladd_code=getdisplaysetup2.deladd_code>
    <cfset billattn=getdisplaysetup2.billattn>
    <cfset delattn=getdisplaysetup2.delattn>
    <cfset billtel=getdisplaysetup2.billtel>
    <cfset deltel=getdisplaysetup2.deltel>
    
    </cfif>

	<table align="center" class="data" border="0" cellpadding="1" cellspacing="0">
	<tr>
		<th width="115">#tranname# #words[58]#</th>
		<td width="94"><h3>#currefno#</h3></td>
		<!--- To do a marking for Update Unit Cost, because the form.type will be change after back from Transaction4.cfm --->
		<td nowrap>
			<cfif tran eq "RC">
				<!---Replace Checkbox updunitcost --->
				<cfinclude template = "transaction2_check_update_unit_cost.cfm">
				<!---Replace Checkbox updunitcost --->
			</cfif>		</td>
		<th>#words[1088]#</th>
		<td width="209"><h2>#words[2155]# #tranname#</h2></td>
	</tr>
	<tr>
		<th <cfif getdisplaysetup2.billdate neq "Y">style="visibility:hidden"</cfif>>#tranname# #words[702]#</th>
		<td colspan="2" <cfif getdisplaysetup2.billdate neq "Y">style="visibility:hidden"</cfif>>
			<input type="text" name="invoicedate" size="10" value="#dateformat(nDateCreate,"dd/mm/yyyy")#" readonly>(DD/MM/YYYY)		</td>
		
        <th height="20" <cfif getdisplaysetup2.refno2 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq 'ascend_i' and tran eq 'INV'>PO No<cfelse>#words[1692]#</cfif></th>
		<td <cfif getdisplaysetup2.refno2 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="refno2" value="#refno2#" <cfif lcase(hcomid) eq 'elsiedan_i'> maxlength="35"<cfelse>maxlength="24"</cfif>></td>
	</tr>
	<tr>
		<th <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>>#iif(tran eq 'RC' or tran eq 'PR' or tran eq 'PO',DE('#words[104]#'),DE('#words[5]#'))# #words[58]#</th>
		<td colspan="2" <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>><input type="text" name="custno" value="#custno#" readonly></td>
		<th  <cfif getdisplaysetup2.currency neq "Y">style="visibility:hidden"</cfif>>#words[9]#</th>
		<td  <cfif getdisplaysetup2.currency neq "Y">style="visibility:hidden"</cfif>>
			<input name="refno3" type="text" size="10" value="#listfirst(xcurrcode)#" readonly>
            <cfif lcase(hcomid) eq 'maranroad_i' or lcase(hcomid) eq 'asramaraya_i'>
            <input name="currrate" id="currrate" type="text" size="10" value="#Numberformat(listfirst(currrate), ".__________")#">
            <cfelse>
			<input name="currrate" id="currrate" type="text" size="10" value="#Numberformat(listfirst(currrate), "._______")#">
            </cfif>
			<input type="Button" name="UpdCurrRate" value="#words[98]#" onClick="displayrate(),displayname()">
			<input type="checkbox" style="visibility:hidden" name="itemrate" id="itemrate" value="1" checked><!---Item Rate--->		</td>
	</tr>
    <cfif lcase(hcomid) eq "keminates_i">
		<tr>
        <th></th>
        <td colspan="2"></td>
        <th>Firm</th>
        <td>
                <cfquery name="getkeminatesfirm" datasource="#dts#">
                	select firm from firm order by firm
                </cfquery>
                	<select name="permitno" id="permitno" onChange="ajaxFunction(document.getElementById('getfirmagentAjaxField'),'kerminatesagentAjax.cfm?firm='+this.value)">
	          			<option value="">Choose a Firm</option>
	          			<cfloop query="getkeminatesfirm">
	            			<option value="#firm#"<cfif permitno eq firm>selected</cfif>>#firm#</option>
	          			</cfloop>
					</select>
        </td>
        </tr>
    </cfif>
    
	<tr>
		<td>&nbsp;</td>
		<td colspan="2" <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>><input name="name" type="text" size="40" maxlength="40" value="#convertquote(name)#" readonly></td>
		<th <cfif getdisplaysetup2.enduser neq "Y">style="visibility:hidden"</cfif>>#words[1358]#</th>
		<td <cfif getdisplaysetup2.enduser neq "Y">style="visibility:hidden"</cfif>>
        <!---
			<cfif getGsetup.filterall eq "1"  and lcase(hcomid) neq "iel_i" and lcase(hcomid) neq "ielm_i" and lcase(hcomid) neq "huanhong_i" and lcase(hcomid) neq "bakersoven11_i">
				<cfquery name="getdrivername" datasource="#dts#">
					select name from driver where driverno='#xdriverno#'
				</cfquery>
				<cfif getdrivername.recordcount eq 0>
					<cfset drname="">
				<cfelse>
					<cfset drname="#xdriverno# - #getdrivername.name#">
				</cfif>
				<input id="searchdriver" name="searchdriver" type="text" size="30" value="#drname#"/>
                <input id="driver" name="driver" type="hidden" value="#xdriverno#" />
				<div id="hint" class="autocomplete"></div>
                <cfif isdefined('url.jsoff') eq false>
                <script type="text/javascript">
					var url = "/ajax/functions/getRecord.cfm";
						
					new Ajax.Autocompleter("searchdriver","hint",url,{afterUpdateElement : getSelectedId});
						
					function getSelectedId(text, li) {
						$('driver').value=li.id;
					}
				</script>
                </cfif>
			<cfelse>--->
           		<cfif lcase(hcomid) eq "keminates_i">
                <cfif trim(permitno) neq "">
                <cfquery name="getdriver" datasource="#dts#">
                	select driverno from firmbody where firm="#permitno#"
                </cfquery>
                </cfif>
                <div id="getfirmagentAjaxField">
                <select name="driver" id="driver">
					<option value="">#words[2159]# #getGsetup.lDRIVER#</option>
          		<cfloop query="getdriver">
            		<option value="#getdriver.driverno#"<cfif xdriverno eq getdriver.driverno>Selected</cfif>>#getdriver.driverno#</option>
          		</cfloop>
				</select>			
                </div>
                
                <cfelse>
                
				<select name="driver" id="driver">
					<option value="">#words[2159]# #getGsetup.lDRIVER#</option>
					<cfloop query="getdriver">
						<option value="#driverno#"<cfif '#xdriverno#' eq '#driverno#'>selected</cfif>>#driverno# - #name# #name2#</option>
					</cfloop>
				</select>
                <a style="cursor:pointer" onClick="ColdFusion.Window.show('searchmember')">#words[11]#</a>
                
                <cfif getpin2.h1C10 eq 'T'>&nbsp;<a href="driver.cfm?type=Create" target="_blank">#words[2152]#</a></cfif>
            </cfif>
                <cfif huserid eq 'ultralung'>#xdriverno#</cfif>
			<!---</cfif>--->
					</td>
	</tr>
	<tr>
		<td height="23"></td>
		<td colspan="2" <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>><input name="name2" type="text" size="40" maxlength="40" value="#name2#" readonly></td>
		<th <cfif getdisplaysetup2.agent neq "Y">style="visibility:hidden"</cfif>>#words[29]#</th>
		<td <cfif getdisplaysetup2.agent neq "Y">style="visibility:hidden"</cfif>>
        <cfif lcase(HcomID) eq "netsource_i" and (tran eq "QUO" or tran eq "SO" or tran eq "DO" or tran eq "SAM" or tran eq "INV" or tran eq "CS")>
        <input type="text" name="agenno" id="agenno" value="#xagenno#" readonly>
        
        <cfelse>
        <select name="agenno" id="select"  <cfif lcase(HcomID) eq "hyray_i">onChange="ajaxFunction(document.getElementById('keeptrackbug'),'/default/transaction/keeptrackbug.cfm?agenno='+this.value+'&type=update&fieldtype=agent&custno=#custno#&tran=#tran#&refno=#currefno#');"</cfif>
        <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>
onChange="ajaxFunction(document.getElementById('projectjobajaxfield'),'/default/transaction/transactionprojectjobajax.cfm?agenno='+this.value);"
        </cfif>
        >
      
			<cfif getpin2.h1B40 neq 'T' or getagent.recordcount eq 0>
            <cfif lcase(hcomid) neq "uniq_i" or tran neq "PO">
				<option value="">#words[2159]# #getGsetup.lAGENT#</option>
			</cfif>
            </cfif>
           
			<cfloop query="getagent">
            
				<option value="#getagent.agent#"<cfif trim(xagenno) eq getagent.agent>Selected</cfif>>#getagent.agent#</option>
                
			</cfloop>
			</select>		
            </cfif></td>
	</tr>
	<tr>
    
		<th height="25" <cfif getdisplaysetup2.descp neq "Y">style="visibility:hidden"</cfif>>#gettranname.ldescription#</th>
		<td colspan="2" <cfif getdisplaysetup2.descp neq "Y">style="visibility:hidden"</cfif>><input name="desp" type="text" size="40" maxlength="40" value="#desp#"></td>
		<th <cfif getdisplaysetup2.terms neq "Y">style="visibility:hidden"</cfif>>#words[67]#</th>
		<td <cfif getdisplaysetup2.terms neq "Y">style="visibility:hidden"</cfif>>
        <cfif lcase(HcomID) eq "netsource_i">
            <input type="text" name="terms" id="terms" value="#xterm#" readonly>
        <cfelse>
        <select name="terms" id="terms" <cfif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i">onChange="ChgDueDate()" <cfelseif lcase(hcomid) eq "techdirect_i">onChange="ChgDueDate2()"</cfif><cfif getdealer_menu.tran_edit_term neq 'Y'>onfocus="this.defaultIndex=this.selectedIndex;" onchange="this.selectedIndex=this.defaultIndex;"</cfif>> <!---<cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i">onChange="updatetermdetail()"</cfif>--->
				<option value="">#words[2159]# #getGsetup.lterm#</option>
				<cfloop query="getterm">
					<option value="#term#" title="#getterm.days#"<cfif xterm eq term>Selected</cfif>>#term# <cfif lcase(hcomid) eq 'fdipx_i'>- #getterm.desp#</cfif></option>
				</cfloop>
			</select>	<div id="termajax"></div> 	
         </cfif></td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
		<td colspan="2" <cfif getdisplaysetup2.descp neq "Y">style="visibility:hidden"</cfif>><input name="despa" type="text" size="40" maxlength="40" value="#despa#"></td>
        
        <cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>
            
            <cfquery name="getProject" datasource="#dts#">
            	select source,(select project from #target_project# where porj = "P" and source=a.source)as project from artran as a where agenno="#xagenno#" and (void='' or void is null) group by source
              order by source
            </cfquery>
            
           	<cfquery name="getProject2" datasource="#dts#">
              select * from #target_project# where porj = "J" and  source='#Huserjob#' order by source
            </cfquery>
            
        </cfif>
        
		<cfif getGsetup.projectbybill eq "1">
			<th <cfif getdisplaysetup2.project neq "Y">style="visibility:hidden"</cfif>><!--- Project / Job --->#words[506]#  <cfif lcase(HcomID) neq "ascend_i"><cfif getmodule.job eq "1">/ #words[475]#</cfif></cfif></th>
			<td <cfif getdisplaysetup2.project neq "Y">style="visibility:hidden"</cfif>>
            <div id="projectjobajaxfield"><!---for weiken--->
            <select name="Source" id="Source" <cfif lcase(HcomID) eq "ascend_i">onChange="document.getElementById('desp').value=document.getElementById('source').options[selectedIndex].title"</cfif>>
					<option value="">#words[2159]# <!--- Project --->#getGsetup.lPROJECT#</option>
					<cfloop query="getProject">
						<option title="#getproject.project#" value="#getProject.source#"<cfif xSource eq getProject.source>Selected</cfif>><cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>#getproject.project#<cfelse>#getProject.source#<cfif lcase(HcomID) eq "ascend_i" or lcase(HcomID) eq "atc2005_i">-#getproject.project#</cfif></cfif></option>
					</cfloop>
				</select>
                <a onMouseOver="JavaScript:this.style.cursor='hand';" ><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findproject');" /></a>
                <cfif lcase(HcomID) eq "ascend_i" or getmodule.job neq "1" or getpin2.h1ZA0 neq "T"> <div style="visibility:hidden"></cfif>
               
				<select name="Job" id="Job">
					<option value="">#words[2159]# <!--- Job --->#getGsetup.lJOB#</option>
					<cfloop query="getProject2">
						<option value="#getProject2.source#"<cfif xJob eq getProject2.source> Selected</cfif> >#getProject2.source#</option>
					</cfloop>
                    
				</select>
				<img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findjob');" />
				<cfif lcase(HcomID) eq "ascend_i" or getmodule.job neq "1" or getpin2.h1ZA0 neq "T"> </div></cfif> </div>
                </td>
        
		<cfelseif getGsetup.jobbyitem eq "Y">
        <th><!--- Project / Job --->#getGsetup.lPROJECT# / #getGsetup.lJOB#</th>
			<td><select name="Source" id="Source">
					<option value="">#words[2159]# <!--- Project --->#getGsetup.lPROJECT#</option>
					<cfloop query="getProject">
						<option value="#getProject.source#"<cfif xSource eq getProject.source>Selected</cfif>>#getProject.source#<cfif lcase(HcomID) eq "ascend_i">-#getProject.Project#</cfif></option>
					</cfloop>
				</select>
                
                <a onMouseOver="JavaScript:this.style.cursor='hand';" ><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findproject');" /></a>
                <input type="hidden" name="Job" id="Job" value="#xJob#"></td>
		<cfelse>
			<input type="hidden" name="Source" id="Source" value="#xSource#">
			<input type="hidden" name="Job" id="Job" value="#xJob#">
			<td colspan="2"></td>
		</cfif>
	</tr>
    <cfif getGsetup.projectbybill eq "1" or getGsetup.jobbyitem eq "Y">
    <tr>
    <cfif getGsetup.transactiondate eq "Y">
    <th><cfif lcase(hcomid) eq "supervalu_i">Bill Date<cfelse>Transaction Date</cfif></th>
		<td colspan="2">
			<input type="text" name="transactiondate" size="10" value="#dateformat(nDateCreate2,"dd/mm/yyyy")#" readonly>(DD/MM/YYYY)		</td>
	<cfelse>
        <td></td>
        <td></td>
        <td></td>
        </cfif>
        <th></th>
        <td <cfif getdisplaysetup2.project neq "Y">style="visibility:hidden"</cfif>><a onClick="ColdFusion.Window.show('createProjectAjax');" onMouseOver="this.style.cursor='hand';" >#words[2152]# #getgsetup.lproject#</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <cfif getmodule.job eq "1">
 <cfif lcase(hcomid) neq "ascend_i">
        <a onClick="ColdFusion.Window.show('createJobAjax');" onMouseOver="this.style.cursor='hand';" >#words[2152]# #getgsetup.ljob#</a></cfif></cfif></td>
        </tr>
        <cfelse>
        <tr>
        <cfif getGsetup.transactiondate eq "Y">
    <th><cfif lcase(hcomid) eq "supervalu_i">Bill Date<cfelse>Transaction Date</cfif></th>
		<td colspan="2">
			<input type="text" name="transactiondate" size="10" value="#dateformat(nDateCreate2,"dd/mm/yyyy")#" readonly>(DD/MM/YYYY)		</td>
        <td></td>
        <td></td>
	<cfelse>
        <td></td>
        <td></td>
        <td></td>
        </cfif>
        <td></td>
        <td></td>
        </tr>
        </cfif>
     <cfif lcase(HcomID) eq 'taftc_i'>
     <cfquery name="getprojectwsq" datasource="#dts#">
     select wsq from #target_project# where source="#getartran.source#"
     </cfquery>
      <tr>
      <td></td><td></td><td></td>
        <th>WSQ Competency Codes :</th>
        <td colspan="4"><cftextarea name="WSQ" id="WSQ" cols="50" rows="7" bind="cfc:tran2cfc.getwsq('#dts#',{Source})">#getprojectwsq.wsq#</cftextarea></td>
      </tr>
      </cfif>
      <cfif tran eq 'DO' and getdisplaysetup2.invnoindo eq 'Y'>
      <tr>
      <th>#words[887]#</th><td>#getartran.toinv#</td>
      </tr>
      </cfif>
	<tr><td height="20" colspan="5"><hr></td></tr>
    <cfif getGsetup.bcurr eq "MYR" and (tran eq "CN" or tran eq "DN" or tran eq "PR")>
         <tr><th><cfif tran eq "PR">Purchase Receive No<cfelse>Invoice No</cfif></th>
            <td><cfinput type="text" name="returnbillno" id="returnbillno" value="#returnbillno#" required="yes" message="Please Key In Related Bill No"></td>
            <td></td>
            <th>Reason</th>
            <td><cfinput type="text" name="returnreason" id="returnreason" value="#returnreason#" size="40" maxlength="100" required="yes" message="Please Key Reason"></td>
         </tr>
         <tr><th><cfif tran eq "PR">Purchase Receive<cfelse>Invoice</cfif> Date</th>
            <td><cfinput type="text" name="returndate" id="returndate" value="#returndate#" required="yes" message="Please Key In Date"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(returndate);">(DD/MM/YYYY)</td>
         </tr>
        <cfelse>
        <input type="hidden" name="returnbillno" id="returnbillno" value="#returnbillno#" >
        <input type="hidden" name="returnreason" id="returnreason" value="#returnreason#" >
        <input type="hidden" name="returndate" id="returndate" value="#returndate#" >
        </cfif>
    <tr>
    <th <cfif quodisplay neq "Y">style="display:none"</cfif>>#words[668]#</th>
    <td <cfif quodisplay neq "Y">style="display:none"</cfif>><input type="text" name="quono" value="#quono#" size="40" maxlength="100"></td>
    <td></td>
    </tr>
    
    <tr>
    <th <cfif sodisplay neq "Y">style="visibility:hidden"</cfif>>#words[752]#</th>
    <td <cfif sodisplay neq "Y">style="visibility:hidden"</cfif>><input type="text" name="sono" value="#sono#" size="40" maxlength="35"></td>
    <td></td>
    <th <cfif permitnodisplay neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "fdipx_i">Invoice No.<cfelseif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">Factory<cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">Validity<cfelseif lcase(hcomid) eq "apnt_i">Inv No<cfelseif lcase(hcomid) eq "atc2005_i">Tag<cfelseif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>Status<cfelseif lcase(hcomid) eq "draco_i">Job Type (Others)
    <cfelseif lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i">
    Transfer To
    <cfelse>#words[788]#</cfif></th>
    <td <cfif permitnodisplay neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
        <select name="permitno">
        <option value="BLK 20" <cfif permitno eq 'BLK 20'>selected</cfif>>BLK 20</option>
        <option value="BLK 22" <cfif permitno eq 'BLK 22'>selected</cfif>>BLK 22</option>
        </select>
    <cfelseif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>
    <select name="permitno">
        <option value="" <cfif permitno eq ''>selected</cfif>></option>
        <option value="locked" <cfif permitno eq 'locked'>selected</cfif>>Locked</option>
        </select>
	<cfelseif lcase(hcomid) eq "atc2005_i">
    <cfquery datasource="#dts#" name="getshelf">
	select * from icshelf order by shelf
	</cfquery>
        <select name="permitno">
        <option value="">Choose a tag</option>
        <cfloop query="getshelf">
        <option value="#getshelf.shelf#" <cfif permitno eq getshelf.shelf>selected</cfif>>#getshelf.shelf# - #getshelf.desp#</option>
        </cfloop>
        
        </select>
    <cfelseif lcase(hcomid) eq "hodaka_i" or lcase(hcomid) eq "hodakadist_i" or lcase(hcomid) eq "hodakams_i" or lcase(hcomid) eq "hodakapte_i" or lcase(hcomid) eq "motoworld_i" or lcase(hcomid) eq "hodakamy_i" or lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "hdkiv_i" or lcase(hcomid) eq "motoworldvn_i">
    <cfif getartran.rem49 eq "send">
    <input type="text" name="permitno" value="#permitno#" size="40" maxlength="80" readonly>
    <cfelse>
    <select name="permitno" id="permitno">
    <option value="">Please Choose Receive Company</option>
    <cfloop list="hodaka_i,hodakadist_i,hodakams_i,hodakapte_i,motoworld_i,hodakamy_i,hdkiv_i,motoworldvn_i" index="j">
    <cfif j neq lcase(dts)>
    <option value="#j#" <cfif getartran.permitno eq j>selected</cfif>>#replace(j,"_i","","all")#</option>
    </cfif>
    </cfloop>
    </select>
    </cfif>
    <cfelseif lcase(hcomid) eq "keminates_i">
    <cfelse>
    <input type="text" name="permitno" value="#permitno#" size="40" maxlength="100">
    </cfif>
    </td>
    </tr>
	<tr>
		<th height="20" <cfif podisplay neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">#gettranname.bodypo#<cfelseif lcase(hcomid) eq "talerfood_i">Customer PO<cfelse>#words[795]#</cfif></th>
		<td colspan="2" <cfif podisplay neq "Y">style="visibility:hidden"</cfif>>
        <cfif custno eq 'ASSM/999'>
        <cfquery name="getissueno" datasource="#dts#">
   		select refno from artran where type='ISS'
		</cfquery>
        <select name="pono">
        <option value="">Choose a issue No</option>
        <cfloop query="getissueno">
        <option value="#getissueno.refno#"<cfif pono eq getissueno.refno>selected</cfif>>#getissueno.refno#</option>
        </cfloop>
        <cfelse>
        <input type="text" name="pono" value="#pono#" size="40" maxlength="35">
        </cfif>
        </td>
		<th <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelseif (lcase(HcomID) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i") and tran neq 'RQ'>style="visibility:hidden"<cfelse><cfif rem5display neq "Y">style="visibility:hidden"</cfif></cfif>>#getGsetup.rem5#</th>
		<td <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelseif (lcase(HcomID) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i") and tran neq 'RQ'>style="visibility:hidden"<cfelse><cfif rem5display neq "Y">style="visibility:hidden"</cfif></cfif>>
		<cfif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "aqua_i">
			<cfquery datasource="#dts#" name="getcust">
				Select custno,name from #target_arcust# order by name
			</cfquery>
			<select name="remark5">
				<option value="">Please Select</option>
				<cfloop query="getcust">
					<option value="#getcust.custno#"<cfif remark5 eq getcust.custno>Selected</cfif>>#getcust.custno# - #getcust.name#</option>
				</cfloop>
			</select>
            <cfelseif tran eq 'RQ'>
            <cfquery datasource="#dts#" name="getcust">
				Select custno,name from #target_arcust#
                where 0=0
                    <cfif getpin2.h1t00 eq 'T'>
					<cfif getgsetup.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                   
                    <cfelse>
					<cfif Huserloc neq "All_loc">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
                
                order by name
			</cfquery>
			<select name="remark5">
				<option value="">Please Select</option>
				<cfloop query="getcust">
					<option value="#getcust.custno#"<cfif remark5 eq getcust.custno>Selected</cfif>>#getcust.custno# - #getcust.name#</option>
				</cfloop>
			</select>
        <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
        <cfquery name="getveh" datasource="#dts#">
        SELECT * from vehicles where custcode = "#custno#"
        </cfquery>
        <select name="remark5" id="remark5" onChange="setTimeout('updateremark6()',1000);">
            <option value="">Select a vehicles</option>
            <cfloop query="getveh">
                <option value="#getveh.carno#" <cfif remark5 eq getveh.carno>Selected</cfif>>#getveh.carno#</option>
            </cfloop>
            </select>
         <cfelseif lcase(HcomID) eq "kimlee_i" and tran eq "CN" or lcase(HcomID) eq "bakersoven_i" and tran eq "CN">
         
			 <script type="text/javascript">
             function selectlist(custno){	
			for (var idx=0;idx<document.getElementById('remark5').options.length;idx++) {
					if (custno==document.getElementById('remark5').options[idx].value) {
						document.getElementById('remark5').options[idx].selected=true;
					}
				} 
				}
	</script>
         <cfquery name="getkiminv" datasource="#dts#">
        SELECT custno,refno,name from artran where type = "INV" group by refno
        </cfquery>
        <select name="remark5" id="remark5">
        <cfloop query="getkiminv">
        	<option value="#getkiminv.refno#" <cfif remark5 eq getkiminv.refno>Selected</cfif>>#getkiminv.refno# - #getkiminv.custno# #getkiminv.name#</option>
        </cfloop>
        </select>
        <img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findInvoice');" />
         <cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark5" id="remark5" value="#remark5#" bind="cfc:tran2cfc.getdate1('#dts#',{Job})" />
         <cfelseif lcase(HcomID) eq "unichem_i" and tran eq "INV">
        <cfquery name="getservicecode" datasource="#dts#">
        SELECT "" as servicecode, "Please Select a Service Agreement" as desp
        union all
        SELECT servicecode,concat(servicecode,' - ',desp) as desp from serviceagree
        </cfquery>  
        <cfselect name="remark5" id="remark5" query="getservicecode" value="servicecode" display="desp" selected="#remark5#" />
        <cfelseif  lcase(HcomID) eq "stjohns_i">
			<input type="text" name="remark5" value="#remark5#" size="40" maxlength="120">
        <cfelseif  lcase(HcomID) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
            <input type="checkbox" name="remcheck" id="remcheck" value="Yes" <cfif remark5 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark5').value='YES';} else {document.getElementById('remark5').value='NO';}">
            <input type="hidden" name="remark5" id="remark5" value="#remark5#" size="40" maxlength="80">
        <cfelseif lcase(HcomID) eq "vtop_i" or lcase(HcomID) eq "success_i">
        <input type="text" name="remark5" value="#remark5#" size="40" maxlength="200">
        <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
            <select name="remark5">
            <option value="">Choose a delivery terms</option>
            <option value="FCA Glimakra, Sweden Incoterms 2010" <cfif remark5 eq 'FCA Glimakra, Sweden Incoterms 2010'>selected</cfif>>FCA Glimakra, Sweden Incoterms 2010</option>
            <option value="FCA Fristad, Sweden Incoterms 2010" <cfif remark5 eq 'FCA Fristad, Sweden Incoterms 2010'>selected</cfif>>FCA Fristad, Sweden Incoterms 2010</option>
            <option value="FCA Brondby, Denmark Incoterms 2010" <cfif remark5 eq 'FCA Brondby, Denmark Incoterms 2010'>selected</cfif>>FCA Brondby, Denmark Incoterms 2010</option>
            <option value="FOB Gothenburg, Sweden Incoterms 2010" <cfif remark5 eq 'FOB Gothenburg, Sweden Incoterms 2010'>selected</cfif>>FOB Gothenburg, Sweden Incoterms 2010</option>
            <option value="CIF Hong Kong port by sea freight Incoterms 2010" <cfif remark5 eq 'CIF Hong Kong port by sea freight Incoterms 2010'>selected</cfif>>CIF Hong Kong port by sea freight Incoterms 2010</option>
            <option value="CIF Singapore port by sea freight Incoterms 2010" <cfif remark5 eq 'CIF Singapore port by sea freight Incoterms 2010'>selected</cfif>>CIF Singapore port by sea freight Incoterms 2010</option>
            <option value="CIF Manila port by sea freight Incoterms 2010" <cfif remark5 eq 'CIF Manila port by sea freight Incoterms 2010'>selected</cfif>>CIF Manila port by sea freight Incoterms 2010</option>
            <option value="FOB Copenhagen port, Incoterms 2010" <cfif remark5 eq 'FOB Copenhagen port, Incoterms 2010'>selected</cfif>>FOB Copenhagen port, Incoterms 2010</option>
            <option value="Excluding local handling fee and/or duties and taxes" <cfif remark5 eq 'Excluding local handling fee and/or duties and taxes'>selected</cfif>>Excluding local handling fee and/or duties and taxes</option>
            <option value="Ex works Hong Kong stock." <cfif remark5 eq 'Ex works Hong Kong stock'>selected</cfif>>Ex works Hong Kong stock. </option>
            <option value="FCA Suzhou, PRC Incoterms 2010" <cfif remark5 eq 'FCA Suzhou, PRC Incoterms 2010'>selected</cfif>>FCA Suzhou, PRC Incoterms 2010</option>
            
            </select>
        <cfelseif lcase(hcomid) eq "ascend_i">
       <cfif tran eq "PO">
                
                <input type="text" name="remark5" value="#remark5#" size="40" maxlength="80">
            <cfelse>
            <select name="remark5" id="remark5">
                <option value="">Choose a title</option>
                <option value="AV/ IT RENTAL" <cfif remark5 eq "AV/ IT RENTAL">selected</cfif>>AV/ IT RENTAL</option>
                <option value="PURCHASE AND INSTALL" <cfif remark5 eq "PURCHASE AND INSTALL">selected</cfif>>PURCHASE AND INSTALL</option>
                <option value="PROVISION OF INTERNET SERVICES" <cfif remark5 eq "PROVISION OF INTERNET SERVICES">selected</cfif>>PROVISION OF INTERNET SERVICES</option>
                </select>
                </cfif>
                
        <cfelseif getmodule.auto eq "1">
        
        
        
        
        
         <cfif hcomid eq 'mylustre_i'>
         
         <cfquery name="general" datasource="#replace(dts,'_i','_c','all')#">
select * from generalSetup
</cfquery>
            <cfquery name="getDeliveryTiming" datasource="#dts#">
select * from deliveryTiming where id = '#general.DeliveryTiming#'
</cfquery>


            <select name="remark5" id="remark5">
            <option value="">Choose a Delivery Timing</option>
           <cfloop from='1' to='4' index='a'>
           <cfif isnumeric(evaluate('getDeliveryTiming.day#a#'))>
           
           <option  <cfif "#evaluate('getDeliveryTiming.day#a#')#-#timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')##timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#" eq remark5>selected</cfif>   value="#evaluate('getDeliveryTiming.day#a#')#-#timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')##timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#"><!--- #DayOfWeekAsString(evaluate('getDeliveryTiming.day#a#'))# ---><cfif #evaluate('getDeliveryTiming.day#a#')# eq 1>AM
           <cfelseif #evaluate('getDeliveryTiming.day#a#')# eq 2>
           PM
           <cfelseif #evaluate('getDeliveryTiming.day#a#')# eq 3>
           Night
           <cfelse>
           Saturday
           </cfif> - #timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')# to #timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#</option>
           </cfif>
           
         </cfloop>
         </select>
        
        <cfelse>
        <cfquery name="getveh" datasource="#dts#">
        SELECT * from vehicles <cfif lcase(hcomid) eq "coolnlite_i" or lcase(hcomid) eq "imperial1_i">where custcode = "#custno#"</cfif>
        </cfquery>
        <select name="remark5" id="remark5" onChange="setTimeout('updateremark6()',1000);">
            <cfif lcase(hcomid) eq "coolnlite_i" or lcase(hcomid) eq "imperial1_i">
            <cfif getveh.recordcount eq 0>
            <option value="">Select a vehicles</option>
            <cfelse>
            
            </cfif>
            <cfelse><option value="">Select a vehicles</option></cfif>
            <cfloop query="getveh">
                <option value="#getveh.entryno#" <cfif trim(remark5) eq getveh.entryno>Selected</cfif>>#getveh.entryno#</option>
            </cfloop>
            </select>
            <input type="button" name="Svehi1" value="Search" onClick="javascript:ColdFusion.Window.show('findvehicle');getfocus();" >
            <cfif lcase(hcomid) eq "f1auto_i" or lcase(hcomid) eq "samac_i">
            <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/default/maintenance/shellvehicles/vehicles2.cfm?type=Create&express=1');">New</a>
            </cfif>
         </cfif>   
		<cfelseif lcase(hcomid) eq "atc2005_i">
        <cfif HUserGrpID eq 'admin' or HUserGrpID eq 'super' or HUserGrpID eq 'Suser'>
        <cfinput type="text" name="remark5" value="#remark5#" size="40" maxlength="10" validate="eurodate" message="Kindly key in date format">
        <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark5);">(DD/MM/YYYY)
        <cfelse>
        
        <cfif getartran.rem45 eq ''>
        <cfinput type="text" name="remark5" value="#remark5#" size="40" maxlength="10" validate="eurodate" message="Kindly key in date format">
        <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark5);">(DD/MM/YYYY)
        
        <cfelse>
        <cfinput type="text" name="remark5" value="#remark5#" size="40" maxlength="10" validate="eurodate" message="Kindly key in date format" readonly> <input type="button" name="editatcdate" id="editatcdate" value="Edit" onClick="ColdFusion.Window.show('atcdatepassword');">
        <div id="atcdatepasswordpasswordcontrol" style="visibility:hidden"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark5);">(DD/MM/YYYY)</div>
       
        </cfif>
        
        </cfif>
        
        
         
        
        
        <cfelse>
        
        
        
        <cfif hcomid eq 'mylustre_i'>
         
         <cfquery name="general" datasource="#replace(dts,'_i','_c','all')#">
select * from generalSetup
</cfquery>
            <cfquery name="getDeliveryTiming" datasource="#dts#">
select * from deliveryTiming where id = '#general.DeliveryTiming#'
</cfquery>


            <select name="remark5" id="remark5">
            <option value="">Choose a Delivery Timing</option>
           <cfloop from='1' to='4' index='a'>
           <cfif isnumeric(evaluate('getDeliveryTiming.day#a#'))>
           
           <option  <cfif "#evaluate('getDeliveryTiming.day#a#')#-#timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')##timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#" eq remark5>selected</cfif>   value="#evaluate('getDeliveryTiming.day#a#')#-#timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')##timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#"><!--- #DayOfWeekAsString(evaluate('getDeliveryTiming.day#a#'))# ---><cfif #evaluate('getDeliveryTiming.day#a#')# eq 1>AM
           <cfelseif #evaluate('getDeliveryTiming.day#a#')# eq 2>
           PM
           <cfelseif #evaluate('getDeliveryTiming.day#a#')# eq 3>
           Night
           <cfelse>
           Saturday
           </cfif> - #timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')# to #timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#</option>
           </cfif>
           
         </cfloop>
         </select>
        
        <cfelse>
        
        
        
        	<cfif trim(getGsetup.remark5list) eq ''>
            <input type="text" name="remark5" value="#remark5#" size="40" maxlength="80">
            <cfelse>
            <select name="remark5" id="remark5">
            <option value="">Please choose</option>
            <cfloop list="#getGsetup.remark5list#" index="i">
            <option value="#i#" <cfif remark5 eq i>selected</cfif>>#i#</option>
            </cfloop>
            </select>
            </cfif>
            </cfif>
		</cfif>		</td>
	</tr>
	<tr>
		<th height="20" <cfif dodisplay neq "Y">style="visibility:hidden"</cfif>>#words[793]#</th>
		<td colspan="2" <cfif dodisplay neq "Y">style="visibility:hidden"</cfif>><input type="text" name="dono" value="#dono#" size="40" maxlength="35"></td>
		<th <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem6display neq "Y">style="visibility:hidden"</cfif></cfif>>#getGsetup.rem6#</th>
        <td <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem6display neq "Y">style="visibility:hidden"</cfif></cfif>><cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
		

  <select name="remark6" id="remark6" >
  <cfloop list="0%,10%,15%,20%,30%,40%,50%" index="i">
  <option value="#i#" <cfif remark6 eq #i#>selected</cfif>>#i#</option>
</cfloop></select><cfinput type="hidden" id="remark61" name="remark61" bind="cfc:accordtran2.getremark6('#dts#',{remark5})" >        </td>
  <cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark6" id="remark6" value="#remark6#" bind="cfc:tran2cfc.getdate2('#dts#',{Job})" />
         <cfelseif lcase(hcomid) eq "visionlaw_i">
         <textarea name="remark6" id="remark6" cols='40' rows='3' onKeyDown="limitText(this.form.remark6,300);" onKeyUp="limitText(this.form.remark6,300);">#remark6#</textarea>	
         <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
        <select name="remark6">
        <option value="">Choose a Payment Terms</option>
        <option value="30% down payment due with purchase order." <cfif remark6 eq '30% down payment due with purchase order.'>selected</cfif>>30% down payment due with purchase order.</option>
        <option value="40% down payment due with purchase order." <cfif remark6 eq '40% down payment due with purchase order.'>selected</cfif>>40% down payment due with purchase order.</option>
        <option value="50% down payment due with purchase order." <cfif remark6 eq '50% down payment due with purchase order.'>selected</cfif>>50% down payment due with purchase order.</option>
        <option value="60% against B/L" <cfif remark6 eq '60% against B/L'>selected</cfif>>60% against B/L</option>
        <option value="70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="Balance 10 days from invoice date" <cfif remark6 eq 'Balance 10 days from invoice date'>selected</cfif>>Balance 10 days from invoice date</option>
        <option value="Balance 14 days from invoice date" <cfif remark6 eq 'Balance 14 days from invoice date'>selected</cfif>>Balance 14 days from invoice date</option>
        <option value="Goods remain the property of Sveba-Dahlen Group until full payment is made" <cfif remark6 eq 'Goods remain the property of Sveba-Dahlen Group until full payment is made'>selected</cfif>>Goods remain the property of Sveba-Dahlen Group until full payment is made</option>
        <option value="The quotation is subject to our general terms and conditions available in our price list" <cfif remark6 eq 'The quotation is subject to our general terms and conditions available in our price list'>selected</cfif>>The quotation is subject to our general terms and conditions available in our price list</option>
        </select>
        <cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        <select name="remark6">
        <option value="4-6 weeks ARO" <cfif remark6 eq '4-6 weeks ARO'>selected</cfif>>4-6 weeks ARO</option>
        <option value="Ex-Stock Prior to Sales" <cfif remark6 eq 'Ex-Stock Prior to Sales'>selected</cfif>>Ex-Stock Prior to Sales</option>
        <option value="1-2 Weeks  ARO" <cfif remark6 eq '1-2 Weeks  ARO'>selected</cfif>>1-2 Weeks  ARO</option>
        <option value="2- 4 week s ARO" <cfif remark6 eq '2- 4 week s ARO'>selected</cfif>>2- 4 week s ARO</option>
        <option value="6-8 weeks AR0" <cfif remark6 eq '6-8 weeks AR0'>selected</cfif>>6-8 weeks AR0</option>
        <option value="See Remarks***" <cfif remark6 eq 'See Remarks***'>selected</cfif>>See Remarks***</option>
        <option value="As per Tender Documents***" <cfif remark6 eq 'As per Tender Documents***'>selected</cfif>>As per Tender Documents***</option>
        <option value="Immediately" <cfif remark6 eq 'Immediately'>selected</cfif>>Immediately</option>
        <option value="" <cfif remark6 eq ''>selected</cfif>></option>
        </select>
        <cfelseif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
            
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80" >
        <cfelseif lcase(hcomid) eq "renowngift_i">
         <input type="text" name="remark6" value="#remark6#" size="10" maxlength="10" >
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark6);">(DD/MM/YYYY)
        <cfelseif lcase(hcomid) eq "ascend_i">
            <input type="hidden" name="ascendremark61" value="" size="40" maxlength="80" >
            <input type="hidden" name="ascendremark62" value="" size="40" maxlength="80" >
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80" >
            From <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(ascendremark61);updateascendremark6();"> To
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(ascendremark62);updateascendremark6();">
        <cfelseif getmodule.auto eq "1" and lcase(hcomid) neq "imperial1_i">
        <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80"  onblur="validatetime('remark6')">
        <input type="button" name="generatedatetime" id="generatedatetime" onClick="document.getElementById('remark6').value='#dateformat(now(),'DD/MM/YYYY')#'+' #timeformat(now(),'HH:MM')#'" value="Start Time" />
        <cfelseif lcase(hcomid) eq "dgalleria_i">
        <cfinput type="text" name="remark6" value="#remark6#" size="40" maxlength="10" validate="eurodate" message="Kindly key in date format">
        <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark6);">(DD/MM/YYYY)
        <cfelseif lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i" or lcase(hcomid) eq "success_i">
	<cfinput type="text" name="remark6" value="#remark6#" size="40" maxlength="200">
	<cfelse>
            
 			<cfif trim(getGsetup.remark6list) eq ''>
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80">
            <cfelse>
            <select name="remark6" id="remark6">
            <option value="">Please choose</option>
            <cfloop list="#getGsetup.remark6list#" index="i">
            <option value="#i#" <cfif remark6 eq i>selected</cfif>>#i#</option>
            </cfloop>
            </select>
            </cfif>
        </cfif></td>
	</tr>
	<tr>
		<th <cfif billtoadd_code neq "Y">style="visibility:hidden"</cfif>>#words[889]#</th>
		<td colspan="2" <cfif billtoadd_code neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark0" value="#remark0#" size="40" readonly></td>
		<th <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem7display neq "Y">style="visibility:hidden"</cfif></cfif>>#getGsetup.rem7#</th>
		<td <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem7display neq "Y">style="visibility:hidden"</cfif></cfif>>
			<!--- MODIFIED ON 23-02-2009,PURPOSE: NET_I NEW PO FORMAT --->
			<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "PO">
				<select name="remark7">
					<option value="">Please Select the Client</option>
					<cfloop query="getarcust">
						<option value="#custno#" <cfif custno eq remark7>selected</cfif>>#custno# - #name#</option>
					</cfloop>
				</select>
                <cfelseif lcase(hcomid) eq "kingston_i" and tran eq "PO">
				<select name="remark7" id="remark7">
                <option value="Kindly send to our office" <cfif remark7 eq "Kindly send to our office">selected</cfif>>Kindly send to our office</option>
                <option value="Kindly send to our site" <cfif remark7 eq "Kindly send to our site">selected</cfif>>Kindly send to our site</option>
                <option value="Self-Collection" <cfif remark7 eq "Self-Collection">selected</cfif>>Self-Collection</option>
                </select>
                        <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and (tran eq "INV" or tran eq "CS")>
                        
                 <select name="remark7" id="remark7">
  <cfloop list="OPC,normal" index="i">
  <option value="#i#" <cfif remark7 eq #i#>selected</cfif>>#i#</option>
</cfloop></select><cfinput type="hidden" id="remark71" name="remark71" bind="cfc:accordtran2.getremark7('#dts#',{remark5})">
			<cfelseif lcase(hcomid) eq "mcjim_i">
            <input type="text" name="remark7" value="#remark7#" size="40" maxlength="50">
            <cfelseif lcase(hcomid) eq "powernas_i">
            <input type="text" name="remark7" value="#remark7#" size="40" maxlength="200">
            <cfelseif lcase(hcomid) eq "visionlaw_i">
         <textarea name="remark7" id="remark7" cols='40' rows='3' onKeyDown="limitText(this.form.remark7,300);" onKeyUp="limitText(this.form.remark7,300);">#remark7#</textarea>	
         	<cfelseif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "litelab_i" or lcase(hcomid) eq "dgalleria_i">
            <cfif isdate(remark7)>
            <cfset remark7=dateformat(remark7,'DD/MM/YYYY')>
            <cfelse>
            <cfset remark7=''>
            </cfif>
            <input type="text" name="remark7" value="#remark7#" size="40" maxlength="80" readonly>
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark7);">(DD/MM/YYYY)
            <cfelseif lcase(hcomid) eq "renowngift_i">
             <input type="text" name="remark7" value="#remark7#" size="10" maxlength="10" readonly>
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark7);">(DD/MM/YYYY)
            <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
        <select name="remark7">
        <option value="">Choose a Payment Terms</option>
        <option value="30% down payment due with purchase order." <cfif remark7 eq '30% down payment due with purchase order.'>selected</cfif>>30% down payment due with purchase order.</option>
        <option value="40% down payment due with purchase order." <cfif remark7 eq '40% down payment due with purchase order.'>selected</cfif>>40% down payment due with purchase order.</option>
        <option value="50% down payment due with purchase order." <cfif remark7 eq '50% down payment due with purchase order.'>selected</cfif>>50% down payment due with purchase order.</option>
        <option value="60% against B/L" <cfif remark7 eq '60% against B/L'>selected</cfif>>60% against B/L</option>
        <option value="70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="Balance 10 days from invoice date" <cfif remark7 eq 'Balance 10 days from invoice date'>selected</cfif>>Balance 10 days from invoice date</option>
        <option value="Balance 14 days from invoice date" <cfif remark7 eq 'Balance 14 days from invoice date'>selected</cfif>>Balance 14 days from invoice date</option>
        <option value="Goods remain the property of Sveba-Dahlen Group until full payment is made" <cfif remark7 eq 'Goods remain the property of Sveba-Dahlen Group until full payment is made'>selected</cfif>>Goods remain the property of Sveba-Dahlen Group until full payment is made</option>
        <option value="The quotation is subject to our general terms and conditions available in our price list" <cfif remark7 eq 'The quotation is subject to our general terms and conditions available in our price list'>selected</cfif>>The quotation is subject to our general terms and conditions available in our price list</option>
        </select>
        <cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        <select name="remark7">
        <option value="14 days" <cfif remark7 eq '14 days'>selected</cfif>>14 days</option>
        <option value="7  days" <cfif remark7 eq '7  days'>selected</cfif>>7  days</option>
        <option value="30 days" <cfif remark7 eq '30 days'>selected</cfif>>30 days</option>
        <option value="45 days" <cfif remark7 eq '45 days'>selected</cfif>>45 days</option>
        <option value="" <cfif remark7 eq ''>selected</cfif>></option>
        </select>
        <cfelseif lcase(hcomid) eq "atc2005_i">
		<input type="text" name="remark7" value="#remark7#" size="40" maxlength="2">
        <cfelseif lcase(hcomid) eq "bcepl_i" or lcase(hcomid) eq "success_i">
		<input type="text" name="remark7" value="#remark7#" size="40" maxlength="200">
        <cfelseif getmodule.auto eq "1" and lcase(hcomid) neq "imperial1_i">
				<input type="text" name="remark7" value="#remark7#" size="40" maxlength="80" onBlur="validatetime('remark7')">
        <input type="button" name="generatedatetime2" id="generatedatetime2" onClick="document.getElementById('remark7').value='#dateformat(now(),'DD/MM/YYYY')#'+' #timeformat(now(),'HH:MM')#'" value="Complete Time" />
			<cfelse>
            
            	<cfif trim(getGsetup.remark7list) eq ''>
            	<input type="text" name="remark7" value="#remark7#" size="40" maxlength="80">
            	<cfelse>
            	<select name="remark7" id="remark7">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark7list#" index="i">
            	<option value="#i#" <cfif remark7 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>
			</cfif>		</td>
	</tr>
	<tr>
    	<th <cfif deladd_code neq "Y">style="visibility:hidden"</cfif>>#words[1421]#</th>
		<td colspan="2" <cfif deladd_code neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark1" value="#remark1#" size="40" readonly></td>
        
		<th  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem8display neq "Y">style="visibility:hidden"</cfif></cfif>>#getGsetup.rem8#</th>
        
		<td  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem8display neq "Y">style="visibility:hidden"</cfif></cfif>>
		<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i" >
			<select name="remark8">
			<option value="">Please Select</option>
			<cfloop query="getlocation">
			<option value="#location#" <cfif remark8 eq location>selected</cfif>>#desp#</option>
			</cfloop>
			</select>
		<cfelseif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i">
			<select name="remark8">
			<option value="">Please Select</option>
			<option value="directReferral" <cfif remark8 eq "directReferral">selected</cfif>>Direct Referral</option>
			<option value="onspot" <cfif remark8 eq "onspot">selected</cfif>>On Spot</option>
			<option value="telesales" <cfif remark8 eq "telesales">selected</cfif>>Tele-Sales</option>
			</select>
            <cfelseif lcase(hcomid) eq "net_i" or lcase(hcomid) eq "evco3_i">
            <input type="text" name="remark8" value="<cfif remark8 neq "" and remark8 neq "0000-00-00"> #dateformat(remark8,"dd/mm/yyyy")#</cfif>" size="10" maxlength="10">
			<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark8);">(DD/MM/YYYY)
           <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and (tran eq "INV" or tran eq "CS")>
<select name="remark8" id="remark8">
<option value="" <cfif remark8 eq "">Selected</cfif>>Please select a coverage type</option>
<option value="Comprehensive" <cfif remark8 eq "Comprehensive">Selected</cfif>>Comprehensive</option>
<option value="Third party, fire and theft" <cfif remark8 eq "Third party, fire and theft">Selected</cfif>>Third party, fire and theft</option>
<option value="Third party only" <cfif remark8 eq "Third party only">Selected</cfif>>Third party only</option>
</select><cfinput type="hidden" id="remark81" name="remark81" bind="cfc:accordtran2.getremark8('#dts#',{remark5})">

<cfelseif lcase(hcomid) eq "redhorn_i" and tran eq "PO">
                        
                <select name="remark8" id="remark8">
<option value="" <cfif remark8 eq "">Selected</cfif>>Please select a Delivery type</option>
<option value="Self Collect" <cfif remark8 eq "Self Collect">Selected</cfif>>Self Collect</option>
<option value="Deliver By Supplier" <cfif remark8 eq "Deliver By Supplier">Selected</cfif>>Deliver By Supplier</option>
</select>

            <cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark8" id="remark8" value="#remark8#"  bind="cfc:tran2cfc.getdate3('#dts#',{Job})" />
   		<cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
        <select name="remark8">
        <option value="">Choose a Payment Terms</option>
        <option value="30% down payment due with purchase order." <cfif remark8 eq '30% down payment due with purchase order.'>selected</cfif>>30% down payment due with purchase order.</option>
        <option value="40% down payment due with purchase order." <cfif remark8 eq '40% down payment due with purchase order.'>selected</cfif>>40% down payment due with purchase order.</option>
        <option value="50% down payment due with purchase order." <cfif remark8 eq '50% down payment due with purchase order.'>selected</cfif>>50% down payment due with purchase order.</option>
        <option value="60% against B/L" <cfif remark8 eq '60% against B/L'>selected</cfif>>60% against B/L</option>
        <option value="70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="Balance 10 days from invoice date" <cfif remark8 eq 'Balance 10 days from invoice date'>selected</cfif>>Balance 10 days from invoice date</option>
        <option value="Balance 14 days from invoice date" <cfif remark8 eq 'Balance 14 days from invoice date'>selected</cfif>>Balance 14 days from invoice date</option>
        <option value="Goods remain the property of Sveba-Dahlen Group until full payment is made" <cfif remark8 eq 'Goods remain the property of Sveba-Dahlen Group until full payment is made'>selected</cfif>>Goods remain the property of Sveba-Dahlen Group until full payment is made</option>
        <option value="The quotation is subject to our general terms and conditions available in our price list" <cfif remark8 eq 'The quotation is subject to our general terms and conditions available in our price list'>selected</cfif>>The quotation is subject to our general terms and conditions available in our price list</option>
        </select>
        <cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        <select name="remark8">
			
        <option value="Ex-Works" <cfif remark8 eq 'Ex-Works'>selected</cfif>>Ex-Works</option>
        <option value="FOB Singapore" <cfif remark8 eq 'FOB Singapore'>selected</cfif>>FOB Singapore</option>
        <option value="CIF " <cfif remark8 eq 'CIF'>selected</cfif>>CIF </option>
        <option value="CIP" <cfif remark8 eq 'CIP'>selected</cfif>>CIP</option>
        <option value="-" <cfif remark8 eq '-'>selected</cfif>>-</option>
        <option value="" <cfif remark8 eq ''>selected</cfif>></option>
        <option value="FCA" <cfif remark8 eq 'FCA'>selected</cfif>>FCA</option>
        <option value="CPT" <cfif remark8 eq 'CPT'>selected</cfif>>CPT</option>
        <option value="DAT" <cfif remark8 eq 'DAT'>selected</cfif>>DAT</option>
        <option value="DAP" <cfif remark8 eq 'DAP'>selected</cfif>>DAP</option>
        <option value="DDP" <cfif remark8 eq 'DDP'>selected</cfif>>DDP</option>
        <option value="FAS" <cfif remark8 eq 'FAS'>selected</cfif>>FAS</option>
        <option value="CFR" <cfif remark8 eq 'CFR'>selected</cfif>>CFR</option>
        </select>
        <cfelseif lcase(hcomid) eq "atc2005_i">
        <input type="text" name="remark8" value="#remark8#" size="40" maxlength="2">
        <cfelseif getmodule.auto eq "1" and lcase(hcomid) neq "imperial1_i">
            <cfif isdate(remark8)>
            <cfset remark8=dateformat(remark8,'DD/MM/YYYY')>
            </cfif>
            <input type="text" name="remark8" value="#remark8#" size="40" maxlength="80" readonly>
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark8);">(DD/MM/YYYY)
		<cfelse>
        		<cfif trim(getGsetup.remark8list) eq ''>
            	<input type="text" name="remark8" value="#remark8#" size="40" maxlength="80">
            	<cfelse>
            	<select name="remark8" id="remark8">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark8list#" index="i">
            	<option value="#i#" <cfif remark8 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>

		</cfif>		</td>
	</tr>
	<tr>
    	<th <cfif billattn neq "Y">style="visibility:hidden"</cfif>>#words[892]#</th>
		<td colspan="2" <cfif billattn neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark2" value="#remark2#" size="40" maxlength="35" readonly></td>
		<th  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem9display neq "Y">style="visibility:hidden"</cfif></cfif>><cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and tran eq "PO">Arrival Date<cfelse>#getGsetup.rem9#</cfif></th>
		<td  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem9display neq "Y">style="visibility:hidden"</cfif></cfif>>
		<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "net_i" or lcase(hcomid) eq "gaf_i" or lcase(hcomid) eq "evco3_i" or ((lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and tran eq "PO")>
			<input type="text" name="remark9" value="<cfif remark9 neq "" and remark9 neq "0000-00-00"> #dateformat(remark9,"dd/mm/yyyy")#</cfif>" size="10" maxlength="10">
			<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark9);">(DD/MM/YYYY)
            
                      <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                        
                     <cfinput type="text" id="remark9" name="remark9" bind="cfc:accordtran2.getremark9('#dts#',{remark5})" value="#remark9#">
<cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark9" id="remark9" value="#remark9#" bind="cfc:tran2cfc.getdate4('#dts#',{Job})" />
         <cfelseif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "mfssmy_i") and tran eq "SO">
			<cfinput type="text" name="remark9" value="#remark9#" size="40" maxlength="35" required="yes" message="Kindly Fill in Doctor Name">
        <cfelseif lcase(hcomid) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
         <input type="checkbox" name="rem9check" id="rem9check" value="Yes" <cfif remark9 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark9').value='YES';} else {document.getElementById('remark9').value='NO';}">
         <input type="hidden" name="remark9" id="remark9" value="#remark9#" size="40" maxlength="35">
         <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
         <select name="remark9">
         <option value="">Choose a warranty</option>
         <option value="Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01" <cfif remark9 eq 'Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01'>selected</cfif>>Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01</option>
         <option value="Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions" <cfif remark9 eq 'Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions'>selected</cfif>>Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions</option>
         <option value="BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions" <cfif remark9 eq 'BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions'>selected</cfif>>BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions</option>
         <option value="Refer to www.bearvarimixer.dk/legal" <cfif remark9 eq 'Refer to www.bearvarimixer.dk/legal'>selected</cfif>>Refer to www.bearvarimixer.dk/legal</option>
         <option value="Refer to www.sveba-dahlen.com/legal" <cfif remark9 eq 'Refer to www.sveba-dahlen.com/legal'>selected</cfif>>Refer to www.sveba-dahlen.com/legal</option>
         <option value="Refer to www.glimek.com/legal" <cfif remark9 eq 'Refer to www.glimek.com/legal'>selected</cfif>>Refer to www.glimek.com/legal</option>
         </select>
         <cfelseif lcase(hcomid) eq "tranz_i">
         <input type="checkbox" name="cbremark9" id="cbremark9" value="1" <cfif remark9 neq ''>checked</cfif> onClick="if(this.checked == true){document.getElementById('remark9').value='Sign'}else{document.getElementById('remark9').value=''}">
         <input type="hidden" name="remark9" value="#remark9#" size="40" maxlength="80">
        <cfelseif lcase(hcomid) eq "ascend_i">
        <input type="text" name="remark9" value="#remark9#" size="40" maxlength="80">
        <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark9);">(DD/MM/YYYY)
       <cfelse>
         		<cfif trim(getGsetup.remark9list) eq ''>
            	<input type="text" name="remark9" value="#remark9#" size="40" maxlength="80">
            	<cfelse>
            	<select name="remark9" id="remark9">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark9list#" index="i">
            	<option value="#i#" <cfif remark9 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>
            
		</cfif>		</td>
	</tr>
	<tr>
    	<th <cfif delattn neq "Y">style="visibility:hidden"</cfif>>#words[1288]#</th>
		<td colspan="2" <cfif delattn neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark3" size="40" maxlength="35" <cfif lcase(HcomID) eq "hl_i" and tran eq "PO"> value="#remark3#"<cfelse>value="#remark3#" readonly</cfif>></td>
		<th  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem10display neq "Y">style="visibility:hidden"</cfif></cfif>><cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i" or lcase(hcomid) eq "gaf_i" or lcase(hcomid) eq "evco3_i") and tran eq "INV">Start On<cfelse>#getGsetup.rem10#</cfif></th>
		<td  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem10display neq "Y">style="visibility:hidden"</cfif></cfif>>
		<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
			<select name="remark10">
			<option value="">Please Select</option>
			<option value="-" <cfif remark10 eq "-">selected</cfif>>To</option>
			<option value="&" <cfif remark10 eq "&">selected</cfif>>And</option>
			</select>
		<cfelseif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i" or lcase(hcomid) eq "gaf_i" or lcase(hcomid) eq "evco3_i") and tran eq "INV">
			<input type="text" name="remark10" value="#remark10#" size="10" maxlength="10">
			<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark10);">(DD/MM/YYYY)
		<cfelseif lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i" or lcase(hcomid) eq "decor_i" >
			<textarea name="remark10" id="remark10" cols='40' rows='1' onKeyDown="limitText(this.form.remark10,200);" onKeyUp="limitText(this.form.remark10,200);">#remark10#</textarea>	
            <cfelseif lcase(hcomid) eq "bestform_i" or lcase(hcomid) eq "alsale_i" or lcase(hcomid) eq "gbi_i" or getmodule.auto eq "1" or lcase(hcomid) eq "litelab_i" or lcase(hcomid) eq "d72ipl_i">
			<textarea name="remark10" id="remark10" cols='40' rows='3' onKeyDown="limitText(this.form.remark10,500);" onKeyUp="limitText(this.form.remark10,500);">#remark10#</textarea>	
        <cfelseif lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "visionlaw_i" or lcase(hcomid) eq "bspl_i" or lcase(hcomid) eq "polypet_i">
        <input type="text" name="remark10" value="#remark10#" maxlength="100" size="40"></td>
        
                 <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and (tran eq "INV" or tran eq "CS")>
                <cfoutput>
<cfinput type="text" name="remark10" id="remark10" value="#remark10#" bind="cfc:accordtran2.getremark10('#dts#',{remark5})"></cfoutput>
        <cfelseif lcase(hcomid) eq "mingsia_i" or lcase(hcomid) eq "knm_i" or lcase(hcomid) eq "letrain_i" or lcase(hcomid) eq "btgroup_i">
        <input type="text" name="remark10" value="#remark10#" maxlength="150" size="40"></td>
         <cfelseif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "mfssmy_i") and tran eq "SO">
         <cfinput type="text" name="remark10" value="#remark10#" maxlength="35" size="40" required="yes" message="Kindly Fill in Patient Name"></td>
	<cfelseif lcase(hcomid) eq "aepl_i">
			<textarea name="remark10" id="remark10" cols='100' rows='3' onKeyDown="limitText(this.form.remark10,200);" onKeyUp="limitText(this.form.remark10,200);">#remark10#</textarea>
        <cfelseif (lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i") and tran eq 'QUO'>
            <select name="remark10" id="remark10" onChange="bnbpupdatedetail();">
            	<option value="" <cfif remark10 eq "">selected</cfif>>Please Choose a Remark</option>
                <option value="1" <cfif remark10 eq "1">selected</cfif>>Remark 1</option>
                <option value="2" <cfif remark10 eq "2">selected</cfif>>Remark 2</option>
                <option value="3" <cfif remark10 eq "3">selected</cfif>>Remark 3</option>
                <option value="4" <cfif remark10 eq "4">selected</cfif>>Remark 4</option>
                <option value="5" <cfif remark10 eq "5">selected</cfif>>Remark 5</option>
            	</select>    
         <cfelseif lcase(hcomid) eq "atc2005_i">
            <input type="text" name="remark10" value="#remark10#" maxlength="200" size="40">
         <cfelseif lcase(hcomid) eq "asaiki_i">
        <input type="text" name="remark10" value="#remark10#" size="40" maxlength="80">
        <input type="button" name="updateshipvia" id="updateshipvia" value="Update" onClick="ajaxFunction(document.getElementById('updateshipviaajax'),'/default/transaction/tran2asaikiajax.cfm?custno='+escape(document.getElementById('custno').value));updateshipvia2();"><div id="updateshipviaajax"></div>
		
		<cfelse>
        
        		<cfif trim(getGsetup.remark10list) eq ''>
            	<input type="text" name="remark10" value="#remark10#" maxlength="300" size="40">
            	<cfelse>
            	<select name="remark10" id="remark10">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark10list#" index="i">
            	<option value="#i#" <cfif remark10 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>
			</td>
		</cfif>
	</tr>
	<tr>
    	<th <cfif billtel neq "Y">style="visibility:hidden"</cfif>>#words[440]#</th>
		<td colspan="2" <cfif billtel neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark4" value="#remark4#" size="40" maxlength="35" readonly></td>
	  <cfif lcase(HcomID) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
			<th  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem11display neq "Y">style="visibility:hidden"</cfif></cfif>>#getGsetup.rem11#</th>
		<td  <cfif getmodule.auto eq "1" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>style="visibility:hidden"<cfelse><cfif rem11display neq "Y">style="visibility:hidden"</cfif></cfif>>
			<input type="text" name="remark11" value="#dateformat(remark11,"dd/mm/yyyy")#" size="10" maxlength="10">
		<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark11);">(DD/MM/YYYY)			</td>
		<cfelseif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i" or lcase(hcomid) eq "gaf_i" or lcase(hcomid) eq "evco3_i") and tran eq "INV">
			<th>Expire On</th>
		<td>
				<input type="text" name="remark11" value="#remark11#" size="10" maxlength="10">
		<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark11);">(DD/MM/YYYY)			</td>
		<cfelseif lcase(hcomid) eq "eocean_i" or lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i" or lcase(hcomid) eq "probulk_i" or lcase(hcomid) eq "ielm_i" or lcase(hcomid) eq "leatat_i" or lcase(hcomid) eq "dnet_i" or lcase(hcomid) eq "avoncleaning_i" or lcase(hcomid) eq "spcivil_i" or lcase(hcomid) eq "marico_i" or lcase(hcomid) eq "knights_i" or lcase(hcomid) eq "manhattan_i" or lcase(hcomid) eq "elmanhattan_i" or lcase(hcomid) eq "alsale_i" or lcase(hcomid) eq "letrain_i" or lcase(hcomid) eq "elitez_i" or lcase(hcomid) eq "reaktion_i" or lcase(hcomid) eq "amtaire_i" or lcase(hcomid) eq "taftc_i" or lcase(hcomid) eq "bofi_i" or lcase(hcomid) eq "avonservices_i" or lcase(hcomid) eq "widos_i" or lcase(hcomid) eq "avoncars_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "cleansing_i" or lcase(hcomid) eq "manhattan09_i" or lcase(hcomid) eq "marquis_i" or lcase(hcomid) eq "hempel_i" or lcase(hcomid) eq "bspl_i" or lcase(hcomid) eq "ccwpl_i" or lcase(hcomid) eq "anab_i" or lcase(hcomid) eq "zoenissi_i" or lcase(hcomid) eq "grace_i" or lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "risb_i" or lcase(hcomid) eq "gbi_i" or lcase(hcomid) eq "sjpst_i" or lcase(hcomid) eq "uniq_i" or lcase(hcomid) eq "sumiden_i" or lcase(hcomid) eq "almh_i" or lcase(hcomid) eq "leadbuilders_i" or getmodule.auto eq "1" or lcase(hcomid) eq "ciss_i" or lcase(hcomid) eq "vsyspteltd_i" or lcase(hcomid) eq "ascend_i" or lcase(hcomid) eq "epoint_i" or lcase(hcomid) eq "atc2005_i" or lcase(hcomid) eq "thats_i" or lcase(hcomid) eq "tranz_i" or lcase(hcomid) eq "chequer_i" or lcase(hcomid) eq "megaplast_i" or lcase(hcomid) eq "d72ipl_i" or lcase(hcomid) eq "bklpl_i" or lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "thongsheng_i" or lcase(hcomid) eq "baronad_i">
		  <th <cfif rem11display neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem11#</th>
       	  <td rowspan="2" <cfif rem11display neq "Y">style="visibility:hidden"</cfif>>
			<textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,200);" onKeyUp="limitText(this.form.remark11,200);">#remark11#</textarea>			</td>
		<cfelseif lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "ideakonzepte_i" or lcase(hcomid) eq "bestform_i" or lcase(hcomid) eq "ovas_i"  or lcase(hcomid) eq "asiasoft_i" or lcase(hcomid) eq "bnbm_i" or lcase(hcomid) eq "bnbp_i" or lcase(hcomid) eq "success_i">
			<th>#getgsetup.rem11#</th>
       	<td rowspan="2">
          <cfif remark11 eq "">
            <textarea name="remark11" id="remark11" cols='100' rows='3' onKeyDown="limitText(this.form.remark11,450);" onKeyUp="limitText(this.form.remark11,450);"></textarea><cfelse>
	    <textarea name="remark11" id="remark11" cols='100' rows='3' onKeyDown="limitText(this.form.remark11,450);" onKeyUp="limitText(this.form.remark11,450);">#remark11#</textarea>		</cfif>	</td>
        
        <cfelseif lcase(hcomid) eq "mingsia_i" or lcase(hcomid) eq "knm_i">
			<th>#getgsetup.rem11#</th>
       	<td rowspan="2">
          <cfif remark11 eq "">
            <textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,800);" onKeyUp="limitText(this.form.remark11,800);"></textarea><cfelse>
	    <textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,800);" onKeyUp="limitText(this.form.remark11,800);">#remark11#</textarea>		</cfif>	</td>
	<cfelseif lcase(hcomid) eq "aepl_i">
			<th>#getgsetup.rem11#</th>
       	<td rowspan="2">
          <cfif remark11 eq "">
            <textarea name="remark11" id="remark11" cols='100' rows='3' onKeyDown="limitText(this.form.remark11,500);" onKeyUp="limitText(this.form.remark11,500);"></textarea><cfelse>
	    <textarea name="remark11" id="remark11" cols='100' rows='3' onKeyDown="limitText(this.form.remark11,500);" onKeyUp="limitText(this.form.remark11,500);">#remark11#</textarea>		</cfif>	</td>

                
                             <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                             <th>#getgsetup.rem11#</th>
             <td>   <cfoutput>
<cfinput type="text" name="remark11" id="remark11" value="#remark11#" bind="cfc:accordtran2.getremark11('#dts#',{remark5})"></cfoutput></td>
        <cfelseif lcase(HcomID) eq "fdipx_i">
            <th>#getGsetup.rem11#</th>
			<td><textarea name="remark11" id="remark11" cols="40" rows="3" >#remark11#</textarea>
            </td>
            <cfelseif lcase(hcomid) eq "elsiedan_i">
                <th>#getgsetup.rem11#</th>
        		<td>
                <select  name="remark11" id="remark11">
                <option value="">Please Choose #getgsetup.rem11#</option>
                <option value="Purchaser Price">Purchaser Price</option>
                <option value="Valuation Price">Valuation Price</option>
                <option value="Financier">Financier</option>
                </select>				</td>
            <cfelseif lcase(hcomid) eq "powernas_i" or lcase(hcomid) eq "acerich_i" or lcase(hcomid) eq "demoinsurance_i">
                <cfquery name="getsupplist" datasource="#dts#">
                select custno,name from #target_apvend#
                </cfquery>
				<th>#getgsetup.rem11#</th>
        		<td>
                <select  name="remark11">
                <option value="">Please Choose a supplier</option>
                <cfloop query="getsupplist">
                <option value="#getsupplist.custno#"<cfif remark11 eq getsupplist.custno>selected</cfif>>#getsupplist.custno# - #getsupplist.name#</option>
                </cfloop>
                </select>
				</td>
        <cfelseif lcase(hcomid) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
            <th>#getgsetup.rem11#</th>
         <td><input type="checkbox" name="rem11check" id="rem11check" value="Yes" <cfif remark11 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark11').value='YES';} else {document.getElementById('remark11').value='NO';}">
         <input type="hidden" name="remark11" value="#remark11#" size="40" maxlength="35">	</td>
         <!---<cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
            <th>#getgsetup.rem11#</th>
            <td>
            <select name="remark11">
            <option value="">Choose a Paid to</option>
            <option value="SDC HKD" <cfif remark11 eq 'SDC HKD'>selected</cfif>>SDC HKD</option>
            <option value="SDC EUR" <cfif remark11 eq 'SDC EUR'>selected</cfif>>SDC EUR</option>
            <option value="SDC USD" <cfif remark11 eq 'SDC USD'>selected</cfif>>SDC USD</option>
            <option value="SDAB EUR" <cfif remark11 eq 'SDAB EUR'>selected</cfif>>SDAB EUR</option>
	    <option value="SDAB USD" <cfif remark11 eq 'SDAB USD'>selected</cfif>>SDAB USD</option>
            <option value="WDC EUR" <cfif remark11 eq 'WDC EUR'>selected</cfif>>WDC EUR</option>
            <option value="GLI EUR" <cfif remark11 eq 'GLI EUR'>selected</cfif>>GLI EUR</option>
            </select>
            </td>--->
        <cfelseif lcase(hcomid) eq "polypet_i">
        <th>#getGsetup.rem11#</th>
			<td><input type="text" name="remark11" value="#remark11#" size="40" maxlength="80"></td>
            
           <cfelseif lcase(hcomid) eq "meisei_i">
          <th>#getGsetup.rem11#</th>
       
			<td><textarea name="remark11" id="remark11" cols='40' rows='5' onKeyDown="limitText(this.form.remark11,200);" onKeyUp="limitText(this.form.remark11,200);">#remark11#</textarea>	</td>
		<cfelseif lcase(HcomID) neq "avt_i">
			<th <cfif rem11display neq "Y">style="visibility:hidden"</cfif>>#getGsetup.rem11#</th>
			<td <cfif rem11display neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark11" value="#remark11#" size="40" maxlength="300"></td>
		
		<cfelse>
			<td colspan="2"></td>
	  </cfif>
	</tr>
	<tr>
		<th <cfif deltel neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">Heading<cfelse>#words[1289]#</cfif></th>

		<td colspan="2" <cfif deltel neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark12" size="40" maxlength="35" <cfif lcase(HcomID) eq "hl_i" and tran eq "PO"> value="#remark12#"<cfelse>value="#remark12#" readonly</cfif>></td>

		<!--- Add on 01-12-2008 --->
   	  <cfif lcase(HcomID) eq "avent_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakasia_i" or lcase(hcomid) eq "techpakbill_i">
			<th>FOB/CIF</th>
   		<td><input type="text" name="xremark3" value="#xremark3#" maxlength="10"></td>
        <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
        	<th>Cheque No:</th>
          <td><cfif isdefined('checkno')>
			  <input type="text" name="checkno" value="#checkno#" maxlength="12">
              </cfif></td>
		<cfelse>
		<td colspan="2">&nbsp;</td>
		</cfif>
	</tr>
    
    <cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i")>
            <tr><td></td><td></td><td></td>
            <th>Certificate Of Merit</th>
          <td>
			  <select name="remark13" id="remark13">
<option value="" <cfif remark13 eq "">Selected</cfif>>Please select a COM</option>
<option value="true" <cfif remark13 eq "true">Selected</cfif>>True</option>
<option value="false" <cfif remark13 eq "false">Selected</cfif>>False</option>
</select><cfinput type="hidden" id="remark131" name="remark131" bind="cfc:accordtran2.getremark13('#dts#',{remark5})">
</td>
            </tr>
        </cfif>
    
	<cfif lcase(HcomID) eq "avt_i">
	<tr>
		<th>#getgsetup.rem11#</th>
		<td colspan="5">
			<textarea name="remark11" wrap="physical" cols="60" rows="5" onKeyDown="textCounter(this.form.remark11,this.form.remLen,300);" onKeyUp="textCounter(this.form.remark11,this.form.remLen,300);">#remark11#</textarea><br>
			<input readonly type="text" name="remLen" size="3" maxlength="3" value="300"> characters left ( You may enter up to 300 characters. )<br></font>		</td>
	</tr>
	</cfif>
    <!--- Add on 290608 --->
    <cfif lcase(HcomID) eq "avent_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakasia_i" or lcase(hcomid) eq "techpakbill_i">
    <tr>
    	<th rowspan="2">Comment</th>
        <td><select name="comment_selection" onChange="changeComment();">
        		<option value="">Select a comment</option>
                <cfloop query="getcomment">
                	<option value="#getcomment.code#">#getcomment.desp#</option>
                </cfloop>
            </select>        </td>
    </tr>
    <tr><td><textarea name="comment_selected" wrap="physical" cols="70" rows="4">#xremark1#</textarea></td></tr>
	<tr>
		<th>Designation</th>
		<td><textarea name="xremark2" wrap="physical" cols="70" rows="4">#xremark2#</textarea></td>
	</tr>
	<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i">
		<tr>
    		<th>Installation & Commissioning</th>
      		<td><select name="xremark1">
					<option value="1" <cfif xremark1 eq "1">selected</cfif>>Yes</option>
        			<option value="" <cfif xremark1 eq "">selected</cfif>>No</option>
            	</select>        	</td>
		</tr>
		<tr>
			<th>Note</th>
			<td><textarea name="xremark2" wrap="physical" cols="60" rows="4">#xremark2#</textarea></td>
		</tr>
	<cfelseif lcase(HcomID) eq "winbells_i">
		<tr><td colspan="100%"><hr></td></tr>
		<tr>
    		<th>JOB REF</th>
      		<td><input type="text" name="xremark1" value="#xremark1#" size="40"></td>
			<td></td>
			<th>Port Of Discharge</th>
      		<td><input type="text" name="xremark9" value="#xremark9#" size="40"></td>
		</tr>
		<tr>
			<th>CARRIER</th>
			<td><input type="text" name="xremark2" value="#xremark2#" size="40"></td>
			<td></td>
			<th>ETD</th>
      		<td><input type="text" name="xremark10" value="#xremark10#" size="40"></td>
		</tr>
		<tr>
			<th>OB/L REF</th>
			<td><input type="text" name="xremark3" value="#xremark3#" size="40"></td>
			<td></td>
			<th>ETA</th>
      		<td><input type="text" name="xremark11" value="#xremark11#" size="40"></td>
		</tr>
		<tr>
			<th>HB/L REF</th>
			<td><input type="text" name="xremark4" value="#xremark4#" size="40"></td>
			<td></td>
			<th>FLIGHT</th>
      		<td><input type="text" name="xremark12" value="#xremark12#" size="40"></td>
		</tr>
		<tr>
			<th>M VESSEL</th>
			<td><input type="text" name="xremark5" value="#xremark5#" size="40"></td>
			<td></td>
			<th>DATE</th>
      		<td><input type="text" name="xremark13" value="#xremark13#" size="40"></td>
		</tr>
		<tr>
			<th>F VESSEL</th>
			<td><input type="text" name="xremark6" value="#xremark6#" size="40"></td>
			<td></td>
			<th>MASTER AWB NO.</th>
      		<td><input type="text" name="xremark14" value="#xremark14#" size="40"></td>
		</tr>
		<tr>
			<th>VOYAGE</th>
			<td><input type="text" name="xremark7" value="#xremark7#" size="40"></td>
			<td></td>
			<th>HAWB NO.</th>
      		<td><input type="text" name="xremark15" value="#xremark15#" size="40"></td>
		</tr>
		<tr>
			<th>Port Of Loading</th>
			<td><input type="text" name="xremark8" value="#xremark8#" size="40"></td>
			<td></td>
			<th>AIR WAY BILL</th>
      		<td><input type="text" name="xremark16" value="#xremark16#" size="40"></td>
		</tr>
		<tr>
			<th>CONTAINER NO.</th>
			<td>
				<textarea name="xremark17" wrap="physical" cols="40" rows="4">#xremark17#</textarea>			</td>
		</tr>
    <cfelseif lcase(HcomID) eq "iel_i">
		<tr><td colspan="100%"><hr></td></tr>
		<tr>
    		<th>TRANSPORTATION OF</th>
      		<td><input type="text" name="xremark1" value="#xremark1#" size="40"></td>
			<td></td>
			<th rowspan="3">DIMENSION</th>
      		<td rowspan="3"><textarea name="xremark2" wrap="physical" cols="40" rows="4">#xremark2#</textarea></td>
		</tr>
        <tr>
    		<th>FROM</th>
      		<td><input type="text" name="xremark3" value="#xremark3#" size="40"></td>
			<td></td>
		</tr>
		<tr>
			<th>TO</th>
			<td><input type="text" name="xremark4" value="#xremark4#" size="40"></td>
			<td></td>
		</tr>
    <cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
		<tr>
			<th>Note</th>
			<td><textarea name="xremark1" wrap="physical" cols="60" rows="4">#xremark1#</textarea></td>
		</tr>
	<cfelseif lcase(HcomID) eq "chemline_i">
		<tr><td colspan="100%"><hr></td></tr>
		<tr>
    		<th>XRemark 1</th>
      		<td><input type="text" name="xremark1" value="#xremark1#" size="40"></td>
			<td></td>
			<th>XRemark 6</th>
      		<td><input type="text" name="xremark6" value="#xremark6#" size="40"></td>
		</tr>
		<tr>
			<th>XRemark 2</th>
			<td><input type="text" name="xremark2" value="#xremark2#" size="40"></td>
			<td></td>
			<th>XRemark 7</th>
      		<td><input type="text" name="xremark7" value="#xremark7#" size="40"></td>
		</tr>
		<tr>
			<th>XRemark 3</th>
			<td><input type="text" name="xremark3" value="#xremark3#" size="40"></td>
			<td></td>
    		<th rowspan="3">XRemark 8</th>
	        <td rowspan="3">
		        <select name="comment_selection" onChange="changeComment();">
	        		<option value="">Select a comment</option>
	                <cfloop query="getcomment">
	                	<option value="#getcomment.code#">#getcomment.desp#</option>
	                </cfloop>
	            </select><br>
		        <textarea name="comment_selected" wrap="physical" cols="40" rows="4">#xremark8#</textarea>	        </td>
	    </tr>
		<tr>
			<th>QUOT NO</th>
			<td><input type="text" name="xremark4" value="#xremark4#" size="40"></td>
			<td></td>
		</tr>
		<tr>
			<th>XRemark 5</th>
			<td><input type="text" name="xremark5" value="#xremark5#" size="40"></td>
			<td></td>
		</tr>
	<cfelseif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
		<tr>
    		<th>GST</th>
      		<td><input type="text" name="xremark1" value="#xremark1#" size="40"></td>
		</tr>
		<tr>
			<th>Validity</th>
			<td><input type="text" name="xremark2" value="#xremark2#" size="40"></td>
		</tr>
	<cfelseif lcase(HcomID) eq "probulk_i">
		<tr>
    		<th>Remark A</th>
      		<td>
				<select name="xremark1">
					<option value="Owner">Owner</option>
					<option value="Charter" <cfif xremark1 eq "Charter">selected</cfif>>Charter</option>
				</select>			</td>
			<td></td>
			<th>Remark B</th>
      		<td>
				<select name="xremark2">
					<option value="Charter Hire Payable">Charter Hire Payable</option>
					<option value="Freight Hire Payable" <cfif xremark2 eq "Freight Hire Payable">selected</cfif>>Freight Hire Payable</option>
				</select>			</td>
		</tr>
		<tr>
    		<th>Remark C</th>
      		<td><input type="text" name="xremark3" value="#xremark3#" size="40"></td>
			<td></td>
			<th rowspan="3">Remark D</th>
      		<td rowspan="3"><textarea name="xremark4" wrap="physical" cols="40" rows="4">#xremark4#</textarea></td>
		</tr>
		<tr>
    		<th>Remark E</th>
      		<td><input type="text" name="xremark5" value="#xremark5#" size="40"></td>
			<td></td>
		</tr>
		<tr>
    		<th>Remark F</th>
      		<td><input type="text" name="xremark6" value="#xremark6#" size="40"></td>
			<td></td>
		</tr>
		<tr>
    		<th>Total Bill</th>
      		<td><input type="text" name="xremark7" value="#xremark7#" size="40"></td>
			<td></td>
		</tr>
    </cfif>
    <!--- Add on 290608 --->
                <cfif lcase(hcomid) eq "mcjim_i" and tran eq "DO">
        <tr>
				<td colspan="5">
					<table align="center">
						<tr>
							<th>Material</th>
							<td colspan="4"><input type="text" name="frem0" value="#convertquote(frem0)#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Colour</th>
							<td colspan="4"><input type="text" name="frem1" value="#convertquote(frem1)#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Specification</th>
							<td colspan="4"><input type="text" name="frem2" value="#frem2#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Requirement</th>
							<td colspan="4"><input type="text" name="frem3" value="#frem3#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (1)</th>
							<td colspan="4"><input type="text" name="frem4" value="#frem4#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (2)</th>
							<td colspan="4"><input type="text" name="frem5" value="#frem5#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (3)</th>
							<td colspan="4"><input type="text" name="frem6" value="#frem6#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (4)</th>
							<td colspan="4"><input type="text" name="frem7" value="#convertquote(frem7)#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (5)</th>
							<td colspan="4">
							<input type="text" name="frem8" value="#convertquote(frem8)#" maxlength="80" size="80">							</td>

							<input type="hidden" name="comm0" value="#convertquote(comm0)#">
							<input type="hidden" name="remark13" value="#remark13#">
							<input type="hidden" name="remark14" value="#remark14#">
							<input type="hidden" name="comm3" value="#comm3#">
							<input type="hidden" name="comm4" value="#comm4#">
                            <input type="hidden" name="d_phone2" value="#d_phone2#">
                            <input type="hidden" name="d_email" value="#d_email#">
                            <input type="hidden" name="phonea" value="#phonea#">
                            <input type="hidden" name="e_mail" value="#e_mail#">
                            <input type="hidden" name="postalcode" value="#postalcode#">
                            <input type="hidden" name="d_postalcode" value="#d_postalcode#">
                            <input type="hidden" name="b_gstno" value="#b_gstno#">
                            <input type="hidden" name="d_gstno" value="#d_gstno#">
						</tr>
						<tr>
							<th>D.O/Invoice No. (6)</th>
							<td colspan="4"><input type="text" name="frem9" value="#frem9#" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 10</th>
							<td colspan="4"><input type="text" name="comm1" value="#convertquote(comm1)#" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 11</th>
							<td colspan="4"><input type="text" name="comm2" value="#convertquote(comm2)#" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 12</th>
							<td colspan="4"><input type="text" name="comm3" value="#convertquote(comm3)#" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 13</th>
							<td colspan="4"><input type="text" name="comm4" value="#convertquote(comm4)#" maxlength="80" size="80"><input type="hidden" name="d_phone2" value="#convertquote(d_phone2)#" maxlength="80" size="80"><input type="hidden" name="d_email" value="#convertquote(d_email)#" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 14</th>
							<td colspan="4"><input type="text" name="remark13" value="#remark13#" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 15</th>
							<td colspan="4"><input type="text" name="remark14" value="#remark14#" maxlength="80" size="80"></td>
						</tr>
					</table>				</td>
			</tr>
			</cfif>
            <cfif getgsetup.addonremark eq 'Y' or (getgsetup.bcurr eq 'MYR' and (tran eq "CN" or tran eq "DN"))>
            <tr><td colspan="5">
            <cfinclude template="tran2addon.cfm">
            </td>
</tr>
</cfif>
 <cfif getgsetup.multiagent eq 'Y'>
            <tr><td colspan="5">
            <cfinclude template="tranmultiagent.cfm">
            </td>
</tr>
</cfif>

	<tr>
		<td colspan="5" align="center">
        <cfif lcase(hcomid) eq 'mcjim_i' and tran eq "DO">
        <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i")>
        	<input type="hidden" name="frem0" value="#convertquote(frem0)#">
			<input type="hidden" name="frem1" value="#convertquote(frem1)#">
			<input type="hidden" name="frem2" value="#frem2#">
			<input type="hidden" name="frem3" value="#frem3#">
			<input type="hidden" name="frem4" value="#frem4#">
			<input type="hidden" name="frem5" value="#frem5#">
			<input type="hidden" name="frem6" value="#frem6#">
			<input type="hidden" name="frem7" value="#convertquote(frem7)#">
			<input type="hidden" name="frem8" value="#convertquote(frem8)#">
			<input type="hidden" name="frem9" value="#frem9#">
			<input type="hidden" name="comm0" value="#convertquote(comm0)#">
			<input type="hidden" name="comm1" value="#convertquote(comm1)#">
			<input type="hidden" name="comm2" value="#convertquote(comm2)#">
			<input type="hidden" name="comm3" value="#convertquote(comm3)#">
			<input type="hidden" name="comm4" value="#convertquote(comm4)#">
            <input type="hidden" name="d_phone2" value="#convertquote(d_phone2)#">
            <input type="hidden" name="d_email" value="#convertquote(d_email)#">
			<input type="hidden" name="remark14" value="#remark14#">
			<input type="hidden" name="phonea" value="#phonea#">
            <input type="hidden" name="e_mail" value="#e_mail#">
            <input type="hidden" name="postalcode" value="#postalcode#">
            <input type="hidden" name="d_postalcode" value="#d_postalcode#">
            <input type="hidden" name="b_gstno" value="#b_gstno#">
            <input type="hidden" name="d_gstno" value="#d_gstno#">
        <cfelse>
			<input type="hidden" name="frem0" value="#convertquote(frem0)#">
			<input type="hidden" name="frem1" value="#convertquote(frem1)#">
			<input type="hidden" name="frem2" value="#frem2#">
			<input type="hidden" name="frem3" value="#frem3#">
			<input type="hidden" name="frem4" value="#frem4#">
			<input type="hidden" name="frem5" value="#frem5#">
			<input type="hidden" name="frem6" value="#frem6#">
			<input type="hidden" name="frem7" value="#convertquote(frem7)#">
			<input type="hidden" name="frem8" value="#convertquote(frem8)#">
			<input type="hidden" name="frem9" value="#frem9#">
			<input type="hidden" name="comm0" value="#convertquote(comm0)#">
			<input type="hidden" name="comm1" value="#convertquote(comm1)#">
			<input type="hidden" name="comm2" value="#convertquote(comm2)#">
			<input type="hidden" name="comm3" value="#convertquote(comm3)#">
			<input type="hidden" name="comm4" value="#convertquote(comm4)#">
            <input type="hidden" name="d_phone2" value="#convertquote(d_phone2)#">
            <input type="hidden" name="d_email" value="#convertquote(d_email)#">
			<input type="hidden" name="remark13" value="#remark13#">
			<input type="hidden" name="remark14" value="#remark14#">
            <input type="hidden" name="postalcode" value="#postalcode#">
            <input type="hidden" name="d_postalcode" value="#d_postalcode#">
            <input type="hidden" name="b_gstno" value="#b_gstno#">
            <input type="hidden" name="d_gstno" value="#d_gstno#">
			<input type="hidden" name="phonea" value="#phonea#">
            <input type="hidden" name="e_mail" value="#e_mail#">
			</cfif>
			<cfif getGsetup.collectaddress eq 'Y'>
            	<input type="hidden" name="remark15" value="#remark15#">
                <input type="hidden" name="remark16" value="#remark16#">
                <input type="hidden" name="remark17" value="#remark17#">
                <input type="hidden" name="remark18" value="#remark18#">
                <input type="hidden" name="remark19" value="#remark19#">
                <input type="hidden" name="remark20" value="#remark20#">
                <input type="hidden" name="remark21" value="#remark21#">
                <input type="hidden" name="remark22" value="#remark22#">
                <input type="hidden" name="remark23" value="#remark23#">
                <input type="hidden" name="remark24" value="#remark24#">
                <input type="hidden" name="remark25" value="#remark25#">
            </cfif>
            <cfif lcase(hcomid) eq 'ugateway_i'>
            	<input type="hidden" name="via" value="#via#" >
			</cfif>	
			<input type="hidden" name="readpeiod" value="#getartran.fperiod#">
            <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid)eq "gorgeous_i">
            <input name="main" type="button" value="#words[1825]#" onClick="location.href='tran_edit1.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(custno)#&first=0'">
            <cfelseif lcase(hcomid) eq "rpi270505_i">
            
            <cfif getartran.accepted eq "Y" and getpin2.h9100 neq 'T'>
            <cfelse>
            <input name="main" type="button" value="#words[1825]#" onClick="location.href='tran_edit1.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(custno)#&first=0'">
            </cfif>
            
            <cfelseif tran eq "RC" or tran eq "PO" or tran eq "PR" or tran eq "RQ"> 
			<input name="main" type="button" value="#words[1827]#" onClick="location.href='tran_edit1.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(custno)#&first=0'">
            <cfelse>
            <input name="main" type="button" value="#words[1825]#" onClick="location.href='tran_edit1.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(custno)#&first=0'">
            </cfif>
			<!--- ADD ON 10-12-2009 --->
			<input name="submit1" type="submit" value="  Save  "<cfif getGsetup.filterall eq "1"> onclick="checkupdate();"</cfif>>
            <cfif getpin2.h2107 eq 'T' and tran eq 'RC'>
            <cfelseif getpin2.h2206 eq 'T' and tran eq 'PR'>
            <cfelseif getpin2.h2307 eq 'T' and tran eq 'DO'>
            <cfelseif getpin2.h2406 eq 'T' and tran eq 'INV'>
            <cfelseif getpin2.h2506 eq 'T' and tran eq 'CS'>
            <cfelseif getpin2.h2606 eq 'T' and tran eq 'CN'>
            <cfelseif getpin2.h2706 eq 'T' and tran eq 'DN'>
            <cfelseif getpin2.h2857 eq 'T' and tran eq 'SAM'>
            <cfelseif getpin2.h2868 eq 'T' and tran eq 'PO'>
            <cfelseif getpin2.h28G7 eq 'T' and tran eq 'RQ'>
            <cfelseif getpin2.h287B eq 'T' and tran eq 'QUO'>
            <cfelseif getpin2.h2889 eq 'T' and tran eq 'SO'>
            <cfelse>
			<input name="submit1" type="submit" value="  Edit  "<cfif getGsetup.filterall eq "1"> onclick="checkupdate();"</cfif>>		</cfif></td>
	</tr>
  	</table>
  </cfoutput>
</cfform>
<cfif lcase(HcomID) eq "kimlee_i" and tran eq "CN" or lcase(HcomID) eq "bakersoven_i" and tran eq "CN">
<cfwindow center="true" width="600" height="400" name="findInvoice" refreshOnShow="true"
        title="Find Invoice" initshow="false"
        source="/default/transaction/findInvoice.cfm" />
</cfif>
<cfwindow center="true" width="550" height="400" name="findvehicle" refreshOnShow="true"
        title="Find Vehicle" initshow="false"
        source="findvehicle.cfm?custno={custno}" />
<cfwindow center="true" width="600" height="400" name="createJobAjax" refreshOnShow="true"
        title="Create Job" initshow="false"
        source="/default/transaction/createJobAjax.cfm" />
<cfwindow center="true" width="600" height="400" name="createProjectAjax" refreshOnShow="true"
        title="Create Project" initshow="false"
        source="/default/transaction/createProjectAjax.cfm" />
<cfwindow center="true" width="580" height="400" name="findproject" refreshOnShow="true"
        title="Find Project" initshow="false"
        source="/default/transaction/findproject.cfm?type=Project" />
<cfwindow center="true" width="580" height="400" name="findjob" refreshOnShow="true"
        title="Find Job" initshow="false"
        source="/default/transaction/findjob.cfm?type=Job" />

<cfwindow center="true" width="700" height="550" name="searchmember" refreshOnShow="true" closable="true" modal="true" title="Search Member" initshow="false" 
source="searchmember.cfm" /> 


<cfif lcase(HcomID) eq "atc2005_i">
<cfwindow center="true" width="580" height="400" name="atcdatepassword" refreshOnShow="true"
        title="Edit Delivery Date" initshow="false"
        source="/default/transaction/atcdatepasswordcontrol.cfm" />        
</cfif>
<!---------------------------------------------------------------------- DATA VALIDATION ---------------------------------------------------->
<script language="JavaScript">
	function textCounter(field, countfield, maxlimit){
		if (field.value.length > maxlimit) // if too long...trim it!
			field.value = field.value.substring(0, maxlimit);
			// otherwise, update 'characters left' counter
		else 
			countfield.value = maxlimit - field.value.length;
	}// End -->
	function limitText(field,maxlimit){
		if (field.value.length > maxlimit) // if too long...trim it!
			field.value = field.value.substring(0, maxlimit);
			// otherwise, update 'characters left' counter
	}
	function displayname(){
		if(document.invoicesheet.custno.value==''){
			document.invoicesheet.name.value='';
			document.invoicesheet.name2.value='';
		}else{
			<cfoutput query ="getcustomer">
			if(document.invoicesheet.custno.value=='#getcustomer.custno#')
			{
				document.invoicesheet.refno3.value='#getcustomer.currcode#';
			}
			</cfoutput>
		}
	}
	function displayrate(){
  		if(document.invoicesheet.refno3.value==''){
			<cfoutput query ="getcustomer">
	  		if(document.invoicesheet.custno.value=='#getcustomer.custno#'){
				document.invoicesheet.refno3.value='#getcustomer.currcode#';
	  		}
			</cfoutput>
  		}
		if(document.invoicesheet.refno3.value!=''){
			<cfoutput><!--- query ="currency"--->
			if(document.invoicesheet.refno3.value=='#currency.currcode#'){	
				<cfquery datasource="#dts#" name="getGsetup">
					Select * from GSetup
				</cfquery>

				<cfset lastaccyear = dateformat(getGsetup.lastaccyear, "dd/mm/yyyy")>
				<cfset period = getGsetup.period>
				<cfset currentdate = dateformat(nDateCreate,"dd/mm/yyyy")>
				<cfset tmpYear = year(currentdate)>
				<cfset clsyear = year(lastaccyear)>
				<!--- MODIFIED ON 04-02-2009 --->
				<!--- <cfset tmpmonth = month(currentdate)> --->
				<cfset tmpmonth = month(nDateCreate)>
				<cfset clsmonth = month(lastaccyear)>
				<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

				<cfif intperiod gt 18 or intperiod lte 0>
					<cfset readperiod = 99>
				<cfelse>
					<cfset readperiod = numberformat(intperiod,"00")>
				</cfif>
				
				<cfset rates2 = currrate>
				<cfloop from='1' to="18" index="i">
    
				<cfif readperiod eq numberformat(i,'00')>
				
				<cfquery name="getdaycurrency" datasource="#dts#">
				select * 
				from #target_currencymonth# 
				where currcode='#getcustomer.currcode#' and fperiod='#numberformat(i,'00')#'
				</cfquery>
				<cfif getdaycurrency.recordcount neq 0>
					<cfset rates2 = evaluate('getdaycurrency.CurrD#day(createdate(right(currentdate,4),mid(currentdate,4,2),left(currentdate,2)))#')>
				<cfelse>
					<cfset rates2 = evaluate('currency.CurrP#i#')>
				</cfif>
				</cfif>
				
				</cfloop>
				
				<!---
				<cfif readperiod eq '01'>
					<cfset rates2 = currency.CurrP1>
				<cfelseif readperiod eq '02'>
					<cfset rates2 = currency.CurrP2>
				<cfelseif readperiod eq '03'>
					<cfset rates2 = currency.CurrP3>
				<cfelseif readperiod eq '04'>
					<cfset rates2 = currency.CurrP4>
				<cfelseif readperiod eq '05'>
					<cfset rates2 = currency.CurrP5>
				<cfelseif readperiod eq '06'>
					<cfset rates2 = currency.CurrP6>
				<cfelseif readperiod eq '07'>
					<cfset rates2 = currency.CurrP7>
				<cfelseif readperiod eq '08'>
					<cfset rates2 = currency.CurrP8>
				<cfelseif readperiod eq '09'>
					<cfset rates2 = currency.CurrP9>
				<cfelseif readperiod eq '10'>
					<cfset rates2 = currency.CurrP10>
				<cfelseif readperiod eq '11'>
					<cfset rates2 = currency.CurrP11>
				<cfelseif readperiod eq '12'>
					<cfset rates2 = currency.CurrP12>
				<cfelseif readperiod eq '13'>
					<cfset rates2 = currency.CurrP13>
				<cfelseif readperiod eq '14'>
					<cfset rates2 = currency.CurrP14>
				<cfelseif readperiod eq '15'>
					<cfset rates2 = currency.CurrP15>
				<cfelseif readperiod eq '16'>
					<cfset rates2 = currency.CurrP16>
				<cfelseif readperiod eq '17'>
					<cfset rates2 = currency.CurrP17>
				<cfelseif readperiod eq '18'>
					<cfset rates2 = currency.CurrP18>
				<cfelse>
					<cfset rates2 = currrate>
				</cfif>--->
				<cfif lcase(hcomid) eq 'maranroad_i' or lcase(hcomid) eq 'asramaraya_i'>
				document.invoicesheet.currrate.value='#numberformat(rates2,".__________")#';
				<cfelse>
				document.invoicesheet.currrate.value='#numberformat(rates2,"._____")#';
				</cfif>
			}
			</cfoutput>
		}
	}
	function NextTransNo(){
   		document.invoicesheet.currefno.value == '#currefno#';
   		return true;
 	}
	function ChgDueDate(){
  		if(document.invoicesheet.terms.value != ''){
			<cfoutput query ="getTerm">
 			if(document.invoicesheet.terms.value == '#term#')
			{
        		<cfif sign eq "P">
        			<cfquery datasource="#dts#" name="getDays">
						Select days from #target_icterm# where term = 'document.invoicesheet.terms.value'
  					</cfquery>

					<cfset Days = getDays.days>
					<cfset xDate = "#dateformat(nDateCreate, "dd/mm/yyyy")#">
					<cfset yDate = DateAdd("y", #Days#, #xDate#)>
  					document.invoicesheet.remark6.value = '#dateformat(yDate, "dd/mm/yyyy")#';
  				</cfif>
  			}
 			</cfoutput>
   		}else{
       		document.invoicesheet.remark6.value = '';
   		}
 	}
	
	function convertDate(inputFormat) {
	  function pad(s) { return (s < 10) ? '0' + s : s; }
	  var d = new Date(inputFormat);
	  return [pad(d.getDate()), pad(d.getMonth()+1), d.getFullYear()].join('/');
	}
	
	function ChgDueDate2(){
  		if(document.invoicesheet.terms.value != ''){
			<cfoutput>
				<cfquery datasource="#dts#" name="getDays">
					Select days from #target_icterm# where term = 'document.invoicesheet.terms.value'
				</cfquery>
				
				<cfset Days = getDays.days>
				<cfset xDate = "#dateformat(nDateCreate, "yyyy-mm-dd")#">
				var dat = new Date("#xDate#")
			</cfoutput>
			var to = new Date();
 			to.setDate(dat.getDate()+(document.invoicesheet.terms.options[document.invoicesheet.terms.selectedIndex].title*1));
  			document.invoicesheet.remark9.value=convertDate(to); 			
   		}else{
       		document.invoicesheet.remark9.value = '';
		}		
 	}
	
	function updatetermdetail()
	{
  		ajaxFunction(document.getElementById('termajax'),'/default/transaction/tran2termajax.cfm?term='+escape(document.getElementById('terms').value)+'&tran='+escape(document.getElementById('tran').value));
		
		setTimeout("document.invoicesheet.remark6.value = document.getElementById('hidtermvalidity').value;",300);
		setTimeout("document.invoicesheet.remark7.value = document.getElementById('hidtermleadtime').value;",300);
		setTimeout("document.invoicesheet.remark11.value = document.getElementById('hidtermremarks').value;",300);
 	}
	
	function bnbpupdatedetail()
	{
  		ajaxFunction(document.getElementById('termajax'),'/default/transaction/tran2bnbremarkajax.cfm?no='+escape(document.getElementById('remark10').value)+'&tran='+escape(document.getElementById('tran').value));
		
		setTimeout("document.invoicesheet.remark11.value = document.getElementById('hidtermandconditionremarks').value;",300);
 	}
	
	//Add on 300608
	function changeComment(){
		var a = document.invoicesheet.comment_selection.options[document.invoicesheet.comment_selection.selectedIndex].value;
		if(a != ''){
			document.all.feedcontact1.dataurl="databind/act_getcomment.cfm?commentcode=" + a;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
	
	function show_info(rset){
		rset.MoveFirst();
		document.invoicesheet.comment_selected.value = unescape(rset.fields("commentdetails").value);
	}
</script>
<div id="keeptrackbug">
</div>
<cfif isdefined('url.posttrue')>

<script type="text/javascript">
<cfif lcase(HcomID) eq "hyray_i">
<cfoutput>
ajaxFunction(document.getElementById('keeptrackbug'),'/default/transaction/keeptrackbug.cfm?agenno='+document.getElementById("agenno").value+'&type=create&fieldtype=agent&custno=#custno#&tran=#tran#&refno=#currefno#');
</cfoutput>
</cfif>
document.invoicesheet.submit();
</script>
</cfif>

<!---new--->
<cfif lcase(HcomID) eq "imiqgroup_i" and isdefined('url.auto')>
<script type="text/javascript">
document.invoicesheet.submit();
</script>
</cfif>
<!---new--->

</body>
</html>