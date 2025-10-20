<html>
<head>
<title>Add Serial No - Item Record</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../../scripts/date_format.js"></script>
<script type='text/javascript' src='../../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../../ajax/core/settings.js'></script>

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_reply(this.recordset);</script>

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact2" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact2" event="ondatasetcomplete">show_info(this.recordset);</script>

<script type="text/javascript">

function generate(){
	//document.getElementById('MyID').innerHTML = str;
	if(document.itemform.qty.value == ""){
		alert('The Qty should not be empty!');
		return false;
	}
	else{
		document.itemform.btngenerate.disabled = true;
		document.itemform.btnassign.disabled = true;
		document.getElementById('generate').style.display = 'block';
	}
}

function generateSerialNo(){
	var qty = document.itemform.qty.value;
	if(document.itemform2.serialno.value == ""){
		alert('The Start Serial No should not be empty!');
		return false;
	}
	else{
		var startserialno = document.itemform2.serialno.value;
		var itemno = document.itemform.itemno.value;
		var location = document.itemform.location.value;
		var wos_date = document.itemform.wos_date.value;
		DWREngine._execute(_tranflocation, null, 'generateserialno', startserialno, escape(itemno), location, wos_date, qty, reply_generateSerialNo);
	}
}

function reply_generateSerialNo(status){
	var itemno = document.itemform.itemno.value;
	window.location = 'dsp_serialno_opening.cfm?itemno=' + escape(itemno);
}

function assignserial(){
	if(document.itemform.qty.value == ""){
		alert('The Qty should not be empty!');
		return false;
	}
	else{
		var qty = document.itemform.qty.value;	
		document.itemform.qty.disabled = true;
		document.itemform.btngenerate.disabled = true;
		document.itemform.btnassign.disabled = true;
		document.itemform.location.disabled = true;
		document.getElementById('assign').style.display = 'block';
		var tbl = document.getElementById('serialnotable');
	
		for(i=0;i<qty;i++){
			var lastRow = tbl.rows.length;
			var iteration = lastRow;
  			var row = tbl.insertRow(lastRow);
  	
  			// first cell
  			var firstcell = row.insertCell(0);
  			firstcell.style.textAlign = 'center';
  			firstcell.innerHTML = iteration + '.';
  	
  			// second cell
  			var secondcell = row.insertCell(1);
  			var el = document.createElement('input');
  			el.type = 'text';
  			el.name = 'txtRow' + iteration;
  			el.id = 'txtRow' + iteration;
  			el.size = 20;
  			secondcell.appendChild(el);
  			
  			// third cell
  			var thirdcell = row.insertCell(2);
  			thirdcell.id = 'cell' + iteration;
  			thirdcell.align = 'center';
  			var el2 = document.createElement('input');
  			el2.type = 'button';
  			el2.name = 'buttonRow' + iteration;
  			el2.id = 'buttonRow' + iteration;
  			el2.value = 'Add';
  			el2.onclick = new Function('addNew('+iteration+');'); 
  			thirdcell.appendChild(el2);
		}
	}
}

function addNew(counter){
	var a = 'txtRow' + counter;
	if(document.getElementById(a).value == ''){
		alert('Pls insert the Serial No. to Add!');
		return false;
	}
	else{
		var serialno = document.getElementById(a).value;
		var itemno = document.itemform.itemno.value;
		var location = document.itemform.location.value;
		var wos_date = document.itemform.wos_date.value;
		
		document.all.feedcontact1.dataurl="databind/act_insertserialno.cfm?itemno=" + itemno + "&serialno=" + serialno + "&location=" + location + "&wos_date=" + wos_date + "&counter=" + counter;
		//prompt("D",document.all.feedcontact1.dataurl);
		document.all.feedcontact1.charset=document.charset;
		document.all.feedcontact1.reset();
	}
}

