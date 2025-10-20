<cfquery name="getclaim" datasource="#dts#">
SELECT * FROM temptable61c where jono <> "" and claimtype <> ""
</cfquery>
<cfloop query="getclaim">
<cfloop list="#getclaim.claimtype#" index="a">
<cfquery name="getgroup" datasource="#dts#">
SELECT wos_group from icgroup WHERE desp = "#a#"
</cfquery>
<cfif getgroup.recordcount neq 0 >
<cfquery name="updateclaim" datasource="#dts#">
UPDATE placement
SET
#getgroup.wos_group#payable = "Y"
,#getgroup.wos_group#billable = "Y"
WHERE
placementno = "#getclaim.jono#"
</cfquery>
</cfif>
</cfloop>
</cfloop>