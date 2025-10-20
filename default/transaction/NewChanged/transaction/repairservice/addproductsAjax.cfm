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
<cfset repairno = URLDecode(url.repairno)>

<cfset wos_date = URLDecode(url.wos_date)>
<cfset custno = URLDecode(url.custno)>
<cfset name = URLDecode(url.name)>
<cfset completedate = URLDecode(url.completedate)>
<cfset repairitem = URLDecode(url.repairitem)>

<cfset ndate = createdate(right(wos_date,4),mid(wos_date,4,2),left(wos_date,2))>
<cfset ncompletedate = createdate(right(completedate,4),mid(completedate,4,2),left(completedate,2))>


<cfquery name="validitemexist" datasource="#dts#">
SELECT * from repairtran where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">
</cfquery>

<cfif validitemexist.recordcount eq 0>
<cfquery name="addrepair" datasource="#dts#">
insert into repairtran (repairno,wos_date,custno,name,completedate,repairitem,desp) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">,'#dateformat(ndate,'YYYY-MM-DD')#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#name#">,'#dateformat(ncompletedate,'YYYY-MM-DD')#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairitem#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">)
</cfquery>
</cfif>

	<cfquery name="getmaxtrancode" datasource="#dts#">
		select max(trancode) as maxtrancode from repairdet where repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">
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
	insert into repairdet
	(
		repairno,
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
        '#repairno#',
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
SELECT SUM(amt_bil) as totalamt,count(itemno) as countitemno FROM repairdet where repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#" />
</cfquery>

<cfquery name="addrepairage" datasource="#dts#">
update repairtran set grossamt="#numberformat(val(getsum.totalamt),'.__')#" where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.totalamt,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
</cfoutput>

