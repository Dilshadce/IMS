<html>
<head>
<title>Packing List Customer Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

	<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
    
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    
	<script src="/SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
	<script src="/SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
	<script type="text/javascript">
	// begin: supplier search
function getSupp(type,option){
	if(type == 'custfrom'){
		var inputtext = document.itemsales.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.itemsales.searchsuppto.value;
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
</script>
</head>




<body>
<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,filterall from gsetup
</cfquery>
<cfquery name="getgroup" datasource="#dts#">
  select packid from packlist
</cfquery>

<cfquery name="getdriver" datasource="#dts#">
  select driverno,name from driver order by driverno
</cfquery>

<cfquery name="getcust" datasource="#dts#">
	select custno, name from #target_arcust# order by custno
</cfquery> 

  <h1 align="center"><cfoutput>Driver Report</cfoutput></h1>
<cfoutput>
<h4>
	<a href="/default/transaction/packinglist/packinglistmain.cfm">Create Packing List</a> || 
	<a href="/default/transaction/packinglist/listpackingmain.cfm">List Packing List</a> || 
	<a href="/default/transaction/packinglist/assigndrivermain.cfm">Assign Driver</a>||
    <a href="/default/transaction/packinglist/deliveryrecord/checkdelivered.cfm">Delivery Record</a>||
    <a href="/default/transaction/packinglist/standardreport.cfm">Delivery Report</a>||
    <a href="/default/transaction/packinglist/packinglistreportmenu.cfm">Packing Report</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">Customer Report</a>
</h4>
  </cfoutput>

<cfform action="customerreport2.cfm" name="form" method="post" target="_blank">


	
  <table border="0" align="center" width="90%" class="data">
  <cfoutput>
<tr>   
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
    </cfoutput>
    <tr> 
        <td colspan="8"><hr></td>
    </tr>
        <tr> 
      <th>Delivery Date From</th>
        <td colspan= "3">
				<cfoutput>
					<input type="text" name="datefrom" id="datefrom" value="#dateformat(now(),"dd/mm/yyyy")#" validate="eurodate" size="10" maxlength="10">
				
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">
				(DD/MM/YYYY)
                </cfoutput>
	  </td>
    </tr>
            <tr> 
        <th>Delivery Date To</th>
               <td colspan= "3">
				<cfoutput>
					<input type="text" name="dateto" id="dateto" value="#dateformat(DATEADD("m",1,Now()),"dd/mm/yyyy")#" validate="eurodate" size="10" maxlength="10">
				
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">
				(DD/MM/YYYY)
                </cfoutput>
			</td>
    </tr>
     <tr> 
        <td colspan="8"><hr></td>
    </tr>
 <tr> 
      <th width="20%"><cfoutput>PACK No From</cfoutput></th>
      <td colspan="6"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Pack No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#packid#">#packid# </option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>PACK No To</cfoutput></th>
      <td colspan="6" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Pack No</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#packid#">#packid#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>
      <tr> 
        <td colspan="8"><hr></td>
    </tr>
<tr> 
      <th width="20%"><cfoutput>Driver No From</cfoutput></th>

      <td colspan="6"><select name="groupfrom2">
          <option value=""><cfoutput>Choose a Driver  No</cfoutput></option>
          <cfoutput query="getdriver">
            <option value="#Driverno#">#driverno# - #name# </option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24"><cfoutput>Driver  No To</cfoutput></th>

      <td colspan="6" nowrap> <select name="groupto2">
          <option value=""><cfoutput>Choose a Driver  No</cfoutput></option>
          <cfoutput query="getdriver">
            <option value="#driverno#">#driverno# - #name#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>
    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
   
       
      <td></td>
      <td></td>
      <td width="5%"><div align="right">
        <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
</cfform>
</body>
</html>
