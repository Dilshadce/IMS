<cfif url.action eq "create">

<cfquery name="selectictran" datasource="#dts#">
SELECT trancode FROM tradeintemp where uuid = "#url.uuid#" order by trancode desc
</cfquery>
<cfquery name="selecticitem" datasource="#dts#">
SELECT unit,unit2,unit3,unit4,unit5,unit6,factor1,factor2,factorU3_a,factorU3_b,factorU4_a,factorU4_b,factorU5_a,factorU5_b,factorU6_a,factorU6_b,desp,despa FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.servicecode)#" >
</cfquery>
<cfquery name='getGsetup' datasource='#dts#'>
  	SELECT df_salestax,df_purchasetax,bcurr
    FROM gsetup;
</cfquery>


<cfif selecticitem.recordcount neq 0>
<cfif selectictran.trancode eq "">
<cfset selectictran.trancode = 0>
</cfif>

<cfset url.servicecode = #URLDecode(url.servicecode)#>
<cfset qtyReal = val(url.expqty)>

<cfif url.unit neq "" and unit neq "#selecticitem.unit#">

<cfif url.unit eq "#selecticitem.unit2#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factor1) ) / val(selecticitem.factor2)>
<cfelseif url.unit eq "#selecticitem.unit3#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU3_a) ) / val(selecticitem.factorU3_b)>
<cfelseif url.unit eq "#selecticitem.unit4#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU4_a) ) / val(selecticitem.factorU4_b)>
<cfelseif url.unit eq "#selecticitem.unit5#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU5_a) ) / val(selecticitem.factorU5_b)>
<cfelseif url.unit eq "#selecticitem.unit6#">
<cfset qtyReal = ( val(url.expqty) * val(selecticitem.factorU6_a) ) / val(selecticitem.factorU6_b)>
</cfif>

</cfif>

<cfset trancode = val(selectictran.trancode) + 1>

<cfquery name="insertictran" datasource="#dts#">
	insert into tradeintemp 
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
        uuid
        )
        values
        (
        'RC',
        '',
        '4000/TI1',
        '',
        '0000-00-00',
        '1',
        #trancode#,#trancode#,
        '',
        '#URLDecode(url.servicecode)#', 
        '#selecticitem.desp#', 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#selecticitem.despa#">, 
        '', 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.location)#">,
        #numberformat(val(url.expqty),'._____')#,
        #numberformat(val(url.expprice),'.__')#, 
        '#url.unit#',
         #numberformat(val(url.expressamt),'.__')#,
        '0.00',
        '0.00',
        '0.00',
        #numberformat(val(url.dis),'._____')#,
        #numberformat(val(url.expressamt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(qtyReal),'._____')#,
         #numberformat(val(url.expprice),'.__')#,
          '#url.unit#',
          '1',
           '1',
            #numberformat(val(url.expressamt),'.__')#,
            #numberformat(val(url.dis),'._____')#,
            #numberformat(val(url.expressamt),'.__')#,
            0.00000,
            'NR',
            '',
             'Trade In',<!---Customer Name--->
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
              '#URLDecode(url.comment)#',
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
              '#uuid#'
        )
</cfquery>
</cfif>

<cfelseif url.action eq "delete">

<cfquery name="updaterow" datasource="#dts#">
DELETE FROM tradeintemp 
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
</cfquery>

<cfquery name="checkitemExist" datasource="#dts#">
select 
trancode 
from tradeintemp 
where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
order by trancode
</cfquery>
<cfif checkitemExist.recordcount gt 0>
<cfset itemcountlist = valuelist(checkitemExist.trancode)>

<cfloop index="i" from="1" to="#listlen(itemcountlist)#">
<cfif listgetat(itemcountlist,i) neq i>
<cfquery name="updateIctran" datasource="#dts#">
	update ictrantemp set 
	itemcount='#i#',
	trancode='#i#'
	where 
	uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
	and trancode='#listgetat(itemcountlist,i)#';
</cfquery>
</cfif>
</cfloop>
</cfif>




</cfif>

<cfquery name="gettotaltradein" datasource="#dts#">
	select sum(amt_bil) as totalamt from tradeintemp where uuid = "#url.uuid#" 
</cfquery>
<cfoutput>
<input type="hidden" name="hidtradein" id="hidtradein" value="#val(gettotaltradein.totalamt)#" />
</cfoutput>
<cfquery name="selectproducts" datasource="#dts#">
SELECT * FROM tradeintemp where uuid = "#url.uuid#" order by trancode
</cfquery>
<cfoutput>
<table width="750">
<tr>
<th width="50">No</th>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="50">Unit</th><th width="100">Price</th>
<th width="100" align="right">Amount</th>
<th width="100" align="right">Action</th>
</tr>
<cfset total = 0>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.trancode#</td>
<td>#selectproducts.itemno# <input type="button" name="addserial" id="addserial" value="S" onClick="PopupCenter('serial.cfm?tran=RC&nexttranno=&itemno=#URLEncodedFormat(itemno)#&itemcount=#trancode#&uuid=#uuid#&qty=#qty_bil#&custno=#custno#&price=#price#&location=#URLEncodedFormat(location)#','Add Serial','400','400');"></td>
<td>#selectproducts.desp#</td>
<td>#numberformat(selectproducts.qty_bil,'.__')#</td>
<td>#selectproducts.unit_bil#</td>
<td>#numberformat(selectproducts.price,'.__')#</td>
<td align="right">#numberformat(selectproducts.amt,'.__')#</td>
<td><input type="button" name="tradeindeletebtn#selectproducts.trancode#" id="tradeindeletebtn#selectproducts.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){tradeindeleterow('#selectproducts.trancode#')}" value="Delete"/></td>
<td></td>
</tr>
<cfset total = total + #numberformat(selectproducts.amt,'.__')# >
</cfloop>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th>Total :</th>
  <td align="right">#numberformat(total,'.__')#</td>
</tr>
</table>
</cfoutput>
