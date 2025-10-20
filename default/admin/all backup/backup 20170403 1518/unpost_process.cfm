<cfif unpost eq "unpost">
	<cfquery name="getbill" dbtype="query">
		select distinct refno as refno,type from gettran
	</cfquery>
	
	<cfif getbill.recordcount eq 0>
		<h3><div align="center">No Bill(s) Unposted !</div></h3>
		<cfabort>
	<cfelse>
		<cfset all_refno1 = "">
		<cfset all_refno2 = "">
		<cfset all_refno3 = "">
		
		<cfloop query="getbill">
			<cfset all_refno1 = listappend(all_refno1,getbill.refno,",")>
			<cfset all_refno2 = listappend(all_refno2,"'"&code&getbill.refno&"'",",")>
			<cfset all_refno3 = listappend(all_refno1,code&getbill.refno,",")>
		</cfloop>
		
		<cfquery name="updatetrxbill" datasource="#dts#">
			update artran set 
			posted='' 
			where type='#getbill.type#' and refno in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno1#">)
		</cfquery>

		<!--- UNPOST THE TRANSACTIONS FROM AMS --->
		<cfif Hlinkams eq "Y">
			<cfinvoke component="cfc.post_to_ams" method="unpost_glpost91">
				<cfinvokeargument name="dts" value="#dts#">
				<cfinvokeargument name="dts1" value="#replace(dts,'_i','_a','all')#">
				<cfinvokeargument name="type" value="#getbill.type#">
				<cfinvokeargument name="all_refno2" value="#all_refno2#">
			</cfinvoke>
		</cfif>
		
		<cfquery name="delete_glpost9_reference" datasource="#dts#">
			delete from glpost9 
			where acc_code='#getbill.type#' 
			and reference in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno3#">);
		</cfquery>
		
		<cfquery name="delete_glpost91_reference" datasource="#dts#">
			delete from glpost91 
			where acc_code='#getbill.type#' 
			and reference in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno3#">);
		</cfquery>
		<h3><div align="center">You Have Unposted The Bill(s) Successfully !</div></h3>
	</cfif>
</cfif>