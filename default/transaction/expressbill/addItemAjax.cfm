<cfsetting showdebugoutput="no">
<cfquery name="checkenable" datasource="#dts#">
select enabledetectrem1,itempriceprior from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
    concat('.',repeat('_',DECL_TOTALAMT)) as Decl_TOTALAMT,
	Decl_Uprice as Decl_Uprice1,Decl_TOTALAMT as Decl_TOTALAMT1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>


<cfset url.itemno = URLDECODE(URLDECODE(url.itemno))>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,comment,"0" as isservi from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
<cfif lcase(hcomid) eq "simplysiti_i" and now() lt "2012-10-21 00:00:00">
<cfif getauthuser() neq "adminnoohuss">
and category <> "In Active"
</cfif>
</cfif>
</cfquery>

<cfif getItemDetails.recordcount eq 0>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT itemno,desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,comment,"0" as isservi from icitem where aitemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
<cfif lcase(hcomid) eq "simplysiti_i" and now() lt "2012-10-21 00:00:00">
<cfif getauthuser() neq "adminnoohuss">
and category <> "In Active"
</cfif>
</cfif>

</cfquery>

<cfif checkenable.enabledetectrem1 eq 'Y'>

<cfif getItemDetails.recordcount eq 0>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT itemno,desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,comment,"0" as isservi from icitem where remark2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
<cfif lcase(hcomid) eq "simplysiti_i" and now() lt "2012-10-21 00:00:00">
<cfif getauthuser() neq "adminnoohuss">
and category <> "In Active"
</cfif>
</cfif>

</cfquery>
</cfif>
</cfif>

<cfif getItemDetails.recordcount neq 0>
<cfset url.itemno = getItemDetails.itemno>
<cfoutput>
<input type="hidden" name="replaceitemno" id="replaceitemno" value="#URLENCODEDFORMAT(trim(url.itemno))#" />
</cfoutput>
</cfif>
</cfif>

<cfif getItemDetails.recordcount eq 0>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT servi,desp,despa,"1" as isservi, 0 as price, 0 as ucost,"" as unit,"" as unit2, "" as unit3, "" as unit4, "" as unit5, "" as unit6,"" as costformula,'' as comment from icservi where servi = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>
</cfif>
<cfset desp = getItemDetails.desp>
<cfset despa = getItemDetails.despa>
<cfif getItemDetails.recordcount neq 1 and url.itemno neq "">
<cfset desp = "itemisnoexisted" >
<cfset despa = "">
</cfif> 
<cfif getItemDetails.isservi neq "1">
<cfset allunit = getItemDetails.unit >
<cfloop from="2" to="6" index="i">
<cfset unitgo = "unit"&i>
<cfset unitadd = evaluate('getItemDetails.#unitgo#')>
<cfif trim(unitadd) neq "">
<cfset allunit = allunit &","&unitadd>
</cfif>
</cfloop>
<cfelse>
<cfset allunit = "">
</cfif>


<cfoutput>
<cfif checkenable.itempriceprior eq "2">
<cfquery name="getcustomerprice" datasource="#dts#">
select * from icl3p<cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'><cfelse>2</cfif> where itemno='#url.itemno#' and custno='#url.custno#'
</cfquery>
<cfif getcustomerprice.recordcount neq 0>
<cfset getItemDetails.price=getcustomerprice.price>
<cfset getItemDetails.ucost=getcustomerprice.price>
</cfif>
</cfif>

<cfquery name="getbustype" datasource="#dts#">
SELECT business FROM #target_arcust#
    where custno='#url.custno#'
</cfquery>
<cfif getbustype.business neq "">
<cfquery name="getpricelvl" datasource="#dts#">
SELECT pricelvl FROM business where business = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbustype.business#">
</cfquery>

<cfif getpricelvl.pricelvl eq 2>
<cfset price = getItemDetails.price2>
<cfelseif getpricelvl.pricelvl eq 3>
<cfset price = getItemDetails.price3>
<cfelseif getpricelvl.pricelvl eq 4>
<cfset price = getItemDetails.price4>
<cfelse>
<cfset price = getItemDetails.price>
</cfif>
<cfelse>
<cfset price = getItemDetails.price>
</cfif>

<cfset getItemDetails.price = price >

<cfif checkenable.itempriceprior eq "1">
<cfquery name="getcustomerprice" datasource="#dts#">
select * from icl3p<cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'><cfelse>2</cfif> where itemno='#url.itemno#' and custno='#url.custno#'
</cfquery>
<cfif getcustomerprice.recordcount neq 0>
<cfset getItemDetails.price=getcustomerprice.price>
<cfset getItemDetails.ucost=getcustomerprice.price>
</cfif>
</cfif>
                        
