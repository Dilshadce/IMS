<cfquery name="gettran" datasource="#dts#">
select grand_bil from artran where type='#form.billtype#' and refno='#form.refno#'
</cfquery>



<cfquery name="updatetran" datasource="#dts#">
update artran set deposit='#val(form.deposit)#',cs_pm_debt='#val(form.change)*-1#',refno2='#form.refno2#' where type='#form.billtype#' and refno='#form.refno#'
</cfquery>

<script language="javascript" type="text/javascript">
window.close();
</script>