function show_reply(rset){
 	rset.MoveFirst();
 	if(rset.fields("error").value != 0){
 		alert(rset.fields("msg").value);
 	}
 	else{
 		var counter = rset.fields("counter").value;
 		var txtboxid = 'txtRow' + counter;
 		var cellid =  'cell' + counter;
 		document.getElementById(txtboxid).disabled = true;
 		document.getElementById(cellid).innerHTML = '<input type="button" value="Edit" onclick="editserial('+counter+');">';
 	}
 }
 
function editserial(counter){
	var txtboxid = 'txtRow' + counter;
	var cellid =  'cell' + counter;
 	document.getElementById(txtboxid).disabled = false;
 	var oritxtboxvalue = document.getElementById(txtboxid).value;
 	document.getElementById(cellid).innerHTML = '<input type="button" value="Edit" onclick="editserial2('+counter+',\''+oritxtboxvalue+'\');">';
}

function editserial2(counter,oriserialno){
	var txtboxid = 'txtRow' + counter;
	if(document.getElementById(txtboxid).value == ''){
		alert('Pls insert the Serial No. to Edit!');
		return false;
	}
	else{
		var itemno = document.itemform.itemno.value;
		var location = document.itemform.location.value;
		
		document.all.feedcontact2.dataurl="databind/act_deleteserialno.cfm?itemno=" + escape(itemno) + "&oriserialno=" + oriserialno + "&location=" + location + "&counter=" + counter;
		//prompt("D",document.all.feedcontact2.dataurl);
		document.all.feedcontact2.charset=document.charset;
		document.all.feedcontact2.reset();
	}
} 

function show_info(rset){
	rset.MoveFirst();
	var itemno = document.itemform.itemno.value;
	var location = document.itemform.location.value;
	var wos_date = document.itemform.wos_date.value;
	var counter = rset.fields("counter").value;
	var txtboxid = 'txtRow' + counter;
	var serialno = document.getElementById(txtboxid).value;
	
	document.all.feedcontact1.dataurl="databind/act_insertserialno.cfm?itemno=" + escape(itemno) + "&serialno=" + serialno + "&location=" + location + "&wos_date=" + wos_date + "&counter=" + counter;
	//prompt("D",document.all.feedcontact1.dataurl);
	document.all.feedcontact1.charset=document.charset;
	document.all.feedcontact1.reset();
}
</script>

</head>
<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<body>
<cfquery name="getlocation" datasource="#dts#">
	select location,desp 
	from iclocation 
	order by location
</cfquery>
<cfoutput>
<h1 align="center">Generate Serial No  - Item <font color="red">#form.itemno#</font> Record</h1>
<h2 align="right"><a href="dsp_serialno_opening.cfm?itemno=#form.itemno#"><u>Exit</u></a></h2>
<form name="itemform">
<input type="hidden" name="itemno" id="itemno" value="#convertquote(form.itemno)#">
<table align="center">
	<tr align="left">
		<th>Location</th>
		<td nowrap>
			<select name="location">
				<option value="">Please Select a Location</option>
				<cfloop query="getlocation">
					<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr align="left">
		<th>Date</th>
		<td nowrap>
			<input type="text" name="wos_date" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');">
		</td>
	</tr>
	<tr align="left">
		<th>Quantity</th>
		<td nowrap>
			<input type="text" name="qty">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" name="btngenerate" id="btngenerate" value="Generate" onclick="generate();">
			<input type="button" name="btnassign" id="btnassign" value="Assign" onclick="assignserial();">
		</td>
	</tr>
</table>
</form>
<div id="generate" style="display:none;">
<form name="itemform2">
<table align="center">
	<tr align="left">
		<th>Start Serial No.</th>
		<td nowrap>
			<input type="text" name="serialno">
			<input type="button" value="OK" onclick="generateSerialNo();">
		</td>
	</tr>
</table>
</form>
</div>
<div id="assign" style="display:none;">
<form name="itemform3">
<table align="center" id="serialnotable">
	<tr align="left">
		<th width="50">No.</th>
		<th width="100">Serial No.</th>
		<th width="50">Action</th>
	</tr>
</table>
<div align="center"><input type="button" value="Finish" onclick="reply_generateSerialNo('')"></div>
</form>
</div>
</cfoutput>
</body>
</html>