
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

<cfform name="PlacementForm" action="Placementtableprocess.cfm" method="post" onsubmit="return validate()">
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
      <select name="custno" id="custno"  onChange="setTimeout('updatearea()',1000);">
      <option value="">Choose a Customer Code</option>
      <cfloop query="getcustno">
      <option value="#getcustno.custno#" <cfif xcustno eq getcustno.custno>selected</cfif> >#getcustno.custno# - #getcustno.name#</option>
      </cfloop>
      </select>
      <br>
      <!---<input type="text" name="searchsuppfr" size="40" onKeyUp="getSupp('custno','Customer');">--->
      <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findcustomer');" id="asbtn" name="asbtn" />
      </td>
      <th>Name</th>
      <td><cfinput type="text" name="custname" value="#custname#" bind="cfc:placement.getname({custno},'#target_arcust#','#dts#')" maxlength="40"></td>
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
      <th>Project</th>
      <td>
      <select name="project">
      <option value="">Choose a Project</option>
      <cfloop query="getproject">
      <option value="#getproject.project#">#getproject.project# - #getproject.desp#</option>
      </cfloop>
      </select>
      </td>
      </tr>
      <tr>
      <th>Job Code</th>
      <td>
      <select name="jobcode" id="jobcode">
      <option value="">Choose a Job Code</option>
      <cfloop query="getenduser">
      <option value="#getenduser.driverno#" <cfif xjobcode eq getenduser.driverno>selected</cfif>>#getenduser.driverno# - #getenduser.name#</option>
      </cfloop>
      </select>
      <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findenduser');"  id="asbtn2" name="asbtn2"/>
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
      <cfinput type="text" name="empno" id="empno" value="#xempno#">&nbsp;&nbsp;&nbsp;<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findempno');"  id="asbtn3" name="asbtn3"/>
      </td>
      <th>Employee NRIC</th>
      <td><cfinput type="text" name="NRIC" id="nric" value="#NRIC#" bind="cfc:placement.getnric({empno},'#dts#','#dts1#')"></td>
      </tr>
      <tr>
      <th>Sex</th>
      <td><cfinput type="text" name="Sex" id="sex" value="#Sex#" bind="cfc:placement.getsex({empno},'#dts#','#dts1#')"></td>
      <th>Duration</th>
      <td><cfinput type="text" name="duration" value="#duration#"></td>
      </tr>
      <tr><th></th><td></td>
      <th>Type</th>
      <td>
      <select name="assignmenttype">
      <option value="invoice" <cfif assignmenttype eq 'invoice'>selected</cfif>>Invoice</option>
      <option value="einvoice" <cfif assignmenttype eq 'einvoice'>selected</cfif>>E-Invoice</option>
      </select>
      </td>
      </tr>
      
      <tr><td colspan="100%"><hr></td></tr>
      <tr>
      <th>Job Start Date</th>
      <td><cfinput type="text" size="20" name="startdate" id="startdate" value="#startdate#" maxlength="10" validate="eurodate" message="Please check Date Format" bind="cfc:placement.getdate({empno},{project},'#dts#','#dts1#')"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(startdate);">DD/MM/YYYY</td>
      <th>Job Completed Date</th>
      <td><cfinput type="text" size="20" name="completedate" value="#completedate#" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(completedate);">DD/MM/YYYY</td>
      </tr>
      <tr>
      <th>Client's Rate</th>
      <td><cfinput type="text" name="clientrate" id="clientrate" value="#clientrate#" validate="float" message="Please Key in numbers only" >&nbsp;<b>Type</b>&nbsp;
      <select name="clienttype" id="clienttype">
      <option value="">Choose a Type</option>
      <option value="hr" <cfif clienttype eq "hr">selected</cfif>>Hr</option>
      <option value="day" <cfif clienttype eq "day">selected</cfif>>Day</option>
      <option value="mth" <cfif clienttype eq "mth">selected</cfif>>Mth</option>
      </select>
      </td>
      <th>Current/New Pay Rate</th>
      <td><cfinput type="text" name="newrate" id="newrate" value="#newrate#" validate="float" message="Please Key in numbers only"  bind="cfc:placement.getbpay({empno},'#dts#','#dts1#')">
      &nbsp;<b>Type</b>&nbsp;
      <select name="newtype" id="newtype">
      <option value="">Choose a Type</option>
      <option value="hr" <cfif newtype eq "hr">selected</cfif>>Hr</option>
      <option value="day" <cfif newtype eq "day">selected</cfif>>Day</option>
      <option value="mth" <cfif newtype eq "mth">selected</cfif>>Mth</option>
      </select>
      </td>
      </tr>
      <tr>
      <th colspan="100%">Other Benefits - Allowances</th>
      </tr>
      <tr>
      <th>Allowances 1</th>
      <td><input type="text" name="allowance1" value="#allowance1#"></td>
      <th>Allowances 2</th>
      <td><input type="text" name="allowance2" value="#allowance2#"></td>
      </tr>
      <tr>
      <th>Allowances 3</th>
      <td><input type="text" name="allowance3" value="#allowance3#"></td>
      <th>Allowances 4</th>
      <td><input type="text" name="allowance4" value="#allowance4#"></td>
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
        title="Find Customer" initshow="false"
        source="findcustomer.cfm?type=target_arcust" />