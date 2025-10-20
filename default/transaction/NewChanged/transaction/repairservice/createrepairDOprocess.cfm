<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

	<cfquery name="getrepairservice" datasource="#dts#">
    select * from repairtran where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
    </cfquery>

    <!---If Header item not blank create RC--->
    
    
    <cfset ndate = createdate(right(form.dodate,4),mid(form.dodate,4,2),left(form.dodate,2))>
	<cfset wos_date = dateformat(ndate,'yyyy-mm-dd')>
    
    <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
        
        <cfquery name="checkexistrefno" datasource="#dts#">
    	select refno from artran where type='DO' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.repairno#">
    	</cfquery>
        <cfif checkexistrefno.recordcount eq 0>
        <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,created_by,userid,created_on,rem0,rem1,invgross,gross_bil,net,net_bil,grand,grand_bil)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="DO">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.repairno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        "Profile",
        "Profile",
        "#val(getrepairservice.grossamt)#",
        "#val(getrepairservice.grossamt)#",
        "#val(getrepairservice.grossamt)#",
        "#val(getrepairservice.grossamt)#",
        "#val(getrepairservice.grossamt)#",
        "#val(getrepairservice.grossamt)#"
        )
        </cfquery>
        
        <cfquery name="insertictran" datasource="#dts#">
            insert into ictran
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
                wos_date,
                fperiod,agenno
                )
                values
                (
                'DO',
                '#getrepairservice.repairno#',
                '#getrepairservice.custno#',
                1,1,
                '',
                '#getrepairservice.repairitem#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.desp#" />, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="" />, 
                '#getrepairservice.location#',
                1,
                0, 
                '',
                0,
                0,
                0,
                0,
                0,
                0, 
                '0',
                '',
                0.00000,
                1,
                0,
                  '',
                  '1',
                   '1',
                    0,
                    0,
                    0,
                    0.00000,
                    '',
                    '',
                      '', 
                      '0000-00-00', 
                      '', 
                      '', 
                      '', 
                      '', 
                      '', 
                      '', 
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
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
                      '#fperiod#',
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
                )
        </cfquery>
        
        <cfquery name="getrepairservicebody" datasource="#dts#">
        select * from repairdet where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
        </cfquery>
		<cfset ictrancode=2>
        
        <cfloop query="getrepairservicebody">
        
        <cfquery name="getitemdetail" datasource="#dts#">
            select '' as wos_group,'' as category,'' as despa,desp,'' as unit from icservi
            where servi = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservicebody.itemno#">
            union all
            select 
            wos_group,category,despa,desp,unit
            from icitem
            where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservicebody.itemno#">
        </cfquery>
        
        <cfquery name="insertictran" datasource="#dts#">
            insert into ictran
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
                wos_date,
                fperiod,
                agenno
                )
                values
                (
                'DO',
                '#getrepairservice.repairno#',
                '#getrepairservice.custno#',
                #ictrancode#,#ictrancode#,
                '',
                '#getrepairservicebody.itemno#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservicebody.desp#" />, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservicebody.despa#" />, 
                '#getrepairservice.location#',
                #numberformat(val(getrepairservicebody.qty_bil),'._____')#,
                #numberformat(val(getrepairservicebody.price_bil),'.______')#, 
                '#getitemdetail.unit#',
                 #numberformat(val(getrepairservicebody.amt_bil),'.__')#,
                #val(getrepairservicebody.dispec1)#,
                #val(getrepairservicebody.dispec2)#,
                #val(getrepairservicebody.dispec3)#,
                #numberformat(val(getrepairservicebody.disamt_bil),'._____')#,
                #numberformat(val(getrepairservicebody.amt_bil),'.__')#, 
                '0',
                '',
                0.00000,
                #numberformat(val(getrepairservicebody.qty_bil),'._____')#,
                 #numberformat(val(getrepairservicebody.price_bil),'.______')#,
                  '#getitemdetail.unit#',
                  '1',
                   '1',
                    #numberformat(val(getrepairservicebody.amt_bil),'.__')#,
                    #numberformat(val(getrepairservicebody.disamt_bil),'._____')#,
                    #numberformat(val(getrepairservicebody.amt_bil),'.__')#,
                    0.00000,
                    '',
                    '',
                      '', 
                      '0000-00-00', 
                      '', 
                      '', 
                      '', 
                      '#getitemdetail.wos_group#', 
                      '#getitemdetail.category#', 
                      '', 
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
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
                      '#fperiod#',
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
                )
        </cfquery>
        
        </cfloop>
        
        <cfquery name="updaterepairno" datasource="#dts#">
            update repairtran set 
            status='Done'
            where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.repairno#">
        </cfquery>
        
        <cfoutput>
        <cfset status='Delivery No #getrepairservice.repairno# created Successfully'>
        </cfoutput>
        <cfelse>
        <cfset status='The Delivery No already exited in system!'>
     </cfif>
   
	 <!---End Create RC--->
<cfoutput>
<script>
	alert('#status#');
	window.close();
	window.opener.location='/default/transaction/repairservice/s_repairservicetable.cfm';
</script>
</cfoutput>