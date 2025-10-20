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

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getPackId" datasource="#dts#">
SELECT reftype from packlist where packid = "#packid#"
</cfquery>

<cfquery name="getSumItem" datasource="#dts#">
SELECT type,refno,custno,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem3,comm0,comm1,comm2,comm3,rem14,rem12,comm4,rem1,custno FROM packlistbill as pa left join artran as ic on pa.billrefno = ic.refno where ic.type = "#getPackId.reftype#" and pa.packID = "#packid#" 
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
<table width="100%" >
<tr><th align="center" colspan="100%">#getgsetup.compro#</td></tr>
<tr><th align="center" colspan="100%">#getgsetup.compro2#</td></tr>
<tr><th align="center" colspan="100%">#getgsetup.compro3#</td></tr>
<tr><th align="center" colspan="100%">#getgsetup.compro4#</td></tr>
<tr><th align="center" colspan="100%"><hr /></td></tr>
<tr>
<th align="left">Packing List</th>
<td>:</td>
<td>#packid#</td>
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
<th width="50px"><cfif lcase(hcomid) eq "accord_i">Inv No<cfelse>Bill No</cfif></th>
<th width="100px">A/C No</th>
<th width="350px">Address Code</th>
<th width="250px">Product No</th>
<th width="400px">Product Name</th>
<th width="150px">Qty</th>
</tr>
<cfloop query="getSumItem">
<cfquery name="getitem" datasource="#dts#">
select itemno,desp,qty,unit from ictran where refno='#getsumitem.refno#'
</cfquery>
<tr>
<td>
#getSumItem.refno#
</td>
<td>
#getSumItem.custno#
</td>
<td>#getSumItem.frem0# #getSumItem.frem1#<br />
#getSumItem.frem2#<br />
#getSumItem.frem3#<br />
#getSumItem.frem4#<br />
#getSumItem.frem5#
</td>
<td><cfloop query="getitem">
#itemno#<br />
</cfloop></td>
<td><cfloop query="getitem">
#desp#<br />
</cfloop></td>
<td><cfloop query="getitem">
#qty# #unit#<br />
</cfloop></td>
</tr>
</cfloop>
</table>
</td>
</tr>
</table>

</body>
</html>
</cfoutput>