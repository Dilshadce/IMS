
<html>
<head>
<title><cfoutput>Placement</cfoutput> Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script type="text/javascript" src="/scripts/prototype.js"></script>
<script type="text/javascript" src="/scripts/effects.js"></script>
<script type="text/javascript" src="/scripts/controls.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
<script language="JavaScript">

// begin: customer search
function getSupp(type,option){
		var inputtext = document.PlacementForm.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("custno");
	DWRUtil.addOptions("custno", suppArray,"KEY", "VALUE");
}

// end: customer search


function validate(){
  if(document.PlacementForm.placementno.value==''){
	alert("Your Placement's No. cannot be blank.");
	document.PlacementForm.placementno.focus();
	return false;
  }

  function getDateObject(dateString,dateSeperator)
	{
	//This function return a date object after accepting 
	//a date string ans dateseparator as arguments
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	
	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	
	//extract month portion 
	endPos=dateString.indexOf(sepChar,curPos+1); cMonth=dateString.substring(curPos+1,endPos);
	
	//extract year portion 
	curPos=endPos;
	endPos=curPos+5; 
	cYear=curValue.substring(curPos+1,endPos);
	
	//Create Date Object
	dtObject=new Date(cYear,cMonth,cDate); 
	return dtObject;
	}
	var startDate = getDateObject(document.PlacementForm.startdate.value,"/");
	var endDate = getDateObject(document.PlacementForm.completedate.value,"/");
	<!---
	if(startDate >= endDate){
	alert("Start date cannot be earlier than completed date");
	document.PlacementForm.startdate.focus();
	return false;
	}--->


  return true;
}

function limitText(field,maxlimit){
	if (field.value.length > maxlimit) // if too long...trim it!
		field.value = field.value.substring(0, maxlimit);
		// otherwise, update 'characters left' counter
}

function selectlist(varval,varattb){		
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++) 
		{
			if (varval==document.getElementById(varattb).options[idx].value) 
			{
				document.getElementById(varattb).options[idx].selected=true;
				
			}
		}
		}

function updatearea()
{
selectlist(document.getElementById('location1').value,'location');
}
	
</script>

<cfset dts1 = replace(dts,'_i','_p','All')>

<cfquery name="getemployee" datasource="#dts#">
	SELECT *
	FROM #dts1#.pmast
</cfquery>

<cfquery name="getarea" datasource="#dts#">
	SELECT *
	FROM icarea
</cfquery>

<cfquery name="getcustno" datasource="#dts#">
	SELECT *
	FROM #target_arcust#
</cfquery>

<cfquery name="getagent" datasource="#dts#">
	SELECT *
	FROM icagent
</cfquery>

<cfquery name="getenduser" datasource="#dts#">
	SELECT *
	FROM driver
</cfquery>


<cfquery name="getproject" datasource="#dts#">
	SELECT *
	FROM #dts1#.project
</cfquery>

