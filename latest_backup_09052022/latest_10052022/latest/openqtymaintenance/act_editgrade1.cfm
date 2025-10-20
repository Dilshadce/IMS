<cfquery name="checkexist1" datasource="#dts#">
	select * from logrdob
	where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
	and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
</cfquery>

<cfquery name="checkexist2" datasource="#dts#">
	select * from itemgrd
	where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
</cfquery>

<cfif checkexist1.recordcount eq 0>
	<cfquery name="insert" datasource="#dts#">
		insert into logrdob 
		(itemno,location)
		values
		(<cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">,
		<cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">)
	</cfquery>
</cfif>

<cfif checkexist2.recordcount eq 0>
	<cfquery name="insert" datasource="#dts#">
		insert into itemgrd 
		(itemno)
		values
		(<cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">)
	</cfquery>
</cfif>

<cfset columnlist = form.varlist>
<cfset colvaluelist = form.qtybflist>
<cfset myArray = ListToArray(columnlist,",")>
<cfset myArray2 = ListToArray(colvaluelist,",")>

<!--- <cfloop from="1" to="#form.totalrecord-1#" index="i">
<cfoutput>#myArray[i]#::#myArray2[i]#</cfoutput><br>
</cfloop> --->
<cfquery name="updatelogrdob" datasource="#dts#">
	update logrdob
	set
	<cfloop from="1" to="#form.totalrecord#" index="i">
		<cfif i neq form.totalrecord>
			#myArray[i]# = #myArray2[i]#,
		<cfelse>
			#myArray[i]# = #myArray2[i]#
		</cfif>
	</cfloop>
	where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
	and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
</cfquery>

<cfquery name="getsumqty" datasource="#dts#">
	select 
	<cfloop from="#form.firstcount#" to="#form.maxcounter#" index="i">
		<cfif i neq form.maxcounter>
			sum(grd#i#) as sumgrd#i#,
		<cfelse>
			sum(grd#i#) as sumgrd#i#
		</cfif>
	</cfloop>
	from logrdob
	where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
</cfquery>

<cfquery name="updatelogrdob" datasource="#dts#">
	update itemgrd
	set
	<cfloop from="#form.firstcount#" to="#form.maxcounter#" index="i">
		<cfif i neq form.maxcounter>
			grd#i# = #Evaluate("getsumqty.sumgrd#i#")#,
		<cfelse>
			grd#i# = #Evaluate("getsumqty.sumgrd#i#")#
		</cfif>
	</cfloop>
	where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
</cfquery>


