<cfsetting showdebugoutput="no">
<cfif isdefined("searchdriver") and searchdriver neq "">
    <cfquery datasource="#dts#" name="qryData">
        SELECT driverno AS Code, name as Value from driver WHERE name like '#lcase(urlDecode(searchdriver))#%'
    </cfquery>    
    <ul>
		<cfoutput query="qryData">
        <li id="#qryData.Code#">#qryData.Code# - #qryData.Value#</li>
        </cfoutput>
    </ul>
<cfelseif isdefined("custno")>
	<cfif  custno neq "" and len(custno) gt 4>
	<cfif url.custtype eq "customer">
		<cfset ptype=target_arcust>
	<cfelse>
		<cfset ptype=target_apvend>
	</cfif>
	<cfquery datasource="#dts#" name="getLimit">
        SELECT custsupp_limit_display from gsetup
    </cfquery> 
	<cfquery datasource="#dts#" name="qryData">
        SELECT custno AS Code, name as Value from #ptype# WHERE custno like '#lcase(urlDecode(custno))#%' order by custno desc limit #getLimit.custsupp_limit_display#
    </cfquery>    
    <ul>
		<cfoutput><li id="#custno#">Latest Number...</li></cfoutput>
		<cfoutput query="qryData">
        <li id="#qryData.Code#">#qryData.Code# - #qryData.Value#</li>
        </cfoutput>
    </ul>
    </cfif>
<cfelseif isdefined("itemno")>
	<cfif itemno neq "">
	<cfquery datasource="#dts#" name="qryData">
        SELECT itemno AS Code, desp as Value from icitem WHERE itemno like '#lcase(urlDecode(itemno))#%' order by itemno desc limit 1
    </cfquery>    
    <ul>
		<cfoutput query="qryData">
        <li id="#qryData.Code#">#qryData.Code# - #qryData.Value#</li>
        </cfoutput>
    </ul>
    </cfif>
<cfelse>
</cfif>