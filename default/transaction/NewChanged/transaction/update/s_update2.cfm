<html>
<head>
<title>Update Main Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function checkAll(){
	
	checkboxObj=document.getElementById("tickall");
	
	if(checkboxObj.checked == true){
		 var inputs = document.getElementsByTagName('input');
	   	 var checkboxes = [];
	    for (var i = 0; i < inputs.length; i++) {
	
	        if (inputs[i].type == 'checkbox') {
	        	inputs[i].checked =true;
			}
		}
	}
	else{
		var inputs = document.getElementsByTagName('input');
	   	var checkboxes = [];
	    for (var i = 0; i < inputs.length; i++) {
	
	    	if (inputs[i].type == 'checkbox') {
	        	inputs[i].checked =false;
			}
		}
	}
}
</script>

</head>
<body>

<cfparam name="datefrom" default="">
<cfparam name="dateto" default="">
<cfparam name="invset" default="1">

<cfif datefrom neq "">
	<cfset date1 = createDate(ListGetAt(datefrom,3,"/"),ListGetAt(datefrom,2,"/"),ListGetAt(datefrom,1,"/"))>
<cfelse>
	<cfset date1 = dateadd('M','-1',createDate(year(now()),month(now()),day(now())))>
</cfif>

<cfif dateto neq "">
	<cfset date2 = createDate(ListGetAt(dateto,3,"/"),ListGetAt(dateto,2,"/"),ListGetAt(dateto,1,"/"))>
<cfelse>
	<cfset date2 = createDate(year(now()),month(now()),day(now()))>
</cfif>

<cfif url.t2 eq "INV">
	<cfif url.t1 eq "SO">
		<cfset tranname="Sales Order">
		
		<cfquery datasource='#dts#' name="getData">
			select type,refno,wos_date,fperiod,custno,name 
			from artran 
			where type = '#t1#' and (toinv = '' or toinv is null) 
			and wos_date between #date1# and #date2#
			order by wos_date,refno
		</cfquery>
	</cfif>
<cfelseif url.t2 eq "SAM">
	<cfif url.t1 eq "SO">
		<cfset tranname="Sales Order">
		
		<cfquery datasource='#dts#' name="getData">
			select type,refno,wos_date,fperiod,custno,name 
			from artran 
			where type = '#t1#' and (exported2 = "" or exported2 is null)
            and (void = "" or void is null)
			and wos_date between #date1# and #date2#
			order by wos_date,refno
		</cfquery>
	</cfif>
</cfif>
<form action="s_update_process.cfm" method="post" name="updatepage">
<cfset session.formName="updatepage">
	<cfoutput>
		<input type="hidden" name="t1" value="#url.t1#">
		<input type="hidden" name="t2" value="#url.t2#">
		<input type="hidden" name="invset" value="#invset#">
	</cfoutput>
	<table align="center" class="data" width="65%">							
		<tr>
			<th width="15%"><cfoutput>#tranname#</cfoutput> No.</th>
			<th width="10%">Date</th>
			<th width="10%">Period</th>
			<th width="10%">Customer No</th>
			<th width="45%">Name</th>
			<th width="10%">To Bill&nbsp;<input type="checkbox" name="tickall" id="tickall" onClick="checkAll();"></th>
		</tr>
		<cfoutput query="getData">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td>#getData.refno#</td>
				<td>#dateformat(getData.wos_date, "dd/mm/yyyy")#</td>
				<td>#getData.fperiod#</td>
				<td>#getData.custno#</td>
				<td>#getData.name#</td>
				<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
			</tr>
		</cfoutput>
		<tr>             
          	<td colspan="5">
			<div align="right"><input type="submit" name="Submit" value="Submit"></div>
			</td>
		</tr>
	</table>
</form>
</body>
</html>
