<cfquery name="getcust" datasource="#dts#">
SELECT custno from arcust where left(custno,4) <> "3000"
</cfquery>
<cfset counterstart = 0>
<cfloop query="getcust">
<cfset counterstart = counterstart + 1>
<cfquery name="updatecustno" datasource="#dts#">
update arcust SET custno = "300Z/#numberformat(counterstart,0000)#" WHERE custno = "#getcust.custno#"
</cfquery>

<cfquery name="updateartran" datasource="#dts#">
update artran SET custno = "300Z/#numberformat(counterstart,0000)#" WHERE custno = "#getcust.custno#"
</cfquery>

<cfquery name="updateartran" datasource="#dts#">
update ictran SET custno = "300Z/#numberformat(counterstart,0000)#" WHERE custno = "#getcust.custno#"
</cfquery>

</cfloop>

<cfquery name="getcust" datasource="#dts#">
SELECT custno from apvend where left(custno,4) <> "4000"
</cfquery>
<cfset counterstart = 0>
<cfloop query="getcust">
<cfset counterstart = counterstart + 1>
<cfquery name="updatecustno" datasource="#dts#">
update apvend SET custno = "400Z/#numberformat(counterstart,0000)#" WHERE custno = "#getcust.custno#"
</cfquery>

<cfquery name="updateartran" datasource="#dts#">
update artran SET custno = "400Z/#numberformat(counterstart,0000)#" WHERE custno = "#getcust.custno#"
</cfquery>

<cfquery name="updateartran" datasource="#dts#">
update ictran SET custno = "400Z/#numberformat(counterstart,0000)#" WHERE custno = "#getcust.custno#"
</cfquery>

</cfloop>