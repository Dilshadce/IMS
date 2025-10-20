<cfinclude template="dealer_setting_checking/selling_above_credit_limit_header_part.cfm">
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<cfajaximport tags="cfform">
<cfajaximport tags="cfwindow,cflayout-tab"> 
<cfparam name="alcreate" default="0">
<cfset sono = "">
<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>

<cfif tran eq "RC">
	<cfset tran = "RC">
  	<cfset tranname = gettranname.lRC>
  	<cfset trancode = "rcno">
  	<cfset tranarun = "rcarun">

	<cfif getpin2.h2102 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "PR">
  	<cfset tran = "PR">
  	<cfset tranname = gettranname.lPR>
  	<cfset trancode = "prno">
  	<cfset tranarun = "prarun">

	<cfif getpin2.h2201 eq 'T'>
 		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "DO">
	<cfset tran = "DO">
	<cfset tranname = gettranname.lDO>
	<cfset trancode = "dono">
    <cfset tranarun = "doarun">

	<cfif getpin2.h2301 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "INV">
  	<cfset tran = "INV">
  	<cfset tranname = gettranname.lINV>

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
</cfif>

<cfif tran eq "CS">
  	<cfset tran = "CS">
  	<cfset tranname = gettranname.lCS>
  	<cfset trancode = "csno">
  	<cfset tranarun = "csarun">

	<cfif getpin2.h2501 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "CN">
  	<cfset tran = "CN">
  	<cfset tranname = gettranname.lCN>
  	<cfset trancode = "cnno">
  	<cfset tranarun = "cnarun">

	<cfif getpin2.h2601 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "DN">
  	<cfset tran = "DN">
  	<cfset tranname = gettranname.lDN>
  	<cfset trancode = "dnno">
  	<cfset tranarun = "dnarun">

	<cfif getpin2.h2701 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "PO">
  	<cfset tran = "PO">
  	<cfset tranname = gettranname.lPO>
  	<cfset trancode = "pono">
  	<cfset tranarun = "poarun">

	<cfif getpin2.h2861 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "RQ">
  	<cfset tran = "RQ">
  	<cfset tranname = gettranname.lRQ>
  	<cfset trancode = "rqno">
  	<cfset tranarun = "rqarun">

	<cfif getpin2.h28G1 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "QUO">
  	<cfset tran = "QUO">
  	<cfset tranname = gettranname.lQUO>
  	<cfset trancode = "quono">
  	<cfset tranarun = "quoarun">

	<cfif getpin2.h2871 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "SO">
  	<cfset tran = "SO">
  	<cfset tranname = gettranname.lSO>
  	<cfset trancode = "sono">
  	<cfset tranarun = "soarun">

	<cfif getpin2.h2881 eq 'T'>
 		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfif tran eq "SAM">
	<cfset tran = "SAM">
	<cfset tranname = gettranname.lSAM>
	<cfset trancode = "samno">
	<cfset tranarun = "samarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SAMM" and lcase(hcomid) eq "hunting_i">
	<cfset tran = "SAMM">
	<cfset tranname = "Sales Order">
	<cfset trancode = "sammno">
	<cfset tranarun = "sammarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<html>
<head>
	<title><cfoutput>#tranname#</cfoutput></title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/stylesheet/style.css"/>
	<link href="../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
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
	</script>
</head>

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_info(this.recordset);</script>

<script src="../../scripts/CalendarControl.js" language="javascript"></script>
<script type="text/javascript" src="/scripts/prototype.js"></script>
<script type="text/javascript" src="/scripts/effects.js"></script>
<script type="text/javascript" src="/scripts/controls.js"></script>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
  	<cfquery name="getcustomer" datasource="#dts#">
		select custno,name,name2,currcode,END_USER from #target_apvend# where custno ='#form.custno#'
  	</cfquery>

	<cfset ptype = "Supplier">
<cfelse>
  	<cfquery name="getcustomer" datasource="#dts#">
		select custno,name,name2,currcode,END_USER from #target_arcust# where custno ='#form.custno#'
  	</cfquery>

	<cfset ptype = "Customer">
</cfif>

<!--- ADD ON 23-02-2009, PURPOSE: NET_I NEW PO FORMAT --->
<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "PO">
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
	select driverno,attn from driver where customerno = '#form.custno#' and customerno <>'' order by driverno
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
		select driverno,name,attn from driver where customerno = '#form.custno#' and customerno <>'' order by driverno
	</cfquery>
</cfif> --->

<cfquery name="getdriver" datasource="#dts#">
	select driverno,name,attn from driver where (customerno = '#custno#' or customerno ='') order by driverno
</cfquery>

<cfquery name="getagent" datasource="#dts#">
  select agent from #target_icagent# where 0=0 and (discontinueagent='' or discontinueagent is null) <cfif getpin2.h1B40 eq 'T'>and agent = '#huserid#' or agentid = '#huserid#'</cfif> order by agent
</cfquery>

<cfquery name="getterm" datasource="#dts#">
  select * from #target_icterm# order by term
</cfquery>

<!--- ADD ON 10-12-2009 --->

	<cfquery name="getProject" datasource="#dts#">
	  select * from #target_project# where porj = "P" and completedproject!='Y' order by source
	</cfquery>
	
	<cfquery name="getJob" datasource="#dts#">
	  select * from #target_project# where porj = "J" order by source
	</cfquery>


<cfif HcomID eq "pnp_i">
	<cfif isdefined("form.invset")>
		<!--- <cfquery datasource="main" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun from refnoset
			where userDept = '#dts#'
			and type = '#tran#'
			and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
		</cfquery> --->
		<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#tran#'
			and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
		</cfquery>
	<cfelse>
		<cfinclude template="../../pnp/get_target_refno.cfm">
	</cfif>
<cfelse>
	<!---cfquery datasource="#dts#" name="getGeneralInfo">
	  	select 
		#trancode# as tranno, 
		#tranarun# as arun, 
		invoneset 
	  	from GSetup
	</cfquery--->
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = '#tran#'
		and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
	</cfquery> --->
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
        from refnoset
		where type = '#tran#'
		and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
	</cfquery>
</cfif>

<!--- 10-12-2009 --->
<!--- <cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery> --->

<cfif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i")>
	<cfset defaultdriver=getgsetup.driver>
<cfelse>
<cfif getgsetup.defaultenduser eq '1'>
	<cfset defaultdriver=getcustomer.END_USER>
<cfelse>
	<cfset defaultdriver = '' >
</cfif>
    
</cfif>

<cfquery name="getlocation" datasource="#dts#">
	select location,desp from iclocation order by desp
</cfquery>

<cfif lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "chemline_i">
    <cfquery datasource='#dts#' name="getcomment">
		select * from comments order by code desc 
	</cfquery>
</cfif>

<cfif form.type eq "Create">
  	<cfset lastaccyear = dateformat(getGsetup.lastaccyear, "dd/mm/yyyy")>
	<cfset period = getGsetup.period>
	<cfset currentdate = dateformat(invoicedate,"dd/mm/yyyy")>
	<cfset tmpYear = year(currentdate)>
	<cfset clsyear = year(lastaccyear)>
	<cfset tmpmonth = month(currentdate)>
	<cfset clsmonth = month(lastaccyear)>
	<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

	<cfif intperiod gt 18 or intperiod lte 0>
		<cfset readperiod = 99>
	<cfelse>
		<cfset readperiod = numberformat(intperiod,"00")>
	</cfif>

	<cfif readperiod eq '01'>
		<cfset rates2 = currency.CurrP1>
	</cfif>

	<cfif readperiod eq '02'>
		<cfset rates2 = currency.CurrP2>
	</cfif>

	<cfif readperiod eq '03'>
		<cfset rates2 = currency.CurrP3>
	</cfif>

	<cfif readperiod eq '04'>
		<cfset rates2 = currency.CurrP4>
	</cfif>

	<cfif readperiod eq '05'>
		<cfset rates2 = currency.CurrP5>
	</cfif>

	<cfif readperiod eq '06'>
		<cfset rates2 = currency.CurrP6>
	</cfif>

	<cfif readperiod eq '07'>
		<cfset rates2 = currency.CurrP7>
	</cfif>

	<cfif readperiod eq '08'>
		<cfset rates2 = currency.CurrP8>
	</cfif>

	<cfif readperiod eq '09'>
		<cfset rates2 = currency.CurrP9>
	</cfif>

	<cfif readperiod eq '10'>
		<cfset rates2 = currency.CurrP10>
	</cfif>

	<cfif readperiod eq '11'>
		<cfset rates2 = currency.CurrP11>
	</cfif>

	<cfif readperiod eq '12'>
		<cfset rates2 = currency.CurrP12>
	</cfif>

	<cfif readperiod eq '13'>
		<cfset rates2 = currency.CurrP13>
	</cfif>

	<cfif readperiod eq '14'>
		<cfset rates2 = currency.CurrP14>
	</cfif>

	<cfif readperiod eq '15'>
		<cfset rates2 = currency.CurrP15>
	</cfif>

	<cfif readperiod eq '16'>
		<cfset rates2 = currency.CurrP16>
	</cfif>

	<cfif readperiod eq '17'>
		<cfset rates2 = currency.CurrP17>
	</cfif>

	<cfif readperiod eq '18'>
		<cfset rates2 = currency.CurrP18>
	</cfif>
    
    <cfif readperiod eq '99' and getgsetup.allowedityearend eq "Y" >
    	<cfset rates2 = currency.CurrP1>
	</cfif>

	<cfif readperiod eq '00'>
		<h3>Error, your Last A/C Year Closing Date is wrong. Please correct it.</h3>
		<cfabort>
	</cfif>
    <cfif readperiod eq '99' and getgsetup.allowedityearend eq "N">
        <h3>Error, the bill date is over period 18. Please contact system administrator.</h3>
        <cfabort>
    <cfelseif readperiod eq '99' and getgsetup.allowedityearend eq "Y" and tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM">
    	<h3>Error, the bill date is over period 18. Please contact system administrator.</h3>
        <cfabort>
    </cfif>

    <cfif getGeneralInfo.arun eq "1">
		<cfset refnocnt = len(getGeneralInfo.tranno)>
		<cfset cnt = 0>
		<cfset yes = 0>

		<cfloop condition = "cnt lte refnocnt and yes eq 0">
			<cfset cnt = cnt + 1>
			<cfif isnumeric(mid(getGeneralInfo.tranno,cnt,1))>
				<cfset yes = 1>
			</cfif>
		</cfloop>

		<cfset nolen = refnocnt - cnt + 1>
		<!--- <cfset nextno = right(getGeneralInfo.tranno,nolen) + 1> --->
		<cftry>
			<cfset nextno = right(getGeneralInfo.tranno,nolen) + 1>
			<cfcatch type="any">
				<cftry>
					<cfset c = len(listlast(getGeneralInfo.tranno,"/"))>
					<cfset v = "0">
					<cfloop from="2" to="#c#" index="a">
						<cfset v = v&"0">
					</cfloop>
					<cfset a = numberformat(right(getGeneralInfo.tranno,4) + 1,v)>
					<cfset nextno = listfirst(getGeneralInfo.tranno,"/")&"/"&a>
				<cfcatch type="any">
					<cfset nextno=0>
				</cfcatch>
				</cftry>
			</cfcatch>
		</cftry>

		<cfset nocnt = 1>
		<cfset zero = "">

		<cfloop condition = "nocnt lte nolen">
			<cfset zero = zero & "0">
			<cfset nocnt = nocnt + 1>
		</cfloop>

		<cfif tran eq 'SO' or tran eq 'PO' or tran eq 'QUO' or tran eq 'RQ'>
			<cfset limit = 24>
		<cfelse>
			<cfset limit = 20>
		</cfif>
		
		<cftry>
			<cfif cnt gt 1>
				<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
				<cfif len(nexttranno) gt limit>
					<cfset nexttranno = '99999999'>
				</cfif>
			<cfelse>
				<cftry>
					<cfset nexttranno = numberformat(nextno,zero)>
					<cfcatch type="any">
					<cfset nexttranno = nextno>
					</cfcatch>
				</cftry>
	
				<cfif len(nexttranno) gt limit>
					<cfset nexttranno = '99999999'>
				</cfif>
			</cfif>
		<cfcatch type="any">
			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
			<cfset nexttranno = newnextNum>	
		</cfcatch>
		</cftry>
		
		<!--- <cfif cnt gt 1>
			<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
			<cfif len(nexttranno) gt limit>
				<cfset nexttranno = '99999999'>
			</cfif>
		<cfelse>
			<cftry>
				<cfset nexttranno = numberformat(nextno,zero)>
				<cfcatch type="any">
				<cfset nexttranno = nextno>
				</cfcatch>
			</cftry>

			<cfif len(nexttranno) gt limit>
				<cfset nexttranno = '99999999'>
			</cfif>
		</cfif> --->
     	<!---  <cfset nexttranno = #getGeneralInfo.tranno# + 1> --->
	
		<!--- ADD ON 19-12-2008 --->
		<!--- <cfif lcase(HcomID) eq "mhsl_i" and tran eq "INV"> --->
		<cfif (lcase(HcomID) eq "mhsl_i" and tran eq "INV") or (lcase(HcomID) eq "ideal_i")>
			<cfset actual_nexttranno = nexttranno>
			<cfif getGeneralInfo.refnocode2 neq "">
				<cfset nexttranno = actual_nexttranno&"/"&getGeneralInfo.refnocode2>
			</cfif>
		<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
			<cfset actual_nexttranno = nexttranno>
			<cfif getGeneralInfo.refnocode2 neq "">
				<cfset nexttranno = actual_nexttranno&"-"&getGeneralInfo.refnocode2>
			</cfif>
		<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "kingston_i" or lcase(HcomID) eq "probulk_i">
			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
			<cfset nexttranno = newnextNum>	
        <cfelse>
        	<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
        	<cfset actual_nexttranno = newnextNum>
            <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
				<cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
            <cfelse>
            	<cfset nexttranno = actual_nexttranno>
			</cfif>		
		</cfif>
	
	  	<cfset tranarun_1 = getGeneralInfo.arun>
   	<cfelse>
      	<cfquery name="getChkDuplicate" datasource='#dts#'>
        	Select * from artran where type = '#type#' and refno = '#form.nexttranno#'
      	</cfquery>

      	<cfoutput query ="getChkDuplicate">
        	<cfif getChkDuplicate.recordcount GT 0 >
            	<h3><font color="##FF0000">Your #tranname# Number's (#form.nexttranno#) has been created already.<br>Press back to edit it.</font></h3>
          		<cfabort>
  	    	</cfif>
      	</cfoutput>

	  	<cfset nexttranno = "">
	  	<cfset tranarun_1 = "0">
	</cfif>
