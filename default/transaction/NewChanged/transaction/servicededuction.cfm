<html>
<head>
<title>Create Job Sheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>

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

</script>

</head>
<body>
	
<h1>Create Job Sheet</h1>
<br>
<h4>
<a href="servicededuction.cfm">Creating New Job Sheet</a> || 
<a href="stransaction.cfm?tran=SAM&searchtype=&searchstr=">List all Job Sheet</a>
</h4>
<hr>

<br>
<cfquery name="getgeneral" datasource="#dts#">
	select filterall from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where type = 'SAM'
	and counter = '1'
</cfquery>

<cfform name="createjob" action="servicedeductionprocess.cfm" method="post">
<cfoutput>
	<table align="center" class="data">
		<tr>
			<th>Customer ID</th>
				<cfquery name="getcust" datasource="#dts#">
					
                    select a.custno,a.name as cname from ictran as a
left join (select sum(qty) as updatedqty,trancode,frrefno,frtype from servicededuct where type='SAM' and frtype='INV' group by itemno)as b on a.trancode=b.trancode and a.type=b.frtype and a.refno=b.frrefno
where a.type='INV' and a.qty-ifnull(b.updatedqty,0) > 0 and a.deductableitem = 'Y' group by a.custno
                    
                    <!---
                    <cfif getpin2.h1250 eq 'T'>
					and agent = '#huserid#'
					</cfif>
    				<cfif getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                    <cfelse>
					<cfif Huserloc neq "All_loc">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>--->
                     order by custno
                    
                    
				</cfquery>
				<td>
					<cfselect name="custno" id="custno" onChange="ajaxFunction(document.getElementById('vehiajax'),'/default/transaction/getserdeduct_vehiajax.cfm?custno='+escape(document.getElementById('custno').value));" required="yes" message="Please Choose a Customer">
						<option value="">Choose a Customer</option>
						<cfloop query="getcust">
							<option value="#getcust.custno#">#getcust.custno# - #getcust.cname#</option>
						</cfloop>
					</cfselect>
					<input type="text" name="searchcust" id="searchcust" onKeyUp="searchSel('custno','searchcust');ajaxFunction(document.getElementById('vehiajax'),'/default/transaction/getserdeduct_vehiajax.cfm?custno='+escape(document.getElementById('custno').value));">
				</td>
		</tr>
        <tr>
        <th>Vehicle No</th>
        <td>
        <div id="vehiajax">
        <cfselect name="vehicleno" id="vehicleno" onChange="ajaxFunction(document.getElementById('refnoajax'),'/default/transaction/getserdeduct_refnoajax.cfm?custno='+escape(document.getElementById('custno').value)+'&vehino='+escape(document.getElementById('vehicleno').value));">
        <option value="">Choose a Vehicle No</option>
        
        </cfselect>
        </div>
        </td>
        </tr>
        
        <tr>
        <th>Reference No</th>
        <td>
        <div id="refnoajax">
        <cfselect name="refno" id="refno" onChange="ajaxFunction(document.getElementById('itemajax'),'/default/transaction/getserdeduct_itemajax.cfm?custno='+escape(document.getElementById('custno').value)+'&vehino='+escape(document.getElementById('vehicleno').value)+'&refno='+escape(document.getElementById('refno').value));">
        <option value="">Choose a Ref No</option>
        
        </cfselect>
        </div>
        </td>
        </tr>
        <cfif getgeneralinfo.arun neq 1>
					<tr>
						<th>Next Refno</th>
						<td><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
					</tr>
		</cfif>
        
	</table>
    <div id="itemajax">
    <table align="center" class="data">
    
    
    </table>
    </div>
    	<div align="center"><input name="submit" type="submit" value="Submit"></div>
    
</cfoutput>
</cfform>

</body>
</html>
