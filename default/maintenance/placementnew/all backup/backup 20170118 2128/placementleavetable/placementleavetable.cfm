<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<title><cfoutput>placementleavetable</cfoutput></title>

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


</head>

<body>
            	
<cfoutput>
<cfset newuuid = createuuid()>
            <cfif url.type eq 'Create'>
            	<cfquery datasource="#dts#" name="getplacementno">
                select placementno from placement 
                </cfquery>
            
            
            		<cfset xplacementno = ''>
        			<cfset leavetype = ''>
            		<cfset xclaimdate = ''>
            		<cfset days = '0'>
                    <cfset created_by = ''>
                    <cfset created_on = ''>
            		<cfset id = ''>
            		<cfset mode="Create">
            		<cfset title="Create Placement Leave">
            		<cfset button="Create">
                    <cfset empno = ''>
                    <cfset custno = "">
                    <cfset custname = "">
                    <cfset ratetype = "">
                    <cfset empname = "">
                    <cfset contractstartdate = "">
                    <cfset contractenddate = "">
            
            
            <cfelseif url.type eq 'Edit' or url.type eq 'Delete'>
				<cfquery datasource='#dts#' name="getplacementno">
        		Select * from placementleave where id='#url.placementno#'
        		</cfquery>
                
                <cfquery name="getplacement" datasource="#dts#">
                SELECT * FROM placment where id='#getplacementno.placementno#'
                </cfquery>
                
                	<cfset xplacementno = getplacementno.placementno>
                    <cfset leavetype = getplacementno.leavetype>
                    <cfset xclaimdate = dateformat(getplacementno.claimdate,'dd/mm/yyyy')>
                    <cfset days = getplacementno.days>
                    <cfset created_by = getplacementno.created_by>
                    <cfset created_on = getplacementno.created_on>
                    <cfset id = getplacementno.id>
                    <cfset mode= url.type>
                    <cfset title="#url.type# Placement Leave">
                    <cfset button=url.type>
                    <cfset empno = getplacement.empno>
                    <cfset custno = getplacement.custno>
                    <cfset custname = getplacement.custname>
                    <cfset ratetype = getplacement.clientype>
                    <cfset empname = getplacement.empname>
                    <cfset contractstartdate = dateformat(getplacement.startdate,"YYYY-MM-DD")>
                    <cfset contractenddate = dateformat(getplacement.completedate,"YYYY-MM-DD")>

            
           </cfif>  
</cfoutput>
<cfoutput>
<h1>#title#</h1>
</cfoutput>
<cfoutput>
  <h4><cfif getpin2.h1H10 eq 'T'><a href="placementleavetable.cfm?type=Create">Creating a Placement Leave</a> </cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="s_placementleave.cfm?type=Placement">Search For Placement Leave</a></cfif></h4>
</cfoutput>

