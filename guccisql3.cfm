<cfquery name="getcust" datasource="#dts#">
select * from icitem3 where size<>''
</cfquery>

<cfoutput>

<cfloop query='getcust'>

<cfquery name="getcust2" datasource="#dts#">
select * from icgroup where wos_group='#getcust.wos_group#'
</cfquery>


<cfloop from='11' to='40' index='i'> 

<cfif evaluate('getcust2.gradd#i#') eq getcust.size>

<cfoutput>
#itemno# - #i#-#getcust.size#-#getcust2.wos_group#--#evaluate('getcust2.gradd#i#')# <br>
</cfoutput>

<cfquery name="insert" datasource="#dts#">
update itemgrd set grd#i#='#getcust.qtybf#' where itemno='#getcust.itemno#'
</cfquery>
</cfif>

</cfloop>




</cfloop>

</cfoutput>