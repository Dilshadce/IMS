<cfset words_id_list = "29, 1387, 1388,1375, 1376, 1377, 517, 1483, 1484, 86, 1485, 1486, 5, 1352, 1353, 123, 495, 496, 146, 497, 498, 1302, 1417, 1418, 703, 1361, 1362, 702, 1300, 1301, 688, 1967, 1968, 1969, 1970, 1924, 1925">
<cfinclude template="/latest/words.cfm">
<html>
<head>
<title>Post to AccPacc</title>
<cfset target = "INV">
<cfset targetCN = "CN">
<cfset targetDN = "DN">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>

<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
<link rel="stylesheet" href="/latest/css/select2/select2.css" />
<link rel="stylesheet" href="/latest/css/form.css" />
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>



<cfinclude template="/latest/filter/filterReferenceNo.cfm">
<cfinclude template="/latest/filter/filterCNDN.cfm">
<cfinclude template="/latest/filter/filterCustomer.cfm">
<script type="text/javascript">

$(document).ready(function(){

	updatebatch($( "#month" ).val());

});

function updatebatch(mon)
{
	ajaxFunction(document.getElementById('ajaxfield'),'getbatchCopy.cfm?month='+mon);
}

function checkall(checkboxType)
{
	if(checkboxType == "checkAll")
	{
		if($('#checkAll').is(":checked") == true)
		{
			$(".batches").prop("checked",true);	
		}
		else
		{
			$(".batches").prop("checked", false);
		}
	}
	else
	if(checkboxType == "checkApproved")
	{
		if($('#checkApproved').is(":checked") == true)
		{
			$(".approved").prop("checked",true);	
		}
		else
		{
			$(".approved").prop("checked", false);
		}
	}
	else
	{
		if($('#checkSubmitted').is(":checked") == true)
		{
			$(".submitted").prop("checked",true);	
		}
		else
		{
			$(".submitted").prop("checked", false);
		}
	}
	
}

<!---function searchSel(fieldid,textid) {
  var input=document.getElementById(textid).value.toLowerCase();
  var output=document.getElementById(fieldid).options;
  for(var i=0;i<output.length;i++) {
    if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
      output[i].selected=true;
	  if(fieldid == 'agentfrom')
	  {
		  document.getElementById('agentto').options[i].selected=true;
	  }
	  if(fieldid == 'billfrom')
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
	document.getElementById(fieldtype).value = custno;
	if(fieldtype == 'getfrom')
			{
				document.getElementById('getto').value = custno;
			}
}--->
// begin: supplier search
<!---function getSupp(type,option){
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
}--->
// end: supplier search

// begin: group search
<!---function getGroup(type){
	if(type == 'groupfrom'){
		var inputtext = document.form123.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.form123.searchgroupto.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult2);
	}
}--->

<!---function getGroupResult(groupArray){
	DWRUtil.removeAllOptions("groupfrom");
	DWRUtil.addOptions("groupfrom", groupArray,"KEY", "VALUE");
}

function getGroupResult2(groupArray){
	DWRUtil.removeAllOptions("groupto");
	DWRUtil.addOptions("groupto", groupArray,"KEY", "VALUE");
}
// end: group search--->



</script>

</head>
<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>
        
         <cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'m')>
    
<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid from gsetup
</cfquery>
<!--- Add On 12-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,custformat from dealer_menu limit 1
</cfquery>

 <cfquery name="userlist" datasource="#dts#">
Select userid from main.users where userbranch = "#dts#" 
and usergrpid <> "super"
ORDER BY userid
 </cfquery>
 

		<cfset trantype = "Invoice">
		<cfset trancode = "INV">
        

	<cfquery datasource="#dts#" name="getsupp">
		select custno,name from #target_arcust# order by custno
	</cfquery>
	<cfset title = "Customer">
<cfset assigndate =  dateformat(createdate(val(getmonth.myear),1,1),'yyyy-mm-dd')>
	<cfquery datasource="#dts#" name="getbill">
		select refno,assignmentslipdate from assignmentslip WHERE assignmentslipdate >= "#assigndate#" order by refno desc
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
<cfform action="accpaccInvReport.cfm" method="post" name="form123" id="form123" target="_blank">

<!--- <h2>Print <cfoutput>#trantype#</cfoutput> Listing Report</h2> --->
<cfoutput>
<h3>
	<a><font size="2">Post to AccPacc</font></a>
</h3>

