<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
	<cfoutput>
<form name="done" id="done" action="serial.cfm?complete=complete" method="post">

		<cfif form.mode eq "Edit" or form.mode eq "Delete">
			<input type="hidden" name="itemcount" id="itemcount" value="#listfirst(itemcount)#">
		<cfelse>
			<input type="hidden" name="itemcount" id="itemcount" value="#listfirst(itemcnt)#">
		</cfif>
			
		<input type="hidden" name="tran" id="tran" value="#listfirst(tran)#">
		<input type="hidden" name="currrate" id="currrate" value="#listfirst(currrate)#">
		<input type="hidden" name="agenno" id="agenno" value="#listfirst(agenno)#">
		<input type="hidden" name="refno3" id="refno3" value="#listfirst(refno3)#">
		<input type="hidden" name="status" id="status" value="#listfirst(status)#">
		<input type="hidden" name="type" id="type" value="#listfirst(mode)#">
		<input type="hidden" name="hmode" id="hmode" value="#listfirst(hmode)#">
        <input type="hidden" name="enterbatch" id="enterbatch" value="#listfirst(enterbatch)#">				
		<input type="hidden" name="nexttranno" id="nexttranno" value="#listfirst(nexttranno)#">
		<input type="hidden" name="custno" id="custno" value="#listfirst(form.custno)#">
		<input type="hidden" name="readperiod" id="readperiod" value="#listfirst(form.readperiod)#">
		<input type="hidden" name="nDateCreate" id="nDateCreate" value="#listfirst(nDateCreate)#">
		<input type="hidden" name="itemno" id="itemno" value="#convertquote(listfirst(form.itemno))#">
		<cfif val(form.factor2) neq 0>
			<cfset act_qty = val(form.qty) * val(form.factor1) / val(form.factor2)>
		<cfelse>
			<cfset act_qty = 0>
		</cfif>
		<input type="hidden" name="qty" id="qty" value="#act_qty#">
		<input type="hidden" name="location" id="location" value="#listfirst(location)#">
		<input type="hidden" name="invoicedate" id="invoicedate" value="#listfirst(form.invoicedate)#">
	    <input type="hidden" name="price" id="price" value="#form.price#">
	    
	    <cfif checkcustom.customcompany eq "Y">
			<input type="hidden" name="remark5" id="remark5" value="#listfirst(form.hremark5)#">	<!--- PERMIT NUMBER, ADD ON 24-03-2009 --->
			<input type="hidden" name="remark6" id="remark6" value="#listfirst(form.hremark6)#">
		</cfif>
			 
		<cfif isdefined("form.updunitcost")>
	    	<input type='hidden' name='updunitcost' id='updunitcost' value='#form.updunitcost#'>
		</cfif>

</form>
	</cfoutput> 

<script>
	done.submit();
</script>

<cfabort>