<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>


<cfoutput>
<cfquery name="getagent" datasource="#dts#">
		SELECT * from #target_icagent#
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
		SELECT * FROM gsetup 
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

<form name="vehicleserdate" action="mechanic1.cfm" method="post" target="_blank">

<!--- <h2>Print #trantype# Report By Type</h2> --->
<h3>
	<a href="vehiclereportmenu.cfm">Vehicle Report</a> >> 
	<a><font size="2">Print #getgsetup.lagent# Performance Report </font></a>
</h3>

<table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">

<input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" />

	<tr> 
        <th>#getgsetup.lagent# From</th>
        <td><select name="agentfrom">
				<option value="">Choose an #getgsetup.lagent#</option>
				<cfloop query="getagent"><option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>
    <tr> 
        <th>#getgsetup.lagent# To</th>
        <td><select name="agentto">
				<option value="">Choose an #getgsetup.lagent#</option>
				<cfloop query="getagent"><option value="#getagent.agent#">#getagent.agent# - #getagent.desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>

    <tr> <td colspan="2"><hr></td></tr>
    <tr> 
        <th>Date From</th>
        <td><input type="text" name="datefrom" id="datefrom" validate="eurodate" message="Invalid Input" maxlength="10" size="10"> 
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));">(DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Date To</th>
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