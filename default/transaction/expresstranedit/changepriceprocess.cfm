<cfquery name="getprice" datasource="#dts#">
SELECT price_bil FROM ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#"> and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
</cfquery>
<cfif val(getprice.price_bil) eq val(form.price_bil1)>
<script type="text/javascript">
calculatefooter();
refreshlist();
recalculateamt();
ColdFusion.Window.hide('changeprice');
</script>
<cfelse>
<cfif isdefined('url.trancode')>
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
price_bil = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(form.price_bil1),stDecl_UPrice)#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>

<cfquery name="getitemdetail" datasource="#dts#">
SELECT itemno,unit,currrate,price_bil,brem4,dispec1,dispec2,dispec3,qty,qty_bil FROM ictran WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>

<cfset qtyReal = val(getitemdetail.qty_bil)>

<cfif val(getitemdetail.currrate) eq 0>
<cfset newcurrate = 1>
<cfelse>
<cfset newcurrate = val(getitemdetail.currrate)>
</cfif>

<cfquery name="updateprice" datasource="#dts#">
UPDATE ictran SET 
price = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getitemdetail.price_bil) * val(newcurrate),stDecl_UPrice)#">
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>


<cfset discountamount = 0 >

<cfquery name="getprice" datasource="#dts#">
SELECT price_bil,qty_bil FROM ictran
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>

<cfset disamt_bil1 = (val(getitemdetail.dispec1) / 100) * (val(getprice.price_bil)* val(qtyReal))>
<cfset netamttemp = (val(getprice.price_bil)* val(qtyReal)) - disamt_bil1>
<cfset disamt_bil2 = (val(getitemdetail.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(getitemdetail.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset newdiscountamt = disamt_bil1 + disamt_bil2 + disamt_bil3>


<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictran SET disamt_bil = "#numberformat(val(newdiscountamt),stDecl_UPrice)#"
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>   




<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictran SET 
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2),
amt1_bil = round((price_bil * qty_bil)+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictran SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#"> and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.changepriceitemno#">
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>
<script type="text/javascript">
calculatefooter();
refreshlist();
recalculateamt();
ColdFusion.Window.hide('changeprice');
</script>
</cfif>
</cfif>