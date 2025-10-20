
<cfset dts=replace(dts,'_i','_p','all')>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">
<cfquery name="gqry" datasource="payroll_main">
		SELECT mmonth,myear from gsetup where comp_id = '#HcomID#'
</cfquery>
<cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = "#val(url.selfsdf)#"
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#">
</cfquery>

<cfquery name="updatepmast" datasource="#dts#">
Update pmast 
SET brate = "#val(url.selfusualpay)#",
payrtype = <cfif url.paytype eq "">"M"<cfelse>"#left(url.paytype,1)#"</cfif>
WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#"> 
</cfquery>

<cfquery name="checkpayrecord" datasource="#dts#">
SELECT * FROM payrecord WHERE 
realempno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#"> 
and placement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placement#"> 
and invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.invoiceno#">
and paytimes = "1"
and month = "#val(gqry.mmonth)#"
and year = "#val(gqry.myear)#"
</cfquery>
<cfif checkpayrecord.recordcount neq 0>
<cfquery name="updatepaytran" datasource="#dts#">
Update paytra1 SET
    BRATE = "#checkpayrecord.BRATE#",
    BRATE2 = "#val(checkpayrecord.BRATE2)#",
    BACKPAY = "#val(checkpayrecord.BACKPAY)#",
    OOB = "#checkpayrecord.OOB#",
    WDAY = "#checkpayrecord.WDAY#",
    WDAY2 = "#val(checkpayrecord.WDAY2)#",
    DW = "#checkpayrecord.DW#",
    DW2 = "#val(checkpayrecord.DW2)#",
    PH = "#checkpayrecord.PH#",
    AL = "#checkpayrecord.AL#",
    ALHR = "#val(checkpayrecord.ALHR)#",
    MC = "#checkpayrecord.MC#",
    MT = "#checkpayrecord.MT#",
    CC = "#checkpayrecord.CC#",
    MR = "#checkpayrecord.MR#",
    PT = "#checkpayrecord.PT#",
    CL = "#checkpayrecord.CL#",
    HL = "#checkpayrecord.HL#",
    AD = "#checkpayrecord.AD#",
    EX = "#checkpayrecord.EX#",
    LS = "#checkpayrecord.LS#",
    OPLD = "#checkpayrecord.OPLD#",
    OPL = "#checkpayrecord.OPL#",
    NPL = "#checkpayrecord.NPL#",
    NS = "#checkpayrecord.NS#",
    NPL2 = "#val(checkpayrecord.NPL2)#",
    AB = "#checkpayrecord.AB#",
    ONPLD = "#checkpayrecord.ONPLD#",
    ONPL = "#checkpayrecord.ONPL#",
    ALTAWDAY = "#val(checkpayrecord.ALTAWDAY)#",
    ALTAWRATE = "#val(checkpayrecord.ALTAWRATE)#",
    ALTAWAMT = "#val(checkpayrecord.ALTAWAMT)#",
    DWAWADJ = "#checkpayrecord.DWAWADJ#",
    ALBFTMP = "#val(checkpayrecord.ALBFTMP)#",
    MCBFTMP = "#val(checkpayrecord.MCBFTMP)#",
    WORKHR = "#checkpayrecord.WORKHR#",
    LATEHR = "#checkpayrecord.LATEHR#",
    EARLYHR = "#checkpayrecord.EARLYHR#",
    NOPAYHR = "#checkpayrecord.NOPAYHR#",
    RATE1 = "#val(checkpayrecord.RATE1)#",
    RATE2 = "#val(checkpayrecord.RATE2)#",
    RATE3 = "#val(checkpayrecord.RATE3)#",
    RATE4 = "#val(checkpayrecord.RATE4)#",
    RATE5 = "#val(checkpayrecord.RATE5)#",
    RATE6 = "#val(checkpayrecord.RATE6)#",
    HR1 = "#checkpayrecord.HR1#",
    HR2 = "#checkpayrecord.HR2#",
    HR3 = "#checkpayrecord.HR3#",
    HR4 = "#checkpayrecord.HR4#",
    HR5 = "#checkpayrecord.HR5#",
    HR6 = "#checkpayrecord.HR6#",
    DIRFEE = "#checkpayrecord.DIRFEE#",
    AW101 = "#checkpayrecord.AW101#",
    AW102 = "#checkpayrecord.AW102#",
    AW103 = "#checkpayrecord.AW103#",
    AW104 = "#checkpayrecord.AW104#",
    AW105 = "#checkpayrecord.AW105#",
    AW106 = "#checkpayrecord.AW106#",
    AW107 = "#checkpayrecord.AW107#",
    AW108 = "#checkpayrecord.AW108#",
    AW109 = "#checkpayrecord.AW109#",
    AW110 = "#checkpayrecord.AW110#",
    AW111 = "#checkpayrecord.AW111#",
    AW112 = "#checkpayrecord.AW112#",
    AW113 = "#checkpayrecord.AW113#",
    AW114 = "#checkpayrecord.AW114#",
    AW115 = "#checkpayrecord.AW115#",
    AW116 = "#checkpayrecord.AW116#",
    AW117 = "#checkpayrecord.AW117#",
    DED101 = "#checkpayrecord.DED101#",
    DED102 = "#checkpayrecord.DED102#",
    DED103 = "#checkpayrecord.DED103#",
    DED104 = "#checkpayrecord.DED104#",
    DED105 = "#checkpayrecord.DED105#",
    DED106 = "#checkpayrecord.DED106#",
    DED107 = "#checkpayrecord.DED107#",
    DED108 = "#checkpayrecord.DED108#",
    DED109 = "#checkpayrecord.DED109#",
    DED110 = "#checkpayrecord.DED110#",
    DED111 = "#checkpayrecord.DED111#",
    DED112 = "#checkpayrecord.DED112#",
    DED113 = "#checkpayrecord.DED113#",
    DED114 = "#checkpayrecord.DED114#",
    DED115 = "#checkpayrecord.DED115#",
    MESS = "#checkpayrecord.MESS#",
    MESS1 = "#checkpayrecord.MESS1#",
    FIXOESP = "#checkpayrecord.FIXOESP#",
    SHIFTA = "#checkpayrecord.SHIFTA#",
    SHIFTB = "#checkpayrecord.SHIFTB#",
    SHIFTC = "#checkpayrecord.SHIFTC#",
    SHIFTD = "#checkpayrecord.SHIFTD#",
    SHIFTE = "#checkpayrecord.SHIFTE#",
    SHIFTF = "#checkpayrecord.SHIFTF#",
    SHIFTG = "#checkpayrecord.SHIFTG#",
    SHIFTH = "#checkpayrecord.SHIFTH#",
    SHIFTI = "#checkpayrecord.SHIFTI#",
    SHIFTJ = "#checkpayrecord.SHIFTJ#",
    SHIFTK = "#checkpayrecord.SHIFTK#",
    SHIFTL = "#checkpayrecord.SHIFTL#",
    SHIFTM = "#checkpayrecord.SHIFTM#",
    SHIFTN = "#checkpayrecord.SHIFTN#",
    SHIFTO = "#checkpayrecord.SHIFTO#",
    SHIFTP = "#checkpayrecord.SHIFTP#",
    SHIFTQ = "#checkpayrecord.SHIFTQ#",
    SHIFTR = "#checkpayrecord.SHIFTR#",
    SHIFTS = "#checkpayrecord.SHIFTS#",
    SHIFTT = "#checkpayrecord.SHIFTT#",
    TIPPOINT = "#checkpayrecord.TIPPOINT#",
    CLTIPOINT = "#val(checkpayrecord.CLTIPOINT)#",
    TIPRATE = "#checkpayrecord.TIPRATE#",
    MFUND = "#checkpayrecord.MFUND#",
    DFUND = "#checkpayrecord.DFUND#",
    ZAKAT_BF = "#val(checkpayrecord.ZAKAT_BF)#",
    ZAKAT_BFN = "#val(checkpayrecord.ZAKAT_BFN)#",
    PIECEPAY = "#val(checkpayrecord.PIECEPAY)#",
    BASICPAY = "#val(checkpayrecord.BASICPAY)#",
    FULLPAY = "#val(checkpayrecord.FULLPAY)#",
    NPLPAY = "#val(checkpayrecord.NPLPAY)#",
    OT1 = "#val(checkpayrecord.OT1)#",
    OT2 = "#val(checkpayrecord.OT2)#",
    OT3 = "#val(checkpayrecord.OT3)#",
    OT4 = "#val(checkpayrecord.OT4)#",
    OT5 = "#val(checkpayrecord.OT5)#",
    OT6 = "#val(checkpayrecord.OT6)#",
    OTPAY = "#val(checkpayrecord.OTPAY)#",
    EPFWW = "#val(checkpayrecord.EPFWW)#",
    EPFCC = "#val(checkpayrecord.EPFCC)#",
    EPFWWEXT = "#val(checkpayrecord.EPFWWEXT)#",
    EPFCCEXT = "#val(checkpayrecord.EPFCCEXT)#",
    EPGWW = "#val(checkpayrecord.EPGWW)#",
    EPGCC = "#val(checkpayrecord.EPGCC)#",
    SOASOWW = "#val(checkpayrecord.SOASOWW)#",
    SOASOCC = "#val(checkpayrecord.SOASOCC)#",
    SOBSOWW = "#val(checkpayrecord.SOBSOWW)#",
    SOBSOCC = "#val(checkpayrecord.SOBSOCC)#",
    SOCSOWW = "#val(checkpayrecord.SOCSOWW)#",
    SOCSOCC = "#val(checkpayrecord.SOCSOCC)#",
    SODSOWW = "#val(checkpayrecord.SODSOWW)#",
    SODSOCC = "#val(checkpayrecord.SODSOCC)#",
    SOESOWW = "#val(checkpayrecord.SOESOWW)#",
    SOESOCC = "#val(checkpayrecord.SOESOCC)#",
    UNIONWW = "#val(checkpayrecord.UNIONWW)#",
    UNIONCC = "#val(checkpayrecord.UNIONCC)#",
    ADVANCE = "#val(checkpayrecord.ADVANCE)#",
    ADVPAY = "#val(checkpayrecord.ADVPAY)#",
    TIPAMT = "#val(checkpayrecord.TIPAMT)#",
    ITAXPCB = "#val(checkpayrecord.ITAXPCB)#",
    ITAXPCBADJ = "#val(checkpayrecord.ITAXPCBADJ)#",
    TAW = "#val(checkpayrecord.TAW)#",
    TXOTPAY = "#val(checkpayrecord.TXOTPAY)#",
    TXAW = "#val(checkpayrecord.TXAW)#",
    TXDED = "#val(checkpayrecord.TXDED)#",
    TDED = "#val(checkpayrecord.TDED)#",
    TDEDU = "#val(checkpayrecord.TDEDU)#",
    GROSSPAY = "#val(checkpayrecord.GROSSPAY)#",
    NETPAY = "#val(checkpayrecord.NETPAY)#",
    EPF_PAY = "#val(checkpayrecord.EPF_PAY)#",
    EPF_PAY_A = "#val(checkpayrecord.EPF_PAY_A)#",
    CCSTAT1 = "#val(checkpayrecord.CCSTAT1)#",
    CCSTAT2 = "#val(checkpayrecord.CCSTAT2)#",
    CCSTAT3 = "#val(checkpayrecord.CCSTAT3)#",
    PENCEN = "#val(checkpayrecord.PENCEN)#",
    PROJECT = "#val(checkpayrecord.PROJECT)#",
    CHEQUE_NO = "#checkpayrecord.CHEQUE_NO#",
    BANKCHARGE = "#val(checkpayrecord.BANKCHARGE)#",
    ADVDAY = "#val(checkpayrecord.ADVDAY)#",
    PM_CODE = "#checkpayrecord.PM_CODE#",
    TMONTH = "#val(checkpayrecord.TMONTH)#",
    UDRATE1 = "#checkpayrecord.UDRATE1#",
    UDRATE2 = "#checkpayrecord.UDRATE2#",
    UDRATE3 = "#checkpayrecord.UDRATE3#",
    UDRATE4 = "#checkpayrecord.UDRATE4#",
    UDRATE5 = "#checkpayrecord.UDRATE5#",
    UDRATE6 = "#checkpayrecord.UDRATE6#",
    UDRATE7 = "#checkpayrecord.UDRATE7#",
    UDRATE8 = "#checkpayrecord.UDRATE8#",
    UDRATE9 = "#checkpayrecord.UDRATE9#",
    UDRATE10 = "#checkpayrecord.UDRATE10#",
    UDRATE11 = "#checkpayrecord.UDRATE11#",
    UDRATE12 = "#checkpayrecord.UDRATE12#",
    UDRATE13 = "#checkpayrecord.UDRATE13#",
    UDRATE14 = "#checkpayrecord.UDRATE14#",
    UDRATE15 = "#checkpayrecord.UDRATE15#",
    UDRATE16 = "#checkpayrecord.UDRATE16#",
    UDRATE17 = "#checkpayrecord.UDRATE17#",
    UDRATE18 = "#checkpayrecord.UDRATE18#",
    UDRATE19 = "#checkpayrecord.UDRATE19#",
    UDRATE20 = "#checkpayrecord.UDRATE20#",
    UDRATE21 = "#checkpayrecord.UDRATE21#",
    UDRATE22 = "#checkpayrecord.UDRATE22#",
    UDRATE23 = "#checkpayrecord.UDRATE23#",
    UDRATE24 = "#checkpayrecord.UDRATE24#",
    UDRATE25 = "#checkpayrecord.UDRATE25#",
    UDRATE26 = "#checkpayrecord.UDRATE26#",
    UDRATE27 = "#checkpayrecord.UDRATE27#",
    UDRATE28 = "#checkpayrecord.UDRATE28#",
    UDRATE29 = "#checkpayrecord.UDRATE29#",
    UDRATE30 = "#checkpayrecord.UDRATE30#",
    PAYYES = "#checkpayrecord.PAYYES#",
    cpf_amt = "#checkpayrecord.cpf_amt#",
    hourrate = "#checkpayrecord.hourrate#",
    total_late_h = "#checkpayrecord.total_late_h#",
    total_earlyD_h = "#checkpayrecord.total_earlyD_h#",
    total_noP_h = "#checkpayrecord.total_noP_h#",
    total_work_h = "#checkpayrecord.total_work_h#",
    additionalwages = "#checkpayrecord.additionalwages#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#">
