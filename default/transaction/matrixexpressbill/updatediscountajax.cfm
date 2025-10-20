
<cfif isdefined('url.uuid')>
<cfset url.uuid = URLDECODE(url.uuid)>
<cfset url.brem4 = trim(URLDECODE(url.brem4))>
<cfset discountpercent1=0>
<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount,
    concat('.',repeat('_',DECL_TOTALAMT)) as DECL_TOTALAMT
	from gsetup2
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_Discount = getgsetup2.Decl_Discount>
<cfset stDECL_TOTALAMT = getgsetup2.DECL_TOTALAMT>


<cfset discountamount = 0 >
<cfif url.brem4 neq "">
<cfquery name="getallitem" datasource="#dts#">
SELECT * FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#" />
</cfquery>

<cfloop query="getallitem">

<cfset qtyreal=getallitem.qty_bil>

<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,qty_bil FROM ictrantemp
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

    <cfset totpercent = val(url.brem4)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset discountpercent1=totpercent/100>
        
        
        <cfif getgsetup.itemdiscmethod eq 'byprice'>
        <cfset adiscountamount = numberformat(numberformat(val(getprice.price_bil) * ((100-totpercent)/100),stDecl_UPrice) * val(qtyReal),stDECL_TOTALAMT)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
		<cfelse>
		<cfset adiscountamount = numberformat(val(getprice.price_bil) * ((100-totpercent)/100),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
        
        </cfif>

<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictrantemp SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#",
brem4 = "#url.brem4#",dispec1='#discountpercent1#'
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>   


<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantemp SET 
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2),
amt1_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictrantemp SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>
</cfloop>

</cfif>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal2" id="hidsubtotal2" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount2" id="hiditemcount2" value="#getsum.notran#" />
</cfoutput>


</cfif>