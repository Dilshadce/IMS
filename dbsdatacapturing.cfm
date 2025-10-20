<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql" and (right(schema_name,2) = "_a" or right(schema_name,2) = "_i") order by schema_name
</cfquery>
<cfoutput>
<table>
<tr>
<th>Customer Code</th>
<th>Total Customer</th>
<th>Total Supplier</th>
</tr>
<cfloop query="backupdb">
<cfset dts = backupdb.schema_name>
<cftry>
<tr>
<td>#backupdb.schema_name#</td>
<cfquery name="getcustomer" datasource="#dts#">
SELECT count(custno) as cno FROM arcust
</cfquery>
<td>#getcustomer.cno#</td>
<cfquery name="getapvend" datasource="#dts#">
SELECT count(custno) as cno FROM apvend
</cfquery>
<td>#getapvend.cno#</td>
</tr>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfloop>
</table>


<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql" and right(schema_name,2) = "_a" order by schema_name
</cfquery>


<table>
<tr>
<th>Customer Code</th>
<th>Bank Account Code</th>
<th>Total Debit Amount</th>
<th>Total Credit Amount</th>
<th>Total Transaction</th>
</tr>
<cfloop query="backupdb">
<cfset dts = backupdb.schema_name>
<cftry>
<cfquery name="getbank" datasource="#dts#">
select desp,accno from gldata where sa like "%bk%" and desp like "%DBS%"
</cfquery>
<cfif getbank.recordcount neq 0>
<tr>
<td>#backupdb.schema_name#</td>
<td>#getbank.accno#</td>
<cfquery name="countin" datasource="#dts#">
SELECT sum(debitamt) as debitamt,sum(creditamt) as creditamt,count(entry) as samt FROM glpost WHERE accno = "#getbank.accno#"
</cfquery>
<td>#countin.debitamt#</td>
<td>#countin.creditamt#</td>
<td>#countin.samt#</td>
</tr>

</cfif>

<cfcatch type="any">
</cfcatch>
</cftry>
</cfloop>
</table>

<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql" and right(schema_name,2) = "_i" order by schema_name
</cfquery>


<table>
<tr>
<th>Customer Code</th>
<th>Total Sales</th>
<th>Total Purchase</th>
<th>Total Sales Figures</th>
<th>Total Purchase Figures</th>
</tr>

<cfloop query="backupdb">
<cfset dts = backupdb.schema_name>
<cftry>
<cfquery name="getrc" datasource="#dts#">
select sum(grand) as grand, count(refno) as cref from artran WHERE type = "RC"
</cfquery>
<cfquery name="getinv" datasource="#dts#">
select sum(grand) as grand, count(refno) as cref from artran WHERE type = "INV"
</cfquery>
<tr>
<td>#backupdb.schema_name#</td>
<td>#getinv.cref#</td>
<td>#getrc.cref#</td>
<td>#getinv.grand#</td>
<td>#getrc.grand#</td>
</tr>

<cfcatch type="any">
</cfcatch>
</cftry>
</cfloop>
</table>

</cfoutput>