</cfquery>
</cfif>
<cfquery name="updatepaytran" datasource="#dts#">
UPDATE paytra1 
SET brate = "#val(url.selfusualpay)#",
DW = "#val(url.selfsalaryday)#",
WDAY = "#val(url.selfsalaryday)#",
WORKHR = "#val(url.selfsalaryhrs)#",
AL = "#val(url.AL)#",
MC = "#val(url.MC)#",
RATE1 = "#val(url.selfotrate1)#",
HR1 = "#val(url.selfothour1)#",
RATE2 = "#val(url.selfotrate2)#",
HR2 = "#val(url.selfothour2)#",
RATE3 = "#val(url.selfotrate3)#",
HR3 = "#val(url.selfothour3)#",
RATE4 = "#val(url.selfotrate4)#",
HR4 = "#val(url.selfothour4)#",
RATE5 = "#val(url.selfexceptionrate)#",
HR5 = "#val(url.selfexceptionhrs)#"
WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#"> 
</cfquery>
<cfquery name="userpin_qry" datasource="#dts#">
		SELECT pin from userpin where usergroup = "#getHQstatus.userGrpID#"
	</cfquery>
	<cfset Hpin = userpin_qry.pin >
	<cfif getHQstatus.userGrpID eq "super">
		<cfset Hpin = 0>
	</cfif>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">

<cfif url.empno eq ''>
<h3>Employee No Cannot Be Empty</h3>
<cfabort>
</cfif>

