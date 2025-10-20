<cfoutput>
<cfset qty1='ffq'&'#fifono#'>
<cfset price1='ffc'&'#fifono#'>
<cfset date1='ffd'&'#fifono#'>
<cftry>
<cfset newdate = createdate('#form.year1#','#form.month1#','#form.day1#') >
<cfcatch>
<h3>Error in Date kindly check the days in that month.</h3>
<cfabort>
</cfcatch>
</cftry>


<cfquery name="checkexist" datasource="#dts#">
select * from fifoopq  where itemno='#form.itemno1#'
</cfquery>

<cfif checkexist.recordcount neq 0>
<cfquery name="updatefifo" datasource="#dts#">
  update fifoopq set #qty1# = '#form.newqty#',#price1# = '#form.newprice#',#date1#=<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate,'yyyy-mm-dd')#"> where itemno='#form.itemno1#'
</cfquery>
<cfelse>
<cfquery name="updatefifo" datasource="#dts#">
  insert into fifoopq (itemno,#qty1#,#price1#,#date1#) values ('#form.itemno1#','#form.newqty#','#form.newprice#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate,'yyyy-mm-dd')#">)
</cfquery>
</cfif>
</cfoutput>

<cfoutput>
	<form name="done" action="fifoopq1.cfm?CFGRIDKEY=#URLEncodedFormat(form.itemno1)#" method="post">
	</form>
</cfoutput>

<script>
	done.submit();
</script>