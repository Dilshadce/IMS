<html>
<head>
<title>Distribute Miscellaneous Charges Into Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<link rel="stylesheet" href="../../../stylesheet/stylesheet.css">
</head>

<cfquery name="getrcno" datasource="#dts#">
	select refno from artran where (void = '' or void is null) and posted='' and type='RC' order by refno
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery>

<cfset clsyear = year(getgeneral.lastaccyear)>	
<cfset clsmonth = month(getgeneral.lastaccyear)>

<!--- period default --->
<cfset newmonth = clsmonth + 1>	

<cfif newmonth gt 12>
	<cfset newmonth = newmonth - 12>
	<cfset newyear = clsyear + 1>
<cfelse>
	<cfset newyear = clsyear>
</cfif>

<cfset newdate = CreateDate(newyear, newmonth, newmonth)>
<cfset vmonth = dateformat(newdate,"mmm yy")>
<cfset xnewmonth = newmonth + 11>
	
<cfif xnewmonth gt 12>
	<cfset xnewmonth = xnewmonth - 12>
	<cfset xnewyear = newyear + 1>
<cfelse>
	<cfset xnewyear = newyear>
</cfif>

<cfset xnewdate = CreateDate(xnewyear, xnewmonth, xnewmonth)>
<cfset vmonthto = dateformat(xnewdate,"mmm yy")>

<!--- period 1 --->
<cfset newmonth1 = clsmonth + 1>	

<cfif newmonth1 gt 12>
	<cfset newmonth1 = newmonth1 - 12>
	<cfset newyear1 = clsyear + 1>
<cfelse>
	<cfset newyear1 = clsyear>
</cfif>

<cfset newdate1 = CreateDate(newyear1, newmonth1, newmonth1)>
<cfset vmonthto1 = dateformat(newdate1,"mmm yy")>

<!--- period 2 --->
<cfset newmonth2 = clsmonth + 2>
	
<cfif newmonth2 gt 12>
	<cfset newmonth2 = newmonth2 - 12>
	<cfset newyear2 = clsyear + 1>
<cfelse>
	<cfset newyear2 = clsyear>
</cfif>

<cfset newdate2 = CreateDate(newyear2, newmonth2, newmonth2)>
<cfset vmonthto2 = dateformat(newdate2,"mmm yy")>

<!--- period 3 --->
<cfset newmonth3 = clsmonth + 3>	

<cfif newmonth3 gt 12>
	<cfset newmonth3 = newmonth3 - 12>
	<cfset newyear3= clsyear + 1>
<cfelse>
	<cfset newyear3 = clsyear>
</cfif>

<cfset newdate3 = CreateDate(newyear3, newmonth3, newmonth3)>
<cfset vmonthto3 = dateformat(newdate3,"mmm yy")>

<!--- period 4--->
<cfset newmonth4 = clsmonth + 4>	

<cfif newmonth4 gt 12>
	<cfset newmonth4 = newmonth4 - 12>
	<cfset newyear4= clsyear + 1>
<cfelse>
	<cfset newyear4 = clsyear>
</cfif>

<cfset newdate4 = CreateDate(newyear4, newmonth4, newmonth4)>
<cfset vmonthto4 = dateformat(newdate4,"mmm yy")>

<!--- period 5--->
<cfset newmonth5 = clsmonth + 5>	

<cfif newmonth5 gt 12>
	<cfset newmonth5 = newmonth5 - 12>
	<cfset newyear5= clsyear + 1>
<cfelse>
	<cfset newyear5 = clsyear>
</cfif>

<cfset newdate5 = CreateDate(newyear5, newmonth5, newmonth5)>
<cfset vmonthto5 = dateformat(newdate5,"mmm yy")>

<!--- period 6--->
<cfset newmonth6 = clsmonth + 6>	

<cfif newmonth6 gt 12>
	<cfset newmonth6 = newmonth6 - 12>
	<cfset newyear6= clsyear + 1>
<cfelse>
	<cfset newyear6 = clsyear>
</cfif>

<cfset newdate6 = CreateDate(newyear6, newmonth6, newmonth6)>
<cfset vmonthto6 = dateformat(newdate6,"mmm yy")>

<!--- period 7--->
<cfset newmonth7 = clsmonth + 7>	

<cfif newmonth7 gt 12>
	<cfset newmonth7 = newmonth7 - 12>
	<cfset newyear7= clsyear + 1>
<cfelse>
	<cfset newyear7 = clsyear>
</cfif>

<cfset newdate7 = CreateDate(newyear7, newmonth7, newmonth7)>
<cfset vmonthto7 = dateformat(newdate7,"mmm yy")>

<!--- period 8--->
<cfset newmonth8 = clsmonth + 8>	

<cfif newmonth8 gt 12>
	<cfset newmonth8 = newmonth8 - 12>
	<cfset newyear8= clsyear + 1>
<cfelse>
	<cfset newyear8 = clsyear>
</cfif>

<cfset newdate8 = CreateDate(newyear8, newmonth8, newmonth8)>
<cfset vmonthto8 = dateformat(newdate8,"mmm yy")>

