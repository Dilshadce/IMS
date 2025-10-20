<cfsetting showdebugoutput="no">
<cfquery name="getItemDetails" datasource="#dts#">
SELECT desp,unit,unit2,unit3,unit4,unit5,unit6,price,ucost from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
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

<cfif url.tran eq "PR" or url.tran eq "RC" or url.tran eq "PO">
<cfset getItemDetails.price = getItemDetails.ucost >
</cfif>

<cfoutput>
<input type="hidden" name="desphid" id="desphid" value="#desp#" />

<input type="hidden" name="unithid" id="unithid" value="#allunit#" />
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.price),'.__')#" />
</cfoutput>
<cfquery name="getpricehis" datasource="#dts#">
		select 
		wos_date,price,dispec1,dispec2,dispec3,qty
		from currictran 
		where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
		and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custno#"> 
		order by wos_date desc limit 2;
	</cfquery>
<cfoutput>
<b>Last Price</b>
<table>
<tr><th>Date</th><td>&nbsp;</td><th>Price</th></tr>
<cfloop query="getpricehis">
<tr><td>#dateformat(getpricehis.wos_date,'YYYY-MM-DD')#</td><td>&nbsp;</td><td>#numberformat(getpricehis.price,'.__')#</td></tr>
</cfloop>
</table>
</cfoutput>