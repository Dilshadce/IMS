 <cfquery name="getdata" datasource="#dts#">
select reference from #replacenocase(dts,"_i","_a","all")#.glpost order by entry desc limit 1
</cfquery>

<cfquery name="getcolumn" datasource="#dts#">
SELECT reference FROM glpost91 WHERE fperiod = "#url.period#" 
<cfif url.type neq "ALL">
AND acc_code = "#url.type#"
</cfif>
group by reference
order by reference
</cfquery>
<cfif getcolumn.recordcount neq 0>
<cfset currentrow = 0>
<cfloop query="getcolumn">
<cfif getcolumn.reference eq getdata.reference>
<cfset currentrow = getcolumn.currentrow >
<cfbreak>
</cfif>
</cfloop>
<cfset totalrow = getcolumn.recordcount>
<cfset totalpercentage = val(currentrow)/val(totalrow) * 100>
<cfoutput>
<h1>#numberformat(totalpercentage,'.__')# %</h1>
</cfoutput>
</cfif>