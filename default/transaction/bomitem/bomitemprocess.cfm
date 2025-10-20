<cfif isdefined('form.bomitemno')>
<cfloop list="#form.bomitemno#" index="i" delimiters=",">
<cfset checkitemfield = "bomqty_"&i>
<cfset checkitemqty = form[checkitemfield]>
<cfset checklocationfield = "bomlocation_"&i>
<cfset checkitemlocation = form[checklocationfield]>
<cfset checkmultilocationuuidfield = "multilocationuuid_"&i>
<cfset checkmultilocationuuid = form[checkmultilocationuuidfield]>

<cfif checkmultilocationuuid eq "">
<cfif checkitemlocation neq ''>
<cfquery name="getlocationqtybal" datasource="#dts#">
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
			and itemno='#i#' 
       		and location='#checkitemlocation#' 
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
			and (toinv='' or toinv is null) 
			and fperiod<>'99'
			and itemno='#i#' 
       		and location='#checkitemlocation#' 

			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno='#i#' 
       	and a.location='#checkitemlocation#' 
        
        group by a.location,a.itemno
		order by a.location,a.itemno
</cfquery>

<cfif getlocationqtybal.balance lt checkitemqty>
<cfoutput>
<h3>Item No #i# does not have enough qty</h3>
<input type="button" name="close" value="close" onclick="ColdFusion.Window.hide('addbomitem');" />
</cfoutput>
<cfabort>
</cfif>
</cfif>
</cfif>

</cfloop>
</cfif>



<cfif isdefined('form.bomitemno')>
<cfset refno = form.refno>
<cfset type = form.type>
<cfset source = form.project>
<cfset itemno = form.itemno>
<cfset bomno = form.bomno>

<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM ictran where refno = "#refno#" and type = "#type#" order by trancode desc
</cfquery>

<cfquery name="insertrecord" datasource="#dts#">
INSERT INTO trackmrnqty (type,refno,bomno,qty) 
VALUES 
(
"#type#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#bomno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bomitemqty#">
)
</cfquery>

<cfquery name="selectartran" datasource="#dts#">
SELECT Fperiod,wos_date,currrate,agenno,name,van,custno,source,job from artran where refno = "#refno#" and type = "#type#"
</cfquery>
<cfif selectictran.trancode eq "">
<cfset selectictran.trancode = 0>
</cfif>

<cfset trancode = val(selectictran.trancode) + 1>

 <cfloop list="#form.bomitemno#" index="i" delimiters=",">
<cfset itemfield = "bomqty_"&i>
<cfset itemqty = form[itemfield]>
<cfset locationfield = "bomlocation_"&i>
<cfset itemlocation = form[locationfield]>
<cfset multilocationuuidfield = "multilocationuuid_"&i>
<cfset multilocationuuid = form[multilocationuuidfield]>
<cfif val(itemqty) neq 0>
    <cfquery name="getitem" datasource="#dts#">
    SELECT unit,price,desp,wos_group,category,shelf from icitem where itemno = <cfqueryparam value="#i#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfif multilocationuuid eq "">
    <!---single location --->
    <cfquery name="insertictran" datasource="#dts#">
	insert into ictran 
	(
		type,
        refno,
        custno,
        fperiod,
        wos_date,
        currrate,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        agenno,
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
        name,
        exported,
        exported1,
        sono,
        toinv,
        van,
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
        source,
        job
        )
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        '#selectartran.custno#',
        '#selectartran.Fperiod#',
         #selectartran.wos_date#,
        '#selectartran.currrate#',
        #trancode#,#trancode#,
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.desp#">, 
        '', 
        '#selectartran.agenno#', 
        '#itemlocation#',
        #val(itemqty)#,
        #numberformat(val(getitem.price),'.__')#, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,
         #numberformat(val(itemqty)*val(getitem.price),'.__')#,
        '0.00',
        '0.00',
        '0.00',
        0.00000,
        #numberformat(val(itemqty)*val(getitem.price),'.__')#, 
        '0',
        '',
        0.00000,
        #val(itemqty)#,
         #numberformat(val(getitem.price)* val(selectartran.currrate),'.__')#,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,
          '1',
           '1',
            #numberformat(val(itemqty)*val(getitem.price)* val(selectartran.currrate),'.__')#,
            0.00000,
            #numberformat(val(itemqty)*val(getitem.price)* val(selectartran.currrate),'.__')#,
            0.00000,
            '',
            '',
             '#selectartran.name#',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '#selectartran.van#', 
              '', 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.wos_group#">, 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.category#">, 
              '', 
              '#form.bomitemqty#', 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">, 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">, 
              '', 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.shelf#">,
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
              '',
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
              '#selectartran.source#',
              '#selectartran.job#'
        )
</cfquery>
<cfset trancode = trancode + 1>
<cfelse>
<!---multilocation --->

<cfquery name="getmultilocation" datasource="#dts#">
select * from tempmultilocation where uuid='#multilocationuuid#'
</cfquery>
<cfloop query="getmultilocation">

<cfquery name="insertictran" datasource="#dts#">
	insert into ictran 
	(
		type,
        refno,
        custno,
        fperiod,
        wos_date,
        currrate,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        agenno,
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
        name,
        exported,
        exported1,
        sono,
        toinv,
        van,
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
        source,
        job
        )
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        '#selectartran.custno#',
        '#selectartran.Fperiod#',
         #selectartran.wos_date#,
        '#selectartran.currrate#',
        #trancode#,#trancode#,
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.desp#">, 
        '', 
        '#selectartran.agenno#', 
        '#getmultilocation.location#',
        #val(getmultilocation.qty)#,
        #numberformat(val(getitem.price),'.__')#, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,
         #numberformat(val(getmultilocation.qty)*val(getitem.price),'.__')#,
        '0.00',
        '0.00',
        '0.00',
        0.00000,
        #numberformat(val(getmultilocation.qty)*val(getitem.price),'.__')#, 
        '0',
        '',
        0.00000,
        #val(getmultilocation.qty)#,
         #numberformat(val(getitem.price)* val(selectartran.currrate),'.__')#,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.unit#">,
          '1',
           '1',
            #numberformat(val(getmultilocation.qty)*val(getitem.price)* val(selectartran.currrate),'.__')#,
            0.00000,
            #numberformat(val(getmultilocation.qty)*val(getitem.price)* val(selectartran.currrate),'.__')#,
            0.00000,
            '',
            '',
             '#selectartran.name#',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '#selectartran.van#', 
              '', 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.wos_group#">, 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.category#">, 
              '', 
              '#form.bomitemqty#', 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">, 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">, 
              '', 
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.shelf#">,
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
              '',
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
              '#selectartran.source#',
              '#selectartran.job#'
        )
</cfquery>
<cfset trancode = trancode + 1>
</cfloop>

</cfif>
</cfif> 
</cfloop>
<div style="display:none">
<cfset url.tran = type>
<cfset url.ttype = "Edit">
<cfset url.refno = refno>
<cfset url.custno =selectartran.custno>
<cfset url.first = 0>
<cfset url.jsoff = "true">

<cfinclude template="/default/transaction/tran_edit2.cfm">
</div>

<cfoutput>
<h1>Generate Success!</h1>
<input type="button" align="right" value="CLOSE" onClick="releaseDirtyFlag();submitinvoice();">
</cfoutput>
<cfelse>
<cfoutput>
<h1>No Item Selected</h1>
</cfoutput>
</cfif>