<html>
<head>
	<title>1st Half - Normal Pay</title>
	<script src="/javascripts/remaintabber.js" type="text/javascript"></script>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<script src="/javscripts/resizeSel.js" type="text/javascript"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/includes/xpath.js"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/includes/SpryData.js"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/widgets/tooltip/SpryTooltip.js"></script>
	
    
	<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
	<link href="/lib/spry/widgets/tooltip/SpryTooltip.css" rel="stylesheet" type="text/css" />
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
     <script type="text/javascript">
    function fullmonth(){
	if(document.getElementById("fullm").checked==true)
	{
	document.getElementById("DW").value = document.getElementById("WDAY").value; 
	}
	else
	{
	document.getElementById("DW").value = document.getElementById("DW").value; 
	}}	
	 	
	function saveonly()
	{
	document.eForm.action = "/payments/1stHalf/AddUpdate/normalPay_process.cfm?type=normal&placement=<cfoutput>#url.placement#&invoiceno=#url.invoiceno#</cfoutput>";
	}
	
	function savenext()
	{
	document.eForm.action = "/payments/1stHalf/AddUpdate/normalPay_process.cfm?type=normal&page=next&placement=<cfoutput>#url.placement#&invoiceno=#url.invoiceno#</cfoutput>";
	}
	function update(entryno)
	{
	document.getElementById('entryno_2').value = entryno;

	ColdFusion.Window.show('update_proj')
	}
	function confirmDelete(entryno,type,empno) {
		var answer = confirm("Confirm Delete?")
		if (answer){
			window.location = "add_proj.cfm?type="+type+ "&entryno="+entryno+"&empno="+empno;
		}
		else{
			
		}
	}
	
	</script>

