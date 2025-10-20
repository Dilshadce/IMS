<cfquery name="insertrow" datasource="#dts#">
INSERT INTO recordtime (updated_on)
VALUES (now())
</cfquery>
<cfoutput>
<script type="text/javascript">
function gotopage()
{
window.location.href='checkuptine.cfm';
}
setTimeout('gotopage();',60000);
</script>
</cfoutput>