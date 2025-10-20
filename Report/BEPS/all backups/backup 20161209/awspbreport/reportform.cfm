<title>AWS & PB Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/scripts/ajax.js"></script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<cfoutput>
<script type="text/javascript">
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
			
									}
</script>
<h3>
	<a><font size="2">AWS & PB Report</font></a>
</h3>
 <cfquery name="userlist" datasource="#dts#">
Select userid from main.users where userbranch = "#dts#" 
and usergrpid <> "super"
ORDER BY userid
 </cfquery>
 
 <cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
    <cfset completedate = dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>
    
    <cfquery name="getCust" datasource="#dts#">
SELECT custno,name from #target_arcust#
</cfquery>
    
 <cfform name="vitalreport" id="vitalreport" action="reportprocess.cfm" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
<table align="center">
 <tr>
 <th>User</th>
 <td>
: 
 </td>
<td>
<select name="createdfrm" id="createdfrm" onchange="document.getElementById('createdto').selectedIndex = this.selectedIndex;">
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
: 
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
<tr>
 <th>Customer From</th>
 <td>:</td>
 <td><select name="comfrm" id="comfrm"  onChange="document.getElementById('comto').selectedIndex=this.selectedIndex;">
 <option value="">Choose a Customer</option>
<cfloop query="getCust">
<option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
</cfloop>
</select>&nbsp;
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='frm';ColdFusion.Window.show('findcustomer');" /></td>
</tr>
<tr>
 <th>Customer To</th>
 <td>:</td>
 <td><select name="comto" id="comto">
  <option value="">Choose a Customer</option>
<cfloop query="getCust">
<option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
</cfloop>
</select>&nbsp;
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findcustomer');" /></td>
 </tr>
   <cfquery name="getemployee" datasource="#dts#">
        SELECT empno,empname FROM placement WHERE empno <> "" GROUP BY empno ORDER BY empno
        </cfquery>
  <tr> 
        	<th>Employee From</th>
            <td>:</td>
            <td>
            	<div id="empfromfield"><select name="empfrom" id="empfrom" onChange="document.getElementById('empto').selectedIndex=this.selectedIndex;">
	          				<option value="">Choose an Employee</option>
					<!--- <option value="">Choose a Location</option> --->
                    <cfloop query="getemployee"> 
                    	<option value="#getemployee.empno#">#getemployee.empno# - #getemployee.empname#</option>
                    </cfloop>
                </select><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='empfrom';ColdFusion.Window.show('findplacementno');" /></div>
            </td>
		</tr>
        
		<tr>
        	<th>Employee To</th>
            <td>:</td>
            <td>
            	<div id="emptofield"><select name="empto" id="empto">
	          				<option value="">Choose an Employee</option>
					<!--- <option value="">Choose a Location</option> --->
                    <cfloop query="getemployee"> 
                    	<option value="#getemployee.empno#">#getemployee.empno# - #getemployee.empname#</option>
                    </cfloop>
                </select><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='empto';ColdFusion.Window.show('findplacementno');" /></div>
            </td>
            
        </tr>
<tr>
<th>Date From</th>
<td>:</td>
<td><cfinput type="text" name="datefrom" id="datefrom" value="#startdate#" required="yes" validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));"></td>
</tr>
<tr>
<th>Date To</th>
<td>:</td>
<td><cfinput type="text" name="dateto" id="dateto" value="#completedate#" required="yes" validate="eurodate" validateat="onsubmit">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));"></td>
</tr>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Submit" />
</td>
</tr>
</table>
</cfform>
</cfoutput>
  <cfwindow center="true" width="650" height="500" name="findcustomer" refreshOnShow="true"
        title="Find Customer" initshow="false"
        source="findcustomer.cfm?type=target_arcust&fromto={fromto}" />
        <cfwindow center="true" width="700" height="400" name="findplacementno" refreshOnShow="true" title="Find Employee" initshow="false" source="findplacementnonew.cfm?type={fromto}" />