<cfif isdefined('form.invoiceno')>
    
<cfquery name="gettaxitem" datasource="#dts#">
SELECT taxitemid FROM taxmethoditem WHERE taxmethodid = 3
</cfquery> 
    
<cfset monthzerotax = "Jun,Jul,Aug">
    
<cfloop index="a" list="#replace(form.invoiceno,' ','')#">
    
<cfquery name="updaterate" datasource="#dts#">
set @invnoitem='#trim(a)#'
</cfquery>

<cfquery name="updaterate" datasource="#dts#">
Update ictran
					set 
                    taxpec1=0,
                    note_a="OS",
                    taxamt=0,
                    taxamt_bil=0
					where refno = @invnoitem and type='INV'
</cfquery>

<cfquery name="updaterate" datasource="#dts#">
Update ictran
					set
                    taxpec1=6.00,
                    note_a="SR",
                        taxamt=round((round(coalesce(amt,'0')+0.000001,2) * 6/100)+0.000001,2),
                        taxamt_bil=round((round(coalesce(amt,'0')+0.000001,2) * 6/100)+0.000001,2)
					where refno = @invnoitem
                    and type='INV'
                    and replace(itemno,'other - ','') in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettaxitem.taxitemid)#" separator="," list="yes">)
</cfquery>

<cfquery name="updaterate" datasource="#dts#">
Update ictran
                set 
                taxpec1=6.00,
                note_a="SR",
                    taxamt=round((round(coalesce(amt,'0')+0.000001,2) * 6/100)+0.000001,2),
                    taxamt_bil=round((round(coalesce(amt,'0')+0.000001,2) * 6/100)+0.000001,2)
                where refno = @invnoitem
                and type='INV'
                and itemno = "adminfee"
</cfquery>
    
    
<cfloop index='aa' list="#monthzerotax#">
    
<cfquery name="updaterate" datasource="#dts#">
    Update ictran
    set 
    taxpec1=0,
    note_a="OS",
    taxamt=0,
    taxamt_bil=0
    where refno = @invnoitem and type='INV'
    and right(brem3,8) = "#aa# 2018"
</cfquery>
    
<cfquery name="updaterate" datasource="#dts#">
Update ictran
					set
                    taxpec1=0.00,
                    note_a="SR",
                        taxamt=0.00,
                        taxamt_bil=0.00
					where refno = @invnoitem
                    and type='INV'
                    and replace(itemno,'other - ','') in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettaxitem.taxitemid)#" separator="," list="yes">)
                    and right(brem3,8) = "#aa# 2018"
</cfquery>

<cfquery name="updaterate" datasource="#dts#">
Update ictran
                set 
                taxpec1=0.00,
                note_a="SR",
                    taxamt=0.00,
                    taxamt_bil=0.00
                where refno = @invnoitem
                and type='INV'
                and itemno = "adminfee"
                and right(brem3,8) = "#aa# 2018"
</cfquery>
    
</cfloop>

<cfquery name="getSum_ictran" datasource="#dts#">
update artran a, (select refno,type,sum(amt_bil) AS sumAmt
            FROM ictran where (void='' or void is null)  group by type,refno) b
set gross_bil = b.sumAmt
    where a.type = b.type
            AND a.refno =b.refno and a.refno=@invnoitem
</cfquery>
    
<cfquery name="updateSum_artran" datasource="#dts#">
update artran
set tax_bil = 0.00
    where refno=@invnoitem
</cfquery>

<cfquery name="updateSum_artran" datasource="#dts#">
update artran a, (select refno,type,sum(amt_bil) AS sumAmt
            FROM ictran where (void='' or void is null) and taxpec1=6 group by type,refno) b
set tax_bil = round(cast(b.sumAmt*0.06 as decimal(15,5)),2)
    where a.type = b.type
            AND a.refno =b.refno and a.refno=@invnoitem
</cfquery>
    
<cfquery name="updateNet_artran" datasource="#dts#">
UPDATE artran
            SET
            	net_bil = gross_bil - disc_bil
            WHERE refno=@invnoitem
</cfquery>

<cfquery name="updateGrand_artran" datasource="#dts#">
UPDATE artran
            SET
        		grand_bil = net_bil+tax_bil,
        		tax1_bil = tax_bil
WHERE refno=@invnoitem
</cfquery>

<cfquery name="updaterate" datasource="#dts#">
UPDATE artran
            SET 
            	grand = grand_bil / currrate ,
                net = net_bil / currrate,
                invgross = gross_bil / currrate,
                tax = tax_bil / currrate,
                tax1 = tax1_bil
WHERE refno=@invnoitem
</cfquery>
    
</cfloop>
    
    <div style="color: red">Done.</div>

</cfif>

<form id="form" name="form" action="setinvoice2itemizedtax.cfm" method="post">
    <h2>Recalculate Invoice to Itemized Rate (Service Tax)</h2>
    <label>Invoice No. :</label>
    <input type="text" id="invoiceno" name="invoiceno" value=""><br>
    <input type="submit" id="submit" name="submit" value="Submit">
</form>

