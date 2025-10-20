<cfsetting showdebugoutput="no">
<cfsilent>
<cfif url.refno eq "">
<script type="text/javascript">
alert('No Bill Selected');
</script>
<cfabort />
</cfif>
<cfset refno = URLDECODE(url.refno)>
<cfset refnolen = len(refno)>
<cfset refno = right(refno,val(refnolen)-1)>
<cftry>
		<cfquery name="createtbl" datasource="#dts#">
        CREATE TABLE currartran like artran
        </cfquery>
        <cfquery name="createtbl" datasource="#dts#">
        CREATE TABLE currictran like ictran
        </cfquery>
<cfcatch>

</cfcatch>
</cftry>

<cfquery name="showcolumns" datasource="#dts#">
show columns from currartran
</cfquery>

<cfset columnsname = "">
<cfloop query="showcolumns">
<cfif url.groupid neq "">
<cfif showcolumns.field eq "eInvoice_Submited">
<cfset showcolumns.field = "#url.groupid# as eInvoice_Submited">
</cfif>
</cfif>
<cfset columnsname = columnsname&showcolumns.field>
<cfif showcolumns.recordcount neq showcolumns.currentrow>
<cfset columnsname = columnsname&",">
</cfif>

</cfloop>

<cftry>
<cfquery name="getartran" datasource="#dts#">
INSERT INTO currartran SELECT #columnsname# FROM artran where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" > and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#" >
</cfquery>

<cfquery name="showcolumns1" datasource="#dts#">
show columns from currictran
</cfquery>

<cfset columnsname1 = "">
<cfloop query="showcolumns1">
<cfset columnsname1 = columnsname1&showcolumns1.field>
<cfif showcolumns1.recordcount neq showcolumns1.currentrow>
<cfset columnsname1 = columnsname1&",">
</cfif>
</cfloop>

<cfquery name="getartran" datasource="#dts#">
INSERT INTO currictran SELECT #columnsname1# FROM ictran where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" > and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#" >
</cfquery>
<cfcatch></cfcatch>
</cftry>

</cfsilent>