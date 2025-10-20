<cfparam name="status" default="">
<cfif form.reftype eq "PACK">
<cfquery name="checkoldrefno" datasource="#dts#">
	select packid from packlist
	where packid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
</cfquery>
<cfif checkoldrefno.recordcount eq 0>
	This Reference No. Not Exist! <cfabort>
</cfif>
<cfif form.newrefno neq "">

<cfquery name="checkoldrefno1" datasource="#dts#">
	select packid from packlist
	where packid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newrefno#">
</cfquery>
<cfif checkoldrefno1.recordcount neq 0>
	This Reference No Existed! <cfabort>
</cfif>
<cfquery name="updatetable1" datasource="#dts#">
UPDATE packlist SET packid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newrefno#">
WHERE PACKID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
</cfquery>

<cfquery name="updatetable2" datasource="#dts#">
UPDATE packlistbill SET packid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newrefno#">
WHERE PACKID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
</cfquery>
<cfset status = "CHANGE REFNO IS SUCCESS">
<cfelse>
<cfset status = "NEW REFNO IS REQUIRED">
</cfif>

<cfelse>
<cfquery name="checkoldrefno" datasource="#dts#">
	select refno from artran
	where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
	and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
</cfquery>
<cfif checkoldrefno.recordcount eq 0>
	This Reference No. Not Exist! <cfabort>
</cfif>
<cfif form.newrefno neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select refno from artran
		where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newrefno#">
		and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Reference No., #form.newrefno# already exist!">
	<cfelse>
		<cfset newcode = form.newrefno>
		<cfset oldcode = form.oldrefno>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set refno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update artran
			set dono = replace(dono,"#oldcode#","#newcode#")
			where dono like <cfqueryparam cfsqltype="cf_sql_char" value="%#oldcode#%">
            <cfif form.reftype eq "DO">
            and type = "INV"
			<cfelse>
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
            </cfif>
		</cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update ictran
			set dono = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where dono = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
            <cfif form.reftype eq "DO">
            and type = "INV"
			<cfelse>
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
            </cfif>
		</cfquery>
		
		<cftry>
			<cfquery name="update" datasource="#dts#">
				update artran_remark
				set refno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
				where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
			</cfquery>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
		
		<cfquery name="update" datasource="#dts#">
			update artranat
			set refno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iclink
			set refno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iclink
			set frrefno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where frrefno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and frtype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set refno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			<cfif form.reftype eq "TR">
				and type in ('TRIN','TROU')
			<cfelse>
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
			</cfif>
		</cfquery>
        
        <cfif form.reftype eq "INV">
        <cfquery name="update" datasource="#dts#">
			Update ictran SET toinv  = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
            WHERE toinv = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
            and type = "DO"
            </cfquery>
            
		</cfif>
        	<cfif form.reftype eq "INV">
            <cfquery name="update" datasource="#dts#">
			Update artran SET toinv  = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
            WHERE toinv = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#"> 
            and type = "DO"
            </cfquery>
		</cfif>
		<cfquery name="update" datasource="#dts#">
			update igrade
			set refno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			<cfif form.reftype eq "TR">
				and type in ('TRIN','TROU')
			<cfelse>
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
			</cfif>
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iserial
			set refno = <cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
			
		</cfquery>
		
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changerefno',<cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newcode#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Reference No., #oldcode# Has Been Changed to #newcode# !">
	</cfif>
<cfelse>
	<cfset status="The New Reference No. cannot be empty!">
</cfif>
</cfif>
<cfoutput>
	<form name="done" action="changerefno.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>