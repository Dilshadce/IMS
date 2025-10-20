<cfquery name="checkupdateqty" datasource="#dts#">
SELECT qty_bil FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
and id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
</cfquery>
    
<cfif find('/',form.qty)>
    <cfset fraction = form.qty>
    <cfset form.qty = evaluate('#form.qty#')>    
</cfif>
    
<cfif val(checkupdateqty.qty_bil) eq val(form.qty)>
<cfabort>
<cfelse>

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


<cfquery name="updaterow" datasource="#dts#">
UPDATE ictrantempcn SET 
qty_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qty#">
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,currrate,price_bil,brem4,qty,qty_bil FROM ictrantempcn WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>

<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.itemno#" >
</cfquery>

<cfset qtyReal = qty>
<cfset unit = getitemdetail.unit>
<cfif unit neq "" and unit neq "#selecticitem.unit#">

<cfif unit eq "#selecticitem.unit2#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factor1) ) / val(selecticitem.factor2)>
<cfelseif unit eq "#selecticitem.unit3#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU3_a) ) / val(selecticitem.factorU3_b)>
<cfelseif unit eq "#selecticitem.unit4#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU4_a) ) / val(selecticitem.factorU4_b)>
<cfelseif unit eq "#selecticitem.unit5#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU5_a) ) / val(selecticitem.factorU5_b)>
<cfelseif unit eq "#selecticitem.unit6#">
<cfset qtyReal = ( val(qty) * val(selecticitem.factorU6_a) ) / val(selecticitem.factorU6_b)>
</cfif>

</cfif>


<cfset discountamount = 0 >
<cfset dispec1=0>
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
        <cfset dispec1=totpercent/100>
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
UPDATE ictrantempcn SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#",
brem4 = "#getitemdetail.brem4#",
dispec1="#dispec1*100#"
WHERE 
id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
</cfquery>  

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantempcn SET 
qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qtyReal#">,
<cfif isdefined('fraction')>
    brem9= <cfqueryparam cfsqltype="cf_sql_varchar" value="#fraction#">,
    amt_bil = round((price_bil * #val(form.qty)#)+0.000001 - disamt_bil,2),
    amt1_bil = round((price_bil * #val(form.qty)#)+0.000001,2)
<cfelse>
    amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2),
    amt1_bil = round((price_bil * qty_bil)+0.000001,2)
</cfif>
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
</cfif>
