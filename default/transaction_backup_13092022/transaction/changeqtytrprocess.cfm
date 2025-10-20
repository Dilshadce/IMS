<cfquery name="getprice" datasource="#dts#">
SELECT qty_bil FROM ictran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
and itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
</cfquery>

<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_Discount = getgsetup2.Decl_Discount>


<cfquery name="updaterow" datasource="#dts#">
UPDATE ictran SET 
qty_bil = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.qty_bil1),stDecl_UPrice)#">
WHERE 
itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and 
<cfif url.type eq 'TR' or url.type eq 'TROU'>
type in ('TROU','TRIN')
<cfelse>
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfif>
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,currrate,price_bil,taxpec1,price,price_bil,qty_bil FROM ictran WHERE 
itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfquery>

<cfset qtyReal = val(getitemdetail.qty_bil)>

<cfif val(getitemdetail.currrate) eq 0>
<cfset newcurrate = 1>
<cfelse>
<cfset newcurrate = val(getitemdetail.currrate)>
</cfif>

<cfquery name="updateprice" datasource="#dts#">
UPDATE ictran SET 
qty = <cfqueryparam cfsqltype="cf_sql_double" value="#qtyReal#">
WHERE 
itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and 

<cfif url.type eq 'TR' or url.type eq 'TROU'>
type in ('TROU','TRIN')
<cfelse>
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfif>
</cfquery>


<cfset discountamount = 0 >

<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,qty_bil FROM ictran
WHERE 
itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfquery>

    <cfset totpercent = val(getitemdetail.taxpec1)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset discountamount = numberformat(val(getprice.price_bil) * (totpercent/100),stDecl_UPrice) * val(qtyReal)>
        </cfif>


<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictran SET taxamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#"
WHERE 
itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and 
<cfif url.type eq 'TR' or url.type eq 'TROU'>
type in ('TROU','TRIN')
<cfelse>
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfif>
</cfquery>   

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictran SET 
amt_bil = round((price_bil * qty_bil)+0.000001,2),
amt1_bil = round((price_bil * qty_bil)+0.000001,2)
WHERE 
itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and 

<cfif url.type eq 'TR' or url.type eq 'TROU'>
type in ('TROU','TRIN')
<cfelse>
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfif>
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictran SET 
taxamt = (taxamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.itemcount)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and 

<cfif url.type eq 'TR' or url.type eq 'TROU'>
type in ('TROU','TRIN')
<cfelse>
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfif>
</cfquery>

<cfquery name="gettax" datasource="#dts#">
    	select sum(taxamt_bil) as tt_taxamt_bil from ictran where 
        <cfif url.type eq 'TR' or url.type eq 'TROU'>
        type in ('TROU','TRIN')
        <cfelse>
        type='#url.type#'
        </cfif>
        and refno='#url.refno#' and (void='' or void is null)
    </cfquery>
	<cfset gettax.tt_taxamt_bil=numberformat(val(gettax.tt_taxamt_bil),".__")>
    <cfquery name="updatetax" datasource="#dts#">
    	update artran set tax_bil='#val(gettax.tt_taxamt_bil)#' where 
        
        <cfif url.type eq 'TR' or url.type eq 'TROU'>
        type='TR'
        <cfelse>
        type='#url.type#'
        </cfif>
        and refno='#url.refno#'
    </cfquery>

<div style="width:1px; height:1px; overflow:scroll">
<cfif url.type eq 'TR' or url.type eq 'TROU'>
<cfset url.tran = 'TR'>
<cfelse>
<cfset url.tran = #url.type#>
</cfif>
<cfset url.ttype = "Edit">
<cfset url.refno = #url.refno#>
<cfset url.custno = #url.custno#>
<cfset url.first = 0>
<cfset url.jsoff = "true">
<cfinclude template="/default/transaction/iss2.cfm">
</div>

<input type="button" align="right" value="CLOSE" onClick="submitinvoice();">