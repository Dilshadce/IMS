
<html>
<head>
<title><cfoutput>Placement</cfoutput> Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<style>
th
{
	text-align:left;
	font-size:13px;
}
</style>

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
		<cfset placementdate=dateformat(getitem.placementdate,'')>
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
        <cfset startdate = dateformat(getitem.startdate,'')>
        <cfset completedate = dateformat(getitem.completedate,'')>
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
		<cfset placementdate=dateformat(getitem.placementdate,'')>
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
        <cfset startdate = dateformat(getitem.startdate,'')>
        <cfset completedate = dateformat(getitem.completedate,'')>
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
  <table align="center" >
    <cfoutput> 
    <tr>
     <th>Contract Signed Date :</th>
        <td>
				<cfinput type="text" size="20" name="Placementdate" value="#Placementdate#" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(Placementdate);">
		</td>
        <th>Location</th>
      <td>
      <select name="location" id="location" <cfif mode neq "Delete" and mode neq "Edit">onChange="document.getElementById('placementno').value=this.value+document.getElementById('placementno').value;"</cfif>>
      <option value="">Choose a location</option>
      <cfloop query="getarea">
      <option value="#getarea.area#" <cfif location eq getarea.area>Selected</cfif>>#getarea.area# - #getarea.desp#</option>
      </cfloop>
      </select>
      <cfinput type="hidden" name="location1" id="location1" bind="cfc:placement.getarea({custno},'#target_arcust#','#dts#')">
      </td>
    </tr>
    
      <tr> 
        <th width="80">Placement No:</th>
        <td> <cfif mode eq "Delete" or mode eq "Edit">
            <input type="text" size="20" name="placementno" id="placementno" value="#url.placementno#" readonly>
            <cfelse>
            <input type="text" size="20" name="placementno" id="placementno" value="#placementno#" maxlength="40">
          </cfif> </td>
        <th>Consultant</th>
      <td><select name="consultant">
      <option value="">Choose a Consultant</option>
      <cfloop query="getagent">
      <option value="#getagent.agent#" <cfif xconsultant eq getagent.agent>selected</cfif>>#getagent.agent# - #getagent.agent#</option>
      </cfloop>
      </select></td>
      </tr>
      <tr>
      <th>PO No</th>
      <td> <input type="text" size="20" name="pono" value=""></td>
       <th>Contract Start Date</th>
      <td><cfinput type="text" size="20" name="startdate" id="startdate" value="#startdate#" maxlength="10" validate="eurodate" message="Please check Date Format" ><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('startdate'));"></td>
      </tr>
      <tr>
      <th>PO Date</th>
      <td><input type="text" size="20" name="podate" id="podate" value=""><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('podate'));"></td>
      <th>Contract End Date</th>
      <td><cfinput type="text" size="20" name="completedate" id="completedate" value="#completedate#" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('completedate'));"></td>
      </tr>
      <tr>
      <th>PO Amount</th>
       <td><input type="text" size="20" name="poamount" id="poamount" value=""></td>
       <th>Option To Extend</th>
       <td><input type="text" size="50" name="optextend" id="optextend" value=""></td>
       
      </tr>
      <tr>
      <th>Description 1</th>
      <td><textarea name="desp1" id="desp1" cols="50" rows="2"></textarea></td>
      <th>Type</th>
      <td><select name="placementtype">
      <option value="Temporary">Temporary</option>
      <option value="Permanent">Permanent</option>
      </select>
      </td>
      </tr>
      <tr>
     <th>Description 2</th>
      <td><textarea name="desp2" id="desp2" cols="50" rows="2"></textarea></td>
       <th>Invoice Type</th>
       
      <td><select name="assignmenttype">
        <option value="invoice" <cfif assignmenttype eq 'invoice'>selected</cfif>>Invoice</option>
        <option value="einvoice" <cfif assignmenttype eq 'einvoice'>selected</cfif>>E-Invoice</option>
         <option value="einvoice" <cfif assignmenttype eq 'sinvoice'>selected</cfif>>S-Invoice</option>
      </select>
      
      </td>
      </tr>
      <tr>
      
        <th>Employee Pay Date</th>
     <td>
     <select name="emppaydate" id="emppaydate">
     <cfloop from="1" to="31" index="a">
     <option value="#a#">#a#</option>
     </cfloop>
     </select>
     </td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      </tr>
      <tr>
      <td colspan="100%"><hr /></td>
      </tr>
      <tr>
      <th>Customer No</th>
      <td>
      <select style="width:230px" name="custno" id="custno"  onChange="document.getElementById('custname').value=this.options[this.selectedIndex].id;selectlist(this.options[this.selectedIndex].title,'location');">
      <option value="">Choose a Customer Code</option>
      <cfloop query="getcustno">
      <option value="#getcustno.custno#" title="#getcustno.area#" id="#getcustno.name#<cfif getcustno.name2 neq ""> #getcustno.name2#</cfif>" <cfif xcustno eq getcustno.custno>selected</cfif> >#getcustno.custno#-#getcustno.name#<cfif getcustno.name2 neq ""> #getcustno.name2#</cfif></option>
      </cfloop>
      </select>&nbsp;<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findcustomer');" />
      </td>
      <th>Contact Person</th>
      <td><cfinput type="text" name="contactperson" value="#contactperson#" bind="cfc:placement.getcontact({custno},'#target_arcust#','#dts#')"></td>
      </tr>
      <tr>
      <th>Customer Name</th>
      <td><cfinput type="text" name="custname" id="custname" value="#custname#" size="50"></td>
      <th>Bill to Person</th>
      <td><cfinput type="text" name="billto" value="#billto#" bind="cfc:placement.getbillto({custno},'#target_arcust#','#dts#')" maxlength='20'></td>
     
      </tr>
 
        <tr>
      <th>Department</th>
     <td> <input type="text" name="department" id="department" value=""></td>
     
      </tr>
     <tr>
     <td>&nbsp;</td>
     </tr>
     <tr>
     <td colspan="100%"><hr /></td>
     </tr>
     <tr>
     <th>Employee No</th>
      <td>
      <cfinput type="text" name="empno" id="empno" value="#xempno#">&nbsp;<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findempno');" />
      </td>
      <th>Employee Name</th>
      <td>
      <cfinput type="text" name="empname" id="empname" value="">
      </td>
     </tr>
     <tr>
     <th>Gender</th>
      <td><cfinput type="text" name="Sex" id="sex" value="#Sex#" bind="cfc:placement.getsex({empno},'#dts#','#dts1#')"></td> 
      <th>Refer By Client</th>
     <td>Yes<input type="radio" name="referbyclient" id="referbyclient" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="referbyclient" id="referbyclient" value="No"></td>
     </tr>
    <tr>
    <th>Employee NRIC</th>
      <td><cfinput type="text" name="NRIC" id="nric" value="#NRIC#" bind="cfc:placement.getnric({empno},'#dts#','#dts1#')"></td>
      <th>Job Code</th>
      <td>
      <select name="jobcode" id="jobcode" onChange="document.getElementById('position').value=this.options[this.selectedIndex].id">
      <option value="">Choose a Job Code</option>
      <cfloop query="getenduser">
      <option id="#getenduser.name#" value="#getenduser.driverno#" <cfif xjobcode eq getenduser.driverno>selected</cfif>>#getenduser.driverno# - #getenduser.name#</option>
      </cfloop>
      </select><input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findenduser');" />
      </td>
    </tr>
      <tr>
      <td></td>
      <td></td>
      <th>Position</th>
      <td><cfinput type="text" name="position" id="position" value="#Position#"></td>
      </tr>
