<cfsetting showdebugoutput="no">
<cfset itemno = URLDecode(url.itemno)>
<cfset desp = URLDecode(url.desp)>
<cfset qtyonhand = val(URLDecode(url.qtyonhand))>
<cfset qtyactual = val(URLDecode(url.qtyactual))>
<cfset qtydiff = val(URLDecode(url.qtydiff))>
<cfset ucost = val(URLDecode(url.ucost))>
<cfset unit = URLDecode(url.unit1)>
<cfset refno = URLDecode(url.refno)>
<cfset date = URLDecode(url.date)>
<cfset period = URLDecode(url.period)>

<cfset date = createdate(right(date,4),mid(date,4,2),left(date,2))>

<!--- <cfset trancode = val(selectictran.trancode) + 1> --->
<cfquery name="checkitemexist" datasource="#dts#">
select itemno from locadj where refno='#refno#' and itemno='#itemno#' and uuid='#uuid#'
</cfquery>
<cfif checkitemexist.recordcount neq 0>
<script type="text/javascript">
alert('Item no Existed');
</script>
<cfelse>
<cfquery name="insertictran" datasource="#dts#">
	insert into locadj
	(
		refno,
        itemno,
        desp,
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
        '#refno#',
        '#itemno#',
        '#desp#',
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