</cfif>

<body  <cfif isdefined('form.checkfast')>style="visibility:hidden"</cfif>>

<cfoutput>
	<cfif form.type eq "Delete">
    	<cfquery datasource='#dts#' name="getitem">
	  		select * from artran where refno='#form.currefno#' and type = "#tran#"
    	</cfquery>
		
		<cfif lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "winbells_i" or lcase(HcomID) eq "iel_i" or 
		lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i" or lcase(HcomID) eq "chemline_i" or 
		lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i" or lcase(HcomID) eq "probulk_i">
		
			<cfquery datasource='#dts#' name="getartran_comment">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
			</cfquery>
		  <cfif getartran_comment.recordcount neq 0>
				<cfset xremark1 = tostring(getartran_comment.remark1)>
				<cfset xremark2 = tostring(getartran_comment.remark2)>
				<cfset xremark3 = tostring(getartran_comment.remark3)>
				<cfset xremark4 = tostring(getartran_comment.remark4)>
				<cfset xremark5 = tostring(getartran_comment.remark5)>
				<cfset xremark6 = tostring(getartran_comment.remark6)>
				<cfset xremark7 = tostring(getartran_comment.remark7)>
				<cfset xremark8 = tostring(getartran_comment.remark8)>
				<cfset xremark9 = tostring(getartran_comment.remark9)>
				<cfset xremark10 = tostring(getartran_comment.remark10)>
			<cfif lcase(HcomID) eq "winbells_i">
					<cfset xremark11 = tostring(getartran_comment.remark11)>
					<cfset xremark12 = tostring(getartran_comment.remark12)>
					<cfset xremark13 = tostring(getartran_comment.remark13)>
					<cfset xremark14 = tostring(getartran_comment.remark14)>
					<cfset xremark15 = tostring(getartran_comment.remark15)>
					<cfset xremark16 = tostring(getartran_comment.remark16)>
					<cfset xremark17 = tostring(getartran_comment.remark17)>
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
		<!--- <cfif lcase(HcomID) eq "avent_i">
			<!--- <cfquery datasource='#dts#' name="getartran_comment">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
			</cfquery>
   			<cfif getartran_comment.recordcount neq 0>
				<cfset comment = tostring(getartran_comment.remark1)>
				<cfset designation = tostring(getartran_comment.remark2)>
				<!--- Add on 01-12-2008 --->
				<cfset fobcif = tostring(getartran_comment.remark2)>
			<cfelse>
				<cfset comment = "">
				<cfset designation = "">
				<cfset fobcif = "">
			</cfif> --->
			<cfquery datasource='#dts#' name="getartran_comment">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
			</cfquery>
   			<cfif getartran_comment.recordcount neq 0>
				<cfset xremark1 = tostring(getartran_comment.remark1)>
				<cfset xremark2 = tostring(getartran_comment.remark2)>
				<cfset xremark3 = tostring(getartran_comment.remark2)>
			<cfelse>
				<cfset xremark1 = "">
				<cfset xremark2 = "">
				<cfset xremark3 = "">
			</cfif>
		<cfelseif lcase(HcomID) eq "topsteel_i">
			<cfquery datasource='#dts#' name="getartran_comment">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
			</cfquery>
   			<cfif getartran_comment.recordcount neq 0>
				<cfset xremark1 = tostring(getartran_comment.remark1)>
				<cfset xremark2 = tostring(getartran_comment.remark2)>
			<cfelse>
				<cfset xremark1 = "">
				<cfset xremark2 = "">
			</cfif>
		<cfelseif lcase(HcomID) eq "winbells_i">
			<cfquery datasource='#dts#' name="getartran_comment">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
			</cfquery>
   			<cfif getartran_comment.recordcount neq 0>
				<cfset xremark1 = tostring(getartran_comment.remark1)>
				<cfset xremark2 = tostring(getartran_comment.remark2)>
				<cfset xremark3 = tostring(getartran_comment.remark3)>
				<cfset xremark4 = tostring(getartran_comment.remark4)>
				<cfset xremark5 = tostring(getartran_comment.remark5)>
				<cfset xremark6 = tostring(getartran_comment.remark6)>
				<cfset xremark7 = tostring(getartran_comment.remark7)>
				<cfset xremark8 = tostring(getartran_comment.remark8)>
				<cfset xremark9 = tostring(getartran_comment.remark9)>
				<cfset xremark10 = tostring(getartran_comment.remark10)>
				<cfset xremark11 = tostring(getartran_comment.remark11)>
				<cfset xremark12 = tostring(getartran_comment.remark12)>
				<cfset xremark13 = tostring(getartran_comment.remark13)>
				<cfset xremark14 = tostring(getartran_comment.remark14)>
				<cfset xremark15 = tostring(getartran_comment.remark15)>
				<cfset xremark16 = tostring(getartran_comment.remark16)>
				<cfset xremark17 = tostring(getartran_comment.remark17)>
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
			<cfquery datasource='#dts#' name="getartran_comment">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
			</cfquery>
   			<cfif getartran_comment.recordcount neq 0>
				<cfset xremark1 = tostring(getartran_comment.remark1)>
				<cfset xremark2 = tostring(getartran_comment.remark2)>
				<cfset xremark3 = tostring(getartran_comment.remark3)>
				<cfset xremark4 = tostring(getartran_comment.remark4)>
			<cfelse>
				<cfset xremark1 = "">
				<cfset xremark2 = "">
				<cfset xremark3 = "">
				<cfset xremark4 = "">
			</cfif>
		<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
            <cfquery datasource='#dts#' name="getartran_remark">
                select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
            </cfquery>
            <cfif getartran_remark.recordcount neq 0>
                <cfset xremark1 = tostring(getartran_remark.remark1)>
            <cfelse>
                <cfset xremark1 = "">
            </cfif>
		<cfelseif lcase(HcomID) eq "chemline_i">
			<cfquery datasource='#dts#' name="getartran_remark">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
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
		<cfif tran eq 'SAM'>
        <cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_apvend# where custno = "#getitem.custno#"
                union all
                Select name, name2,currcode,agent from #target_arcust# where custno = "#getitem.custno#"
      		</cfquery>
        <cfelse>
		<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
	  		<cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_apvend# where custno = "#getitem.custno#"
      		</cfquery>
    	<cfelse>
	  		<cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_arcust# where custno = "#getitem.custno#"
	  		</cfquery>
    	</cfif>
        </cfif>
		
		<cfset currperiod = "CurrP"&"#val(getitem.fperiod)#">

	  <cfif getitem.currcode neq "">
			<cfset xcurrcode = getitem.currcode>
		<cfelse>
			<cfset xcurrcode = getcustomere.currcode>
	  </cfif>

		<cfset currrate = getitem.currrate>
    	<cfset wos_type = getitem.type>
    	<cfset refno2 = getitem.refno2>
    	<cfset Bil_Custno = getitem.custno>
    	<cfset custno = getitem.custno>
    	<cfset name = getcustomere.name>
    	<cfset name2 = getcustomere.name2>
    	<cfset readpreiod = getitem.fperiod>
    	<cfset nDateCreate = getitem.wos_date>
    	<cfset desp = getitem.desp>
    	<cfset despa = getitem.despa>
    	<cfset xterm = getitem.term>
    	<cfset xsource = getitem.source>
    	<cfset xjob = getitem.job>
    	<cfset xagenno = getitem.agenno>
		<cfset xdriverno = getitem.van>
    	<cfset pono = getitem.pono>
		<cfset dono = getitem.dono>
        <cfset sono = getitem.sono>
		<cfset remark0 = form.BCode>
    	<cfset remark2 = form.B_Attn>
    	<cfset remark4 = form.B_Phone>
		<cfset remark5 = getitem.rem5>
    	<cfset remark6 = getitem.rem6>
    	<cfset remark7 = getitem.rem7>
    	<cfset remark8 = getitem.rem8>
    	<cfset remark9 = getitem.rem9>
    	<cfset remark10 = getitem.rem10>
    	<cfset remark11 = getitem.rem11>
        <cfset permitno = getitem.permitno>
		<cfset frem0 = form.B_name>
		<cfset frem1 = form.B_name2>
		<cfset frem2 = form.B_add1>
		<cfset frem3 = form.B_add2>
		<cfset frem4 = form.B_add3>
		<cfset frem5 = form.B_add4>
		<cfset remark13 = form.B_add5>
		<cfset frem6 = form.B_fax>
		<cfset phonea = form.b_phone2>
        <cfset e_mail = form.b_email>

	  <cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or tran eq 'SAM' or tran eq 'QUO' or tran eq 'CS'>
		<cfif lcase(HcomID) eq "hco_i">
				<cfset remark1 = getitem.rem1>
				<cfset remark3 = getitem.rem3>
				<cfset remark12 = getitem.rem12>
				<cfset frem7 = getitem.frem7>
				<cfset frem8 = tostring(getitem.frem8)>
				<cfset frem9 = getitem.frem9>
				<cfset comm0 = getitem.comm0>
				<cfset comm1 = getitem.comm1>
				<cfset comm2 = getitem.comm2>
				<cfset comm3 = getitem.comm3>
				<cfset remark14 = getitem.rem14>
				<cfset comm4 = getitem.comm4>
                <cfset d_phone2 = ''>
			<cfelse>
				<cfset remark1 = form.DCode>
				<cfset remark3 = form.D_Attn>
				<cfset remark12 = form.D_Phone>
				<cfset frem7 = form.D_name>
				<cfset frem8 = form.D_name2>
				<cfset frem9 = form.frem9>
				<cfset comm0 = form.D_add1>
				<cfset comm1 = form.D_add2>
				<cfset comm2 = form.D_add3>
				<cfset comm3 = form.D_add4>
				<cfset remark14 = form.D_add5>
				<cfset comm4 = form.D_fax>
                <cfset d_phone2 = form.d_phone2>
		</cfif>
        <cfif getGsetup.collectaddress eq 'Y'>
				<cfset remark15 = form.CCode>
				<cfset remark16 = form.C_name>
				<cfset remark17 = form.C_name2>
				<cfset remark18 = form.C_add1>
				<cfset remark19 = form.C_add2>
				<cfset remark20 = form.C_add3>
				<cfset remark21 = form.C_add4>
				<cfset remark22 = form.C_add5>
				<cfset remark23 = form.C_attn>
				<cfset remark24 = form.C_phone>
				<cfset remark25 = form.C_fax>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = form.via>
		</cfif>
           
		<cfelse>
			<cfset remark1 = ''>
			<cfset remark3 = ''>
			<cfset remark12 = ''>
			<cfset remark14 = ''>
			<cfset frem7 = ''>
			<cfset frem8 = ''>
			<cfset frem9 = ''>
			<cfset comm0 = ''>
			<cfset comm1 = ''>
			<cfset comm2 = ''>
			<cfset comm3 = ''>
			<cfset comm4 = ''>
            <cfset d_phone2 = ''>
        <cfif getGsetup.collectaddress eq 'Y'>
				<cfset remark15 = ''>
				<cfset remark16 = ''>
				<cfset remark17 = ''>
				<cfset remark18 = ''>
				<cfset remark19 = ''>
				<cfset remark20 = ''>
				<cfset remark21 = ''>
				<cfset remark22 = ''>
				<cfset remark23 = ''>
				<cfset remark24 = ''>
				<cfset remark25 = ''>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = ''>
		</cfif>
            
	  </cfif>

    	<cfset userid = getitem.userid>
		<cfset nexttranno = form.currefno>
		<cfset mode = "Delete">
		<cfset title = "Mode  =  Delete">
		<cfset button = "Delete">
  	</cfif>

  	<cfif form.type eq "Create">
   		<cfset wos_type = "">
		
        <cfif tran eq 'SAM'>
        <cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent,term from #target_apvend# where custno = "#form.custno#"
                union all
                Select name, name2,currcode,agent,term from #target_arcust# where custno = "#form.custno#"
      		</cfquery>
        <cfelse>
		<cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent,term from #target_apvend# where custno = "#form.custno#"
	  		</cfquery>
		<cfelse>
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent,term from #target_arcust# where custno = "#form.custno#"
	  		</cfquery>
		</cfif>
        </cfif>

		<cfset Bil_Custno = "">
		<cfset xcurrcode = getcustomere.currcode>

	  <cfif rates2 eq "">
			<cfset currrate = 1>
		<cfelse>
			<cfset currrate = rates2>
	  </cfif>
		
		<cfset readpreiod = "">
      <cfif isdefined('form.refno2set')>
        <cfset refno2 = form.refno2set>
		<cfelse>
		<cfset refno2 = "">
      </cfif>
		<cfset nDateCreate = "">
	  <cfif tran eq "INV">
			<cfset desp = "SALES">
		<cfelseif tran eq "RC">
			<cfset desp = "PURCHASES">
		<cfelseif tran eq "PR">
			<cfset desp = "PURCHASES RETURN">
		<cfelseif tran eq "DO">
			<cfset desp = "DELIVERY">
		<cfelseif tran eq "CS">
			<cfset desp = "CASH SALES">
		<cfelseif tran eq "CN">
        <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "cstct_i">
        	<cfset desp = "GOODS RETURNED">
        <cfelse>
			<cfset desp = "GOOD RETURNED">
        </cfif>
		<cfelseif tran eq "DN">
			<cfset desp = "DEBIT NOTE">
		<cfelse>
			<cfset desp = "">
	  </cfif>
		<cfset despa = "">
		<cfset xterm = getcustomere.term>
    	<cfset xsource = "">
    	<cfset xjob = "">
		<cfset xagenno = getcustomere.agent>
        <cfif getcustomere.agent eq ''>
		<cfquery name="getagentfromuser" datasource="#dts#">
  select agent from #target_icagent# where 0=0 and (discontinueagent='' or discontinueagent is null) and agent = '#huserid#' or agentid = '#huserid#' order by agent
		</cfquery>
        <cfif getagentfromuser.agent neq ''>
		<cfset xagenno = getagentfromuser.agent>
        <cfelse>
        <cfset xagenno = ''>
        </cfif>
		</cfif>
        
    	<cfset xdriverno = defaultdriver>
      <cfif isdefined('form.issueno')>
            <cfset pono='#form.issueno#'>
            <cfelse>
            <cfset pono = "">
      </cfif>
		
		<cfset dono = "">
		<cfset remark0 = form.BCode>
    	<cfset remark2 = form.B_Attn>
    	<cfset remark4 = form.B_Phone>
		<cfset remark5 = "">
		<cfset remark6 = "">
		<cfset remark7 = "">
        <cfif lcase(hcomid) eq "ascend_i">
        <cfset remark8 = "Terms of Payment :">
        <cfelse>
		<cfset remark8 = "">
        </cfif>
		<cfset remark9 = "">
		<cfset remark10 = "">
		<cfset remark11 = "">
        <cfset permitno = "">
		<cfset frem0 = form.B_name>
		<cfset frem1 = form.B_name2>
		<cfset frem2 = form.B_add1>
		<cfset frem3 = form.B_add2>
		<cfset frem4 = form.B_add3>
		<cfset frem5 = form.B_add4>
		<cfset remark13 = form.B_add5>
		<cfset frem6 = form.B_fax>
		<cfset phonea = form.b_phone2>
        <cfset e_mail = form.b_email>
		
		<cfif lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "winbells_i" or lcase(HcomID) eq "iel_i" or 
		lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i" or lcase(HcomID) eq "chemline_i" or 
		lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i" or lcase(HcomID) eq "probulk_i">
			
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
		<!--- <cfif lcase(HcomID) eq "avent_i">
			<cfset xremark1 = "">
			<cfset xremark2 = "">
			<cfset xremark3 = "">
		<cfelseif lcase(HcomID) eq "topsteel_i">
			<cfset xremark1 = "">
			<cfset xremark2 = "">
		<cfelseif lcase(HcomID) eq "winbells_i">
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
        <cfelseif lcase(HcomID) eq "iel_i">
			<cfset xremark1 = "">
			<cfset xremark2 = "">
			<cfset xremark3 = "">
			<cfset xremark4 = "">
        <cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
			<cfset xremark1 = "">
		<cfelseif lcase(HcomID) eq "chemline_i">
			<cfset xremark1 = "">
			<cfset xremark2 = "">
			<cfset xremark3 = "">
			<cfset xremark4 = "">
			<cfset xremark5 = "">
			<cfset xremark6 = "">
			<cfset xremark7 = "">
			<cfset xremark8 = "">
		</cfif> --->

	  <cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or tran eq 'SAM' or tran eq 'QUO' or tran eq 'CS'>
			<cfset remark1 = form.DCode>
			<cfset remark3 = form.D_Attn>
			<cfset remark12 = form.D_Phone>
			<cfset frem7 = form.D_name>
			<cfset frem8 = form.D_name2>
			<cfset frem9 = form.frem9>
			<cfset comm0 = form.D_add1>
			<cfset comm1 = form.D_add2>
			<cfset comm2 = form.D_add3>
			<cfset comm3 = form.D_add4>
			<cfset remark14 = form.D_add5>
			<cfset comm4 = form.D_fax>
            <cfset d_phone2 = form.d_phone2>
        <cfif getGsetup.collectaddress eq 'Y'>
				<cfset remark15 = form.CCode>
				<cfset remark16 = form.C_name>
				<cfset remark17 = form.C_name2>
				<cfset remark18 = form.C_add1>
				<cfset remark19 = form.C_add2>
				<cfset remark20 = form.C_add3>
				<cfset remark21 = form.C_add4>
				<cfset remark22 = form.C_add5>
				<cfset remark23 = form.C_attn>
				<cfset remark24 = form.C_phone>
				<cfset remark25 = form.C_fax>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = form.via >
		</cfif>
            
		<cfelse>
			<cfset remark1 = ''>
			<cfset remark3 = ''>
			<cfset remark12 = ''>
			<cfset remark14 = ''>
			<cfset frem7 = ''>
			<cfset frem8 = ''>
			<cfset frem9 = ''>
			<cfset comm0 = ''>
			<cfset comm1 = ''>
			<cfset comm2 = ''>
			<cfset comm3 = ''>
			<cfset comm4 = ''>
            <cfset d_phone2 = ''>
        <cfif getGsetup.collectaddress eq 'Y'>
				<cfset remark15 = ''>
				<cfset remark16 = ''>
				<cfset remark17 = ''>
				<cfset remark18 = ''>
				<cfset remark19 = ''>
				<cfset remark20 = ''>
				<cfset remark21 = ''>
				<cfset remark22 = ''>
				<cfset remark23 = ''>
				<cfset remark24 = ''>
				<cfset remark25 = ''>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = ''>
		</cfif>
           
	  </cfif>

		<cfset userid = "">

		<!--- Same as Javascript - function ChgDueDate() --->
    	<!--- <cfif lcase(HcomID) neq "mhca_i" and lcase(HcomID) neq "thaipore_i" and lcase(hcomid) neq "jaynbtrading_i" and lcase(HcomID) neq "demo_i" and lcase(HcomID) neq "winbells_i"> --->
		<cfif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i">
			<cfif xterm neq ''>
		  		<cfloop query = "getTerm">
	 				<cfif xterm eq getTerm.term>
	          			<cfif sign eq "P">
	        				<cfquery datasource="#dts#" name="getDays">
				  				Select days from #target_icterm# where term = '#xterm#'
	  						</cfquery>
	
							<cfset Days = getDays.days>
							<cfset xDate = '#dateformat(invoicedate, 'dd/mm/yyyy')#'>
							<cfset yDate = DateAdd("y",Days,xDate)>
	  						<cfset remark6 = '#dateformat(yDate, 'dd/mm/yyyy')#'>
	   		  			<cfelse>
			    			<!---     //Not available for minus date yet. --->
	  		  			</cfif>
					</cfif>
	 	  		</cfloop>
	    	<cfelse>
	      		<cfset remark6 = ''>
			</cfif>
		<cfelse>
			<cfset remark6 = ''>
		</cfif>
		

		<cfset mode = "Create">
		<cfset title = "Mode=Create">
		<cfset button = "Create">
	</cfif>

	<cfif form.type eq "Edit">
		<cfquery datasource='#dts#' name="getitem">
	  		select * from artran where refno='#form.currefno#' and type = "#tran#"
		</cfquery>

		<cfset Bil_Custno=getitem.custno>
		<cfset custno=form.custno>
		
        <cfif tran eq 'SAM'>
        <cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_apvend# where custno = "#form.custno#"
                union all
                Select name, name2,currcode,agent from #target_arcust# where custno = "#form.custno#"
      		</cfquery>
        <cfelse>
		<cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent from #target_apvend# where custno = "#form.custno#"
	  		</cfquery>
		<cfelse>
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent from #target_arcust# where custno = "#form.custno#"
	  		</cfquery>
    	</cfif>
        </cfif>

		<cfset name = getcustomere.name>
    	<cfset name2 = getcustomere.name2>

   	  <cfif getitem.currcode neq "">
			<cfset xcurrcode = getitem.currcode>
		<cfelse>
			<cfset xcurrcode = getcustomere.currcode>
	  </cfif>

		<cfset currrate = getitem.currrate>
    	<cfset wos_type = getitem.type>
    	<cfset readpreiod = getitem.fperiod>
    	<cfset nDateCreate = getitem.wos_date>
    	<cfset refno2 = getitem.refno2>
    	<cfset desp = getitem.desp>
    	<cfset despa = getitem.despa>
    	<cfset xterm = getitem.term>
    	<cfset xsource = getitem.source>
    	<cfset xjob = getitem.job>
    	<cfset xagenno = getitem.agenno>
		<cfset xdriverno = getitem.van>
    	<cfset pono = getitem.pono>
		<cfset dono = getitem.dono>
		<cfset sono = getitem.sono>
	  <cfif lcase(HcomID) eq "hco_i">
			<cfset remark0 = getitem.rem0>
			<cfset remark2 = getitem.rem2>
			<cfset remark4 = getitem.rem4>
			<cfset remark5 = getitem.rem5>
			<cfset remark6 = getitem.rem6>
			<cfset remark7 = getitem.rem7>
			<cfset remark8 = getitem.rem8>
			<cfset remark9 = getitem.rem9>
			<cfset remark10 = getitem.rem10>
			<cfset remark11 = getitem.rem11>
            <cfset permitno = getitem.permitno>
			<cfset frem0 = getitem.frem0>
			<cfset frem1 = getitem.frem1>
			<cfset frem2 = getitem.frem2>
			<cfset frem3 = getitem.frem3>
			<cfset frem4 = getitem.frem4>
			<cfset frem5 = getitem.frem5>
			<cfset remark13 = getitem.rem13>
			<cfset frem6 = getitem.frem6>
		<cfelse>
			<cfset remark0 = form.BCode>
			<cfset remark2 = form.B_Attn>
			<cfset remark4 = form.B_Phone>
			<cfset remark5 = getitem.rem5>
			<cfset remark6 = getitem.rem6>
			<cfset remark7 = getitem.rem7>
			<cfset remark8 = getitem.rem8>
			<cfset remark9 = getitem.rem9>
			<cfset remark10 = getitem.rem10>
			<cfset remark11 = getitem.rem11>
            <cfset permitno = getitem.permitno>
			<cfset frem0 = form.B_name>
			<cfset frem1 = form.B_name2>
			<cfset frem2 = form.B_add1>
			<cfset frem3 = form.B_add2>
			<cfset frem4 = form.B_add3>
			<cfset frem5 = form.B_add4>
			<cfset remark13 = form.B_add5>
			<cfset frem6 = form.B_fax>
			<cfset phonea = form.b_phone2>
            <cfset e_mail = form.b_email>
	  </cfif>

	  <cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or tran eq 'SAM' or tran eq 'QUO' or tran eq 'CS'>
		<cfif lcase(HcomID) eq "hco_i">
				<cfset remark1 = getitem.rem1>
				<cfset remark3 = getitem.rem3>
				<cfset remark12 = getitem.rem12>
				<cfset frem7 = getitem.frem7>
				<cfset frem8 = tostring(getitem.frem8)>
				<cfset frem9 = getitem.frem9>
				<cfset comm0 = getitem.comm0>
				<cfset comm1 = getitem.comm1>
				<cfset comm2 = getitem.comm2>
				<cfset comm3 = getitem.comm3>
				<cfset remark14 = getitem.rem14>
				<cfset comm4 = getitem.comm4> 
                <cfset d_phone2 = ''>
			<cfelse>
				<cfset remark1 = form.DCode>
				<cfset remark3 = form.D_Attn>
				<cfset remark12 = form.D_Phone>
				<cfset frem7 = form.D_name>
				<cfset frem8 = form.D_name2>
				<cfset frem9 = form.frem9>
				<cfset comm0 = form.D_add1>
				<cfset comm1 = form.D_add2>
				<cfset comm2 = form.D_add3>
				<cfset comm3 = form.D_add4>
				<cfset remark14 = form.D_add5>
				<cfset comm4 = form.D_fax>
                <cfset d_phone2 = form.d_phone2>
		</cfif>
        <cfif getGsetup.collectaddress eq 'Y'>
				<cfset remark15 = form.CCode>
				<cfset remark16 = form.C_name>
				<cfset remark17 = form.C_name2>
				<cfset remark18 = form.C_add1>
				<cfset remark19 = form.C_add2>
				<cfset remark20 = form.C_add3>
				<cfset remark21 = form.C_add4>
				<cfset remark22 = form.C_add5>
				<cfset remark23 = form.C_attn>
				<cfset remark24 = form.C_phone>
				<cfset remark25 = form.C_fax>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = form.via>
		</cfif>
           
		<cfelse>
		<cfif lcase(HcomID) eq "hco_i">
				<cfset remark1 = getitem.rem1>
				<cfset remark3 = getitem.rem3>
				<cfset remark12 = getitem.rem12>
				<cfset remark14 = getitem.rem14>
				<cfset frem7 = getitem.frem7>
				<cfset frem8 = tostring(getitem.frem8)>
				<cfset frem9 = getitem.frem9>
				<cfset comm0 = getitem.comm0>
				<cfset comm1 = getitem.comm1>
				<cfset comm2 = getitem.comm2>
				<cfset comm3 = getitem.comm3>
				<cfset comm4 = getitem.comm4>
                <cfset d_phone2 = ''>
			<cfelse>
				<cfset remark1 = ''>
				<cfset remark3 = ''>
				<cfset remark12 = ''>
				<cfset remark14 = ''>
				<cfset frem7 = ''>
				<cfset frem8 = ''>
				<cfset frem9 = ''>
				<cfset comm0 = ''>
				<cfset comm1 = ''>
				<cfset comm2 = ''>
				<cfset comm3 = ''>
				<cfset comm4 = ''>
                <cfset d_phone2 = ''>
		</cfif>
        <cfif getGsetup.collectaddress eq 'Y'>
				<cfset remark15 = ''>
				<cfset remark16 = ''>
				<cfset remark17 = ''>
				<cfset remark18 = ''>
				<cfset remark19 = ''>
				<cfset remark20 = ''>
				<cfset remark21 = ''>
				<cfset remark22 = ''>
				<cfset remark23 = ''>
				<cfset remark24 = ''>
				<cfset remark25 = ''>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = ''>
		</cfif>
            
	  </cfif>

		<cfset userid = getitem.userid>
    	<cfset nexttranno = form.currefno>
		<cfset mode = "Edit">
    	<cfset title = "Mode = Edit ">
    	<cfset button = "Edit">
  	</cfif>
