<cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
    <cfset completedate = dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>
<html>
<head>
<title>View Assignment Slip Report</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

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
// begin: supplier search
function getSupp(type,option){
	if(type == 'getfrom'){
		var inputtext = document.form123.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.form123.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult2);
	}
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("getfrom");
	DWRUtil.addOptions("getfrom", suppArray,"KEY", "VALUE");
}

function getSuppResult2(suppArray){
	DWRUtil.removeAllOptions("getto");
	DWRUtil.addOptions("getto", suppArray,"KEY", "VALUE");
}
// end: supplier search

// begin: group search
function getGroup(type){
	if(type == 'groupfrom'){
		var inputtext = document.form123.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.form123.searchgroupto.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult2);
	}
}

function getGroupResult(groupArray){
	DWRUtil.removeAllOptions("groupfrom");
	DWRUtil.addOptions("groupfrom", groupArray,"KEY", "VALUE");
}

function getGroupResult2(groupArray){
	DWRUtil.removeAllOptions("groupto");
	DWRUtil.addOptions("groupto", groupArray,"KEY", "VALUE");
}
// end: group search

</script>

</head>
<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>
        
<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid from gsetup
</cfquery>
<!--- Add On 12-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,custformat from dealer_menu limit 1
</cfquery>

		<cfset trantype = "Invoice">
		<cfset trancode = "INV">
        

	<cfquery datasource="#dts#" name="getsupp">
		select custno,name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
	</cfquery>
	<cfset title = "Customer">

	<cfquery datasource="#dts#" name="getbill">
		select refno from assignmentslip order by refno
	</cfquery>

<cfquery datasource="#dts#" name="getagent">
	select agent,desp from icagent
    where 0=0
    <cfif alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(agent)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			
		</cfif>
    order by agent
</cfquery>

<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super'>
	<cfquery name="getlocation" datasource="#dts#">
		select location,desp 
		from iclocation 
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
        <cfelse>
		<cfif Huserloc neq "All_loc">
			where location in (#ListQualify(Huserloc,"'",",")#)
		</cfif>
        </cfif>
		order by location
	</cfquery>
<cfelse>
	<cfquery name="getlocation" datasource="#dts#">
		select 
		location,
		desp 
		from iclocation 
		order by location
	</cfquery>
</cfif>

<cfquery name="getproject" datasource="#dts#">
		select source,project from project WHERE PORJ = "P" <cfif lcase(HcomID) eq "mphcranes_i">order by project<cfelse> order by source</cfif>
	</cfquery>
    
<cfquery name="getjob" datasource="#dts#">
		select source,project from project WHERE PORJ = "J" <cfif lcase(HcomID) eq "mphcranes_i">order by project<cfelse> order by source</cfif>
	</cfquery>

<body>
<cfform action="bill_listingreport1.cfm?type=#trantype#&trancode=#trancode#&alown=#alown#" method="post" name="form123" target="_blank">

<!--- <h2>Print <cfoutput>#trantype#</cfoutput> Listing Report</h2> --->
<h3>
	<a><font size="2">Print Assignment Slip Listing Report</font></a>
</h3>

<br><br>

<table border="0" align="center" width="80%" class="data">
<cfoutput>
<input type="hidden" name="tran" id="tran" value="#target_arcust#" />
</cfoutput>
<input type="hidden" name="fromto" id="fromto" value="" />
	<cfoutput><input type="hidden" name="title" value="#title#"></cfoutput>
    <tr>
      	<th>Ref No</th>
      	<td><div align="center">From</div></td>
      	<td colspan="2"><select name="billfrom" id="billfrom" onChange="document.getElementById('billto').selectedIndex=this.selectedIndex;">
          		<option value="">Select a ref no</option>
          		<cfoutput query="getbill">
            		<option value="#refno#">#refno#</option>
          		</cfoutput>
			</select></td>
    </tr>
    <tr>
      	<th>Ref No</th>
      	<td><div align="center">To</div></td>
      	<td colspan="2"><select name="billto" id="billto">
          		<option value="">Select a ref no</option>
          		<cfoutput query="getbill">
            		<option value="#refno#">#refno#</option>
          		</cfoutput>
			</select></td>
    </tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#title#</cfoutput></th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2">
			<select name="getfrom" id="getfrom" onChange="document.getElementById('getto').selectedIndex=this.selectedIndex;">
            	<option value="">Choose a <cfoutput>#title#</cfoutput></option>
				<cfoutput query="getsupp">
            	<option value="#custno#">#custno# - #name#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<cfoutput><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppfr" onKeyUp="getSupp('getfrom','#title#');"></cfoutput>
			</cfif>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#title#</cfoutput></th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td colspan="2">
			<select name="getto" id="getto">
				<option value="">Choose a <cfoutput>#title#</cfoutput></option>
		  		<cfoutput query="getsupp">
				<option value="#custno#">#custno#- #name#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<cfoutput>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" name="searchsuppto" onKeyUp="getSupp('getto','#title#');"></cfoutput>
			</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    
    <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2"><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10" value="#startdate#">(DD/MM/YYYY)</td>
    </tr>
    <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td width="69%"><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10" value="#completedate#">(DD/MM/YYYY)&nbsp;</td>
      	
    </tr>
    <tr>
    
    <td colspan="3">
    </td>
    <td width="10%"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>

</cfform>
<cfif getdealer_menu.custformat eq '2'>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer2.cfm?type={tran}&fromto={fromto}" />
<cfelse>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        </cfif>
</body>
</html>