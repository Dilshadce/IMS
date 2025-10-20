<cftry>
<cffunction name="findCurrentSetInv" output="true">
	<cfargument name="input" type="query" required="yes">
	<cfargument name="refno" type="string" required="yes">
	<cfset prefixRefno=left(arguments.refno,3)>
	<cfif left(input.invno,3) eq prefixRefno>
		<cfreturn 1>
	<cfelseif left(input.invno_2,3) eq prefixRefno>
		<cfreturn 2>
	<cfelseif left(input.invno_3,3) eq prefixRefno>
		<cfreturn 3>
	<cfelseif left(input.invno_4,3) eq prefixRefno>
		<cfreturn 4>
	<cfelseif left(input.invno_5,3) eq prefixRefno>
		<cfreturn 5>
	<cfelse>
		<cfreturn 6>
	</cfif> 
</cffunction>
<cfquery name="getTypeBill" datasource="#dts#">
SELECT iaft,invoicedatafile,externalthirdparty,compro7,compro6,compro5,compro4,compro3,compro2,compro from gsetup
</cfquery>

<cfif isdefined('form.attachbill')>

<cfloop list="#form.attachbill#" index="i">
<cfif getTypeBill.iaft eq "Default">

<cfset url.tran = "INV">
<cfset url.nexttranno = "#i#">
<cfset url.pdf ="true">
<cfdocument format="pdf" backgroundvisible="no" pagetype="a4" scale="100" filename="#HRootPath#\eInvoicing\#dts#\bill\#i#.pdf" overwrite="yes">
<cfinclude template="/billformat/#dts#/transactionformat.cfm">
</cfdocument>

<cfelse>

<cfset url.tran = "INV">
<cfset url.nexttranno = "#i#">
<cfset billname = "#getTypeBill.iaft#">
<cfset url.pdf ="true">
<cfset doption = "0">
<cfinclude template="/billformat/#dts#/einvoice_preprintedformat.cfm">

</cfif>

</cfloop>
</cfif>
<cfoutput>
<cfmail to="shicai@mynetiquette.com" from="#getTypeBill.compro7#" type="html" subject="E-Invoice[#getTypeBill.externalthirdparty#]" failto="#getTypeBill.compro7#">
<cfmailparam file = "#HRootPath#\eInvoicing\#dts#\iv3600#getTypeBill.invoicedatafile#.dat" >
<cfif isdefined('form.attachbill')>

<cfloop list="#form.attachbill#" index="i">
<cfmailparam file = "#HRootPath#\eInvoicing\#dts#\bill\#i#.pdf" >
</cfloop>

</cfif>

<p>
Regards,<br/>
#getTypeBill.compro#<br/>
#getTypeBill.compro2#<br/>
#getTypeBill.compro3#<br/>
#getTypeBill.compro4#<br/>
#getTypeBill.compro5#<br/>
#getTypeBill.compro6#<br/>
</p>
</cfmail>
</cfoutput>
<cfset msg="success">
<cfcatch type="any">
<cfset msg="fail:#cfcatch.Detail#">
</cfcatch>
</cftry>
<cfoutput>
   <form name="form1" id="form1" method="post" action="/default/eInvoicing/eInvoiceSubmitDone.cfm">
   <input type="hidden" name="msg" id="msg" value="#msg#" />
   <input type="hidden" name="invoicelist" id="invoicelist" value="#form.invoicelist#" />
   <cfif isdefined('form.attachbill')>
   <input type="hidden" name="attachedbill" id="attachedbill" value="#form.attachbill#" />
   </cfif>
   </form>
   </cfoutput>
   
   <script>
	form1.submit();
	</script>