</cfoutput>

<cfoutput>
<h4>
	<cfif alcreate eq 1>
		<cfif HcomID eq "pnp_i">
		  <cfinclude template="../../pnp/get_authorised_multi_invoive.cfm">
		  <cfelse>
			<!---cfif getgeneralinfo.invoneset neq '1' and tran eq 'INV'--->
			<cfif getgsetup.invoneset neq '1' and tran eq 'INV'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.rc_oneset neq '1' and tran eq 'RC'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.pr_oneset neq '1' and tran eq 'PR'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.do_oneset neq '1' and tran eq 'DO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.cs_oneset neq '1' and tran eq 'CS'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.cn_oneset neq '1' and tran eq 'CN'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.dn_oneset neq '1' and tran eq 'DN'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.iss_oneset neq '1' and tran eq 'ISS'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.po_oneset neq '1' and tran eq 'PO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.so_oneset neq '1' and tran eq 'SO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.quo_oneset neq '1' and tran eq 'QUO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.assm_oneset neq '1' and tran eq 'ASSM'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.tr_oneset neq '1' and tran eq 'TR'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.oai_oneset neq '1' and tran eq 'OAI'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.oar_oneset neq '1' and tran eq 'OAR'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getgsetup.sam_oneset neq '1' and tran eq 'SAM'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelse>
				<a href="transaction1.cfm?ttype=create&tran=#tran#&nexttranno=&first=0">Create New #tranname#</a>
			</cfif> || 
		</cfif>
	</cfif>
  	<a href="transaction.cfm?tran=#tran#">List all #tranname#</a> ||
	<a href="stransaction.cfm?tran=#tran#&searchtype=&searchstr=">Search For #tranname#</a>
