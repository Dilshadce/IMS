<noscript>
	Javascript has been disabled or not supported in this browser.<br>Please enable Javascript supported before continue.
</noscript>


<cfquery name="getGSetup" datasource="#dts#">
  	select compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno from gsetup 
</cfquery>

<cfquery name="getGSetup2" datasource='#dts#'>
  	Select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,concat('.',repeat('_',Decl_Discount)) as Decl_Discount from gsetup2
</cfquery>


<cfquery name="getPackId" datasource="#dts#">
SELECT reftype,created_on from packlist where packid = "#packid#"
</cfquery>

<cfquery name="getcustadd" datasource="#dts#">
SELECT billrefno,ar.custno,cust.name,cust.name2,cust.add1,cust.add2,cust.add3,cust.add4 FROM packlistbill as pa left join artran as ar on pa.billrefno = ar.refno left join arcust as cust on ar.custno=cust.custno  where pa.packID = "#packid#"
</cfquery>


<cfquery name="getSumItem" datasource="#dts#">
SELECT qty_bil as sumqty,billrefno,ic.itemno as itemno,unit_bil,price_bil,currrate,item.packing as packing,(qty_bil/brem2) as packingqty,brem3,brem4,((qty_bil/brem2)*brem3) as totalnw,((qty_bil/brem2)*brem4) as totalgw FROM packlistbill as pa left join ictran as ic on pa.billrefno = ic.refno left join icitem as item on item.itemno=ic.itemno where pa.packID = "#packid#" order by billrefno

</cfquery>
<cfset totalltr=0>
<cfset totalkg=0>
<cfset totalusd=0>
<cfset totalrp=0>
<cfset totaldrm=0>
<cfset totaljrc=0>
<cfset totalpail=0>
<cfset totalcan=0>
<cfset grandtotalgw=0>
<cfset grandtotalnw=0>

<cfloop query="getSumItem">
<cfif unit_bil eq 'LTR'>
<cfset totalltr=totalltr+sumqty>
</cfif>
<cfif unit_bil eq 'KG'>
<cfset totalkg=totalkg+sumqty>
</cfif>
<cfif currrate eq 1>
<cfset totalrp=totalrp+(sumqty*price_bil)>
</cfif>
<cfif currrate neq 1>
<cfset totalusd=totalusd+(sumqty*price_bil)>
</cfif>
<cfif lcase(packing) eq 'drm'>
<cfset totaldrm=totaldrm+packingqty>
</cfif>
<cfif lcase(packing) eq 'jrc'>
<cfset totaljrc=totaljrc+packingqty>
</cfif>
<cfif lcase(packing) eq 'pail'>
<cfset totalpail=totalpail+packingqty>
</cfif>
<cfif lcase(packing) eq 'can'>
<cfset totalcan=totalcan+packingqty>
</cfif>

<cfset grandtotalgw=grandtotalgw+totalgw>
<cfset grandtotalnw=grandtotalnw+totalnw>
</cfloop>

<cfreport template="packinglist.cfr" format="PDF" query="getSumItem"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
    <cfreportparam name="packID" value="#packID#">
    <cfreportparam name="name" value="#getcustadd.name#">
    <cfreportparam name="name2" value="#getcustadd.name2#">
    <cfreportparam name="add1" value="#getcustadd.add1#">
    <cfreportparam name="add2" value="#getcustadd.add2#">
    <cfreportparam name="add3" value="#getcustadd.add3#">
    <cfreportparam name="add4" value="#getcustadd.add4#">
    <cfreportparam name="reftype" value="#getpackid.reftype#">
    <cfreportparam name="totalltr" value="#totalltr#">
    <cfreportparam name="totalkg" value="#totalkg#">
    <cfreportparam name="totalusd" value="#totalusd#">
    <cfreportparam name="totalrp" value="#totalrp#">
    <cfreportparam name="totaldrm" value="#totaldrm#">
    <cfreportparam name="totaljrc" value="#totaljrc#">
    <cfreportparam name="totalpail" value="#totalpail#">
    <cfreportparam name="totalcan" value="#totalcan#">
    <cfreportparam name="grandtotalgw" value="#grandtotalgw#">
    <cfreportparam name="grandtotalnw" value="#grandtotalnw#">
    <cfreportparam name="created_on" value="#getPackId.created_on#">
</cfreport>