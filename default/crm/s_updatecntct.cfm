<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	
<script src="../../scripts/CalendarControl.js" language="javascript"></script>

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
	
<script type="text/javascript">
	function updateContract(invno){
		var remark10=document.getElementById("remark10_"+invno).value;
		var remark11=document.getElementById("remark11_"+invno).value;
		checkboxObj=document.getElementById("contract_"+invno);
		if(checkboxObj.checked == true){
			var contract='T';
		}else{
			var contract='';
		}
		document.getElementById("row_"+invno).style.backgroundColor  = 'red';
		DWREngine._execute(_crmflocation, null, 'updateContract', escape(invno), remark10,remark11,contract, showResult);	
	}
		
	function showResult(FieldObject){	
		document.getElementById("row_"+FieldObject.REFNO).style.backgroundColor  = '';
	}
</script>
</head>
<body>

<cfparam name="refno" default="">
<cfparam name="custno" default="">
<cfparam name="custname" default="">
<cfoutput>
	<cfparam name="datefrom" default="#dateformat(now(),'dd/mm/yyyy')#">
	<cfparam name="dateto" default="#dateformat(now(),'dd/mm/yyyy')#">
</cfoutput>

<cfif datefrom neq "">
	<cfset date1 = createDate(ListGetAt(datefrom,3,"/"),ListGetAt(datefrom,2,"/"),ListGetAt(datefrom,1,"/"))>
<cfelse>
	<cfset date1 = createDate(year(now()),month(now()),day(now()))>
</cfif>

<cfif dateto neq "">
	<cfset date2 = createDate(ListGetAt(dateto,3,"/"),ListGetAt(dateto,2,"/"),ListGetAt(dateto,1,"/"))>
<cfelse>
	<cfset date2 = createDate(year(now()),month(now()),day(now()))>
</cfif>

<!--- <cfquery datasource='#dts#' name="getjobs">
	Select * from service_tran 
	where (s_status = "1" or s_status = "2" or s_status = "4")
	<cfif serviceid neq "" and serviceid neq "Service ID">
		and serviceid like '%#serviceid#%'
	</cfif>
	<cfif custno neq "" and custno neq "Customer No">
		and custno like '%#custno#%'
	</cfif>
	<cfif datefrom neq "" and dateto neq "">
		and servicedate between #date1# and #date2#
	</cfif>
	order by servicedate desc, apptime desc, csoid
</cfquery> --->
<cfquery datasource='#dts#' name="getartran">
	Select a.* 
	from artran a
	where (void = '' or void is null) and type='INV'
	<cfif custname neq "" and custname neq "Customer Name">
		and a.name like '#custname#%'
	</cfif>
	<cfif refno neq "" and refno neq "Invoice No.">
		and a.refno like '%#refno#%'
	</cfif>
	<cfif trim(custno) neq "" and custno neq "Customer No">
		and a.custno like '%#trim(custno)#%'
	</cfif>
	<cfif datefrom neq "" and dateto neq "">
		and a.wos_date between #date1# and #date2#
	</cfif>
	order by a.wos_date desc,a.refno desc
</cfquery>
<form name="itemform" action="" method="post">
<table align="center" class="data" width="100%">							
	<tr>
		<th>Invoice No.</th>
		<th>Date</th>
		<th>Customer No</th>
		<th>Name</th>
		<th>Start On</th>
		<th>Expire On</th>
		<th><div align="center">Contract</div></th>
		<th>Action</th>
	</tr>
	<cfoutput query="getartran">
		<tr id="row_#getartran.refno#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><a href="../../billformat/#dts#/transactionformat.cfm?tran=#getartran.type#&nexttranno=#getartran.refno#" target="_blank">#getartran.refno#</a></td>
			<td>#dateformat(getartran.wos_date, "dd/mm/yyyy")#</td>
			<td>#getartran.custno#</td>
			<td>#getartran.name#</td>
			<td>
				<input type="text" name="remark10_#getartran.refno#" value="#getartran.rem10#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark10_#getartran.refno#);">
			</td>
			<td>
				<input type="text" name="remark11_#getartran.refno#" value="#getartran.rem11#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark11_#getartran.refno#);">
			</td>
			<td>
				<div align="center"><input name="contract_#getartran.refno#" type="checkbox" value="T" #iif(getartran.frem9 eq "T",DE("checked"),DE(""))#></div>
			<td>
				<!--- <input type="button" name="updatebtn_#getartran.refno#" value="Update" onclick="updateContract('#getartran.refno#');"> --->
				<img src="../../images/userdefinedmenu/iedit.gif" alt="Edit" style="cursor: hand;" onClick="updateContract('#getartran.refno#');">
				<img src="../../images/userdefinedmenu/view.gif" alt="Contract -Service" style="cursor: hand;" onClick="window.location.href='chkcntct3.cfm?type=#getartran.type#&refno=#getartran.refno#&custno=#getartran.custno#&action_page=s_updatecntct.cfm';">
			</td>
		</tr>
	</cfoutput>
</table>
</form>
</body>
</html>
