<html>
<head>
	<title>Create/Add Employee</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<script src="/javscripts/resizeSel.js" type="text/javascript"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/includes/xpath.js"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/includes/SpryData.js"></script>
	<script language="JavaScript" type="text/javascript" src="/lib/spry/widgets/tooltip/SpryTooltip.js"></script>
	<script src="/javascripts/CalendarControl.js" language="javascript"> </script>
	
	<link href="/lib/spry/widgets/tooltip/SpryTooltip.css" rel="stylesheet" type="text/css" />
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">

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
	function selectRow(prefix,id){
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
				//var whtTooltip = new Spry.Widget.Tooltip('whtN1', '#whtTriggerN1', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
			};
		}else{
			window.onload = function() {
				oldOnLoad();
				show_row( document.getElementById("fwlevymtd"));
				var whtTooltip = new Spry.Widget.Tooltip('wht', '#whtTrigger', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht1', '#whtTrigger1', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht2', '#whtTrigger2', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				var whtTooltip = new Spry.Widget.Tooltip('wht3', '#whtTrigger3', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
				//var whtTooltip = new Spry.Widget.Tooltip('whtN1', '#whtTriggerN1', {hideDelay: 350, closeOnTooltipLeave: true, offsetX: "10px", offsetY:"-10px"});
			};
		}
	}
	addLoadEvent();
	
	function vali() {
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
	}
</script>
</head>

<body>
<cfquery name="general_qry" datasource="payroll_main">
SELECT COMP_ID, OD_MAXPAY1, OD_MAXPAY2, ccode
FROM gsetup
where comp_id = '#HcomID#'
</cfquery>

<cfquery name="acBank_qry" datasource="#dts#">
SELECT *
FROM address a, dept d
WHERE org_type in ('BANK')
<!--- ORDER BY deptdesp --->
</cfquery>

<cfquery name="acEPF_qry" datasource="#dts#">
SELECT *
FROM address
WHERE org_type in ('EPF')
<!--- ORDER BY deptdesp --->
</cfquery>

<cfquery name="acTAX_qry" datasource="#dts#">
SELECT *
FROM address
WHERE org_type in ('TAX')
<!--- ORDER BY deptdesp --->
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
<!--- <cfif url.type eq "update"><cfif url.type neq "update">
WHERE empno = "#url.empno#"
</cfif> --->
</cfquery>

<cfquery name="aw_qry" datasource="#dts#">
SELECT *
FROM awtable
WHERE aw_cou < 18
</cfquery>

<cfquery name="ded_qry" datasource="#dts#">
SELECT *
FROM dedtable
</cfquery>

<cfquery name="shf_qry" datasource="#dts#">
SELECT *
FROM shftable
</cfquery>

