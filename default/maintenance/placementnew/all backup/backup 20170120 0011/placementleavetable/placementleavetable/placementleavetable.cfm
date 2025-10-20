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
            
            
            <cfif url.type eq 'Edit' or url.type eq 'Delete'>
				<cfquery datasource='#dts#' name="getplacementno">
        		Select * from placementleave where id='#url.placementno#'
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
                    

            
           </cfif>  
</cfoutput>
<cfoutput>
<h1>#title#</h1>
</cfoutput>
<cfoutput>
  <h4><cfif getpin2.h1H10 eq 'T'><a href="placementleavetable.cfm?type=Create">Creating a Placement</a> </cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="s_placementleave.cfm?type=Placement">Search For Placement</a></cfif></h4>
</cfoutput>

<cfform name="placementleave" action="/default/maintenance/Placementnew/placementleaveprocess.cfm" method="post" >
	<cfoutput>
    	<input type="hidden" name="mode" value="#mode#" >
        <input type="hidden" name="id" value="#id#" >
    </cfoutput>
    <table align="center">
    <cfoutput>
    	<tr>
        	<th>Placement number</th>
            <td><!---<input type="text" name="placementno" id="placementno" value="#placementno#">--->              
                    	<input type="text" id="placementno" name="placementno" value="#xplacementno#" <cfif url.type neq 'create'>readonly</cfif>/> &nbsp;<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findplacementno');" />
            </td>
        </tr>
        <tr>
        	<th>Leave type</th>
            <td>
            	<cfscript>
					
				</cfscript>
            	<select name="leavetype">              
                	<cfloop list="AL,MC,HL,CC,EC,EXL,PTL,SPL,CL,ML" index="i">
                    	<option name="#i#" value="#i#" <cfif leavetype eq '#i#'>selected</cfif>><cfif i eq 'AL'>Annual Leaves<cfelseif i eq 'MC'>Medical Leave<cfelseif i eq 'HL'>Hospitalisation Leave<cfelseif i eq 'CC'>Childcare Leave<cfelseif i eq 'EC'>Enhanced Childcare<cfelseif i eq 'EXL'>Extended Childcare<cfelseif i eq 'PTL'>Paternal Leave<cfelseif i eq 'SPL'>Shared Parental Leave<cfelseif i eq 'CL'>Copassionate Leave<cfelseif i eq 'ML'>Marriage Leave</cfif></option>
                    </cfloop>
                </select>
            </td>
        </tr>
        <tr>
        	<th>Leave date</th>
            <td><cfinput type="text" name="claimdate" id="claimdate" validate="eurodate" value="#xclaimdate#"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('claimdate'));"></td>
        </tr>
        <tr>
        	<th>Days</th>
            <td><cfinput type="text" name="days" id="days" value="#days#" required="yes"></td>
        </tr>
        <tr>
        	<td><input name="submit" type="submit" value="#button#"></td>            
        </tr>
    </cfoutput>
    </table>
</cfform>

</body>
</html>

<cfwindow center="true" width="450" height="400" name="findplacementno" refreshOnShow="true" title="Find Placement number" initshow="false" source="findplacementno.cfm?type=placementno" />