</h4>
</cfoutput>

<cfform name="invoicesheet" id="invoicesheet" action="transaction3.cfm" method="post">
<cfset newuuid = rereplace(createUUID(),'-','','all')>
<cfset formname = "transpage"&newuuid>
<cfset session[#formName#]="transpage">
  	<cfoutput>
    <input type="hidden" name="newuuid" value="#newuuid#"> 
	<input type="hidden" name="type" value="#listfirst(mode)#">
	<input type="hidden" name="tran" value="#listfirst(tran)#">

	<cfif isdefined("form.invset")>
		<input type="hidden" name="invset" value="#listfirst(invset)#">
		<input type="hidden" name="tranarun" value="#listfirst(tranarun)#">
	</cfif>

	<cfif form.type eq "Delete" or form.type eq "Edit">
	  	<input type="hidden" name="currefno" value="#listfirst(form.currefno)#">
	  	<input type="hidden" name="nexttranno" value="#listfirst(form.currefno)#">

		<cfif isdefined("form.recover") and form.type eq "Delete">
			<input type="hidden" name="recover" value="#listfirst(form.recover)#">
		</cfif>

	  	<cfif isdefined("form.related") and form.type eq "Delete">
	  		<input name="related" type="hidden" value="#listfirst(form.related)#">
		</cfif>
		
		<cfif isdefined("form.keepDeleted") and form.type eq "Delete">	<!--- ADD ON 22-12-2009 --->
	  		<input name="keepDeleted" type="hidden" value="#listfirst(form.keepDeleted)#">
		</cfif>
	</cfif>

	<table align="center" class="data" border="0" cellpadding="1" cellspacing="0">
      	<tr>
        	<th width="115"><cfif form.type eq "Create">Next</cfif>#tranname# No</th>
        	<td width="94">
				<cfif form.type eq "Create">
            		<cfif tranarun_1 neq "1">
              			<cfset nexttranno = form.nexttranno>
              			<input name="nexttranno" type="hidden" value="#listfirst(form.nexttranno)#">
            		</cfif>
          		</cfif>
				<h3>#nexttranno#</h3>
				<cfset session.tran_refno = nexttranno>
          	<!--- To do a marking for Update Unit Cost, because the form.type will be change after back from Transaction4.cfm --->        	</td>
        	<td nowrap>
				<cfif tran eq "RC">
					<!---Replace Checkbox updunitcost --->
					<cfinclude template = "transaction2_check_update_unit_cost.cfm">
					<!---Replace Checkbox updunitcost --->
				</cfif>			</td>
        	<th width="94">Type</th>
        	<td width="209"><h2>
            <cfif form.type eq "Create">
              New
            </cfif>

			<cfif form.type eq "Delete">
              Delete
            </cfif>

			<cfif form.type eq "Edit">
              Edit
            </cfif>
            #tranname#
			</h2></td>
      	</tr>
    	<tr>
      		<th <cfif getdisplaysetup2.billdate neq "Y">style="visibility:hidden"</cfif>>#tranname# Date</th>
      		<td colspan="2" <cfif getdisplaysetup2.billdate neq "Y">style="visibility:hidden"</cfif>>
				<cfinput type="text" name="invoicedate" size="10" value="#listfirst(form.invoicedate)#" validate="eurodate">(DD/MM/YYYY)			</td>
      		<th height="20" <cfif getdisplaysetup2.refno2 neq "Y">style="visibility:hidden"</cfif>>#getGsetup.refno2#</th>
      		<td <cfif getdisplaysetup2.refno2 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="refno2" value="#refno2#">
            <cfif isdefined('form.invset2')>
            <input type="hidden" name="invset2" value="#form.invset2#">
			</cfif>            </td>
    	</tr>
    	<tr>
      		<th <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>>#ptype# No</th>
      		<td colspan="2" <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>><input type="text" name="custno" value="#listfirst(form.custno)#" readonly></td>
      		<th <cfif getdisplaysetup2.currency neq "Y">style="visibility:hidden"</cfif>>Currency</th>
      		<td <cfif getdisplaysetup2.currency neq "Y">style="visibility:hidden"</cfif>>
				<cfif form.type eq "Create" or form.custno neq Bil_Custno>
          			<input type="text" name="refno3" value="#listfirst(xcurrcode)#" size="4" readonly>
          		<cfelse>
          			<input name="refno3" type="text" size="10" value="#listfirst(xcurrcode)#" readonly>
				</cfif>
                
           
	
          		<input name="currrate" id="currrate" type="text" size="10" value="<cfif val(listfirst(currrate)) neq 0>#Numberformat(listfirst(currrate), "._____")#<cfelse>1.000</cfif>">
          		<input type="Button" name="UpdCurrRate" value="Update" onClick="displayrate(),displayname()">
				<input type="checkbox" name="itemrate" value="1">Item Rate			</td>
    	</tr>
    	<tr>
      		<td>&nbsp;</td>
      		<td colspan="2" <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>><input name="name" type="text" size="40" maxlength="40" value="#convertquote(getcustomere.name)#" readonly></td>
			<th <cfif getdisplaysetup2.enduser neq "Y">style="visibility:hidden"</cfif>>#getGsetup.lDRIVER#</th>
      		<td <cfif getdisplaysetup2.enduser neq "Y">style="visibility:hidden"</cfif>>
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
                    <script type="text/javascript">
						var url = "/ajax/functions/getRecord.cfm";
						
						new Ajax.Autocompleter("searchdriver","hint",url,{afterUpdateElement : getSelectedId});
						
						function getSelectedId(text, li) {
							$('driver').value=li.id;
						}
					</script>
				<cfelse>	
					<select name="driver">
	          			<option value="">Choose a #getGsetup.lDRIVER#</option>
	          			<cfloop query="getdriver">
	            			<option value="#driverno#"<cfif xdriverno eq driverno>selected</cfif>>#driverno# - #name#</option>
	          			</cfloop>
					</select>	
				</cfif>
				<cfif getpin2.h1C10 eq 'T'><br /><a href="driver.cfm?type=Create" target="_blank">Create New End User</a></cfif>			</td>
    	</tr>
    	<tr>
      		<td height="23"></td>
      		<td colspan="2" <cfif getdisplaysetup2.customerno neq "Y">style="visibility:hidden"</cfif>><input name="name2" type="text" size="40" maxlength="40" value="#getcustomere.name2#" readonly></td>
      		<th <cfif getdisplaysetup2.agent neq "Y">style="visibility:hidden"</cfif>>#getGsetup.lAGENT#</th>
      		<td <cfif getdisplaysetup2.agent neq "Y">style="visibility:hidden"</cfif>><select name="agenno" id="agenno" <cfif lcase(HcomID) eq "hyray_i">onChange="ajaxFunction(document.getElementById('keeptrackbug'),'/default/transaction/keeptrackbug.cfm?agenno='+this.value+'&type=update&fieldtype=agent&custno=#listfirst(form.custno)#&tran=#tran#&refno=#nexttranno#');"</cfif>>
          		<cfif getpin2.h1B40 neq 'T' or getagent.recordcount eq 0>
					<option value="">Choose a #getGsetup.lAGENT#</option>
				</cfif>
          		<cfloop query="getagent">
            		<option value="#getagent.agent#"<cfif xagenno eq getagent.agent>Selected</cfif>>#getagent.agent#</option>
          		</cfloop>
				</select>			</td>
    	</tr>
    	<tr>
      		<th height="25" <cfif getdisplaysetup2.descp neq "Y">style="visibility:hidden"</cfif>>Description</th>
            <cfif lcase(HcomID) eq "cyberhealth_i">
            <cfset desp = getcustomere.name >
			</cfif>
      		<td colspan="2" <cfif getdisplaysetup2.descp neq "Y">style="visibility:hidden"</cfif>><input name="desp" type="text" size="40" maxlength="40" value="#desp#"></td>
			<th <cfif getdisplaysetup2.terms neq "Y">style="visibility:hidden"</cfif>>Terms</th>
      		<td <cfif getdisplaysetup2.terms neq "Y">style="visibility:hidden"</cfif>><select name="terms" id="terms" <cfif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i">onChange="ChgDueDate()"</cfif>>
          			<option value="">Choose a Terms</option>
                    <cfif lcase(HcomID) eq "taff_i" and xterm eq "" and tran eq "INV">
                    <cfset xterm = "immediate">
					</cfif>
          			<cfloop query="getterm">
            			<option value="#term#"<cfif xterm eq term>Selected</cfif>>#term#<cfif lcase(hcomid) eq 'fdipx_i'>- #getterm.desp#</cfif></option>
          			</cfloop>
				</select>      		</td>
    	</tr>
    	<tr>
      		<td height="23">&nbsp;</td>
      		<td colspan="2" <cfif getdisplaysetup2.descp neq "Y">style="visibility:hidden"</cfif>><input name="despa" type="text" size="40" maxlength="40" value="#despa#"></td>
			<cfif getgsetup.projectbybill eq "1">
	      		<th <cfif getdisplaysetup2.project neq "Y">style="visibility:hidden"</cfif>><!--- Project / Job --->#getGsetup.lPROJECT# <cfif lcase(hcomid) neq "ascend_i">/ #getGsetup.lJOB#</cfif></th>
	      		<td <cfif getdisplaysetup2.project neq "Y">style="visibility:hidden"</cfif>><select name="Source" id="Source">
	          			<option value="">Choose a <!--- Project --->#getGsetup.lPROJECT#</option>
	          			<cfloop query="getProject">
	            			<option value="#getProject.source#"<cfif xSource eq getProject.source>Selected</cfif>>#getProject.source#<cfif lcase(HcomID) eq "ascend_i">-#getproject.project#</cfif></option>
	          			</cfloop>
					</select>
                    
                    <cfif lcase(HcomID) eq "ascend_i"> <div style="visibility:hidden"></cfif>
					<select name="Job" id="Job">
	          			<option value="">Choose a <!--- Job --->#getGsetup.lJOB#</option>
	          			<cfloop query="getJob">
	            			<option value="#getJob.source#"<cfif xJob eq getJob.source>Selected</cfif>>#getJob.source#</option>
	          			</cfloop>
					</select><cfif lcase(HcomID) eq "ascend_i"> </div></cfif>				</td>
            <cfelseif getgsetup.jobbyitem eq "Y">  
              <th><!--- Project / Job --->#getGsetup.lPROJECT# / #getGsetup.lJOB#</th>
	      		<td><select name="Source" id="Source">
	          			<option value="">Choose a <!--- Project --->#getGsetup.lPROJECT#</option>
	          			<cfloop query="getProject">
	            			<option value="#getProject.source#"<cfif xSource eq getProject.source>Selected</cfif>>#getProject.source#<cfif lcase(HcomID) eq "ascend_i">-#getProject.project#</cfif></option>
	          			</cfloop>
					</select><input type="hidden" name="Job" id="Job" value="#xJob#"></td>
			<cfelse>
				<input type="hidden" name="Source" id="Source" value="#xSource#">
				<input type="hidden" name="Job" id="Job" value="#xJob#">
				<td colspan="2"></td>
			</cfif>
    	</tr>
        <cfif getGsetup.projectbybill eq "1" or getGsetup.jobbyitem eq "Y">
         <tr>
         <cfif getGsetup.transactiondate eq 'Y'>
        <th>Transaction Date</th>
      		<td colspan="2">
				<cfinput type="text" name="transactiondate" size="10" value="#listfirst(form.transactiondate)#" validate="eurodate">(DD/MM/YYYY)</td>
                <cfelse>
                <td></td>
                <td></td>
                <td></td>
                
		 </cfif>
        <th></th>
        <td <cfif getdisplaysetup2.project neq "Y">style="visibility:hidden"</cfif>><a onClick="ColdFusion.Window.show('createProjectAjax');" onMouseOver="this.style.cursor='hand';" >Create New #getgsetup.lproject#</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <cfif lcase(hcomid) neq "ascend_i">
        <a onClick="ColdFusion.Window.show('createJobAjax');" onMouseOver="this.style.cursor='hand';" >Create New #getgsetup.ljob#</a></cfif></td>
        </tr>
        <cfelse>
        <tr>
        <cfif getGsetup.transactiondate eq 'Y'>
        <th>Transaction Date</th>
      		<td colspan="2">
				<cfinput type="text" name="transactiondate" size="10" value="#listfirst(form.transactiondate)#" validate="eurodate">(DD/MM/YYYY)</td>
		 </cfif>
        <td></td>
        <td></td>
        </tr>
        </cfif>
 <cfif lcase(HcomID) eq 'taftc_i'>
      <tr>
      <td></td><td></td><td></td>
        <th>WSQ Competency Codes :</th>
        <td colspan="4"><cftextarea name="WSQ" id="WSQ" cols="50" rows="7" bind="cfc:tran2cfc.getwsq('#dts#',{Source})"></cftextarea></td>
      </tr>
      </cfif>
    	<tr>
      		<td height="20" colspan="5"> <hr></td>
    	</tr>
        <tr>
        <th <cfif getdisplaysetup2.so neq "Y">style="visibility:hidden"</cfif>>SO</th>
        <td <cfif getdisplaysetup2.so neq "Y">style="visibility:hidden"</cfif>><input type="text" name="sono" value="#sono#" size="40" maxlength="35"></td>
        <td></td>
        <th <cfif getdisplaysetup2.permitno neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "fdipx_i">Invoice No.<cfelseif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">Factory<cfelseif lcase(hcomid) eq "sdc_i">Validity<cfelse>Permit No</cfif></th>
        <td <cfif getdisplaysetup2.permitno neq "Y">style="visibility:hidden"</cfif>>
        <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
        <select name="permitno">
        <option value="BLK 20" <cfif permitno eq 'BLK 20'>selected</cfif>>BLK 20</option>
        <option value="BLK 22" <cfif permitno eq 'BLK 22'>selected</cfif>>BLK 22</option>
        </select>
        <cfelse>
        <input type="text" name="permitno" value="#permitno#" size="40" maxlength="100">
        </cfif>
        </td>
        </tr>
      	<tr>
        	<th height="20" <cfif getdisplaysetup2.po neq "Y">style="visibility:hidden"</cfif>>PO</th>
        	<td colspan="2" <cfif getdisplaysetup2.po neq "Y">style="visibility:hidden"</cfif>><input type="text" name="pono" value="#pono#" size="40" maxlength="35"></td>
        	<th <cfif getdisplaysetup2.hremark5 neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem5#</th>
        	<td <cfif getdisplaysetup2.hremark5 neq "Y">style="visibility:hidden"</cfif>>
			<cfif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "aqua_i">
				<cfquery datasource="#dts#" name="getcust">
					Select custno,name from #target_arcust# order by name
				</cfquery>
				<select name="remark5">
					<option value="">Please choose</option>
					<cfloop query="getcust">
						<option value="#getcust.custno#"<cfif remark5 eq getcust.custno>Selected</cfif>>#getcust.custno# - #getcust.name#</option>
					</cfloop>
				</select>
			
			<cfelseif lcase(hcomid) eq "kingston_i" and tran eq "PO">
            
            <input type="text" name="remark5" value="Tay Si Lin" size="40" maxlength="35">
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
        SELECT refno,custno,name from artran where type = "INV" group by refno
        </cfquery>
        <select name="remark5" id="remark5">
        <option value="">Select an invoice number</option>
        <cfloop query="getkiminv">
        	<option value="#getkiminv.refno#" <cfif remark5 eq getkiminv.refno>Selected</cfif>>#getkiminv.refno#-#getkiminv.custno# #getkiminv.name#</option>
        </cfloop>
        </select><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findInvoice');" />
        
            
                 <cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark5" id="remark5"  bind="cfc:tran2cfc.getdate1('#dts#',{Job})" />
        
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
            <cfelseif lcase(HcomID) eq "vtop_i">
			
            <input type="text" name="remark5" value="#remark5#" size="40" maxlength="200">
            <cfelseif lcase(hcomid) eq "sdc_i">
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
            <input type="text" name="remark5" value="AV/IT Rental" size="40" maxlength="80">
            <cfelse>
            <select name="remark5">
            <option value="">Choose a title</option>
           <option value="AV/ IT RENTAL" <cfif remark5 eq "AV/ IT RENTAL">selected</cfif>>AV/ IT RENTAL</option>
                <option value="PURCHASE AND INSTALL" <cfif remark5 eq "PURCHASE AND INSTALL">selected</cfif>>PURCHASE AND INSTALL</option>
            
            </select>
            </cfif>
            <cfelseif lcase(hcomid) eq "shell_i">
            <cfquery name="getveh" datasource="#dts#">
            SELECT * from vehicles
            </cfquery>
            <select name="remark5" id="remark5" onChange="setTimeout('updateremark6()',1000);">
            <option value="">Select a vehicles</option>
            <cfloop query="getveh">
                <option value="#getveh.entryno#" <cfif remark5 eq getveh.entryno>Selected</cfif>>#getveh.entryno#</option>
            </cfloop>
            </select>
		<cfelse>
			
            <input type="text" name="remark5" value="#remark5#" size="40" maxlength="80">
			</cfif>			</td>
      	</tr>
      	<tr>
        	<th height="20" <cfif getdisplaysetup2.do neq "Y">style="visibility:hidden"</cfif>>DO<cfif lcase(hcomid) eq "widos_i">/QUO</cfif></th>
        	<td colspan="2" <cfif getdisplaysetup2.do neq "Y">style="visibility:hidden"</cfif>><input type="text" name="dono" value="#listfirst(dono)#" size="40" maxlength="35"></td>
        	<th <cfif getdisplaysetup2.hremark6 neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem6#</th>
            
                    <cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
<td>

  <select name="remark6" id="remark6" >
  <cfloop list="0%,10%,15%,20%,30%,40%,50%" index="i">
  <option value="#i#" <cfif remark6 eq #i#>selected</cfif>>#i#</option>
</cfloop></select><cfinput type="hidden" id="remark61" name="remark61" bind="cfc:accordtran2.getremark6('#dts#',{remark5})" >        </td>
        <cfelseif lcase(hcomid) eq "aimpest_i">
        <cfquery name="getarrem1" datasource="#dts#">
            SELECT arrem1 from #target_arcust# where custno = "#custno#"
            </cfquery>
        <td><input type="text" name="remark6" value="#getarrem1.arrem1#" size="40" maxlength="80"></td>
        <cfelseif lcase(hcomid) eq "taftc_i"><td>
         <cfinput type="text" name="remark6" id="remark6"  bind="cfc:tran2cfc.getdate2('#dts#',{Job})" />
</td>
		<cfelseif lcase(hcomid) eq "visionlaw_i">
        <td><textarea name="remark6" id="remark6" cols='40' rows='3' onKeyDown="limitText(this.form.remark6,200);" onKeyUp="limitText(this.form.remark6,200);">#remark6#</textarea>		</td>
        <cfelseif lcase(hcomid) eq "sdc_i">
        <td>
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
        </td>
       <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
        <td>
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
        </select></td>
         <cfelseif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
         
            <td>
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80" >
           </td>
            <cfelseif lcase(hcomid) eq "shell_i">
			<td><input type="text" name="remark6" value="#remark6#" size="40" maxlength="80"  onblur="validatetime('remark6')">
            <input type="button" name="generatedatetime" id="generatedatetime" onClick="document.getElementById('remark6').value='#dateformat(now(),'DD/MM/YYYY')#'+' #timeformat(now(),'HH:MM')#'" value="Start Time" />
            </td>
        <cfelse>
			<td <cfif getdisplaysetup2.hremark6 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark6" value="#remark6#" size="40" maxlength="80"></td></cfif>
      	</tr>
      	<tr>
			<cfif lcase(HcomID) eq "hco_i">
				<th>Remark 0</th>
        		<td colspan="2"><input type="text" name="remark0" value="#remark0#" size="40"></td>
			<cfelse>
				<th <cfif getdisplaysetup2.billtoadd_code neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem0#</th>
        		<td colspan="2" <cfif getdisplaysetup2.billtoadd_code neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark0" value="#form.BCode#" size="40" readonly></td>
			</cfif>
        	<!--- <th>#getgsetup.rem0#</th>
        	<td colspan="2"><input type="text" name="remark0" value="#form.BCode#" size="40" readonly></td> --->
        	<th <cfif getdisplaysetup2.hremark7 neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem7#</th>
        	<td <cfif getdisplaysetup2.hremark7 neq "Y">style="visibility:hidden"</cfif>>
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
                <option value="Kindly send to our office" selected>Kindly send to our office</option>
                <option value="Kindly send to our site">Kindly send to our site</option>
                <option value="Self-Collection">Self-Collection</option>
                </select>
                
                          <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                        
                <select name="remark7" id="remark7">
  <cfloop list="OPC,NORMAL" index="i">
  <option value="#i#" <cfif remark7 eq #i#>selected</cfif>>#i#</option>
</cfloop></select><cfinput type="hidden" id="remark71" name="remark71" bind="cfc:accordtran2.getremark7('#dts#',{remark5})">
 				<cfelseif lcase(hcomid) eq "mcjim_i">
                <input type="text" name="remark7" value="#remark7#" size="40" maxlength="50">
                <cfelseif lcase(hcomid) eq "powernas_i">
                <input type="text" name="remark7" value="#remark7#" size="40" maxlength="200">
                <cfelseif lcase(hcomid) eq "visionlaw_i">
        <textarea name="remark7" id="remark7" cols='40' rows='3' onKeyDown="limitText(this.form.remark7,300);" onKeyUp="limitText(this.form.remark7,300);">#remark7#</textarea>	
        		<cfelseif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                <cfif isdate(remark7)>
            <cfset remark7=dateformat(remark7,'DD/MM/YYYY')>
            </cfif>
            <input type="text" name="remark7" value="#remark7#" size="40" maxlength="80" readonly>
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark7);">(DD/MM/YYYY)	
            <cfelseif lcase(hcomid) eq "sdc_i">
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
       <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
        <select name="remark7">
        <option value="14 days" <cfif remark7 eq '14 days'>selected</cfif>>14 days</option>
        <option value="7  days" <cfif remark7 eq '7  days'>selected</cfif>>7  days</option>
        <option value="30 days" <cfif remark7 eq '30 days'>selected</cfif>>30 days</option>
        <option value="45 days" <cfif remark7 eq '45 days'>selected</cfif>>45 days</option>
        <option value="" <cfif remark7 eq ''>selected</cfif>></option>
        </select>
        <cfelseif lcase(hcomid) eq "shell_i">
                
					<input type="text" name="remark7" value="#remark7#" size="40" maxlength="80"  onblur="validatetime('remark7')">
                    <input type="button" name="generatedatetime2" id="generatedatetime2" onClick="document.getElementById('remark7').value='#dateformat(now(),'YYYY/MM/DD')#'+' #timeformat(now(),'HH:MM')#'" value="Complete Time" />
				<cfelse>
                
					<input type="text" name="remark7" value="#remark7#" size="40" maxlength="80">
				</cfif>			</td>
      	</tr>
      	<tr>

				<th <cfif getdisplaysetup2.deladd_code neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem1#</th>
				<td colspan="2" <cfif getdisplaysetup2.deladd_code neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark1" value="#form.DCode#" size="40" readonly></td>
        	<!--- <th>#getgsetup.rem1#</th>
        	<td colspan="2"><input type="text" name="remark1" value="#form.DCode#" size="40" readonly></td> --->
        	<th <cfif getdisplaysetup2.hremark8 neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem8#</th>
        	<td <cfif getdisplaysetup2.hremark8 neq "Y">style="visibility:hidden"</cfif>>
			<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<select name="remark8">
				<option value="">Please select</option>
				<cfloop query="getlocation">
				<option value="#location#" <cfif remark8 eq location>selected</cfif>>#desp#</option>
				</cfloop>
				</select>
            <cfelseif lcase(hcomid) eq "net_i">
            <input type="text" name="remark8" value="<cfif remark8 neq "" and remark8 neq "0000-00-00"> #dateformat(remark8,"dd/mm/yyyy")#</cfif>" size="10" maxlength="10">
			<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark8);">(DD/MM/YYYY)
			<cfelseif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i">
				<select name="remark8">
				<option value="">Please Select</option>
				<option value="directReferral" <cfif remark8 eq "directReferral">selected</cfif>>Direct Referral</option>
				<option value="onspot" <cfif remark8 eq "onspot">selected</cfif>>On Spot</option>
				<option value="telesales" <cfif remark8 eq "telesales">selected</cfif>>Tele-Sales</option>
				</select>
                <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                        
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
         <cfinput type="text" name="remark8" id="remark8"  bind="cfc:tran2cfc.getdate3('#dts#',{Job})" />
         
         <cfelseif lcase(hcomid) eq "sdc_i">
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
        <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
        <select name="remark8">
        <option value="Ex-Works" <cfif remark8 eq 'Ex-Works'>selected</cfif>>Ex-Works</option>
        <option value="FOB Singapore" <cfif remark8 eq 'FOB Singapore'>selected</cfif>>FOB Singapore</option>
        <option value="CIF " <cfif remark8 eq 'CIF'>selected</cfif>>CIF </option>
        <option value="CIP" <cfif remark8 eq 'CIP'>selected</cfif>>CIP</option>
        <option value="-" <cfif remark8 eq '-'>selected</cfif>>-</option>
        <option value="" <cfif remark8 eq ''>selected</cfif>></option>
        </select>
        <cfelseif lcase(hcomid) eq "shell_i">
            <cfif isdate(remark8)>
            <cfset remark8=dateformat(remark8,'DD/MM/YYYY')>
            </cfif>
            <input type="text" name="remark8" value="#remark8#" size="40" maxlength="80" readonly>
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark8);">(DD/MM/YYYY)
			<cfelse>
				<input type="text" name="remark8" value="#remark8#" size="40" maxlength="80">
			</cfif>			</td>
      	</tr>
      	<tr>

				<th <cfif getdisplaysetup2.billattn neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem2#</th>
        		<td colspan="2" <cfif getdisplaysetup2.billattn neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark2" value="#remark2#" size="40" maxlength="35" readonly></td>
        	<!--- <th>#getgsetup.rem2#</th>
        	<td colspan="2"><input type="text" name="remark2" value="#remark2#" size="40" maxlength="35" readonly></td> --->
        	<th <cfif getdisplaysetup2.hremark9 neq "Y">style="visibility:hidden"</cfif>><cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and tran eq "PO">Arrival Date<cfelse>#getgsetup.rem9#</cfif></th>
        	<td <cfif getdisplaysetup2.hremark9 neq "Y">style="visibility:hidden"</cfif>>
			<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "net_i" or ((lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and tran eq "PO")>
				<input type="text" name="remark9" value="#dateformat(remark9,"dd/mm/yyyy")#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark9);">(DD/MM/YYYY)
                
                                      <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                        
 <cfinput type="text" id="remark9" name="remark9" bind="cfc:accordtran2.getremark9('#dts#',{remark5})">
<cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark9" id="remark9"  bind="cfc:tran2cfc.getdate4('#dts#',{Job})" />
         
         <cfelseif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfss_i") and tran eq "SO">
         <cfinput type="text" name="remark9" value="#remark9#" size="40" maxlength="35" required="yes" message="Kindly Fill in Doctor Name">
         <cfelseif lcase(hcomid) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
         <input type="checkbox" name="rem9check" id="rem9check" value="Yes" <cfif remark9 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark9').value='YES';} else {document.getElementById('remark9').value='NO';}">
         <input type="hidden" name="remark9" id="remark9" value="#remark9#" size="40" maxlength="35">
         <cfelseif lcase(hcomid) eq "sdc_i">
         <select name="remark9">
         <option value="">Choose a warranty</option>
         <option value="Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01" <cfif remark9 eq 'Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01'>selected</cfif>>Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01</option>
         <option value="Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions" <cfif remark9 eq 'Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions'>selected</cfif>>Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions</option>
         <option value="BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions" <cfif remark9 eq 'BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions'>selected</cfif>>BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions</option>
         <option value="Refer to www.bearvarimixer.dk/legal" <cfif remark9 eq 'Refer to www.bearvarimixer.dk/legal'>selected</cfif>>Refer to www.bearvarimixer.dk/legal</option>
         <option value="Refer to www.sveba-dahlen.com/legal" <cfif remark9 eq 'Refer to www.sveba-dahlen.com/legal'>selected</cfif>>Refer to www.sveba-dahlen.com/legal</option>
         <option value="Refer to www.glimek.com/legal" <cfif remark9 eq 'Refer to www.glimek.com/legal'>selected</cfif>>Refer to www.glimek.com/legal</option>
         </select>
         <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
        <cfquery name="getvsolutionsremark" datasource="#dts#">
        SELECT arrem1 from #target_arcust# where custno = '#custno#'
        </cfquery>
         <cfinput type="text" id="remark9" name="remark9" value="#getvsolutionsremark.arrem1#" maxlength="80" size="40">
			<cfelse>
             <div>
				<input type="text" name="remark9" value="#remark9#" size="40" maxlength="80"></div>
			</cfif>			</td>
      	</tr>
      	<tr>
				<th <cfif getdisplaysetup2.delattn neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem3#</th>
        		<td colspan="2" <cfif getdisplaysetup2.delattn neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark3" size="40" maxlength="35" <cfif lcase(HcomID) eq "hl_i" and tran eq "PO"> value=""<cfelse>value="#remark3#" readonly</cfif>></td>
        	<th <cfif getdisplaysetup2.hremark10 neq "Y">style="visibility:hidden"</cfif>><cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">Start On<cfelse>#getgsetup.rem10#</cfif></th>
        	<td <cfif getdisplaysetup2.hremark10 neq "Y">style="visibility:hidden"</cfif>>
			<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<select name="remark10">
					<option value="">Please Select</option>
					<option value="-" <cfif remark10 eq "-">selected</cfif>>To</option>
					<option value="&" <cfif remark10 eq "&">selected</cfif>>And</option>
				</select>
			<cfelseif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">
				<input type="text" name="remark10" value="#remark10#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark10);">(DD/MM/YYYY)
			<cfelseif lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i" or lcase(hcomid) eq "decor_i">
				<textarea name="remark10" id="remark10" cols='40' rows='1' onKeyDown="limitText(this.form.remark10,200);" onKeyUp="limitText(this.form.remark10,200);">#remark10#</textarea>
                <cfelseif lcase(hcomid) eq "bestform_i" or lcase(hcomid) eq "alsale_i" or lcase(hcomid) eq "gbi_i" or lcase(hcomid) eq "shell_i">
				<textarea name="remark10" id="remark10" cols='40' rows='3' onKeyDown="limitText(this.form.remark10,500);" onKeyUp="limitText(this.form.remark10,500);">#remark10#</textarea>
            <cfelseif lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "visionlaw_i" or lcase(hcomid) eq "bspl_i" or lcase(hcomid) eq "polypet_i">
        <input type="text" name="remark10" value="#remark10#" maxlength="100" size="40"></td>
        <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                <cfoutput>
<cfinput type="text" name="remark10" id="remark10" value="#remark10#" bind="cfc:accordtran2.getremark10('#dts#',{remark5})"></cfoutput>
        <cfelseif lcase(hcomid) eq "mingsia_i" or lcase(hcomid) eq "knm_i" or lcase(hcomid) eq "letrain_i" or lcase(hcomid) eq "btgroup_i">
        <input type="text" name="remark10" value="#remark10#" maxlength="150" size="40">
        <cfelseif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfss_i") and tran eq "SO">
        <cfinput type="text" name="remark10" value="#remark10#" maxlength="35" size="40" required="yes" message="Kindly Fill in Patient Name">
	<cfelseif lcase(hcomid) eq "aepl_i">
				<textarea name="remark10" id="remark10" cols='100' rows='3' onKeyDown="limitText(this.form.remark10,200);" onKeyUp="limitText(this.form.remark10,500);">#remark10#</textarea>
			<cfelse>
				<input type="text" name="remark10" value="#remark10#" maxlength="35" size="40">
			</cfif>
			</td>
      	</tr>
      	<tr>
				<th <cfif getdisplaysetup2.billtel neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem4#</th>
        		<td colspan="2" <cfif getdisplaysetup2.billtel neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark4" value="#remark4#" size="40" maxlength="35" readonly></td>
			<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<th>#getgsetup.rem11#</th>
        		<td>
				<input type="text" name="remark11" value="#dateformat(remark11,"dd/mm/yyyy")#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark11);">(DD/MM/YYYY)</td>
			<cfelseif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">
				<th>Expire On</th>
				<td>
					<input type="text" name="remark11" value="#remark11#" size="10" maxlength="10">
					<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark11);">(DD/MM/YYYY)				</td>
			<cfelseif lcase(hcomid) eq "eocean_i" or lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i" or lcase(hcomid) eq "probulk_i" or lcase(hcomid) eq "ielm_i" or lcase(hcomid) eq "leatat_i" or lcase(hcomid) eq "dnet_i" or lcase(hcomid) eq "avoncleaning_i" or lcase(hcomid) eq "spcivil_i" or lcase(hcomid) eq "marico_i" or lcase(hcomid) eq "knights_i" or lcase(hcomid) eq "manhattan_i" or lcase(hcomid) eq "elmanhattan_i" or lcase(hcomid) eq "alsale_i" or lcase(hcomid) eq "letrain_i" or lcase(hcomid) eq "elitez_i" or lcase(hcomid) eq "reaktion_i" or lcase(hcomid) eq "amtaire_i" or lcase(hcomid) eq "taftc_i" or lcase(hcomid) eq "bofi_i" or lcase(hcomid) eq "avonservices_i" or lcase(hcomid) eq "widos_i" or lcase(hcomid) eq "avoncars_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "cleansing_i" or lcase(hcomid) eq "manhattan09_i" or lcase(hcomid) eq "marquis_i" or lcase(hcomid) eq "hempel_i" or lcase(hcomid) eq "bspl_i" or lcase(hcomid) eq "ccwpl_i" or lcase(hcomid) eq "anab_i" or lcase(hcomid) eq "zoenissi_i" or lcase(hcomid) eq "grace_i" or lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "risb_i" or lcase(hcomid) eq "gbi_i" or lcase(hcomid) eq "sjpst_i" or lcase(hcomid) eq "uniq_i" or lcase(hcomid) eq "sumiden_i" or lcase(hcomid) eq "almh_i" or lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "shell_i" or lcase(hcomid) eq "ciss_i">
				<th>#getgsetup.rem11#</th>
        		<td rowspan="2">
					<textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,200);" onKeyUp="limitText(this.form.remark11,200);">#remark11#</textarea>				</td>
                   <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                             <th>#getgsetup.rem11#</th>
             <td>   <cfoutput>
