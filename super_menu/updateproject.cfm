<html>
<head>
<title>Update Transaction Project</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/scripts/date_format.js"></script>

<script type="text/javascript">

function searchRecord(){
	var tran = document.getElementById('tran').value;
	var refno = document.getElementById('refno').value;
	var datefrom = document.getElementById('datefrom').value;
	var dateto = document.getElementById('dateto').value;
	
	document.getElementById('itemframe').src = 's_updateproject.cfm?tran=' + tran + '&refno=' + refno + '&datefrom=' + datefrom + '&dateto=' + dateto;
} 
</script>

</head>
<body>

<h1>Update Project</h1>
<br>

<form name="itemform">
	<h1>Search For : </h1> 
	<select name="tran" id="tran">
		<option value="RC">Purchase Receive</option>
		<option value="PR">Purchase Return</option>
		<option value="DO">Delivery Order</option>
		<option value="INV" selected>Invoice</option>
		<option value="CS">Cash Sales</option>
		<option value="CN">Credit Note</option>
		<option value="DN">Debit Note</option>
		<option value="PO">Purchase Order</option>
		<option value="QUO">Quotation</option>
		<option value="SO">Sales Order</option>
	</select>
	<input type="text" name="refno" id="refno" value="Reference No" onChange="if(this.value == ''){this.value='Reference No'}" onClick="if(this.value == 'Reference No'){this.value=''}" onBlur="if(this.value == ''){this.value='Reference No'}" size="15">&nbsp;&nbsp;
	<cfoutput>
	Date:
	<input type="text" name="datefrom" id="datefrom" value="#dateformat(now(),"dd/mm/yyyy")#" size="15" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> To 
	<input type="text" name="dateto" id="dateto" value="#dateformat(now(),"dd/mm/yyyy")#" size="15" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');">&nbsp;&nbsp;
	</cfoutput>
	<input type="button" value="Submit" onclick="searchRecord();">
</form>
<iframe align="middle" scrolling="auto" frameborder="0" width="100%" height="700" src="s_updateproject.cfm" id="itemframe"></iframe>
</body>
</html>
