<html>
<head>
<title>Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
</head>

<script language="JavaScript">
	function validate()
	{
		if(document.form1.carno.value=='')
		{
			alert("Your Brand cannot be blank.");
			document.form1.brand.focus();
			return false;
		}
		return true;
	}
	
</script>
<body>
			
	<cfquery datasource='#dts#' name="getitem">
		Select * from vehicles where carno='#CFGRIDKEY#'
	</cfquery>
	<cfset carno=getitem.carno>
				
                <cfquery name="getexinsurance" datasource="#dts#">
SELECT itemno,desp from icitem
</cfquery>
	<cfset mode="Edit">
	<cfset title="Edit Vehicle">
	<cfset button="Edit">


<cfoutput>
	<h1>#title#</h1>
<h4>
<a href="vehicles.cfm">Create Vehicles Profile</a>||<a href="p_vehicles.cfm">Vehicles Listing</a>||<a href="vehiclereport.cfm">Vehicles History Report</a>||<a href="vehiclerenew.cfm">Vehicles Renew Report</a></h4>	
</cfoutput>

<cfform name="form1" action="editvehprocess.cfm" method="post" onsubmit="return validate()">
	<cfoutput><input type="hidden" name="mode" value="#mode#"></cfoutput>
  	<h1 align="center"><cfoutput>Vehicle Number #CFGRIDKEY#</cfoutput></h1>
  	
  	<table align="center" class="data" width="800">
    
    <cfoutput query="getitem">
    
    <tr>
<th>Customer Code</th>
<td colspan="3"><cfinput type="text" name="custcode" id="custcode" required="yes" value="#custcode#" readonly /></td>
</tr>
	<tr>
        <th width="100px">Customer Name</th>
<td width="150px"><input type="text" name="custname" id="custname" value="#custname#" /></td>
<th width="100px">Customer IC</th>
<td width="150px"><input type="text" name="custic" id="custic" value="#custic#" /></td>
</tr>
<tr>
  <th>Customer Address</th>
  <td colspan="3">
  <textarea name="custadd" id="custadd" cols="55" rows="2">#custadd#
  </textarea>  </td> 
</tr>
<tr>
  <th>Email Address</th>
  <td>
<input type="text" name="custemail" id="custemail" value="#getitem.custemail#" />  
</td> 
<th>Gender</th>
<td>
<select name="gender" id="gender">
<option value="female" <cfif getitem.gender eq "female"> selected</cfif>>Female</option>
<option value="male" <cfif getitem.gender eq "male"> selected</cfif>>Male</option>
</select></td>
</tr>
<tr>

<th>Marital Status</th>
<td>
<select name="marital" id="marital">
<option value="single"<cfif getitem.marstatus eq "single"> </cfif>>Single</option>
<option value="married"<cfif getitem.marstatus eq "married"> selected</cfif>>Married</option>
<option value="others" <cfif getitem.marstatus eq "others"> selected</cfif>>Others</option>
</select></td>
<th>Date of Birth</th>
<td><input type="text" name="dob" id="dob" value="#dateformat(getitem.dob,'DD/MM/YYYY')#" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dob);"> (DD/MM/YYYY)
</td>
</tr>
<tr>

<th>License Date</th>
<td><input type="text" name="licdate" id="licdate" value="#dateformat(getitem.licdate,'DD/MM/YYYY')#" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(licdate);"> (DD/MM/YYYY)</td>
<th>Vehicle Number</th>
<td><cfinput type="text" name="carno" id="carno" required="yes" value="#getitem.carno#" readonly /></td> 
</tr>
<tr>
  <th>NCD</th>
  <td>
  <select name="ncd" id="ncd" >
  <option value="0%" <cfif getitem.ncd eq "0%" >selected</cfif>>0%</option>
  <option value="10%" <cfif getitem.ncd eq "10%" >selected</cfif>>10%</option>
  <option value="15%"<cfif getitem.ncd eq "15%" >selected</cfif>>15%</option>
  <option value="20%" <cfif getitem.ncd eq "20%" >selected</cfif>>20%</option>
  <option value="30%" <cfif getitem.ncd eq "30%" >selected</cfif>>30%</option>
  <option value="40%" <cfif getitem.ncd eq "40%" >selected</cfif>>40%</option>
  <option value="50%" <cfif getitem.ncd eq "50%" >selected</cfif>>50%</option>
  </select>  </td>
 
</tr>
<tr>
<th>Certificate of Merit</th>

<td>
<input type="checkbox" name="com" id="com"<cfif getitem.com eq "true">checked</cfif> />
</td>

<th>Vehicle Make</th>
<td><input type="text" name="make" id="make" value="#getitem.make#" /></td>
</tr>
<tr>
  <th>Vehicle Scheme</th>
  <td>
  <input type="radio" name="scheme" id="scheme" value="OPC" <cfif getitem.scheme eq "OPC">checked</cfif>>&nbsp;OPC&nbsp;&nbsp;<input type="radio" name="scheme" id="scheme" value="NORMAL" <cfif getitem.scheme eq "NORMAL">checked</cfif> />&nbsp;Normal
  </td>
  <th>Chassis No</th>
  <td><input type="text" name="chasis" id="chasis" value="#getitem.chasisno#" /></td>
