<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
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

<cfquery datasource='#dts#' name="getcustinfo">
	Select * from #target_arcust# where custno = "#form.custno#"
</cfquery>

<!--- <cfquery name="getct" datasource="#dts#">
	Select * from ictran where custno = "#form.custno#" and itemno = "MAINTENANCE-1Y" and type = "INV"
</cfquery> --->
<cfquery name="getct" datasource="#dts#">
	Select * from artran 
	where custno = '#form.custno#' 
	and frem9 = 'T' and type = 'INV'
	order by wos_date desc limit 1
</cfquery>

<cfquery name="getcso" datasource="#dts#">
	Select * from cso
</cfquery>

<cfquery name="getservicetype" datasource="#dts#">
	Select * from service_type
</cfquery>

<!--- <cfif getct.recordcount GT 0>
	<cfset duedate = DateAdd("d", 372 , getct.wos_date)>
	<cfset duedate2 = datediff("d", now(), duedate)>
<cfelse>
	<cfset duedate = 0>
	<cfset duedate2 =0>
</cfif> --->
<cfif getct.recordcount GT 0 and getct.rem10 neq "" and getct.rem11 neq "">
	<cfset startdate=createDate(ListGetAt(getct.rem10,3,"/"),ListGetAt(getct.rem10,2,"/"),ListGetAt(getct.rem10,1,"/"))>
	<cfset duedate=createDate(ListGetAt(getct.rem11,3,"/"),ListGetAt(getct.rem11,2,"/"),ListGetAt(getct.rem11,1,"/"))>
	<cfset duedate2 = datediff("d", now(), duedate)>
<cfelse>
	<cfset startdate="-">
	<cfset duedate = 0>
	<cfset duedate2 =0>
</cfif>

<div align="center">
<table width="75%" border="0">
	<tr bgcolor="#CCCCCC"> 
    	<td colspan="2"><h1 align="center">Customer Information</h1></td>
    </tr>
    <tr> 
      	<td width="75%"><cfoutput><strong><font size="2">Customer Name:</font></strong>#getcustinfo.name#</cfoutput></td>
    </tr>
	<cfif getct.recordcount gt 0>
		<tr> 
	    	<td><cfoutput><strong><font size="2">Date Of Purchace:</font></strong> - <cfif getct.rem10 neq "" and getct.rem11 neq "">#dateformat(startdate,"dd/mm/yyyy")#</cfif></cfoutput></td>
	    </tr>
		<cfif duedate2 gte 1>
		    <tr> 
		    	<td><cfoutput><strong><font size="2">Contract Valid Till:</font></strong> - <cfif getct.rem10 neq "" and getct.rem11 neq "">#dateformat(duedate,"dd/mm/yyyy")# - (#duedate2# days)</cfif></cfoutput></td>
		    </tr>
		</cfif>
	<cfelse>
		<tr> 
	    	<td><strong><font size="2">Date Of Purchace:</font></strong> - </td>
	    </tr>
	</cfif>
    <tr> 
      	<td><cfoutput><strong><font size="2">Status:</font></strong></cfoutput> 
        <strong> 
		<cfif getct.recordcount gt 0 and getct.rem10 neq "" and getct.rem11 neq "">
			<cfif duedate2 gte 1 >
				<font color="#0000FF" size="2">Valid</font> 
			<cfelse>
				<font color="#FF0000" size="2">Expired</font> 
			</cfif>
		<cfelse>
			<font color="#FF0000" size="2">No Contract</font>
		</cfif>
		</strong>
		</td>
    </tr>
    <!---<tr> 
      	<td></strong><p><strong></strong><strong><font size="2">Onsite(s) Balance:</font></strong>10</p></td>
    </tr>--->
</table>
</div>
<br>
<cfform name="createjob" action="createjobprocess.cfm" method="post">
<table align="center" class="data">
	<tr> 
      	<th colspan="4">Select Job Type</th>
    </tr>
    <tr> 
      	<th width="121">Customer ID</th>
      	<td width="162"><cfoutput><input type="text" value="#form.custno#" size="12" disabled>
		<input type="hidden" name="custno1" value="#form.custno#"></cfoutput></td>
	</tr>	
    <tr> 
      	<th>CSO</th>
      	<td><select name="csoid">
	          	<option value="-">Please Select</option>
	          	<!--- <option value="Edwin">Edwin</option>
				<option value="JunYong">Jun Yong</option>
				<option value="Lee">Lee</option>
				<option value="Seah">Seah</option>
				<option value="Stella">Stella</option>
				<option value="WeeSiong">Wee Siong</option>
	          	<option value="others">Others</option> --->
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
          		<!--- <option value="tacc1">Training - Acc 1</option>
          		<option value="tacc2">Training - Acc 2</option>
				<option value="tstk1">Training - Stk 1</option>
          		<option value="tstk2">Training - Stk2</option>
				<option value="tpay1">Training - Pay 1</option>
				<option value="tpay2">Training - Pay 2</option>
				<option value="tass1">Training - Ass 1</option>
				<option value="tass2">Training - Ass 2</option>
				<option value="tpos1">Training - Pos 1</option>
				<option value="tpos2">Training - Pos 2</option>
				<option value="install">Installation</option>
				<option value="install-O2">Installation - O2</option>
          		<option value="onsite">Onsite</option>
          		<option value="customization">Customization</option>
          		<option value="others">Others</option> --->
				<cfoutput query="getservicetype">
					<option value="#getservicetype.servicetypeid#">#getservicetype.desp#</option>
				</cfoutput>
        	</select>
		</td>
      	<th>Status</th>
		<td>
			<select name="s_status">
          		<option value="1">New</option>
          		<option value="2">Follow Up</option>
        	</select>
		</td>
    </tr>
    <tr> 
      	<th>Collect Payment</th>
      	<td><p><label><input name="collect" type="radio" value="1" checked>Yes</label>
			<input type="radio" name="collect" value="0">No</label><br></p>
        </td>

      	<th>Qty</th>
      	<td><cfinput name="qty" id="qty" required="yes" message="Please Enter Qty" type="text" size="10" maxlength="10"></td>

    </tr>
    <tr> 
      	<th>Job Description</th>
      	<td colspan="3" nowrap><textarea name="instruction" cols="50" rows="5"></textarea></td>
    </tr>
    <tr> 
      	<td></td>
      	<td align="right" nowrap>&nbsp;</td>
      	<td align="right" nowrap>&nbsp;</td>
      	<td align="right" nowrap><cfoutput><input name="btnhistory" type="button" value="History" onClick="window.open('historyresult.cfm?custno=#form.custno#');"></cfoutput>&nbsp;<input name="submit" type="submit" value="Submit"></td>
    </tr>
</table>
</cfform>
</body>
</html>