<table border="0" align="center" width="80%" class="data">
<!---<cfoutput>
<input type="hidden" name="tran" id="tran" value="#target_arcust#" />
</cfoutput>
<input type="hidden" name="fromto" id="fromto" value="" />
	<cfoutput><input type="hidden" name="title" value="#title#"></cfoutput>
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
			<input type="text" name="getfrom" id="getfrom">
			<cfif getgeneral.filterall eq "1">
				<cfoutput><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" id="searchsuppfr" name="searchsuppfr" onKeyUp="getSupp('getfrom','#title#');"></cfoutput>
			</cfif>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#title#</cfoutput></th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td colspan="2">
			<input type="text" name="getto" id="getto">
			<cfif getgeneral.filterall eq "1">
				<cfoutput>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" id="searchsuppto" name="searchsuppto" onKeyUp="getSupp('getto','#title#');"></cfoutput>
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
					</cfquery>--->
    <!---<tr> 
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
    <tr> 
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
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfquery name="getarea" datasource="#dts#">
		select area,desp from icarea order by area
	</cfquery>
    <tr> 
        <th>Branch</th>
        <td>From</td>
        <td><select name="areafrom" id="areafrom" onChange="document.getElementById('areato').selectedIndex=this.selectedIndex;">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
				<option value="#area#">#desp#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr> 
        <th>Branch</th>
        <td>To</td>
        <td><select name="areato" id="areato">
				<option value="">Choose an Area</option>
				<cfloop query="getarea">
				<option value="#area#">#desp#</option>
				</cfloop>
			</select>
		</td>
    </tr>
     <tr >
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
 <th>User</th>
 <td>
From
 </td>
<td>
<select name="createdfrm" id="createdfrm" onChange="document.getElementById('createdto').selectedIndex = this.selectedIndex;">
<option value="">Choose an User</option>
<cfloop query="userlist">
<option value="#userlist.userid#">#userlist.userid#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
 <th>User</th>
 <td>
To
 </td>
