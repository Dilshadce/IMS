<cfquery name="getcust" datasource="#dts#">
SELECT custno,name,name2,add1,add2,add3,add4,arrem1,arrem2,arrem3,arrem4,arrem5,arrem6,contact,E_mail from #target_arcust# where custno="#url.custno#"
</cfquery>

<cfquery name="getexinsurance" datasource="#dts#">
SELECT itemno,desp from icitem
</cfquery>


<cfoutput>
<table width="100%">
<tr>
<th width="100px">Customer Name</th>
<td width="150px"><input type="text" name="custname" id="custname" value="#getcust.name#" /></td>
<th width="100px">Customer IC</th>
<td width="150px"><input type="text" name="custic" id="custic" value="#getcust.arrem1#" /></td>
</tr>
<tr>
  <th>Customer Address</th>
  <td colspan="3">
  <textarea name="custadd" id="custadd" cols="55" rows="2">#getcust.add1#
  </textarea>  </td> 
</tr>
<tr>
  <th>Email Address</th>
  <td colspan="">
<input type="text" name="custemail" id="custemail" value="#getcust.E_mail#" />  
</td>
<th>Gender</th>
<td>
<cfif #getcust.arrem2# eq "male" or #getcust.arrem2# eq "MALE" or #getcust.arrem2# eq "Male">
<select name="gender" id="gender">
<option value="male">Male</option>
<option value="female">Female</option>
</select>
<cfelse>
<select name="gender" id="gender">
<option value="female">Female</option>
<option value="male">Male</option>
</select>
</cfif></td>
</tr>
<tr>

<th>Marital Status</th>
<td>
<cfif #getcust.arrem3# eq "single" or #getcust.arrem3# eq "SINGLE" or #getcust.arrem3# eq "Single">
<select name="marital" id="marital">
<option value="single">Single</option>
<option value="married">Married</option>
<option value="others">Others</option>
</select>
<cfelseif #getcust.arrem3# eq "married" or #getcust.arrem3# eq "MARRIED" or #getcust.arrem3# eq "Married">
<select name="marital" id="marital">
<option value="married">Married</option>
<option value="others">Others</option>
<option value="single">Single</option>
</select>
<cfelse>
<select name="marital" id="marital">
<option value="others">Others</option>
<option value="single">Single</option>
<option value="married">Married</option>
</select>
</cfif></td>
<th>Date of Birth</th>
<td>
<cfif isdate(getcust.arrem5)>
<cfset dobdate = getcust.arrem5>
<cfelse>
<cfset dobdate = "1930-01-01">
</cfif>
<select name="day1" id="day1">
<cfloop from="1" to="31" index="i">
<option value="#i#" <cfif dateformat(dobdate,'dd') eq i>Selected</cfif>>#i#</option>
</cfloop>
</select>
<select name="month1" id="month1">
<cfloop from="1" to="12" index="i">
<cfset datecrete = createdate('2010',i,'1')>
<option value="#i#" <cfif dateformat(dobdate,'mm') eq i>Selected</cfif>>#ucase(dateformat(datecrete,'mmmm'))#</option>
</cfloop>
</select>
<select name="year1" id="year1">
<cfloop from="1930" to="2010" index="i">
<option value="#i#" <cfif dateformat(dobdate,'yyyy') eq i>Selected</cfif>>#i#</option>
</cfloop>
</select></td>
</tr>
<tr>
<th>License Date</th>
<td><input type="text" name="licdate" id="licdate" value="#dateformat(getcust.arrem4,'dd/mm/yyyy')#" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(licdate);"> (DD/MM/YYYY)</td>
<th>Vehicle Number</th>
<td><input type="text" name="carno" id="carno" required="yes" message="Vehicles No is Required" /></td>  
</tr>
<tr>
  <th>NCD</th>
  <td>
  <select name="ncd" id="ncd" >
  <option value="0%">0%</option>
  <option value="10%">10%</option>
  <option value="15%">15%</option>
  <option value="20%">20%</option>
  <option value="30%">30%</option>
  <option value="40%">40%</option>
  <option value="50%">50%</option>
  </select>  </td>
