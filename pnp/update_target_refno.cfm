<cfif tran eq "INV">
	<cfquery name="get_invoice_set" datasource="#dts#">
		select 
		invoice_set
		from user_id_location 
		where userid='#jsstringformat(preservesinglequotes(HUserID))#';
	</cfquery>
	
	<cfset new_trancode = iif((get_invoice_set.invoice_set eq 0 or get_invoice_set.invoice_set eq 1),DE(trancode),DE(trancode&"_"&get_invoice_set.invoice_set))>
	
	<!---cfquery name="updategsetup" datasource="#dts#">
		update gsetup set 
		#new_trancode#=UPPER('#nexttranno#');
	</cfquery--->
	<!--- <cfquery name="updategsetup" datasource="main">
		update refnoset 
		set lastUsedNo=UPPER('#nexttranno#')
		where userDept = '#dts#'
		and type = '#tran#'
		and counter =  '#get_invoice_set.invoice_set#'
	</cfquery> --->
	<cfquery name="updategsetup" datasource="#dts#">
		update refnoset 
		set lastUsedNo=UPPER('#nexttranno#')
		where type = '#tran#'
		and counter =  '#get_invoice_set.invoice_set#'
	</cfquery>
<cfelse>
	<!---cfquery name="updategsetup" datasource="#dts#">
		update Gsetup set 
		#trancode#=UPPER('#nexttranno#');
	</cfquery--->
	
	<!--- <cfquery name="updategsetup" datasource="main">
		update refnoset 
		set lastUsedNo=UPPER('#nexttranno#')
		where userDept = '#dts#'
		and type = '#tran#'
		and counter =  '1'
	</cfquery> --->
	
	<cfquery name="updategsetup" datasource="#dts#">
		update refnoset 
		set lastUsedNo=UPPER('#nexttranno#')
		where type = '#tran#'
		and counter =  '1'
	</cfquery>
</cfif>