<tr><td></td></tr>
<tr>
<td colspan="100%">
<hr/>
</td>
</tr>

<tr>
<th>Rate Type</th>
      <td>
      <select name="clienttype" id="clienttype">
      <option value="">Choose a Type</option>
      <option value="hr" <cfif clienttype eq "hr">selected</cfif>>Hourly</option>
      <option value="day" <cfif clienttype eq "day">selected</cfif>>Daily</option>
      <option value="mth" <cfif clienttype eq "mth">selected</cfif>>Monthly</option>
      </select>
      </td>
      <th>Admin Fee</th>
      <td>
      Fixed<input type="radio" name="billableadmin" id="billableadmin" value="Yes" onClick="if(this.checked == true){document.getElementById('afamt').style.display = 'block';document.getElementById('afpercent').style.display = 'none';}else{document.getElementById('afamt').style.display = 'none';document.getElementById('afpercent').style.display = 'block';}" checked>&nbsp;&nbsp;&nbsp;%<input type="radio" name="billableadmin" id="billableadmin" value="No" onClick="if(this.checked == false){document.getElementById('afamt').style.display = 'block';document.getElementById('afpercent').style.display = 'none';}else{document.getElementById('afamt').style.display = 'none';document.getElementById('afpercent').style.display = 'block';}" >
      </td>
