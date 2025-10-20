
<cfif isdefined('url.uuid') and isdefined('url.trancode')>
<cfset url.uuid = URLDECODE(url.uuid)>
<cfset url.brem4 = trim(URLDECODE(url.brem4))>
<cfset url.brem1 = trim(URLDECODE(url.brem1))>
<cfset url.job = trim(URLDECODE(url.job))>
<cfset url.qty = URLDECODE(url.qty)>
<cfset url.unit = trim(URLDECODE(url.unit))>
<cfset url.promotiontype =trim(URLDECODE(url.promotiontype))>

<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_Discount = getgsetup2.Decl_Discount>

<!---getgrouplocation--->
<cfquery name="getlocationgroup" datasource="#dts#">
	select price_bil,itemno,location,trancode,qty from ictrantemp 
    WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>
<!--- --->

<cfquery name="getlocationgroupitem" datasource="#dts#">
	select price_bil,itemno,location,trancode,qty from ictrantemp 
    WHERE 
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroup.itemno#">
and price_bil = '#getlocationgroup.price_bil#'
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>


<cfquery name="updaterow" datasource="#dts#">
UPDATE ictrantemp SET 
job=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.job#">,
unit_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.unit#">,
unit=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.unit#">,
brem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.brem1#">,
promotion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.promotiontype#">
<cfif url.promotiontype neq "">
,rem11 = ""
</cfif>
WHERE 
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroup.itemno#">
and price_bil = '#getlocationgroup.price_bil#'
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfloop query="getlocationgroupitem">

<cfset qtyReal = getlocationgroupitem.qty>

<cfset discountamount = 0 >
<cfif url.brem4 neq "">

	<cfif right(url.brem4,1) eq "%">
    <cfset totpercent = val(url.brem4)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset adiscountamount = numberformat(val(getlocationgroupitem.price_bil) * ((100-totpercent)/100),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getlocationgroupitem.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    <cfelse>
    <cfset totdis = val(url.brem4)>
        <cfif totdis lte val(getlocationgroupitem.price_bil)>
        <cfset adiscountamount =numberformat( val(getlocationgroupitem.price_bil) - val(totdis),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getlocationgroupitem.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    </cfif>
</cfif>
<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictrantemp SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#",
brem4 = "#url.brem4#"
<cfif right(url.brem4,1) eq "%">
,dispec1='#val(url.brem4)#'
</cfif>
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>   

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantemp SET 
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2),
amt1_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictrantemp SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

</cfloop>


<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
</cfoutput>


</cfif>