<cfif tran eq "INV">
	<cfquery name="get_invoice_set" datasource="#dts#">
		select 
		invoice_set
		from user_id_location 
		where userid='#jsstringformat(preservesinglequotes(HUserID))#';
	</cfquery>
	
	<cfset new_trancode = iif((get_invoice_set.invoice_set eq 0 or get_invoice_set.invoice_set eq 1),DE(trancode),DE(trancode&"_"&get_invoice_set.invoice_set))>
	<cfset new_tranarun = iif((get_invoice_set.invoice_set eq 0 or get_invoice_set.invoice_set eq 1),DE(tranarun),DE(tranarun&"_"&get_invoice_set.invoice_set))>
	
	<!---cfquery name="getGeneralInfo" datasource="#dts#">
		select 
		#new_trancode# as tranno,
		#new_tranarun# as arun,
		invoneset 
		from GSetup;
	</cfquery--->
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = '#tran#'
		and counter = '#get_invoice_set.invoice_set#'
	</cfquery> --->
	
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#tran#'
		and counter = '#get_invoice_set.invoice_set#'
	</cfquery>
<cfelse>
	<!---cfquery datasource="#dts#" name="getGeneralInfo">
		select #trancode# as tranno, #tranarun# as arun,invoneset from GSetup
	</cfquery--->
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = '#tran#'
		and counter = '1'
	</cfquery> --->
	
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#tran#'
		and counter = '1'
	</cfquery>
</cfif>
