<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/scripts/date_format.js"></script>

<script type="text/javascript">

function searchRecord(){
	var serviceid = document.itemform.serviceID.value;
	
	var refno = document.itemform.refno.value;
	var custno = document.itemform.custno.value;
	var vehino = document.itemform.vehino.value;
	var datefrom = document.itemform.datefrom.value;
	var dateto = document.itemform.dateto.value;

	document.getElementById('itemframe').src = 'screatejob_similar.cfm?serviceid=' + serviceid + '&refno=' + refno + '&vehino=' + vehino + '&custno=' + custno + '&datefrom=' + datefrom + '&dateto=' + dateto ;

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

<form name="itemform">
	<h1>Search By : </h1> 
	<input type="text" name="serviceID" value="Service ID" onChange="if(this.value == ''){this.value='Service ID'}" onClick="if(this.value == 'Service ID'){this.value=''}" onBlur="if(this.value == ''){this.value='Service ID'}" size="10">&nbsp;&nbsp;
    <input type="text" name="refno" value="Invoice No" onChange="if(this.value == ''){this.value='Invoice No'}" onClick="if(this.value == 'Invoice No'){this.value=''}" onBlur="if(this.value == ''){this.value='Invoice No'}" size="15">&nbsp;&nbsp;
	<input type="text" name="custno" value="Customer No" onChange="if(this.value == ''){this.value='Customer No'}" onClick="if(this.value == 'Customer No'){this.value=''}" onBlur="if(this.value == ''){this.value='Customer No'}" size="15">&nbsp;&nbsp;
	<input type="text" name="vehino" value="Vehicle No" onChange="if(this.value == ''){this.value='Vehicle No'}" onClick="if(this.value == 'Vehicle No'){this.value=''}" onBlur="if(this.value == ''){this.value='Vehicle No'}" size="15">&nbsp;&nbsp;
	<cfoutput>
	Date of Service:
	<input type="text" name="datefrom" value="#dateformat(now(),"dd/mm/yyyy")#" size="15" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> To 
	<input type="text" name="dateto" value="#dateformat(now(),"dd/mm/yyyy")#" size="15" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');">&nbsp;&nbsp;
	</cfoutput>
	<input type="button" value="Submit" onClick="searchRecord();">
</form>
<iframe align="middle" scrolling="auto" frameborder="0" width="100%" height="700" src="screatejob_similar.cfm" id="itemframe"></iframe>
</body>
</html>
