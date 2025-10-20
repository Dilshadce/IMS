<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>View Contract - Service</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<script type="text/javascript">

function updateContract(){
	var tran=document.form.type.value;
	var refno=document.form.refno.value;
	var custno=document.form.custno.value;
	var service=document.form.service.value;
	var qty=document.form.qty.value;
	var unit=document.form.unit.value;
	var action_type=document.form.action_type.value;
	
	if(action_type =='addnew'){
		DWREngine._execute(_crmflocation, null, 'addContractService', tran, refno, custno, escape(service),qty,unit, showResult);
	}
	else if(action_type =='edit'){
		DWREngine._execute(_crmflocation, null, 'editContractService', tran, refno, custno, escape(service),qty,unit, showResult);
	}
	else{
		DWREngine._execute(_crmflocation, null, 'deleteContractService', tran, refno, custno, escape(service), showResult);
	}
}

function showResult(status){
	if(status!=''){
		alert(status);
	}
	else{
		window.location.reload();
	}	
}

function deleteAction(service,qty){
	if (confirm("Are you sure you want to Delete?")) {
		document.form.action_type.value='delete';
		document.getElementById("typecol").innerHTML='<input name="service" value="" type="text" size="30" readonly>';
		document.form.service.value=service;
		updateContract();
	}	
}

function updateAction(service,servidesp,qty,unit){
	document.form.action_type.value='edit';
	document.getElementById("typecol").innerHTML='<input name="service" value="" type="hidden"><input name="servidesp" value="" type="text" size="30" readonly>';
	document.form.service.value=service;
	document.form.servidesp.value=servidesp;
	document.form.qty.value=qty;
	document.form.unit.value=unit;
}

</script>

</head>
<cfquery name="getuom" datasource="#dts#">
	Select * from unit 
</cfquery>

<cfquery name="getct" datasource="#dts#">
	Select * from artran 
	where custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
	and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = "INV"
</cfquery>

<cfif getct.recordcount GT 0>
	<cfif getct.rem10 neq "" and getct.rem11 neq "">
		<cfset duedate=createDate(ListGetAt(getct.rem11,3,"/"),ListGetAt(getct.rem11,2,"/"),ListGetAt(getct.rem11,1,"/"))>
	<cfelse>
		<cfset duedate = DateAdd("d", 372 , getct.wos_date)>
	</cfif>
	<cfset duedate2 = datediff("d", now(), duedate)>
<cfelse>
	<cfset duedate = 0>
	<cfset duedate2 =0>
</cfif>

<cftry>
	<cfquery name="getcont_service" datasource="#dts#">
		select a.*,b.desp as servicedesp from contract_service a,icservi b
		where a.servi=b.servi
		and a.type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
		and a.refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
		and a.custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#">
	</cfquery>
<cfcatch type="any">
	Please Check With the System Administrator.
	<cfabort>
</cfcatch>
</cftry>

<body>
<cfoutput>
<h2>Contract - Service</h2>

<div align="center">
<table width="60%" border="0">
	<tr bgcolor="##CCCCCC"> 
    	<td colspan="2"><h1 align="center">Customer Information</h1></td>
   	</tr>
    <tr> 
      	<td width="75%" align="left"><strong><font size="2">Customer Name:</font></strong> #getct.name#</td>
    </tr>
	<tr> 
    	<td align="left"><strong><font size="2">Invoice No:</font></strong> #url.refno#</td>
    </tr>
	<tr> 
    	<td align="left"><strong><font size="2">Date Of Purchace:</font></strong> - #dateformat(getct.wos_date,"dd/mm/yyyy")#</td>
    </tr>
	<cfif getct.recordcount gt 0 and duedate2 gte 1>
    <tr> 
    	<td align="left"><strong><font size="2">Contract Valid Till:</font></strong> - #dateformat(duedate,"dd/mm/yyyy")# - (#duedate2# days)</td>
    </tr>
	</cfif>
</table>
</div>	
<br>	
<cfquery name="getservi" datasource="#dts#">
	select servi,(select desp from icservi where servi=service_type.servi) as servicedesp from service_type where servi <> '' group by servi
</cfquery>
<form name="form" action="" method="post">
	<input type="hidden" name="action_type" value="addnew">
	<input type="hidden" name="type" value="#url.type#">
	<input type="hidden" name="refno" value="#url.refno#">
	<input type="hidden" name="custno" value="#url.custno#">
	<table align="center" class="data"width="40%">
		<tr>
			<th width="*">Service</th>
			<th width="20%">Qty</th>
            <th width="20%">Unit</th>
			<th width="20%"><div align="center">Action</div></th>
		</tr>
		<tr>
			<td id="typecol">
				<select name="service">
					<cfloop query="getservi">
						<option value="#getservi.servi#">#getservi.servicedesp#</option>
					</cfloop>
				</select>
			</td>
			<td><input type="text" name="qty" size="5"></td>
            <td>
				<select name="unit">
                	<option value="">Please select unit</option>
					<cfloop query="getuom">
						<option value="#getuom.unit#">#getuom.unit#</option>
					</cfloop>
				</select>
			</td>
			<td><input type="button" value="Save" onclick="updateContract();"></td>
		</tr>
	</table>
	<br>
	<table align="center" class="data" width="40%">
		<tr>
			<th width="*">Service</th>
			<th width="20%">Qty</th>
            <th width="20%">Unit</th>
			<th width="20%"><div align="center">Action</div></th>
		</tr>
		<cfloop query="getcont_service">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='e6e6fa';">
				<td>#getcont_service.servicedesp#</td>
				<td><div align="center">#getcont_service.qty#</div></td>
                <td><div align="center">#getcont_service.unit#</div></td>
				<td><div align="center">
				<img src="/images/userdefinedmenu/iedit.gif" alt="Edit" style="cursor: hand;" onclick="updateAction('#getcont_service.servi#','#getcont_service.servicedesp#','#getcont_service.qty#','#getcont_service.unit#');">
				<img src="/images/userdefinedmenu/idelete.gif" alt="Delete" style="cursor: hand;" onclick="deleteAction('#getcont_service.servi#','#getcont_service.qty#');">
				</div></td>		  
			</tr>
		</cfloop>
	</table>
	<br>
	<div align="center"><input type="button" name="Submit2" value="Back" onclick="history.go(-1);"></div>
</form>	
</cfoutput>
<br>
	
</body>
</html>
