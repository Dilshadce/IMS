<cfoutput>
<cfset packid =URLDecode("#url.packid#")>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/stylesheet/reportprint.css"/>
<title>PACKING LIST FOR #packid#</title>
</head>
<body style="width:1000px; margin:0 auto; text-align:left">

<cfquery name="getSumItem" datasource="#dts#">
SELECT sum(qty_bil) as sumqty,itemno,unit_bil FROM packlistbill as pa left join ictran as ic on pa.billrefno = ic.refno where ic.type = "SO" and pa.packID = "#packid#" group by itemno order by desp
</cfquery>

<cfquery name="getPackDetail" datasource="#dts#">
SELECT * from packlist where packid = "#packid#"
</cfquery>

<cfif getPackDetail.updated_by neq "">
<cfset packedby = getPackDetail.updated_by>
<cfelse>
<cfset packedby = getPackDetail.created_by>
</cfif>
<cfif getPackDetail.Created_on lt getPackDetail.updated_on >
<cfset datepacked = getPackDetail.updated_on>
<cfelse>
<cfset datepacked = getPackDetail.Created_on>
</cfif>
<h1>PACKING LIST FOR #packid#</h1>
<table width="800px" >
<tr>
<th width="70px" rowspan="5">SO NO.</th>
<td width="200px" rowspan="5">
<table>
<cfset tablestruc = 1>
<cfloop list="#getPackDetail.totalbill#" index="i">
<cfset tablecount = tablestruc mod 2>
<cfif tablecount neq 0>
<tr>
</cfif>
<th>#tablestruc#:</th><td>#i#&nbsp;</td>
<cfif tablecount eq 0>
</tr>
</cfif>
<cfset tablestruc = tablestruc + 1>
</cfloop>

</table>
</td>
<th width="100px" align="left">PACK ID</th>
<td width="10px">:</td>
<td width="150px">#packid#</td>
</tr>
<tr>
<th align="left">DATE</th>
<td>:</td>
<td>#dateformat(datepacked,'yyyy-mmm-dd')#</td>
</tr>
<tr>
<th align="left">PACKED BY</th>
<td>:</td>
<td>#packedby#</td>
</tr>
<tr>
<th align="left">DRIVER</th>
<td>:</td>
<td>#getPackDetail.driver#</td>
</tr>
<tr>
<th align="left">DELIVERY ON</th>
<td>:</td>
<td>#dateformat(getPackDetail.delivery_on,'yyyy-mmm-dd')#</td>
</tr>
<tr>
<td colspan="5">
<br/>
<table width="100%">
<tr>
<th width="50px" align="left">NO.</th>
<th width="100px" align="left">ITEM NO.</th>
<th width="400px" align="left">DESP</th>
<th width="100px" align="left">UNIT</th>
<th width="150px" align="left">QUANTITY</th>
</tr>
<cfset itemrow = 1 >
<cfloop query="getSumItem">
<tr>
<td>#itemrow#</td>
<td>#getSumItem.itemno#</td>
<cfquery name="getItemDesp" datasource="#dts#">
SELECT DESP FROM icitem WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getSumItem.itemno#"
></cfquery>
<td>#getItemDesp.desp#</td>
<td>#getSumItem.unit_bil#</td>
<td>#getSumItem.sumqty#</td>
</tr>
<cfset itemrow = itemrow + 1>
</cfloop>
</table>

</td>
</tr>
<cfquery name="gettotal" dbtype="query">
SELECT sum(sumqty) as sumqtyunit,unit_bil from getSumItem group by unit_bil 
</cfquery>
<tr>
<td colspan="5">
<table border="1">
<tr>
<cfloop query="getTotal">
<td width="100">#getTotal.unit_bil#</td>
</cfloop>
</tr>
<tr>
<cfloop query="getTotal">
<td>#getTotal.sumqtyunit#</td>
</cfloop>
</tr>
</table>
</td>
</tr>
</table>

</body>
</html>
</cfoutput>