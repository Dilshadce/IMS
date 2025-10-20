<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<cfif frtype eq "SO" or frtype eq "QUO" or frtype eq "DO">
	<cfset ptype="Customer">
	<cfif frtype eq "SO">
		<cfset reftype=gettranname.lSO>
	<cfelseif frtype eq "QUO">
		<cfset reftype=gettranname.lQUO>
	<cfelseif frtype eq "DO">
		<cfset reftype=gettranname.lDO>
	</cfif>
<cfelse>
	<cfset ptype="Supplier">
	<cfif frtype eq "PO">
		<cfset reftype=gettranname.lPO>
	</cfif>
</cfif>

<cfif url.totype eq 'PO'>
<cfset reftypeto=gettranname.lPO>
<cfelseif url.totype eq 'INV'>
<cfset reftypeto=gettranname.lINV>
<cfelseif url.totype eq 'CS'>
<cfset reftypeto=gettranname.lCS>
<cfelseif url.totype eq 'RC'>
<cfset reftypeto=gettranname.lRC>
</cfif>
<cfquery name="get_cust" datasource="#dts#">
	Select count(refno) as cnt, custno, name,refno 
	from artran where type = '#url.frtype#'
	group by custno order by custno
</cfquery>
<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery>
<html>
<head>
	<title>UPDATED BILL</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
</head>

<script language="javascript">
function validation()
{
	if(document.form.custno.value == '')
	{
		alert("Please select a Customer/Supplier.");
		document.form.custno.focus();
		return false;
	}
	
	return true;
}

function getCust(type,option){
		var inputtext = document.form.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
		
}

function getCustResult(suppArray){
	DWRUtil.removeAllOptions("custno");
	DWRUtil.addOptions("custno", suppArray,"KEY", "VALUE");
}

function refresh_refno(){
	var custno=document.form.custno.value;
	var frtype=document.form.frtype.value;
	DWREngine._execute(_reportflocation, null, 'custrefnolookup', custno, frtype, getRefnoResult);
	//usrCtrl();
}
function getRefnoResult(refnoArray){
	DWRUtil.removeAllOptions("invno");
	DWRUtil.addOptions("invno", refnoArray,"KEY", "VALUE");
}
</script>
<body>
<cfoutput>
<h3>
	<a href="outstandmenu.cfm">Outstanding And Tracking</a> >> 
	<a><font size="2">Updated Bill (From #reftype#<cfif url.totype neq ""> To #reftypeto#</cfif>)</font></a>
</h3>
<form name="form" action="updatedbill_result.cfm?frtype=#url.frtype#&totype=#url.totype#" method="post" target="_blank" onSubmit="return validation();">
	<input type="hidden" name="frtype" value="#url.frtype#">
	<input type="hidden" name="totype" value="#url.totype#">
<table width="60%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr> 
        <th>#ptype#</th>
		<td><select name="custno" onChange="refresh_refno()">
				<option value="">Please Choose</option>
				<cfloop query="get_cust"><option value="#get_cust.custno#">#get_cust.custno# - #get_cust.name#</option></cfloop>
			</select>
            <cfif getgeneral.filterall eq "1">
				<input type="text" name="searchsuppfr" onKeyUp="getCust('custfrom','#ptype#');">
			</cfif>
		</td>
    </tr>
	<tr> 
        <td colspan="100%"><hr></td>
    </tr>
	<tr>   
    	<th>#reftype# No.</th>
        <td><select name="invno">
				<option value="--">Please Choose</option>
			</select>
		</td>
	</tr>
    <tr> 
		<th>Customer Name from Customer Profile</th>
      <td colspan="7">
      <input type="checkbox" name="cbcust" value="checkbox" >
      </td></tr>
	<tr> 
        <td colspan="100%"><hr></td>
    </tr>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr> 
</table>
</form>
</cfoutput>
</body>
</html>