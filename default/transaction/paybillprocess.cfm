<cfquery name="gettran" datasource="#dts#">
select grand_bil from artran where type='#form.billtype#' and refno='#form.refno#'
</cfquery>



<cfquery name="updatetran" datasource="#dts#">
update artran set cs_pm_cash=<cfif val(form.paycash) gt gettran.grand_bil>'#val(gettran.grand_bil)#'<cfelse>'#val(form.paycash)#'</cfif>,cs_pm_cheq='#val(form.cheq)#',cs_pm_crcd='#val(form.cc1)#',cs_pm_crc2='#val(form.cc2)#',cs_pm_dbcd='#val(form.dbcd)#',cs_pm_vouc='#val(form.vouc)#',deposit='#val(form.deposit)#',cs_pm_cashcd='#val(form.cashc)#',cs_pm_debt='#val(form.change)*-1#',creditcardtype1='#form.cctype1#',creditcardtype2='#form.cctype2#',checkno='#form.chequeno#',refno2='#form.refno2#' where type='#form.billtype#' and refno='#form.refno#'
</cfquery>

<cfquery name="updatedeposit" datasource="#dts#">
update deposit set billno='' where billno='#form.refno#'
</cfquery>

<cfquery name="updatedeposit2" datasource="#dts#">
update deposit set billno='#form.refno#' where depositno='#form.depositno#'
</cfquery>


<script language="javascript" type="text/javascript">
window.close();
</script>