<cfinput type="text" name="remark11" id="remark11" value="#remark11#" bind="cfc:accordtran2.getremark11('#dts#',{remark5})"></cfoutput></td>
        
			<cfelseif lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "ideakonzepte_i" or lcase(hcomid) eq "bestform_i" or lcase(hcomid) eq "ovas_i"  or lcase(hcomid) eq "asiasoft_i">
				<th>#getgsetup.rem11#</th>
	        	<td rowspan="2">
					<textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,300);" onKeyUp="limitText(this.form.remark11,300);"></textarea>				</td>
             
             <cfelseif lcase(hcomid) eq "mingsia_i" or lcase(hcomid) eq "knm_i">
				<th>#getgsetup.rem11#</th>
	        	<td rowspan="2">
					<textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,800);" onKeyUp="limitText(this.form.remark11,300);"></textarea>				</td>
             <cfelseif lcase(hcomid) eq "aepl_i">
				<th>#getgsetup.rem11#</th>
	        	<td rowspan="2">
					<textarea name="remark11" id="remark11" cols='100' rows='3' onKeyDown="limitText(this.form.remark11,500);" onKeyUp="limitText(this.form.remark11,300);"></textarea>				</td>
                <cfelseif lcase(hcomid) eq "fdipx_i">
				<th>#getgsetup.rem11#</th>
        		<td>
				<textarea name="remark11" id="remark11" cols="40" rows="3" >#remark11#</textarea>				</td>
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
                </select>				</td>
            <cfelseif lcase(hcomid) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
            <th>#getgsetup.rem11#</th>
         <td><input type="checkbox" name="rem11check" id="rem11check" value="Yes" <cfif remark11 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark11').value='YES';} else {document.getElementById('remark11').value='NO';}">
         <input type="hidden" name="remark11" value="#remark11#" size="40" maxlength="35">	</td>
         	<cfelseif lcase(hcomid) eq "sdc_i">
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
            </td>
            <cfelseif lcase(hcomid) eq "polypet_i">
        	<th>#getGsetup.rem11#</th>
			<td><input type="text" name="remark11" value="#remark11#" size="40" maxlength="80"></td>
			<cfelseif lcase(hcomid) neq "avt_i">
				<th <cfif getdisplaysetup2.hremark11 neq "Y">style="visibility:hidden"</cfif>>#getgsetup.rem11#</th>
        		<td <cfif getdisplaysetup2.hremark11 neq "Y">style="visibility:hidden"</cfif>>
				<input type="text" name="remark11" value="#remark11#" size="40" maxlength="35">				</td>
			<cfelse>
				<td colspan="2"></td>
			</cfif>
      	</tr>
      	<tr>
				<th <cfif getdisplaysetup2.deltel neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">Heading<cfelse>#getgsetup.rem12#</cfif></th>
        		<td colspan="2" <cfif getdisplaysetup2.deltel neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark12" size="40" maxlength="35" <cfif lcase(HcomID) eq "hl_i" and tran eq "PO"> value=""<cfelse>value="#remark12#" readonly</cfif>></td>
              
        		<cfif lcase(hcomid) eq "avent_i">
					<th>FOB/CIF</th>
      				<td><input type="text" name="xremark3" value="#xremark3#" maxlength="10"></td>
                 <cfelseif lcase(hcomid) eq "amtaircon_i" and tran eq "PO">
                 	<th>Requisitor</th>
                    <td><input type="text" name="remark13" id="remark13" value="#remark13#" size="40" maxlength="35"></td>
                <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                	<th>Cheque no</th>
                    <td><input type="text" name="checkno" id="checkno" value="" maxlength="12"></td>
				<cfelse> 
					<td colspan="2">&nbsp;</td>
				</cfif>
           
        	<!--- <th>#getgsetup.rem12#</th>
        	<td colspan="2"><input type="text" name="remark12" value="#remark12#" size="40" maxlength="35" readonly></td>
        	<td colspan="2">&nbsp;</td> --->
      	</tr> 
		<cfif lcase(hcomid) eq "amtaircon_i" and tran eq "PO">
            <tr><th>Delivery Date</th>
            <td><input type="text" name="remark14" id="remark14" value="#remark14#" ><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark14);">(DD/MM/YYYY)</td></td>
            </tr>
            <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i")>
            <tr><td></td><td></td><td></td>
            <th>Certificate Of Merit</th>
          <td>
			  <select name="remark13" id="remark13">