<input type="hidden" name="desphid" id="desphid" value="#URLENCODEDFORMAT(desp)#" />
<input type="hidden" name="despahid" id="despahid" value="#URLENCODEDFORMAT(despa)#" />
<input type="hidden" name="commenthid" id="commenthid" value="#URLENCODEDFORMAT(tostring(getItemDetails.comment))#" />
<input type="hidden" name="unithid" id="unithid" value="#allunit#" />
<cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'>
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.ucost),stDecl_UPrice)#" />
<cfelse>
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.price),stDecl_UPrice)#" />
</cfif>
<input type="hidden" name="costformulaid" id="costformulaid" value="#getItemDetails.costformula#" />
<input type="hidden" name="iservi" id="isservi" value="#getItemDetails.isservi#" />
</cfoutput>


<cfif url.reftype eq 'TR'>
<cfset wos_date = URLDecode(url.date)>
<cfset ndate = createdate(right(wos_date,4),mid(wos_date,4,2),left(wos_date,2))>
<cfset locationto = URLDecode(url.locationto)>
<cfquery name="getlasttransfer" datasource="#dts#">
		select refno,wos_date,qty from ictran where type='TRIN' and location='#locationto#' and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
        order by wos_date desc limit 3;
</cfquery>

<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="currentmonth"/>

<cfset lastperiod=numberformat(currentmonth-1,'00')>
<cfquery name="getlasttransfer2" datasource="#dts#">
		select sum(amt) as amt,sum(qty) as qty,wos_date from ictran where type='SAM' and fperiod='#lastperiod#' and location='#locationto#' and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>

<cfset lastperiod2=numberformat(currentmonth-2,'00')>
<cfquery name="getlasttransfer3" datasource="#dts#">
		select sum(amt) as amt,sum(qty) as qty,wos_date from ictran where type='SAM' and fperiod='#lastperiod2#' and location='#locationto#' and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>


<cfset lastperiod3=numberformat(currentmonth-3,'00')>
<cfquery name="getlasttransfer4" datasource="#dts#">
		select sum(amt) as amt,sum(qty) as qty,wos_date from ictran where type='SAM' and fperiod='#lastperiod3#' and location='#locationto#' and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>

<cfoutput>
<b>Last transfer</b>
<table>
<tr><td><b>Date</b></td><td>&nbsp;</td><td><b>Refno</b></td><td>&nbsp;</td><td><b>Qty</b></td></tr>
<cfloop query="getlasttransfer">
<tr><td>#dateformat(getlasttransfer.wos_date,'YYYY-MM-DD')#</td><td>&nbsp;</td><td>#getlasttransfer.refno#</td><td>&nbsp;</td><td>#getlasttransfer.qty#</td></tr>
</cfloop>
</table>
<b>Last Month Sales</b>
<table>
<tr><td><b>Date</b></td><td>&nbsp;</td><td><b>Qty</b></td><td>&nbsp;</td><td align="right"><b>Amount</b></td></tr>
<cfif val(getlasttransfer2.amt) neq 0>
<tr><td>#dateformat(getlasttransfer2.wos_date,'MMMM YYYY')#</td><td>&nbsp;</td><td>#getlasttransfer2.qty#</td><td>&nbsp;</td><td align="right">#numberformat(getlasttransfer2.amt,',_.__')#</td></tr>
</cfif>
<cfif val(getlasttransfer3.amt) neq 0>
<tr><td>#dateformat(getlasttransfer3.wos_date,'MMMM YYYY')#</td><td>&nbsp;</td><td>#getlasttransfer3.qty#</td><td>&nbsp;</td><td align="right">#numberformat(getlasttransfer3.amt,',_.__')#</td></tr>
</cfif>
<cfif val(getlasttransfer4.amt) neq 0>
<tr><td>#dateformat(getlasttransfer4.wos_date,'MMMM YYYY')#</td><td>&nbsp;</td><td>#getlasttransfer4.qty#</td><td>&nbsp;</td><td align="right">#numberformat(getlasttransfer4.amt,',_.__')#</td></tr>
</cfif>
</table>

</cfoutput>

<cfelse>
<cfquery name="getpricehis" datasource="#dts#">
		select 
		wos_date,price,dispec1,dispec2,dispec3,qty
		from ictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
		order by wos_date desc limit 2;
</cfquery>
<cfoutput>
<b>Last Price</b>
<table>
<cfloop query="getpricehis">
<tr><td>#dateformat(getpricehis.wos_date,'YYYY-MM-DD')#</td><td>&nbsp;</td><td>#numberformat(getpricehis.price,'.__')#</td></tr>
</cfloop>
</table>
</cfoutput>
</cfif>