</tr>
<tr>
  <th>Vehicle Model</th>
  <td>
  <input type="text" name="model" id="model" value="#getitem.model#" />  </td>
  <th>Original Reg Date</th>
  <td><input type="text" name="oriregdate" id="oriregdate" value="#dateformat(getitem.oriregdate,'DD/MM/YYYY')#">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(oriregdate);"> (DD/MM/YYYY)</td>
</tr>
<tr>
  <th>Year of Manufacture</th>
  <td>
  <select name="yearofmade" id="yearofmade">
  <cfloop from="#dateformat(now(),'yyyy')#" to="1930" index="i" step="-1">
  <option value="#i#" <cfif getitem.yearmade eq  i>selected</cfif>>#i#</option>
  </cfloop>
  </select>  </td>
  <th>Engine Capacity</th>
  <td><input type="text" name="capacity" id="capacity" value="#capacity#"></td>
</tr>
<tr>

<th>Coverage</th>

<td>
<input type="radio" name="coverage" id="coverage" value="Comprehensive" <cfif coveragetype eq "Comprehensive">checked</cfif> />
1. Comprehensive<br />
<input type="radio" name="coverage" id="coverage" value="Third party, fire and theft" <cfif coveragetype eq "Third party, fire and theft">checked</cfif> /> 2. Third party, fire and theft<br />
<input type="radio" name="coverage" id="coverage" value="Third party only" <cfif coveragetype eq "Third party only">checked</cfif> /> 
3. Third party only</td>
<th>Insurance Expiry Date</th>
<td><input type="text" name="inexpdate" id="inexpdate" value="#dateformat(inexpdate,'DD/MM/YYYY')#">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(inexpdate);"> (DD/MM/YYYY)</td>

</tr>

<tr>
<th>Market Value</th>
<td>

<input type="radio" name="marketvalue" id="marketvalue" value="With COE" <cfif marketvalue eq "With COE">checked</cfif> />1. With COE<br />
<input type="radio" name="marketvalue" id="marketvalue" value="W/O COE" <cfif marketvalue eq "W/O COE">checked</cfif>/>2. W/O COE<br />

</td>
<th>Sum Insured</th>
<td>

<input type="radio" name="suminsured" id="suminsured" value="Market Value" <cfif suminsured eq "Market Value"> checked</cfif> />1. Market Value<br />
<input type="radio" name="suminsured" id="suminsured" value="2" <cfif suminsured neq "Market Value"> checked</cfif>/>2.
<input type="text" name="suminsured2" id="suminsured2" value="<cfif suminsured neq "Market Value">#suminsured#</cfif>">
</td>
</tr>
<tr>
<th>Premium</th>
<td><input type="text" name="premium" id="premium" value="#premium#"></td>

<th>Previous Insurer</th>
<td><select name="insurance" id="insurance">
  <option value="">Please select an insurance</option>
  <cfloop query ="getexinsurance">
    <option value="#desp#" <cfif getitem.insurance eq desp>selected </cfif>>#itemno# - #desp#</option>
  </cfloop>
</select></td></tr><tr>
<th>Contact</th>
<td><input type="text" name="contract" id="contract" value="#contract#"></td>

<th>Commission</th>
<td>

<input type="radio" name="commission" id="commission" value="10%" <cfif commission eq "10%">checked</cfif>/>1.10%<br />
<input type="radio" name="commission" id="commission" value="2" <cfif commission neq "10%">checked</cfif>/>2.
<input type="text" name="commission2" id="commission2" value=<cfif commission neq "10%">"#commission#"</cfif>>
</td></tr>
<tr>
<th>Referred By</th>
<td><input type="text" name="referred" id="referred" value="#custrefer#"></td>

<th>Payment</th>
<td>
<select name="payment" id="payment">

<option value="" <cfif payment eq "">selected</cfif>>Please select a payment</option>
<option value="Cheque" <cfif payment eq "Cheque">selected</cfif>>Cheque</option>
<option value="Cash" <cfif payment eq "Cash">selected</cfif>>Cash</option>
<option value="CC" <cfif payment eq "CC">selected</cfif>>Credit Card</option>
</select></td></tr>
<tr>
<th>Finance Company</th>
<td><input type="text" name="financecom" id="financecom" value="#financecom#" ></td>

<th>Excess</th>
<td><input type="text" name="excess" id="excess" value="#excess#"></td>
<td></td>

      	<tr> 
       		<td></td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td></td><td></td><td></td>
        	<td align="right"><input name="submit" type="submit" value="  #button#  "></td>
      	</tr>
    </cfoutput> 
  	</table>
</cfform>
			
</body>
</html>