<option value="" <cfif remark13 eq "">Selected</cfif>>Please select a COM</option>
<option value="true" <cfif remark13 eq "true">Selected</cfif>>True</option>
<option value="false" <cfif remark13 eq "false">Selected</cfif>>False</option>
</select><cfinput type="hidden" id="remark131" name="remark131" bind="cfc:accordtran2.getremark13('#dts#',{remark5})"></td>
            </tr>
        </cfif>
		<cfif lcase(hcomid) eq "hco_i">
			<tr>
				<td colspan="5">
					<table align="center">
						<tr>
							<th>Footer Remark 0</th>
							<td colspan="4"><input type="text" name="frem0" value="#convertquote(frem0)#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 1</th>
							<td colspan="4"><input type="text" name="frem1" value="#convertquote(frem1)#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 2</th>
							<td colspan="4"><input type="text" name="frem2" value="#frem2#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 3</th>
							<td colspan="4"><input type="text" name="frem3" value="#frem3#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 4</th>
							<td colspan="4"><input type="text" name="frem4" value="#frem4#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 5</th>
							<td colspan="4"><input type="text" name="frem5" value="#frem5#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 6</th>
							<td colspan="4"><input type="text" name="frem6" value="#frem6#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 7</th>
							<td colspan="4"><input type="text" name="frem7" value="#convertquote(frem7)#" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Footer Remark 8</th>
							<td colspan="4">
							<textarea name="frem8" id="frem8" cols='100' rows='12'>#convertquote(frem8)#</textarea>
							<!--- <input type="text" name="frem8" value="#frem8#" maxlength="80" size="80"> --->							</td>

							<input type="hidden" name="remark13" value="#remark13#">
							<input type="hidden" name="remark14" value="#remark14#">
							<input type="hidden" name="comm0" value="#convertquote(comm0)#">
							<input type="hidden" name="comm1" value="#convertquote(comm1)#">
							<input type="hidden" name="comm2" value="#convertquote(comm2)#">
							<input type="hidden" name="comm3" value="#convertquote(comm3)#">
							<input type="hidden" name="comm4" value="#convertquote(comm4)#">
                            <input type="hidden" name="d_phone2" value="#convertquote(d_phone2)#">
						</tr>
						<tr>
							<th>Footer Remark 9</th>
							<td colspan="4"><input type="text" name="frem9" value="#form.frem9#" maxlength="80" size="80"></td>
						</tr>
					</table>				</td>
			</tr>
			<tr>
				<td align="center" colspan="5">
					<cfif type eq "Delete" or type eq "Edit">
						<input type="hidden" name="readpeiod" value="#getitem.fperiod#">
					<cfelse>
						<input type="hidden" name="readpeiod" value="#listfirst(readperiod)#">
					</cfif>
						<input name="submit" type="submit" value="  #listfirst(mode)#  ">				</td>
			</tr>
        
		<cfelse>
			<cfif lcase(hcomid) eq "avt_i">
			<tr>
				<th>#getgsetup.rem11#</th>
				<td colspan="5">
					<textarea name="remark11" wrap="physical" cols="60" rows="5" onKeyDown="textCounter(this.form.remark11,this.form.remLen,300);" onKeyUp="textCounter(this.form.remark11,this.form.remLen,300);">#remark11#</textarea><br>
					<input readonly type="text" name="remLen" size="3" maxlength="3" value="300"> characters left ( You may enter up to 300 characters. )<br></font>				</td>
			</tr>
			</cfif>
			 <cfif lcase(HcomID) eq "avent_i">
   			 	<tr>
    				<th rowspan="2">Comment</th>
      				<td><select name="comment_selection" onChange="changeComment();">
        					<option value="">Select a comment</option>
               				<cfloop query="getcomment">
	                			<option value="#getcomment.code#">#getcomment.desp#</option>
							</cfloop>
            			</select>        			</td>
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
            			</select>        			</td>
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
						<textarea name="xremark17" wrap="physical" cols="40" rows="4">#xremark17#</textarea>					</td>
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
			      		<textarea name="comment_selected" wrap="physical" cols="40" rows="4">#xremark8#</textarea>					</td>
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
						</select>					</td>
					<td></td>
					<th>Remark B</th>
		      		<td>
						<select name="xremark2">
							<option value="Charter Hire Payable">Charter Hire Payable</option>
							<option value="Freight Hire Payable" <cfif xremark2 eq "Freight Hire Payable">selected</cfif>>Freight Hire Payable</option>
						</select>					</td>
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
            <cfif lcase(hcomid) eq "mcjim_i" and tran eq "DO">
        <tr>
				<td colspan="5">
					<table align="center">
						<tr>
							<th>Material</th>
							<td colspan="4"><input type="text" name="frem0" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Colour</th>
							<td colspan="4"><input type="text" name="frem1" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Specification</th>
							<td colspan="4"><input type="text" name="frem2" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>Requirement</th>
							<td colspan="4"><input type="text" name="frem3" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (1)</th>
							<td colspan="4"><input type="text" name="frem4" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (2)</th>
							<td colspan="4"><input type="text" name="frem5" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (3)</th>
							<td colspan="4"><input type="text" name="frem6" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (4)</th>
							<td colspan="4"><input type="text" name="frem7" value="" maxlength="80" size="80"></td>
						</tr>
						<tr>
							<th>D.O/Invoice No. (5)</th>
							<td colspan="4">
							<input type="text" name="frem8" value="" maxlength="80" size="80">							</td>

							<input type="hidden" name="comm0" value="#comm0#">
                            <input type="hidden" name="phonea" value="#phonea#">
                            <input type="hidden" name="e_mail" value="#e_mail#">
						</tr>
						<tr>
							<th>D.O/Invoice No. (6)</th>
							<td colspan="4"><input type="text" name="frem9" value="" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 10</th>
							<td colspan="4"><input type="text" name="comm1" value="" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 11</th>
							<td colspan="4"><input type="text" name="comm2" value="" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 12</th>
							<td colspan="4"><input type="text" name="comm3" value="" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 13</th>
							<td colspan="4"><input type="text" name="comm4" value="" maxlength="80" size="80"><input type="hidden" name="d_phone2" value="" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 14</th>
							<td colspan="4"><input type="text" name="remark13" value="" maxlength="80" size="80"></td>
						</tr>
                        <tr>
							<th>Footer Remark 15</th>
							<td colspan="4"><input type="text" name="remark14" value="" maxlength="80" size="80"></td>
						</tr>
					</table>				</td>
			</tr>
			</cfif>
            <cfif getgsetup.addonremark eq 'Y'>
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
                    <cfif lcase(hcomid) eq 'amtaircon_i' and tran eq "PO">
                    <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i")>
                    <input type="hidden" name="remark14" value="#remark14#">
                    <cfelse>
					<input type="hidden" name="remark13" value="#remark13#">
					<input type="hidden" name="remark14" value="#remark14#">
                    </cfif>
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
            			<input type="hidden" name="via" value="#via#">
					</cfif>


					<cfif type eq "Delete" or type eq "Edit">
						<input type="hidden" name="readpeiod" value="#getitem.fperiod#">
					<cfelse>
						<input type="hidden" name="readpeiod" value="#listfirst(readperiod)#">
					</cfif>
					<input name="submit1" type="submit" value="  #listfirst(mode)#  " <cfif lcase(HcomID) eq "unichem_i"> onclick="openwindow()"</cfif>>				</td>
			</tr>
		</cfif>
  	</table>
	</cfoutput>
