<cfif form.newitemno2 neq "">
	<cfquery name="checkexist" datasource="#dts#">
		select itemno from icitem
		where itemno = '#form.newitemno2#'
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
	
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
	</cfif>	
<!--- <cfelseif form.newitemno neq "">
	<cfset newitemno = form.newitemno>
	<cfset olditemno = form.olditemno>
	
	<cfquery name="getbillmat1" datasource="#dts#">
		select * from billmat
		where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
	</cfquery>
	
	<cfloop query="getbillmat1">
		<cfquery name="check1" datasource="#dts#">
			select * from billmat
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			and Bomno = '#getbillmat1.Bomno#'
			and BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat1.BMITEMNO#">
		</cfquery>
		
		<cfif check1.recordcount neq 0>
			<cfquery name="delete" datasource="#dts#">
				delete from billmat
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat1.itemno#">
				and Bomno = '#getbillmat1.Bomno#'
				and BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat1.BMITEMNO#">
			</cfquery>
		<cfelse>
			<cfquery name="update" datasource="#dts#">
				update billmat
				set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
				and Bomno = '#getbillmat1.Bomno#'
				and BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat1.BMITEMNO#">
			</cfquery>
		</cfif>
	</cfloop>
	
	<cfquery name="getbillmat2" datasource="#dts#">
		select * from billmat
		where BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
	</cfquery>
	
	<cfloop query="getbillmat2">
		<cfquery name="check2" datasource="#dts#">
			select * from billmat
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat2.itemno#">
			and Bomno = '#getbillmat2.Bomno#'
			and BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
		</cfquery>
		
		<cfif check2.recordcount neq 0>
			<cfquery name="delete" datasource="#dts#">
				delete from billmat
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat2.itemno#">
				and Bomno = '#getbillmat2.Bomno#'
				and BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat2.BMITEMNO#">
			</cfquery>
		<cfelse>
			<cfquery name="update" datasource="#dts#">
				update billmat
				set BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbillmat2.itemno#">
				and Bomno = '#getbillmat2.Bomno#'
				and BMITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
			</cfquery>
		</cfif>
	</cfloop>
	
		<cfquery name="update" datasource="#dts#">
			update commentemp
			set ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#newitemno#">
			where ITEMNO = <cfqueryparam cfsqltype="cf_sql_char" value="#olditemno#">
		</cfquery> --->
</cfif>

<script language="javascript" type="text/javascript">
	alert("Item No. Changed !");
	window.close();
</script>