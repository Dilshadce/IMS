<html>
<head>
<title>Placement Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script type="text/javascript" src="/scripts/ajax.js"></script>
</head>

<cfquery name="getlocation" datasource="#dts#">
		select * from icarea
	</cfquery>

<script type="text/javascript">
function getfield()
{
	var custfromdata = document.getElementById('custfrom').value;
	var custtodata = document.getElementById('custto').value;
	
	if(custfromdata != '' && custtodata != '')
	{
		var deptfromdata = document.getElementById('departmentfrom').value;
		var depttodata = document.getElementById('departmentto').value;
		var suppfromdata = document.getElementById('supervisorfrom').value;
		var supptodata = document.getElementById('supervisorto').value;
		var empfromdata = document.getElementById('empfrom').value;
		var emptodata = document.getElementById('empto').value;
		
		var getfieldurl = "fieldlist.cfm?type=";
		var fieldelementurl = "&custfrom="+escape(custfromdata)+"&custto="+escape(custtodata)+"&deptfrom="+escape(deptfromdata)+"&deptto="+escape(depttodata)+"&suppfrom="+escape(suppfromdata)+"&suppto="+escape(supptodata)+"&empfrom="+escape(empfromdata)+"&empto="+escape(emptodata) ;
		
		ajaxFunction(document.getElementById('deptfromfield'),getfieldurl+'departmentfrom'+fieldelementurl);
		ajaxFunction(document.getElementById('depttofield'),getfieldurl+'departmentto'+fieldelementurl);
		ajaxFunction(document.getElementById('suppfromfield'),getfieldurl+'supervisorfrom'+fieldelementurl);
		ajaxFunction(document.getElementById('supptofield'),getfieldurl+'supervisorto'+fieldelementurl);
		ajaxFunction(document.getElementById('empfromfield'),getfieldurl+'empfrom'+fieldelementurl);
		ajaxFunction(document.getElementById('emptofield'),getfieldurl+'empto'+fieldelementurl);
	}
}


function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
			if(fieldtype == 'custfrom')
			{
			document.getElementById('custto').options[idx].selected=true;		
			}
			else if(fieldtype == 'empfrom')
			{
			document.getElementById('empto').options[idx].selected=true;		
			}
        	}
    		} 
			 getfield();
			
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
  <h1 align="center"><cfoutput>Placement Leave Claim Submmission Report</cfoutput></h1>
<cfoutput>
  <h4><cfif getpin2.h1H10 eq 'T'><a href="placementleavetable.cfm?type=Create">Creating a Placement Leave</a> </cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="s_placementleave.cfm?type=Placement">Search For Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleave.cfm">Summary Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleave1.cfm">Detail Placement Leave</a></cfif><cfif getpin2.h1H30 eq 'T'>|| <a href="p_placementleavemarkclaim.cfm">Leave Claim Status Report</a></cfif></h4>
  </cfoutput>
<br>
<br>
<br>

<cfform action="l_placementleavemarkclaim.cfm" name="form" method="post" target="_blank">
<cfoutput>
<input type="hidden" name="fromto" id="fromto">
<input type="hidden" name="tran" id="tran" value="#target_arcust#">
</cfoutput>
  <table border="0" align="center" width="90%" class="data">

        <cfoutput>
        <tr>
    <td colspan="100%">

    <input type="radio" name="result" value="all">All<br/>
			<input type="radio" name="result" value="marked" checked>Marked<br/>
			<input type="radio" name="result" value="nomarked">Not Mark<br/>		</td>
    </tr>
    <cfquery name="getclaimableleave" datasource="#dts#">
SELECT costcode,desp from iccostcode where claimable = "Y" ORDER BY desp
</cfquery>
<tr>
<th>Type of Leave</th>
<td></td>
<td>
<select name="leavetype" id="leavetype">
<option value="">Choose Type of Leave</option>
<cfloop query="getclaimableleave">
<option value="#getclaimableleave.costcode#">#getclaimableleave.desp#</option>
</cfloop>
</select>
</td>
</tr>
   <tr>
      	<td colspan="5"><hr></td>
    </tr>
<cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
    <cfset completedate = dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>
        <tr> 
        	<th><cfoutput>Leave Taken Dates</cfoutput></th>
            <td><div align="center">From</div></td>
            <td colspan="2">
            	<cfinput type="text" name="datefrom" id="datefrom" validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));">
            </td>
		</tr>
        
		<tr>
        	<th>Leave Taken Dates</th>
            <td><div align="center">To</div></td>
            <td width="69%">
            	<cfinput type="text" name="dateto" id="dateto"  validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));">
            </td>
            
        </tr>
        
        
        <tr>
      	<td colspan="5"><hr></td>
    </tr>
    
            <tr> 
        	<th><cfoutput>Claim Dates</cfoutput></th>
            <td><div align="center">From</div></td>
            <td colspan="2">
            	<cfinput type="text" name="claimdatefrom" id="claimdatefrom" value=""validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('claimdatefrom'));">
            </td>
		</tr>
        
		<tr>
        	<th>Claim Dates</th>
            <td><div align="center">To</div></td>
            <td width="69%">
            	<cfinput type="text" name="claimdateto" id="claimdateto" value="" validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('claimdateto'));">
            </td>
            
        </tr>
        
        
        <tr>
      	<td colspan="5"><hr></td>
    </tr>
    
    
    

    <tr> 
        <th>Customer</th>
        <td><div align="center">From</div></td>
        <td><select name="custfrom" id="custfrom" onChange="document.getElementById('custto').selectedIndex=this.selectedIndex;getfield();">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='custfrom';ColdFusion.Window.show('findCustomer');" />

		</td>
    </tr>
    <tr> 
        <th>Customer</th>
        <td><div align="center">To</div></td>
        <td><select name="custto" id="custto" onChange="getfield();">
				<option value="">Choose a Customer</option>
				<cfloop query="getcust">
				<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='custto';ColdFusion.Window.show('findCustomer');" />

		</td>
    </tr>
        </cfoutput>
        <cfquery name="getdepartment" datasource="#dts#">
        SELECT department FROM placement WHERE department <> "" GROUP BY department ORDER BY department
        </cfquery>
    <tr style="display:none">
      	<td colspan="5"><hr></td>
    </tr>
    <tr style="display:none"> 
      <th width="20%"><cfoutput>Department</cfoutput></th>
      <td width="10%"> <div align="center">From</div></td>
      <td width="70%"><div id="deptfromfield"><select name="departmentfrom" id="departmentfrom"  onChange="document.getElementById('departmentto').selectedIndex=this.selectedIndex;getfield();">
          <option value=""><cfoutput>Choose a Department</cfoutput></option>
          <cfoutput query="getdepartment">
            <option value="#getdepartment.department#">#getdepartment.department#</option>
          </cfoutput> </select></div></td>
    </tr>
    <tr style="display:none">
      <th height="24" width="20%"><cfoutput>Department</cfoutput></th>
      <td width="10%"><div align="center">To</div></td>
      <td width="70%" nowrap> <div id="depttofield"><select name="departmentto" id="departmentto" onChange="getfield();">
          <option value=""><cfoutput>Choose a Deparment</cfoutput></option>
         <cfoutput query="getdepartment">
            <option value="#getdepartment.department#">#getdepartment.department#</option>
          </cfoutput> </select> </div></td>
	  </td>
    </tr>
    <tr style="display:none">
      	<td colspan="5"><hr></td>
    </tr>
<cfquery name="getsupervisor" datasource="#dts#">
        SELECT supervisor FROM placement WHERE supervisor <> "" GROUP BY supervisor ORDER BY supervisor
        </cfquery>
    <tr style="display:none"> 
        	<th><cfoutput>Supervisor</cfoutput></th>
            <td><div align="center">From</div></td>
            <td colspan="2">
            	<div id="suppfromfield"><select name="supervisorfrom" id="supervisorfrom" onChange="document.getElementById('supervisorto').selectedIndex=this.selectedIndex;getfield();">
	          				<option value="">Choose a Supervisor</option>
					
                    <cfoutput query="getsupervisor"> 
                    	<option value="#getsupervisor.supervisor#">#getsupervisor.supervisor#</option>
                    </cfoutput>
                </select></div>
            </td>
		</tr>
        
		<tr style="display:none">
        	<th>Supervisor</th>
            <td><div align="center">To</div></td>
            <td width="69%">
            	<div id="supptofield"><select name="supervisorto" id="supervisorto"  onChange="getfield();">
	          				<option value="">Choose a Supervisor</option>
					
                    <cfoutput query="getsupervisor"> 
                    	<option value="#getsupervisor.supervisor#">#getsupervisor.supervisor#</option>
                    </cfoutput>
                </select></div>
            </td>
            
        </tr>
        
        
        <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfquery name="getemployee" datasource="#dts#">
        SELECT empno,empname FROM placement WHERE empno <> "" GROUP BY empno ORDER BY empno
        </cfquery>
        <tr> 
        	<th><cfoutput>Employee</cfoutput></th>
            <td><div align="center">From</div></td>
            <td colspan="2">
            	<div id="empfromfield"><select name="empfrom" id="empfrom"  onChange="document.getElementById('empto').selectedIndex=this.selectedIndex;">
	          				<option value="">Choose an Employee</option>
					<!--- <option value="">Choose a Location</option> --->
                    <cfoutput query="getemployee"> 
                    	<option value="#getemployee.empno#">#getemployee.empno# - #getemployee.empname#</option>
                    </cfoutput>
                </select>&nbsp;<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='empfrom';ColdFusion.Window.show('findempno');" /></div>
            </td>
		</tr>
        
		<tr>
        	<th>Employee</th>
            <td><div align="center">To</div></td>
            <td width="69%">
            	<div id="emptofield"><select name="empto" id="empto">
	          				<option value="">Choose an Employee</option>
					<!--- <option value="">Choose a Location</option> --->
                    <cfoutput query="getemployee"> 
                    	<option value="#getemployee.empno#">#getemployee.empno# - #getemployee.empname#</option>
                    </cfoutput>
                </select>&nbsp;<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='empto';ColdFusion.Window.show('findempno');" /></div>
            </td>
            
        </tr>
      

    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
   
   
    <tr> 
      <td colspan="100%" align="center">
          <input type="Submit" name="Submit" value="Submit">
        </td>
    </tr>
  </table>
</cfform>
</body>
</html>
<cfwindow width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Customer" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        <cfwindow center="true" width="700" height="400" name="findempno" refreshOnShow="true" title="Find Employee" initshow="false" source="findempno.cfm?type={fromto}" />
