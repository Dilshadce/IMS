<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script src="/scripts/CalendarControl.js" language="javascript"></script>

<cfparam name="invType" default="">
<cfparam name="bylocation" default="">

<cfquery name="getGSetup" datasource="#dts#">
	select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset
	from gsetup
</cfquery>

<cfif lcase(hcomid) eq "nikbra_i">
	<cfset bylocation="Y">
</cfif>

<cfif url.tran eq "SO">
	<cfset bill = "INV,Invoice,DO,Delivery Order">
    <cfset selectedbill="INV">
<cfelseif url.tran eq "PO">
	<cfset bill = "RC,Purchase Receive">
    <cfset selectedbill="RC">
<cfelseif url.tran eq "QUO">
	<cfset bill = "SO,Sales Order,INV,Invoice">
    <cfset selectedbill="SO">
<cfelseif url.tran eq "DO">
	<cfset bill = "INV,Invoice">
    <cfset selectedbill="INV">
</cfif>

<script type="text/javascript">
	
<cfoutput query="getGSetup">
	var oneInv=#getGSetup.invoneset#;
	var oneRc=#getGSetup.rc_oneset#;
	var onePr=#getGSetup.pr_oneset#;
	var oneDo=#getGSetup.do_oneset#;
	var oneCs=#getGSetup.cs_oneset#;
	var oneCn=#getGSetup.cn_oneset#;
	var oneDn=#getGSetup.dn_oneset#;
	var oneIss=#getGSetup.iss_oneset#;
	var onePo=#getGSetup.po_oneset#;
	var oneSo=#getGSetup.so_oneset#;
	var oneQuo=#getGSetup.quo_oneset#;
	var oneAssm=#getGSetup.assm_oneset#;
	var oneTr=#getGSetup.tr_oneset#;
	var oneOai=#getGSetup.oai_oneset#;
	var oneOar=#getGSetup.oar_oneset#;
	var oneSam=#getGSetup.sam_oneset#;
</cfoutput>

<!--- Multiple Inv changes event End --->
function checkExist(id){
	var type=document.form.ft.value;
	if(type!=""){
		DWREngine._execute(_copyflocation, null,'checkRefnolookup',type,document.getElementById("nextrefno").value,id,checkRefnoResult);
	}
}

function checkRefnoResult(statusObject){
	if(statusObject.EXIST=="yes"){
		alert("This Refno have been used. Please try others.");
		document.getElementById(statusObject.ID).value="";
	}
}

function refresh_to(){
	var value_t = document.form.ft.value;
	changeType("ft_type",value_t);//multiple inv
	changeSize(value_t);
	getLastNum(value_t);
}

function changeType(ID,VALUE){//for multiple inv
	document.getElementById(ID).value = VALUE;
	if(ID == 'ft_type'){
		if(VALUE == 'INV'){
			var typeoneset = oneInv;
		}else if(VALUE == 'RC'){
			var typeoneset = oneRc;
		}else if(VALUE == 'PR'){
			var typeoneset = onePr;
		}else if(VALUE == 'DO'){
			var typeoneset = oneDo;
		}else if(VALUE == 'CS'){
			var typeoneset = oneCs;
		}else if(VALUE == 'CN'){
			var typeoneset = oneCn;
		}else if(VALUE == 'DN'){
			var typeoneset = oneDn;
		}else if(VALUE == 'ISS'){
			var typeoneset = oneIss;
		}else if(VALUE == 'PO'){
			var typeoneset = onePo;
		}else if(VALUE == 'SO'){
			var typeoneset = oneSo;
		}else if(VALUE == 'QUO'){
			var typeoneset = oneQuo;
		}else if(VALUE == 'ASSM'){
			var typeoneset = oneAssm;
		}else if(VALUE == 'TR'){
			var typeoneset = oneTr;
		}else if(VALUE == 'OAI'){
			var typeoneset = oneOai;
		}else if(VALUE == 'OAR'){
			var typeoneset = oneOar;
		}else if(VALUE == 'SAM'){
			var typeoneset = oneSam;
		}
		
		if(typeoneset == 0){
			DWREngine._execute(_copyflocation, null, 'refnosetlookup', typeoneset, VALUE, getRefnosetResult);
		}else{
			change('invt','none');
		}
	}
}

