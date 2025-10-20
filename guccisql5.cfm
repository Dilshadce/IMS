<cfquery name="getcust" datasource="#dts#">
select * from itemgrd
</cfquery>

<cfoutput>

<cfloop query='getcust'>
<cfset qty1=0>

<cfloop from='11' to='40' index='i'> 
<cfset qty1=qty1+evaluate('getcust.grd#i#')>
</cfloop>
<cfif qty1 neq 0>
<cfquery name="insert" datasource="#dts#">
update icitem set qtybf='#qty1#' where itemno='#getcust.itemno#'
</cfquery>
</cfif>

</cfloop>

</cfoutput>