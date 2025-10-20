<cfparam name="status" default="">
<cfif form.newitemno2 CONTAINS '"' or form.newitemno2 CONTAINS "'" or form.newitemno2 CONTAINS "?" or form.newitemno2 CONTAINS "@" or form.newitemno2 CONTAINS "&" or form.newitemno2 CONTAINS "," or form.newitemno2 CONTAINS "\" or form.newitemno2 CONTAINS "+">

<h2>Do Not use Symbol ' " # @ & ? , \ + in Item no</h2>
<cfabort>

</cfif>
<cfif form.newitemno2 neq "">
	
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
		<cftry>
		<cfquery name="update" datasource="#dts#">
			update fifoopq
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
        <cfcatch type="any">
        
        
        
        <cfquery name="deleteitem" datasource="#dts#">
        DELETE FROM fifoopq WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#"> 
        </cfquery>
        </cfcatch>
        </cftry>
		
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
        <cfquery name="deleteitem" datasource="#dts#">
        DELETE FROM fifoopq_last_year WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#"> 
        </cfquery>
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
		<cftry>
		<cfquery name="update" datasource="#dts#">
			update locqdbf
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
        <cfcatch type="any">
        
        <cfquery name="selectall" datasource="#dts#">
        select * from locqdbf where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
        </cfquery>
        
        <cfloop query="selectall">
        
        <cfquery name="updateall" datasource="#dts#">
        update locqdbf set locqfield=locqfield+#selectall.locqfield# where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
        and location=<cfqueryparam cfsqltype="cf_sql_char" value="#selectall.location#">
        </cfquery>
        
        </cfloop>
        
          <cfquery name="deleteitem" datasource="#dts#">
        DELETE FROM locqdbf WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#"> 
        </cfquery>
        </cfcatch>
        </cftry>
		
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
        
        <cfif lcase(hcomid) eq 'tcds_i'>
        
        <cfquery name="checkorderform" datasource="#dts#">
        	select * from orderformtemp where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
        </cfquery>
        <cfif checkorderform.recordcount eq 0>
        <cfquery name="update" datasource="#dts#">
			update orderformtemp
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery>
        <cfelse>
        <cfquery name="checkorderform" datasource="#dts#">
        	select * from orderformtemp where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
        </cfquery>
        
        <cfquery name="update" datasource="#dts#">
			update orderformtemp
			set qty_gwc=qty_gwc+#checkorderform.qty_gwc#,
            qty_pp=qty_pp+#checkorderform.qty_pp#,
            qty_rf=qty_rf+#checkorderform.qty_rf#,
            qty_mbs=qty_mbs+#checkorderform.qty_mbs#,
            qty_stock=qty_stock+#checkorderform.qty_stock#,
            qty_warehouse=qty_warehouse+#checkorderform.qty_warehouse#
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
		</cfquery>
        <cfquery name="checkorderform" datasource="#dts#">
        	delete from orderformtemp where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
        </cfquery>
        
        </cfif>
        </cfif>
		
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
         <cfquery name="deleteitem" datasource="#dts#">
        DELETE FROM icitem_last_year WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
        </cfquery>
		</cfcatch>
		</cftry>
		
        
        <cfquery name="selectall" datasource="#dts#">
        select * from icitem where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
        </cfquery>
        
        <cfloop query="selectall">
        
        <cfquery name="updateall" datasource="#dts#">
        update icitem set qtybf=qtybf+#selectall.qtybf# where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
        </cfquery>
        
        </cfloop>
        
        <cfquery name="deleteitem" datasource="#dts#">
        DELETE FROM icitem WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#"> 
        </cfquery>
<!--- 		<cfquery name="update" datasource="#dts#">
			update icitem
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">,
			DESP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newitemdesp#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#"> 
		</cfquery> --->
        
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,beforeedit,afteredit,edited_by,edited_on) values ('replaceitemno',<cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">,<cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">,'#huserid#',now())
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

<cfelse>
	<cfset status="The New Item No cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="replaceitemno.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>