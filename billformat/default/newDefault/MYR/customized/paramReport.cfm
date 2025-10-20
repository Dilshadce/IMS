<cfquery name="getcninvdate" datasource="#dts#">
	SELECT wos_date 
	FROM artran
	WHERE refno = "#getheaderinfo.rem49#" and type="INV";
</cfquery>

<cfif tran eq "tr">
<cfquery name="gettradd" datasource="#dts#">
	SELECT * FROM iclocation where location="#getheaderinfo.rem1#"
</cfquery>

<cfquery name="gettradd2" datasource="#dts#">
	SELECT * FROM iclocation where location="#getheaderinfo.rem2#"
</cfquery>

</cfif>

<cfquery name="getformattype" datasource="#dts#">
	select * from customized_format where <cfif IsDefined("url.counter")>counter="#url.counter#" and </cfif> type="#url.tran#"
</cfquery>



<cfreport template="#fname#" format="#getformattype.format#" query="MyQuery">    	
    <cfreportparam name="amsLink" value="#IIF(Hlinkams eq 'Y',DE('yes'),DE('no'))#">
    <cfreportparam name="dts" value="#dts#">
    <cfreportparam name="custSupp" value="#ptype#">
    <cfreportparam name="decimalPlace_unitPrice" value="#getGsetup2.Decl_Uprice#">
    <cfreportparam name="decimalPlace_discount" value="#getGsetup2.Decl_Discount#">
    <cfreportparam name="decimalPlace_totalAmt" value="#getGsetup2.Decl_TotalAmt#">
    <cfreportparam name="compro" value="#getGsetup.compro#">
    <cfloop index="i" from="2" to="10">
    	<cfreportparam name="compro#i#" value="#evaluate('getGsetup.compro#i#')#">
	</cfloop>
    <cfreportparam name="companyCurrency" value="#getGsetup.bcurr#">
    <cfreportparam name="GSTno" value="#getGsetup.gstno#">
    <cfreportparam name="gst" value="">
    <cfreportparam name="companyUEN" value="#getGsetup.comuen#">
    <cfloop index="i" from="5" to="11">
    	<cfreportparam name="headerRemark#i#" value="#evaluate('getGsetup.rem#i#')#">
	</cfloop>    
    <cfreportparam name="currencyCodeControl" value="#getHeaderInfo.currencyCode#">
    <cfreportparam name="taxInclude" value="#getHeaderInfo.taxincl#">
    <cfreportparam name="cash" value="#getHeaderInfo.cs_pm_cash#">
    <cfreportparam name="cheque" value="#getHeaderInfo.cs_pm_cheq#">
    <cfreportparam name="cheqno" value="#getHeaderInfo.checkno#">
    <cfreportparam name="creditCard1" value="#getHeaderInfo.cs_pm_crcd#">
    <cfreportparam name="creditCard2" value="#getHeaderInfo.cs_pm_crc2#">
    <cfreportparam name="voucher" value="#getHeaderInfo.cs_pm_vouc#">
    <cfreportparam name="debitCard" value="#getHeaderInfo.cs_pm_dbcd#">
    <cfreportparam name="debt" value="#getHeaderInfo.cs_pm_debt#">
    <cfreportparam name="miscellaneousCharges" value="#getHeaderInfo.mc1_bil#">
    <cfreportparam name="termsCondition" value="#getHeaderInfo.termscondition#">
    <cfloop index="i" from="30" to="47">
    	<cfreportparam name="rem#i#" value="#evaluate('getHeaderInfo.rem#i#')#">
	</cfloop>
    
    <cfif IsDefined("getheaderinfo.returnreason") AND  getheaderinfo.returnreason neq "">
    	<cfreportparam name="rem48" value="#getHeaderInfo.returnreason#">
    <cfelse>
    	<cfreportparam name="rem48" value="#getHeaderInfo.rem48#">
    </cfif>

    <cfif IsDefined("getheaderinfo.returnbillno") AND getheaderinfo.returnbillno neq "">
    	<cfreportparam name="rem49" value="#getHeaderInfo.returnbillno#">
    <cfelse>
    	<cfreportparam name="rem49" value="#getHeaderInfo.rem49#">
    </cfif>

    <cfif IsDefined("getheaderinfo.returndate") AND getheaderinfo.returndate neq "" and isdate(getheaderinfo.returndate)>
    	<cftry>
    		<cfset rem50date=createdate(right(getheaderinfo.returndate,4),mid(getheaderinfo.returndate,4,2),left(getheaderinfo.returndate,2))>
    	<cfcatch>
    		<cfif Len(getheaderinfo.returndate) GT 8>
	    		<cfset rem50date=createdate(right(getheaderinfo.returndate,4),listgetat(getheaderinfo.returndate,2,'/'),listgetat(getheaderinfo.returndate,1,'/'))>
       	 	<cfelse>
	    		<cfset rem50date=createdate(right(getheaderinfo.returndate,2),listgetat(getheaderinfo.returndate,2,'/'),listgetat(getheaderinfo.returndate,1,'/'))>
        	</cfif>
    	</cfcatch>
    	</cftry>
    
    	<cfreportparam name="rem50" value="#rem50date#">
    <cfelse>
    	<cfreportparam name="rem50" value="#getcninvdate.wos_date#">
    </cfif>
    
    <cfreportparam name="agentSignature" value="#getHeaderInfo.agentSignature#">
    <cfreportparam name="termCode" value="#getHeaderInfo.termCode#">
    <cfreportparam name="termDesp" value="#getHeaderInfo.termDesp#">
    <cfreportparam name="soNo" value="#getHeaderInfo.sono#">
    <cfreportparam name="quoNo" value="#getHeaderInfo.quono#">
    <cfreportparam name="projectDesp" value="#getHeaderInfo.projectDesp#">
    <cfreportparam name="jobDesp" value="#getHeaderInfo.jobDesp#">
    <cfreportparam name="driverNo" value="#getHeaderInfo.driverno#">
    <cfreportparam name="driverName" value="#getHeaderInfo.name#">
    <cfif getHeaderInfo.username NEQ ''>
        <cfreportparam name="username" value="#getHeaderInfo.username#">
    <cfelse>
        <cfreportparam name="username" value="#getUserName.username#">
    </cfif> 
    <cfif tran eq "tr">
    <cfreportparam name="trfradd1" value="#gettradd.addr1#"> 
    <cfreportparam name="trfradd2" value="#gettradd.addr2#"> 
    <cfreportparam name="trfradd3" value="#gettradd.addr3#"> 
    
    <cfreportparam name="trtoadd1" value="#gettradd2.addr1#"> 
    <cfreportparam name="trtoadd2" value="#gettradd2.addr2#"> 
    <cfreportparam name="trtoadd3" value="#gettradd2.addr3#"> 
    </cfif>

    <cfreportparam name="createdBy" value="#getHeaderInfo.created_by#"> 
    <cfreportparam name="companyLogo" value="#companyLogo#">    
</cfreport>