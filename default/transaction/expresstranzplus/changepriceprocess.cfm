<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,itemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>



<cfif val(getprice.price_bil) eq val(form.price_bil1)>
<script type="text/javascript">
calculatefooter();
refreshlist();
recalculateamt();
ColdFusion.Window.hide('changeprice');
</script>
<cfelse>

<cfquery name="checksamepricesameitem" datasource="#dts#">
 	SELECT itemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#"> and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getprice.itemno#"> and price_bil='#form.price_bil1#'
</cfquery>

<cfif checksamepricesameitem.recordcount neq 0>

<script type="text/javascript">
alert('Unable to change price due to there is already item with same price!')
ColdFusion.Window.hide('changeprice');
</script>

<cfelse>
<cfif isdefined('url.uuid') and isdefined('url.trancode')>
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


<cfloop query="getlocationgroupitem">

<cfquery name="updaterow" datasource="#dts#">
UPDATE ictrantemp SET 
price_bil = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.price_bil1),stDecl_UPrice)#">
WHERE 
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.itemno#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,currrate,price_bil,brem4,qty,qty_bil FROM ictrantemp WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfset qtyReal = val(getitemdetail.qty_bil)>

<cfif val(getitemdetail.currrate) eq 0>
<cfset newcurrate = 1>
<cfelse>
<cfset newcurrate = val(getitemdetail.currrate)>
</cfif>

<cfquery name="updateprice" datasource="#dts#">
UPDATE ictrantemp SET 
price = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getitemdetail.price_bil) * val(newcurrate),stDecl_UPrice)#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>


<cfset discountamount = 0 >
<cfif getitemdetail.brem4 neq "">
<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,qty_bil FROM ictrantemp
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationgroupitem.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
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
UPDATE ictrantemp SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#"
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

<script type="text/javascript">
calculatefooter();
refreshlist();
recalculateamt();
ColdFusion.Window.hide('changeprice');
</script>
</cfif>
</cfif>
</cfif>