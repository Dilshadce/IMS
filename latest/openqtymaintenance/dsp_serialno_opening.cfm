<html>
<head>
<title>Edit Serial No Opening Quantity</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_reply(this.recordset);</script>

</head>
<script type="text/javascript">

function editRecord(serialno,location){
	var itemno = document.form1.itemno.value;
	var opt = 'dialogWidth:400px; dialogHeight:300px; center:yes; scroll:no; status:no';
	window.showModalDialog('dsp_editopeningserial.cfm?itemno='+encodeURIComponent(escape(itemno))+'&serialno='+encodeURIComponent(escape(serialno))+'&location='+location, '',opt);
	window.location.reload();
}

function deleteRecord(serialno,location){
	if (confirm("Are you sure you want to delete?")) {		
		var itemno = document.form1.itemno.value;
 		document.all.feedcontact1.dataurl="databind/act_deleteserialno.cfm?itemno=" + encodeURIComponent(escape(itemno)) + "&oriserialno=" + encodeURIComponent(escape(serialno)) + "&location=" + location + "&counter=";
		//prompt("D",document.all.feedcontact1.dataurl);
		document.all.feedcontact1.charset=document.charset;
		document.all.feedcontact1.reset();
 	}
}

function show_reply(rset){
	rset.MoveFirst();
	window.location.reload();
} 

</script>
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<body>
<h1 align="center">Edit Serial No - Item <font color="red"><cfoutput>#itemno#</cfoutput></font> Opening Quantity</h1>
<h2 align="right"><a href="serialno_opening_qty_maintenance.cfm"><u>Exit</u></a></h2>
<cfquery name="getitemserial" datasource="#dts#">
	select * from iserial
    where itemno = '#itemno#'
    and type='ADD'
    and sign = 1
    order by serialno
</cfquery>
<cfquery name="getgeneral" datasource="#dts#">
select * from gsetup
</cfquery>
<table width="50%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
	<tr>
    	<th width="5%"></th>
		<th width="10%">No.</th>
    	<th width="20%"><cfoutput>#getgeneral.lserial#.</cfoutput></th>
    	<th width="20%">Date</th>
    	<th width="20%"><div align="center">Location</div></th>
    	<th width="25%"><div align="center">Action</div></th>
  	</tr>

<cfoutput query="getitemserial">
	<cfquery name="getused" datasource="#dts#">
		select * from iserial
		where itemno = '#itemno#'
		and sign = '-1'
		and location = '#getitemserial.location#'
		and serialno = '#getitemserial.serialno#'
	</cfquery>
	<tr>
		<td></td>
		<td>#getitemserial.currentrow#.</td>
		<td>#getitemserial.serialno#</td>
		<td>#dateformat(getitemserial.wos_date,"dd-mm-yyyy")#</td>
		<td align="center">#getitemserial.location#</td>
		<td align="center">
			<cfif getused.recordcount neq 0>
				<img src="/images/userdefinedmenu/iedit_disabled.gif" alt="Edit">
				<img src="/images/userdefinedmenu/idelete_disabled.gif" alt="Delete">
			<cfelse>
				<img src="/images/userdefinedmenu/iedit.gif" alt="Edit" style="cursor: hand;" onClick="editRecord('#getitemserial.serialno#','#getitemserial.location#');">
				<img src="/images/userdefinedmenu/idelete.gif" alt="Delete" style="cursor: hand;" onClick="deleteRecord('#getitemserial.serialno#','#getitemserial.location#');">
			</cfif>
		</td>
	</tr>
</cfoutput>
</table>
<form id="form1" name="form1" action="dsp_generateopeningserial.cfm" method="post">
<cfoutput><input type="hidden" name="itemno" id="itemno" value="#convertquote(itemno)#"></cfoutput>
<table align="center">
	<tr align="center">
		<td nowrap>
			<input name="generate" type="submit" value="Generate">
		</td>
	</tr>
</table>
</form>
</body>
</html>
