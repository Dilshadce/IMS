<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
</head>
<body>
	
<h1>Create Job Sheet</h1>
<h4>
<a href="createjob.cfm?type=Create">Creating New Job Sheet</a> || 
<a href="viewjob.cfm">List all Job Sheet</a> || 
<a href="s_createjob.cfm">Search For Job Sheet</a> ||
</h4>
<hr>

<cfquery name="getct" datasource="#dts#">
	Select * from artran 
	where refno='#form.refno#' 
    and type = 'INV'
	order by wos_date desc limit 1
</cfquery>

<cfquery name="getcso" datasource="#dts#">
	Select * from cso
</cfquery>

<cfquery name="getservicetype" datasource="#dts#">
	Select * from service_type
</cfquery>


<div align="center">
<table width="75%" border="0">
	<tr bgcolor="#CCCCCC"> 
    	<td colspan="2"><h1 align="center">Invoice Information</h1></td>
    </tr>
    <tr> 
      	<td width="75%"><cfoutput><strong><font size="2">Invoice No:</font></strong>#getct.refno#</cfoutput></td>
    </tr>
    <tr> 
      	<td width="75%"><cfoutput><strong><font size="2">Vehicle No:</font></strong>#getct.rem5#</cfoutput></td>
    </tr>
    <tr> 
      	<td width="75%"><cfoutput><strong><font size="2">Customer Name:</font></strong>#getct.name#</cfoutput></td>
    </tr>
	<tr> 
      	<td width="75%"><cfoutput><strong><font size="2">Contract Period</font></strong>#getct.rem6#</cfoutput></td>
    </tr>
    <tr> 
      	<td width="75%"><cfoutput><strong><font size="2">Contract Service</font></strong>#getct.rem7#</cfoutput></td>
    </tr>
    
</table>
</div>
<br>
<cfform name="createjob" action="createjobprocess.cfm" method="post">
<table align="center" class="data">
	<tr> 
      	<th colspan="4">Select Job Type</th>
    </tr>
    <tr> 
      	<th width="121">Invoice No</th>
      	<td width="162"><cfoutput><input type="text" value="#form.refno#" size="12" disabled>
		<input type="hidden" name="refno" id="refno" value="#form.refno#"></cfoutput></td>
	</tr>	
    <tr> 
      	<th>CSO</th>
      	<td><select name="csoid">
	          	<option value="-">Please Select</option>
	          	<cfoutput query="getcso">
					<option value="#getcso.csoid#">#getcso.desp#</option>
				</cfoutput>
        	</select>
		</td>
      	<th>Assigned by:</th>
      	<td>
			<cfoutput>#HUserName# 
          		<input type="hidden" name="assby" value="#HUserName#">
        	</cfoutput>
		</td>
    </tr>
    <tr> 
      	<th>Date of Service</th>
      	<td><cfinput name="servicedate" id="servicedate" required="yes" validate="eurodate" message="Please Enter Your Date !" type="text" size="10" maxlength="10">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(servicedate);">&nbsp;(DD/MM/YYYY) </td>
      	<th>Time :</th>
      	<td>
			<select name="apptime" id="apptime">
          		<option value="9.00AM">9.00AM</option>
          		<option value="9.30AM">9.30AM</option>
          		<option value="10.00AM">10.00AM</option>
          		<option value="10.30AM">10.30AM</option>
				<option value="11.00AM">11.00AM</option>
				<option value="12.00NN">12.00NN</option>
          		<option value="2.00PM">2.00PM</option>
          		<option value="2.30PM">2.30PM</option>
          		<option value="3.00PM">3.00PM</option>
          		<option value="3.30PM">3.30PM</option>
          		<option value="4.00PM">4.00PM</option>
          		<option value="4.30PM">4.30PM</option>
        	</select>
		</td>
    </tr>
    <tr> 
      	<th>Type of Service</th>
      	<td>
			<select name="servicetype">
          		<option value="-">Please Select</option>
				<cfoutput query="getservicetype">
					<option value="#getservicetype.servicetypeid#">#getservicetype.desp#</option>
				</cfoutput>
        	</select>
		</td>
      	
    </tr>
    <tr> 
      	<th>Job Description</th>
      	<td colspan="3" nowrap><textarea name="instruction" cols="50" rows="5"></textarea></td>
    </tr>
    <tr> 
      	<td></td>
      	<td align="right" nowrap>&nbsp;</td>
      	<td align="right" nowrap>&nbsp;</td>
      	<td align="right" nowrap><cfoutput><input name="btnhistory" type="button" value="History" onClick="window.open('historyresult.cfm?refno=#form.refno#');"></cfoutput>&nbsp;<input name="submit" type="submit" value="Submit"></td>
    </tr>
</table>
</cfform>
</body>
</html>