<cfform name="placementleave" action="/default/maintenance/Placementleavetable/placementleaveprocess.cfm" method="post" >
	<cfoutput>
    	<input type="hidden" name="mode" value="#mode#" >
        <input type="hidden" name="id" value="#id#" >
    </cfoutput>
    <table align="center" width="80%">
    <cfoutput>
    	<tr>
        	<th>Placement number</th>
            <td><!---<input type="text" name="placementno" id="placementno" value="#placementno#">--->  
            <cfif mode eq "create">            
                    	<cfinput type="text" id="placementno" name="placementno" value="#xplacementno#" required="yes" message="Placement number is invalid" > &nbsp;<input type="button" name="search_btn" id="search_btn" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findplacementno');" />
			<cfelse>
            
            <cfinput type="text" id="placementno" name="placementno" value="#xplacementno#" required="yes" message="Placement number is invalid" readonly="yes">
            </cfif>
            </td>
            <th>Employee No</th>
        	<td><label id="empno">#empno#</label></td>	
        </tr>
        <tr>
        <th>Customer No</th>
        <td><label id="custno">#custno#</label></td>
        <th>Employee Name</th>
        <td><label id="empname">#empname#</label></td>
        </tr>
        <tr>
        <th>Customer Name</th>
        <td>
        <label id="custname">#custname#</label>
        </td>
        <th>
        Contract Start Date
        </th>
        <td>
        <label id="contractstartdate">#contractstartdate#</label>
        </td>
        </tr>
        <tr>
        <th>Rate Type</th>
        <td>
        <label id="ratetype">#ratetype#</label>
        </td>
        <th>
        Contract End Date
        </th>
        <td>
        <label id="contractenddate">#contractenddate#</label>
        </td>
        </tr>
        <tr>
        <td>&nbsp;&nbsp;</td>
        </tr>
        <tr>
        <td colspan="100%">
        <div id="leavelist">
        <table align="center" width="100%">
        <tr>
        <td></td>
        <th>Entitlement</th>
        <th>Carry Forward</th>
        <th>Taken</th>
        <th>Balance</th>
        <th>Outstanding Claimables</th>
        </tr>
        <cfquery name="getleave" datasource="#dts#">
        Select * from iccostcode order by costcode
        </cfquery>
        <cfloop query="getleave">
        <cfset leavearray = arraynew(1)>
        <cfset leavedesparray = arraynew(1)>
        <cfset leavebalarray = arraynew(1)>
        <cfset leaveclaimablearray = arraynew(1)>
        <cfif evaluate('getplacement.#getleave.costcode#entitle') eq "Y">
        <cfquery name="gettotaltaken" datasource="#dts#">
        SELECT sum(days) as takendays,sum(if(claimed = "N",claimamount,0)) as outstandingclaim FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#"> and leavetype = "#getleave.costcode#"
        </cfquery>
        <tr>
        <th>#getcostcode.desp#</th>
        <td>#numberformat(evaluate('#getleave.costcode#days'),'.__')#</td>
        <td><cfif getleave.costcode eq "AL"><cfset cf = evaluate('getplacement.#getleave.costcode#bfdays')><cfelse><cfset cf = 0 ></cfif>#numberformat(cf,'.__')#</td>
        <td>#numberformat(gettotaltaken.takendays,'.__')#</td>
        <cfset balance = numberformat(evaluate('#getleave.costcode#days'),'.__') + numberformat(cf,'.__') - numberformat(gettotaltaken.takendays,'.__')>
        <td>#numberformat(balance,'.__')#</td>
        <td><cfif claimable eq "Y"><cfset arrayappend(leaveclaimablearray,'Y')>#numberformat(gettotaltaken.outstandingclaim,'.__')#<cfelse>N/A<cfset arrayappend(leaveclaimablearray,'N')></cfif></td>
        </tr>
        <cfset arrayappend(leavearray,'#getleave.costcode#')>
        <cfset arrayappend(leavedesparray,'#getleave.desp#')>
        <cfset arrayappend(leavebalarray,'#numberformat(balance,'.__')#')>
		</cfif>
        </cfloop>
        </table>
        <table width="100%">
        <tr>
        <th colspan="100%" align="center"><div align="center">Leave Entry</div></th>
        </tr>
        <tr>
        <th>Type of Leave</th>
        <th>Start Date</th>
        <th>Start Date AM/PM</th>
        <th>End Date</th>
        <th>End Date AM/PM</th>
        <th>Leave Taken</th>
        <th>Leave Balance</th>
        <th>Claim Amount</th>
        <th>Remarks</th>
        </tr>
        <tr>
        
        <td>
        <select name="leavetype" id="leavetype" onchange="document.getElementById('leavebal').value=parseFloat(this.options[this.selectedIndex].id)-parseFloat(document.getElementById('leavedays').value);if(this.options[this.selectedIndex].title == 'Y'){document.getElementById('claimableamt').style.display='block';}else{document.getElementById('claimableamt').style.display='none';}">
        <cfloop from="1" to="#arraylen(leavearray)#" index="i">
        <option value="#leavearray[i]#" id="#leavebalarray[i]#" title="#leaveclaimablearray[i]#">#leavedesparray[i]#</option>
        </cfloop>
        </select>
        </td>
        <td>
        <input type="text" name="startdate" id="startdate"  size="12" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('startdate'));">
        </td>
        <td>
        <select name="startampm" id="startampm">
        <option value="AM">AM</option>
        <option value="PM">PM</option>
        </select>
        </td>
        <td>
        <input type="text" name="enddate" id="enddate" size="12" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('enddate'));">
        </td>
        <td>
        <select name="endampm" id="endampm">
        <option value="AM">AM</option>
        <option value="PM">PM</option>
        </select>
        </td>
        <td>
        <input type="text" name="leavedays" id="leavedays" size="5" value="0.00" onkeyup="document.getElementById('leavebal').value=(parseFloat(document.getElementById('leavetype').options[document.getElementById('leavetype').selectedIndex].id)-parseFloat(this.value)).toFixed(2);" />
        </td>
         <td>
        <input type="text" name="leavebal" id="leavebal" size="5" readonly="readonly" value="#numberformat(leavebalarray[i],'.__')#" />
        </td>
        <td>
        <input type="text" name="claimableamt" id="claimableamt"  value="" <cfif leaveclaimablearray[i] eq "N">style="display:none"</cfif> size="8" />
        </td>
        <td>
        <input type="text" name="remarks" id="remarks" value="" />&nbsp;<input type="button" name="add_btn" id="add_btn" value="Add" onclick="document.getElementById('search_btn').disabled==true;" /></td>
        </tr> 
        <cfquery name="getleavelist" datasource="#dts#">
        SELECT * FROM (
        SELECT * FROM leavelisttemp WHERE uuid = "#newuuid#" order by id) as a
        LEFT JOIN
        (SELECT desp, costcode FROM iccostcode) as b
        on a.leavetype = b.costcode
        </cfquery>
        <cfloop query="getleavelist">
        <tr>
        <td>#getleavelist.desp#</td>
        <td>#dateformat(getleavelist.startdate,'dd/mm/yyyy')#</td>
        <td>#getleavelist.startampm#</td>
        <td>#dateformat(getleavelist.enddate,'dd/mm/yyyy')#</td>
        <td>#getleavelist.endampm#</td>
        <td>#numberformat(getleavelist.days,'.__')#</td>
        <td>#numberformat(getleavelist.balance,'.__')#</td>
        <td>#numberformat(getleavelist.claimamount,'.__')#</td>
        <td>#getleavelist.remarks#</td>
        </tr>
        </cfloop>
        </table>
        </div>
        </td>
        </tr>
        <tr>
        <td>&nbsp;</td>
        </tr>
        <tr>
        <td colspan="100%" align="center">
        
        </td>
        </tr>
       
        <tr>
        	<td colspan="100%" align="center"><input name="submit" type="submit" value="#button#"></td>            
        </tr>
    </cfoutput>
    </table>
</cfform>

</body>
</html>

<cfwindow center="true" width="700" height="400" name="findplacementno" refreshOnShow="true" title="Find Placement number" initshow="false" source="findplacementno.cfm?type=placementno" />