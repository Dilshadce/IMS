<title>Vital Report</title>
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
        	}
    		} 
			
									}
</script>
<h3>
	<a><font size="2">Vital Report</font></a>
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
SELECT custno,name from #target_arcust# order by custno
</cfquery>
    
 <cfform name="vitalreport" id="vitalreport" action="reportprocess.cfm" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
<table align="center">
 <tr>
 <th>Created By From</th>
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
 <th>Created By To</th>
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
 <td><select name="comfrm" id="comfrm" onChange="document.getElementById('comto').selectedIndex=this.selectedIndex;">
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
 <cfquery name="getdept" datasource="#dts#">
 SELECT department FROM placement WHERE department <> "" GROUP by department Order By department
 </cfquery>
 <tr>
 <th>Deparment From</th>
 <td>:</td>
 <td>
 <select name="deptfrom" id="deptfrom"  onchange="document.getElementById('deptto').selectedIndex = this.selectedIndex;">
 <option value="">Choose a Department</option>
 <cfloop query="getdept">
 <option value="#getdept.department#">#getdept.department#</option>
 </cfloop>
 </select>&nbsp;<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finddept');" />
 </td>
 </tr>
  <tr>
 <th>Deparment To</th>
 <td>:</td>
 <td>
 <select name="deptto" id="deptto">
 <option value="">Choose a Department</option>
 <cfloop query="getdept">
 <option value="#getdept.department#">#getdept.department#</option>
 </cfloop>
 </select>&nbsp;<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finddept');" />
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
 <th>Headquarter From</th>
 <td>:</td>
 <td><select name="hdfrm" id="hdfrm" onChange="document.getElementById('hdto').selectedIndex=this.selectedIndex;">
 <option value="">Choose a Headquarter</option>
<cfloop query="getCust">
<option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
</cfloop>
</select>&nbsp;
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='frm';ColdFusion.Window.show('findcustomer2');" /></td>
</tr>
<tr>
 <th>Headquarter To</th>
 <td>:</td>
 <td><select name="hdto" id="hdto">
  <option value="">Choose a Headquarter</option>
<cfloop query="getCust">
<option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
</cfloop>
</select>&nbsp;
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findcustomer2');" /></td>
 </tr>
<tr>
<th>Additional Columns</th>
<td>:</td>
<td>
<input type="checkbox" name="totalbill" id="totalbill" value="" /> Total Billing after GST
</td>
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
  
  <cfwindow center="true" width="650" height="500" name="findcustomer2" refreshOnShow="true"
        title="Find Headquarters" initshow="false"
        source="findcustomer2.cfm?type=target_arcust&fromto={fromto}" />
          <cfwindow center="true" width="650" height="500" name="finddept" refreshOnShow="true"
        title="Find Department" initshow="false"
        source="finddept.cfm?fromto={fromto}" />