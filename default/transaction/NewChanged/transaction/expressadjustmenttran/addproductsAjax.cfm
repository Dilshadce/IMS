<cfsetting showdebugoutput="no">
<cfset itemno = URLDecode(url.itemno)>
<cfset desp = URLDecode(url.desp)>
<cfset qtyonhand = val(URLDecode(url.qtyonhand))>
<cfset qtyactual = val(URLDecode(url.qtyactual))>
<cfset qtydiff = val(URLDecode(url.qtydiff))>
<cfset ucost = val(URLDecode(url.ucost))>
<cfset unit = URLDecode(url.unit1)>
<cfset refno = URLDecode(url.refno)>
<cfset location = URLDecode(url.loc)>
<cfset date = URLDecode(url.date)>
<cfset period = URLDecode(url.period)>

<cfset date = createdate(right(date,4),mid(date,4,2),left(date,2))>

<!--- <cfset trancode = val(selectictran.trancode) + 1> --->
<cfquery name="checkitemexist" datasource="#dts#">
select itemno from locadjtran where refno='#refno#' and itemno='#itemno#' and uuid='#uuid#'
</cfquery>
<cfif checkitemexist.recordcount neq 0>
<h3>Item Existed</h3>
<cfelse>

<cfquery name="getmaxtrancode" datasource="#dts#">
select ifnull(max(trancode),0) as trancode from locadjtran where refno='#refno#' and uuid='#uuid#'
</cfquery>

<cfquery name="insertictran" datasource="#dts#">
	insert into locadjtran
	(
    	trancode,
		refno,
        itemno,
        desp,
        location,
        qtyonhand,
        qtyactual,
        qtydiff,
        unit,
        ucost,
        date,
        period,
        uuid,
        created_by,
        created_on
        )
        values
        (
        '#val(getmaxtrancode.trancode)+1#',
        '#refno#',
        '#itemno#',
        '#desp#',
        '#location#',
        '#qtyonhand#',
        '#qtyactual#',
        '#qtydiff#',
        '#unit#',
        '#ucost#',
        '#dateformat(date,'yyyy-mm-dd')#',
        '#period#',
        '#uuid#',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
		now()
        )
</cfquery>

</cfif>
