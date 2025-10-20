<cfparam name="status" default="">
<cfif form.newcustno neq "">
	<cfif form.ctype eq "Customer">
		<cfset ptype=target_arcust>
	<cfelse>
		<cfset ptype=target_apvend>
	</cfif>
	<cfquery name="checkexist" datasource="#dts#">
		select custno from #ptype#
		where custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newcustno#">
	</cfquery>
	
	<!--- <cfif checkexist.recordcount neq 0>
		<cfset status="The #form.ctype# No., #form.newcustno# already exist!">
	<cfelse> --->
		<cfset newcode = form.newcustno>
		<cfset oldcode = form.oldcustno>
		
		<cfif Hlinkams eq "Y">
			<cfset dts1=replacenocase(dts,"_i","_a","all")>
			<cfquery datasource="#dts1#" name="updategldata">
				update gldata 
				set accno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where accno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updatearcust">
				update arcust 
				set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updateapvend">
				update apvend 
				set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updateglpost">
				update glpost 
				set accno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where accno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updateglpostat">
				update glpostat 
				set accno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where accno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updatearpost">
				update arpost 
				set accno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where accno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updateappost">
				update appost 
				set accno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where accno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updatearpay">
				update arpay 
				set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery datasource="#dts1#" name="updateappay">
				update appay 
				set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
		</cfif>
		
		<cfquery name="update" datasource="#dts#">
			update arcust
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update apvend
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update artranat
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update driver
			set Customerno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where Customerno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update glpost91 
			set accno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where accno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update glpost9
			set accno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where accno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icl3p
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icl3p2
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iserial
			set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
		</cfquery>
		
		<cfif form.ctype eq "Supplier">
			<cfquery name="update" datasource="#dts#">
				update icitem_last_year
				set supp = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where supp = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
			</cfquery>
				
			<cfquery name="update" datasource="#dts#">
				update icitem
				set supp = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where supp = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
			</cfquery>
			
			<cfquery name="update" datasource="#dts#">
				update icmitem
				set supp = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where supp = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
		</cfif>
		
        <cfif lcase(hcomid) eq "accord_i">
			<cfquery name="update" datasource="#dts#">
				update vehicles
				set custcode = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where custcode = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
            </cfif>
		<cfif lcase(hcomid) eq "net_i">
			<cfquery name="update" datasource="#dts#">
				update contract_service
				set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
			
			<cfquery name="update" datasource="#dts#">
				update service_tran
				set custno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where custno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			</cfquery>
		</cfif>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changecustsupp',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The #form.ctype# No., #oldcode# Has Been Changed to #newcode# !">
	<!--- </cfif> --->
<cfelse>
	<cfset status="The New #form.ctype# No. cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changecustsupp.cfm?custtype=#form.ctype#&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>