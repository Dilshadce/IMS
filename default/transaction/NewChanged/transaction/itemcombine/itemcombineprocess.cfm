<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bill Same Item Combine</title>
</head>

<body>
<cftry>
<cfset billnolen = len(form.billno) - 1>
<cfset form.billno = right(form.billno,billnolen)>
<cfquery name="checksameitem" datasource="#dts#">
SELECT refno FROM ictran WHERE 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billno#"> and
type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tran#">
</cfquery>

<cfquery name="checksameitem2" datasource="#dts#">
SELECT refno FROM ictran WHERE 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billno#"> and
type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tran#">
GROUP BY itemno
</cfquery>

<cfif checksameitem2.recordcount neq checksameitem.recordcount>
<cfquery name="getduplicate" datasource="#dts#">
select * from (select 
count(itemno) as countitem, itemno,
refno,price,sum(qty) as sqty,
sum(qty_bil) as sqty_bil, 
sum(amt1) as samt1, 
sum(amt1_bil) as samt1_bil, 
sum(disamt_bil) as sdisamt_bil, 
sum(disamt) as sdisamt, 
sum(amt_bil) as samt_bil,
sum(amt) as samt,
sum(taxamt_bil) as staxamt_bil,
sum(taxamt) as staxamt,
currrate,
itemcount from ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tran#"> group by itemno,price,currrate) as a where a.countitem > 1
</cfquery>

<cfif getduplicate.recordcount neq 0>
<cfloop query="getduplicate">
<cfquery name="updaterow" datasource="#dts#">
UPDATE ictran SET
qty = "#getduplicate.sqty#",
qty_bil = "#getduplicate.sqty_bil#", 
amt1 = "#getduplicate.samt1#", 
amt1_bil = "#getduplicate.samt1_bil#", 
disamt_bil = "#getduplicate.sdisamt_bil#", 
disamt = "#getduplicate.sdisamt#", 
amt_bil = "#getduplicate.samt_bil#",
amt = "#getduplicate.samt#",
taxamt_bil = "#getduplicate.staxamt_bil#",
taxamt = "#getduplicate.staxamt#"
WHERE 
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getduplicate.itemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billno#"> 
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tran#">
and itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getduplicate.itemcount#">
</cfquery>

<cfquery name="deleteduplicate" datasource="#dts#">
Delete from ictran where 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billno#"> and 
type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tran#"> and
price = <cfqueryparam cfsqltype="cf_sql_float" value="#getduplicate.price#"> and
currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getduplicate.currrate#"> and
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getduplicate.itemno#"> and
itemcount <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#getduplicate.itemcount#">
</cfquery>
</cfloop>
</cfif>

</cfif>
<table align="center">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td align="center"><h3>Combine Item Success!</h3><br />Click <a href="/default/transaction/itemcombine/index.cfm" >Here</a> To Combine Item For Another Bill</td>
</tr>
</table>
<cfcatch type="any">
<table align="center">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td align="center"><h3>Combine Item Fail! Reason: <cfoutput>#cfcatch.Message#</cfoutput></h3><br />Please Contact System Administrator</td>
</tr>
</table>
</cfcatch>

</cftry>

</body>
</html>