<body>
<cfoutput>
	<cfif url.type eq "Edit">
		<cfquery datasource='#dts#' name="getitem">
			Select * from Placement where placementno='#url.placementno#'
		</cfquery>
		
		<cfset placementno=getitem.placementno>
		<cfset placementdate=dateformat(getitem.placementdate,'DD/MM/YYYY')>
		<cfset placementtype=getitem.placementtype>
        <cfset location = getitem.location>
        <cfset xcustno = getitem.custno>
        <cfset custname = getitem.custname>
        <cfset contactperson = getitem.contactperson>
        <cfset xconsultant = getitem.consultant>
        <cfset billto = getitem.billto>
        <cfset xjobcode = getitem.jobcode>
        <cfset position = getitem.position>
        <cfset xempno = getitem.empno>
        <cfset nric = getitem.nric>
        <cfset sex = getitem.sex>
        <cfset duration = getitem.duration>
        <cfset startdate = dateformat(getitem.startdate,'DD/MM/YYYY')>
        <cfset completedate = dateformat(getitem.completedate,'DD/MM/YYYY')>
        <cfset clientrate = getitem.clientrate>
        <cfset clienttype = getitem.clienttype>
        <cfset newrate = getitem.newrate>
        <cfset newtype = getitem.newtype>
        <cfset allowance1 = getitem.allowance1>
        <cfset allowance2 = getitem.allowance2>
        <cfset allowance3 = getitem.allowance3>
        <cfset allowance4 = getitem.allowance4>
        <cfset assignmenttype=getitem.assignmenttype>
        
        
		
		<cfset mode="Edit">
		<!--- <cfset title="Edit Item"> --->
		<cfset title="Edit Placement">
		<cfset button="Edit">
	
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getitem">
			Select * from Placement where placementno='#url.placementno#'
		</cfquery>
		
		<cfset placementno=getitem.placementno>
		<cfset placementdate=dateformat(getitem.placementdate,'DD/MM/YYYY')>
		<cfset placementtype=getitem.placementtype>
        <cfset location = getitem.location>
        <cfset xcustno = getitem.custno>
        <cfset custname = getitem.custname>
        <cfset contactperson = getitem.contactperson>
        <cfset xconsultant = getitem.consultant>
        <cfset billto = getitem.billto>
        <cfset xjobcode = getitem.jobcode>
        <cfset position = getitem.position>
        <cfset xempno = getitem.empno>
        <cfset nric = getitem.nric>
        <cfset sex = getitem.sex>
        <cfset duration = getitem.duration>
        <cfset startdate = dateformat(getitem.startdate,'DD/MM/YYYY')>
        <cfset completedate = dateformat(getitem.completedate,'DD/MM/YYYY')>
        <cfset clientrate = getitem.clientrate>
        <cfset clienttype = getitem.clienttype>
        <cfset newrate = getitem.newrate>
        <cfset newtype = getitem.newtype>
        <cfset allowance1 = getitem.allowance1>
        <cfset allowance2 = getitem.allowance2>
        <cfset allowance3 = getitem.allowance3>
        <cfset allowance4 = getitem.allowance4>
        <cfset assignmenttype=getitem.assignmenttype>
		
		<cfset mode="Delete">
		<!--- <cfset title="Delete Item"> --->
		<cfset title="Delete Placement">
		<cfset button="Delete">
	
	<cfelseif url.type eq "Create">
    <cfquery name="getplacementno" datasource="#dts#">
    select max(placementno) as placementno from placement
    </cfquery>
    <cfif getplacementno.recordcount eq 0>
		<cfset placementno='000001'>
        <cfelse>
        <cfset length=len(getplacementno.placementno)>
        <cfset length1="">
        <cfloop from="1" to="#length#" index="i">
        <cfset length1=length1&"0">
        </cfloop>
        
        <cfset placementno=numberformat(getplacementno.placementno+1,length1)>
        </cfif>
		<cfset placementdate=''>
		<cfset placementtype=''>
        <cfset location = ''>
        <cfset xcustno = ''>
        <cfset custname = ''>
        <cfset contactperson = ''>
        <cfset xconsultant = ''>
        <cfset billto = ''>
        <cfset xjobcode = ''>
        <cfset position = ''>
        <cfset xempno = ''>
        <cfset nric = ''>
        <cfset sex = ''>
        <cfset duration = ''>
        <cfset startdate = ''>
        <cfset completedate = ''>
        <cfset clientrate = '0.00'>
        <cfset clienttype = ''>
        <cfset newrate = '0.00'>
        <cfset newtype = ''>
        <cfset allowance1 = '0.00'>
        <cfset allowance2 = '0.00'>
        <cfset allowance3 = '0.00'>
        <cfset allowance4 = '0.00'>
		<cfset assignmenttype="">
        
		<cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create Placement">
		<cfset button="Create">
	</cfif>

  <h1>#title#</h1>
			
	<h4>
		<cfif getpin2.h1H10 eq 'T'><a href="Placementtable2.cfm?type=Create">Creating a Placement</a> </cfif>
		<cfif getpin2.h1H20 eq 'T'>|| <a href="Placementtable.cfm?">List all Placement</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_Placementtable.cfm?type=Placement">Search For Placement</a></cfif>||<a href="p_Placement.cfm">Placement Listing report</a>
	</h4>
