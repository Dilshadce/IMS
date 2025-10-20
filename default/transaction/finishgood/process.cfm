<cfif isdefined('url.proceess')>
<script type="text/javascript">
alert('1');
</script>
</cfif>

<cfif isdefined('form.arid') eq false>
<cfquery name="insertar" datasource="#dts#">
INSERT INTO finishedgoodar (project,itemno,quantity,created_by,created_on,location)
VALUES (
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#form.quantity#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">)
</cfquery>

<cfquery name="getlastid" datasource="#dts#">
SELECT LAST_INSERT_ID() as lastid
</cfquery>
<cfset lastid = getlastid.lastid>
<cfelse>

<cfset lastid = form.arid>
<cfquery name="getfinishgood" datasource="#dts#">
SELECT * FROM finishedgoodar WHERE id = "#lastid#"
</cfquery>
<cfset form.sono = getfinishgood.project>
<cfset form.itemno = form.itemno>
<cfset form.quantity = form.quantity>

<cfquery name="updatear" datasource="#dts#">
UPDATE finishedgoodar SET 
itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">,
quantity = <cfqueryparam cfsqltype="cf_sql_double" value="#form.quantity#">
WHERE id = "#lastid#"
</cfquery>

<cfquery name="delete" datasource="#dts#">
DELETE FROM finishedgoodic WHERE arid = "#lastid#"
</cfquery>

</cfif>

<cfquery name="getictran" datasource="#dts#">
SELECT itemno,sum(qty) as qty,refno,job,batchcode as brem1,batchcode,type,trancode,price from ictran where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#"> 
and fperiod<>'99'
and (void = '' or void is null)
and (linecode <> 'SV' or linecode is null)
and type = "inv"
group by itemno,batchcode
</cfquery>
<cfset itemvalue = 0>
<cfloop query="getictran">
<cfset fieldname = "_#trim(getictran.itemno)#_#getictran.batchcode#">

<cfset fieldname = replace(fieldname,'-','_','all')>
<cfset fieldname = replace(fieldname,'+','_','all')>
<cfset usedqtyfield = "usedqty#fieldname#">
<cfif isdefined("form.#usedqtyfield#")>
<cfif huserid eq 'ultralung'>
<cfoutput>
#form.usedqty_H_CS_3988_602_L1_3000_HA_#
evaluate('form.#usedqtyfield#')
</cfoutput>
</cfif>

<cfset usedqty = evaluate('form.#usedqtyfield#')>
<cfset status = evaluate('form.status#fieldname#')>
<cfset rejectqty = evaluate('form.rejectqty#fieldname#')>
<cfset rejectcode = evaluate('form.rejectcode#fieldname#')>
<cfset returnquantityfield = "rejectcode#fieldname#">
<cfif isdefined('form.#returnquantityfield#')>
<cfset returnqty = evaluate('form.returnqty#fieldname#')>
<cfelse>
<cfset returnqty = 0>
</cfif>
<cfelse>
<cfset usedqty = 0>
</cfif>

<cfset writeoffqtyfield = "writeoffqty#fieldname#">
<cfif isdefined("form.#writeoffqtyfield#")>
<cfset writeoffqty = evaluate('form.#writeoffqtyfield#')>
<cfelse>
<cfset writeoffqty = 0>
</cfif>


<cfif val(usedqty) neq 0 or val(writeoffqty) neq 0>
<cfset itemvalue = itemvalue +( val(usedqty) * val(getictran.price))>
<cfquery name="insertic" datasource="#dts#">
INSERT INTO finishedgoodic(arid,refno,job,brem1,type,trancode,status,itemno,usedqty,rejectqty,rejectcode,returnqty,writeoffqty,created_by,created_on,batchcode,project)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#lastid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.job#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.brem1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.trancode#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#status#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(usedqty)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(rejectqty)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rejectcode#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(returnqty)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(writeoffqty)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.batchcode#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">
)
</cfquery>
</cfif>
</cfloop>

