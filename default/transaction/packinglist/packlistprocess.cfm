<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfquery name="getPackNo" datasource="#dts#">
SELECT * from refnoset where type = "PACK"
</cfquery>

<cfif getPackNo.refnoused neq "1">

<cfif form.packno neq "">
<cfset olrnewrefno = form.packno>
<cfset newrefno = form.packno>
<cfelse>
<h1>REFNO MUST NOT EMPTY</h1>
<cfabort />
</cfif>

<cfelse>
<cfinvoke component="cfc.refno" method="processNum" oldNum="#getPackNo.lastUsedNo#" returnvariable="newrefno" />
<cfset olrnewrefno = newrefno>
<cfif getPackNo.presuffixuse eq "1">
<cfset newrefno = getPackNo.refnocode&newrefno&getPackNo.refnocode2>
</cfif>
</cfif>

<cfquery name="checkexist" datasource="#dts#">
SELECT packid FROM packlist WHERE packid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newrefno#">
</cfquery>

<cfif checkexist.recordcount neq 0 and getPackNo.refnoused eq 0>
<cfoutput>
<h1>PACKING LIST NUMBER EXISTED</h1>
<cfabort />
</cfoutput>
<cfelse>
<cfset findnewno = 0>
<cfloop condition="findnewno eq 0">
<cfinvoke component="cfc.refno" method="processNum" oldNum="#newrefno#" returnvariable="newrefno1" />
<cfquery name="checkexist" datasource="#dts#">
SELECT packid FROM packlist WHERE packid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newrefno1#">
</cfquery>
<cfif checkexist.recordcount eq 0>
<cfset newrefno = newrefno1>
<cfset findnewno = 1>
<cfelse>
<cfset newrefno = newrefno1>
</cfif>
</cfloop>
</cfif>

<cfquery name="insertPack" datasource="#dts#">
INSERT INTO PACKLIST
(PACKID,totalbill,reftype,created_on,created_by)
VALUES
("#newrefno#","#form.sono#","#form.reftype#",now(),"#HUserName#")
</cfquery>

<cfset errormsg = "">
<cfset newlist = "">
<cfloop list="#form.sono#" index="i">
<cfquery name="checkexist2" datasource="#dts#">
select reftype,billrefno from PACKLISTBILL where billrefno='#i#' and reftype="#form.reftype#"
</cfquery>
<cfif checkexist2.recordcount eq 0>
<cfset newlist = newlist&i&",">
<cfquery name="insertPackBill" datasource="#dts#">
INSERT INTO PACKLISTBILL
(PACKID,billRefno,reftype)
VALUES
("#newrefno#","#i#","#form.reftype#")
</cfquery>
<cfquery name="updateArtran" datasource="#dts#">
UPDATE artran SET PACKED = "Y", PACKED_ON = now(), PACKED_BY = "#Husername#" WHERE REFNO = "#i#" and type = "#form.reftype#"
</cfquery>

<cfelse>
<cfset errormsg = errormsg&"<br />"&i>
</cfif>
</cfloop>

<cfquery name="updatenewlist" datasource="#dts#">
UPDATE PACKLIST SET totalbill = "#newlist#" WHERE PACKID = "#newrefno#"
</cfquery>

<cfquery name="updateLastUsedNo" datasource="#dts#">
UPDATE refnoset SET lastusedno = "#olrnewrefno#" WHERE type ="PACK"
</cfquery>
<cfoutput>
<h4>
	<a href="/default/transaction/packinglist/packinglistmain.cfm">Create Packing List</a> || 
	<a href="/default/transaction/packinglist/listpackingmain.cfm">List Packing List</a> || 
	<a href="/default/transaction/packinglist/assigndrivermain.cfm">Assign Driver</a>||
    <a href="/default/transaction/packinglist/deliveryrecord/checkdelivered.cfm">Delivery Record</a>||
    <a href="/default/transaction/packinglist/standardreport.cfm">Delivery Report</a>
</h4>
<div align="center">
<br/>
<cfif errormsg eq "">
<h2>PACKING LIST #newrefno# HAVE SUCCESSFULLY GENERATED </h2>
<cfelse>
<h2>PACKING LIST #newrefno# HAVE PARTIALLY GENERATED</h2>
#UCASE(form.reftype)# Below has been pack by other user
#errormsg#
</cfif>
<h3><a href="/default/transaction/packinglist/printpackinglist.cfm?packno=#newrefno#" target="_blank"><img src="/images/printRpt.gif" width="20px" height="20px" /><br/>Print</a></h3>
</div>
</cfoutput>