</cfform>
<cfif lcase(HcomID) eq "kimlee_i" and tran eq "CN" or lcase(HcomID) eq "bakersoven_i" and tran eq "CN">
<cfwindow center="true" width="600" height="400" name="findInvoice" refreshOnShow="true"
        title="Find Invoice" initshow="false"
        source="/default/transaction/findInvoice.cfm" />
</cfif>
<cfwindow center="true" width="600" height="400" name="createJobAjax" refreshOnShow="true"
        title="Create Job" initshow="false"
        source="/default/transaction/createJobAjax.cfm" />
<cfwindow center="true" width="600" height="400" name="createProjectAjax" refreshOnShow="true"
        title="Create Project" initshow="false"
        source="/default/transaction/createProjectAjax.cfm" />
<!---------------------------------------------------------------------- DATA VALIDATION ---------------------------------------------------->
<script language="JavaScript">

	function openwindow()
	{
	if(document.invoicesheet.remark5.value !=''){

	window.open('/default/transaction/recurringtran/');

	}
	}
	function textCounter(field, countfield, maxlimit) 
	{if (field.value.length > maxlimit) // if too long...trim it!
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
	
	function displayname()
	{
		if(document.invoicesheet.custno.value=='')
		{
			document.invoicesheet.name.value='';
			document.invoicesheet.name2.value='';
		}
		else
		{
			<cfoutput query ="getcustomer">
			if(document.invoicesheet.custno.value=='#getcustomer.custno#')
			{
				document.invoicesheet.refno3.value='#getcustomer.currcode#';
			}
			</cfoutput>
		}
	}

	function displayrate()
	{
  		if(document.invoicesheet.refno3.value=='')
		{
			<cfoutput query ="getcustomer">
	  		if(document.invoicesheet.custno.value=='#getcustomer.custno#')
			{
				document.invoicesheet.refno3.value='#getcustomer.currcode#';
	  		}
			</cfoutput>
  		}
		if(document.invoicesheet.refno3.value!='')
		{
			<cfoutput query ="currency">
			if(document.invoicesheet.refno3.value=='#currency.currcode#')
			{	<cfquery datasource="#dts#" name="getGeneralInfo">
					Select * from GSetup
				</cfquery>

				<cfset lastaccyear = dateformat(getGeneralInfo.lastaccyear, "dd/mm/yyyy")>
				<cfset period = '#getGeneralInfo.period#'>
				<cfset currentdate ="#dateformat(invoicedate,"dd/mm/yyyy")#">
				<cfset tmpYear = year(currentdate)>
				<cfset clsyear = year(lastaccyear)>
				<cfset tmpmonth = month(currentdate)>
				<cfset clsmonth = month(lastaccyear)>
				<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

				<cfif intperiod gt 18 or intperiod lte 0>
					<cfset readperiod = 99>
				<cfelse>
					<cfset readperiod = numberformat(intperiod,"00")>
				</cfif>

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
				</cfif>
				document.invoicesheet.currrate.value='#numberformat(rates2,"._____")#';
			}
			</cfoutput>
		}
	}
<cfoutput>
	function NextTransNo()
 	{
   		document.invoicesheet.nexttranno.value == '#nexttranno#';
   		return true;
 	}
	</cfoutput>

	function ChgDueDate()
	{
  		if(document.invoicesheet.terms.value != '')
  		{
			<cfoutput query ="getTerm">
 			if(document.invoicesheet.terms.value == '#term#')
			{
        		<cfif sign eq "P">
        			<cfquery datasource="#dts#" name="getDays">
						Select days from #target_icterm# where term = 'document.invoicesheet.terms.value'
  					</cfquery>

					<cfset Days = getDays.days>
					<cfset xDate = "#dateformat(invoicedate, "dd/mm/yyyy")#">
					<cfset yDate = DateAdd("y", #Days#, #xDate#)>
  					document.invoicesheet.remark6.value = '#dateformat(yDate, 'dd/mm/yyyy')#';
  				</cfif>
  			}
 			</cfoutput>
   		}
   		else
   		{
       		document.invoicesheet.remark6.value = '';
   		}
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
<cfif isdefined('form.checkfast')>

<script type="text/javascript">
<cfif lcase(HcomID) eq "hyray_i">
<cfoutput>
ajaxFunction(document.getElementById('keeptrackbug'),'/default/transaction/keeptrackbug.cfm?agenno='+document.getElementById("agenno").value+'&type=create&fieldtype=agent&custno=#listfirst(form.custno)#&tran=#tran#&refno=#nexttranno#');
</cfoutput>
</cfif>
document.invoicesheet.submit();
</script>
</cfif>

</body>
</html>