<cfif isdefined('url.process')>
<cfset itemprice = val(itemvalue)/val(form.quantity)>

<cfquery datasource="#dts#" name="getGeneralInfo">
    select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
    from refnoset
    where type = 'RC'
    and counter = '1'
</cfquery>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(now(),'yyyy-mm-dd')#" returnvariable="fperiod"/>

<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
		from refnoset
		where type = 'RC'
		and counter = 1
	</cfquery>

<cfset refnocheck = 0>
<cfset refno1 = getGeneralInfo.tranno>
<cfloop condition="refnocheck eq 0">
<cftry>
<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
<cfcatch>
<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />	
</cfcatch>
</cftry>
<cfquery name="checkexistence" datasource="#dts#">
SELECT refno FROM artran WHERE 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = 'rc'
</cfquery>
<cfif checkexistence.recordcount eq 0>
<cfset refnocheck = 1>
<cfelse>
<cfset refno1 = refno>
</cfif>
</cfloop>

<cfquery name="getcurrcode" datasource="#dts#">
SELECT bcurr FROM gsetup
</cfquery>
<cfset currencycode = getcurrcode.bcurr>

<cfquery name="insertrc" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="ASSM/999">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'YYYY-MM-DD')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="Finished Good">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(itemvalue),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now(),
"",
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currencycode#">
)
</cfquery>


<cfquery name="getitemdesp" datasource="#dts#">
SELECT desp,despa,unit,wos_group,category FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
</cfquery>

<cfquery name="getgeneralmail" datasource="main">
select useremail from users where userDept = "#dts#" and userGrpId="Delivery" and useremail <> ""
</cfquery>
<cfset email1=''>
<cfloop query="getgeneralmail">
<cfset email1=email1&getgeneralmail.useremail>
<cfif getgeneralmail.recordcount neq getgeneralmail.currentrow>
<cfset email1=email1&",">
</cfif>
</cfloop>

<cfif email1 neq ''>

<cfoutput>
<cftry>
<cfmail from="noreply@mynetiquette.com" to="#email1#" 
			subject="Finish Goods-#refno#"
		>
This message was sent by an automatic mailer built with cfmail:
= = = = = = = = = = = = = = = = = = = = = = = = = = =

Finish Goods has been created
Goods Receipt No      :#refno#
FG Code.   :#form.itemno#
SO No	   :#form.sono#
Description:#getitemdesp.desp#
Qty        :#form.quantity#

</cfmail>
<cfcatch>
</cfcatch></cftry>
</cfoutput>

</cfif>


<cfquery name="insertic" datasource="#dts#">
insert into ictran
	(
    	wos_date,
    	fperiod,
        source,
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
        mc7_bil
        )
        values
        (
        "#dateformat(now(),'YYYY-MM-DD')#",
        '#fperiod#',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
        'RC',
        '#refno#',
        'ASSM/999',
        1,1,
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdesp.desp#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdesp.despa#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,
        <cfqueryparam cfsqltype="cf_sql_double" value="#form.quantity#">,
        #numberformat(val(itemprice),'.__')#, 
        '#getitemdesp.unit#',
         #numberformat(val(itemvalue),'.__')#,
        0,
        0,
        0,
        0,
        #numberformat(val(itemvalue),'.__')#, 
        '0',
        '0',
        0.00000,
        <cfqueryparam cfsqltype="cf_sql_double" value="#form.quantity#">,
         #numberformat(val(itemprice),'.__')#,
          '#getitemdesp.unit#',
          '1',
           '1',
            #numberformat(val(itemvalue),'.__')#,
            0,
            #numberformat(val(itemvalue),'.__')#,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '#getitemdesp.wos_group#', 
              '#getitemdesp.category#', 
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
              0.00000
        )
</cfquery>

<cfquery name="updatercno" datasource="#dts#">
update finishedgoodar SET rcno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,fperiod="#fperiod#"
WHERE id = "#lastid#"
</cfquery>

<cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
    where type = 'RC'
	and counter = 1
    </cfquery>
<!---Return Bill ---->
<cfset returnexistcheck=0>
<cfset totalamountreturnbill=0>

<cfset refnocheck = 0>
<cfset refno1 = getGeneralInfo.tranno>
<cfloop condition="refnocheck eq 0">
<cftry>
<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refnonew"/>
<cfcatch>
<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refnonew" />	
</cfcatch>
</cftry>
<cfquery name="checkexistence" datasource="#dts#">
SELECT refno FROM artran WHERE 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#"> and type = 'rc'
</cfquery>
<cfif checkexistence.recordcount eq 0>
<cfset refnocheck = 1>
<cfelse>
<cfset refno1 = refnonew>
</cfif>
</cfloop>
<cfset newtrancode=1>
<cfloop query="getictran">
<cfset fieldname = "_#trim(getictran.itemno)#_#getictran.batchcode#">
<cfset fieldname = replace(fieldname,'-','_','all')>
<cfset fieldname = replace(fieldname,'+','_','all')>
<cfset totalreturnqty=0>
<cfset totalreturnamt=0>
<cfset returnqty= 0>
<cfset returnquantityfield = "returnqty#fieldname#">
<cfif isdefined('form.#returnquantityfield#')>
<cfset returnqty= evaluate('form.returnqty#fieldname#')>
</cfif>
<cfset totalreturnqty=returnqty>
<cfset totalreturnamt=getictran.price*totalreturnqty>
<cfset totalamountreturnbill=totalamountreturnbill+totalreturnamt>

<cfif totalreturnqty gt 0>
<cfset returnexistcheck=1>

<cfquery name="getcurrcode" datasource="#dts#">
SELECT bcurr FROM gsetup
</cfquery>
<cfset currencycode = getcurrcode.bcurr>

<cfquery name="getitemdesp" datasource="#dts#">
SELECT desp,despa,unit,wos_group,category FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#">
</cfquery>

<cfquery name="insertic" datasource="#dts#">
insert into ictran
	(
    	wos_date,
    	fperiod,
        source,
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
        mc7_bil
        )
        values
        (
        "#dateformat(now(),'YYYY-MM-DD')#",
        '#fperiod#',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
        'RC',
        '#refnonew#',
        'ASSM/999',
        '#newtrancode#','#newtrancode#',
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.itemno#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdesp.desp#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdesp.despa#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,
        <cfqueryparam cfsqltype="cf_sql_double" value="#totalreturnqty#">,
        #numberformat(val(getictran.price),'.__')#, 
        '#getitemdesp.unit#',
         #numberformat(val(totalreturnamt),'.__')#,
        0,
        0,
        0,
        0,
        #numberformat(val(totalreturnamt),'.__')#, 
        '0',
        '0',
        0.00000,
        <cfqueryparam cfsqltype="cf_sql_double" value="#totalreturnqty#">,
         #numberformat(val(getictran.price),'.__')#,
          '#getitemdesp.unit#',
          '1',
           '1',
            #numberformat(val(totalreturnamt),'.__')#,
            0,
            #numberformat(val(totalreturnamt),'.__')#,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '#getitemdesp.wos_group#', 
              '#getitemdesp.category#', 
              '#rejectcode#', 
              'Return Products', 
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
              0.00000
        )
</cfquery>
    
</cfif>

<cfset newtrancode=newtrancode+1>

</cfloop>

<cfif returnexistcheck eq 1>
<cfquery name="insertrc" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="ASSM/999">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'YYYY-MM-DD')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="Finished Good">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountreturnbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now(),
"",
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currencycode#">
)
</cfquery>

<cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
    where type = 'RC'
	and counter = 1
    </cfquery>

</cfif>


<!---reject Bill ---->
<cfset rejectexistcheck=0>
<cfset totalamountrejectbill=0>