<!--- period 9--->
<cfset newmonth9 = clsmonth + 9>	

<cfif newmonth9 gt 12>
	<cfset newmonth9 = newmonth9 - 12>
	<cfset newyear9= clsyear + 1>
<cfelse>
	<cfset newyear9 = clsyear>
</cfif>

<cfset newdate9 = CreateDate(newyear9, newmonth9, newmonth9)>
<cfset vmonthto9 = dateformat(newdate9,"mmm yy")>

<!--- period 10--->
<cfset newmonth10 = clsmonth + 10>	

<cfif newmonth10 gt 12>
	<cfset newmonth10 = newmonth10 - 12>
	<cfset newyear10= clsyear + 1>
<cfelse>
	<cfset newyear10 = clsyear>
</cfif>

<cfset newdate10 = CreateDate(newyear10, newmonth10, newmonth10)>
<cfset vmonthto10 = dateformat(newdate10,"mmm yy")>

<!--- period 11--->
<cfset newmonth11 = clsmonth + 11>	

<cfif newmonth11 gt 12>
	<cfset newmonth11 = newmonth11 - 12>
	<cfset newyear11= clsyear + 1>
<cfelse>
	<cfset newyear11 = clsyear>
</cfif>

<cfset newdate11 = CreateDate(newyear11, newmonth11, newmonth11)>
<cfset vmonthto11 = dateformat(newdate11,"mmm yy")>

<!--- period 12--->
<cfset newmonth12 = clsmonth + 12>	

<cfif newmonth12 gt 12>
	<cfset newmonth12 = newmonth12 - 12>
	<cfset newyear12= clsyear + 1>
<cfelse>
	<cfset newyear12 = clsyear>
</cfif>

<cfset newdate12 = CreateDate(newyear12, newmonth12, newmonth12)>
<cfset vmonthto12 = dateformat(newdate12,"mmm yy")>

<!--- period 13--->
<cfset newmonth13 = clsmonth + 13>

<cfif newmonth13 gt 24>
	<cfset newmonth13 = newmonth13 - 24>
	<cfset newyear13= clsyear + 2>	
<cfelseif newmonth13 gt 12>
	<cfset newmonth13 = newmonth13 - 12>
	<cfset newyear13= clsyear + 1>
<cfelse>
	<cfset newyear13 = clsyear>
</cfif>

<cfset newdate13 = CreateDate(newyear13, newmonth13, newmonth13)>
<cfset vmonthto13 = dateformat(newdate13,"mmm yy")>

<!--- period 14--->
<cfset newmonth14 = clsmonth + 14>

<cfif newmonth14 gt 24>
	<cfset newmonth14 = newmonth14 - 24>
	<cfset newyear14= clsyear + 2>	
<cfelseif newmonth14 gt 12>
	<cfset newmonth14 = newmonth14 - 12>
	<cfset newyear14= clsyear + 1>
<cfelse>
	<cfset newyear14 = clsyear>
</cfif>

<cfset newdate14 = CreateDate(newyear14, newmonth14, newmonth14)>
<cfset vmonthto14 = dateformat(newdate14,"mmm yy")>

<!--- period 15--->
<cfset newmonth15 = clsmonth + 15>

<cfif newmonth15 gt 24>
	<cfset newmonth15 = newmonth15 - 24>
	<cfset newyear15= clsyear + 2>	
<cfelseif newmonth15 gt 12>
	<cfset newmonth15 = newmonth15 - 12>
	<cfset newyear15= clsyear + 1>
<cfelse>
	<cfset newyear15 = clsyear>
</cfif>

<cfset newdate15 = CreateDate(newyear15, newmonth15, newmonth15)>
<cfset vmonthto15 = dateformat(newdate15,"mmm yy")>

<!--- period 16--->
<cfset newmonth16 = clsmonth + 16>

<cfif newmonth16 gt 24>
	<cfset newmonth16 = newmonth16 - 24>
	<cfset newyear16= clsyear + 2>	
<cfelseif newmonth16 gt 12>
	<cfset newmonth16 = newmonth16 - 12>
	<cfset newyear16= clsyear + 1>
<cfelse>
	<cfset newyear16 = clsyear>
</cfif>

<cfset newdate16 = CreateDate(newyear16, newmonth16, newmonth16)>
<cfset vmonthto16 = dateformat(newdate16,"mmm yy")>

<!--- period 17--->
<cfset newmonth17 = clsmonth + 17>

<cfif newmonth17 gt 24>
	<cfset newmonth17 = newmonth17 - 24>
	<cfset newyear17= clsyear + 2>	
<cfelseif newmonth17 gt 12>
	<cfset newmonth17 = newmonth17 - 12>
	<cfset newyear17= clsyear + 1>
<cfelse>
	<cfset newyear17 = clsyear>
</cfif>

<cfset newdate17 = CreateDate(newyear17, newmonth17, newmonth17)>
<cfset vmonthto17 = dateformat(newdate17,"mmm yy")>

