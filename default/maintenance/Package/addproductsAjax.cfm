<cfsetting showdebugoutput="no">
<cfset itemno = URLDecode(url.itemno)>
<cfset desp = URLDecode(url.desp)>
<cfset itemdesp = URLDecode(url.itemdesp)>
<cfset itemdespa = URLDecode(url.itemdespa)>
<cfset amt = val(URLDecode(url.amt_bil))>
<cfset qty = val(URLDecode(url.qty_bil))>
<cfset price = val(URLDecode(url.price_bil))>
<cfset dispec1 = URLDecode(url.dispec1)>
<cfset dispec2 = URLDecode(url.dispec2)>
<cfset dispec3 = URLDecode(url.dispec3)>
<cfset dis = URLDecode(url.disamt_bil)>
<cfset packcode = URLDecode(url.packcode)>

<cfquery name="validitemexist" datasource="#dts#">
SELECT * from package where packcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#">
</cfquery>

<cfif validitemexist.recordcount eq 0>
<cfquery name="addpackage" datasource="#dts#">
insert into package (packcode,packdesp) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">)
</cfquery>
</cfif>

	<cfquery name="getmaxtrancode" datasource="#dts#">
		select max(trancode) as maxtrancode from packdet where packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#">
	</cfquery>
    <cfif getmaxtrancode.recordcount eq 0>
    <cfset trancode=1>
    <cfelse>
    <cfset trancode=val(getmaxtrancode.maxtrancode)+1>
    </cfif>

<cfquery name="selecticitem" datasource="#dts#">
SELECT * FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" >
</cfquery>

<cfset qtyReal = qty>

<cfquery name="insertictran" datasource="#dts#">
	insert into packdet
	(
		packcode,
        trancode,
        itemno,
        desp,
        despa,
        qty_bil,
        price_bil,
        dispec1,
        dispec2,
        dispec3,
        disamt_bil,
        amt_bil,
        taxpec1,
        taxpec2,
        taxpec3,
        taxamt_bil,
        note_a
        )
        values
        (
        '#packcode#',
        #trancode#,
        '#itemno#', 
        '#REReplace(itemdesp,"925925925925","%","ALL")#', 
        '#REReplace(itemdespa,"925925925925","%","ALL")#',
        #numberformat(val(qty),'._____')#,
        #numberformat(val(price),'.__')#, 
        #val(dispec1)#,
        #val(dispec2)#,
        #val(dispec3)#,
        #numberformat(val(dis),'._____')#,
        #numberformat(val(amt),'.__')#, 
        '0',
        '0',
        '0',
        0.00000,
        ''
        )
</cfquery>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as totalamt,count(itemno) as countitemno FROM packdet where packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#" />
</cfquery>

<cfquery name="addpackage" datasource="#dts#">
update package set grossamt="#numberformat(val(getsum.totalamt),'.__')#" where packcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.totalamt,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
</cfoutput>

