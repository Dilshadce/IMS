<cfsetting showdebugoutput="no">

<cfset url.itemno=URLDecode(url.itemno)>

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


<cfoutput>
<input type="hidden" name="tradeindesphid" id="tradeindesphid" value="#desp#" />
<input type="hidden" name="tradeindespahid" id="tradeindespahid" value="#getItemDetails.despa#" />
<input type="hidden" name="tradeincommenthid" id="tradeincommenthid" value="#getItemDetails.comment#" />
<input type="hidden" name="tradeinunithid" id="tradeinunithid" value="#allunit#" />
<input type="hidden" name="tradeinpricehid" id="tradeinpricehid" value="0" />
</cfoutput>
