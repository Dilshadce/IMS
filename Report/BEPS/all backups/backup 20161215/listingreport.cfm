<html>
<head>
<title>View Assignment Slip Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>

 <cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
    <cfset completedate = dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>

<script type="text/javascript">

function searchSel(fieldid,textid) {
  var input=document.getElementById(textid).value.toLowerCase();
  var output=document.getElementById(fieldid).options;
  for(var i=0;i<output.length;i++) {
    if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
      output[i].selected=true;
	  if(fieldid = 'agentfrom')
	  {
		  document.getElementById('agentto').options[i].selected=true;
	  }
	  if(fieldid = 'billfrom')
	  {
		  document.getElementById('billto').options[i].selected=true;
	  }
	  break;
      }
    if(document.getElementById(textid).value==''){
      output[0].selected=true;
      }
  }
}

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
			if(fieldtype == 'getfrom')
			{
			document.getElementById('getto').options[idx].selected=true;		
			}
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
		select custno,name from #target_arcust# order by custno
	</cfquery>
	<cfset title = "Customer">

	<cfquery datasource="#dts#" name="getbill">
		select refno,assignmentslipdate from assignmentslip order by refno
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
<cfform action="listingreportprocess.cfm?type=#url.type#" method="post" name="form123" target="_blank">

<!--- <h2>Print <cfoutput>#trantype#</cfoutput> Listing Report</h2> --->
<cfoutput>
<h3>
	<a><font size="2">#url.type# Report</font></a>
</h3>


<br><br>

