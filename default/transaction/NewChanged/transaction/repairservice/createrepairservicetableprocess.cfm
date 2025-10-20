<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfset ndate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfset ncompletedate = createdate(right(form.completedate,4),mid(form.completedate,4,2),left(form.completedate,2))>


<cfif form.mode eq "Create">
	<cfquery name="checkexist" datasource="#dts#">
    select * from repairtran where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
    </cfquery>
    
    <cfset repairno=form.repairno>
    
    <cfif checkexist.recordcount neq 0>
    
    	<cfset refnocheck = 0>
        <cfset repairno1 = checkexist.repairno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#repairno1#" returnvariable="repairno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#repairno1#" returnvariable="repairno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
      select * from repairtran where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset repairno1 = repairno>
		</cfif>
        </cfloop>
    
    </cfif>
    
    <cfquery name="insertrepairno" datasource="#dts#">
    insert into repairtran (repairno,wos_date,custno,name,completedate,repairitem,desp,location,deliverystatus,agent,rem5,rem6,rem7,rem8,rem9,rem10,rem11,status,add1,add2,add3,add4,phone,phonea,fax) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">,'#dateformat(ndate,'YYYY-MM-DD')#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,'#dateformat(ncompletedate,'YYYY-MM-DD')#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairitem#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deliverystatus#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem6#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem7#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem9#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem11#">,'Repair',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_phone#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_phone2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_fax#">)
	</cfquery>
    
    <!---If Header item not blank create RC--->
    <cfif form.repairitem neq ''>
    
    <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
    <!---
    <cfquery datasource="#dts#" name="getrunningrc">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = 'RC'
				and counter = '1'
		</cfquery>
    
	<cfquery name="checkexistrefno" datasource="#dts#">
    	select refno from artran where type='RC' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrunningrc.tranno#">
    </cfquery>
		<cfif checkexistrefno.recordcount neq 0>
        <cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = 'RC'
				and counter = '1'
		</cfquery>
        <cfset refnocheck = 0>
        <cfset refno1 = checkexistrefno.refno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = 'RC'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = refno>
		</cfif>
        </cfloop>
        </cfif>
        --->
        
        <cfquery name="checkexistrefno" datasource="#dts#">
    	select refno from artran where type='RC' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">
    	</cfquery>
        <cfif checkexistrefno.recordcount eq 0>
        <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,created_by,userid,created_on,rem0,rem1,rem5,rem6,rem7,rem8,rem9,rem10,rem11)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="4000/999">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(ndate,'yyyy-mm-dd')#">,
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
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem5#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem6#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem7#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem8#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem9#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem11#">
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
                agenno
                )
                values
                (
                'RC',
                '#repairno#',
                '4000/999',
                1,1,
                '',
                '#form.repairitem#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#" />, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="" />, 
                '#form.location#',
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
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
                )
        </cfquery>
     </cfif>
     </cfif>   
	 <!---End Create RC--->
    
    
	
	<cfset status="The Repair, #repairno# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
    	<cfcase value="Delete">
			<cfquery name="deleterepairno" datasource="#dts#">
            delete from repairtran 
            where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
            </cfquery>
            <cfquery name="deleterepairno2" datasource="#dts#">
            delete from repairdet 
            where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
        	</cfquery>
            <cfquery name="deleterepairno3" datasource="#dts#">
            delete from artran 
            where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
        	</cfquery>
            <cfquery name="deleterepairno4" datasource="#dts#">
            delete from ictran 
            where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
        	</cfquery>
        
        <cfset status="The Repair, #form.repairno# Has Been Deleted successfully !">
        
        </cfcase>
    
		<cfcase value="Edit">
			<cfquery name="updaterepairno" datasource="#dts#">
            update repairtran set 
            desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
            wos_date='#dateformat(ndate,'YYYY-MM-DD')#',
            custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
            name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
            completedate='#dateformat(ncompletedate,'YYYY-MM-DD')#',
            repairitem=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairitem#">,
            grossamt='#val(grossamt)#',
            agent=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">,
            rem5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem5#">,
            rem6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem6#">,
            rem7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem7#">,
            rem8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem8#">,
            rem9=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem9#">,
            rem10=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">,
            rem11=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem11#">,
            status='Repair',
            add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add1#">,
            add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add2#">,
            add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add3#">,
            add4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add4#">,
            phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_phone#">,
            phonea=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_phone2#">,
            fax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_fax#">
            
            where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
            </cfquery>
            
            
        <cfif form.repairitem neq ''>
    
    	<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
        
        <cfquery name="checkexistrefno" datasource="#dts#">
    	select refno from artran where type='RC' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
    	</cfquery>
        <cfif checkexistrefno.recordcount eq 0>
        <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,created_by,userid,created_on,rem0,rem1,rem5,rem6,rem7,rem8,rem9,rem10,rem11)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="4000/999">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(ndate,'yyyy-mm-dd')#">,
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
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem5#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem6#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem7#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem8#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem9#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem11#">
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
                agenno
                )
                values
                (
                'RC',
                '#form.repairno#',
                '4000/999',
                1,1,
                '',
                '#form.repairitem#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#" />, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="" />, 
                '#form.location#',
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
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
                )
        </cfquery>
     </cfif>
     </cfif>   
            
            
            
            
			<cfset status="The Receive has been created Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_repairservicetable.cfm?type=Package&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>