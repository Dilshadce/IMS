<cfquery name="updategsetup" datasource="#dts#">
update gsetup set skipwizard='Y'
</cfquery>
<cflocation url="/index.cfm">