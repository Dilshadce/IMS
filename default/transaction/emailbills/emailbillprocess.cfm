<cfoutput>
<cfif isdefined('form.donotshow')>
<cfquery name="updateemailalert" datasource="#dts#">
update gsetupemail set Q#url.tran#=""
</cfquery>
</cfif>

<script type="application/javascript">
ColdFusion.Window.hide('emailcontrol');
<cfif form.sendbill2 eq "Yes">
ColdFusion.Window.show('emailcontent');
</cfif>

</script>

</cfoutput>