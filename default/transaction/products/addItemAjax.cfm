<cfsetting showdebugoutput="no">
<cfquery name="getItemDetails" datasource="#dts#">
SELECT desp,unit,unit2,unit3,unit4,unit5,unit6,price,ucost,price2,price3,price4,comment,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="i">,fcurrcode#i#,fprice#i#,fucost#i#</cfloop> from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
<cfif Hitemgroup neq ''>
   and wos_group='#Hitemgroup#'
</cfif>

</cfquery>
<cfset desp = getItemDetails.desp>
<cfif getItemDetails.recordcount neq 1 and url.itemno neq "">
<cfset desp = "itemisnoexisted" >
</cfif> 
<cfset allunit = getItemDetails.unit >
<cfloop from="2" to="6" index="i">
<cfset unitgo = "unit"&i>
<cfset unitadd = evaluate('getItemDetails.#unitgo#')>
<cfif trim(unitadd) neq "">
<cfset allunit = allunit &","&unitadd>
</cfif>
</cfloop>

<cfif url.tran eq "PR" or url.tran eq "RC" or url.tran eq "PO" or url.tran eq "ISS">
<cfset getItemDetails.price = getItemDetails.ucost >
</cfif>

<cfquery name="getitemprior" datasource="#dts#">
SELECT itempriceprior FROM gsetup
</cfquery>

<cfif getitemprior.itempriceprior eq "2">
<cfquery name="getcustomerprice" datasource="#dts#">
select * from icl3p<cfif url.tran eq 'PO' or url.tran eq 'RC' or url.tran eq 'PR'><cfelse>2</cfif> where itemno='#url.itemno#' and custno='#url.custno#'
</cfquery>
<cfif getcustomerprice.recordcount neq 0>
<cfset getItemDetails.price=getcustomerprice.price>
<cfset getItemDetails.ucost=getcustomerprice.price>
</cfif>
</cfif>

<cfquery name="getbustype" datasource="#dts#">
SELECT business,currcode FROM #target_arcust#
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

<cfif getitemprior.itempriceprior eq "1">
<cfquery name="getcustomerprice" datasource="#dts#">
select * from icl3p<cfif url.tran eq 'PO' or url.tran eq 'RC' or url.tran eq 'PR'><cfelse>2</cfif> where itemno='#url.itemno#' and custno='#url.custno#'
</cfquery>
<cfif getcustomerprice.recordcount neq 0>
<cfset getItemDetails.price=getcustomerprice.price>
<cfset getItemDetails.ucost=getcustomerprice.price>
</cfif>
</cfif>


<cftry>

<cfif getbustype.currcode eq getItemDetails.fcurrcode>
<cfif url.tran eq "PR" or url.tran eq "RC" or url.tran eq "PO" or url.tran eq "ISS">
<cfset price=getItemDetails.fucost>
<cfelse>
<cfset price=getItemDetails.fprice>
</cfif>

</cfif>

<cfloop from="2" to="10" index="i">
<cfif getbustype.currcode eq evaluate('getItemDetails.fcurrcode#i#')>
<cfif url.tran eq "PR" or url.tran eq "RC" or url.tran eq "PO" or url.tran eq "ISS">
<cfset price= evaluate('getItemDetails.fucost#i#')>
<cfelse>
<cfset price= evaluate('getItemDetails.fprice#i#')>
</cfif>
</cfif>

</cfloop>
<cfcatch></cfcatch></cftry>


<cfoutput>
<input type="hidden" name="desphid" id="desphid" value="#getItemDetails.desp#" />
<input type="hidden" name="commenthid" id="commenthid" value="#getItemDetails.comment#" />
<input type="hidden" name="unithid" id="unithid" value="#allunit#" />
<input type="hidden" name="pricehid" id="pricehid" value="#price#" />
</cfoutput>

<cfquery name="histpricemethod" datasource="#dts#">
		select histpriceinv from gsetup
	</cfquery>
<cfif histpricemethod.histpriceinv eq 'Y'>
<cfif url.tran eq 'PO' or url.tran eq 'RC' or url.tran eq 'PR'>
<cfquery name="getpricehis" datasource="#dts#">
		select 
		refno,wos_date,price_bil,dispec1,dispec2,dispec3,qty
		from ictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(urldecode(url.itemno))#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
        and type = 'RC'
		order by wos_date desc limit 5;
	</cfquery>
<cfelse>
<cfquery name="getpricehis" datasource="#dts#">
		select 
		refno,wos_date,price_bil,dispec1,dispec2,dispec3,qty
		from ictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
        and type = 'INV'
		order by wos_date desc limit 5;
	</cfquery>

</cfif>
<cfelse>

<cfquery name="getpricehis" datasource="#dts#">
		select 
		refno,wos_date,price_bil,dispec1,dispec2,dispec3,qty
		from ictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
		order by wos_date desc limit 5;
	</cfquery>
    </cfif>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>
    
<cfif getdisplaysetup2.body_pricelist eq "Y">
<cfoutput>
    <cfquery name="getallprice" datasource="#dts#">
    select price,price2,price3,price4 from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
    </cfquery>
    Price:#numberformat(getallprice.price,',_.____')#<br />
    Price 2:#numberformat(getallprice.price2,',_.____')#<br />
	Price 3:#numberformat(getallprice.price3,',_.____')#<br />
	Price 4:#numberformat(getallprice.price4,',_.____')#<br />
</cfoutput>
    </cfif>
    
    
<cfoutput>
<b>Last Price</b>
<table>
<tr><th>Ref No</th><td>&nbsp;</td><th>Date</th><td>&nbsp;</td><th>Price</th></tr>
<cfloop query="getpricehis">
<tr>
<td>#refno#</td><td>&nbsp;</td>
<td>#dateformat(getpricehis.wos_date,'YYYY-MM-DD')#</td><td>&nbsp;</td><td>#numberformat(getpricehis.price_bil,'.____')#</td></tr>
</cfloop>
</table>
</cfoutput>