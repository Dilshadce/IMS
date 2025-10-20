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
			<cfset all_refno3 = listappend(all_refno3,code&getbill.refno,",")>
		</cfloop>
		
		<!--- <cfquery name="updatetrxbill" datasource="#dts#">
			update artran set 
			posted='' 
			where type='#getbill.type#' and refno in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno1#">)
		</cfquery> --->


		<!--- UNPOST THE TRANSACTIONS FROM AMS --->
		<cfif Hlinkams eq "Y" and isdefined('url.ubs') eq false>
			<cfinvoke component="cfc.post_to_ams2" method="unpost_glpost91" returnvariable="all_refno4">
				<cfinvokeargument name="dts" value="#dts#">
                 <cfif listfindnocase(comlist,hcomid) neq 0 >
                 <cfinvokeargument name="dts1" value="ssa0804_a">
                 <cfelse>
				<cfinvokeargument name="dts1" value="#replace(lcase(dts),'_i','_a','all')#">
                </cfif>
				<cfinvokeargument name="type" value="#getbill.type#">
				<cfinvokeargument name="all_refno3" value="#all_refno3#">
			</cfinvoke>
			
			<cfinvoke component="cfc.post_to_ams2" method="unpost_iras">
				<cfinvokeargument name="dts" value="#dts#"><cfif listfindnocase(comlist,hcomid) neq 0 >
                 <cfinvokeargument name="dts1" value="ssa0804_a">
                 <cfelse>
				<cfinvokeargument name="dts1" value="#replace(dts,'_i','_a','all')#">
                </cfif>
				<cfinvokeargument name="type" value="#getbill.type#">
				<cfinvokeargument name="all_refno3" value="#all_refno3#">
				<cfinvokeargument name="all_refno4" value="#all_refno4#">
			</cfinvoke>
		</cfif>
		
		<cfquery name="delete_glpost9_reference" datasource="#dts#">
			delete from glpost9<cfif isdefined('url.ubs')>ubs</cfif> 
			where acc_code='#getbill.type#' 
			and reference in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno3#">)
		</cfquery>
		
		<cfquery name="delete_glpost91_reference" datasource="#dts#">
			delete from glpost91<cfif isdefined('url.ubs')>ubs</cfif> 
			where acc_code='#getbill.type#' 
			and reference in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno3#">)
		</cfquery>
		
		<cfquery name="updatetrxbill" datasource="#dts#">
			update artran set 
			posted<cfif isdefined('url.ubs')>ubs</cfif>='' 
			where type='#getbill.type#' and refno in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno1#">)
			<cfif Hlinkams eq "Y" and isdefined('url.ubs') eq false>and refno not in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#all_refno4#">)</cfif>
		</cfquery>
		<!---<h3><div align="center">You Have Unposted The Bill(s) Successfully !</div></h3>--->
		<script language="javascript" type="text/javascript">
			showMessage();
			
			function showMessage(){
				<cfoutput>
				<cfif all_refno4 eq "">
				document.getElementById('message').innerHTML = "You Have Unposted The Bill(s) Successfully !";
				<cfelse>
				document.getElementById('message').innerHTML = "Bill No #all_refno4# Has Been Knock Off!";
				</cfif>
				</cfoutput>
			}
		</script>
	</cfif>
</cfif>