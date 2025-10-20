<cfswitch expression = "#trancode#">
  <cfcase value="SO">
    <cfswitch expression = "#form.reporttype#">
	  <cfcase value="">
	    <cfoutput><h3><font color="##FF0000">Error, Please select a report type.</font></h3></cfoutput> 
        <cfabort>
	  </cfcase>
	  <cfcase value="1">
		  <cflocation url="..\reports\solistingdetail.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
      <cfcase value="2">
        <cflocation url="..\reports\solistingsummary.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
      <cfcase value="3">
        <cflocation url="..\reports\solistingoutstandingd.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
      <cfcase value="4">
        <cflocation url="..\reports\solistingoutstandings.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
      <cfcase value="5">
        <cflocation url="..\reports\solistingcompleted.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
    </cfswitch>
  </cfcase>
  
  <cfcase value="PO">
    <cfswitch expression = "#form.reporttype#">
	  <cfcase value="">
	    <cfoutput><h3><font color="##FF0000">Error, Please select a report type.</font></h3></cfoutput> 
        <cfabort>
	  </cfcase>

	  <cfcase value="1">
	    <cfif rgSort eq "GRN No" or rgSort eq "Contract No">
	      <cfoutput><h3><font color="##FF0000">Error, Please select the correct sorting.</font></h3></cfoutput> 
          <cfabort>
		<cfelse>
		  <cflocation url="..\reports\polistingdetail.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
		</cfif>
      </cfcase>

      <cfcase value="2">
	    <cfif rgSort eq "GRN No" or rgSort eq "Contract No">
	      <cfoutput><h3><font color="##FF0000">Error, Please select the correct sorting.</font></h3></cfoutput> 
          <cfabort>
		<cfelse>
		  <cflocation url="..\reports\polistingsummary.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
		</cfif>
      </cfcase>
      <cfcase value="3">
        <cflocation url="..\reports\polistingoutstandingd.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
      <cfcase value="4">
        <cflocation url="..\reports\polistingoutstandings.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
      <cfcase value="5">
        <cflocation url="..\reports\polistingcompleted.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&agentto=#agentto#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#&bf=#billfrom#&bt=#billto#">
      </cfcase>
    </cfswitch>
  </cfcase>
</cfswitch>

<!--- 
<cfswitch expression = "#form.reporttype#">
	<cfcase value="Detail">
		<cfif rgSort eq "GRN NO">
	    	<h3><font color="#FF0000">Error, Only Completed Sales Order Listing can be sort by GRN No.</font></h3>
			<cfabort>
		<cfelse>
			<cflocation url="..\reports\solistingdetail.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#">
		</cfif>
	</cfcase>
	<cfcase value="Summary">
		<cfif rgSort eq "GRN NO">
	    	<h3><font color="#FF0000">Error, Only Completed Sales Order Listing can be sort by GRN No.</font></h3>
			<cfabort>
		<cfelse>
			<cflocation url="..\reports\solisting.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#">
		</cfif>
	</cfcase>
	<cfcase value="Outstanding">
		<cflocation url="..\reports\solistingoutstanding.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#">
	</cfcase>
	<cfcase value="Completed">
		<cflocation url="..\reports\solistingcompleted.cfm?trantype=#trantype#&trancode=#trancode#&getfrom=#getfrom#&getto=#getto#&agentfrom=#agentfrom#&periodfrom=#periodfrom#&periodto=#periodto#&datefrom=#datefrom#&dateto=#dateto#&rgsort=#rgsort#">
	</cfcase>
</cfswitch>
--->

<!--- Please refer the source code below --->
<!--- <cfoutput>
<cfif getitem.wserialno eq "1">
			<form name="done" action="../transaction/transactionserial.cfm?complete=complete" method="post">
			<cfoutput>
				<cfif #form.mode# eq "Edit" or form.mode eq "Delete">
				<input type="hidden" name="itemcount" value="#itemcount#">
				<cfelse>
				<input type="hidden" name="itemcount" value="#itemcnt#">
			    </cfif>
				<input type="hidden" name="tran" value="#tran#">
				<input type="hidden" name="currrate" value="#currrate#">
				<input type="hidden" name="agenno" value="#agenno#">
				<input type="hidden" name="refno3" value="#refno3#">
				<input name="status" value="#status#" type="hidden">
				<input name="type" value="Inprogress" type="hidden">				
				<input type="hidden" name="nexttranno" value="#nexttranno#">
				<input type="hidden" name="custno" value="#form.custno#">
				<input type="hidden" name="readperiod" value="#form.readperiod#">
				<input type="hidden" name="nDateCreate" value="#form.nDateCreate#">
				<input type="hidden" name="itemno" value="#form.itemno#">
				<input type="hidden" name="qty" value="#form.qty#">
				
				<!--- <input type="hidden" name="nDateNow" value="#nDateNow#"> --->
				<input type="hidden" name="invoicedate" value="#dateformat(form.invoicedate,"dd/mm/yyyy")#">
			</cfoutput> 
		</form>
		
		<cfelse>
			<!--- Default page if nothing else --->
			<form name="done" action="../transaction/transaction3.cfm?complete=complete" method="post">
			<cfoutput>
				<!--- <input type="hidden" name="itemcount" value="#itemcount#"> --->
				<input type="hidden" name="tran" value="#tran#">
				<input type="hidden" name="currrate" value="#currrate#">
				<input type="hidden" name="agenno" value="#agenno#">
				<input type="hidden" name="refno3" value="#refno3#">
				<input name="status" value="#status#" type="hidden">
				<input name="type" value="Inprogress" type="hidden">				
				<input type="hidden" name="nexttranno" value="#nexttranno#">
				<input type="hidden" name="custno" value="#form.custno#">
				<input type="hidden" name="readperiod" value="#form.readperiod#">
				<input type="hidden" name="nDateCreate" value="#form.nDateCreate#">
				<!--- <input type="hidden" name="nDateNow" value="#nDateNow#"> --->
				<input type="hidden" name="invoicedate" value="#dateformat(form.invoicedate,"dd/mm/yyyy")#">
			</cfoutput> 
			</form>
		</cfif>
		
		
	</cfoutput>
<script>
	done.submit();
</script> --->