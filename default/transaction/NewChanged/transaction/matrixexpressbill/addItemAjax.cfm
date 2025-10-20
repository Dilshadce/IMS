<cfsetting showdebugoutput="no">
<cfquery name="getItemDetails" datasource="#dts#">
SELECT desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,"0" as isservi from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>
<cfif getItemDetails.recordcount eq 0>
<cfquery name="getItemDetails" datasource="#dts#">
SELECT servi,desp,despa,"1" as isservi, 0 as price,"" as unit,"" as unit2, "" as unit3, "" as unit4, "" as unit5, "" as unit6 from icservi where servi = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
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
<input type="hidden" name="desphid" id="desphid" value="#desp#" />
<input type="hidden" name="despahid" id="despahid" value="#despa#" />
<input type="hidden" name="unithid" id="unithid" value="#allunit#" />
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.price),'.__')#" />
<input type="hidden" name="iservi" id="isservi" value="#getItemDetails.isservi#" />
</cfoutput>
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