function getRefnosetResult(a){
	change('invt','block');
	DWRUtil.removeAllOptions("ft_invtype");
	DWRUtil.addOptions("ft_invtype", a,"KEY", "VALUE");
}

function changeSize(TYPE){
	var to = document.form.nextrefno;
	if(TYPE == "SO" || TYPE == "PO" || TYPE == "QUO"){
		to.size="25";
		to.maxLength="25";
		to.value="zzzzzzzzzzzzzzzzzzzzzzzz";
	}else{
		to.size="20";
		to.maxLength="24";
		to.value="zzzzzzzz";
	}
}

function getLastNum(type){getArunStatus(type,'1');}

function getLastNumResult(numObject){DWRUtil.setValue("nextrefno", numObject.LASTNUM);}

function getArunStatus(type,count){
	if(type == 'INV'){
		var typeoneset = oneInv;
	}else if(type == 'RC'){
		var typeoneset = oneRc;
	}else if(type == 'PR'){
		var typeoneset = onePr;
	}else if(type == 'DO'){
		var typeoneset = oneDo;
	}else if(type == 'CS'){
		var typeoneset = oneCs;
	}else if(type == 'CN'){
		var typeoneset = oneCn;
	}else if(type == 'DN'){
		var typeoneset = oneDn;
	}else if(type == 'ISS'){
		var typeoneset = oneIss;
	}else if(type == 'PO'){
		var typeoneset = onePo;
	}else if(type == 'SO'){
		var typeoneset = oneSo;
	}else if(type == 'QUO'){
		var typeoneset = oneQuo;
	}else if(type == 'ASSM'){
		var typeoneset = oneAssm;
	}else if(type == 'TR'){
		var typeoneset = oneTr;
	}else if(type == 'OAI'){
		var typeoneset = oneOai;
	}else if(type == 'OAR'){
		var typeoneset = oneOar;
	}else if(type == 'SAM'){
		var typeoneset = oneSam;
	}
	if(typeoneset !="1"){
		DWREngine._execute(_copyflocation, null, 'arunlookup', type, count, getARunResult);
	}else if(type!=""){
		DWREngine._execute(_copyflocation, null, 'arunlookup', type, '1', getARunResult);
	}
}

function getARunResult(arunObject){
	if(arunObject.ARUNSTATUS=="1"){
		if(arunObject.TYPE == 'INV'){
			var typeoneset = oneInv;
		}else if(arunObject.TYPE == 'RC'){
			var typeoneset = oneRc;
		}else if(arunObject.TYPE == 'PR'){
			var typeoneset = onePr;
		}else if(arunObject.TYPE == 'DO'){
			var typeoneset = oneDo;
		}else if(arunObject.TYPE == 'CS'){
			var typeoneset = oneCs;
		}else if(arunObject.TYPE == 'CN'){
			var typeoneset = oneCn;
		}else if(arunObject.TYPE == 'DN'){
			var typeoneset = oneDn;
		}else if(arunObject.TYPE == 'ISS'){
			var typeoneset = oneIss;
		}else if(arunObject.TYPE == 'PO'){
			var typeoneset = onePo;
		}else if(arunObject.TYPE == 'SO'){
			var typeoneset = oneSo;
		}else if(arunObject.TYPE == 'QUO'){
			var typeoneset = oneQuo;
		}else if(arunObject.TYPE == 'ASSM'){
			var typeoneset = oneAssm;
		}else if(arunObject.TYPE == 'TR'){
			var typeoneset = oneTr;
		}else if(arunObject.TYPE == 'OAI'){
			var typeoneset = oneOai;
		}else if(arunObject.TYPE == 'OAR'){
			var typeoneset = oneOar;
		}else if(arunObject.TYPE == 'SAM'){
			var typeoneset = oneSam;
		}
		if(typeoneset !="1"){
			DWREngine._execute(_copyflocation, null, 'lastNumlookup', arunObject.TYPE, arunObject.COUNTER, getLastNumResult);
		}else{
			DWREngine._execute(_copyflocation, null, 'lastNumlookup', arunObject.TYPE, arunObject.COUNTER, getLastNumResult);
		}
		document.getElementById("nextrefno").readOnly=true;
		document.getElementById("nextrefno").style.backgroundColor="#FFFF99";
	}else if(arunObject.ARUNSTATUS=="0"){
		document.getElementById("nextrefno").value="";
		document.getElementById("nextrefno").readOnly=false;
		document.getElementById("nextrefno").style.backgroundColor="";
	}
}

