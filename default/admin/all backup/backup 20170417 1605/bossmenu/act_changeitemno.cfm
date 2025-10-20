<cfparam name="status" default="">
<cfif form.newitemno2 CONTAINS '"' or form.newitemno2 CONTAINS "'" or form.newitemno2 CONTAINS "?" or form.newitemno2 CONTAINS "@" or form.newitemno2 CONTAINS "&" or form.newitemno2 CONTAINS "," or form.newitemno2 CONTAINS "\" or form.newitemno2 CONTAINS "+" or form.newitemno2 CONTAINS "##">

<h2>Do Not use Symbol ' " # @ & ? , \ + in Item no</h2>
<cfabort>

</cfif>
<cfif form.newitemno2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select itemno from icitem
		where itemno = '#form.newitemno2#'
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		<cfset status="The Item No, #form.newitemno2# already exist!">
	<cfelse>
		<cfset newitemno = form.newitemno2>
		<cfset olditemno = form.olditemno>
		
		<cfquery name="update" datasource="#dts#">
			update billmat
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update billmat
			set BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update commentemp
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update fifoopq
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
		
		<cftry>
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
		</cftry>
				
		<cfquery name="update" datasource="#dts#">
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
		</cfquery>
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('changeitemno',<cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">,'#huserid#',now())
        </cfquery>
        
        <cfquery name="getlocation" datasource="#dts#">
        SELECT location FROM iclocation
        </cfquery>
        <cfloop query="getlocation">
        <cfquery name="replacecommand" datasource="#dts#">
        INSERT INTO posreplaceitem (olditemno,newitemno,location)
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#getlocation.location#">
        )
        </cfquery>
        </cfloop>
        
        
        
		<cfset status="The Item No, #olditemno# Has Been Changed to #newitemno# !">
	</cfif>
<cfelse>
	<cfset status="The New Item No cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changeitemno.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>