</cfoutput> 

<cfform name="PlacementForm" action="" method="post" onsubmit="return validate()">
  <cfoutput> 
    <input type="hidden" name="mode" value="#mode#">
  </cfoutput> 
  <h1 align="center"><cfoutput>Placement</cfoutput> File Maintenance</h1>
  <table align="center" class="data">
    <cfoutput> 
      <tr> 
        <th width="80">Placement No:</th>
        <td> <cfif mode eq "Delete" or mode eq "Edit">
            <input type="text" size="20" name="placementno" value="#url.placementno#" readonly>
            <cfelse>
            <input type="text" size="20" name="placementno" value="#placementno#" maxlength="40">
          </cfif> </td>
        <th>Date :</th>
        <td>
				<cfinput type="text" size="20" name="Placementdate" value="#Placementdate#" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(Placementdate);">DD/MM/YYYY
		</td>
      </tr>
      <tr>
      <th>Type</th>
      <td><select name="placementtype">
      <option value="Temporary">Temporary</option>
      <option value="Permanent">Permanent</option>
      </select>
      </td>
      <th>Location</th>
      <td>
      <select name="location">
      <option value="">Choose a location</option>
      <cfloop query="getarea">
      <option value="#getarea.area#" <cfif location eq getarea.area>Selected</cfif>>#getarea.area# - #getarea.desp#</option>
      </cfloop>
      </select>
      <cfinput type="hidden" name="location1" id="location1" bind="cfc:placement.getarea({custno},'#target_arcust#','#dts#')">
      </td>
      </tr>
      <tr>
      <th>Customer No</th>
      <td>
      <select name="custno"  onChange="setTimeout('updatearea()',1000);">
      <option value="">Choose a Customer Code</option>
      <cfloop query="getcustno">
      <option value="#getcustno.custno#" <cfif xcustno eq getcustno.custno>selected</cfif> >#getcustno.custno# - #getcustno.name#</option>
      </cfloop>
      </select>
      <br>
      <!---<input type="text" name="searchsuppfr" size="40" onKeyUp="getSupp('custno','Customer');">--->
      <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findcustomer');" />
      </td>
      <th>Name</th>
      <td><cfinput type="text" name="custname" value="#custname#" bind="cfc:placement.getname({custno},'#target_arcust#','#dts#')"></td>
      </tr>
      <tr>
      <th>Contact Person</th>
      <td><cfinput type="text" name="contactperson" value="#contactperson#" bind="cfc:placement.getcontact({custno},'#target_arcust#','#dts#')"></td>
      <th>Consultant</th>
      <td><select name="consultant">
      <option value="">Choose a Consultant</option>
      <cfloop query="getagent">
      <option value="#getagent.agent#" <cfif xconsultant eq getagent.agent>selected</cfif>>#getagent.agent# - #getagent.agent#</option>
      </cfloop>
      </select></td>
      </tr>
      <tr>
      <th>Bill to Person</th>
      <td><cfinput type="text" name="billto" value="#billto#" bind="cfc:placement.getbillto({custno},'#target_arcust#','#dts#')" maxlength='20'></td>
      <th>Type</th>
      <td><select name="assignmenttype">
        <option value="invoice" <cfif assignmenttype eq 'invoice'>selected</cfif>>Invoice</option>
        <option value="einvoice" <cfif assignmenttype eq 'einvoice'>selected</cfif>>E-Invoice</option>
      </select>
      
      </td>
      </tr>
      <tr>
      <th>Job Code</th>
      <td>
      <select name="jobcode">
      <option value="">Choose a Job Code</option>
      <cfloop query="getenduser">
      <option value="#getenduser.driverno#" <cfif xjobcode eq getenduser.driverno>selected</cfif>>#getenduser.driverno# - #getenduser.name#</option>
      </cfloop>
      </select>
      <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findenduser');" />
      </td>
      <th>Position</th>
      <td><cfinput type="text" name="position" value="#Position#" bind="cfc:placement.getposition({jobcode},'#dts#')"></td>
      </tr>
      <tr>
      <th>Employee No</th>
      <td>
      <!---
      <select name="empno">
      <option value="">Choose a Employee No</option>
      <cfloop query="getemployee">
      <option value="#getemployee.empno#" <cfif xempno eq getemployee.empno>checked</cfif>>#getemployee.empno# - #getemployee.name#</option>
      </cfloop>
      </select>--->
      <cfinput type="text" name="empno" id="empno" value="#xempno#">&nbsp;&nbsp;&nbsp;<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findempno');" />
      </td>
      <th>Employee NRIC</th>
      <td><cfinput type="text" name="NRIC" id="nric" value="#NRIC#" bind="cfc:placement.getnric({empno},'#dts#','#dts1#')"></td>
      </tr>
      <tr>
      <th>Sex</th>
      <td><cfinput type="text" name="Sex" id="sex" value="#Sex#" bind="cfc:placement.getsex({empno},'#dts#','#dts1#')"></td>
      <th>Duration</th>
      <td><cfinput type="text" name="duration" value="#duration#"></td 
      ><tr><td colspan="100%"><hr></td></tr>
      <tr>
      <th>Job Start Date</th>
      <td><cfinput type="text" size="20" name="startdate" id="startdate" value="#startdate#" maxlength="10" validate="eurodate" message="Please check Date Format" ><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(startdate);">DD/MM/YYYY</td>
      <th>Job Completed Date</th>
      <td><cfinput type="text" size="20" name="completedate" value="#completedate#" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(completedate);">DD/MM/YYYY</td>
      </tr>
      <tr>
      <th>Employee Rate</th>
      <td><cfinput type="text" name="newrate" id="newrate" value="#newrate#" validate="float" message="Please Key in numbers only"  bind="cfc:placement.getbpay({empno},'#dts#','#dts1#')">
    
      </td>
      <th>Client's Rate</th>
      <td><cfinput type="text" name="clientrate" id="clientrate" value="#clientrate#" validate="float" message="Please Key in numbers only" >
      </td>
     
      </tr>
      <tr>
      <th>Rate Type</th>
      <td>
      <select name="clienttype" id="clienttype">
      <option value="">Choose a Type</option>
      <option value="hr" <cfif clienttype eq "hr">selected</cfif>>Hr</option>
      <option value="day" <cfif clienttype eq "day">selected</cfif>>Day</option>
      <option value="mth" <cfif clienttype eq "mth">selected</cfif>>Mth</option>
      </select>
      </td>
      <th>Billable Employer CPF</th>
      <td>
      <select name="billableercpf" id="billableercpf">
      <option value="Y">Yes</option>
      <option value="N">No</option>
      </select>
      </td>
      </tr>
      <tr>
      <th>Billable SDF</th>
      <td>
      <select name="billablesdf" id="billablesdf">
      <option value="Y">Yes</option>
      <option value="N">No</option>
      </select>
      </td>
      <th>Billable Admin Fee</th>
      <td>
      <select name="billableadmin" id="billableadmin">
      <option value="Y">Yes</option>
      <option value="N">No</option>
      </select>
      </td>
      </tr>
      <tr>
      <th>Admin Fee Percent</th>
      <td>
      <input type="text" name="adminfeepercent" id="adminfeepercent" value="" size="5">%
      </td>
      <th>Admin Fee Minimum Charges</th>
      <td>
      <input type="text" name="adminfeemin" id="adminfeemin">
      </td>
      </tr>
      <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r1');"><div align='center'><strong>Entitlement<img src="/images/u.gif" name="imgr1" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="100%">
          		<table style="display:none" id="r1" align="center" width="100%">
                <tr>
                <th>Performance Bonus</th>
                <td>
                 <select name="performbonus" id="performbonus">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                 <th>Bonus Misc Billable</th>
                <td>
                 <select name="bonusmiscable" id="bonusmiscable">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                </tr>
                <tr>
                <th>Bonus Amount</th>
                 <td>
                 <input type="text" name="bonusamt" id="bonusamt" value="">
                </td>
                <th>Bonus Date</th>
                 <td>
                 <input type="text" name="bonusdate" id="bonusdate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('bonusdate'));">DD/MM/YYYY
                </td>
                </tr>
                 <tr>
                <th>AWS</th>
                <td>
                 <select name="performAWS" id="performAWS">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                 <th>AWS Misc Billable</th>
                <td>
                 <select name="AWSmiscable" id="AWSmiscable">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                </tr>
                <tr>
                <th>AWS Amount</th>
                 <td>
                 <input type="text" name="AWSamt" id="AWSamt" value="">
                </td>
                <th>AWS Date</th>
                 <td>
                 <input type="text" name="AWSdate" id="AWSdate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('AWSdate'));">DD/MM/YYYY
                </td>
                </tr>
                <tr>
                <th>AL Entitle</th>
                <td>
                 <select name="alable" id="alable">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                <th>AL Days Given</th>
                <td>
                 <input type="text" name="aldays" id="aldays" value="">
                </td>
                </tr>
                <tr>
                <th>AL Probabtion Month</th>
                <td>
                 <input type="text" name="alpromonths" id="alpromonths" value="0">
                </td>
                <th>AL Claimable From</th>
                <td>
                  <input type="text" name="Aldate" id="Aldate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('Aldate'));">DD/MM/YYYY
                </td>
                </tr>
                <tr>
                <th>AL Type</th>
                <td><select name="altype" id="altype">
                  <option value="tmwd">This Month Work Done</option>
                  <option value="lmwd">Last Month Work Done</option>
                  </select></td>
                  <th>Earned AL</th>
                  <td>
                 <select name="alearn" id="alearn">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                </tr>
                 <tr>
                <th>MC Entitle</th>
                <td>
                 <select name="mcable" id="mcable">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                <th>MC Days Given</th>
                <td>
                 <input type="text" name="mcdays" id="mcdays" value="">
                </td>
                </tr>
                <tr>
                <th>MC Probabtion Month</th>
                <td>
                 <input type="text" name="mcpromonths" id="mcpromonths" value="0">
                </td>
                <th>MC Claimable From</th>
                <td>
                  <input type="text" name="mcdate" id="mcdate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('mcdate'));">DD/MM/YYYY
                </td>
                </tr>
                 <tr>
                <th>HL Entitle</th>
                <td>
                 <select name="HLable" id="HLable">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                <th>HL Days Given</th>
                <td>
                 <input type="text" name="HLdays" id="HLdays" value="">
                </td>
                </tr>
                <tr>
                <th>HL Probabtion Month</th>
                <td>
                 <input type="text" name="HLpromonths" id="HLpromonths" value="0">
                </td>
                <th>HL Claimable From</th>
                <td>
                  <input type="text" name="HLdate" id="HLdate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('HLdate'));">DD/MM/YYYY
                </td>
                </tr>
                  <tr>
                <th>PH Entitle</th>
                <td>
                 <select name="phable" id="phable">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                <th>PH Claimable From</th>
                <td>
                  <input type="text" name="phdate" id="phdate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('phdate'));">DD/MM/YYYY
                </td>
                </tr>
                   <tr>
                <th>MC Claim Entitle</th>
                <td>
                 <select name="mclaimable" id="mclaimable">
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                </td>
                <th>MC Claimable From</th>
                <td>
                  <input type="text" name="mcclaimdate" id="mcclaimdate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('mcclaimdate'));">DD/MM/YYYY
                </td>
                </tr>
                <tr>
                <th>Per MC Claim Cap</th>
                <td>
                <input type="text" name="permcclaimcap" id="permcclaimcap" value="">
                </td>
                <th>Total MC Claim Cap</th>
                <td>
                <input type="text" name="totalmcclaimable" id="totalmcclaimable" value="">
                </td>
                </tr>
                </table>
     </td>
     </tr>
      <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r2');"><div align='center'><strong>Fixed Allowance<img src="/images/u.gif" name="imgr2" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="100%">
          		<table style="display:none" id="r2" align="center" width="100%">
                <tr>
                <th>Fixed Allowance Name</th>
                <th>Amount</th>
                <th>IR8A Category</th>
                </tr>
                <cfloop from="1" to="3" index="a">
                <tr>
                <td>
                <input type="text" name="allowance#a#" id="allowance#a#" size="50" value="">
                </td>
                <td>
                <input type="text" name="allowanceamt#a#" id="allowanceamt#a#" value="">
                </td>
                <td>
                <select name="awir8atype#a#" id="awir8atype#a#">
                <option value="ENT">Entertainment</option>
                <option value="TRANS">Transport</option>
                <option value="OTH">Others</option>
                </select>
                </td>
                </tr>
                </cfloop>
                
                </table>
                </td>
                </tr>
     <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r3');"><div align='center'><strong>Fixed Billable Item<img src="/images/u.gif" name="imgr3" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="100%">
          		<table  style="display:none" id="r3" align="center" width="100%">
                <tr>
                <th>Billable Item Name</th>
                <th>Amount</th>
                
                </tr>
                <cfloop from="1" to="3" index="a">
                <tr>
                <td>
                <input type="text" name="billableitem#a#" id="billableitem#a#" size="50" value="">
                </td>
                <td>
                <input type="text" name="billableitemamt#a#" id="billableitemamt#a#" value="">
                </td>
              
                </tr>
                </cfloop>
                
                </table>
                </td>
                </tr>
                
                    <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r4');"><div align='center'><strong>Work Hour Pattern<img src="/images/u.gif" name="imgr4" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="100%">
          		<table  style="display:none" id="r4" align="center" width="100%">
                <tr>
                <th>Day</th>
                <th>Start Time</th>
                <th>Off Time</th>
                <th>Break Time Hour</th>
                <th>Daily Work Hour</th>
                </tr>
                <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
                <tr>
                <td>#i#day</td>
                <td>

              
                <select name="#i#timestart" id="#i#timestart">
                <cfloop from="0" to="1410"  index="a" step="30">
                <cfset timenow = createdatetime('2013','1','1','0','0','0')>			
                <option value="#timeformat(dateadd('h',a,timenow),'HH:MM:SS')#">#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#</option>
                </cfloop>
                </select>
                </td>
                <td>
                 <select name="#i#timeoff" id="#i#timeoff">
                <cfloop from="0" to="1410"  index="a" step="30">
                <cfset timenow = createdatetime('2013','1','1','0','0','0')>
                <option value="#timeformat(dateadd('h',a,timenow),'HH:MM:SS')#">#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#</option>
                </cfloop>
                </select>
                </td>
                <td>
                <input type="text" name="#i#breakhour" id="#i#breakhour" value="">
                </td>
                 <td>
                <input type="text" name="#i#totalhour" id="#i#totalhour" value="">
                </td>
                </tr>
                </cfloop>
                </table>
                </td>
                </tr>
                
     
    </cfoutput> 
    <tr> 
      <td height="23"></td>
      <td colspan="4" align="right"><cfoutput> 
          <input name="submit" type="submit" value="  #button#  ">
        </cfoutput></td>
    </tr>
  </table>
</cfform>

</body>
</html>
<cfwindow center="true" width="550" height="400" name="findempno" refreshOnShow="true"
        title="Find Employee No" initshow="false"
        source="findempno.cfm?type=EmpNo" />
<cfwindow center="true" width="550" height="400" name="findenduser" refreshOnShow="true"
        title="Find Job Code" initshow="false"
        source="findenduser.cfm?type=Job Code" />
<cfwindow center="true" width="550" height="400" name="findcustomer" refreshOnShow="true"
        title="Find Employee No" initshow="false"
        source="findcustomer.cfm?type=target_arcust" />