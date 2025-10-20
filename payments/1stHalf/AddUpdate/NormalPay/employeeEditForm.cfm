<html>
<head>
	<title>Edit/Update Employee</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<script src="/javascripts/resizeSel.js" type="text/javascript"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/includes/xpath.js"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/includes/SpryData.js"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/widgets/tooltip/SpryTooltip.js"></script>
	<script src="/javascripts/CalendarControl.js" language="javascript"> </script>
	
	<link href="/lib/spry/widgets/tooltip/SpryTooltip.css" rel="stylesheet" type="text/css" />
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
<style type="text/css">
div.resizeSel{
	OVERFLOW: hidden; position:relative; overflow-x: hidden; overflow-y: fixed; 
	visibility:visible;
}
</style>
<script language="javascript">
	function show_row(obj){
		if (obj.value!='M'){
		  // Toggle visibility between none and inline
			document.getElementById("dailyAdj").style.display = 'inline';
		}else{
			document.getElementById("dailyAdj").style.display = 'none';
			document.getElementById("fwlevyadj").value='0.00';
		}
	}
	//Tooltip Dialog
	analyseForm = function(formEl)
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
	function selectRow(prefix,id){<!--- alert(); --->
		document.getElementById(prefix+id).checked=true;
	}
	
	analyseForm1 = function(formE2)
	{
		var inputs = formE2.getElementsByTagName('input');
		for (var i=0; i < inputs.length; i++)
		{
			if (inputs[i].getAttribute('type').toLowerCase() == 'radio'){
				if(inputs[i].checked) document.eForm.shifttbl.value =inputs[i].value;
			}
		}
		return false;
	}
	//function selectRow(prefix,id){
	//	document.getElementById(prefix+id).checked=true;
	//}
	
	analyseForm2 = function(formE3)
	{
		var inputs = formE3.getElementsByTagName('input');
		for (var i=0; i < inputs.length; i++)
		{
			if (inputs[i].getAttribute('type').toLowerCase() == 'radio'){
				if(inputs[i].checked) document.eForm.ottbl.value =inputs[i].value;
			}
		}
		return false;
	}
	//function selectRow(prefix,id){
	//	document.getElementById(prefix+id).checked=true;
	//}
	
	analyseForm3 = function(formE4)
	{
		var inputs = formE4.getElementsByTagName('input');
		for (var i=0; i < inputs.length; i++)
		{
			if (inputs[i].getAttribute('type').toLowerCase() == 'radio'){
				if(inputs[i].checked) document.eForm.almctbl.value =inputs[i].value;
			}
		}
		return false;
	}
	//function selectRow(prefix,id){
	//	document.getElementById(prefix+id).checked=true;
	//}
	
	analyseForm4 = function(formE5)
	{
		var inputs = formE5.getElementsByTagName('input');
		for (var i=0; i < inputs.length; i++)
		{
			if (inputs[i].getAttribute('type').toLowerCase() == 'radio'){
				if(inputs[i].checked) document.eForm.fwlevytbl.value =inputs[i].value;
			}
		}
		return false;
	}

	function addLoadEvent()
	{
		/* This function adds tabberAutomatic to the window.onload event,
		so it will run after the document has finished loading.*/
		var oldOnLoad;
		/* Taken from: http://simon.incutio.com/archive/2004/05/26/addLoadEvent */
		oldOnLoad = window.onload;
		if (typeof window.onload != 'function') {
			window.onload = function(){
				show_row( document.getElementById("fwlevymtd"));
				var whtTooltip = new Spry.Widget.Tooltip('wht', '#whtTrigger', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht1', '#whtTrigger1', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht2', '#whtTrigger2', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht3', '#whtTrigger3', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('whtN1', '#whtTriggerN1', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
			};
		}else{
			window.onload = function() {
				oldOnLoad();
				show_row( document.getElementById("fwlevymtd"));
				var whtTooltip = new Spry.Widget.Tooltip('wht', '#whtTrigger', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht1', '#whtTrigger1', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht2', '#whtTrigger2', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht3', '#whtTrigger3', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('whtN1', '#whtTriggerN1', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
			};
		}
	}
	addLoadEvent();
	
<!--- 	function vali() {
	if(window.document.eForm.empno.value=="" 
	|| window.document.eForm.name.value==""
	|| window.document.eForm.emp_code.value==""
	|| window.document.eForm.weekpay.value==""
	|| window.document.eForm.contract.value=="")
	{
		alert("Emp No., Name, Employee Code, Week Pay and Contract are required.");
	}
	else	{
				window.document.eForm.submit();
			}
	} --->
</script>
</head>

<body>
<cfquery name="general_qry" datasource="payroll_main">
SELECT COMP_ID, OD_MAXPAY1, OD_MAXPAY2
FROM gsetup
where comp_id = '#HcomID#'
</cfquery>

<cfquery name="acBank_qry" datasource="#dts#">
SELECT *
FROM address a, dept d
WHERE 
org_type in ('BANK')
</cfquery>

<cfquery name="acEPF_qry" datasource="#dts#">
SELECT *
FROM address
WHERE org_type in ('EPF')
</cfquery>

<cfquery name="acTAX_qry" datasource="#dts#">
SELECT *
FROM address
WHERE org_type in ('TAX')
</cfquery>

<cfquery name="branch_qry" datasource="#dts#">
SELECT *
FROM branch
ORDER BY brdesp
</cfquery>

<cfquery name="category_qry" datasource="#dts#">
SELECT *
FROM category
ORDER BY desp
</cfquery>

<cfquery name="country_qry" datasource="#dts_main#">
SELECT *
FROM councode
ORDER BY cname
</cfquery>

<cfquery name="department_qry" datasource="#dts#">
SELECT *
FROM dept
ORDER BY deptdesp
</cfquery>

<cfquery name="lineno_qry" datasource="#dts#">
SELECT *
FROM tlineno
ORDER BY desp
</cfquery>

<cfquery name="race_qry" datasource="#dts#">
SELECT *
FROM race
ORDER BY racedesp
</cfquery>

<cfquery name="religion_qry" datasource="#dts#">
SELECT *
FROM religion
ORDER BY reldesp
</cfquery>

<cfquery name="wht_qry" datasource="#dts#">
SELECT * <!--- ot_cou,xpaymthpy,xdaypmth,xdaypmthab,xhrpday_m,xhrpyear,xhrpday_d,xdaypmtha,xdaypmthb,xhrpday_h, levy_m, levy_d --->
FROM ottable
ORDER BY ot_cou
</cfquery>

<cfquery name="employee" datasource="#dts#">
SELECT *
FROM pmast
WHERE empno = "#url.empno#"
</cfquery>

<cfquery name="aw_qry" datasource="#dts#">
SELECT *
FROM awtable
WHERE aw_cou < 18
</cfquery>

<cfquery name="shf_qry" datasource="#dts#">
SELECT *
FROM shftable
</cfquery>

<cfquery name="ded_qry" datasource="#dts#">
SELECT *
FROM dedtable
</cfquery>


	<!--- Prompt Table Start --->
	<!--- Tool Tip Dialog --->
	<form id="wht" onClick="return analyseForm(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput query="wht_qry">
	<tr id='a#wht_qry.ot_cou#' onClick="selectRow('a',this.id)">
		<td>
			<input id="aa#wht_qry.ot_cou#" type="radio" name="wht" value="#wht_qry.ot_cou#" #IIF(wht_qry.ot_cou eq employee.whtbl,DE('checked="checked"'),DE(''))#/>
		</td>
		<td>#wht_qry.ot_cou#</td>
		<td>#wht_qry.xpaymthpy#</td>
		<td>#wht_qry.xdaypmth#</td>
		<td>#wht_qry.xdaypmthab#</td>
		<td>#wht_qry.xhrpday_m#</td>
		<td>#wht_qry.xhrpyear#</td>
		<td>#wht_qry.xhrpday_d#</td>
		<td>#wht_qry.xdaypmtha#</td>
		<td>#wht_qry.xdaypmthb#</td>
		<td>#wht_qry.xhrpday_h#</td>
	</tr>
	</cfoutput>
	</table>
	</form>
	
	<form id="wht1" onClick="return analyseForm1(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput query="shf_qry">
	<tr id='a1#shf_qry.shf_cou#' onClick="selectRow('a',this.id)">
		<td>
			<input id="aa1#shf_qry.shf_cou#" type="radio" name="wht1" value="#shf_qry.shf_cou#" #IIF(shf_qry.shf_cou eq employee.shifttbl,DE('checked="checked"'),DE(''))# />
		</td>
		<td>#shf_qry.shf_cou#</td>
		<td>#shf_qry.shf_desp#</td>
	</tr>
	</cfoutput>
	</table>
	</form>
	
	<form id="wht2" onClick="return analyseForm2(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput query="wht_qry">
	<tr id='a2#wht_qry.ot_cou#' onClick="selectRow('a',this.id)">
		<td>
			<input id="aa2#wht_qry.ot_cou#" type="radio" name="wht2" value="#wht_qry.ot_cou#" #IIF(wht_qry.ot_cou eq employee.ottbl,DE('checked="checked"'),DE(''))#/>
		</td>
		<td>#wht_qry.ot_cou#</td>
		<td>#wht_qry.ot_ratio#</td>
		<td>#wht_qry.ot_ratio2#</td>
		<td>#wht_qry.ot_ratio3#</td>
		<td>#wht_qry.ot_ratio4#</td>
		<td>#wht_qry.ot_ratio5#</td>
		<td>#wht_qry.ot_ratio6#</td>
		<td>&nbsp;</td>
		<td>#wht_qry.ot_const#</td>
		<td>#wht_qry.ot_const2#</td>
		<td>#wht_qry.ot_const3#</td>
		<td>#wht_qry.ot_const4#</td>
		<td>#wht_qry.ot_const5#</td>
		<td>#wht_qry.ot_const6#</td>
	</tr>
	</cfoutput>
	</table>
	</form>
	
	<form id="wht3" onClick="return analyseForm3(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput query="wht_qry">
	<tr id='a3#wht_qry.ot_cou#' onClick="selectRow('a',this.id)">
		<td>
			<input id="aa3#wht_qry.ot_cou#" type="radio" name="wht3" value="#wht_qry.ot_cou#" #IIF(wht_qry.ot_cou eq employee.ottbl,DE('checked="checked"'),DE(''))#/>
		</td>
		<td>#wht_qry.ot_cou#</td>
		<td>#wht_qry.alday1#</td>
		<td>#wht_qry.alday2#</td>
		<td>#wht_qry.alday3#</td>
		<td>#wht_qry.alday4#</td>
		<td>#wht_qry.alday5#</td>
		<td>#wht_qry.alday6#</td>
		<td>#wht_qry.alday7#</td>
		<td>#wht_qry.alday8#</td>
		<td>#wht_qry.alday9#</td>
		<td>#wht_qry.alday10#</td>
		<td>&nbsp;</td>
		<td>#wht_qry.mcday1#</td>
		<td>#wht_qry.mcday2#</td>
		<td>#wht_qry.mcday3#</td>
		<td>#wht_qry.mcday4#</td>
		<td>#wht_qry.mcday5#</td>
		<td>#wht_qry.mcday6#</td>
	</tr>
	</cfoutput>
	</table>
	</form>
	
	<form id="whtN1" onClick="return analyseForm4(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput query="wht_qry">
	<tr id='a4#wht_qry.ot_cou#' onClick="selectRow('a',this.id)">
		<td>
			<input id="aa4#wht_qry.ot_cou#" type="radio" name="whtN1" value="#wht_qry.ot_cou#" #IIF(wht_qry.ot_cou eq employee.fwlevytbl,DE('checked="checked"'),DE(''))# />
		</td>
		<td>#wht_qry.ot_cou#</td>
		<td>&nbsp;</td>
		<td>#wht_qry.levy_m#</td>
		<td>#wht_qry.levy_d#</td>
	</tr>
	</cfoutput>
	</table>
	</form>
	
	<!--- Prompt Table End --->
	<div class="mainTitle">Personnel File Maintenance</div>
	<cfinclude template="/personnel/employee/employeeHeader.cfm">
	<!--- <cfif event.isArgDefined("message")><p style="color:red;"><cfoutput>#event.getArg("message")#</cfoutput></p></cfif>
	<cfif structCount(employee.Errors) > 		
	<br>
	<div style="color: red;">
	<cfset formErrors = employee.Errors >
	<cfloop collection="#formerrors#" item="errorKey">
		<cfoutput>#formErrors[errorKey]#</cfoutput><br/>
	</cfloop>
	</div>	
	<br>	
	</cfif> --->
	<cfoutput>
	<cfform name="eForm" action="/personnel/employee/act.cfm?type=update" method="post">
	<div class="tabber">
		<div class="tabbertab">
			<h3>Personal Detail</h3>
			<table class="form" border="0">
			<tr>
				<th>Emp No.</th>
				<td><input type="text" name="empno" value="#employee.empno#" size="6" maxlength="6" readonly/></td>
				<th>Name</th>
				<td colspan="3"><input type="text" name="name" value="#employee.name#" size="45" maxlength="45" /></td>
				<th>Initial</th>
				<td><input type="text" name="iname" value="#employee.iname#" size="3" maxlength="3" /></td>
			</tr>
			<tr>
				<th width="22%" colspan="2">Employee Code</th>
				<td width="28%" colspan="3"><input type="text" name="emp_code" value="#employee.emp_code#" size="12" maxlength="12" /></td>
				<th width="22%">I/C No. (Old)</th>
				<td width="28%" colspan="2"><input type="text" name="nric" value="#employee.nric#" size="15" maxlength="15" /></td>
			</tr>
			<tr>
				<th colspan="2">Address</th>
				<td colspan="3"><input type="text" name="add1" value="#employee.add1#" size="50" maxlength="50" /></td>
				<th>I/C No. (New)</th>
				<td colspan="2"><input type="text" name="nricn" value="#employee.nricn#" size="15" maxlength="15" /></td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="3"><input type="text" name="add2" value="#employee.add2#" size="50" maxlength="50" /></td>
				<th>I/C Colour</th>
				<td colspan="2"><input type="text" name="iccolor" value="#employee.iccolor#" size="3" maxlength="3" /></td>
			</tr>
			<tr>
				<th colspan="2">Post Code</th>
				<td><input type="text" name="postcode" value="#employee.postcode#" size="6" maxlength="6" /></td>
				<th>Town</th>
				<td><input type="text" name="town" value="#employee.town#" size="15" maxlength="15" /></td>
				<th>Passport No.</th>
				<td colspan="2"><input type="text" name="passport" value="#employee.passport#" size="15" maxlength="15" /></td>
			</tr>
			<tr>
				<th colspan="2">State</th>
				<td><input type="text" name="state" value="#employee.state#" size="15" maxlength="15" /></td>
				<th>Nationality</th>
				<td><div class="resizeSel" style="width:100px">
					<select id="s1_100px" name="national" style="width:100px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
					<cfloop query="country_qry"><option value="#country_qry.ccode#" #IIF(country_qry.ccode eq employee.national,DE('selected'),DE(''))#>#country_qry.ccode# - #country_qry.cname#</option></cfloop>
					</select></div></td>
				<th>Sex</th>
				<td colspan="2"><select name="sex">
								<option value="M" #IIF(employee.sex eq "M",DE('selected'),DE(''))#>Male</option>
								<option value="F" #IIF(employee.sex eq "F",DE('selected'),DE(''))#>Female</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Phone No.</th>
				<td colspan="3"><input type="text" name="phone" value="#employee.phone#" size="50" maxlength="24" /></td>
				<th>Race</th>
				<td colspan="2"><select name="race">
								<cfloop query="race_qry"><option value="#race_qry.racecode#" #IIF(race_qry.racecode eq employee.race,DE('selected'),DE(''))#>#race_qry.racedesp#</option></cfloop>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Highest Edu.</th>
				<td colspan="3"><input type="text" name="edu" value="#employee.edu#" size="50" maxlength="30" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Working Exp.</th>
				<td colspan="3"><input type="text" name="exp" value="#employee.exp#" size="50" maxlength="30" /></td>
				<th>Religion</th>
				<td colspan="2"><select name="relcode">
								<cfloop query="religion_qry"><option value="#religion_qry.relcode#" #IIF(religion_qry.relcode eq employee.relcode,DE('selected'),DE(''))#>#religion_qry.reldesp#</option></cfloop>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Date of Birth</th>
				<td colspan="3"><input type="text" name="dbirth" value="#DateFormat(employee.dbirth, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dbirth);">(dd/mm/yyyy)
				</td>
				<th>Maritial Status</th>
				<td colspan="2">
					<select name="mstatus">
						<option value="S" #IIF(employee.mstatus eq "S",DE('selected'),DE(''))#>Single</option>
						<option value="M" #IIF(employee.mstatus eq "M",DE('selected'),DE(''))#>Married</option>
						<option value="O" #IIF(employee.mstatus eq "O",DE('selected'),DE(''))#>Other</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">Spouse Particular</th>
				<th class="subheader" colspan="3">Permanent Address/Contact</th>
			</tr>
			<tr>
				<th colspan="2">Spouse Name</th>
				<td colspan="3"><input type="text" name="sname" value="#employee.sname#" size="50" maxlength="30" /></td>
				<th>Name</th>
				<td colspan="2"><input type="text" name="econtact" value="#employee.econtact#" size="30" maxlength="24" /></td>
			</tr>
			<tr>
				<th colspan="2">SP. I/C No.</th>
				<td colspan="3"><input type="text" name="snric" value="#employee.snric#" size="15" maxlength="22" /></td>
				<th>Address</th>
				<td colspan="2"><input type="text" name="eadd1" value="#employee.eadd1#" size="30" maxlength="40" /></td>
			</tr>
			<tr>
				<th colspan="2">## Children</th>
				<td colspan="3"><input type="text" name="numchild" value="#employee.numchild#" size="2" maxlength="2" /></td>
				<td></td>
				<td colspan="2"><input type="text" name="eadd2" value="#employee.eadd2#" size="30" maxlength="40" /></td>
			</tr>
			<tr>
				<th colspan="2">## Children (TAX)</th>
				<td colspan="3"><input type="text" name="num_child" value="#employee.num_child#" size="2" maxlength="2" />&nbsp;Below 18 Yrs</td>
				<td></td>
				<td colspan="2"><input type="text" name="eadd3" value="#employee.eadd3#" size="30" maxlength="40" /></td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="3"></td>
				<th>Phone No.</th>
				<td colspan="2"><input type="text" name="etelno" value="#employee.etelno#" size="30" maxlength="24" /></td>
			</tr>
			</table>
		</div>
		<div class="tabbertab">
			<h3>Pay</h3>
			<table class="form" border="0">
			<tr>
				<th width="22%" colspan="2">Job Title</th>
				<td width="28%" colspan="3"><input type="text" name="jtitle" value="#employee.jtitle#" size="40" maxlength="40" /></td>
				<th width="22%">Pay Rate Type</th>
				<td width="28%" colspan="2"><select name="payrtype">
											<option value="M" #IIF(employee.payrtype eq "M",DE('selected'),DE(''))#>Monthly</option>
											<option value="D" #IIF(employee.payrtype eq "D",DE('selected'),DE(''))#>Daily</option>
											<option value="H" #IIF(employee.payrtype eq "H",DE('selected'),DE(''))#>Hourly</option>
											</select></td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="3"></td>
				<th>Pay method</th>
				<td colspan="2"><select name="paymeth">
								<option value="B" #IIF(employee.paymeth eq "B",DE('selected'),DE(''))#>Bank</option>
								<option value="C" #IIF(employee.paymeth eq "C",DE('selected'),DE(''))#>Cash</option>
								<option value="Q" #IIF(employee.paymeth eq "Q",DE('selected'),DE(''))#>Cheque</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Line No.</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s2_150px" name="plineno" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="lineno_qry"><option value="#lineno_qry.lineno#" #IIF(lineno_qry.lineno eq employee.plineno,DE('selected'),DE(''))#>#lineno_qry.lineno# - #lineno_qry.desp#</option></cfloop>
								</select></div></td>
				<th>Pay Status</th>
				<td colspan="2"><select name="paystatus">
								<option value="A" #IIF(employee.paystatus eq "A",DE('selected'),DE(''))#>Active</option>
								<option value="N" #IIF(employee.paystatus eq "N",DE('selected'),DE(''))#>Non-Active</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Branch</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s3_150px" name="brcode" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="branch_qry"><option value="#branch_qry.brcode#" #IIF(branch_qry.brcode eq employee.brcode,DE('selected'),DE(''))#>#branch_qry.brcode# - #branch_qry.brdesp#</option></cfloop>
								</select></div></td>
				<th>Week Pay</th>
				<td colspan="2"><select name="weekpay">
								<option value="Y" #IIF(employee.weekpay eq "Y",DE('selected'),DE(''))#>Yes</option>
								<option value="N" #IIF(employee.weekpay eq "N",DE('selected'),DE(''))#>No</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Department</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s4_150px" name="deptcode" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="department_qry"><option value="#department_qry.deptcode#" #IIF(department_qry.deptcode eq employee.deptcode,DE('selected'),DE(''))#>#department_qry.deptcode# - #department_qry.deptdesp#</option></cfloop>
								</select></div></td>
				<th>Confidential</th>
				<td colspan="2">
				<!--- <select name="tconfig" onChange="document.eForm.config.value=document.eForm.tconfig.options[document.eForm.tconfig.selectedIndex].value" style="position:absolute;width:38px;clip:rect(0 50 22 20)">
								<option value="1">1</option><option value="2">2</option><option value="2">3</option></select> --->
								<input type="text" name="confid" value="#employee.confid#" onChange="document.eForm.tconfig.selectedIndex=-1" maxlength="1" size="2"/></td>
			</tr>
			<tr>
				<th colspan="2">Category</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s5_150px" name="category" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="category_qry"><option value="#category_qry.category#" #IIF(category_qry.category eq employee.category,DE('selected'),DE(''))#>#category_qry.category# - #category_qry.desp#</option></cfloop>
								</select></div></td>
				<th class="subheader" colspan="3">Contract</th>
			</tr>
			<tr>
				<th colspan="2">Project (Account)</th>
				<td colspan="3"><input type="text" name="source" value="#employee.source#" size="10" maxlength="10" /></td>
				<th>Contract</th>
				<td colspan="2"><select name="contract">
								<option value="Y" #IIF(employee.contract eq "Y",DE('selected'),DE(''))#>Yes</option>
								<option value="N" #IIF(employee.contract eq "N",DE('selected'),DE(''))#>No</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Date Commence</th>
				<td colspan="3"><input type="text" name="dcomm" value="#DateFormat(employee.dcomm, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dcomm);">(dd/mm/yyyy)
				</td>
				<th>Contract Valid From</th>
				<td colspan="2"><input type="text" name="contract_f" value="#DateFormat(employee.contract_f, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(contract_f);">(dd/mm/yyyy)
				</td>
			</tr>
			<tr>
				<th colspan="2">Date Confirmed</th>
				<td colspan="3"><input type="text" name="dconfirm" value="#DateFormat(employee.dconfirm, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dconfirm);">(dd/mm/yyyy)
				</td>
				<th>Contract Expired On</th>
				<td colspan="2"><input type="text" name="contract_t" value="#DateFormat(employee.contract_t, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(contract_t);">(dd/mm/yyyy)
				</td>
			</tr>
			<tr>
				<th colspan="2">Date Promoted</th>
				<td colspan="3"><input type="text" name="dpromote" value="#DateFormat(employee.dpromote, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dpromote);">(dd/mm/yyyy)
				</td>
				<th class="subheader" colspan="3">Employment Status</th>
			</tr>
			<tr>
				<th colspan="2">Date Resigned</th>
				<td colspan="3"><input type="text" name="dresign" value="#DateFormat(employee.dresign, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dresign);">(dd/mm/yyyy)</td>
				<th>For Month</th>
				<td colspan="2"><select name="emp_status">
								<option value="">----  Please Select  ----</option>
								<option value="E" #IIF(employee.emp_status eq "E",DE('selected'),DE(''))#>Existing Employee</option>
								<option value="L" #IIF(employee.emp_status eq "L",DE('selected'),DE(''))#>Leaver This Month</option>
								<option value="N" #IIF(employee.emp_status eq "N",DE('selected'),DE(''))#>New Joined</option>
								<option value="O" #IIF(employee.emp_status eq "O",DE('selected'),DE(''))#>Join & Leave This Month</option>
								</select></td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">Basic Rate</th>
				<th>For Year</th>
				<td colspan="2"><select name="cp8dgrp">
								<option value="">----  Please Select  ----</option>
								<option value="O" #IIF(employee.cp8dgrp eq "O",DE('selected'),DE(''))#>Joined Before This Year</option>
								<option value="N" #IIF(employee.cp8dgrp eq "N",DE('selected'),DE(''))#>Joined This Year</option>
								<option value="R" #IIF(employee.cp8dgrp eq "R",DE('selected'),DE(''))#>Resigned This Year</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="3">Basic Rate</th>
				<td colspan="2"><input type="text" name="brate" value="#employee.brate#" size="15" maxlength="9" /></td>
				<th>Employee Type</th>
				<td colspan="2"><select name="emp_type">
								<option value="">----  Please Select  ----</option>
								<option value="P" #IIF(employee.emp_type eq "P",DE('selected'),DE(''))#>Pensionable</option>
								<option value="N" #IIF(employee.emp_type eq "N",DE('selected'),DE(''))#>Non Pensionable</option>
								<option value="A" #IIF(employee.emp_type eq "A",DE('selected'),DE(''))#>Bonus Permanent</option>
								<option value="C" #IIF(employee.emp_type eq "C",DE('selected'),DE(''))#>Contract Service</option>
								<option value="S" #IIF(employee.emp_type eq "S",DE('selected'),DE(''))#>Saver's Plan</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="3">Increment Amount</th>
				<td colspan="2"><input type="text" name="inc_amt" value="#employee.inc_amt#" size="15" maxlength="2" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Increment Date</th>
				<td colspan="2"><input type="text" name="inc_date" value="#DateFormat(employee.inc_date, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(inc_date);">(dd/mm/yyyy)</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Mid Month Increment Amount</th>
				<td colspan="2"><input type="text" name="m_inc_amt" value="#employee.m_inc_amt#" size="15" maxlength="9" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Mid Month Increment Date</th>
				<td colspan="2"><input type="text" name="m_inc_date" value="#DateFormat(employee.m_inc_date, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(m_inc_date);">(dd/mm/yyyy)
				</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			</table>
		</div>
		<div class="tabbertab">
			<h3>Government</h3>
			<table class="form" border="0">
			<tr>
				<th class="subheader" colspan="5">Bank - UNITED OVERSEAS BANK LIMITED</th>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th width="22%" colspan="2">Bank Code</th>
				<td width="28%" colspan="3"><input type="text" name="bankcode" value="#employee.bankcode#" size="12" maxlength="12" /></td>
				<td width="22%"></td>
				<td width="28%" colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Branch Code</th>
				<td colspan="3"><input type="text" name="brancode" value="#employee.brancode#" size="12" maxlength="12" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Branch A/C No.</th>
				<td colspan="3"><input type="text" name="bankaccno" value="#employee.bankaccno#" size="30" maxlength="20" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Category</th>
				<td><div class="resizeSel" style="width:40px">
					<select id="s6_40px" name="bankcat" style="width:40px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
					<cfloop query="acBank_qry"><option value="#acBank_qry.category#" #IIF(employee.bankcat eq acBank_qry.category,DE('selected'),DE(''))#>#acBank_qry.category# - #acBank_qry.org_name#</option></cfloop>
					</select></div></td>
				<th>Payment Mode</th>
				<td><input type="text" name="bankpmode" value="#employee.bankpmode#" size="5" maxlength="5" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Bank IC</th>
				<td colspan="3"><div class="resizeSel" style="width:40px">
								<select id="s7_40px" name="bankic" style="width:40px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="O" #IIF(employee.bankic eq "O",DE('selected'),DE(''))#>O - Use the old Ic No.</option>
								<option value="N" #IIF(employee.bankic eq "N",DE('selected'),DE(''))#>N - Use the new Ic No.</option>
								<option value="P" #IIF(employee.bankic eq "P",DE('selected'),DE(''))#>P - Use the Passport Ic No.</option>
								</select></div></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">CPF</th>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">CPF No.</th>
				<td colspan="3"><input type="text" name="epfno" value="#employee.epfno#" size="25" maxlength="12" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Table</th>
				<td colspan="3"><select name="epftbl">
								<cfloop from="1" to="30" index="i"><option value="#i#" #IIF(employee.epftbl eq i,DE('selected'),DE(''))#>#i#</option></cfloop>
								</select></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Category</th>
				<td colspan="3"><div class="resizeSel" style="width:40px">
								<select id="s8_40px" name="epfcat" style="width:40px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<cfloop query="acEPF_qry"><option value="#acEPF_qry.category#" #IIF(employee.epfcat eq acEPF_qry.category,DE('selected'),DE(''))#>#acEPF_qry.category# - #acEPF_qry.org_name#</option></cfloop>
								<option value="X" #IIF(employee.epfcat eq 'X',DE('selected'),DE(''))#>X - None</option>
								</select></div></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">CPF Ceiling</th>
				<td colspan="3"><input type="text" name="cpf_ceili" value="#employee.cpf_ceili#" size="5" maxlength="5" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">CPF (Yee) Formula</th>
				<td colspan="3"><input type="text" name="epf_fyee" value="#employee.epf_fyee#" size="40" maxlength="40" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">CPF (Yer) Formula</th>
				<td colspan="3"><input type="text" name="epf_fyer" value="#employee.epf_fyer#" size="40" maxlength="40" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">TAX</th>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Branch</th>
				<td colspan="2"><input type="text" name="itaxbran" value="#employee.itaxbran#" size="15" maxlength="15" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Tax No.</th>
				<td colspan="2"><input type="text" name="itaxno" value="#employee.itaxno#" size="30" maxlength="20" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="3"></td>
				<td colspan="2"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Category</th>
				<td colspan="3"><select id="s9_40px" name="itaxcat" style="width:40px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<cfloop query="acTAX_qry"><option value="#acTAX_qry.category#" #IIF(employee.itaxcat eq acTAX_qry.category,DE('selected'),DE(''))#>#acTAX_qry.category# - #acTAX_qry.org_name#</option></cfloop>
								<option value="X" #IIF(employee.itaxcat eq 'X',DE('selected'),DE(''))#>X - None</option>
								</select></td>
				<td colspan="2"></td>
			</tr>
			</table>
		</div>
		<div class="tabbertab">
			<h3>Non-Citizen</h3>
			<table class="form" border="0">
			<tr>
				<th class="subheader" colspan="5">Resident</th>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th width="22%" colspan="2">Resident Status</th>
				<td width="28%" colspan="3"><select name="r_statu">
											<option value=""></option>
											<option value="PR" #IIF(employee.r_statu eq "PR",DE('selected'),DE(''))#>PERMANENT RESIDENT</option>
											<option value="EP" #IIF(employee.r_statu eq "EP",DE('selected'),DE(''))#>EMPLOYMENT PASS</option>
											<option value="WP" #IIF(employee.r_statu eq "WP",DE('selected'),DE(''))#>WORK PERMIT</option>
											</select></td>
				<td width="22%"></td>
				<td width="28%" colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">PR Number</th>
				<td colspan="3"><input type="text" name="pr_num" value="#employee.pr_num#" size="20" maxlength="20" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">PR Since</th>
				<td colspan="3"><input type="text" name="pr_from" value="#DateFormat(employee.pr_from, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(pr_from);">(dd/mm/yyyy)
				</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">Work Permit</th>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Work Permit</th>
				<td colspan="3"><input type="text" name="wpermit" value="#employee.wpermit#" size="20" maxlength="20" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">W.P. Valid From</th>
				<td colspan="3"><input type="text" name="wp_from" value="#DateFormat(employee.wp_from, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wp_from);">(dd/mm/yyyy)
				</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">W.P. Expired On</th>
				<td colspan="3"><input type="text" name="wp_to" value="#DateFormat(employee.wp_to, "dd/mm/yyyy")#" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wp_to);">(dd/mm/yyyy)
				</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Employment Pass</th>
				<td colspan="3"><input type="text" name="emppass" value="#employee.emppass#" size="20" maxlength="15" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">Foreign Worker Levy</th>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Table</th>
				<td colspan="3"><input type="text" name="fwlevytbl" value="#employee.fwlevytbl#" size="2" readonly="yes">
					<img id="whtTriggerN1" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Method</th>
				<td colspan="3"><select name="fwlevymtd" onChange="show_row(this)">
								<option value="M" #IIF(employee.fwlevymtd eq "M",DE('selected'),DE(''))#>Monthly</option>
								<option value="D" #IIF(employee.fwlevymtd eq "D",DE('selected'),DE(''))#>Daily</option>
								</select></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr id="dailyAdj">
				<th colspan="2">Daily Adjustment</th>
				<td colspan="3"><input type="text" name="fwlevyadj" value="#employee.fwlevyadj#" size="6" maxlength="6">Days</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			</table>
		</div>
		<div class="tabbertab">
			<h3>Setting</h3>
			<table class="form" border="0">
			<tr>
				<th class="subheader" colspan="5">Table Setting</th>
				<th class="subheader" colspan="3">Pay By Employer</th>
			</tr>
			<tr>
				<th width="22%" colspan="2">Working Hours Table</th>
				<td width="28%" colspan="3"><input type="text" name="whtbl" value="#employee.whtbl#" size="2" readonly="yes">
					<img id="whtTrigger" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<th width="22%">All CPF Pay By Employer</th>
				<td width="28%" colspan="2"><select name="epfbyer">
											<option value=""></option>
											<option value="Y" #IIF(employee.epfbyer eq "Y",DE('selected'),DE(''))#>Yes</option>
											<option value="N" #IIF(employee.epfbyer eq "N",DE('selected'),DE(''))#>No</option>
											</select></td>
			</tr>
			<tr>
				<td colspan="5"></td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<th colspan="2">Shift Allowance Table</th>
				<td colspan="3"><input type="text" name="shifttbl" value="#employee.shifttbl#" size="2" readonly="yes">
					<img id="whtTrigger1" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Overtime Table</th>
				<td colspan="3"><input type="text" name="ottbl" value="#employee.ottbl#" size="2" readonly="yes">
					<img id="whtTrigger2" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Annual Leave & Medical Leave Table</th>
				<td colspan="3"><input type="text" name="almctbl" value="#employee.almctbl#" size="2" readonly="yes">
					<img id="whtTrigger3" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">1st Half Setting</th>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">1st Half CPF Directly</th>
				<td colspan="3"><select name="epf1hd">
								<option value=""></option>
								<option value="Y" #IIF(employee.epf1hd eq "Y",DE('selected'),DE(''))#>Yes</option>
								<option value="N" #IIF(employee.epf1hd eq "N",DE('selected'),DE(''))#>No</option>
								</select></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<cfloop from=1 to=4 index="i">
			<tr>
				<td colspan="2">&nbsp;</td>
				<td colspan="3"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			</cfloop>
			<tr>
				<th class="subheader" colspan="5">Basic Rate / Basic Pay Setting</th>
				<th class="subheader" colspan="3">Overtime Setting</th>
			</tr>
			<tr>
				<th colspan="2">No. of payment per month</th>
				<td colspan="3"><select name="nppm">
								<option value="0" #IIF(employee.nppm eq "0",DE('selected'),DE(''))#>0 - Based on Parameter Setup</option>
								<option value="1" #IIF(employee.nppm eq "1",DE('selected'),DE(''))#>1 - Pay once a month</option>
								<option value="2" #IIF(employee.nppm eq "2",DE('selected'),DE(''))#>2 - Pay twice a month</option>
								</select></td>
				<th>OT Rate Calculate</th>
				<td colspan="2"><select name="otraterc">
								<option value="R" #IIF(employee.otraterc eq "R",DE('selected'),DE(''))#>Ratio</option>
								<option value="C" #IIF(employee.otraterc eq "C",DE('selected'),DE(''))#>Constant</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Cal.CPF Using Basic Rate Instead Of Basic Pay</th>
				<td colspan="3"><select name="epfbrinsbp">
								<option value=""></option>
								<option value="Y" #IIF(employee.epfbrinsbp eq "Y",DE('selected'),DE(''))#>Yes</option>
								<option value="N" #IIF(employee.epfbrinsbp eq "N",DE('selected'),DE(''))#>No</option>
								</select></td>
				<th>Max Pay to Calculate OT</th>
				<td colspan="2"><select name="ot_maxpay">
								<option value="1" #IIF(employee.ot_maxpay eq "1",DE('selected'),DE(''))#>#general_qry.OD_MAXPAY1#</option>
								<option value="2" #IIF(employee.ot_maxpay eq "2",DE('selected'),DE(''))#>#general_qry.OD_MAXPAY2#</option>
								</select></td>
			</tr>
			<tr>
				<td colspan="5"></td>
				<th class="subheader" colspan="3">Bonus Setting</th>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="3"></td>
				<th>Performance Bonus</th>
				<td colspan="2"><select name="pbonus_mth">
								<cfloop from="0" to="99" index="i"><option value="#i#" #IIF(employee.pbonus_mth eq i,DE('selected'),DE(''))#>#i#</option></cfloop>
								</select></td>
			</tr>
			</table>
		</div>
		<div class="tabbertab">
			<h3>Allowance / Deduction</h3>
			<table class="form" border="0">
			<tr>
				<td>
				<table border="0">
				<tr>
					<th class="subheader" colspan="3">Allowance</th>
				</tr>
				<cfset i=1>
				<cfloop query="aw_qry">
				<tr>
					<th>#i#</th>
					<th width="150px"><cfif #aw_qry.aw_desp# eq "">&nbsp;<cfelse>#aw_qry.aw_desp#</cfif></th>
					<td><input type="text" name="dbaw#(100+i)#" value="#evaluate("employee.dbaw"&(100+i))#" size="5"></td>
				</tr>
				<cfset i=i+1>
				</cfloop>
				</table>
				</td>
				<td>
				<table border="0">
				<tr>
					<th class="subheader" colspan="3">Deduction</th>
					<th class="subheader">Membership No.</th>
				</tr>
				<cfset j=1>
				<cfloop query="ded_qry">
				<tr>
					<th>#j#</th>
					<th width="150px">#ded_qry.ded_desp#</th>
					<td><input type="text" name="dbded#(100+j)#" value="#evaluate("employee.dbded"&(100+j))#" size="5"></td>
					<cfif j gt 10>
						<td><input type="text" name="dedmem#(100+j)#" value="#evaluate("employee.dedmem"&(100+j))#"></td>
					</cfif>
				</tr>
				<cfset j=j+1>
				</cfloop>
				</table>
				</td>
			</tr>
			<!--- <tr>
				<th class="subheader" colspan="3">Allowance</th>
				<th class="subheader" colspan="3">Deduction</th>
				<th class="subheader">Membership No.</th>
			</tr>
			<cfloop from="1" to="17" index="i">
			<tr>
				<th>#i#</th>
				<th width="15%">#aw_qry.aw_desp#</th>
				<td><input type="text" name="dbaw#(100+i)#" value="#evaluate("employee.dbaw"&(100+i))#" size="15" maxlength="12" /></td>
				<cfif i lt 16>
					<th>#i#</th>
					<th width="15%"></th>
					<td><input type="text" name="dbded#(100+i)#" value="#evaluate("employee.dbded"&(100+i))#" size="15" maxlength="12" /></td>
						<cfif i gt 10>
							<td><input type="text" name="dedmem#(100+i)#" value="#evaluate("employee.dedmem"&(100+i))#" size="25" maxlength="12" /></td>
						<cfelse>
							<td></td>
						</cfif>
				<cfelse>
					<td colspan="4"></td>
				</cfif>
			</tr>
			</cfloop> --->
			</table>
		</div>
	</div>
	<br />
	<center>
		<!--- <input type="reset" name="reset" value="Reset"> --->
		<input type="submit" name="save" value="Update Employee">
		<input type="button" name="exit" value="Exit" onclick="window.location='/personnel/employee/employeeMain.cfm'">
	</center>
	<br>
	</cfform>
	</cfoutput>
</body>
</html>