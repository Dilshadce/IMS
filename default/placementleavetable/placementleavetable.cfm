<cfajaximport tags="cfform">
<cfset newuuid = createuuid()>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<title>placementleavetable</title>

<script language="javascript" type="text/javascript" src="/scripts/ajax.js">

</script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script src="/scripts/CalendarControlbeps.js" language="javascript"></script>
<script type="text/javascript">
function editdate(newid)
{
	document.getElementById('editdateid').value = newid;
	ColdFusion.Window.show('editdate');
}

function dateajaxfunction()
{
	var datef = document.getElementById('startdate').value;
	var datet = document.getElementById('enddate').value;
	var startampmval = document.getElementById('startampm').value;
	var endampmval = document.getElementById('endampm').value;
	var getleavetype = document.getElementById('leavetype').value;
	
	if(datef == datet && startampmval !=endampmval && datef != '' && datet != '')
	{
		alert('If Start date date is the same as end date, there should not be different AM / PM sessions');
		return false;
	}
	if(datef != '' && datet != '')
	{
	var placementno = document.getElementById('placementno').value;
	var leavedaysvar = document.getElementById('leavedays');
	var getleeavedaysurl = 'leavedays.cfm?datefrom='+escape(datef)+'&dateto='+escape(datet)+'&placementno='+placementno+'&startampm='+startampmval+'&endampm='+endampmval+'&leavetype='+getleavetype;
		new Ajax.Request(getleeavedaysurl,
			{
				method:'get',
				onSuccess: function(getdetailback){
					document.getElementById('ldayscal').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(response){ 
					alert(response.statusText); },		
			
				onComplete: function(transport){
					leavedaysvar.value = document.getElementById('newleavedays').value;
					document.getElementById('leavebal').value=(parseFloat(document.getElementById('leavetype').options[document.getElementById('leavetype').selectedIndex].id)-parseFloat(document.getElementById('newleavedays').value)).toFixed(2);
				}
			})	
	
	}
}

function applyleavedatecheck5()
{
				var datef = document.getElementById('getcontractstartdate').value;
				var datet = document.getElementById('startdate').value;
				var datefday = datef.substring(0,2) * 1;
				var datetday = datet.substring(0,2) * 1;
				var datefmonth = datef.substring(3,5) * 1;
				var datetmonth = datet.substring(3,5) * 1;
				var datefyear = datef.substring(6,10) * 1;
				var datetyear = datet.substring(6,10) * 1;
				
				if(datefyear > datetyear)
				{
				 alert("Leave Date Should be Within Contract Period");
				 return false;
				}
				else if( datefmonth > datetmonth && datefyear == datetyear)
				{
				 alert("Leave Date Should be Within Contract Period");
				 return false;
				}
				else if(datefday > datetday &&  datefmonth == datetmonth && datefyear == datetyear)
				{
				 alert("Leave Date Should be Within Contract Period");
				 return false;
				}
				else{
					return true;
				}
}


function applyleavedatecheck()
{
				var datef = document.getElementById('enddate').value;
				var datet = document.getElementById('getcontractenddate').value;
				var datefday = datef.substring(0,2) * 1;
				var datetday = datet.substring(0,2) * 1;
				var datefmonth = datef.substring(3,5) * 1;
				var datetmonth = datet.substring(3,5) * 1;
				var datefyear = datef.substring(6,10) * 1;
				var datetyear = datet.substring(6,10) * 1;
				
				if(datefyear > datetyear)
				{
				 alert("Leave Date Should be Within Contract Period");
				 return false;
				}
				else if( datefmonth > datetmonth && datefyear == datetyear)
				{
				 alert("Leave Date Should be Within Contract Period");
				 return false;
				}
				else if(datefday > datetday &&  datefmonth == datetmonth && datefyear == datetyear)
				{
				 alert("Leave Date Should be Within Contract Period");
				 return false;
				}
				else{
					return true;
				}
}

function applyleavedatecheck2()
{
				var datef = document.getElementById('startdate').value;
				var datet = document.getElementById('enddate').value;
				var datefday = datef.substring(0,2) * 1;
				var datetday = datet.substring(0,2) * 1;
				var datefmonth = datef.substring(3,5) * 1;
				var datetmonth = datet.substring(3,5) * 1;
				var datefyear = datef.substring(6,10) * 1;
				var datetyear = datet.substring(6,10) * 1;
				
				if(datefyear > datetyear)
				{
				 alert("Start Date Should Be Earlier Than End Date");
				 return false;
				}
				else if( datefmonth > datetmonth && datefyear == datetyear)
				{
				 alert("Start Date Should Be Earlier Than End Date");
				 return false;
				}
				else if(datefday > datetday &&  datefmonth == datetmonth && datefyear == datetyear)
				{
				 alert("Start Date Should Be Earlier Than End Date");
				 return false;
				}
				else{
					return true;
				}
}


function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
function getleave(placeno)
{
	ajaxFunction(document.getElementById('leavelist'),'placementleaveajax.cfm?<cfif url.type eq 'Edit' or url.type eq 'Delete'>id=#url.placementno#&</cfif>uuid=#URLENCODEDFORMAT(newuuid)#&placementno='+placeno);
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

function addleave(id,atype)
{
	if(atype == 'delete')
	{
		var addleaveurl = 'placementleaveajax.cfm?uuid=#URLENCODEDFORMAT(newuuid)#&action=delete&id='+id+'&placementno='+document.getElementById('placementno').value;
	}
	else if(atype == 'add')
	{
		
		var getleavetype = escape(document.getElementById('leavetype').value);
		var getstartdate = escape(document.getElementById('startdate').value);
		var getstartampm = escape(document.getElementById('startampm').value);
		var getenddate = escape(document.getElementById('enddate').value);
		var getendampm = escape(document.getElementById('endampm').value);
		var getleavebal = escape(document.getElementById('leavebal').value);
		var getleavedays = escape(document.getElementById('leavedays').value);
		var getclaimableamt= escape(document.getElementById('claimableamt').value);
		var getremarks= escape(document.getElementById('remarks').value);
		
		var addleaveurl = 'placementleaveajax.cfm?<cfif url.type eq 'Edit' or url.type eq 'Delete'>id=#url.placementno#&</cfif>uuid=#URLENCODEDFORMAT(newuuid)#&action=add&leavetype='+getleavetype+'&startdate='+getstartdate+'&startampm='+getstartampm+'&enddate='+getenddate+'&endampm='+getendampm+'&leavebal='+getleavebal+'&leavedays='+getleavedays+'&claimableamt='+getclaimableamt+'&remarks='+getremarks+'&placementno='+document.getElementById('placementno').value;
		var msg = '';
		
		if(trim(getstartdate) == '')
		{
			msg = msg + 'Start Date is Required\n';
		}
		if(trim(getenddate) == '')
		{
			msg = msg + 'End Date is Required\n';
		}
		if(parseFloat(trim(getleavedays)) == 0.00)
		{
			msg = msg + 'Leave Taken Should Not Be Zero\n';
		}
		if(parseFloat(trim(getleavebal)) < 0)
		{
			msg = msg + 'Leave Balance is Not Enough\n';
		}
		if(msg == '')
		{
			if(applyleavedatecheck())
			{
				if(applyleavedatecheck2())
				{
						if(applyleavedatecheck5())
						{
						}
						else
						{
							return false;
						}
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		else
		{
			alert(msg);
			return false;
		}
		
	}

	new Ajax.Request(addleaveurl,
			{
				method:'get',
				onSuccess: function(getdetailback){
					document.getElementById('leavelist').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(response){ 
					alert(response.statusText); },		
			
				onComplete: function(transport){
					 try{
						alert(document.getElementById('alerttext').value);
					}
					catch(err)
					{
					}
					
				}
			})		
}
	
</script>


</head>

<body>
            	


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
                SELECT * FROM placement where placementno='#getplacementno.placementno#'
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
                    <cfset ratetype = getplacement.clienttype>
                    <cfset empname = getplacement.empname>
                    <cfset contractstartdate = dateformat(getplacement.startdate,"dd/mm/yyyy")>
                    <cfset contractenddate = dateformat(getplacement.completedate,"dd/mm/yyyy")>
<cfquery name="insertleave" datasource="#dts#">
                    INSERT INTO leavelisttemp
                    (
                    placementno,
                    leavetype,
                    days,
                    claimamount,
                    remarks,
                    startdate,
                    startampm,
                    enddate,
                    endampm,
                    leavebalance,
                    contractenddate,
                    claimed,
                    submitted,
                    submited_on,
                    submit_date,
                    claimremark,
                    uuid
                    )
                    SELECT 
                    placementno,
                    leavetype,
                    days,
                    claimamount,
                    remarks,
                    startdate,
                    startampm,
                    enddate,
                    endampm,
                    leavebalance,
                    contractenddate,
                    claimed,
                    submitted,
                    submited_on,
                    submit_date,
                    claimremark,
                    "#newuuid#"
                    FROM leavelist 
                    WHERE 
                    placementleaveid = '#url.placementno#'
                    </cfquery>
            
           </cfif>  


<h1>#title#</h1>


  <h4><cfif getpin2.h1H10 eq 'T'><a href="placementleavetable.cfm?type=Create">Creating a Placement Leave</a> </cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="s_placementleave.cfm?type=Placement">Search For Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleave.cfm">Summary Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleave1.cfm">Detail Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleavemarkclaim.cfm">Leave Claim Status Report</a></cfif></h4>


<cfform name="placementleave" action="/default/maintenance/Placementleavetable/placementleaveprocess.cfm" method="post" >

    	<input type="hidden" name="mode" value="#mode#" >
        <input type="hidden" name="id" value="#id#" >
        <input type="hidden" name="newuuid" value="#newuuid#" >

    <table align="center" width="80%">

    	<tr>
        	<th>Placement number</th>
            <td><!---<input type="text" name="placementno" id="placementno" value="#placementno#">--->  
            <cfif mode eq "create">            
                    	<cfinput type="text" id="placementno" name="placementno" value="#xplacementno#" required="yes" message="Placement number is invalid" readonly="Yes" > &nbsp;<input type="button" name="search_btn" id="search_btn" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findplacementno');" />
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
       
        <div id="leavelist"> <cfif url.type eq 'Edit' or url.type eq 'Delete'>
        
<cfquery name="getplacementinfo" datasource="#dts#">
        SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#">
        </cfquery>
      
      <table align="center" width="100%">
        <tr>
        <td></td>
        <th><div align="left">Claimable From</div></th>
        <th>Entitlement</th>
        <th>Carry Forward</th>
        <th>Taken</th>
        <th>Balance</th>
        <th>Outstanding Claimables</th>
        </tr>
        <cfquery name="getleave" datasource="#dts#">
        Select * from iccostcode order by costcode
        </cfquery>
		<cfset leavearray = arraynew(1)>
        <cfset leavedesparray = arraynew(1)>
        <cfset leavebalarray = arraynew(1)>
		<cfset leaveclaimablearray = arraynew(1)>
        <cfloop query="getleave">
        
        
        <cfif evaluate('getplacementinfo.#getleave.costcode#entitle') eq "Y">
        <cfquery name="gettotaltaken" datasource="#dts#">
        SELECT sum(days) as takendays,sum(if(claimed = "N",claimamount,0)) as outstandingclaim FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#"> and leavetype = "#getleave.costcode#"
       <!---  and contractenddate = "#dateformat(getplacementinfo.completedate,'YYYY-MM-DD')#" --->
        </cfquery>
        
        <th><input type="hidden" name="getcontractenddate" id="getcontractenddate" value="#dateformat(getplacementinfo.completedate,'dd/mm/yyyy')#" /><input type="hidden" name="getcontractstartdate" id="getcontractstartdate" value="#dateformat(getplacementinfo.startdate,'dd/mm/yyyy')#" />#getleave.desp#</th>
        <td align="left">#dateformat(evaluate('getplacementinfo.#getleave.costcode#date'),'dd/mm/yyyy')#</td>
        <td align="right">#numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__')#</td>
        <td align="right"><cfif getleave.costcode eq "AL" ><cfset cf = evaluate('getplacementinfo.#getleave.costcode#bfdays')><cfelse><cfset cf = 0 ></cfif><cfif numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') neq 0>#numberformat(cf,'.__')#</cfif></td>
        <td align="right">#numberformat(gettotaltaken.takendays,'.__')#</td>
        <cfset balance = numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') + numberformat(cf,'.__') - numberformat(gettotaltaken.takendays,'.__')>
        <td align="right"><cfif numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') neq 0>#numberformat(balance,'.__')#</cfif></td>
        <td align="right"><cfif claimable eq "Y"><cfset arrayappend(leaveclaimablearray,'Y')>#numberformat(gettotaltaken.outstandingclaim,'.__')#<cfelse>N/A<cfset arrayappend(leaveclaimablearray,'N')></cfif></td>
        </tr>
        <cfset arrayappend(leavearray,'#getleave.costcode#')>
        <cfset arrayappend(leavedesparray,'#getleave.desp#')>
        <cfif numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') neq 0>
        <cfset arrayappend(leavebalarray,'#numberformat(balance,'.__')#')>
        <cfelse>
        <cfset arrayappend(leavebalarray,'999')>
		</cfif>
		</cfif>
        </cfloop>
        </table>
        <cfif ArrayLen(leavearray) neq 0>
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
        <th>Claimable</th>
        <th>Remarks</th>
        <th>Contract End Date</th>
        <th>Action</th>
        </tr>
        <tr>
        
        <td>
        <select name="leavetype" id="leavetype" onchange="if(parseFloat(this.options[this.selectedIndex].id) == 999){document.getElementById('leavebal').style.display = 'none';} else {document.getElementById('leavebal').style.display = 'block';}document.getElementById('leavebal').value=parseFloat(this.options[this.selectedIndex].id)-parseFloat(document.getElementById('leavedays').value);if(this.options[this.selectedIndex].title == 'Y'){document.getElementById('claimableamt').style.display='block';document.getElementById('claimableamt').selectedIndex=1;}else{document.getElementById('claimableamt').style.display='none';document.getElementById('claimableamt').selectedIndex=0;}dateajaxfunction();">
        <cfloop from="1" to="#arraylen(leavearray)#" index="i">
        <option value="#leavearray[i]#" id="#leavebalarray[i]#" title="#leaveclaimablearray[i]#">#leavedesparray[i]#</option>
        </cfloop>
        </select>
        </td>
        <td>
        <input type="text" name="startdate" id="startdate"  size="12" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('startdate'));">
        </td>
        <td>
        <select name="startampm" id="startampm" onchange="dateajaxfunction();">
        <option value="FULL DAY">FULL DAY</option>
        <option value="AM">AM</option>
        <option value="PM">PM</option>
        </select>
        </td>
        <td>
        <input type="text" name="enddate" id="enddate" size="12" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('enddate'));">
        </td>
        <td>
        <select name="endampm" id="endampm"  onchange="dateajaxfunction();">
        <option value="FULL DAY">FULL DAY</option>
        <option value="AM">AM</option>
        <option value="PM">PM</option>
        </select>
        </td>
        <td>
        <input type="text" name="leavedays" id="leavedays" size="5" value="0.00" onkeyup="document.getElementById('leavebal').value=(parseFloat(document.getElementById('leavetype').options[document.getElementById('leavetype').selectedIndex].id)-parseFloat(this.value)).toFixed(2);" />
        </td>
         <td>
        <input type="text" name="leavebal" id="leavebal" size="5" readonly="readonly" value="#numberformat(leavebalarray[1],'.__')#" <cfif val(leavebalarray[1]) eq 999> style="display:none"</cfif> />
        </td>
        <td>
        <select name="claimableamt" id="claimableamt"   <cfif leaveclaimablearray[1] eq "N">style="display:none"</cfif>>
        <option value="N" <cfif leaveclaimablearray[1] eq "N">Selected</cfif>>N</option>
        <option value="Y"  <cfif leaveclaimablearray[1] eq "Y">Selected</cfif>>Y</option>
        </select>
        </td>  
        <td>
        <input type="text" name="remarks" id="remarks" value="" /></td><td></td><td><input type="button" name="add_btn" id="add_btn" value="Add" onclick="addleave('','add');document.getElementById('search_btn').disabled==true;" /></td>
      
        </tr> 
        <cfquery name="getleavelist" datasource="#dts#">
        SELECT * FROM (
        SELECT * FROM leavelisttemp WHERE uuid = "#newuuid#" order by id) as a
        LEFT JOIN
        (SELECT desp, costcode FROM iccostcode) as b
        on a.leavetype = b.costcode
        ORDER BY a.contractenddate desc, a.leavetype, a.startdate desc
        </cfquery>
        <cfloop query="getleavelist">
        <tr >
        <td>#getleavelist.desp#</td>
        <td>#dateformat(getleavelist.startdate,'dd/mm/yyyy')#</td>
        <td>#getleavelist.startampm#</td>
        <td>#dateformat(getleavelist.enddate,'dd/mm/yyyy')#</td>
        <td>#getleavelist.endampm#</td>
        <td>#numberformat(getleavelist.days,'.__')#</td>
        <td></td>
        <td>#getleavelist.claimamount#</td>
        <td>#getleavelist.remarks#</td>
         <td<cfif huserid eq "adminbeps" or huserid eq "ultracai"> style="cursor:pointer"  onclick="editdate('#getleavelist.id#')"</cfif>>#dateformat(getleavelist.contractenddate,'dd/mm/yyyy')#</td>
        <td><a style="cursor:pointer" onclick="if(confirm('Are You Sure You Want To Delete?')){addleave('#getleavelist.id#','delete')}"><u>Delete</u></a></td>
        </tr>
        </cfloop>
        </table>
        <cfelse>
		<h1>No Any Entitle Leave Found</h1>
		</cfif>
        </cfif>
        </div>
       
        </td>
      </tr>
        <tr>
        	<td colspan="100%" align="center"><input name="submit" type="submit" value="#button#"></td>            
        </tr>

    </table>
    <input type="hidden" id="editdateid" name="editdateid" value="" />
</cfform>
<div id="ldayscal"></div>
</body>
</html>
    </cfoutput>
<cfwindow center="true" width="700" height="400" name="findplacementno" refreshOnShow="true" title="Find Placement number" initshow="false" source="findplacementno.cfm?type=placementno" />

<cfwindow center="true" width="500" height="200" name="editdate" refreshOnShow="true" title="Edit Contract End Date" initshow="false" source="editdate.cfm?uuid=#newuuid#&id={editdateid}" />
