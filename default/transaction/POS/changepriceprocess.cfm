<cfquery name="getprice" datasource="#dts#">
SELECT price_bil FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
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

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="updaterow" datasource="#dts#">
UPDATE ictrantemp SET 
price_bil = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.price_bil1),stDecl_UPrice)#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,currrate,price_bil,brem4,dispec1,dispec2,dispec3,qty,qty_bil FROM ictrantemp WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
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
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>


<cfset discountamount = 0 >  

<cfset realamount = numberformat(val(getitemdetail.price_bil) * val(qtyReal),stDecl_UPrice)>

<cfset disamt_bil1 = (val(getitemdetail.dispec1) / 100) * realamount>
<cfset netamttemp = realamount - disamt_bil1>
<cfset disamt_bil2 = (val(getitemdetail.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(getitemdetail.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset adiscountamount = disamt_bil1 + disamt_bil2 + disamt_bil3>

<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictrantemp SET disamt_bil = "#numberformat(val(adiscountamount),stDecl_UPrice)#"
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery> 



<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantemp SET 
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,3),
amt1_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,3)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictrantemp SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,3),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,3)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfif getgsetup.wpitemtax eq "1">
	<cfquery name="updateictrantax" datasource="#dts#">
	UPDATE ictrantemp SET
        <cfif getgsetup.taxincluded eq "Y">
        TAXAMT_BIL=round((AMT_BIL*(taxpec1/(taxpec1+100))),3),
        TAXAMT=round((AMT*(taxpec1/(taxpec1+100))),3),
        taxincl="T"
        <cfelse>
        TAXAMT_BIL=round((AMT_BIL*(taxpec1/100)),3),
        TAXAMT=round((AMT*(taxpec1/100)),3)
        </cfif>
        where 
        uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
	</cfquery>
</cfif>



<script type="text/javascript">
calculatefooter();
refreshlist();
recalculateamt();
ColdFusion.Window.hide('changeprice');
</script>
</cfif>
</cfif>