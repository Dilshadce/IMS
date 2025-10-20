<h2>Assign item forecast for <cfoutput>#url.itemno#</cfoutput></h2>
<cfquery name="getpromo" datasource="#dts#">
SELECT * FROM icitem WHERE itemno = "#url.itemno#"
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lastaccyear from gsetup
</cfquery>

<cfquery name="checkexist1" datasource="#dts#">
SELECT * FROM icitemforecast WHERE itemno = "#url.itemno#"
</cfquery>

<cfif checkexist1.recordcount neq 0>
<cfset periodone= checkexist1.period1>
<cfset periodtwo= checkexist1.period2>
<cfset periodthree= checkexist1.period3>
<cfset periodfour= checkexist1.period4>
<cfset periodfive= checkexist1.period5>
<cfset periodsix= checkexist1.period6>
<cfset periodseven= checkexist1.period7>
<cfset periodeight= checkexist1.period8>
<cfset periodnine= checkexist1.period9>
<cfset periodten= checkexist1.period10>
<cfset periodeleven= checkexist1.period11>
<cfset periodtwelve= checkexist1.period12>
<cfset periodthirteen= checkexist1.period13>
<cfset periodfourteen= checkexist1.period14>
<cfset periodfivteen= checkexist1.period15>
<cfset periodsixteen= checkexist1.period16>
<cfset periodseventeen= checkexist1.period17>
<cfset periodeighteen= checkexist1.period18>
<cfelse>
<cfset periodone= "">
<cfset periodtwo= "">
<cfset periodthree= "">
<cfset periodfour= "">
<cfset periodfive= "">
<cfset periodsix= "">
<cfset periodseven= "">
<cfset periodeight= "">
<cfset periodnine= "">
<cfset periodten= "">
<cfset periodeleven= "">
<cfset periodtwelve= "">
<cfset periodthirteen= "">
<cfset periodfourteen= "">
<cfset periodfivteen= "">
<cfset periodsixteen= "">
<cfset periodseventeen= "">
<cfset periodeighteen= "">
</cfif>
<cfoutput>
<table>
<tr>
<th>
Item No:
</th>
<td>
#url.itemno#
</td>
<th>
Item Description:
</th>
<td>
#getpromo.desp#
</td>
</tr>

</table>
</cfoutput>
<cfform action="additemprocess.cfm" name="assignitem" method="post">
<cfoutput><input type="hidden" name="promoidlist" id="promoidlist" value="#url.itemno#" /></cfoutput>
<cfset itemno = "#url.itemno#">
<table>
<cfoutput>
<tr>
<th>
Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td>
<cfinput type="text" name="period1" id="period1" value="#periodone#" /></td>
<th>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period2" id="period2" value="#periodtwo#" /></td>
<th>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period3" id="period3" value="#periodthree#"/></td>

<tr><th>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period4" id="period4" value="#periodfour#" /></td>
<th>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period5" id="period5" value="#periodfive#" /></td>
<th>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period6" id="period6" value="#periodsix#" /></td>
</tr>

<tr><th>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period7" id="period7" value="#periodseven#" /></td>
<th>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period8" id="period8" value="#periodeight#" /></td>
<th>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period9" id="period9" value="#periodnine#" /></td>
</tr>

<tr><th>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period10" id="period10" value="#periodten#" /></td>
<th>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period11" id="period11" value="#periodeleven#" /></td>
<th>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period12" id="period12" value="#periodtwelve#" /></td>
</tr>

<tr><th>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period13" id="period13" value="#periodthirteen#"/></td>
<th>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period14" id="period14" value="#periodfourteen#"/></td>
<th>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period15" id="period15" value="#periodfivteen#"/></td>
</tr>

<tr><th>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period16" id="period16" value="#periodsixteen#"/></td>
<th>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period17" id="period17" value="#periodseventeen#"/></td>
<th>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</th>
<td><cfinput type="text" name="period18" id="period18" value="#periodeighteen#"/></td>
<td><cfinput type="hidden" name="itemno" id="itemno" value="#url.itemno#" /></td>
</tr>

<tr><td>
<input type="submit" name="submit" id="submit" value="ADD ITEM" /></td>
</tr>
</cfoutput>
</table>
</cfform>