<td>
<select name="createdto" id="createdto">
<option value="">Choose an User</option>
<cfloop query="userlist">
<option value="#userlist.userid#">#userlist.userid#</option>
</cfloop>
</select>
</td>
</tr>
    <tr >
      	<td colspan="5"><hr></td>
    </tr>--->
    <tr>
      	<th width="16%">Invoice</th>
      	<td width="5%"> </td>
      	<td colspan="2">
       		<input type="hidden" id="refNoFrom" name="refNoFrom" class="referenceNoFilter" data-placeholder="#words[1376]#" />
            <input type="hidden" id="refNoTo" name="refNoTo" class="referenceNoFilter" data-placeholder="#words[1377]#" />     
        </td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    	<th width="16%"> </th>
        <td> </td>
        <td align="center">
			&nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="Invoice Report" onClick="document.form123.action = 'accpaccInvReport.cfm';">
        </td>
        <td width="15%"> </td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%">CN/DN</th>
      	<td width="5%"> </td>
      	<td colspan="2">
       		<input type="hidden" id="CNDNFrom" name="CNDNFrom" class="CNDNFilter" data-placeholder="#words[1376]#" />
            <input type="hidden" id="CNDNTo" name="CNDNTo" class="CNDNFilter" data-placeholder="#words[1377]#" />     
        </td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    	<th width="16%"> </th>
        <td> </td>
        <td align="center">
			&nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="CN/DN Report" onClick="document.form123.action = 'accpaccCNDNReport.cfm';">
        </td>
        <td width="15%"> </td>
    </tr>
    <tr>
      	<th width="16%">Customer</th>
      	<td width="5%"> </td>
      	<td colspan="2">
       		<input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
            <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />     
        </td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    	<th width="16%"> </th>
        <td> </td>
        <td align="center">
			&nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="Customer Report" onClick="document.form123.action = 'accpaccCustReport.cfm';">
        </td>
        <td width="15%"> </td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%">Month</th>
      	<td width="5%"> </td>
      	<td colspan="2">
        <select name="month" id="month" onChange="updatebatch(this.value);">
        <!---"ajaxFunction(document.getElementById('getbatchCopy'),'getbatchCopy.cfm?month='+escape(document.getElementById('month').value));"--->
        <cfloop from="1" to="12" index="a">
        <option value="#a#" <cfif a eq startdate>Selected</cfif>>#dateformat(createdate(year(now()),'#a#','1'),'mmmm')#</option>
        </cfloop>
        </select>
        </td>
    </tr>
     <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%">Batch</th>
      	<td width="5%"> </td>
      	<td colspan="2">
     <!---    <div id="ajaxfield">--->
     <!----
    <cfif val(startdate) neq 0>
    <cfquery name="getbatch" datasource="#dts#">
    SELECT batches,giropaydate, branch FROM assignmentslip WHERE 
    year(assignmentslipdate) = "#getmonth.myear#"
    and month(assignmentslipdate) = "#startdate#"
    and batches <> "" and batches is not null
    Group By Batches
    order by batches
    </cfquery>
    
    
    <cfquery name="getvalidbatch" datasource="#dts#">
    SELECT batchno FROM argiro WHERE 
    batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
    and appstatus = "Approved"
    </cfquery>
    <cfset submitedlist = valuelist(getvalidbatch.batchno)>
    <cfquery name="getvalidbatch2" datasource="#dts#">
    SELECT batchno FROM argiro WHERE 
    batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
    and appstatus = "Pending"
    </cfquery>
    <cfset submitedlist2 = valuelist(getvalidbatch2.batchno)>
    <table width="532"> 
    	<tr> 
            <th width="61%"> <div align="left">&nbsp;  Batch - Pay Date </div></th>
            <th width="39%"> <div align="left">Entity </div></th> 
            <!---branch--->
        </tr>
      
        <cfloop query="getbatch">
            <tr>
                <td width="61%">   
                <div id="getbatchCopy">
        
        		</div>
        <input type="checkbox" name="batches" id="batches" value="#getbatch.batches#">
                				#getbatch.batches#-#dateformat(getbatch.giropaydate,'dd/mm/yyyy')# </td>
                <td colspan="1"> <div align="left">&nbsp; #getbatch.branch#</div></td>
            </tr>
            
		</cfloop>
        
    </table>
    
    <!---<input type="checkbox" name="batches" id="batches" value="#getbatch.batches#">&nbsp;&nbsp;#getbatch.batches#-#dateformat(getbatch.giropaydate,'dd/mm/yyyy')#
	<cfif listfindnocase(submitedlist,getbatch.batches) neq 0>&nbsp;(Approved)</cfif><cfif listfindnocase(submitedlist2,getbatch.batches) neq 0>&nbsp;(Submitted)</cfif>
    &nbsp;&nbsp; - #getbatch.branch#<br>--->

    
	</cfif>
    --->
 <!---   </div>--->
 
     <div id="ajaxfield">
        <cfif val(startdate) neq 0>
        <!---<cfquery name="getbatch" datasource="#dts#">
        SELECT batches,giropaydate FROM assignmentslip WHERE
        year(assignmentslipdate) = "#getmonth.myear#"
        and payrollperiod = "#startdate#"
        and batches <> "" and batches is not null
        Group By Batches
        order by batches
        </cfquery>
    
    
        <cfquery name="getvalidbatch" datasource="#dts#">
        SELECT batchno FROM argiro WHERE
        batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
        and appstatus = "Approved"
        </cfquery>
        <cfset submitedlist = valuelist(getvalidbatch.batchno)>
        <cfquery name="getvalidbatch2" datasource="#dts#">
        SELECT batchno FROM argiro WHERE
        batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
        and appstatus = "Pending"
        </cfquery>
        <cfset submitedlist2 = valuelist(getvalidbatch2.batchno)>--->
        
    
        <!---<cfloop query="getbatch">
        <input type="checkbox" class='batches  <cfoutput>#listfindnocase(submitedlist,getbatch.batches) neq 0 ? 'approved':''#</cfoutput> <cfoutput>#listfindnocase(submitedlist2,getbatch.batches) neq 0 ? 'submitted':''#</cfoutput>' name="batches" id="batches" value="#getbatch.batches#">&nbsp;&nbsp;#getbatch.batches#-#dateformat(getbatch.giropaydate,'dd/mm/yyyy')#<cfif listfindnocase(submitedlist,getbatch.batches) neq 0>&nbsp;(Approved)</cfif><cfif listfindnocase(submitedlist2,getbatch.batches) neq 0>&nbsp;(Submitted)</cfif><br>
    
        </cfloop>--->
        </cfif>
        </div>
        </td>
    </tr>
    <tr >
      	<td colspan="5"><hr></td>
    </tr>
    <!---<tr>
    <th>Order By</th>
    <td></td>
    <td>
    <select name="orderby" id="orderby">
    <option value="invoice"> Invoice </option>
    <option value="customer"> Customer </option>
    </select>
    </td>
    </tr>--->
    <tr>
    <!---<th>Summary Report</th>--->
    <td></td>
    <td>
    <!---<input type="checkbox" name="summary" id="summary" value="" checked>--->
    </td>
    </tr>
	<tr>
    </tr>
    <tr>

    <td colspan="100%" align="center"><!---<input type="Submit" name="Submit" value="View Report" onClick="document.form123.action = 'batchcontroldetailprocess.cfm';">--->
	 <!---&nbsp;&nbsp;&nbsp;---><!---<input type="Submit" name="Submit" value="Html Report" onClick="document.form123.action = 'AccPaccReport.cfm';">---> 
    
    <!---&nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="Customer Report" onClick="document.form123.action = 'accpaccCustReport.cfm';">--->
    &nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="Generate Pay and Burden Report" onClick="document.form123.action = 'Entity.cfm';">
    &nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="Generate Burden Report (NEW)" onClick="document.form123.action = 'Entity2.cfm';"></td>
    </tr>
</table>
</cfoutput>
</cfform>
<!---<cfif getdealer_menu.custformat eq '2'>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer2.cfm?type={tran}&fromto={fromto}" />
<cfelse>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        </cfif>--->
        
        
</body>
</html>