<script language="javascript">
	<!--- function show_row(obj){
		if (obj.value!='M'){
		  // Toggle visibility between none and inline
			document.getElementById("dailyAdj").style.display = 'inline';
		}else{
			document.getElementById("dailyAdj").style.display = 'none';
			document.getElementById("fwlevyadj").value='0.00';
		}
	} --->
	//Tooltip Dialog
	<!--- analyseForm = function(formEl)
	{
		var inputs = formEl.getElementsByTagName('input');
		for (var i=0; i < inputs.length; i++)
		{
			if (inputs[i].getAttribute('type').toLowerCase() == 'radio'){
				if(inputs[i].checked) document.eForm.whtbl.value =inputs[i].value;
			}
		}
		return false;
	}
	function selectRow(prefix,id){
		document.getElementById(prefix+id).checked=true;
	} --->
	
	function balance()
	{
		window.document.eForm.balAL.value = window.document.eForm.total_AL_entitled.value - window.document.eForm.past_month_leave.value - window.document.eForm.AL.value;
		if(window.document.eForm.total_mc_entitled.value -  window.document.eForm.past_month_mc.value - window.document.eForm.MC.value < 0)
		{
		<!--- alert('MC cannot less than MC balance');
		window.document.eForm.MC.value = document.getElementById('mcoldone').value; --->
		}
		else
		{
		<!--- window.document.eForm.balMC.value = window.document.eForm.total_mc_entitled.value -  window.document.eForm.past_month_mc.value - window.document.eForm.MC.value; --->
		}
		<!--- window.document.eForm.balCC.value = window.document.eForm.total_cc_entitled.value -  window.document.eForm.past_month_cc.value - window.document.eForm.CC.value ; --->
	}
	
	<!--- function rdate(){
	var thisDate = new Date(document.eForm.dcomm.value);
	//thisDate.setYear(document.eForm.dcomm.value);
	//thisDate.setMonth(parseInt(document.eForm.dcomm.value));
	//var ddate = thisDate.setFullYear(dyear,dmonth-1,1);
	//thisDate.setDate(document.eForm.dcomm.value);
	//thisDate.setDate(0);
	//document.getElementById("lyear").innerHTML = thisDate.getDate()+'/'+parseInt(document.paraForm.mmonth.value)+'/'+thisDate.getFullYear();
	alert(thisDate.getDate()+'/'+thisDate.getMonth()+'/'+thisDate.getFullYear());
	//dstring = thisDate.toLocaleString()
	//alert(thisDate);
	} --->
	
	function addLoadEvent()
	{
		/* This function adds tabberAutomatic to the window.onload event,
		so it will run after the document has finished loading.*/
		var oldOnLoad;
		/* Taken from: http://simon.incutio.com/archive/2004/05/26/addLoadEvent */
		oldOnLoad = window.onload;
		if (typeof window.onload != 'function') {
			window.onload = function(){
				var whtTooltip = new Spry.Widget.Tooltip('wht', '#whtTrigger', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				//window.document.eForm.balAL.value = window.document.eForm.ALBF.value -  window.document.eForm.AL.value;
				//window.document.eForm.balMC.value = window.document.eForm.MCALL.value -  window.document.eForm.MC.value;
			};
		}else{
			window.onload = function() {
				oldOnLoad();
				var whtTooltip = new Spry.Widget.Tooltip('wht', '#whtTrigger', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				window.document.eForm.balAL.value = window.document.eForm.bal_AL2.value;
				window.document.eForm.balMC.value = window.document.eForm.bal_MC2.value;
				window.document.eForm.balCC.value = window.document.eForm.bal_CC2.value;
			};
		}
	}
	addLoadEvent();

</script>
</head>

<body>
<script type="text/javascript" src="/javascripts/wz_tooltip.js"></script> 
<cfquery name="pay_qry" datasource="#dts#">
SELECT * FROM paytra1
WHERE EMPNO = "#URLDecode(url.empno)#"
</cfquery>

<cfquery name="ot_qry" datasource="#dts#">
SELECT ot_desp, ot_unit FROM ottable
WHERE ot_cou between 1 and 6
</cfquery>

<cfquery name="at1_qry" datasource="#dts#">
SELECT aw_desp FROM awtable
WHERE aw_cou < 11
</cfquery>

<cfquery name="at2_qry" datasource="#dts#">
SELECT aw_desp FROM awtable
WHERE aw_cou between 11 and 17
</cfquery>

<cfquery name="pmast_qry" datasource="#dts#">
SELECT *, month(dcomm) as mcomm <!--- EMPNO, NAME, PLINENO, ALBF, MCALL, PAYRTYPE ---> 
FROM pmast
WHERE EMPNO = "#URLDecode(url.empno)#"
</cfquery>

<cfquery name="ded1_qry" datasource="#dts#">
SELECT ded_desp FROM dedtable
WHERE ded_cou < 11
</cfquery>

<cfquery name="ded2_qry" datasource="#dts#">
SELECT ded_desp FROM dedtable
WHERE ded_cou between 11 and 15
</cfquery>

<cfquery name="udrate1_qry" datasource="#dts#">
SELECT udrat_desp FROM awtable
WHERE aw_cou between 1 and 15
</cfquery>

<cfquery name="udrate2_qry" datasource="#dts#">
SELECT udrat_desp FROM awtable
WHERE aw_cou between 16 and 30
</cfquery>

<cfquery name="pro_qry" datasource="#dts#">
SELECT * FROM project
</cfquery>

<cfquery name="gs_qry" datasource="#dts_main#">
SELECT *
FROM gsetup
WHERE comp_id = "#HcomID#"
</cfquery>
<cfif gs_qry.MMONTH gte 13>
<script type="text/javascript">
alert('You have come to the end of the year. Please kindly run year end processing to go to next year.');
</script>
<cfabort />
</cfif>

<cfquery name="emp_poj_qry" datasource="#dts#">
SELECT * FROM proj_rcd_1 WHERE EMPNO = "#URLDecode(url.empno)#"
</cfquery>
<!--- Prompt Table Start --->
	<!--- Tool Tip Dialog --->
	<form id="wht" onClick="return analyseForm(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput>
	<tr>
		<td colspan="2">To Determine Out of Bond (OOB)</td>
	</tr>
	<tr>
		<td>Day in Month</td>
		<td>Day in Half Month</td>
	</tr>
	<tr>
		<td>28</td>
		<td>14</td>
	</tr>
	<tr>
		<td>29</td>
		<td>14.5</td>
	</tr>
	<tr>
		<td>30</td>
		<td>15</td>
	</tr>
	<tr>
		<td>31</td>
		<td>15.5</td>
	</tr>
	</cfoutput>
	</table>
	</form>

	<cfoutput>
	<div class="mainTitle">1st Half Payroll - Normal Pay 
		[<cfif gs_qry.mmonth eq 1>January<cfelseif gs_qry.mmonth eq 2>February<cfelseif gs_qry.mmonth eq 3>March
		<cfelseif gs_qry.mmonth eq 4>April<cfelseif gs_qry.mmonth eq 5>May<cfelseif gs_qry.mmonth eq 6>June
		<cfelseif gs_qry.mmonth eq 7>July<cfelseif gs_qry.mmonth eq 8>August<cfelseif gs_qry.mmonth eq 9>September
		<cfelseif gs_qry.mmonth eq 10>October<cfelseif gs_qry.mmonth eq 11>November<cfelseif gs_qry.mmonth eq 12>December</cfif>
		#gs_qry.myear#]
	</div>
	
	<cfform name="eForm" id="eForm" action="/payments/1stHalf/AddUpdate/normalPay_process.cfm?type=normal&placement=#url.placement#&invoiceno=#url.invoiceno#" method="post">
	<table class="form">
	<tr>
		<td>Employee No.</td>
		<td><input type="text" name="empno" value="#pmast_qry.EMPNO#" size="8" readonly></td>
		<td><input type="text" name="name" value="#pmast_qry.NAME#" size="40" readonly></td>
        <td><input type="button" name="goprocess" value="Process Pay" onClick="window.location.href='/payments/1stHalf/processpaymain.cfm?empno=#pmast_qry.EMPNO#'" /></td>
	</tr>
	<tr>
		<td>Line No.</td>
		<td><input type="text" name="plineno" value="#pmast_qry.PLINENO#" size="8" readonly></td>
        <td>Ic No: #pmast_qry.nricn#</td>
		<td width="">
			<div id="ajaxField" name="ajaxField">
				<cfif #pay_qry.payyes# eq "Y">
					<label style="background-color:darkblue; color:white; font-size:12px; font-weight:bold">Update</label>
				<cfelse>
					<label style="background-color:red; color:white; font-size:12px; font-weight:bold">Add New Pay</label>
				</cfif>
			</div>
		</td>
	</tr>
	</table>
	<div class="tabber">
		<div class="tabbertab" style="height:390px;">
			<h3>Basic Pay And Overtime</h3>
			<table class="form" border="0">
			<tr>
				<td>
				<table>
				<tr>
					<td colspan="2" width="100">Basic Rate </td>
					<td colspan="2" width="150">
						<cfif val(pay_qry.BRATE) eq 0>
							<cfset pbrate= val(pmast_qry.BRATE)>
							
							<cfif pmast_qry.nppm eq "0" and pmast_qry.PAYRTYPE eq "M" >
								<cfset pbrate = val(pmast_qry.BRATE)/val(gs_qry.bp_payment)>
							<cfelseif pmast_qry.nppm neq "0" and pmast_qry.PAYRTYPE eq "M">
								<cfset pbrate = val(pmast_qry.BRATE)/val(pmast_qry.nppm)>
							</cfif>	
						<cfelse>
							<cfset pbrate= val(pay_qry.BRATE)>
						</cfif>
						<input type="text" name="BRATE" value="#numberformat(pbrate,'.__')#" size="22"></td>
					<td width="180" colspan="3">
						<label class="llabel" name="payrtype">
						<cfif #pmast_qry.PAYRTYPE# eq "M">Monthly
						<cfelseif #pmast_qry.PAYRTYPE# eq "D">Daily
						<cfelseif #pmast_qry.PAYRTYPE# eq "H">Hourly
						</cfif></label>
					</td>
				</tr>
				<tr>
					<td colspan="2" width="100">Working Days</td>
					<td width="">
						<cfset workingday =  val(pay_qry.WDAY) >
						<!--- <cfif workingday neq 0>
							<cfif pmast_qry.nppm eq "0" and pmast_qry.PAYRTYPE eq "M">
								<cfset workingday = val(pay_qry.WDAY)/val(gs_qry.bp_payment)>
							<cfelseif pmast_qry.nppm neq "0" and pmast_qry.PAYRTYPE eq "M">
								<cfset workingday = val(pay_qry.WDAY)/val(pmast_qry.nppm)>
							</cfif>
						</cfif> --->
						
						<cfset Date_sys = Createdate(gs_qry.MYEAR,gs_qry.MMONTH,1)>
						<cfinvoke component="cfc.workingday" method="calwday" returnvariable="workingday" 
						wday="#val(pay_qry.WDAY)#" salarypaytype="#pmast_qry.PAYRTYPE#" Date_sys="#Date_sys#" 
						empno="#URLDecode(url.empno)#" emp_pay_time="#pmast_qry.nppm#"	comp_pay_time="#gs_qry.bp_payment#"	
						emp_grp="#pmast_qry.wrking_grp#" db="#dts#">
						<cfif emp_poj_qry.payyes eq "Y">
						<input type="text" name="WDAY" id="WDAY" value="#numberformat(workingday,'.__')#" size="8" readonly>
						<cfelse>
						<input type="text" name="WDAY" id="WDAY" value="#numberformat(workingday,'.__')#" size="8">
						</cfif>
					</td>
					<input type="hidden" name="dcomm" value="#pmast_qry.dcomm#">
					<td align="right">
						<input type="button" name="cal" value="Cal." <cfif #pmast_qry.mcomm# neq "#gs_qry.mmonth#">disabled
						<cfelse>
						</cfif> 
						onClick="window.open('/payments/1stHalf/AddUpdate/normalPay_cal.cfm?empno=#URLEncodedFormat(pmast_qry.empno)#', 'windowname', 'width=150, height=150, left=100, top=100')">
					</td>
					<td>
						<input type="button" name="" value="More" onClick="window.open('/payments/1stHalf/AddUpdate/normalPay_more.cfm?empno=#URLEncodedFormat(pmast_qry.empno)#', 'windowname', 'width=350, height=280, left=100, top=100')"></td>
				</tr>
				<tr>
					<th colspan="2">Pay Days</th>
					<th colspan="2"></th>
					<th colspan="3" width="180">No Pay Days</th>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('DAY WORKED')" onMouseOut="UnTip()">DW</td>
					<td onMouseOver="Tip('DAY WORKED')" onMouseOut="UnTip()"><input type="text" name="DW" id="DW" value="#numberformat(pay_qry.DW,'.__')#" size="6"></td>
					<td><cfif #HcomID# eq "demo"><input type="checkbox" name="fullm" id="fullm" onClick="javascript:fullmonth()" /> Full Month</cfif></td>					
					<td></td>
					<td>No Pay</td>
					<td width="30" onMouseOver="Tip('LINE SHUT DOWN')" onMouseOut="UnTip()" >LS</td>
					<td onMouseOver="Tip('LINE SHUT DOWN')" onMouseOut="UnTip()"><input type="text" name="LS" value="#numberformat(pay_qry.LS,'.__')#" size="11"></td>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('PUBLIC HOLIDAY')" onMouseOut="UnTip()">PH</td>
					<td  onmouseover="Tip('PUBLIC HOLIDAY')" onMouseOut="UnTip()"><input type="text" name="PH" value="#numberformat(pay_qry.PH,'.__')#" size="6"></td>
					<th colspan="2"><div align="center"><u>Balance</u></div></th>
					<td>No Pay</td>
					<td width="30"  onmouseover="Tip('NON-PAY LEAVES')" onMouseOut="UnTip()">NPL</td>
					<td onMouseOver="Tip('NON-PAY LEAVES')" onMouseOut="UnTip()">
						<cfif emp_poj_qry.payyes eq "Y">
						<input type="text" name="NPL" value="#numberformat(pay_qry.NPL,'.__')#" size="11" readonly>
						<cfelse>
						<input type="text" name="NPL" value="#numberformat(pay_qry.NPL,'.__')#" size="11">
						</cfif>
					</td>
				</tr>
				<cfquery name="emp_data" datasource="#dts#" >
					SELECT * FROM pmast as pm LEFT JOIN emp_users as ep ON pm.empno = ep.empno WHERE ep.empno = "#URLDecode(url.empno)#" 
				</cfquery>
				<cfquery name="leave_data" datasource="#dts#">
					SELECT * FROM emp_users as pm LEFT JOIN pay_ytd as p ON pm.empno = p.empno WHERE pm.empno = "#URLDecode(url.empno)#"
				</cfquery>
				<cfquery name="leave_data2" datasource="#dts#">
					SELECT * FROM pleave as p left join emp_users as pm on p.empno= pm.empno where pm.empno = "#URLDecode(url.empno)#"
				</cfquery>
				<cfquery name="aLeave_qry" datasource="#dts_main#">
					SELECT mmonth,myear,c_ale FROM gsetup WHERE comp_id = "#HcomID#"
				</cfquery>
				
				<!--- <cfset today="#dateformat(now(),'MM')#"> --->
				<cfset sys_year = aLeave_qry.myear>
				<cfset sys_month = aLeave_qry.mmonth>
				<cfset sys_date = #createdate(sys_year,sys_month,1)#>
				<cfset today = #dateformat(sys_date,'mm')#>
				
				
				<cfset tLVE_DAY_a = 0>
				<cfset tLVE_DAY_b = 0>
				<cfset tLVE_DAY_MC_a = 0>
				<cfset tLVE_DAY_MC_b = 0>
				<cfset tLVE_DAY_CC_a = 0>
				<cfset tLVE_DAY_CC_b = 0>
				
				
			<!--- start AL --->
				
				<cfloop query="leave_data2">
					<cfset leave_date="#dateformat(leave_data2.LVE_DATE,'MM')#">
					<!-- sum of the leave in last month -->
					<cfif #leave_date# lte #today# AND leave_data2.LVE_TYPE eq "AL">  
						<cfset tLVE_DAY_a= tLVE_DAY_a + val(leave_data2.LVE_DAY)>
					</cfif>
					<!-- sum of the leave in this month -->
					<cfif #leave_date# gt #today# AND leave_data2.LVE_TYPE eq "AL">  
						<cfset tLVE_DAY_b= tLVE_DAY_b + val(leave_data2.LVE_DAY)>
					</cfif>
				</cfloop>
				
				<!-- Annual Leave Entitle Base on L(Last Year Work Done), T(This Year Work Done) -->
				
					<cfset total_AL_entitled = val(emp_data.alall)+val(emp_data.albf)+val(emp_data.aladj) >
				
				<!-- take pleave as the total past month leave if pleave greater than ytd else vice versa -->				
				<cfif leave_data.AL gte #tLVE_DAY_a# >
					<cfset bal_AL = total_AL_entitled -(val(leave_data.AL)+val(tLVE_DAY_b)) >
					<input type="hidden" name="total_AL_entitled" id="total_AL_entitled" value="#total_AL_entitled#">
					<input type="hidden" name="past_month_leave" id="past_month_leave" value="#leave_data.AL#" >
					<input type="hidden" name="bal_AL2" id="bal_AL2" value="#bal_AL#" >
				<cfelse>
					<cfset bal_AL = total_AL_entitled -(val(tLVE_DAY_a)+val(tLVE_DAY_b))>
					<input type="hidden" name="total_AL_entitled" id="total_AL_entitled" value="#total_AL_entitled#">
					<input type="hidden" name="past_month_leave" id="past_month_leave" value="#tLVE_DAY_a#" >
					<input type="hidden" name="bal_AL2" id="bal_AL2" value="#bal_AL#" >
				</cfif>
				
			<!--- start MC --->
				
				<cfloop query="leave_data2">
					<cfset leave_date="#dateformat(leave_data2.LVE_DATE,'MM')#">
					<cfif #leave_date# lte #today# AND leave_data2.LVE_TYPE eq "MC">  
						<cfset tLVE_DAY_MC_a= tLVE_DAY_MC_a + val(leave_data2.LVE_DAY)>
					</cfif>
					
					<cfif #leave_date# gt #today# AND leave_data2.LVE_TYPE eq "MC">  
					<cfset tLVE_DAY_MC_b= tLVE_DAY_MC_b + val(leave_data2.LVE_DAY)>
					</cfif>
				</cfloop>
				
				<cfif leave_data.MC gte #tLVE_DAY_MC_a# >
					<cfset bal_MC = val(emp_data.mcall)-(val(leave_data.MC)+val(tLVE_DAY_MC_b)) >
					<input type="hidden" name="total_mc_entitled" id="total_mc_entitled" value="#emp_data.mcall#">
					<input type="hidden" name="past_month_mc" id="past_month_mc" value="#leave_data.MC#" >
					<input type="hidden" name="bal_MC2" id="bal_MC2" value="#bal_MC#" >
				<cfelse>
					<cfset bal_MC = val(emp_data.mcall)-(val(tLVE_DAY_MC_a)+val(tLVE_DAY_MC_b))>
					<input type="hidden" name="total_mc_entitled" id="total_mc_entitled" value="#emp_data.mcall#">
					<input type="hidden" name="past_month_mc" id="past_month_mc" value="#tLVE_DAY_MC_a#" >
					<input type="hidden" name="bal_MC2" id="bal_MC2" value="#bal_MC#" >
				</cfif>
				
				<!--- start childcare --->
				
				<cfloop query="leave_data2">
					<cfset leave_date="#dateformat(leave_data2.LVE_DATE,'MM')#">
					<cfif #leave_date# lte #today# AND leave_data2.LVE_TYPE eq "CC">  
						<cfset tLVE_DAY_CC_a= tLVE_DAY_CC_a + val(leave_data2.LVE_DAY)>
					</cfif>
					
					<cfif #leave_date# gt #today# AND leave_data2.LVE_TYPE eq "CC">  
						<cfset tLVE_DAY_CC_b= tLVE_DAY_CC_b + val(leave_data2.LVE_DAY)>
					</cfif>
				</cfloop>
				<!--- <cfoutput>#tLVE_DAY_CC_b#</cfoutput> --->
				<cfif leave_data.CC gte #tLVE_DAY_CC_a# >
					<cfset bal_CC = val(emp_data.ccall)-(val(leave_data.CC)+val(tLVE_DAY_CC_b)) >
					<input type="hidden" name="total_cc_entitled" id="total_cc_entitled" value="#emp_data.ccall#">
					<input type="hidden" name="past_month_cc" id="past_month_cc" value="#leave_data.CC#" >
					<input type="hidden" name="bal_CC2" id="bal_CC2" value="#bal_CC#" >
				<cfelse>
					<cfset bal_CC = val(emp_data.ccall)-(val(tLVE_DAY_CC_a)+val(tLVE_DAY_CC_b))>
					<input type="hidden" name="total_cc_entitled" id="total_cc_entitled" value="#emp_data.ccall#">
					<input type="hidden" name="past_month_cc" id="past_month_cc" value="#val(tLVE_DAY_CC_a)#" >
					<input type="hidden" name="bal_CC2" id="bal_CC2" value="#bal_CC#" >
				</cfif> 
				<tr>
					<td width="40" onMouseOver="Tip('ANNUAL LEAVES')" onMouseOut="UnTip()">AL</td>
					<td onMouseOver="Tip('ANNUAL LEAVES')" onMouseOut="UnTip()" >
						<input type="text" name="AL" id="AL" value="#numberformat(pay_qry.AL,'.__')#" size="6" onKeyUp="balance();">
					</td>
	                 	
					<th colspan="2">
						<div align="center">
							<input type="text" name="balAL" id="balAL" value="#val(bal_AL)#" size="4" readonly>
						</div>
					</th>
					<td>No Pay</td>
					<td width="30" onMouseOver="Tip('ABSENT')" onMouseOut="UnTip()">AB</td>
					<td onMouseOver="Tip('ABSENT')" onMouseOut="UnTip()">
						<input type="text" name="AB" value="#numberformat(pay_qry.AB,'.__')#" size="11">
					</td>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('MEDICAL LEAVE')" onMouseOut="UnTip()">MC</td>
					<td onMouseOver="Tip('MEDICAL LEAVE')" onMouseOut="UnTip()" >
                     <input type="hidden" name="mcoldone" id="mcoldone" value="#numberformat(pay_qry.MC,'.__')#" size="6" readonly>
						<cfif emp_poj_qry.payyes eq "Y">
						<input type="text" name="MC" value="#numberformat(pay_qry.MC,'.__')#" size="6" readonly>
						<cfelse>
						<input type="text" name="MC" value="#numberformat(pay_qry.MC,'.__')#" size="6" onKeyUp="balance();">
						</cfif>
					</td>
						
					<th colspan="2"><div align="center">
						<input type="text" name="balMC" value="" size="4" readonly></div></th>
					<td>No Pay</td>
					<td width="30"><input type="text" name="ONPLD" value="#pay_qry.ONPLD#" size="2"></td>
					<td><input type="text" name="ONPL" value="#numberformat(pay_qry.ONPL,'.__')#" size="11"></td>
				</tr>
                <tr>
					<td width="40" onMouseOver="Tip('MATERNITY LEAVE')" onMouseOut="UnTip()">MT</td>
					<td onMouseOver="Tip('MATERNITY LEAVE')" onMouseOut="UnTip()" ><input type="text" name="MT" value="#numberformat(pay_qry.MT,'.__')#" size="6"></td>
                    <td></td>
                    <td></td>
                    <td>No Pay</td>
                    <td>NS</td>
                    <td><input type="text" name="NS" id="NS" value="#numberformat(pay_qry.NS,'.__')#" size="11"></td>
                    
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('CHILD CARE')" onMouseOut="UnTip()">CC</td>
					<td onMouseOver="Tip('CHILD CARE')" onMouseOut="UnTip()" >
						<input type="text" name="CC" value="#numberformat(pay_qry.CC,'.__')#" size="6" onKeyUp="balance();">
					</td>
					<th colspan="2"><div align="center"><input type="text" name="balCC" value="" size="4" readonly></div></th>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('MARRIAGE LEAVE')" onMouseOut="UnTip()">MR</td>
					<td onMouseOver="Tip('MARRIAGE LEAVE')" onMouseOut="UnTip()" ><input type="text" name="MR" value="#numberformat(pay_qry.MR,'.__')#" size="6"></td>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('COMPASSIONATE LEAVE')" onMouseOut="UnTip()" >CL</td>
					<td onMouseOver="Tip('COMPASSIONATE LEAVE')" onMouseOut="UnTip()" ><input type="text" name="CL" value="#numberformat(pay_qry.CL,'.__')#" size="6"></td>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('HOSPITALISATION LEAVE')" onMouseOut="UnTip()" >HL</td>
					<td onMouseOver="Tip('HOSPITALISATION LEAVE')" onMouseOut="UnTip()" ><input type="text" name="HL" value="#numberformat(pay_qry.HL,'.__')#" size="6"></td>	
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('EXAMINATION LEAVE')" onMouseOut="UnTip()" >EX</td>
					<td onMouseOver="Tip('EXAMINATION LEAVE')" onMouseOut="UnTip()"><input type="text" name="EX" value="#numberformat(pay_qry.EX,'.__')#" size="6"></td>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('PATERNITY LEAVE')" onMouseOut="UnTip()" >PT</td>
					<td onMouseOver="Tip('PATERNITY LEAVE')" onMouseOut="UnTip()"><input type="text" name="PT" value="#numberformat(pay_qry.PT,'.__')#" size="6"></td>
					<td colspan="2"></td>
					<td></td>
					<td>(Days)</td>
					<td><input type="text" name="OOB" value="#numberformat(pay_qry.OOB,'.__')#" size="5">
						<img id="whtTrigger" src="/images/OOB.ICO" style="background:inherit; width:15px; height:15px">
						<!--- <input type="button" id="whtTrigger" name="" value="?" disabled onmouseover=""> --->
					</td>
				</tr>
				<tr>
					<td width="40" onMouseOver="Tip('ADVANCE LEAVE')" onMouseOut="UnTip()" >AD</td>
					<td onMouseOver="Tip('ADVANCE LEAVE')" onMouseOut="UnTip()" ><input type="text" name="AD" value="#numberformat(pay_qry.AD,'.__')#" size="6"></td>
				</tr>
				<tr>
					<td width="40"><input type="text" name="OPLD" value="#pay_qry.OPLD#" size="3"></td>
					<td><input type="text" name="OPL" value="#numberformat(pay_qry.OPL,'.__')#" size="6"></td>
				</tr>
				</table>
				</td>
				<td>
				<table>
				<tr>
					<td>
					<table>
					<tr>
						<th width="80">Overtime</th>
						<th width="80">Hrs/Days</th>
						<th width="50"></th>
					</tr>
					<cfset i=1>
					<cfloop query="ot_qry">
					<tr>
						<td>#ot_qry.ot_desp#</td>
						<td>
							<cfif emp_poj_qry.payyes eq "Y">
								<input type="text" name="HR#i#" value="#numberformat(evaluate('pay_qry.HR#i#'),'.__')#" size="10" readonly>
							<cfelse>
								<input type="text" name="HR#i#" value="#numberformat(evaluate('pay_qry.HR#i#'),'.__')#" size="10">
							</cfif>
						</td>
						<td>#ot_qry.ot_unit#</td>
					</tr>
					<cfset i=i+1>
					</cfloop>
					<tr>
					</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td>
					<table>
					<tr>
						<th colspan="3" width="220"><div align="center">Hours</div></th>
					</tr>
					<tr>
						<td>Work Hours</td>
						<td><input type="text" name="WORKHR" value="#numberformat(pay_qry.WORKHR,'.__')#" size="10"></td>
						<td></td>
					</tr>
					<tr>
						<td>Lateness</td>
						<td><input type="text" name="LATEHR" value="#numberformat(pay_qry.LATEHR,'.__')#" size="10"></td>
						<td></td>
					</tr>
					<tr>
						<td>Early Dep.</td>
						<td><input type="text" name="EARLYHR" value="#numberformat(pay_qry.EARLYHR,'.__')#" size="10"></td>
						<td></td>
					</tr>
					<tr>
						<td>No Pay Hour</td>
						<td><input type="text" name="NOPAYHR" value="#numberformat(pay_qry.NOPAYHR,'.__')#" size="10"></td>
						<td></td>
					</tr>
					</table>
					</td>
				</tr>
				</table>
				</td>
			</tr>
			</table>
		</div>
		<div class="tabbertab" style="height:390px;">
			<h3>Allowance</h3>
			<table class="form" border="0">
			<tr>
				<td>
				<table>
				<tr>
					<th width="200" colspan="2">Director Fee</th>
					<th width="100">Amount</th>
				</tr>
				<tr>
					<td colspan="2">Director Fee</td>
					<td><input type="text" name="DIRFEE" value="#numberformat(pay_qry.DIRFEE,'.__')#" size="14"></td>
				</tr>
				<tr>
					<th colspan="2">Allowance</th>
					<th>Amount</th>
				</tr>
				<cfset i=1>
				<cfset j=101>
				<cfloop query="at1_qry">
				<tr>
					<td>#i#.</td>
					<td>#at1_qry.aw_desp#</td>
					<td><input type="text" name="AW#j#"
                     
					 
                    
					<cfoutput> value="#numberformat(evaluate('pay_qry.AW#j#'),'.__')#" </cfoutput>
					<!--- <cfif #evaluate('pmast_qry.DBAW#j#')# eq 0><cfelse><cfoutput>value="#numberformat(evaluate('pmast_qry.DBAW#j#'),'.__')#" readonly="readonly"</cfoutput>
					</cfif>  --->
                    size="14"></td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>

				</table>
				</td>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td>
				<table>
				<tr>
					<th width="200" colspan="2">Allowance</th>
					<th width="100">Amount</th>
				</tr>
				<cfset i=11>
				<cfset j=111>
				<cfloop query="at2_qry">
				<tr>
					<td>#i#.</td>
					<td>#at2_qry.aw_desp#</td>
					<td><input type="text" name="AW#j#" 
					
					<cfoutput> value="#numberformat(evaluate('pay_qry.AW#j#'),'.__')#" </cfoutput>
					<!--- <!--- <cfif #evaluate('pmast_qry.DBAW#j#')# eq 0> ---><cfelse><cfoutput>value="#numberformat(evaluate('pmast_qry.DBAW#j#'),'.__')#" readonly="readonly"</cfoutput>
					</cfif> ---> 
                    size="14">
                    </td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>
				<tr>
					<td colspan="2"></td>
					<td align="right"><input type="button" name="moreAW" value="More.." onClick="window.open('/payments/1stHalf/AddUpdate/normalPay_moreAW.cfm?empno=#URLEncodedFormat(pmast_qry.empno)#', 'windowname1', 'width=400, height=500, left=100, top=100')"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th colspan="2">Day Worked</th>
					<th>Days</th>
				</tr>
				<tr>
					<td colspan="2">DW Allowance Adjustment</td>
					<td><input type="text" name="DWAWADJ" value="#numberformat(pay_qry.DWAWADJ,'.__')#" size="14"></td>
				</tr>
				</table>
				</td>
			</tr>
			</table>
		</div>
		<div class="tabbertab" style="height:390px;">
			<h3>Deduction</h3>
			<table class="form" border="0">
			<tr>
				<td>
				<table>
				<tr>
					<th width="200" colspan="2">Deductions</th>
					<th width="100">Amount</th>
				</tr>
				<cfset i=1>
				<cfset j=101>
				<cfloop query="ded1_qry">
				<tr>
					<td>#i#.</td>
					<td>#ded1_qry.ded_desp#</td>
                    
					<td><input type="text" name="DED#j#" 
                    <cfif #evaluate('pmast_qry.DBDED#j#')# eq 0>
					<cfoutput> value="#numberformat(evaluate('pay_qry.DED#j#'),'.__')#" </cfoutput>
					<cfelse><cfoutput>value="#numberformat(evaluate('pmast_qry.DBDED#j#'),'.__')#" readonly="readonly"</cfoutput>
					</cfif> 
                    size="14"></td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>
				</table>
				</td>
				<td>
				<table>
				<tr>
					<th width="200" colspan="2">Deductions</th>
					<th width="100">Amount</th>	
				</tr>
				<cfset i=11>
				<cfset j=111>
				<cfloop query="ded2_qry">
				<tr>
					<td>#i#.</td>
					<td>#ded2_qry.ded_desp#</td>
					<td><input type="text" name="DED#j#" 
                    
					<cfoutput> value="#numberformat(evaluate('pay_qry.DED#j#'),'.__')#" </cfoutput>
					
                    size="14">
                    </td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>
				<tr>
					<td colspan="3" align="right"><input type="button" name="more" value="More.." onClick="window.open('/payments/1stHalf/AddUpdate/normalPay_moreDED.cfm?empno=#URLEncodedFormat(pmast_qry.empno)#', 'windowname1', 'width=400, height=500, left=100, top=100')"></td>
				</tr>
				<tr>
					<th colspan="3">Message</th>
				</tr>
				<tr>
					<td>Message</td>
				</tr>
				<tr>
					<td colspan="3"><input type="text" name="MESS" value="#pay_qry.MESS#" size="47"></td>
				</tr>
				<tr>
					<td>Message 2</td>
				</tr>
				<tr>
					<td colspan="3"><input type="text" name="MESS1" value="#pay_qry.MESS1#" size="47"></td>
				</tr>
				</table>
				</td>
			</tr>
			</table>
		</div>
		<div class="tabbertab" style="height:390px;">
			<h3>Other</h3>
			<table class="form" border="0">
			<tr>
				<th width="310" colspan="3">Shift Allowance Table - </th>
				<th width="30"></th>
				<th width="150">Description</th>
				<th width="80">Rate</th>
				<th width="80">Days Worked</th>	
			</tr>
			<tr>            
            <cfquery name="shift_rate" datasource="#dts#">
            SELECT * from shftable WHERE shf_cou = '#pmast_qry.shifttbl#'
            </cfquery>
				<th width="150">Description</th>
				<th width="80">Rate</th>
				<th width="80">Days Worked</th>
				<td width="30"></td>
				<td width="150">SHIFT 15</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift15,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTO" value="#numberformat(pay_qry.SHIFTO,'.__')#" size="10"></td>
                

			</tr>
			<tr>
				<td width="150">SHIFT 1</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift1,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTA" value="#numberformat(pay_qry.SHIFTA,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150">SHIFT 14</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift14,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTN" value="#numberformat(pay_qry.SHIFTN,'.__')#" size="10"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 2</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift2,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTB" value="#numberformat(pay_qry.SHIFTB,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150">SHIFT 16</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift16,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTP" value="#numberformat(pay_qry.SHIFTP,'.__')#" size="10"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 3</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift3,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTC" value="#numberformat(pay_qry.SHIFTC,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150">SHIFT 17</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift17,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTQ" value="#numberformat(pay_qry.SHIFTQ,'.__')#" size="10"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 4</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift4,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTD" value="#numberformat(pay_qry.SHIFTD,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150">SHIFT 18</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift18,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTR" value="#numberformat(pay_qry.SHIFTR,'.__')#" size="10"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 5</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift5,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTE" value="#numberformat(pay_qry.SHIFTE,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150">SHIFT 19</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift19,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTS" value="#numberformat(pay_qry.SHIFTS,'.__')#" size="10"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 6</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift6,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTF" value="#numberformat(pay_qry.SHIFTF,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150">SHIFT 20</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift20,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTT" value="#numberformat(pay_qry.SHIFTT,'.__')#" size="10"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 7</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift7,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTG" value="#numberformat(pay_qry.SHIFTG,'.__')#" size="10"></th>
				<td width="30"></td>
				<th width="150" colspan="3">Tip Allowance</th>
			</tr>
			<tr>
				<td width="150">SHIFT 8</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift8,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTH" value="#numberformat(pay_qry.SHIFTH,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150" colspan="2">Tip Point</td>
				<td width="100"><input type="text" name="TIPPOINT" value="#numberformat(pay_qry.TIPPOINT,'.__')#" size="14"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 9</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift9,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTI" value="#numberformat(pay_qry.SHIFTI,'.__')#" size="10"></th>
				<td width="30"></td>
				<td width="150" colspan="2">Tip Rate</td>
				<td width="100"><input type="text" name="TIPRATE" value="#numberformat(pay_qry.TIPRATE,'.__')#" size="14"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 10</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift10,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTJ" value="#numberformat(pay_qry.SHIFTJ,'.__')#" size="10"></th>
				<td width="30"></td>
				<th colspan="3">Other Benefits</th>
			</tr>
			<tr>
				<td width="150">SHIFT 11</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift11,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTK" value="#numberformat(pay_qry.SHIFTK,'.__')#" size="10"></th>
				<td width="30"></td>
				<td colspan="2">Medical Fund</td>
				<td width="100"><input type="text" name="MFUND" value="#numberformat(pay_qry.MFUND,'.__')#" size="14"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 12</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift12,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTL" value="#numberformat(pay_qry.SHIFTL,'.__')#" size="10"></th>
				<td width="30"></td>
				<td colspan="2">Dental Fund</td>
				<td width="100"><input type="text" name="DFUND" value="#numberformat(pay_qry.DFUND,'.__')#" size="14"></td>
			</tr>
			<tr>
				<td width="150">SHIFT 13</td>
				<td width="80"><input type="text" name="" value="#numberformat(shift_rate.shift13,'.__')#" size="10" readonly></td>
				<td width="80"><input type="text" name="SHIFTM" value="#numberformat(pay_qry.SHIFTM,'.__')#" size="10"></th>
				<td width="30"></td>
				<th colspan="3">Project</th>
			</tr>
			<tr>
				<td width="150"></td>
				<td width="80"></th>
				<td width="80"></td>
				<td width="30"></td>
				<td colspan="2">Project</td>
				<td width="80">
					<!--- <input type="text" name="project" value="#pro_qry.#" size="14"> --->
					<select name="project">
						<option value=""></option>
						<cfloop query="pro_qry">
						<option value="#pro_qry.project#">#pro_qry.project# | #pro_qry.desp#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			</table>
		</div>
		<div class="tabbertab" style="height:390px;">
			<h3>User Define Rate</h3>
			<table class="form" border="0">
			<tr>
				<th class="subheader" colspan="4">User Define Rate</th>
			</tr>
			<tr>
				<td>
				<table>
				<cfset i=1>
				<cfloop query="udrate1_qry">
				<tr>					
					<td width="100">
					<cfif #udrate1_qry.udrat_desp# eq "">
						UDRATE#i#
					<cfelse>
						#udrate1_qry.udrat_desp#
					</cfif>
					</td>
					<td width="150"><input type="text" name="UDRATE#i#" value="#numberformat(evaluate('pay_qry.UDRATE#i#'),'.__')#" size="15"></td>
				</tr>
				<cfset i=i+1>
				</cfloop>				
				</table>
				</td>
				<td>
				<table>
				<cfset i=16>
				<cfloop query="udrate2_qry">
				<tr>
					<td width="100">
					<cfif #udrate2_qry.udrat_desp# eq "">
						UDRATE#i#
					<cfelse>
						#udrate2_qry.udrat_desp#
					</cfif>
					</td>
					<td width="150"><input type="text" name="UDRATE#i#" value="#numberformat(evaluate('pay_qry.UDRATE#i#'),'.__')#" size="15"></td>
				</tr>
				<cfset i=i+1>
				</cfloop>				
				</table>
				</td>
			</tr>
			</table>
		</div>
		<div class="tabbertab" style="height:390px;">
			<h3>Project Site</h3>
			
			
			<table class="form" width="500px" border="0">
				<tr>
					<th width="100px">PROJECT</th>	
					<th width="100px">DATE</th>
					<th >DW</th>
					<th >MC</th>
					<th >NPL</th>
					<th >OT1</th>
					<th >OT2</th>
					<th >OT3</th>
					<th >OT4</th>
					<th >OT5</th>
					<th >OT6</th>
					<th colspan="2">Action</th>				
				</tr>
				
				<input type="hidden" name="entryno_2" id="entryno_2" value="">
				<cfloop query="emp_poj_qry">
					<cfquery name="prj_name" datasource="#dts#">
						SELECT desp FROM project where project =<cfqueryparam cfsqltype="cf_sql_varchar" value="#emp_poj_qry.project_code#">;
					</cfquery>
				<tr>
					<cfset entryno = emp_poj_qry.entryno>
					<input type="hidden" name="entryno_id" id="entryno_id" value="#entryno#">
					<td><input name="proj_code" id="proj_code" size="25" value="#emp_poj_qry.project_code#-#prj_name.desp#" readonly/></td>
					<cfset pdate = dateformat(emp_poj_qry.date_p,'dd-mm-yyyy')>
					<td><input name="date_p" id="date_p" value="#pdate#" size="25" readonly/></td>
					<td><input name="dw_p" id="dw_p" value="#emp_poj_qry.dw_p#" size="5" readonly/></td>
					<td><input name="mc_p" id="mc_p" value="#emp_poj_qry.mc_p#" size="5" readonly/></td>
					<td><input name="npl_p" id="npl_p" value="#emp_poj_qry.npl_p#" size="5" readonly/></td>
					<td><input name="ot1_p" id="ot1_p" value="#emp_poj_qry.ot1_p#" size="5" readonly/></td>
					<td><input name="ot2_p" id="ot2_p" value="#emp_poj_qry.ot2_p#" size="5" readonly/></td>
					<td><input name="ot3_p" id="ot3_p" value="#emp_poj_qry.ot3_p#" size="5" readonly/></td>
					<td><input name="ot4_p" id="ot4_p" value="#emp_poj_qry.ot4_p#" size="5" readonly/></td>
					<td><input name="ot5_p" id="ot5_p" value="#emp_poj_qry.ot5_p#" size="5" readonly/></td>
					<td><input name="ot6_p" id="ot6_p" value="#emp_poj_qry.ot6_p#" size="5" readonly/></td>
					<td><a onClick="javascript:update(#entryno#);" >
						<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> </td> 
					<td><a href="##" onClick="confirmDelete('#entryno#','del','#pay_qry.empno#')">
						<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>
                    </td>
				</tr>
				</cfloop>
				<cfquery name="sum_prj_rcd" datasource="#dts#">
				SELECT sum(coalesce(dw_p,0))as totdw_p,sum(coalesce(mc_p,0))as totmc_p, 
					   sum(coalesce(npl_p,0))as totnpl_p,sum(coalesce(ot1_p,0))as totot1_p, 
					   sum(coalesce(ot2_p,0))as totot2_p, sum(coalesce(ot3_p,0))as totot3_p ,
					   sum(coalesce(ot4_p,0))as totot4_p,sum(coalesce(ot5_p,0))as totot5_p ,
					   sum(coalesce(ot6_p,0))as totot6_p FROM proj_rcd_1 p 
				WHERE EMPNO = "#URLDecode(url.empno)#";
				</cfquery> 
				<tr>
					<th colspan="2">Total</th>
			
					<td><input name="totdw_p" id="totdw_p" value="#sum_prj_rcd.totdw_p#" size="5" readonly/></td>
					<td><input name="totmc_p" id="totmc_p" value="#sum_prj_rcd.totmc_p#" size="5" readonly/></td>
					<td><input name="totnpl_p" id="totnpl_p" value="#sum_prj_rcd.totnpl_p#" size="5" readonly/></td>
					<td><input name="totot1_p" id="tottotot1_p" value="#sum_prj_rcd.totot1_p#" size="5" readonly/></td>
					<td><input name="totot2_p" id="tottotot2_p" value="#sum_prj_rcd.totot2_p#" size="5" readonly/></td>
					<td><input name="totot3_p" id="tottotot3_p" value="#sum_prj_rcd.totot3_p#" size="5" readonly/></td>
					<td><input name="totot4_p" id="tottotot4_p" value="#sum_prj_rcd.totot4_p#" size="5" readonly/></td>
					<td><input name="totot5_p" id="tottotot5_p" value="#sum_prj_rcd.totot5_p#" size="5" readonly/></td>
					<td><input name="totot6_p" id="tottotot5_p" value="#sum_prj_rcd.totot6_p#" size="5" readonly/></td>
					<td></td>
				</tr>
				<tr>
					<td align="center">&nbsp</td>									
				</tr>
				<tr>
					<td align="center">&nbsp</td>									
				</tr>
				<tr>
					<td colspan="12" align="center">
					<input type="button" name="add" value="add" onClick="javascript:ColdFusion.Window.show('Add_proj')" >
					<input type="button" name="generate" value="Generate" size="5" onClick="javascript:ColdFusion.Window.show('generate_proj')" >
					</td>
				</tr>
				
			</table>
		</div>	
	</div>
	<br />
    <center>
        <cfquery name="nex_list" datasource="#dts#">
    		SELECT empno FROM pmast WHERE empno > <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.empno)#"> 
	    	and paystatus = "A"  and confid >= #hpin# 
		<cfif gs_qry.t1 eq 0>
        <cfif gs_qry.bp_payment eq "2">
        and (nppm = "2" or nppm = "0") 
		<cfelse>
        and nppm = "2"
		</cfif>
		</cfif> order by empno
    	</cfquery>
        <cfquery name="prev_list" datasource="#dts#">
	    	SELECT * FROM pmast WHERE empno < "#URLDecode(url.empno)#" and paystatus = "A"  and confid >= #hpin#
            <cfif gs_qry.t1 eq 0>
        <cfif gs_qry.bp_payment eq "2">
        and (nppm = "2" or nppm = "0") 
		<cfelse>
        and nppm = "2"
		</cfif>
		</cfif>
         ORDER BY empno DESC
	    </cfquery>
        
     
        <input type="submit" name="save" value="Save" onClick="javascript:saveonly();setTimeout('window.opener.getbasicrate();',500)">
        <input type="button" name="exit" value="Exit" onClick="window.close();">
      </center>
	</cfform>
	</cfoutput> 
    <cfwindow x="210" y="100" width="500" height="400" name="searchwindow"
        title="Search Employee" initshow="false"
        source="searchEmployee.cfm"  modal="true" refreshonshow="true"/>
		
		<cfwindow x="210" y="100" width="570" height="480" name="Add_proj"
  		 minHeight="400" minWidth="400" 
   		 title="Add Project" initshow="false"
   		 source="Add_proj.cfm?empno=#URLEncodedFormat(pay_qry.empno)#"/>
	
		<cfwindow x="210" y="100" width="570" height="480" name="update_proj"
  		 minHeight="400" minWidth="400" 
   		 title="Update Project" initshow="false" refreshOnShow = "true"
   		 source="Add_proj.cfm?empno=#URLEncodedFormat(pay_qry.empno)#&entryno={eForm:entryno_2}&act=update"  />
	
		<cfwindow x="210" y="100" width="400" height="200" name="generate_proj"
  		title="Genrate into Payroll" initshow="false" refreshOnShow = "true"
   		 source="generate_proj.cfm?empno=#URLEncodedFormat(pay_qry.empno)#"  />
	<script type="text/javascript">
	setTimeout('balance();',1000);
    </script>
</body>
</html></html></html></html>