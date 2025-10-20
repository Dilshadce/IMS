<html>
<head>
<title>Add Serial No - Item Record</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/scripts/date_format.js"></script>
</head>

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_reply(this.recordset);</script>

<script language="JavaScript">
	
function submitaction(){
 	if(document.itemform.serialno.value == ''){
 		alert("The Serial No Cannot Be Empty!");
 		return false;
 	}
 	else{
 		var oriserialno = document.itemform.oriserialno.value;
 		var orilocation = document.itemform.oriloc.value;
 		var serialno = document.itemform.serialno.value;
 		var itemno = document.itemform.itemno.value;
 		var location = document.itemform.location.value;
 		var wos_date = document.itemform.wos_date.value;
 		document.all.feedcontact1.dataurl="databind/act_updateserialno.cfm?itemno=" + encodeURIComponent(escape(itemno)) + "&serialno=" + encodeURIComponent(escape(serialno)) + "&location=" + location + "&wos_date=" + wos_date + "&oriserialno=" + oriserialno + "&orilocation=" + orilocation;
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
 		window.close();
 	}
 }
 
</script>
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<body>
<cfquery name="getlocation" datasource="#dts#">
	select location,desp 
	from iclocation 
	order by location
</cfquery>

<cfquery name="getrecord" datasource="#dts#">
	select * from iserial
	where itemno= '#itemno#'
	and location = '#location#'
	and serialno = '#serialno#'
	and sign = 1
	and type = 'ADD'
	and refno = '000000'
	and trancode = 1
</cfquery>
<cfoutput>
<h1 align="center">Edit Serial No  - Item <font color="red">#itemno#</font> Record</h1>
<form name="itemform">
<input type="hidden" name="itemno" id="itemno" value="#convertquote(itemno)#">
<input type="hidden" name="oriserialno" id="oriserialno" value="#getrecord.serialno#">
<input type="hidden" name="oriloc" id="oriloc" value="#getrecord.location#">
<table align="center">
	<tr align="left">
		<th>Location</th>
		<td nowrap>
			<select name="location">
				<option value="">Please Select a Location</option>
				<cfloop query="getlocation">
					<option value="#getlocation.location#" <cfif getrecord.location eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr align="left">
		<th>Date</th>
		<td nowrap>
			<input type="text" name="wos_date" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');" <cfif getrecord.wos_date neq "">value="#dateformat(getrecord.wos_date,"dd/mm/yyyy")#"</cfif>>
		</td>
	</tr>
	<tr align="left">
		<th>Serial No</th>
		<td nowrap>
			<input type="text" name="serialno" value="#getrecord.serialno#">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" name="submit" value="Submit"  onclick="submitaction();">
		</td>
	</tr>
</table>
</form>
</cfoutput>
</body>
</html>