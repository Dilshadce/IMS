<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

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
			<th>Customer ID</th>
			<cfif getgeneral.filterall eq "1">
				<cfquery name="getcust" datasource="#dts#">
					select custno,name as cname from #target_arcust# where 0=0
                    <cfif getpin2.h1250 eq 'T'>
					and agent = '#huserid#'
					</cfif>
    				<cfif getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
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
                    </cfif>
                    
                    
                     order by custno
                    
                    
				</cfquery>
				<td>
					<select name="custno" id="custno">
						<option value="">Choose a Customer</option>
						<cfoutput query="getcust">
							<option value="#getcust.custno#">#getcust.custno# - #getcust.cname#</option>
						</cfoutput>
					</select>
					<input type="text" name="searchcust" id="searchcust" onKeyUp="searchSel('custno','searchcust')">
				</td>
			<cfelse>
				<cfif isdefined("url.custno")>
					<td><cfoutput><input name="custno" type="text" value="#custno#"></cfoutput>
				<cfelse>
					<td><cfoutput><input name="custno" type="text" value=""></cfoutput>
				</cfif>
				<a href="ctsearch.cfm?type=createjob">SEARCH</a></td>
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