<!--- period 18--->
<cfset newmonth18 = clsmonth + 18>

<cfif newmonth18 gt 24>
	<cfset newmonth18 = newmonth18 - 24>
	<cfset newyear18= clsyear + 2>	
<cfelseif newmonth18 gt 12>
	<cfset newmonth18 = newmonth18 - 12>
	<cfset newyear18= clsyear + 1>
<cfelse>
	<cfset newyear18 = clsyear>
</cfif>

<cfset newdate18 = CreateDate(newyear18, newmonth18, newmonth18)>
<cfset vmonthto18 = dateformat(newdate18,"mmm yy")>

<body onLoad="displaymonth();">
<cfoutput>

<h2 align="center">Distribute Miscellaneous Charges Into Cost</h2>
<table align="center">
<tr><td></td></tr>
	<tr><td><div align="justify">- This Option Distribute <font color="red">OTHER CHARGES</font> of The Invoice Into Invoice Items.</div></td></tr>
	<tr><td><div align="justify">- Cost Will Only Be Distributed Into Those Item Marked <font color="red">XCOST</font> In Remark 4 In Transaction.</div></td></tr>
	<tr><td><div align="justify">- Please Check The Adjusted Cost In <font color="red">Enquiry -> History Price Enquiry -> Adjusted Transaction Cost</font></div></td></tr>
</table>

<form name="distribute_miscellaneous_charges_into_cost" action="distribute_miscellaneous_charges_into_cost1.cfm" method="post" target="_blank">
<table width="60%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
	<tr>
		
		<td colspan="2"><input type="checkbox" name="distriall" id="distriall" value="1">&nbsp; Distribute Miscellaneous Charges Into All Item <br>
        <input type="hidden" name="fromto" id="fromto" value="" /><input type="checkbox" name="updateitemcost" id="updateitemcost" value="1">&nbsp; Update Receive to Item Profile Cost
        </td>
      	</tr>
	<tr>
		<th>Period From</th>
		<td><select name="periodfrom" onChange="displaymonth();">
				<option value="">Choose a Period</option>
				<option value="01">1</option>
		    	<option value="02">2</option>
				<option value="03">3</option>
				<option value="04">4</option>
				<option value="05">5</option>
				<option value="06">6</option>
				<option value="07">7</option>
				<option value="08">8</option>
				<option value="09">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
				<option value="16">16</option>
				<option value="17">17</option>
				<option value="18">18</option>
				</select>&nbsp;<input type="text" name="monthfrom" value="#vmonth#" size="6" readonly>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>
        <!---
		<tr>
		  	<th nowrap>Select Receive No From</th>
        	<td><select name="reffrom">
				<option value="">Choose a Receive No</option>
				<cfloop query="getrcno">
					<option value="#getrcno.refno#">#getrcno.refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
      	<tr> 
        	<th nowrap>Select Receive No To</th>
        	<td><select name="refto">
				<option value="">Choose a Receive No</option>
				<cfloop query="getrcno">
					<option value="#getrcno.refno#">#getrcno.refno#</option>
				</cfloop>
				</select>
			</td>
      	</tr>
		<tr> 
			<td colspan="3"><hr></td>
		</tr>--->
		<tr>
		  	<th nowrap>Enter Receive No From</th>
        	<td><input type="text" name="enterreffrom" maxlength="8" size="9"><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findrefno');" /></td>
      	</tr>
      	<tr> 
        	<th nowrap>Enter Receive No To</th>
        	<td><input type="text" name="enterrefto" maxlength="8" size="9"><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findrefno');" /></td>
      	</tr>
		<tr> 
			<td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
		</tr>
	</table>
</form>

<script language="JavaScript">
	function displaymonth(){
		
	if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=="")
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='';}
	
	if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='01')		
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto1#'; }
		
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='02')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto2#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='03')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto3#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='04')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto4#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='05')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto5#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='06')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto6#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='07')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto7#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='08')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto8#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='09')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto9#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='10')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto10#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='11')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto11#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='12')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto12#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='13')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto13#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='14')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto14#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='15')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto15#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='16')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto16#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='17')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto17#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodfrom.value=='18')	
	{	document.distribute_miscellaneous_charges_into_cost.monthfrom.value='#vmonthto18#'; }
	
	if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='01')		
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto1#'; }
		
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='02')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto2#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='03')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto3#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='04')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto4#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='05')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto5#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='06')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto6#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='07')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto7#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='08')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto8#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='09')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto9#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='10')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto10#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='11')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto11#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='12')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto12#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='13')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto13#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='14')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto14#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='15')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto15#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='16')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto16#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='17')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto17#'; }
	
	else if(document.distribute_miscellaneous_charges_into_cost.periodto.value=='18')	
	{	document.distribute_miscellaneous_charges_into_cost.monthto.value='#vmonthto18#'; }
	
	}
</script>

<cfwindow center="true" width="550" height="400" name="findrefno" refreshOnShow="true"
        title="Find Reference" initshow="false"
        source="findrefno.cfm?fromto={fromto}" />

</cfoutput>
</form>
</body>
</html>