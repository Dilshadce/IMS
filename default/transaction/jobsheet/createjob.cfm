<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<script type="text/javascript">
function searchSel(fieldid,textid) {
  var input=document.getElementById(textid).value.toLowerCase();
  var output=document.getElementById(fieldid).options;
  for(var i=0;i<output.length;i++) {
    if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
      output[i].selected=true;
	  break;
      }
    if(document.getElementById(textid).value==''){
      output[0].selected=true;
      }
  }
}

// begin: customer search
function getCust(option){
	var inputtext = document.createjob.searchcust.value;
	DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
}

function getCustResult(custArray){
	DWRUtil.removeAllOptions("custno");
	DWRUtil.addOptions("custno", custArray,"KEY", "VALUE");
}
// end: customer search

function selectlist(itemno,fieldname) {
  document.getElementById(fieldname).value=itemno;
}

</script>

</head>
<body>
	
<h1>Create Job Sheet</h1>
<br>
<h4>
<a href="createjob.cfm?type=Create">Creating New Job Sheet</a> || 
<a href="viewjob.cfm">List all Job Sheet</a> || 
<a href="s_createjob.cfm">Search For Job Sheet</a> ||
</h4>
<hr>

<br>
<cfquery name="getgeneral" datasource="#dts#">
	select filterall from gsetup
</cfquery>
<cfform name="createjob" action="createjob2.cfm" method="post">
	<table align="center" class="data">
		<tr>
			<th>Invoice No</th>
				<cfif isdefined("url.refno")>
					<td><cfoutput><cfinput name="refno" type="text" value="#refno#" required="yes" readonly></cfoutput>
				<cfelse>
					<td><cfoutput><cfinput name="refno" type="text" value="" required="yes" readonly>
					<img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findRefno');" />
					</cfoutput>
				</cfif>

		</tr>
		<tr>
			<td></td>
			<td align="right" nowrap><input name="submit" type="submit" value="Submit"></td>
		</tr>
	</table>
</cfform>

</body>
</html>

<cfwindow center="true" width="900" height="400" name="findRefno" refreshOnShow="true"
        title="Find Refno" initshow="false"
        source="findRefno.cfm?type=INV" />