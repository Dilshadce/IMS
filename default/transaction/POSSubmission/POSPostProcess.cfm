<cfquery name="getfilename" datasource="#dts#">
    select * from POSFTP
</cfquery>

<cfftp connection="testftp" server="#getfilename.ftphost#" username="#getfilename.ftpuser#" password="#getfilename.ftppass#" port="#getfilename.ftpport#" action="open" stoponerror="yes">


<cfoutput>
   <form name="form1" id="form1" method="post" action="/default/eInvoicing/eInvoiceSubmitDone.cfm">
   <input type="hidden" name="msg" id="msg" value="" />
   <input type="hidden" name="invoicelist" id="invoicelist" value="#form.invoicelist#" />
   <cfif isdefined('form.attachbill')>
   <input type="hidden" name="attachedbill" id="attachedbill" value="#form.attachbill#" />
   </cfif>
   </form>
   </cfoutput>
   
   <script>
	form1.submit();
	</script>