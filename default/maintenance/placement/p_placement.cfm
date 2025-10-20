<html>
<head>
<title>Placement Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

</head>

<cfquery name="getlocation" datasource="#dts#">
		select * from icarea
	</cfquery>

<script type="text/javascript">
function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}


function getcust(type,option){
	if(type == 'custfrom'){
		var inputtext = document.form.searchcustfr.value;
		DWREngine._execute(_reportflocation, null, 'Customerlookup', inputtext, option, getcustResult);
		
	}
	else{
		var inputtext = document.form.searchcustto.value;
		DWREngine._execute(_reportflocation, null, 'Customerlookup', inputtext, option, getcustResult2);
	}
}

function getcustResult(custArray){
	DWRUtil.removeAllOptions("custfrom");
	DWRUtil.addOptions("custfrom", custArray,"KEY", "VALUE");
}

function getcustResult2(custArray){
	DWRUtil.removeAllOptions("custto");
	DWRUtil.addOptions("custto", custArray,"KEY", "VALUE");
}
</script>

<body>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,singlelocation from gsetup
</cfquery>
<cfquery name="getgroup" datasource="#dts#">
  select * from Placement order by Placementno
</cfquery>

<cfquery name="getcust" datasource="#dts#" >
	select custno, name from #target_arcust# order by custno
</cfquery> 
  <h1 align="center"><cfoutput>Placement Listing Report</cfoutput></h1>
<cfoutput>
    <h4 align = "center">
		<cfif getpin2.h1H10 eq 'T'><a href="Placementtable2.cfm?type=Create">Creating a Placement</a> </cfif>
		<cfif getpin2.h1H20 eq 'T'>|| <a href="Placementtable.cfm?">List all Placement</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_Placementtable.cfm?type=project">Search For Placement</a></cfif>||<a href="p_Placement.cfm">Placement Listing report</a>
  </h4>
  </cfoutput>

<cfform action="l_Placement.cfm" name="form" method="post" target="_blank">
  <table border="0" align="center" width="90%" class="data">
  <tr>
    <td nowrap>
    <cfoutput>
    <input type="radio" name="result" value="all">All<br/>
			<input type="radio" name="result" value="active" checked>Active<br/><input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" /></cfoutput>
			<input type="radio" name="result" value="ended">Ended<br/>		</td>
    </tr>
    <tr>
    <td colspan="100%">
    <input type="checkbox" name="showactive" id="showactive" value="">Placement With <select name="activelist" id="activelist"><option value="A">Active</option><option value="N">No Active</option></select> Employee Only
    </td>
    </tr>
   
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th width="20%"><cfoutput>Placement</cfoutput></th>
      <td width="10%"> <div align="center">From</div></td>
      <td width="70%"><select name="groupfrom">
          <option value=""><cfoutput>Choose a Placement</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Placementno#">#Placementno#</option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24" width="20%"><cfoutput>Placement</cfoutput></th>
      <td width="10%"><div align="center">To</div></td>
      <td width="70%" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a Placement</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#Placementno#">#Placementno#</option>
          </cfoutput> </select> </td>
	  </td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>

    <tr> 
        	<th><cfoutput>Location</cfoutput></th>
            <td><div align="center">From</div></td>
            <td colspan="2">
            	<select name="locfrom">
	          				<option value="">Choose a Location</option>
					<!--- <option value="">Choose a Location</option> --->
                    <cfoutput query="getlocation"> 
                    	<option value="#getlocation.area#">#getlocation.area# - #getlocation.desp#</option>
                    </cfoutput>
                </select>
            </td>
		</tr>
        
		<tr>
        	<th>Location</th>
            <td><div align="center">To</div></td>
            <td width="69%">
            	<select name="locto">
					
	          				<option value="">Choose a Location</option>

                	<!--- <option value="">Choose a Location</option> --->
                    <cfoutput query="getlocation"> 
                        <option value="#getlocation.area#">#getlocation.area# - #getlocation.desp#</option>
                    </cfoutput>
                </select>
            </td>
            
        </tr>
        
        
        <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfoutput>
    <tr> 
        <th>Customer</th>
        <td><div align="center">From</div></td>
        <td><select name="custfrom">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />

		</td>
    </tr>
    <tr> 
        <th>Customer</th>
        <td><div align="center">To</div></td>
        <td><select name="custto">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />

		</td>
    </tr>
        </cfoutput>
    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
   
   
    <tr> 
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
<cfwindow width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Customer" initshow="false"
        source="/default/report-sales/findCustomer.cfm?type={tran}&fromto={fromto}" />
