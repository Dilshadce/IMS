<cfquery name="getcust" datasource="#dts#">
select * from icitem3 group by wos_group
</cfquery>

<cfoutput>

<cfloop query='getcust'>

<cfquery name="getcust2" datasource="#dts#">
select * from icitem3 where wos_group='#getcust.wos_group#' group by size order by size
</cfquery>

<cfset sizea=11>

<cfloop query='getcust2'>

<cfquery name="insert" datasource="#dts#">
update icgroup set gradd#sizea#='#getcust2.size#' where wos_group='#getcust.wos_group#'
</cfquery>

<cfset sizea=sizea+1>

</cfloop>




</cfloop>

</cfoutput>