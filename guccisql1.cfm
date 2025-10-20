<cfquery name="getcust" datasource="#dts#">
select * from icitem group by wos_group
</cfquery>

<cfoutput>

<cfloop query='getcust'>

<cfquery name="getcust2" datasource="#dts#">
insert into icgroup (wos_group,desp) values ('#getcust.wos_group#','#getcust.wos_group#')
</cfquery>

</cfloop>

</cfoutput>