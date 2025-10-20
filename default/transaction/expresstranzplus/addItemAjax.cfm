

<cfsetting showdebugoutput="no">
<cfquery name="checkenable" datasource="#dts#">
select enabledetectrem1,itempriceprior from gsetup
</cfquery>
<cfset url.itemno = URLDECODE(URLDECODE(url.itemno))>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,"0" as isservi from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>

<cfif getItemDetails.recordcount eq 0>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT itemno,desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,"0" as isservi from icitem where aitemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>

<cfif checkenable.enabledetectrem1 eq 'Y'>

<cfif getItemDetails.recordcount eq 0>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT itemno,desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,"0" as isservi from icitem where remark2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>
</cfif>
</cfif>

<cfif getItemDetails.recordcount eq 0>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT itemno,desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,"0" as isservi from icitem where barcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>
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
SELECT servi,desp,despa,"1" as isservi, 0 as price, 0 as ucost,"" as unit,"" as unit2, "" as unit3, "" as unit4, "" as unit5, "" as unit6,"" as costformula from icservi where servi = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
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
<input type="hidden" name="unithid" id="unithid" value="#allunit#" />
<cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR' or url.reftype eq 'ISS'>
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.ucost),'.__')#" />
<cfelse>
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.price),'.__')#" />
</cfif>
<input type="hidden" name="costformulaid" id="costformulaid" value="#getItemDetails.costformula#" />
<input type="hidden" name="iservi" id="isservi" value="#getItemDetails.isservi#" />
</cfoutput>

<cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'>
<cfquery name="lastprice" datasource="#dts#">
select * from ictran where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#"> and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#">  and type='PO' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>

<cfquery name="lastprice2" datasource="#dts#">
select * from ictran where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">  and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#">  and type='RC' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>   
<cfelse>
<cfquery name="lastprice" datasource="#dts#">
select * from ictran where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#"> and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#">  and type='QUO' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>

<cfquery name="lastprice2" datasource="#dts#">
select * from ictran where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">  and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#">  and type='INV' and fperiod<>'99' and (void='' or void is null) order by wos_date desc limit 5
</cfquery>    
</cfif>
<cfquery name="getallbal" datasource="#dts#">
    select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance,
    ifnull(d.soqty,0) as soqty,
    ifnull(e.poqty,0) as poqty
    from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and fperiod<>'99'
		and (void = '' or void is null)
		and (toinv='' or toinv is null) 
		group by itemno
	) as c on a.itemno=c.itemno
    
    left join 
	(
		select itemno,sum(qty) as soqty 
		from ictran 
		where type in ('SO') 
		and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as d on a.itemno=d.itemno
    
    left join 
	(
		select itemno,sum(qty) as poqty 
		from ictran 
		where type in ('PO') 
		and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as e on a.itemno=e.itemno
    
    where a.itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
    
    </cfquery>    
    
    
<cfoutput>
<table width="250" border="1">
<tr><th>Qtybf</th><th>PO</th><th>SO</th></tr>
<tr><td>#getallbal.balance#</td><td>#getallbal.poqty#</td><td>#getallbal.soqty#</td></tr>
</table>
<br />
<table width="500" border="1">
<cfif url.reftype eq 'PO' or url.reftype eq 'RC' or url.reftype eq 'PR'>
<tr><th colspan="2">Last 5 PURCHASED</th><th>&nbsp;</th><th colspan="2">Last 5 RECEIVED</th></tr>
<cfelse>
<tr><th colspan="2">Last 5 QUOTED</th><th>&nbsp;</th><th colspan="2">Last 5 INVOICED</th></tr>
</cfif>
<tr>
<th>No.</th>
<th>Price</th>
<th>&nbsp;</th>
<th>No.</th>
<th>Price</th>
</tr>
<cfloop query="lastprice">
<tr>
<td>#lastprice.refno#</td>
<td>#numberformat(lastprice.price,',.__')#</td>
<td>&nbsp;</td>
<td>#lastprice2.refno#</td>
<td>#numberformat(lastprice2.price,',.__')#</td>
</tr>
</cfloop>
</table>


</cfoutput>