<!--- <cfquery name="pay_qry" datasource="#dts#">
SELECT *
FROM paytra1
</cfquery> --->

	<!--- Prompt Table Start --->
	<!--- Tool Tip Dialog --->
	<form id="wht" onClick="return analyseForm(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput query="wht_qry">
	<tr id='a#wht_qry.ot_cou#' onClick="selectRow('a',this.id)">
		<td>
			<input id="aa#wht_qry.ot_cou#" type="radio" name="wht" value="#wht_qry.ot_cou#"/>
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
	<tr id='a1#shf_qry.shf_cou#' onClick="selectRow('a1',this.id)">
		<td>
			<input id="aa1#shf_qry.shf_cou#" type="radio" name="wht1" value="#shf_qry.shf_cou#"/>
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
	<tr id='a2#wht_qry.ot_cou#' onClick="selectRow('a2',this.id)">
		<td>
			<input id="aa2#wht_qry.ot_cou#" type="radio" name="wht2" value="#wht_qry.ot_cou#"/>
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
	<tr id='a3#wht_qry.ot_cou#' onClick="selectRow('a3',this.id)">
		<td>
			<input id="aa3#wht_qry.ot_cou#" type="radio" name="wht3" value="#wht_qry.ot_cou#"/>
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
	
	<!--- <form id="whtN1" onClick="return analyseForm4(this);" class="tooltipContent" method="get">
	<table border="1">
	<cfoutput query="wht_qry">
	<tr id='a4#wht_qry.ot_cou#' onClick="selectRow('a',this.id)">
		<td>
			<input id="aa4#wht_qry.ot_cou#" type="radio" name="whtN1" value="#wht_qry.ot_cou#"/>
		</td>
		<td>#wht_qry.ot_cou#</td>
		<td>&nbsp;</td>
		<td>#wht_qry.levy_m#</td>
		<td>#wht_qry.levy_d#</td>
	</tr>
	</cfoutput>
	</table>
	</form> --->
	
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
	<cfform name="eForm" action="/personnel/employee/act.cfm?type=create" method="post">
	<div class="tabber">
		<div class="tabbertab">
			<h3>Personal Detail</h3>
			<table class="form" border="0">
			<tr>
				<th>Emp No.</th>
				<td><input type="text" name="empno" value="" size="6" maxlength="6" /></td>
				<th>Name</th>
				<td colspan="3"><input type="text" name="name" value="" size="45" maxlength="45" /></td>
				<th>Initial</th>
				<td><input type="text" name="iname" value="" size="3" maxlength="3" /></td>
			</tr>
			<tr>
				<th width="22%" colspan="2">Employee Code</th>
				<td width="28%" colspan="3"><input type="text" name="emp_code" value="" size="12" maxlength="12" /></td>
				<th width="22%">I/C No. (Old)</th>
				<td width="28%" colspan="2"><input type="text" name="nric" value="" size="15" maxlength="15" /></td>
			</tr>
			<tr>
				<th colspan="2">Address</th>
				<td colspan="3"><input type="text" name="add1" value="" size="50" maxlength="50" /></td>
				<th>I/C No. (New)</th>
				<td colspan="2"><input type="text" name="nricn" value="" size="15" maxlength="15" /></td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="3"><input type="text" name="add2" value="" size="50" maxlength="50" /></td>
				<th>I/C Colour</th>
				<td colspan="2"><input type="text" name="iccolor" value="B" size="3" maxlength="3" /></td>
			</tr>
			<tr>
				<th colspan="2">Post Code</th>
				<td><input type="text" name="postcode" value="" size="6" maxlength="6" /></td>
				<th>Town</th>
				<td><input type="text" name="town" value="" size="15" maxlength="15" /></td>
				<th>Passport No.</th>
				<td colspan="2"><input type="text" name="passport" value="" size="15" maxlength="15" /></td>
			</tr>
			<tr>
				<th colspan="2">State</th>
				<td><input type="text" name="state" value="" size="15" maxlength="15" /></td>
				<th>Nationality</th>
				<td><div class="resizeSel" style="width:100px">
					<select id="s1_100px" name="national" style="width:100px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
					<cfloop query="country_qry">
						<option value="#country_qry.ccode#" #IIF(country_qry.ccode eq general_qry.ccode ,DE('selected'),DE(''))#>#country_qry.ccode# - #country_qry.cname#</option>
					</cfloop>
					</select></div></td>
				<th>Sex</th>
				<td colspan="2"><select name="sex">
								<option value="M">Male</option>
								<option value="F">Female</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Phone No.</th>
				<td colspan="3"><input type="text" name="phone" value="" size="50" maxlength="24" /></td>
				<th>Race</th>
				<td colspan="2"><select name="race">
								<cfloop query="race_qry"><option value="">#race_qry.racedesp#</option></cfloop>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Highest Edu.</th>
				<td colspan="3"><input type="text" name="edu" value="" size="50" maxlength="30" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Working Exp.</th>
				<td colspan="3"><input type="text" name="exp" value="" size="50" maxlength="30" /></td>
				<th>Religion</th>
				<td colspan="2"><select name="relcode">
								<cfloop query="religion_qry"><option value="">#religion_qry.reldesp#</option></cfloop>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Date of Birth</th>
				<td colspan="3"><input type="text" name="dbirth" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dbirth);">(dd/mm/yyyy)
				</td>
				<th>Maritial Status</th>
				<td colspan="2">
					<select name="mstatus">
						<option value="S">Single</option>
						<option value="M">Married</option>
						<option value="O">Other</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">Spouse Particular</th>
				<th class="subheader" colspan="3">Permanent Address/Contact</th>
			</tr>
			<tr>
				<th colspan="2">Spouse Name</th>
				<td colspan="3"><input type="text" name="sname" value="" size="50" maxlength="30" /></td>
				<th>Name</th>
				<td colspan="2"><input type="text" name="econtact" value="" size="30" maxlength="24" /></td>
			</tr>
			<tr>
				<th colspan="2">SP. I/C No.</th>
				<td colspan="3"><input type="text" name="snric" value="" size="15" maxlength="22" /></td>
				<th>Address</th>
				<td colspan="2"><input type="text" name="eadd1" value="" size="30" maxlength="40" /></td>
			</tr>
			<tr>
				<th colspan="2">## Children</th>
				<td colspan="3"><input type="text" name="numchild" value="0" size="2" maxlength="2" /></td>
				<td></td>
				<td colspan="2"><input type="text" name="eadd2" value="" size="30" maxlength="40" /></td>
			</tr>
			<tr>
				<th colspan="2">## Children (TAX)</th>
				<td colspan="3"><input type="text" name="num_child" value="0" size="2" maxlength="2" />&nbsp;Below 18 Yrs</td>
				<td></td>
				<td colspan="2"><input type="text" name="eadd3" value="" size="30" maxlength="40" /></td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="3"></td>
				<th>Phone No.</th>
				<td colspan="2"><input type="text" name="etelno" value="" size="30" maxlength="24" /></td>
			</tr>
			</table>
		</div>
		<div class="tabbertab">
			<h3>Pay</h3>
			<table class="form" border="0">
			<tr>
				<th width="22%" colspan="2">Job Title</th>
				<td width="28%" colspan="3"><input type="text" name="jtitle" size="40" maxlength="40" /></td>
				<th width="22%">Pay Rate Type</th>
				<td width="28%" colspan="2"><select name="payrtype">
											<option value="M">Monthly</option>
											<option value="D">Daily</option>
											<option value="H">Hourly</option>
											</select></td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="3"></td>
				<th>Pay method</th>
				<td colspan="2"><select name="paymeth">
								<option value="B">Bank</option>
								<option value="C">Cash</option>
								<option value="Q">Cheque</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Line No.</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s2_150px" name="plineno" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="lineno_qry"><option value="#lineno_qry.lineno#">#lineno_qry.lineno# - #lineno_qry.desp#</option></cfloop>
								</select></div></td>
				<th>Pay Status</th>
				<td colspan="2"><select name="paystatus">
								<option value="A">Active</option>
								<option value="N">Non-Active</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Branch</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s3_150px" name="brcode" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="branch_qry"><option value="#branch_qry.brcode#">#branch_qry.brcode# - #branch_qry.brdesp#</option></cfloop>
								</select></div></td>
				<th>Week Pay</th>
				<td colspan="2"><select name="weekpay">
								<option value="Y">Yes</option>
								<option value="N">No</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Department</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s4_150px" name="deptcode" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="department_qry"><option value="#department_qry.deptcode#">#department_qry.deptcode# - #department_qry.deptdesp#</option></cfloop>
								</select></div></td>
				<th>Confidential</th>
				<td colspan="2">
								<select name="confid">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</select>
				<!--- <select name="tconfig" onChange="document.eForm.config.value=document.eForm.tconfig.options[document.eForm.tconfig.selectedIndex].value" style="position:absolute;width:38px;clip:rect(0 50 22 20)">
								<option value="1">1</option><option value="2">2</option><option value="2">3</option></select> --->
								<!--- <input type="text" name="confid" value="" onChange="document.eForm.tconfig.selectedIndex=-1" maxlength="1" size="2"/> --->
				</td>
			</tr>
			<tr>
				<th colspan="2">Category</th>
				<td colspan="3"><div class="resizeSel" style="width:150px">
								<select id="s5_150px" name="category" style="width:150px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="">----  Please Select  ----</option>
								<cfloop query="category_qry"><option value="#category_qry.category#">#category_qry.category# - #category_qry.desp#</option></cfloop>
								</select></div></td>
				<th class="subheader" colspan="3">Contract</th>
			</tr>
			<tr>
				<th colspan="2">Project (Account)</th>
				<td colspan="3"><input type="text" name="source" value="" size="10" maxlength="10" /></td>
				<th>Contract</th>
				<td colspan="2"><select name="contract">
								<option value="Y">Yes</option>
								<option value="N">No</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Date Commence</th>
				<td colspan="3"><input type="text" name="dcomm" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dcomm);">(dd/mm/yyyy)
				</td>
				<th>Contract Valid From</th>
				<td colspan="2"><input type="text" name="contract_f" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(contract_f);">(dd/mm/yyyy)
				</td>
			</tr>
			<tr>
				<th colspan="2">Date Confirmed</th>
				<td colspan="3"><input type="text" name="dconfirm" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dconfirm);">(dd/mm/yyyy)
				</td>
				<th>Contract Expired On</th>
				<td colspan="2"><input type="text" name="contract_t" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(contract_t);">(dd/mm/yyyy)
				</td>
			</tr>
			<tr>
				<th colspan="2">Date Promoted</th>
				<td colspan="3"><input type="text" name="dpromote" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dpromote);">(dd/mm/yyyy)
				</td>
				<th class="subheader" colspan="3">Employment Status</th>
			</tr>
			<tr>
				<th colspan="2">Date Resigned</th>
				<td colspan="3"><input type="text" name="dresign" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dresign);">(dd/mm/yyyy)
				</td>
				<th>For Month</th>
				<td colspan="2"><select name="emp_status">
								<option value="">----  Please Select  ----</option>
								<option value="E">Existing Employee</option>
								<option value="L">Leaver This Month</option>
								<option value="N">New Joined</option>
								<option value="O">Join & Leave This Month</option>
								</select></td>
			</tr>
			<tr>
				<th class="subheader" colspan="5">Basic Rate</th>
				<th>For Year</th>
				<td colspan="2"><select name="cp8dgrp">
								<option value="">----  Please Select  ----</option>
								<option value="O">Joined Before This Year</option>
								<option value="N">Joined This Year</option>
								<option value="R">Resigned This Year</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="3">Basic Rate</th>
				<td colspan="2"><input type="text" name="brate" value="0.00" size="15" maxlength="9" /></td>
				<th>Employee Type</th>
				<td colspan="2"><select name="emp_type">
								<option value="">----  Please Select  ----</option>
								<option value="P">Pensionable</option>
								<option value="N">Non Pensionable</option>
								<option value="A">Bonus Permanent</option>
								<option value="C">Contract Service</option>
								<option value="S">Saver's Plan</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="3">Increment Amount</th>
				<td colspan="2"><input type="text" name="inc_amt" value="0.00" size="15" maxlength="2" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Increment Date</th>
				<td colspan="2"><input type="text" name="inc_date" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(inc_date);">(dd/mm/yyyy)
				</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Mid Month Increment Amount</th>
				<td colspan="2"><input type="text" name="m_inc_amt" value="0.00" size="15" maxlength="9" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Mid Month Increment Date</th>
				<td colspan="2"><input type="text" name="m_inc_date" value="" size="10" maxlength="10" />
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
				<td width="28%" colspan="3"><input type="text" name="bankcode" value="" size="12" maxlength="12" /></td>
				<td width="22%"></td>
				<td width="28%" colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Branch Code</th>
				<td colspan="3"><input type="text" name="brancode" value="" size="12" maxlength="12" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Branch A/C No.</th>
				<td colspan="3"><input type="text" name="bankaccno" value="" size="30" maxlength="20" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Category</th>
				<td><div class="resizeSel" style="width:40px">
					<select id="s6_40px" name="bankcat" style="width:40px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
					<cfloop query="acBank_qry"><option value="">#acBank_qry.category# - #acBank_qry.org_name#</option></cfloop>
					</select></div></td>
				<th>Payment Mode</th>
				<td><input type="text" name="bankpmode" value="" size="5" maxlength="5" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Bank IC</th>
				<td colspan="3"><div class="resizeSel" style="width:40px">
								<select id="s7_40px" name="bankic" style="width:40px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<option value="O" >O - Use the old Ic No.</option>
								<option value="N" >N - Use the new Ic No.</option>
								<option value="P" >P - Use the Passport Ic No.</option>
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
				<td colspan="3"><input type="text" name="epfno" value="" size="25" maxlength="12" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Table</th>
				<td colspan="3"><select name="epftbl">
								<cfloop from="1" to="30" index="i"><option value="#i#" >#i#</option></cfloop>
								</select></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Category</th>
				<td colspan="3"><div class="resizeSel" style="width:40px">
								<select id="s8_40px" name="epfcat" style="width:40px;" onmouseover="resize(this.id);" onclick="hold(this.id);" onChange="resize(this.id);">
								<cfloop query="acEPF_qry"><option value="#acEPF_qry.category#" >#acEPF_qry.category# - #acEPF_qry.org_name#</option></cfloop>
								<option value="X" >X - None</option>
								</select></div></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">CPF Ceiling</th>
				<td colspan="3"><input type="text" name="cpf_ceili" value="0" size="5" maxlength="5" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">CPF (Yee) Formula</th>
				<td colspan="3"><input type="text" name="epf_fyee" value="" size="40" maxlength="40" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">CPF (Yer) Formula</th>
				<td colspan="3"><input type="text" name="epf_fyer" value="" size="40" maxlength="40" /></td>
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
				<td colspan="2"><input type="text" name="itaxbran" value="" size="15" maxlength="15" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="3">Tax No.</th>
				<td colspan="2"><input type="text" name="itaxno" value="" size="30" maxlength="20" /></td>
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
								<cfloop query="acTAX_qry"><option value="#acTAX_qry.category#" >#acTAX_qry.category# - #acTAX_qry.org_name#</option></cfloop>
								<option value="X" >X - None</option>
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
											<option value="PR" >PERMANENT RESIDENT</option>
											<option value="EP" >EMPLOYMENT PASS</option>
											<option value="WP" >WORK PERMIT</option>
											</select></td>
				<td width="22%"></td>
				<td width="28%" colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">PR Number</th>
				<td colspan="3"><input type="text" name="pr_num" value="" size="20" maxlength="20" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">PR Since</th>
				<td colspan="3"><input type="text" name="pr_from" value="" size="10" maxlength="10" />
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
				<td colspan="3"><input type="text" name="wpermit" value="" size="20" maxlength="20" /></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">W.P. Valid From</th>
				<td colspan="3"><input type="text" name="wp_from" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wp_from);">(dd/mm/yyyy)
				</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">W.P. Expired On</th>
				<td colspan="3"><input type="text" name="wp_to" value="" size="10" maxlength="10" />
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wp_to);">(dd/mm/yyyy)
				</td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Employment Pass</th>
				<td colspan="3"><input type="text" name="emppass" value="" size="20" maxlength="15" /></td>
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
				<td colspan="3">
					<!--- <input type="text" name="fwlevytbl" value="#employee.fwlevytbl#" size="2" readonly="yes">
					<img id="whtTriggerN1" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"> --->
								<select name="fwlevytbl">
									<option value=""></option>
								<cfloop query="wht_qry">
									<option value="">#wht_qry.ot_cou# &nbsp;&nbsp;&nbsp;&nbsp; #wht_qry.levy_m# | #wht_qry.levy_d#</option>
								</cfloop>
								</select></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Method</th>
				<td colspan="3"><select name="fwlevymtd" onChange="show_row(this)">
								<option value="M" >Monthly</option>
								<option value="D" >Daily</option>
								</select></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr id="dailyAdj">
				<th colspan="2">Daily Adjustment</th>
				<td colspan="3"><input type="text" name="fwlevyadj" value="" size="6" maxlength="6">Days</td>
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
				<th width="280" colspan="2">Working Hours Table</th>
				<td width="210" colspan="3"><input type="text" name="whtbl" value="1" size="2" readonly="yes">
					<img id="whtTrigger" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<th width="150">All CPF Pay By Employer</th>
				<td width="80" colspan="2"><select name="epfbyer">
											<option value=""></option>
											<option value="Y" >Yes</option>
											<option value="N" >No</option>
											</select></td>
			</tr>
			<tr>
				<td colspan="5"></td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<th colspan="2">Shift Allowance Table</th>
				<td colspan="3"><input type="text" name="shifttbl" value="1" size="2" readonly="yes">
					<img id="whtTrigger1" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Overtime Table</th>
				<td colspan="3"><input type="text" name="ottbl" value="1" size="2" readonly="yes">
					<img id="whtTrigger2" src="/images/edit.ICO" style="background:inherit; width:15px; height:15px"></td>
				<td></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<th colspan="2">Annual Leave & Medical Leave Table</th>
				<td colspan="3"><input type="text" name="almctbl" value="1" size="2" readonly="yes">
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
								<option value="Y" >Yes</option>
								<option value="N" >No</option>
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
								<option value="0" >0 - Based on Parameter Setup</option>
								<option value="1" >1 - Pay once a month</option>
								<option value="2" >2 - Pay twice a month</option>
								</select></td>
				<th>OT Rate Calculate</th>
				<td colspan="2"><select name="otraterc">
								<option value="R" >Ratio</option>
								<option value="C" >Constant</option>
								</select></td>
			</tr>
			<tr>
				<th colspan="2">Cal.CPF Using Basic Rate Instead Of Basic Pay</th>
				<td colspan="3"><select name="epfbrinsbp">
								<option value=""></option>
								<option value="Y" >Yes</option>
								<option value="N" >No</option>
								</select></td>
				<th>Max Pay to Calculate OT</th>
				<td colspan="2"><select name="ot_maxpay">
								<option value="1">#general_qry.OD_MAXPAY1#</option>
								<option value="2">#general_qry.OD_MAXPAY2#</option>
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
								<cfloop from="0" to="99" index="i"><option value="#i#" >#i#</option></cfloop>
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
					<td><input type="text" name="dbaw#(100+i)#" value="" size="5"></td>
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
					<td><input type="text" name="dbded#(100+j)#" value="" size="5"></td>
					<cfif j gt 10>
						<td><input type="text" name="dedmem#(100+j)#" value=""></td>
					</cfif>
				</tr>
				<cfset j=j+1>
				</cfloop>
				</table>
				</td>
			</tr>
			<!--- <table class="form" border="0">
			<tr>
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
					<th width="15%">#ded_qry.ded_desp#</th>
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
		<input type="reset" name="reset" value="Reset">
		<input type="submit" name="save" value="Add Employee">
		<input type="button" name="exit" value="Exit" onclick="window.location='/personnel/employee/employeeMain.cfm'">
	</center>
	<br>
	</cfform>
	</cfoutput>
</body>
</html>