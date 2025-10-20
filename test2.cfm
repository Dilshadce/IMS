<cfif isdefined('form.yearfield')>
<cfif form.yearfield mod 4 eq 0>
<cfset thisyear = 366>
<cfelse>
<cfset thisyear = 365>
</cfif>

<cfset monthkey = "0">
<cfset monkey = 0>
<cfset tuekey = 0>
<cfset wedkey = 0>
<cfset thukey = 0>
<cfset frikey = 0>
<cfset satkey = 0>
<cfset sunkey = 0>

<cfset datestart = createdate('#form.yearfield#',1,1)>
<cfoutput>
<table>
<tr>
<th>Month</th>
<th>Mon</th>
<th>Tues</th>
<th>Wed</th>
<th>Thur</th>
<th>Fri</th>
<th>Sat</th>
<th>Sun</th>
</tr>

<cfloop from="0" to="#thisyear-1#" index="a">
<cfset datenow = dateadd("d",a,datestart)>
<cfif a neq 0 and dateformat(datenow,'m') neq monthkey>
<td>#monkey#</td>
<td>#tuekey#</td>
<td>#wedkey#</td>
<td>#thukey#</td>
<td>#frikey#</td>
<td>#satkey#</td>
<td>#sunkey#</td>
</tr>
<cfset monkey = 0>
<cfset tuekey = 0>
<cfset wedkey = 0>
<cfset thukey = 0>
<cfset frikey = 0>
<cfset satkey = 0>
<cfset sunkey = 0>

</cfif>

<cfif dateformat(datenow,'m') neq monthkey>
<tr>
<td>#dateformat(datenow,'mmmm')#</td>
<cfset monthkey = dateformat(datenow,'m')>
</cfif>

<cfif dayofweek(datenow) eq 1>
<cfset sunkey = sunkey + 1>
</cfif>

<cfif dayofweek(datenow) eq 2>
<cfset monkey = monkey + 1>
</cfif>

<cfif dayofweek(datenow) eq 3>
<cfset tuekey = tuekey + 1>
</cfif>

<cfif dayofweek(datenow) eq 4>
<cfset wedkey = wedkey + 1>
</cfif>

<cfif dayofweek(datenow) eq 5>
<cfset thukey = thukey + 1>
</cfif>

<cfif dayofweek(datenow) eq 6>
<cfset frikey = frikey + 1>
</cfif>

<cfif dayofweek(datenow) eq 7>
<cfset satkey = satkey + 1>
</cfif>

<cfif a eq thisyear-1>
<td>#monkey#</td>
<td>#tuekey#</td>
<td>#wedkey#</td>
<td>#thukey#</td>
<td>#frikey#</td>
<td>#satkey#</td>
<td>#sunkey#</td>
</tr>
</cfif>

</cfloop>

</table>
</cfoutput>
</cfif>