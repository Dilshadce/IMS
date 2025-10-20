<html>
<head>
<title>Currency Code</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script language="javascript" type="text/javascript">
	function getcurrency(currcode){
		DWREngine._execute(_maintenanceflocation, null, 'getcurrency', currcode, showcurrency);
	}
	
	function showcurrency(currencyObject){
		DWRUtil.setValue("currency", currencyObject.CURRENCY);
		DWRUtil.setValue("CurrDollar", currencyObject.CURRENCY1);
		DWRUtil.setValue("CurrCent", currencyObject.CURRENCY2);
	}
</script>
</head>

<body>

<cfif URL.type eq "CREATE">
	<cfset currcode = "">
	<cfset currency = "">
	<cfset currency0 = "">
	<cfset currency1 = "">
	<cfset currency2 = "">
	<cfset CurrRate = "1.0000000000">
	<cfset currP01 = "1.0000000000">
	<cfset currP02 = "1.0000000000">
	<cfset currP03 = "1.0000000000">
	<cfset currP04 = "1.0000000000">
	<cfset currP05 = "1.0000000000">
	<cfset currP06 = "1.0000000000">
	<cfset currP07 = "1.0000000000">
	<cfset currP08 = "1.0000000000">
	<cfset currP09 = "1.0000000000">
	<cfset currP10 = "1.0000000000">
	<cfset currP11 = "1.0000000000">
	<cfset currP12 = "1.0000000000">
	<cfset currP13 = "1.0000000000">
	<cfset currP14 = "1.0000000000">
	<cfset currP15 = "1.0000000000">
	<cfset currP16 = "1.0000000000">
	<cfset currP17 = "1.0000000000">
	<cfset currP18 = "1.0000000000">
<cfelseif URL.type eq "Edit">
	<cfquery datasource='#dts#' name="currEdit">
		select * 
		from #target_currency# 
		where currcode='#url.currcode#'
	</cfquery>
	
	<cfif currEdit.recordcount gt 0>
		<cfset currcode = currEdit.currcode>
		<cfset currency = currEdit.currency>
		<cfset currency0 = currEdit.currency0>
		<cfset currency1 = currEdit.currency1>
		<cfset currency2 = currEdit.currency2>
		<cfset CurrRate = currEdit.currRate>
		<cfset currP01 = currEdit.currP1>
		<cfset currP02 = currEdit.currP2>
		<cfset currP03 = currEdit.currP3>
		<cfset currP04 = currEdit.currP4>
		<cfset currP05 = currEdit.currP5>
		<cfset currP06 = currEdit.currP6>
		<cfset currP07 = currEdit.currP7>
		<cfset currP08 = currEdit.currP8>
		<cfset currP09 = currEdit.currP9>
		<cfset currP10 = currEdit.currP10>
		<cfset currP11 = currEdit.currP11>
		<cfset currP12 = currEdit.currP12>
		<cfset currP13 = currEdit.currP13>
		<cfset currP14 = currEdit.currP14>
		<cfset currP15 = currEdit.currP15>
		<cfset currP16 = currEdit.currP16>
		<cfset currP17 = currEdit.currP17>
		<cfset currP18 = currEdit.currP18>
	<cfelse>
		<h3>INVALID Currency! This currency is not in the database. Please contact administrator.</h3>
	</cfif>
<cfelseif URL.type eq "Delete">
	<cfquery datasource='#dts#' name="currEdit">
		select * 
		from #target_currency# 
		where currcode='#url.currcode#'
	</cfquery>
	
	<cfif currEdit.recordcount gt 0>
		<cfset currcode = currEdit.currcode>
		<cfset currency = currEdit.currency>
		<cfset currency0 = currEdit.currency0>
		<cfset currency1 = currEdit.currency1>
		<cfset currency2 = currEdit.currency2>
		<cfset CurrRate = currEdit.currRate>
		<cfset currP01 = currEdit.currP1>
		<cfset currP02 = currEdit.currP2>
		<cfset currP03 = currEdit.currP3>
		<cfset currP04 = currEdit.currP4>
		<cfset currP05 = currEdit.currP5>
		<cfset currP06 = currEdit.currP6>
		<cfset currP07 = currEdit.currP7>
		<cfset currP08 = currEdit.currP8>
		<cfset currP09 = currEdit.currP9>
		<cfset currP10 = currEdit.currP10>
		<cfset currP11 = currEdit.currP11>
		<cfset currP12 = currEdit.currP12>
		<cfset currP13 = currEdit.currP13>
		<cfset currP14 = currEdit.currP14>
		<cfset currP15 = currEdit.currP15>
		<cfset currP16 = currEdit.currP16>
		<cfset currP17 = currEdit.currP17>
		<cfset currP18 = currEdit.currP18>
	<cfelse>
		<h3>INVALID Currency! This currency is not in the database. Please contact administrator.</h3>
	</cfif>