function change(layer_ref,state){ 
	if (document.all){ //IS IE 4 or 5 (or 6 beta) 
	eval( "document.all." + layer_ref + ".style.display = state"); 
	} 
	if (document.layers) { //IS NETSCAPE 4 or below 
	document.layers[layer_ref].display = state; 
	} 
	if (document.getElementById &&!document.all) { 
	hza = document.getElementById(layer_ref); 
	hza.style.display = state; 
	} 
} 

function getRefnoFtRefresh(){
	var type = document.form.ft_type.value;
	var count = document.form.ft_invtype.value;
	document.form.counter.value = document.form.ft_invtype.value;
	getArunStatus(type,count);
}

function init(){
	DWRUtil.useLoadingMessage();
	DWREngine._errorHandler =  errorHandler;
	change('invt','none');
	refresh_to();
}

function validation(){
	//bill selection
	var temp1 = document.form.ft;
	//refno no. (to)
	var temp2 = document.form.nextrefno;
	var temp3 = document.form.f_cdate;

	if(temp1.value == ""){
		alert("Please select one.");
		temp1.focus();
		return false;
	}else if(temp2.value == ""){
		alert("Please fill in.");
		temp2.focus();
		return false;
	}else if(temp2.value=="EMPTY" || temp2.value=="ERROR"){
		alert("ERROR: Please check the last used ref.no number.");
		temp2.focus();
		return false;
	}
	if(temp3.value == ""){
		alert("Please fill in.");
		temp3.focus();
		return false;
	}
	return true;
}
</script>

</head>

<cfinvoke component="CFC.Period" method="getCurrentPeriod" dts="#dts#" returnvariable="cfcPeriod"/>
<body onLoad="init()">
	<h1 align="center">Update Bill</h1>
	<cfoutput>
	<form name="form" action="update1.cfm" method="post" onSubmit="return validation();">
	<input type="hidden" id="counter" name="counter" value="1">
    <input type="hidden" name="fr_type" value="#url.tran#">
    <input type="hidden" name="fr_refno" value="#url.nexttranno#">
    <input type="hidden" name="bylocation" value="#bylocation#">
	<table width="50%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
	<cfif isdefined("url.errorMessage")>
	<tr><td colspan="100%"><h3><cfoutput>#url.errorMessage#</cfoutput></h3>Click <a href="update.cfm">here</a> to refresh.</td></tr>
	<tr><td colspan="100%"><hr></td></tr>
	</cfif>
	<tr>
		<td>
		<fieldset style="border:1px ridge ##ff00ff; padding: 0.5em;">
		<legend style="color: ##ff0000;">To</legend>
			<select name="ft" size="#listlen(bill)/2#" onChange="refresh_to()">
			<cfloop from="1" to="#listlen(bill)#" index="i" step="+2"><option value="#listgetat(bill,i)#" <cfif listgetat(bill,i) eq selectedbill>selected</cfif>>#listgetat(bill,i+1)#</option>
			</cfloop>
			</select>
		</fieldset>
		</td>
	</tr>
	<tr><td colspan="100%"><hr></td></tr>
	<tr><td colspan="100%"><b>To</b></td></tr>
	<tr>
		<td width="25%">Type</td>
		<td width="*">
			<input style="background-color:##FFFF99" id="ft_type" type="text" name="ft_type" size="3" readonly="yes">
			&nbsp;
			<div id="invt">
			<select id="ft_invtype" name="ft_invtype" onChange="getRefnoFtRefresh()">
			
			</select>
			</div>
		</td>
	</tr>
	<tr>
		<td>Ref.No.</td>
		<td>
			<input id="nextrefno" type="text" name="nextrefno" size="9" onKeyUp="checkExist(this.id);">
		</td> 
	</tr>
	<tr>
		<td>Date</td>
		<td><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> 
		<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
		</td>
	</tr>
	<tr>
		<td>Period</td>
		<td><input style="background-color:##FFFF99" type="text" name="f_period" size="2" value="#cfcPeriod#" readonly></td>
	</tr>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td></td>
		<td align="right">
		<input type="submit" name="submit" value="Submit">
		</td>
	</tr>
	</table>
	</form>
	</cfoutput>
</body>
</html>