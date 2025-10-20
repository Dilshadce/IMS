<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

	<cfquery name="getrepairservice" datasource="#dts#">
    select * from repairtran where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
    </cfquery>

    <!---If Header item not blank create RC--->
    <cfif getrepairservice.repairitem neq '' and getrepairservice.custno neq ''>
    
    <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(getrepairservice.wos_date,'yyyy-mm-dd')#" returnvariable="fperiod"/>
        
        <cfquery name="checkexistrefno" datasource="#dts#">
    	select refno from artran where type='RC' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.repairno#">
    	</cfquery>
        <cfif checkexistrefno.recordcount eq 0>
        <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,created_by,userid,created_on,rem0,rem1)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.repairno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.repairno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="4000/999">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(getrepairservice.wos_date,'yyyy-mm-dd')#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        "Profile",
        "Profile"
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
                fperiod
                )
                values
                (
                'RC',
                '#getrepairservice.repairno#',
                '4000/999',
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
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(getrepairservice.wos_date,'yyyy-mm-dd')#">,
                      '#fperiod#'
                )
        </cfquery>
        
        <cfquery name="updaterepairno" datasource="#dts#">
            update repairtran set 
            status='Repair'
            where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrepairservice.repairno#">
        </cfquery>
        
        
        <cfoutput>
        <cfset status='Received No #getrepairservice.repairno# created Successfully'>
        </cfoutput>
        <cfelse>
        <cfset status='The Receive already exited in system!'>
     </cfif>
     	<cfelse>
        <cfset status='Please Key in Customer and Item!'>
     </cfif>   
	 <!---End Create RC--->
<cfoutput>
<script>
	alert('#status#');
	
	<cfif status eq 'Please Key in Customer and Item!'>
	window.location='/default/transaction/repairservice/createrepairservicetable.cfm?type=Edit&repairno=#getrepairservice.repairno#';
	<cfelse>
	window.opener.location='/default/transaction/repairservice/s_repairservicetable.cfm';
	window.close();
	</cfif>
</script>
</cfoutput>