</tr>

<tr>
 <th>Include Billable CPF</th>
      <td>
      Yes<input type="radio" name="billableercpf" id="billableercpf" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="billableercpf" id="billableercpf" value="No">
      </td>
       <th><div id="afamt">Admin Fee Fixed Amount</div><div style="display:none" id="afpercent">Admin Fee %</div></th>
      <td>
      <input type="text" name="adminfeepercent" id="adminfeepercent" value="">
      </td>
</tr>


      <tr>
      <th>CPF Amount</th>
      <td><cfinput type="text" name="cpfamt" id="cpfamt" value="" validate="float" message="Please Key in numbers only">
    
      </td>
     <th>Admin Fee Min Amt</th>
      <td>
      <input type="text" name="adminfeemin" id="adminfeemin">
      </td>
      </tr>
      <tr>
      
     
      </tr>
      <tr>
      <th>Include Billable SDF</th>
      <td>
       Yes<input type="radio" name="billablesdf" id="billablesdf" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="billablesdf" id="billablesdf" value="No">
      </td>
      <th>Rebate</th>
      <td><input type="text" name="rebate" id="rebate" value=""></td>
      </tr>
      <tr>
     <th>SDF Amount</th>
      <td><cfinput type="text" name="sdfamt" id="adfamt" value="" validate="float" message="Please Key in numbers only">
      <th>Rebate Pro-Rate</th>
      <td><input type="checkbox" name="rebatepro" id="rebatepro" value=""></td>
      </tr>
      <tr>
      <td></td>
      <td></td>
      </tr>
      <tr>
      <td colspan="100%">
      <table width="100%" >
      <tr>
      <th>Effective Date</th>
      <th>Employee Rate</th>
      <th>Employer Rate</th>
      </tr>
      <cfloop from="1" to="3" index="i">
      <tr>
      <td><input type="text" size="20" name="ratedate#i#" id="ratedate#i#" value=""><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('ratedate#i#'));"></td>
      <td>
      <input type="text" name="employeerate#i#" id="employeerate#i#" value="">
      </td>
       <td>
      <input type="text" name="employerrate#i#" id="employerrate#i#" value="">
      </td>
      </tr>
      </cfloop>
      </table>
      </td>
      </tr>
      <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r1');"><div align='center'><strong>Entitlement<img src="/images/u.gif" name="imgr1" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="100%">
          		<table id="r1" align="center" width="100%" style="display:none" >
                <tr>
                <td></td>
                <td></td>
       
                <th>Payable</th>
                <th>Billable</th>
                <th>Amount</th>
                <th>Payment Date</th>
                <th>Adm</th><th>SDF</th><th>CPF</th><th>WI</th>
                </tr>
                <cfloop list="bonus,aws,ph" index="a">
                <tr>
                <th><cfif a eq "bonus">1<cfelseif a eq "aws">2<cfelse>3</cfif></th>
                <th><cfif a eq "bonus">Performance Bonus<cfelseif a eq "aws">AWS<cfelse>Public Holiday</cfif></th>
                <td>
                Yes<input type="radio" name="#a#payable" id="#a#payable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#payable" id="#a#payable" value="No">
                </td>
                <td>
                   Yes<input type="radio" name="#a#billable" id="#a#billable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#billable" id="#a#billable" value="No">
                </td>
                <td> <cfif a neq "ph"><input type="text" name="#a#amt" id="#a#amt" value=""></cfif></td>
                <td><input type="text" name="#a#date" id="#a#date" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('#a#date'));"></td>
                <td><cfif a neq "ph">Yes<input type="radio" name="#a#admable" id="#a#admable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#admable" id="#a#admable" value="No"></cfif></td>
                <td><cfif a neq "ph">Yes<input type="radio" name="#a#sdfable" id="#a#sdfable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#sdfable" id="#a#sdfable" value="No"></cfif></td>
                 <td><cfif a neq "ph">Yes<input type="radio" name="#a#cpfable" id="#a#cpfable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#cpfable" id="#a#cpfable" value="No"></cfif></td>
                 <td><cfif a neq "ph">Yes<input type="radio" name="#a#wiable" id="#a#wiable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#wiable" id="#a#wiable" value="No"></cfif></td>
                </tr>
                </cfloop>
                <tr>
                <td>&nbsp;</td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <th>Payable</th>
                <th>Billable</th>
                <th>Per Visit Cap</th>
                <th>Contract Cap</th>
                </tr>
                <tr>
                <th>4</th>
                <th>Medical Claim</th>
                 <td>
                Yes<input type="radio" name="mcpayable" id="mcpayable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="mcpayable" id="mcpayable" value="No">
                </td>
                <td>
                   Yes<input type="radio" name="mcbillable" id="mcbillable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="mcbillable" id="mcbillable" value="No">
                </td>
                <td>
                <input type="text" name="permcclaimcap" id="permcclaimcap" value="">
                </td>
                <td>
                 <input type="text" name="totalmcclaimable" id="totalmcclaimable" value="">
                </td>
                </tr>
                <tr>
                <th>5</th>
                <th>Dental Claim</th>
                 <td>
                Yes<input type="radio" name="dcpayable" id="dcpayable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="dcpayable" id="dcpayable" value="No">
                </td>
                <td>
                   Yes<input type="radio" name="dcbillable" id="dcbillable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="dcbillable" id="dcbillable" value="No">
                </td>
                <td>
                <input type="text" name="perdcclaimcap" id="perdcclaimcap" value="">
                </td>
                <td>
                 <input type="text" name="totaldcclaimable" id="totaldcclaimable" value="">
                </td>
                </tr>
                <tr>
                <td>&nbsp;</td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <th>Entitled</th>
                <th>Claimable from Date</th>
                <th>Days</th>
                <th>Carry Forward</th>
                <th>Total</th>
                <th>Earned</th>
                <th>Earn Type</th>
                <th>Carry Forward</th>
                <th>Remarks</th>
                </tr>
				<cfset listcount = 1>
                <cfloop list="AL,MC,HL,CC,EC,EXC,PTL,SPL,CL,ML" index="i">
                <tr>
                <th>#listcount#<cfset listcount = listcount + 1></th>
                <th><cfswitch expression="#i#">
                <cfcase value="AL">Annual Leave</cfcase>
                <cfcase value="MC">Medical Leave</cfcase>
                <cfcase value="HL">Hospitalisation Leave</cfcase>
                <cfcase value="CC">Childcare Leave</cfcase>
                <cfcase value="EC">Enhanced Childcare</cfcase>
                <cfcase value="EXC">Extended Childcare</cfcase>
                <cfcase value="PTL">Paternal Leave</cfcase>
                <cfcase value="SPL">Shared Parental Leave</cfcase>
                <cfcase value="CL">Compassionate Leave</cfcase>
                <cfcase value="ML">Marriage Leave</cfcase>
                </cfswitch> </th>
                <td>Yes<input type="radio" name="#i#entitle" id="#i#entitle" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#i#entitle" id="#i#entitle" value="No"></td>
                <td><input size="12" type="text" name="#i#date" id="#i#date" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('#i#date'));"></td>
                <td><input type="text" size="5" name="#i#days" id="#i#days" value="" onKeyUp="document.getElementById('#i#totalday').value=parseFloat(this.value)+document.getElementById('#i#bfdays').value"></td>
                 <td><cfif i eq "AL"><input type="text" size="5" name="#i#bfdays" id="#i#bfdays" value=""  onKeyUp="document.getElementById('#i#totalday').value=parseFloat(this.value)+document.getElementById('#i#days').value">
                  </cfif></td>
                 <td><input type="text" size="5" name="#i#totaldays" id="#i#totaldays" value=""></td>
                  <td>Yes<input type="radio" name="#i#earndays" id="#i#earndays" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#i#earndays" id="#i#earndays" value="No"></td>
                  <td> <cfif i eq "AL"><select name="#i#type" id="#i#type" style="width:80px">
                     <option value="lmwd">Last Month Work Done</option>
                     <option value="tmwd">This Month Work Done</option>
                  </select></cfif></td>
                  <td>
                  <cfif i eq "AL">Yes<input type="radio" name="#i#bfable" id="#i#bfable" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#i#bfable" id="#i#bfable" value="No"></cfif>
                  </td>
                  <td>
                  <input type="text" name="#i#remarks" id="#i#remarks" value="" >
                  </td>
                </tr>
                </cfloop>
               
              
                </table>
     </td>
     </tr>
      <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r2');"><div align='center'><strong>Fixed Allowance<img src="/images/u.gif" name="imgr2" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="100%">
          		<table id="r2" align="center" width="100%" style="display:none"     >
                <tr>
                <th>Fixed Allowance Name</th>
                <th>Amount</th>
                <th>Pro-Rated</th>
                </tr>
                <cfloop from="1" to="3" index="a">
                <tr>
                <td>
                <cfquery name="getaw" datasource="#dts1#">
                SELECT * FROM awtable where aw_cou > 3 and aw_cou <=17 order by aw_cou
                </cfquery>
                <select name="allowance#a#" id="allowance#a#" onChange="document.getElementById('allowancedesp#a#').value=this.options[this.selectedIndex].id;">
                <option value="">Choose an Allowance</option>
                <cfloop query="getaw">
                <option value="#getaw.aw_cou#" id="#getaw.aw_desp#">#getaw.aw_desp#</option>
                </cfloop>
                </select>
                <input type="text" name="allowancedesp#a#" id="allowancedesp#a#" size="30" value="">
                </td>
                <td>
                <input type="text" name="allowanceamt#a#" id="allowanceamt#a#" value="">
                </td>
                <td>Yes<input type="radio" name="#a#prorated" id="#a#prorated" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#prorated" id="#a#prorated" value="No"></td>
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
          		<table id="r3" align="center" width="100%"  style="display:none"   >
                <tr>
                <th>Billable Item Name</th>
                <th>Amount</th>
                <th>Pro-Rated</th>
                </tr>
                <cfquery name="getcate" datasource="#dts#">
                select * from iccate
                </cfquery>
                <cfloop from="1" to="3" index="a">
                <tr>
                <td>
                <select name="billableitem#a#" id="billableitem#a#">
                <option value="">Select a Billable Item</option>
                <cfloop query="getcate">
                <option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
                </cfloop>
                </select>
                </td>
                <td>
                <input type="text" name="billableitemamt#a#" id="billableitemamt#a#" value="">
                </td>
              	<td>
                Yes<input type="radio" name="#a#billableprorated" id="#a#billableprorated" value="Yes" checked>&nbsp;&nbsp;&nbsp;No<input type="radio" name="#a#billableprorated" id="#a#billableprorated" value="No">
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
          		<table  id="r4" align="center" width="100%" style="display:none"  >
                <tr>
                <th colspan="2">Workdays Per Week</th>
                <td colspan="4"><input type="text" name="workdaysperweek" id="workdaysperweek" value="5" size="5"></td>
                </tr>
               
                <tr>
                <th>Day</th>
                <th>Start Time</th>
                <th>Off Time</th>
                <th>Break Time Hour</th>
                <th>Daily Work Hour</th>
                <th>Remark</th>
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
                <td>
                <input type="text" name="#i#remark" id="#i#remark" value="">
                </td>
                </tr>
                </cfloop>
                <tr>
                <th colspan="2">Special Pay Schedule</th>
                <td colspan="4"><input type="checkbox" name="sps" id="sps" value=""<!---  onChange="if(this.checked){document.getElementById('spsfield').style.display='block';}else{document.getElementById('spsfield').style.display='none';}" --->></td>
                </tr>
                <tr>
                <td colspan="6">
               
                <table >
                <tr>
                <th>Public Holiday Pay Hour Per Day</th>
                <td><input type="text" name="phph" id="phph" value=""></td>
                </tr>
                <tr>
                <th>Annual Leave Pay Hour Per Day</th>
                <td><input type="text" name="phph" id="phph" value=""></td>
                </tr>
                 <tr>
                <th>Medical Leave Pay Hour Per Day</th>
                <td><input type="text" name="phph" id="phph" value=""></td>
                </tr>
                 <tr>
                <th>Hospitalisation Leave Pay Hour Per Day</th>
                <td><input type="text" name="phph" id="phph" value=""></td>
                </tr>
                </table>
                
                </td>
                </tr>
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
<cfwindow center="true" width="650" height="500" name="findcustomer" refreshOnShow="true"
        title="Find Employee No" initshow="false"
        source="findcustomer.cfm?type=target_arcust" />