<cfset refnocheck = 0>
<cfset refno1 = getGeneralInfo.tranno>
<cfloop condition="refnocheck eq 0">
<cftry>
<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refnonew2"/>
<cfcatch>
<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refnonew2" />	
</cfcatch>
</cftry>
<cfquery name="checkexistence" datasource="#dts#">
SELECT refno FROM artran WHERE 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew2#"> and type = 'rc'
</cfquery>
<cfif checkexistence.recordcount eq 0>
<cfset refnocheck = 1>
<cfelse>
<cfset refno1 = refnonew2>
</cfif>
</cfloop>
<cfset newtrancode=1>
<cfloop query="getictran">
<cfset fieldname = "_#trim(getictran.itemno)#_#getictran.batchcode#">
<cfset fieldname = replace(fieldname,'-','_','all')>
<cfset fieldname = replace(fieldname,'+','_','all')>
<cfset totalrejectqty=0>
<cfset totalrejectamt=0>
<cfset rejectqty= 0>
<cfif isdefined("form.rejectqty#fieldname#")>
<cfset rejectqty = evaluate('form.rejectqty#fieldname#')>
<cfset rejectcode = evaluate('form.rejectcode#fieldname#')>
</cfif>
<cfset totalrejectqty=rejectqty>
<cfset totalrejectamt=getictran.price*totalrejectqty>
<cfset totalamountrejectbill=totalamountrejectbill+totalrejectamt>

<cfif totalrejectqty gt 0>
<cfset rejectexistcheck=1>

<cfquery name="getcurrcode" datasource="#dts#">
SELECT bcurr FROM gsetup
</cfquery>
<cfset currencycode = getcurrcode.bcurr>

<cfquery name="getitemdesp" datasource="#dts#">
SELECT desp,despa,unit,wos_group,category FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rejectcode#">
</cfquery>

<cfquery name="insertic" datasource="#dts#">
insert into ictran
	(
    	wos_date,
    	fperiod,
        source,
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
        mc7_bil
        )
        values
        (
        "#dateformat(now(),'YYYY-MM-DD')#",
        '#fperiod#',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
        'RC',
        '#refnonew2#',
        'ASSM/999',
        '#newtrancode#','#newtrancode#',
        '',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#rejectcode#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdesp.desp#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdesp.despa#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,
        <cfqueryparam cfsqltype="cf_sql_double" value="#totalrejectqty#">,
        #numberformat(val(getictran.price),'.__')#, 
        '#getitemdesp.unit#',
         #numberformat(val(totalrejectamt),'.__')#,
        0,
        0,
        0,
        0,
        #numberformat(val(totalrejectamt),'.__')#, 
        '0',
        '0',
        0.00000,
        <cfqueryparam cfsqltype="cf_sql_double" value="#totalrejectqty#">,
         #numberformat(val(getictran.price),'.__')#,
          '#getitemdesp.unit#',
          '1',
           '1',
            #numberformat(val(totalrejectamt),'.__')#,
            0,
            #numberformat(val(totalrejectamt),'.__')#,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '#getitemdesp.wos_group#', 
              '#getitemdesp.category#', 
              '#rejectcode#', 
              'Rejected Products', 
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
              0.00000
        )
</cfquery>
    
</cfif>

<cfset newtrancode=newtrancode+1>

</cfloop>

<cfif rejectexistcheck eq 1>
<cfquery name="insertrc" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="RC">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="ASSM/999">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(),'YYYY-MM-DD')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="Finished Good">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalamountrejectbill),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now(),
"",
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currencycode#">
)
</cfquery>

<cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew2#">
    where type = 'RC'
	and counter = 1
    </cfquery>

</cfif>




<script type="text/javascript">
alert('Finished Good Generate Successfully!');
window.location.href="listfinish.cfm";
</script>
<cfelse>
<script type="text/javascript">
alert('Finished Good Save Successfully!');
window.location.href="listfinish.cfm";
</script>
</cfif>