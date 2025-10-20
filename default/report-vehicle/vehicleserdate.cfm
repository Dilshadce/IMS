<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>


<cfoutput>
<cfquery name="getvehicle" datasource="#dts#">
		SELECT entryno FROM vehicles order by entryno		
</cfquery>
</cfoutput>

<cfoutput>
<cfloop from="1" to="18" index="i">
<cfinvoke component="CFC.Date" method="getAppDateByPeriod" dts="#dts#" inputPeriod="#i#" returnvariable="newdate"/>
<cfset "vmonthto#i#" = dateformat(newdate,"mmm yy")>
</cfloop>
</cfoutput>

<html>
<head>
	<title>Vehicle Service Date Report By Date</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link href="../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script type="text/javascript">

function selectlist(nextserdate,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (nextserdate==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}


</script>
	
</head>

<script src="../../scripts/CalendarControl.js" language="javascript"></script>


<body>
<cfoutput>

<form name="vehicleserdate" action="vehicleserdate1.cfm" method="post" target="_blank">

<!--- <h2>Print #trantype# Report By Type</h2> --->
<h3>
	<a href="vehiclereportmenu.cfm">Vehicle Service Date Report</a> >> 
	<a><font size="2">Print Vehicle Service Date Report By Date </font></a>
</h3>

<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">

<input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />


    <tr>
		<th>Report Format</th>
		<td>
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT
		</td>
	</tr>
    <tr> <td colspan="2"><hr></td></tr>
	<tr> 
        <th>Vehicles</th>
        <td><select name="vehiclefrom" id="vehiclefrom">
				<option value="">Choose an Vehicle</option>
				<cfloop query="getvehicle"><option value="#entryno#">#entryno#</option>
				</cfloop>
			</select>
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findvehicle');" />
		</td>
	</tr>
    <!---
    <tr> 
        <th>Vehicles To</th>
        <td><select name="vehicleto">
				<option value="">Choose an Vehicle</option>
				<cfloop query="getvehicle"><option value="#entryno#">#entryno#</option>
				</cfloop>
			</select>
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findvehicle');" />
		</td>
	</tr>--->

    <tr> <td colspan="2"><hr></td></tr>
    <tr> 
        <th>Next Service Date From</th>
        <td><input type="text" name="datefrom" id="datefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> 
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));">(DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Next Service Date To</th>
        <td><input type="text" name="dateto" id="dateto" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> 
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));">(DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>      
</table>
</form>
</cfoutput>
</body>
</html>
<cfwindow center="true" width="550" height="400" name="findvehicle" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="findvehicle.cfm?type=vehicle&fromto={fromto}" />
<!---
<cfset clsyear=year(getgeneral.lastaccyear)>	
<cfset clsmonth=month(getgeneral.lastaccyear)>
<!--- period default --->
<cfset newmonth=clsmonth+1>	

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
--->