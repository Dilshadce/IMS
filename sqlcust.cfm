<cfquery name="getallitem" datasource="#dts#">
	select * from arcust2 
</cfquery>

<cfloop query="getallitem">

<cfset custno1='3'&numberformat(custno,'0000000')>
<cfquery name="insertlocqdbf" datasource="#dts#">
	update arcust2 set custno='#custno1#' where custno='#getallitem.custno#'
</cfquery>

</cfloop>
