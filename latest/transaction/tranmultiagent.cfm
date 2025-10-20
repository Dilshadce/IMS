<cftry>
<cfquery name="getagent1" datasource="#dts#">
SELECT "" as agentid, "Choose an agent" as agent
union all
select * from (
  select agent as agentid, agent as agent from #target_icagent# <cfif getpin2.h1B40 eq 'T'>where agent = '#huserid#'</cfif> order by agent) as a
</cfquery>
<cfif isdefined('url.ttype')>
<cfset trantype = url.ttype>
<cfelseif isdefined('form.type')>
<cfset trantype = form.type >
<cfelse>
<cfset trantype = "Create">
</cfif>
<cfif trantype eq "Create">
<cfset multiagent1 = "">
<cfset multiagent2 = "">
<cfset multiagent3 = "">
<cfset multiagent4 = "">
<cfset multiagent5 = "">
<cfset multiagent6 = "">
<cfset multiagent7 = "">
<cfset multiagent8 = "">
<cfelse>
<cfquery name="getmultiagent" datasource="#dts#">
select multiagent1,multiagent2,multiagent3,multiagent4,multiagent5,multiagent6,multiagent7,multiagent8 from artran where refno='#refno#' and type = "#tran#"
</cfquery>
<cfset multiagent1 = getmultiagent.multiagent1>
<cfset multiagent2 = getmultiagent.multiagent2>
<cfset multiagent3 = getmultiagent.multiagent3>
<cfset multiagent4 = getmultiagent.multiagent4>
<cfset multiagent5 = getmultiagent.multiagent5>
<cfset multiagent6 = getmultiagent.multiagent6>
<cfset multiagent7 = getmultiagent.multiagent7>
<cfset multiagent8 = getmultiagent.multiagent8>
</cfif>

<cfoutput>
  	<table align="center" class="data" width="770">
    <tr>
    <th colspan="4"><div align="center">Multi Agent</div>
    </th>
    </tr>
    <cfloop from="1" to="7" index="i" step="2">
    <tr>
    <td>#getGsetup.lAGENT# #i#</td>
    <cfset selectedvar = "multiagent"&i>
    <cfset selectedfield = evaluate('#selectedvar#')>
    <td><cfselect name="multiagent#i#" id="multiagent#i#" query="getagent1" value="agentid" display="agent" selected="#selectedfield#" /></td>
    <td>#getGsetup.lAGENT# #i+1#</td>
    <cfset selectedvar = "multiagent"&i+1>
    <cfset selectedfield = evaluate('#selectedvar#')>
    <td><cfselect name="multiagent#i+1#" id="multiagent#i+1#" query="getagent1" value="agentid" display="agent" selected="#selectedfield#" /></td>
    </tr>
    </cfloop>
    </table>
</cfoutput>
<cfcatch type="any">
</cfcatch>
</cftry>