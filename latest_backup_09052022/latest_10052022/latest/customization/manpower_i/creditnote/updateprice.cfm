<cfset promoitem=''>
    
<cfset form.price = replace(replace(form.price,',',''),' ','')>
    
<cfquery name="getprice" datasource="#dts#">
SELECT type,price_bil,itemno FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
and id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
</cfquery>
<!---<cfif val(getprice.price_bil) eq val(form.price)>
<cfabort>
<cfelse>--->
<cfif isdefined('form.uuid') and isdefined('form.trancode')>
<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_Discount = getgsetup2.Decl_Discount>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getitemrealprice" datasource="#dts#">
select price,costcode from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getprice.itemno#">
</cfquery>

<cfif val(form.price) lt getitemrealprice.price>
<cfset promoitem='Y'>
<cfelseif getitemrealprice.costcode eq 'YES'>
<cfset promoitem='Y'>
</cfif>

<cfquery name="updaterow" datasource="#dts#">
UPDATE ictrantempcn SET 
    <cfif getprice.type eq 'cn'>
        price_bil = <cfif left(form.price,1) eq '-'><cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.price),stDecl_UPrice)#"><cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.price),stDecl_UPrice)#">*-1</cfif>,
    <cfelse>
        price_bil = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.price),stDecl_UPrice)#">,
    </cfif>
    
note1='#promoitem#'
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,currrate,price_bil,brem4,qty,qty_bil FROM ictrantempcn WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>

<cfset qtyReal = val(getitemdetail.qty_bil)>

<cfif val(getitemdetail.currrate) eq 0>
<cfset newcurrate = 1>
<cfelse>
<cfset newcurrate = val(getitemdetail.currrate)>
</cfif>

<cfquery name="updateprice" datasource="#dts#">
UPDATE ictrantempcn SET 
price = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getitemdetail.price_bil) * val(newcurrate),stDecl_UPrice)#">
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>


<cfset discountamount = 0 >
<cfif getitemdetail.brem4 neq "">
<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,qty_bil FROM ictrantempcn
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>

	<cfif right(getitemdetail.brem4,1) eq "%">
    <cfset totpercent = val(getitemdetail.brem4)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset adiscountamount = numberformat(val(getprice.price_bil) * ((100-totpercent)/100),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    <cfelse>
    <cfset totdis = val(getitemdetail.brem4)>
        <cfif totdis lte val(getprice.price_bil)>
        <cfset adiscountamount =numberformat( val(getprice.price_bil) - val(totdis),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    </cfif>
</cfif>
<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictrantempcn SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#"
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>   




<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantempcn SET 
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2),
amt1_bil = round((price_bil * qty_bil)+0.000001,2)
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictrantempcn SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>

<cfif getgsetup.wpitemtax eq "1">
	<cfquery name="updateictrantax" datasource="#dts#">
	UPDATE ictrantempcn SET
        <cfif getgsetup.taxincluded eq "Y">
        TAXAMT_BIL=round((AMT_BIL*(taxpec1/(taxpec1+100))),3),
        TAXAMT=round((AMT*(taxpec1/(taxpec1+100))),3),
        taxincl="T"
        <cfelse>
        TAXAMT_BIL=round((AMT_BIL*(taxpec1/100)),3),
        TAXAMT=round((AMT*(taxpec1/100)),3)
        </cfif>
        where 
        uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
        and id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
	</cfquery>
</cfif>

</cfif>
<!---</cfif>--->
