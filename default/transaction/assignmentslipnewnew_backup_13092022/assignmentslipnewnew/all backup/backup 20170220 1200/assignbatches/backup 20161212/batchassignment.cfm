
<html>
<head>
<title>Assign Batches</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>



<body>

	<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
	
	<!--- <cfif isdefined("URL.Type")> --->
		
<h1><cfoutput>Assign Batches</cfoutput></h1>
		
<cfoutput>
	<h4>
		<a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable2.cfm?type=Create">Creating a Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable.cfm?">List all Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/s_Assignmentsliptable.cfm?type=Assignmentslip">Search For Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/assignbatches/batchassignment.cfm">Assign Batch Control</a>
        || <a href="/default/transaction/assignmentslipnewnew/assignbatches/s_batchtable.cfm">List Batch Control</a>
        <!--- || <a href="/default/transaction/assignmentslipnewnew/printcheque.cfm">Print Claim Cheque</a>
        || <a href="/default/transaction/assignmentslipnewnew/printclaim.cfm">Print Claim Voucher</a>
        || <a href="/default/transaction/assignmentslipnewnew/generatecheqno.cfm">Record Claim Cheque No</a>
         || <a href="/default/transaction/assignmentslipnewnew/definecheqno.cfm">Predefined Cheque No</a> --->
	</h4>
</cfoutput>

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
 <cfquery name="userlist" datasource="#dts#">
Select userid from main.users where userbranch = "#dts#" 
and usergrpid <> "super"
ORDER BY userid
 </cfquery>
 
 <cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
    <cfset completedate = dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>
    
    <cfquery name="getCust" datasource="#dts#">
SELECT custno,name from #target_arcust# limit 10
</cfquery>
    
 <cfform name="vitalreport" id="vitalreport" action="/default/transaction/assignmentslipnewnew/assignbatches/reportprocess.cfm" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
<table align="center">
<tr>
<th>Pay Day</th>
<td>:</td>
<td><select name="paydate" id="paydate" >
      <option value="paytra1">Normal Pay Out</option>
      <option value="paytran">Exception Pay Out</option>
      </select></td>
</tr>
<tr>
<th>Payment Type</th>
<td>:</td>
<td><select name="paymeth" id="paymeth" >
      <option value="B">Bank</option>
      <option value="Q">Cheque</option>
      <option value="C">Cash</option>
      </select></td>
</tr>
 <tr>
 <th>User</th>
 <td>
: 
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
 <td><select name="comfrm" id="comfrm">
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
            	<div id="empfromfield"><select name="empfrom" id="empfrom">
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
		<!--- This query is added by Edwin to display placement not processed --->
		<!---<cfquery name='getplacement' datasource="#dts#">
			Select placementno from assignmentslip where batches = "" and empno <> "" ORDER BY placementno
		</cfquery>--->
		
        <cfquery name="getplacement" datasource="#dts#">
        SELECT placementno FROM placement WHERE empno <> "" GROUP BY empno ORDER BY empno
        </cfquery>
  <tr> 
        	<th>Placement From</th>
            <td>:</td>
            <td>
            	<select name="placementfrom" id="placementfrom">
	          				<option value="">Choose a Placement</option>
					<!--- <option value="">Choose a Location</option> --->
                    <cfloop query="getplacement"> 
                    	<option value="#getplacement.placementno#">#getplacement.placementno#</option>
                    </cfloop>
                </select><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='placementfrom';ColdFusion.Window.show('findplacementnonew');" />
            </td>
		</tr>
        
		<tr>
        	<th>Placement To</th>
            <td>:</td>
            <td>
            	<select name="placementto" id="placementto">
	          				<option value="">Choose a Placement</option>
					<!--- <option value="">Choose a Location</option> --->
                    <cfloop query="getplacement"> 
                    	<option value="#getplacement.placementno#">#getplacement.placementno#</option>
                    </cfloop>
                </select><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='placementto';ColdFusion.Window.show('findplacementnonew');" />
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
<th>Giro Credit Date</th>
<td>:</td>
<td><cfinput type="text" name="giropaydate" id="giropaydate" value="" validate="eurodate" validateat="onsubmit" required="yes" message="Giro Pay Date is Required">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('giropaydate'));"></td>
</tr>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Submit" />
</td>
</tr>
</table>
</cfform>
</cfoutput>
  <cfwindow center="true" width="650" height="500" name="findcustomer" refreshOnShow="true" title="Find Customer" initshow="false" source="findcustomer.cfm?type=target_arcust&fromto={fromto}" />
  <cfwindow center="true" width="700" height="400" name="findplacementno" refreshOnShow="true" title="Find Employee" initshow="false" source="findplacementnonew.cfm?type={fromto}" />
  <cfwindow center="true" width="700" height="400" name="findplacementnonew" refreshOnShow="true" title="Find Placement" initshow="false" source="findplacementnonewnew.cfm?type={fromto}" />

</body>
</html>