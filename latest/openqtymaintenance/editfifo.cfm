<html>
<head>
<title>Edit Fifo</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfif CFGRIDKEY eq " Oldest 50">
<cfset cfgridkey = 50>
</cfif>
<cfset quantity = 0>
<cfset price = 0>
<cfset nday = dateformat(now(),'dd') >
<cfset nmonth = dateformat(now(),'mm') >
<cfset nyear = dateformat(now(),'yyyy') >

<cfquery name="getdata" datasource="#dts#">
SELECT ffd#CFGRIDKEY# as ffd,ffc#CFGRIDKEY# as ffc,ffq#CFGRIDKEY# as ffq FROM fifoopq WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>
<cfif getdata.recordcount neq 0>
<cfset quantity = val(getdata.ffq)>
<cfset price = val(getdata.ffc)>
<cfif getdata.ffd neq "">
<cfset nday = dateformat(getdata.ffd,'dd') >
<cfset nmonth = dateformat(getdata.ffd,'mm') >
<cfset nyear = dateformat(getdata.ffd,'yyyy') >
</cfif>
</cfif>

	<h1>Edit Fifo</h1>
<cfoutput>
<cfform name="Editfifo" action="editfifoprocess.cfm" method="post">
  	
	<h1 align="center">Edit Fifo No #CFGRIDKEY# Item No #url.itemno#</h1>
  	
	<table align="center" class="data" width="500">
<tr>
<th>New Quantity</th>
<td><cfinput type='text' name='newqty' id='newqty' value='#val(quantity)#'> <cfinput type='hidden' name='itemno1' id='itemno1' value='#url.itemno#'><cfinput type='hidden' name='fifono' id='fifono' value='#CFGRIDKEY#'>
</tr>
<tr>
<th>New Price</th>
<td><cfinput type='text' name='newprice' id='newprice' value='#numberformat(price,'.__')#'>
</tr>
<tr>
<th>New Date</th>
<td><select name="day1" id="day1">
<cfloop from="1" to="31" index="i">
<option value="#i#" <cfif numberformat(i,'00') eq nday>Selected</cfif>>#i#</option>
</cfloop>
</select>
<select name="month1" id="month1">
<cfloop from="1" to="12" index="i">
<cfset datecrete = createdate('2010',i,'1')>
<option value="#i#" <cfif numberformat(i,'00') eq nmonth>Selected</cfif>>#i##ucase(dateformat(datecrete,'mmmm'))#</option>
</cfloop>
</select>
<select name="year1" id="year1">
<cfloop from="1990" to="2020" index="i">
<option value="#i#" <cfif i eq nyear>Selected</cfif>>#i#</option>
</cfloop>
</select>
</tr>
<tr>
<th></th>
<td><cfinput type='submit' name='Edit' value='Edit'>
</tr>
  	</table>
</cfform>
</cfoutput>
</body>
</html>