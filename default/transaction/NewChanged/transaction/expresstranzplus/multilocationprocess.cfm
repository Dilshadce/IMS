<cfquery name="checkenable" datasource="#dts#">
select enabledetectrem1,itempriceprior from gsetup
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

<cfif val(multilocationtotallocation) neq 0>

<cfquery name="gettranrefno" datasource="#dts#">
	select type,refno,custno,name from ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">
</cfquery>

<cfloop from="1" to="#multilocationtotallocation#" index="i">

<cfset itemno = form.multilocationitemno>
<cfset price = form.multilocationprice_bil>
<cfset location = evaluate('form.multilocation_location_#i#')>
<cfset qty = evaluate('form.multilocation_qty_#i#')>

<cfquery name="getproductdetail" datasource="#dts#">
select * from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
</cfquery>

<cfset desp = getproductdetail.desp>
<cfset amt1 = price*qty>
<cfset unit = getproductdetail.unit>

<cfif val(qty) eq 0>
<!--- delete process---->
<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil 
FROM ictrantemp WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#"> and price_bil='#price#'
</cfquery>

<cfif validitemexist.recordcount neq 0>

<cfquery name="deleteictrantemp" datasource="#dts#">
delete FROM ictrantemp WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#"> and price_bil='#price#'
</cfquery>

</cfif>

<cfquery name="checkitemExist" datasource="#dts#">
select 
itemcount 
from ictrantemp 
where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">
</cfquery>
<cfif checkitemExist.recordcount gt 0>
<cfset itemcountlist = valuelist(checkitemExist.itemcount)>

<cfloop index="i" from="1" to="#listlen(itemcountlist)#">
<cfif listgetat(itemcountlist,i) neq i>
<cfquery name="updateIctran" datasource="#dts#">
	update ictrantemp set 
	itemcount='#i#',
	trancode='#i#'
	where 
	uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">
	and itemcount='#listgetat(itemcountlist,i)#';
</cfquery>
</cfif>
</cfloop>
</cfif>


<!---end delete--->
<cfelse>

<cfquery name="validitemexist" datasource="#dts#">
SELECT trancode,itemno,qty_bil,price_bil
FROM ictrantemp WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#"> and price_bil='#price#'
</cfquery>

<cfset dispec1=0>
<cfset discountamount=0>

<cfif form.multilocationdiscount neq "">

	<cfif right(form.multilocationdiscount,1) eq "%">
    <cfset totpercent = val(url.brem4)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset adiscountamount = numberformat(val(price) * ((100-totpercent)/100),stDecl_UPrice) * val(qty)>
        <cfset discountamount = numberformat(val(price),stDecl_UPrice) * val(qty) - val(adiscountamount)>
        </cfif>
    <cfelse>
    <cfset totdis = val(form.multilocationdiscount)>
        <cfif totdis lte val(price)>
        <cfset adiscountamount =numberformat( val(price) - val(totdis),stDecl_UPrice) * val(qty)>
        <cfset discountamount = numberformat(val(price),stDecl_UPrice) * val(qty) - val(adiscountamount)>
        </cfif>
    </cfif>
</cfif>

<cfif right(form.multilocationdiscount,1) eq "%">
<cfset dispec1=val(form.multilocationdiscount)>
</cfif>

<cfif validitemexist.recordcount neq 0>

<cfquery name="updatediscountamount" datasource="#dts#">
UPDATE ictrantemp SET disamt_bil = "#numberformat(val(discountamount),stDecl_UPrice)#",
brem4 = "#form.multilocationdiscount#"
<cfif right(form.multilocationdiscount,1) eq "%">
,dispec1='#val(form.multilocationdiscount)#'
</cfif>
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">
</cfquery>   

<cfquery name="updateictranqty" datasource="#dts#">
UPDATE ictrantemp SET 
qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qty#">,
qty_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qty#">,
amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2),
amt1_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictrantemp SET 
disamt = (disamt_bil * if(currrate = 0,1,currrate)),
amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,2),
amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,2)
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#validitemexist.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">
</cfquery>

<cfelse>

<cfquery name="gettrancode" datasource="#dts#">
    select 
    ifnull(max(trancode),0) as trancode
    from ictrantemp 
    where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">
</cfquery>

<cfset desp = getproductdetail.desp>
<cfset qtyReal = qty>
<cfset amt=amt1-discountamount>

<cfquery name="insertictran" datasource="#dts#">
	insert into ictrantemp
	(
		type,
        refno,
        custno,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        location,
        qty_bil,
        price_bil,
        unit_bil,
        amt1_bil,
        dispec1,
        dispec2,
        dispec3,
        disamt_bil,
        amt_bil,
		taxpec1,
        gltradac,
        taxamt_bil,
        qty,
        price,
        unit,
        factor1,
        factor2,
        amt1,
        disamt,
        amt,
        taxamt,
        note_a,
		dono,
        exported,
        exported1,
        sono,
        toinv,
        generated,
        wos_group,
        category,
        brem1,
        brem2,
        brem3,
        brem4,
        packing,
        shelf,
        supp,
        qty1,
        qty2,
        qty3,
        qty4,
        qty5,
        qty6,
        qty7,
        trdatetime,
        sv_part,
        sercost,
        userid,
        sodate,
        dodate,
        adtcost1,
        adtcost2,
        batchcode,
        expdate,
        mc1_bil,
        mc2_bil,
        defective,
        nodisplay,
        title_id,
        title_desp,
        comment,
        m_charge1,
        m_charge2,
        m_charge3,
        m_charge4,
        m_charge5,
        m_charge6,
        m_charge7,
       	mc3_bil,
        mc4_bil,
        mc5_bil,
        mc6_bil,
        mc7_bil,
        uuid
        )
        values
        (
        '#gettranrefno.type#',
        '#gettranrefno.refno#',
        '#gettranrefno.custno#',
        #gettrancode.trancode+1#,#gettrancode.trancode+1#,
        '',
        '#itemno#', 
        '#REReplace(desp,"925925925925","%","ALL")#', 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getproductdetail.despa#" />, 
        '#location#',
        #numberformat(val(qty),'._____')#,
        #numberformat(val(price),'.__')#, 
        '#unit#',
         #numberformat(val(amt1),'.__')#,
        #val(dispec1)#,
        0,
        0,
        #numberformat(val(discountamount),'._____')#,
        #numberformat(val(amt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(price),'.__')#,
          '#unit#',
          '1',
           '1',
            #numberformat(val(amt1),'.__')#,
            #numberformat(val(discountamount),'._____')#,
            #numberformat(val(amt),'.__')#,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '#getproductdetail.wos_group#', 
              '#getproductdetail.category#', 
              '#getproductdetail.barcode#', 
              '', 
              '', 
              '', 
              '', 
              '',
              '', 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              now(),
              '',
              0.00000,
              '#huserid#',
              '0000-00-00',
              '0000-00-00', 
              0.00000, 
              0.00000,
              '',
              '0000-00-00',
              0.00000, 
              0.00000,
              '',
              'N',
              '',
              '',
              '#tostring(getproductdetail.comment)#',
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              '#multilocationuuid#'
        )
</cfquery>
</cfif>




</cfif>

</cfloop>
</cfif>


<script type="text/javascript">
calculatefooter();
refreshlist();
recalculateamt();
ColdFusion.Window.hide('multilocationwindow');
</script>
<!---

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
</cfoutput>--->