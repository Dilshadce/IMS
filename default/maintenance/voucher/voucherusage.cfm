<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery>
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>
<cfquery name="getcust" datasource="#dts#">
	select custno, name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
</cfquery> 

<html>
<head>
	<title>Cust/Supp/Agent/Area Item Report By Type</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<script type="text/javascript">

// begin: supplier search
function getSupp(type,option){
	if(type == 'custfrom'){
		var inputtext = document.voucherusage.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.voucherusage.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult2);
	}
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", suppArray,"KEY", "VALUE");
}

function getSuppResult2(suppArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", suppArray,"KEY", "VALUE");
}
// end: supplier search

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}

</script>
	
</head>

<script src="/scripts/CalendarControl.js" language="javascript"></script>

<body>
<cfoutput>

<h1>Vocher Usage Report</h1>
<h4>
<a href="voucher.cfm">Create Voucher</a>|<a href="p_voucher.cfm">Voucher Listing</a>|<a href="vouchermaintenance.cfm">Voucher Maintenance</a>|<a href="voucherusage.cfm">Voucher Usage Report</a>|<a href="voucherprefix.cfm">Voucher Prefix</a></h4>
<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i"  or lcase(hcomid) eq "mfssmy_i">
<form name="voucherusage" method="post" action="voucherusagereport2.cfm" target="_blank">
<cfelse>
<form name="voucherusage" method="post" action="voucherusagereport.cfm" target="_blank">
</cfif>
<cfquery name="getgroup" datasource="#dts#">
  select * from voucher order by voucherNo
</cfquery>

<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr>   <input type="hidden" name="fromto" id="fromto" value="" />
    <th>Customer From</th>
        <td><select name="custfrom">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
					<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchsuppfr" onKeyUp="getSupp('custfrom','Customer');">
			</cfif>
		</td>
    </tr>
    <tr> 
        <th>Customer To</th>
        <td><select name="custto">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust"><option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchsuppto" onKeyUp="getSupp('custto','Customer');">
			</cfif>
		</td>
    </tr>
    <tr> <td colspan="2"><hr></td></tr>
     <tr> 
      <th>Voucher No From</th>
      <td ><select name="voucherfrom">
          <option value="">Choose a Voucher No</option>
          <cfloop query="getgroup">
            <option value="#getgroup.voucherno#">#getgroup.voucherno#</option>
          </cfloop> </select><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findvoucher');" /></td>
    </tr>
    <tr>
      <th >Voucher No To</th>
      <td > <select name="voucherto">
           <option value="">Choose a Voucher No</option>
          <cfloop query="getgroup">
            <option value="#getgroup.voucherno#">#getgroup.voucherno#</option>
          </cfloop> </select><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findvoucher');" /> </td>
	  </td>
    </tr>
    <tr> <td colspan="2"><hr></td></tr>
    <tr> 
        <th>Date From</th>
        <td><input type="text" name="datefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> 
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">(DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Date To</th>
        <td><input type="text" name="dateto" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> 
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">(DD/MM/YYYY)</td>
    </tr>
    <cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i"  or lcase(hcomid) eq "mfssmy_i">
     <tr> <td colspan="2"><hr></td></tr>
    <tr> 
        <th>Report Date</th>
        <td><input type="text" name="reportdate" validate="eurodate" message="Invalid Input" maxlength="10" size="10" value="#dateformat(now(),'DD/MM/YYYY')#">  
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(reportdate);">(DD/MM/YYYY)</td>
    </tr>
    </cfif>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>      
</table>
</form>

</cfoutput>
<cfwindow center="true" width="550" height="400" name="findvoucher" refreshOnShow="true"
        title="Find Voucher" initshow="false"
        source="findvoucher.cfm?fromto={fromto}" />

</body>
</html>
