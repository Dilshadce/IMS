<cfparam name="status" default="">
<cfif form.newattnno2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select attentionno from attention
		where attentionno = '#form.newattnno2#'
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Attention No, #form.newattnno2# already exist!">
	<cfelse>
		<cfset newattnno = form.newattnno2>
		<cfset oldattnno = form.oldattnno>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set rem2 = <cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">
			where rem2 = <cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set rem3 = <cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">
			where rem3 = <cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update arcust
			set attn = <cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">
			where attn = <cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update arcust
			set dattn = <cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">
			where dattn = <cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">
		</cfquery>
        <cfquery name="update" datasource="#dts#">
			update apvend
			set attn = <cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">
			where attn = <cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">
		</cfquery>
	<cfquery name="update" datasource="#dts#">
			update apvend
			set dattn = <cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">
			where dattn = <cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">
		</cfquery>	
        <cfquery name="update" datasource="#dts#">
			update attention
			set attentionno = <cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">
			where attentionno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">
		</cfquery>
	
    
    
    
    <!---	<cftry>
			<cfquery name="checkexist3" datasource="#dts#">
				select itemno from fifoopq_last_year
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
			</cfquery>
		
			<cfif checkexist3.recordcount neq 0>
				<cfquery name="update" datasource="#dts#">
					update fifoopq_last_year
					set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
					where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>--->
				
		<!---<cfquery name="update" datasource="#dts#">
			update icl3p
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update icl3p2
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iclink
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update igrade
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iserial
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update itemgrd
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update lobthob
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update locqdbf
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update logrdob
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update monthcost
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update monthcost_last_year
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update obbatch
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update obbatch_last_year
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update temptrx
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cftry>
			<cfquery name="checkexist2" datasource="#dts#">
				select itemno from icitem_last_year
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
			</cfquery>
		
			<cfif checkexist2.recordcount neq 0>
				<cfquery name="update" datasource="#dts#">
					update icitem_last_year
					set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
					where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#"> 
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
		
		<cfquery name="update" datasource="#dts#">
			update icitem
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newitemdesp#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#"> 
		</cfquery>--->
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeattnno',<cfqueryparam cfsqltype="cf_sql_char" value="#oldattnno#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newattnno#">,'#huserid#',now())
        </cfquery>
        
		<cfset status="The Attention No, #oldattnno# Has Been Changed to #newattnno# !">
	</cfif>
<cfelse>
	<cfset status="The New Attention No cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeattentionno.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>