</cfif>
<cfform action="currencyRateS2.cfm" method="post" name="createCurrency" preservedata="yes">
	<cfoutput>
		<input type="hidden" name="mode" value="#url.type#">
		<cfif isdefined("URl.currcode")>
			<input type="hidden" name="oriCode" value="#url.currcode#">
		</cfif>
		
		<h1>#url.type# Currency</h1>
	
		<h4>
			<a href="createCurrency.cfm?type=Create"> Create New Currency</a> || 
			<a href="vCurrency.cfm">List all Currency</a> 
		</h4>
		
		<cfif isdefined("form.status")>
			<h1>#form.status#</h1>
		</cfif>
	
		<table>
			<tr>
				<td>Currency Code :</td>
				<td>
					<cfif url.type eq "Delete" or url.type eq "Edit">
						<h2>#url.currcode#</h2>
						<input type="hidden" name="currcode" value="#currcode#">
					<cfelse>
						<!--- <cfinput type="text" name="currcode" value="" maxlength="20" size="20"> --->
						<cfquery name="getcurr" datasource="main">
							SELECT * FROM currencylist
						</cfquery>
						<select name="currcode" onChange="getcurrency(this.value);">
							<cfloop query="getcurr">
								<option value="#getcurr.code#">#getcurr.code# - #getcurr.desp#</option>
							</cfloop>
						</select>
		  			</cfif>
				</td>
			</tr>
			<tr>
				<td>Currency Symbol : (E.g S$)</td>
				<td><cfinput type="text" name="currency" value="#currency#" size="30"></td>		
			</tr>
			<tr>
				<td>Currency Dollars : (In words. E.g Singapore Dollars)</td>
				<td><cfinput type="text" name="CurrDollar" value="#currency1#" size="30"></td>		
			</tr>
			<tr>
				<td>Currency Cents : (In words. E.g Singapore Cents)</td>
				<td><cfinput type="text" name="CurrCent" value="#currency2#" size="30"></td>		
			</tr>
			<tr>
				<td>Currency Rate : </td>
				<td><cfinput type="text" name="Currrate" value="#currrate#" size="30"></td>		
			</tr>
            <cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,cost,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,filteritemreport,ddlitem,lbrand 
	from gsetup
</cfquery>
			<tr><td colspan="2"><hr></td></tr>
				<tr>
					<th>Period 1 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP01" value="#currP01#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=1">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 2 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP02" value="#currP02#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=2">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 3 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP03" value="#currP03#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=3">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 4 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP04" value="#currP04#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=4">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 5 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP05" value="#currP05#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=5">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 6 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP06" value="#currP06#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=6">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 7 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP07" value="#currP07#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=7">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 8 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP08" value="#currP08#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=8">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 9 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP09" value="#currP09#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=9">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP10" value="#currP10#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=10">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP11" value="#currP11#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=11">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP12" value="#currP12#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=12">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP13" value="#currP13#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=13">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP14" value="#currP14#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=14">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP15" value="#currP15#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=15">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP16" value="#currP16#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=16">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP17" value="#currP17#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=17">Edit Day Currency</a></cfif></td>
				</tr>
				<tr>
					<th>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')# :</th>
					<td><CFinput type="text" name="currP18" value="#currP18#"> <cfif url.type eq "Delete" or url.type eq "Edit"><a href="currencyMonth.cfm?type=Edit&currcode=#currcode#&period=18">Edit Day Currency</a></cfif></td>
				</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="#url.type#"></td>	
			</tr>
		</table>
	</cfoutput>
</cfform>

</body>
</html>