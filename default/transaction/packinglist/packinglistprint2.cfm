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

<cfquery name="getPackId" datasource="#dts#">
SELECT reftype from packlist where packid = "#packid#"
</cfquery>

<cfquery name="getSumItem" datasource="#dts#">
SELECT type,refno,custno,frem7,frem8,rem3,comm0,comm1,comm2,comm3,rem14,rem12,comm4 FROM packlistbill as pa left join artran as ic on pa.billrefno = ic.refno where ic.type = "#getPackId.reftype#" and pa.packID = "#packid#" 
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
<th>REF TYPE</th>
<td>#getPackDetail.reftype#</td>
</tr>
<tr>
<th width="70px" rowspan="5">REF NO.</th>
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
<td>#dateformat(getPackDetail.delivery_on,'yyyy-mmm-dd')#<cfif getPackDetail.trip neq ''>  ( #getPackDetail.trip# )</cfif></td>
</tr>
<tr>
<td colspan="5">
<br/>
</td>
</tr>
<tr>
<td colspan="5">
<table border="1">
<tr>
<tr>
<th width="50px">Bill Type</th>
<th width="100px">Bill No</th>
<th width="350px">Customer Detail</th>
<th width="250px">Remarks</th>
<th width="250px">Speedrometer</th>
<th width="150px">Time In</th>
<th width="150px">Time Out</th>
<th width="150px">Area</th>
</tr>
<cfloop query="getSumItem">
<cfquery name="getarea" datasource="#dts#">
SELECT area from #target_arcust# where custno = "#getSumItem.custno#"
</cfquery>
<tr>
<td>
#getSumItem.type#
</td>
<td>
#getSumItem.refno#
</td>
<td>
#getSumItem.custno#-#getSumItem.frem7#&nbsp;#getSumItem.frem8#<br />
#getSumItem.comm0#&nbsp;#getSumItem.comm1#<br />
#getSumItem.comm2#&nbsp;#getSumItem.comm3#<br />
#getSumItem.rem14#<br/>
ATTN: #getSumItem.rem3#<br />
PHONE: #getSumItem.rem12#<br/>
FAX: #getSumItem.comm4#<br/>
</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td>#getarea.area#</td>
</tr>
</cfloop>
</table>
</td>
</tr>
</table>

</body>
</html>
</cfoutput>