</tr>
<tr>
<th>Certificate of Merit</th>
<td><input type="checkbox" name="com" id="com" value="true" checked /></td>
<th>Vehicle Make</th>
<td><input type="text" name="make" id="make" /></td>
</tr>
<tr>
  <th>Vehicle Scheme</th>
  <td><input type="radio" name="scheme" id="scheme" value="NORMAL" checked>&nbsp;NORMAL&nbsp;&nbsp;<input type="radio" name="scheme" id="scheme" value="OPC" />&nbsp;OPC</td>
  <th>Chassis No</th>
  <td><input type="text" name="chasis" id="chasis" /></td>
</tr>
<tr>
  <th>Vehicle Model</th>
  <td>
  <input type="text" name="model" id="model" />  </td>
  <th>Original Reg Date</th>
  <td><input type="text" name="oriregdate" id="oriregdate" value="">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(oriregdate);"> (DD/MM/YYYY)</td>
</tr>
<tr>
  <th>Year of Manufacture</th>
  <td>
  <select name="yearofmade" id="yearofmade" >
  <cfloop from="#dateformat(now(),'yyyy')#" to="1930" index="i" step="-1">
  <option value="#i#">#i#</option>
  </cfloop>
  </select>  </td>
  <th>Engine Capacity</th>
  <td><input type="text" name="capacity" id="capacity" value=""></td>
</tr>
<tr>

<th>Coverage Types</th>
<td>
<input type="radio" name="coverage" id="coverage" value="Comprehensive" checked />
1. Comprehensive<br />
<input type="radio" name="coverage" id="coverage" value="Third party, fire and theft" /> 2. Third party, fire and theft<br />
<input type="radio" name="coverage" id="coverage" value="Third party only" /> 
3. Third party only</td>
<th>Insurance Expired Date</th>
<td><input type="text" name="inexpdate" id="inexpdate" value="" />  &nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onclick="showCalendarControl(inexpdate);" /> (DD/MM/YYYY)</td>
</tr>
<tr>
<th>Market Value</th>
<td>
<input type="radio" name="marketvalue" id="marketvalue" value="With COE" checked/>1. With COE<br />
<input type="radio" name="marketvalue" id="marketvalue" value="W/O COE" />2. W/O COE<br /></td>
<th>Sum Insuranced</th>
<td>
<input type="radio" name="suminsured" id="suminsured" value="Market Value"checked />1.Market Value<br />
<input type="radio" name="suminsured" id="suminsured" value="2" />2.
<input type="text" name="suminsured2" id="suminsured2" value=""></td>
</tr>
<tr>
<th>Premium</th>
<td><input type="text" name="premium" id="premium" value=""></td>

<th>Ex-Insurance</th>
<td><select name="insurance" id="insurance">
  <option value="">Please select an insurance</option>
  <cfloop query ="getexinsurance">
    <option value="#desp#">#itemno# - #desp# </option>
  </cfloop>
</select></td>
</tr>
<tr>
<th>Contact</th>
<td><input type="text" name="contract" id="contract" value="#getcust.contact#"></td>

<th>Commission</th>
<td>
<input type="radio" name="commission" id="commission" value="10%" checked/>1.10%<br />
<input type="radio" name="commission" id="commission" value="3" />2.
<input type="text" name="commission2" id="commission2" value=""></td></tr><tr>
<th>Referred By</th>
<td><input type="text" name="referred" id="referred" value="#getcust.arrem6#"></td>


<th>Payment</th>
<td>
<select name="payment" id="payment">
<option value="">Please select a payment</option>
<option value="Cheque">Cheque</option>
<option value="Cash">Cash</option>
<option value="CC">Credit Card</option>
</select></td>
</tr><tr>
<th>Finance Company</th>
<td><input type="text" name="financecom" id="financecom" value="" ></td>

<th>Excess</th>
<td><input type="text" name="excess" id="excess"/></td>

</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td><input type="submit" value="Create" /></td>
</tr>
</table>
</cfoutput>
<script type="text/javascript">
clearform();
</script>