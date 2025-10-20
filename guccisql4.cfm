<cfquery name="getcust" datasource="#dts#">
select * from icitem3 group by itemno
</cfquery>

<cfoutput>

<cfloop query='getcust'>

<cfquery name="getcust2" datasource="#dts#">
insert into itemgrd (itemno) values ('#getcust.itemno#')
</cfquery>


</cfloop>

</cfoutput>