<cfquery name="getprice" datasource="#dts#">
SELECT taxamt_bil FROM ictran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.trancode)#">
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
taxamt_bil = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.taxamt_bil1),stDecl_UPrice)#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.trancode)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,currrate,taxamt_bil,taxpec1,qty,qty_bil FROM ictran WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.trancode)#">
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
taxamt = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getitemdetail.taxamt_bil) * val(newcurrate),stDecl_UPrice)#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(url.trancode)#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfquery>

<cfquery name="gettax" datasource="#dts#">
    	select sum(taxamt_bil) as tt_taxamt_bil from ictran where type='#url.type#' and refno='#url.refno#' and (void='' or void is null)
    </cfquery>
	<cfset gettax.tt_taxamt_bil=numberformat(val(gettax.tt_taxamt_bil),".__")>
    <cfquery name="updatetax" datasource="#dts#">
    	update artran set tax_bil='#val(gettax.tt_taxamt_bil)#' where type='#url.type#' and refno='#url.refno#'
    </cfquery>

<div style="width:1px; height:1px; overflow:scroll">
<cfset url.tran = #url.type#>
<cfset url.ttype = "Edit">
<cfset url.refno = #url.refno#>
<cfset url.custno = #url.custno#>
<cfset url.first = 0>
<cfset url.jsoff = "true">
<cfinclude template="/default/transaction/tran_edit2.cfm">
</div>

<input type="button" align="right" value="CLOSE" onClick="releaseDirtyFlag();submitinvoice();">