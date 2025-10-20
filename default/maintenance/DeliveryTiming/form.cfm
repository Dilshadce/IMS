 <cfif cgi.HTTP_HOST eq 'ims2.netiquette.com.sg' or cgi.HTTP_HOST eq 'ims.netiquette.com.sg' or cgi.HTTP_HOST eq 'imspro.netiquette.com.sg'>
<cfset imsdts = dts>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfelse>
 <cfinclude template="/_dsp/dsp_header.cfm"> 
<cfif not len(getAuthUser())>
	<cfset request.loginmessage = <!--- request.loginmessage &  --->"<br>You must be authorized to access that area ... Please login.">
	<cfinclude template="#Application.webroot#security/login.cfm">
</cfif>
</cfif>
<cfoutput>
<table border="0" >
<tr>
<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="setDeliveryTiming.cfm"><b>Set the Delivery Timing</b></a></td>
<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="list.cfm"><b>Delivery Timing Listing</b></a></td>
<!---<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="electrolist.cfm"><b>Production Routing Card List</b></a></td> --->
</tr>
</table>

<cftry>
<cfinclude template="/cfc/istime.cfm">
<cfcatch type="any">
<cfinclude template="istime.cfm">
</cfcatch>
</cftry>
<cfif isdefined('form.submit')>
<cfif form.type eq 'Create'>
<cfquery name="insert" datasource="#imsdts#">
insert into DeliveryTiming (option1,
<cfloop from="1" to="4" index="a">
<cfif isdefined('form.day#a#')>
day#a#,
</cfif>
<cfif isTime(evaluate('form.time#a#'))>
time#a#,
</cfif>
<cfif isTime(evaluate('form.totime#a#'))>
totime#a#,
</cfif>
</cfloop>
created_on,
created_by
)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.option#">,
<cfloop from="1" to="4" index="a">
<cfif isdefined('form.day#a#')>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.day#a#')#">,
</cfif>
<cfif isTime(evaluate('form.time#a#'))>
<cfqueryparam cfsqltype="cf_sql_time" value="#evaluate('form.time#a#')#">,
</cfif>
<cfif isTime(evaluate('form.totime#a#'))>
<cfqueryparam cfsqltype="cf_sql_time" value="#evaluate('form.totime#a#')#">,
</cfif>
</cfloop>
now(),
'#getauthuser()#'
)
</cfquery>


<cfelseif form.type eq 'Edit'>

<cfquery name="edit" datasource="#imsdts#">
update DeliveryTiming set
option1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.option#">,
<cfloop from="1" to="4" index="a">
<cfif isdefined('form.day#a#')>
day#a#=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.day#a#')#">,
</cfif>
<cfif isTime(evaluate('form.time#a#'))>
time#a#=<cfqueryparam cfsqltype="cf_sql_time" value="#evaluate('form.time#a#')#">,
</cfif>
<cfif isTime(evaluate('form.totime#a#'))>
totime#a#=<cfqueryparam cfsqltype="cf_sql_time" value="#evaluate('form.totime#a#')#">,
</cfif>
</cfloop>
updated_on=now(),
updated_by='#getAuthuser()#'
where id = '#form.id#'
</cfquery>


<cfelse>

<cfquery name="edit" datasource="#imsdts#">
delete from DeliveryTiming 
where id = '#form.id#'
</cfquery>
</cfif>


<script type="text/javascript">
alert('#form.type# Successfully');
window.location.href='list.cfm';
</script>
<cfabort>
</cfif>






<cfset option = ''>
<cfset id = ''>

<cfloop from="1" to="7" index="a">
<cfset 'day#a#' = ''>
<cfset 'time#a#' = ''>
<cfset 'totime#a#' = ''>
</cfloop>


<cfif url.type eq 'Edit' or url.type eq 'Delete'>
<cfquery name="get" datasource="#imsdts#">
select * from DeliveryTiming where id = '#url.id#'
</cfquery>
<cfset option = get.option1>
<cfset id = get.id>

<cfloop from="1" to="4" index="a">
<cfset 'day#a#' = evaluate('get.day#a#')>
<cfset 'time#a#' = evaluate('get.time#a#')>
<cfset 'totime#a#' = evaluate('get.totime#a#')>
</cfloop>

</cfif>
<h4>#url.type# Delivery Timing</h4>
<form method="post" action="">
<input type="hidden" name="type" id="type" value="#url.type#">
<input type="hidden" name="id" id="id" value="#id#">
<table align="center" class="data">
<tr>
<th style="border-bottom:solid black 1px">Delivery Timing Option</th>
<td style="border-bottom:solid black 1px"><input type="text" required name="option" id="option" value="#option#">
</td>
</tr>
<tr>
<th>
Day
</th>
<th>
Time
</th>
</tr>


<cfloop list="1:AM,2:PM,3:Night,4:Saturday" index="a">
<tr>
<td>
<input type="checkbox"  name="day#listfirst(a,':')#" <cfif evaluate('day#listfirst(a,':')#') eq listfirst(a,':')>checked</cfif> id="day#listfirst(a,':')#" value="#listfirst(a,':')#">
#listlast(a,':')#
</td>
<td>

<cfset dtHour = CreateTimeSpan(
0, <!--- Days. --->
0, <!--- Hours. --->
15, <!--- Minutes. --->
0 <!--- Seconds. --->
) />
 
 
<!---
When looping over the hours in the day, we can enter the
start and end time as "readable" time. ColdFusion will
automatically convert those time strings to their numeric
equivalents for use within the index loop.
--->
<select name="time#listfirst(a,':')#">
<option value="">-Select Time-</option>
<cfloop
index="dtTime"
from="12:00 AM"
to="11:59 PM"
step="#dtHour#">
 
<br />
 

<option <cfif timeformat(evaluate('time#listfirst(a,':')#'),'hh:mm TT') eq TimeFormat( dtTime, "hh:mm TT" )> selected</cfif> value="#TimeFormat( dtTime, "hh:mm TT" )#">#TimeFormat( dtTime, "hh:mm TT" )#</option>

</cfloop>
</select> to 
<select name="ToTime#listfirst(a,':')#">
<option value="">-Select Time-</option>
<cfloop
index="dtTime"
from="12:00 AM"
to="11:59 PM"
step="#dtHour#">
 
<br />
 

<option <cfif timeformat(evaluate('totime#listfirst(a,':')#'),'hh:mm TT') eq TimeFormat( dtTime, "hh:mm TT" )> selected</cfif> value="#TimeFormat( dtTime, "hh:mm TT" )#">#TimeFormat( dtTime, "hh:mm TT" )#</option>

</cfloop>
</select>

</td>
</tr>
</cfloop>

<tr>
<td colspan="2"><input type="submit" name="submit" id="submit" value="<cfif url.type eq 'Delete'>Delete<cfelse>Submit</cfif>">
</td>
</tr>
</table>
</form>


</cfoutput>