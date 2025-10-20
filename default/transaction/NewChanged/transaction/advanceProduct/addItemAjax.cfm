<cfsetting showdebugoutput="no">
<cfquery name="getItemDetails" datasource="#dts#">
SELECT desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,comment from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
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

<cfoutput>
<input type="hidden" name="desphid" id="desphid" value="#desp#" />
<input type="hidden" name="despahid" id="despahid" value="#getItemDetails.despa#" />
<input type="hidden" name="commenthid" id="commenthid" value="#getItemDetails.comment#" />
<input type="hidden" name="unithid" id="unithid" value="#allunit#" />
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.price),'.__')#" />
</cfoutput>

<cfquery name="histpricemethod" datasource="#dts#">
		select histpriceinv from gsetup
	</cfquery>
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


<cfif histpricemethod.histpriceinv eq 'Y'>
<cfif url.tran eq 'PO' or url.tran eq 'RC' or url.tran eq 'PR'>
<cfquery name="getpricehis" datasource="#dts#">
		select 
		refno,wos_date,price,dispec1,dispec2,dispec3,qty
		from ictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
        and type = 'RC'
		order by wos_date desc limit 2;
	</cfquery>
<cfelse>
<cfquery name="getpricehis" datasource="#dts#">
		select 
		refno,wos_date,price,dispec1,dispec2,dispec3,qty
		from ictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
        and type = 'INV'
		order by wos_date desc limit 2;
	</cfquery>

</cfif>
<cfelse>

<cfquery name="getpricehis" datasource="#dts#">
		select 
		refno,wos_date,price,dispec1,dispec2,dispec3,qty
		from ictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
		order by wos_date desc limit 2;
	</cfquery>
    </cfif>

<cfoutput>
<b>Last Price</b>
<table>
<tr><th>Ref No</th><td>&nbsp;</td><th>Date</th><td>&nbsp;</td><th>Price</th></tr>
<cfloop query="getpricehis">
<tr><td>#refno#</td><td>&nbsp;</td><td>#dateformat(getpricehis.wos_date,'YYYY-MM-DD')#</td><td>&nbsp;</td><td>#numberformat(getpricehis.price,'.__')#</td></tr>
</cfloop>
</table>
</cfoutput>