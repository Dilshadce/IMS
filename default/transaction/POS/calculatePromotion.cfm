<cfsetting showdebugoutput="no">
<cfif isdefined('url.uuid')>
	<cfset url.uuid = URLDECODE(url.uuid)>
	<!--- <cfset url.coltype = URLDECODE(url.coltype)>
    <cfset url.qty = URLDECODE(url.qty)> --->
    
    <cfquery name="getgsetup2" datasource="#dts#">
        select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
               Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
               concat('.',repeat('_',Decl_Discount)) as Decl_Discount
        from gsetup2
    </cfquery>

	<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
    <cfset stDecl_Discount = getgsetup2.Decl_Discount>

    <cfquery name="getgsetup" datasource="#dts#">
        select * from gsetup
    </cfquery>

	<!--- <cfquery name="updaterow" datasource="#dts#">
        UPDATE ictrantemp 
        SET qty_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(url.qty)#">,
            brem1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.coltype#">
        WHERE trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
              and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
    </cfquery> --->
    
    <cfquery name="getitemdetail" datasource="#dts#">
        SELECT itemno,trancode,qty,unit,dispec1,dispec2,dispec3,price_bil 
        FROM ictrantemp 
        WHERE <!--- trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
        and ---> uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
    </cfquery>
    
    <cfloop query="getitemdetail">
        <cfquery name="selecticitem" datasource="#dts#">
            SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b 
            FROM icitem 
            where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.itemno#" >
        </cfquery>
    
        <!--- <cfset qtyReal = val(qty)> --->
        <cfset qtyReal = val(getitemdetail.qty)>
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
    
        <cfset discountamount = 0>
        <cfset realamount = numberformat(val(getitemdetail.price_bil) * val(qtyReal), stDecl_UPrice)>
        <cfset disamt_bil1 = (val(getitemdetail.dispec1) / 100) * realamount>
        <cfset netamttemp = realamount - disamt_bil1>
        <cfset disamt_bil2 = (val(getitemdetail.dispec2) / 100) * netamttemp>
        <cfset netamttemp = netamttemp - disamt_bil2>
        <cfset disamt_bil3 = (val(getitemdetail.dispec3) / 100) * netamttemp>
        <cfset netamttemp = netamttemp - disamt_bil3>
        <cfset adiscountamount = disamt_bil1 + disamt_bil2 + disamt_bil3>
    
        <cfquery name="updatediscountamount" datasource="#dts#">
            UPDATE ictrantemp 
            SET disamt_bil = "#numberformat(val(adiscountamount), stDecl_UPrice)#"
            WHERE trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.trancode#">
                  and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        </cfquery> 
    
        <cfquery name="updateictranqty" datasource="#dts#">
            UPDATE ictrantemp 
            SET qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qtyReal#">,
                amt_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,3),
                amt1_bil = round((price_bil * qty_bil)+0.000001 - disamt_bil,3)
            WHERE trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.trancode#">
                  and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        </cfquery>
    
        <cfquery name="updateamt" datasource="#dts#">
            UPDATE ictrantemp 
            SET disamt = (disamt_bil * if(currrate = 0,1,currrate)),
                amt = round((amt_bil * if(currrate = 0,1,currrate))+0.000001,3),
                amt1 = round((amt1_bil * if(currrate = 0,1,currrate))+0.000001,3)
            WHERE trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.trancode#">
                  and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        </cfquery>
    
        <cfif getgsetup.wpitemtax eq "1">
            <cfquery name="updateictrantax" datasource="#dts#">
                UPDATE ictrantemp 
                SET
                <cfif getgsetup.taxincluded eq "Y">
                    TAXAMT_BIL=round((AMT_BIL*(taxpec1/(taxpec1+100))),3),
                    TAXAMT=round((AMT*(taxpec1/(taxpec1+100))),3),
                    taxincl="T"
                <cfelse>
                    TAXAMT_BIL=round((AMT_BIL*(taxpec1/100)),3),
                    TAXAMT=round((AMT*(taxpec1/100)),3)
                </cfif>
                where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
                      and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdetail.trancode#">
            </cfquery>
        </cfif>
    </cfloop>
    
    <cfquery name="getsum" datasource="#dts#">
        SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran,sum(taxamt_bil) as sumtaxtotal 
        FROM ictrantemp 
        where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#" />
    </cfquery>
    
    <cfset footerdiscount =0>
    <cfset updatefooterdiscount=0>
    
    <cfquery name="getlastitemdetail" datasource="#dts#">
        SELECT itemno,trancode,qty,unit,dispec1,dispec2,dispec3,price_bil 
        FROM ictrantemp 
        WHERE <!--- trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
        and ---> uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
        order by trancode DESC 
        LIMIT 1
    </cfquery>
    
    <cfquery name="checkpromotion" datasource="#dts#">
        SELECT * 
        FROM promoitem as a right join promotion as b on a.promoid = b.promoid 
        WHERE a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlastitemdetail.itemno#"> and b.periodfrom <="#dateformat(now(),'yyyy-mm-dd')#" 
              and b.periodto >= "#dateformat(now(),'yyyy-mm-dd')#" and (b.customer='') 
              and (b.location like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#huserloc#%"> or b.location='' or b.location is null)  
        order by rangefrom * 1
    </cfquery>
    
    <cfif checkpromotion.type eq "buy" and checkpromotion.discby eq "amt" and checkpromotion.buydistype eq "totalqty">
        <cfloop query="checkpromotion">
            <cfquery name="getallpromotionitem" datasource="#dts#">
                SELECT itemno 
                FROM promoitem 
                where promoid = "#checkpromotion.promoid#"
            </cfquery>
            
            <cfset promoitemlist=valuelist(getallpromotionitem.itemno)>
        
            <cfquery name="getsumpromoqty" datasource="#dts#">
                select sum(qty_bil) as qty 
                from ictrantemp 
                where itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#promoitemlist#">) 
                      and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
            </cfquery>
        
            <cfif getsumpromoqty.qty lt checkpromotion.rangefrom>
                <cfbreak>
            <cfelse>
                <cfset footerdiscount =val(checkpromotion.priceamt)>
            </cfif>
        </cfloop>
        <cfset updatefooterdiscount=1>
    </cfif>
    
    <cfoutput>
    <input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
    <input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
    <input type="hidden" name="hidfooterdiscount" id="hidfooterdiscount" value="#numberformat(footerdiscount,'.__')#" />
    <input type="hidden" name="updatefooterdiscount" id="updatefooterdiscount" value="#updatefooterdiscount#" />
    <input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
    </cfoutput>
</cfif>