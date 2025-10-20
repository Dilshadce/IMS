
<cfif isdefined('url.tran') and isdefined('url.refno') and isdefined('url.trancode')>
<cfset url.refno = URLDECODE(url.refno)>
<cfset url.tran = URLDECODE(url.tran)>
<cfset url.coltype = URLDECODE(url.coltype)>
<cfset url.qty = URLDECODE(url.qty)>
<cfset url.brem4 = trim(URLDECODE(url.brem4))>
<cfset url.brem1 = trim(URLDECODE(url.brem1))>
<cfset url.job = trim(URLDECODE(url.job))>
<cfset url.itemno = trim(URLDECODE(url.itemno))>

<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_Discount = getgsetup2.Decl_Discount>

<cftry>
<cfquery name="checkbillpromo" datasource="#dts#">
	select refno,type,custno,itemno from ictran where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#"> and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>

<cfif checkbillpromo.type eq 'PO' or checkbillpromo.type eq 'RC' or checkbillpromo.type eq 'PR'>

<cfelse>
	<cfquery name="checkpromotion" datasource="#dts#">
    	SELECT * FROM promoitem as a right join promotion as b on a.promoid = b.promoid WHERE a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(checkbillpromo.itemno)#"> and b.periodfrom <="#dateformat(now(),'yyyy-mm-dd')#" and b.periodto >= "#dateformat(now(),'yyyy-mm-dd')#" and (b.customer='#checkbillpromo.custno#' or b.customer='')
    </cfquery>
    
    <cfif checkpromotion.type eq "buy">
    <cfif checkpromotion.pricedistype eq "Varprice" and (url.qty gte checkpromotion.rangefrom and url.qty lte checkpromotion.rangeto)>
    
    <cfquery name="updateictranqty" datasource="#dts#">
    UPDATE ictran SET 
    price_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(checkpromotion.itemprice)#">
    WHERE 
    trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
    and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
    </cfquery>
    <cfelse>
    <cfquery name="getitemprice" datasource="#dts#">
    select price from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(checkbillpromo.itemno)#">
    </cfquery>
    <cfquery name="updateictranqty" datasource="#dts#">
    UPDATE ictran SET 
    price_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(getitemprice.price)#">
    WHERE 
    trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
    and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
    </cfquery>
    
	</cfif>
    </cfif>
    
    </cfif>
    
<cfcatch>
</cfcatch></cftry>



<cfquery name="updaterow" datasource="#dts#">
UPDATE ictran SET 
qty_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.qty#">,
location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.coltype#">,
job=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.job#">,
brem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.brem1#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit FROM ictran WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
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
<!---
<cfif url.brem4 neq "">
<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,qty_bil FROM ictran
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

	<cfif right(url.brem4,1) eq "%">
    <cfset totpercent = val(url.brem4)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset adiscountamount = numberformat(val(getprice.price_bil) * ((100-totpercent)/100),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    <cfelse>
    <cfset totdis = val(url.brem4)>
        <cfif totdis lte val(getprice.price_bil)>
        <cfset adiscountamount =numberformat( val(getprice.price_bil) - val(totdis),stDecl_UPrice) * val(qtyReal)>
        <cfset discountamount = numberformat(val(getprice.price_bil),stDecl_UPrice) * val(qtyReal) - val(adiscountamount)>
        </cfif>
    </cfif>
</cfif>
<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictran SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#",
brem4 = "#url.brem4#"
<cfif right(url.brem4,1) eq "%">
,dispec1='#val(url.brem4)#'
</cfif>
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>   ---->


<cfquery name="getdiscountdetail" datasource="#dts#">
SELECT dispec1,dispec2,dispec3,disamt_bil,price_bil,qty_bil FROM ictran
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfif val(getdiscountdetail.dispec1) +  val(getdiscountdetail.dispec2) + val(getdiscountdetail.dispec3) neq 0>

<cfset subtotalcal = val(getdiscountdetail.price_bil) * val(getdiscountdetail.qty_bil)>
<cfset tempamt = numberformat((subtotalcal*val(getdiscountdetail.dispec1)/100),stDecl_Discount)>
<cfset totaldiscount = tempamt>
<cfset tempamt = numberformat((subtotalcal-totaldiscount),stDecl_Discount)>
<cfset tempamt = numberformat((tempamt*val(getdiscountdetail.dispec2)/100),stDecl_Discount)>
<cfset totaldiscount = numberformat(val(totaldiscount)+val(tempamt),stDecl_Discount)>
<cfset tempamt = numberformat((subtotalcal-totaldiscount),stDecl_Discount)>
<cfset tempamt = numberformat((tempamt*val(getdiscountdetail.dispec3)/100),stDecl_Discount)>
<cfset totaldiscount = numberformat(val(totaldiscount)+val(tempamt),stDecl_Discount)>
<cfset discountamount = totaldiscount>

<cfelse>

<Cfset discountamount = getdiscountdetail.disamt_bil>
</cfif>


<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictran SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#"
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>


<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictran SET 
qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qtyReal#">,
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2),
amt1_bil = round((price_bil * qty_bil)+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictran SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as sumsubtotal,count(trancode) as notran FROM ictran where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
</cfoutput>


</cfif>