<table border="0" align="center" width="80%" class="data">
<cfoutput>
<input type="hidden" name="tran" id="tran" value="#target_arcust#" />
</cfoutput>
<input type="hidden" name="fromto" id="fromto" value="" />
	<cfoutput><input type="hidden" name="title" value="#title#"></cfoutput>
    <cfif url.type eq "Sales">
    <cfquery name="getbill" datasource="#dts#">
    SELECT refno, wos_date as assignmentslipdate FROM artran ORDER by refno
    </cfquery>
	</cfif>
    <tr>
      	<th>Ref No</th>
      	<td><div align="center">From</div></td>
      	<td colspan="2"><select name="billfrom" id="billfrom" onChange="document.getElementById('billto').selectedIndex=this.selectedIndex;">
          		<option value="">Select a ref no</option>
          		<cfloop query="getbill">
            		<option value="#getbill.refno#">#getbill.refno# - #dateformat(getbill.assignmentslipdate,'YYYY-MM-DD')#</option>
          		</cfloop>
			</select>&nbsp;<input type="text" name="searchbillfrom" id="searchbillfrom" onKeyUp="searchSel('billfrom','searchbillfrom')"></td>
    </tr>
    <tr>
      	<th>Ref No</th>
      	<td><div align="center">To</div></td>
      	<td colspan="2"><select name="billto" id="billto">
          		<option value="">Select a ref no</option>
          		<cfloop query="getbill">
            		<option value="#getbill.refno#">#getbill.refno# - #dateformat(getbill.assignmentslipdate,'YYYY-MM-DD')#</option>
          		</cfloop>
			</select>&nbsp;<input type="text" name="searchbillto" id="searchbillto" onKeyUp="searchSel('billto','searchbillto')"></td>
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
				<cfloop query="getsupp">
            	<option value="#getsupp.custno#">#getsupp.custno# - #getsupp.name#</option>
				</cfloop>
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
		  		<cfloop query="getsupp">
				<option value="#getsupp.custno#">#getsupp.custno#- #getsupp.name#</option>
				</cfloop>
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
    <cfquery name="getagent" datasource="#dts#">
						select agent,desp from icagent where 0=0
                        <cfif alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and  ucase(agent)='#ucase(huserid)#'
					</cfif>
					<cfelse>
					
					</cfif> order by agent
					</cfquery>
    <tr<cfif url.type eq "Sales"> style="display:none;"</cfif>> 
    	<th>#getgeneral.lAGENT#</th>
        <td>From</td>
        <td  colspan="2"><select name="agentfrom" id="agentfrom" onChange="document.getElementById('agentto').selectedIndex=this.selectedIndex;">	
					<option value="">Choose an #getgeneral.lAGENT#</option>
					<cfloop query="getagent">
					<option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
					</cfloop>

			</select>&nbsp;<input type="text" name="searchagentfrom" id="searchagentfrom" onKeyUp="searchSel('agentfrom','searchagentfrom')">
		</td>
    </tr>
    <tr <cfif url.type eq "Sales"> style="display:none;"</cfif>> 
        <th>#getgeneral.lAGENT#</th>
        <td>To</td>
        <td colspan="2"><select name="agentto" id="agentto">
				
					<option value="">Choose an #getgeneral.lAGENT#</option>
					<cfloop query="getagent">
					<option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
					</cfloop>
			</select>&nbsp;<input type="text" name="searchagentto" id="searchagentto" onKeyUp="searchSel('agentto','searchagentto')">
		</td>
    </tr>
    <tr <cfif url.type eq "Sales"> style="display:none;"</cfif>>
      	<td colspan="5"><hr></td>
    </tr>
    <cfquery name="getarea" datasource="#dts#">
		select area,desp from icarea order by area 
	</cfquery>
    <tr <cfif url.type eq "Sales"> style="display:none;"</cfif>> 
        <th>Location</th>
        <td>From</td>
        <td><select name="areafrom" id="areafrom" onChange="document.getElementById('areato').selectedIndex=this.selectedIndex;">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
				<option value="#area#">#area#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr <cfif url.type eq "Sales"> style="display:none;"</cfif>> 
        <th>Location</th>
        <td>To</td>
        <td><select name="areato" id="areato">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
				<option value="#area#">#area#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr >
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2"><cfinput type="text" name="datefrom" id="datefrom" maxlength="10" validate="eurodate" size="10" value="#startdate#"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));">(DD/MM/YYYY)</td>
    </tr>
    <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td width="69%"><cfinput type="text" name="dateto" id="dateto" maxlength="10" validate="eurodate" size="10" value="#completedate#"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));">(DD/MM/YYYY)&nbsp;</td>
      	
    </tr>
     <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfif url.type eq "Sales">
    <tr>
    <th>Order By</th>
    <td></td>
    <td>
    <select name="orderbysales" id="orderbysales">
    <option value="refno">Invoice No</option>
    <option value="wos_Date">Date</option>
    <option value="name">Company Name</option>
    <option value="location">Branch</option>
    </select>
    </td>
    </tr>
    <tr>
    <th>Include Void Transaction</th>
    <td></td>
    <td><input type="checkbox" name="voidtrans" id="voidtrans" value=""></td>
    </tr>
	</cfif>
    <tr<cfif url.type eq "Sales"> style="display:none;"</cfif>>
    <th>1st Order By</th>
    <td></td>
    <td>
    <select name="orderby" id="orderby">
    <option value="refno">Assignment No</option>
    <option value="Date">Date</option>
    <option value="Empnoname">Employee Name</option>
    <option value="Companyname">Company Name</option>
    <cfif url.type eq "Cheque Listing">
    <option value="chequeno">Cheque No</option>
	</cfif>
    </select>
    </td>
    </tr>
    <tr<cfif url.type eq "Sales"> style="display:none;"</cfif>>
    <th>2nd Order By</th>
    <td></td>
    <td>
    <select name="orderby2" id="orderby2">
    <option value="">Choose 2nd Order By</option>
    <option value="refno">Assignment No</option>
    <option value="Date">Date</option>
    <option value="Empnoname">Employee Name</option>
    <option value="Companyname">Company Name</option>
    <cfif url.type eq "Cheque Listing">
    <option value="chequeno">Cheque No</option>
	</cfif>
    </select>
    </td>
    </tr>
    <cfif url.type eq "costing">
    <tr>
    <th>Split Based on Consultant</th>
    <td></td>
    <td><input type="checkbox" name="splitbased" id="splitbased" value=""></td>
    </tr>
	</cfif>
    <tr>
    
    <td colspan="3">
    </td>
    <td width="10%"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</cfoutput>
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