<html>
<head>
<title>IMPORT EXCEL FILE TO IMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select * from gsetup
</cfquery>

<cfset listnotimported=''>

<cfset refno = urldecode(url.refno)>
<cfset type = url.type>

<cfquery name="getallbranch" datasource="#dts#">
select branch from icbranch order by branch
</cfquery>

<cfquery name="getallcust" datasource="#dts#">
select custno,name from #target_arcust# order by custno
</cfquery>

<cfparam name="importicitem" default="">
<cfparam name="DELETEICITEM" default="">

<body>
<cfform action="import_tranexcelSO.cfm?type=#type#&refno=#URLENCODEDFORMAT(refno)#" method="post" enctype="multipart/form-data">
<H1>Import EXCEL File To IMS</H1>
<table align="center" class="data">
	    <tr>
        <td>Type</td>
        <td>
        <cfoutput>
       #type#
        </cfoutput>
        </td>
    </tr>
    <tr>
        <td>Ref No</td>
        <td>
        <cfoutput>
       	#refno#
        </cfoutput>
        </td>
    </tr>
    <tr>
        <td>Get File (<cfoutput>itembodySO.xls</cfoutput>) From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="geticitem" size="25">
        </font></td>
    </tr>
    <tr>
        <td>Price take item profile price</td>
        <td><font size="2">
        	<input type="checkbox" name="itemprice" id="itemprice" value="1">
        </font></td>
    </tr>
	<tr>
        <td>Import into Database</td>
        <td><font size="2">
        <input type="submit" name="importicitem" value="Import Item">
        </font></td>
    </tr>
</table>
</cfform>
<cfoutput>

<cfif importicitem eq 'Import Item'>
<cfset currentDirectory = "C:\importtranbody\#dts#">
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>

	<cftry>
		<cffile action = "delete" file = "C:\importtranbody\#dts#\itembodySO.xls">
		<h2>You have deleted item_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\importtranbody\#dts#\itembodySO.xls" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal">
		<h2>You have FTP item_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
    <cfquery name="truncatetemptable" datasource="#dts#">
			truncate ictran_excel3
	</cfquery>
    
	<cfset filename="C:/importtranbody/#dts#/itembodySO.xls">

		<cfinclude template = "import_tranexcelSO2.cfm">
	
    <!--- F Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyF!='' and qtyF!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-F'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyF)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyF)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyF)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyF)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyF)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyF),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyF),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyF)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyF)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyF)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyF)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyF)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyF),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyF),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-F">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-F">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
		
        <!--- XXXS Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty3XS!='' and qty3XS!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-XXS'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty3XS)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty3XS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty3XS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty3XS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty3XS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty3XS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty3XS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty3XS)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty3XS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty3XS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty3XS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty3XS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty3XS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty3XS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-3XS">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-3XS">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        
        <!--- XXS Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyXXS!='' and qtyXXS!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-XXS'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXXS)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXXS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXXS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXXS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXXS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXXS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXXS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXXS)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXXS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXXS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXXS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXXS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXXS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXXS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-XXS">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-XXS">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        
        <!--- XS Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyXS!='' and qtyXS!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-XS'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXS)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXS)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-XS">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-XS">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        
        <!--- S Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyS!='' and qtyS!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-S'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyS)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyS)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyS)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyS)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyS)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyS)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyS),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyS),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-S">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-S">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- M Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyM!='' and qtyM!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-M'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyM)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyM)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyM)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyM)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyM)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyM),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyM),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyM)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyM)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyM)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyM)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyM)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyM),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyM),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-M">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-M">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- L Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyL!='' and qtyL!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-L'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyL)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyL)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-L">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-L">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- XL Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyXL!='' and qtyXL!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-XL'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXL)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXL)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-XL">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-XL">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- XXL Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qtyXXL!='' and qtyXXL!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-XXL'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXXL)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXXL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXXL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXXL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXXL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXXL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXXL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qtyXXL)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qtyXXL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qtyXXL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qtyXXL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qtyXXL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qtyXXL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qtyXXL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-XXL">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-XXL">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- XXXL Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty3XL!='' and qty3XL!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-XXL'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty3XL)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty3XL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty3XL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty3XL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty3XL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty3XL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty3XL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty3XL)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty3XL)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty3XL)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty3XL)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty3XL)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty3XL),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty3XL),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-3XL">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-3XL">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        
        <!--- 3 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty3!='' and qty3!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-03'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty3)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty3)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty3)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty3)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty3)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty3),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty3),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty3)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty3)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty3)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty3)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty3)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty3),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty3),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-03">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-03">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 4 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty4!='' and qty4!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-04'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty4)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty4)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty4)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty4)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty4)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty4),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty4),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty4)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty4)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty4)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty4)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty4)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty4),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty4),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-04">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-04">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 5 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty5!='' and qty5!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-05'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty5)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty5)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty5)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty5)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty5)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty5),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty5),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty5)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty5)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty5)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty5)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty5)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty5),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty5),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-05">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-05">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 6 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty6!='' and qty6!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-06'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty6)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty6)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty6)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty6)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty6)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty6),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty6),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty6)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty6)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty6)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty6)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty6)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty6),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty6),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-06">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-06">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 7 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty7!='' and qty7!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-07'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty7)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty7)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty7)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty7)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty7)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty7),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty7),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty7)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty7)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty7)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty7)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty7)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty7),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty7),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-07">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-07">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 8 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty8!='' and qty8!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-08'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty8)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty8)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty8)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty8)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty8)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty8),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty8),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty8)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty8)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty8)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty8)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty8)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty8),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty8),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-08">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-08">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 9 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty9!='' and qty9!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-09'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty9)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty9)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty9)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty9)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty9)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty9),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty9),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty9)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty9)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty9)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty9)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty9)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty9),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty9),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-09">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-09">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 10 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty10!='' and qty10!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-10'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty10)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty10)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty10)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty10)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty10)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty10),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty10),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty10)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty10)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty10)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty10)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty10)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty10),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty10),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-10">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-10">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 11 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty11!='' and qty11!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-11'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty11)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty11)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty11)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty11)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty11)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty11),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty11),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty11)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty11)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty11)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty11)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty11)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty11),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty11),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-11">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-11">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        
        <!--- 12 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty12!='' and qty12!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-12'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty12)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty12)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty12)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty12)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty12)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty12),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty12),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty12)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty12)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty12)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty12)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty12)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty12),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty12),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-12">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-12">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 37 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty37!='' and qty37!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-37'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty37)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty37)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty37)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty37)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty37)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty37,
        qty37,
        qty37,
        qty37,
        qty37,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty37),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty37),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty37)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty37)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty37)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty37)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty37)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty37,
        qty37,
        qty37,
        qty37,
        qty37,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty37),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty37),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-37">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-37">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 38 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty38!='' and qty38!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-38'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty38)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty38)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty38)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty38)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty38)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty38,
        qty38,
        qty38,
        qty38,
        qty38,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty38),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty38),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty38)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty38)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty38)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty38)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty38)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty38,
        qty38,
        qty38,
        qty38,
        qty38,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty38),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty38),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-38">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-38">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 39 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty39!='' and qty39!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-39'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty39)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty39)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty39)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty39)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty39)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty39,
        qty39,
        qty39,
        qty39,
        qty39,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty39),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty39),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty39)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty39)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty39)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty39)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty39)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty39,
        qty39,
        qty39,
        qty39,
        qty39,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty39),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty39),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-39">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-39">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 40 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty40!='' and qty40!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-40'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty40)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty40)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty40)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty40)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty40)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty40,
        qty40,
        qty40,
        qty40,
        qty40,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty40),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty40),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty40)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty40)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty40)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty40)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty40)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty40,
        qty40,
        qty40,
        qty40,
        qty40,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty40),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty40),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-40">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-40">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 41 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty41!='' and qty41!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-41'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty41)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty41)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty41)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty41)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty41)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty41,
        qty41,
        qty41,
        qty41,
        qty41,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty41),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty41),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty41)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty41)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty41)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty41)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty41)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty41,
        qty41,
        qty41,
        qty41,
        qty41,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty41),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty41),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-41">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-41">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 42 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty42!='' and qty42!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-42'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty42)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty42)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty42)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty42)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty42)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty42,
        qty42,
        qty42,
        qty42,
        qty42,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty42),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty42),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty42)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty42)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty42)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty42)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty42)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty42,
        qty42,
        qty42,
        qty42,
        qty42,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty42),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty42),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-42">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-42">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 43 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty43!='' and qty43!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-43'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty43)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty43)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty43)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty43)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty43)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty43,
        qty43,
        qty43,
        qty43,
        qty43,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty43),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty43),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty43)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty43)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty43)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty43)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty43)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty43,
        qty43,
        qty43,
        qty43,
        qty43,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty43),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty43),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-43">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-43">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
        <!--- 44 Size--->
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel3 where (qty44!='' and qty44!=0)
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
        </cfquery>

        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=getictrantrancode.trancode+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#-#gettempitem.color#-44'
            </cfquery>
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty44)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty44)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty44)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty44)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty44)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty44,
        qty44,
        qty44,
        qty44,
        qty44,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty44),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty44),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported=gettempitem.itemno>
            <cfelse>
            <cfset listnotimported=listnotimported&','&gettempitem.itemno>
            </cfif>
            </cfif>
            <!--- Location not blank---->
            
            <cfelse>
            
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#gettempitem.location#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0 and getlocation.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty44)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty44)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty44)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty44)>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>

        <cfelse>

<cfset disamt_bil1 = (val(gettempitem.dispec1) / 100) * amt1_bil>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (val(gettempitem.dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (val(gettempitem.dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt_bil3>
<cfset disamt_bil = disamt_bil1 + disamt_bil2 + disamt_bil3>
</cfif>
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty44)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= gettempitem.price*getartrandetail.currrate>
            <cfset disamtlocal=disamt_bil*getartrandetail.currrate>
            <cfset taxamtlocal=taxamt_bil*getartrandetail.currrate>
            <cfset amt1local=amt1_bil*getartrandetail.currrate>
            <cfset amtlocal=amt_bil*getartrandetail.currrate>
            
					<cfquery name="insert" datasource="#dts#">
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
        qty44,
        qty44,
        qty44,
        qty44,
        qty44,
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
        taxincl
        )
        values
        (
        '#type#',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#gettempitem.location#',
        #numberformat(val(gettempitem.qty44),'._____')#,
        #numberformat(val(gettempitem.price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(amt1_bil),'.__')#,
        '#numberformat(val(gettempitem.dispec1),'.__')#',
        '#numberformat(val(gettempitem.dispec2),'.__')#',
        '#numberformat(val(gettempitem.dispec3),'.__')#',
        '#numberformat(val(disamt_bil),'.__')#',
        #numberformat(val(amt_bil),'.__')#, 
        '#numberformat(val(gettempitem.taxpec1),'.__')#',
        '',
        '#numberformat(val(taxamt_bil),'.__')#',
        #numberformat(val(gettempitem.qty44),'._____')#,
         #numberformat(val(pricelocal),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(amt1local),'.__')#,
            #numberformat(val(disamtlocal),'.__')#,
            #numberformat(val(amtlocal),'.__')#,
            #numberformat(val(taxamtlocal),'.__')#,
            '#gettempitem.note_a#',
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
              'T'
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            <cfelse>
            <cfif listnotimported eq ''>
            <cfset listnotimported="#gettempitem.itemno#-#gettempitem.color#-44">
            <cfelse>
            <cfset listnotimported=listnotimported&','&"#gettempitem.itemno#-#gettempitem.color#-44">
            </cfif>
            </cfif>
            </cfif>
			</cfloop>
		</cfif>
        
		<script language="javascript">
		<cfif listnotimported neq ''>
		<cfoutput>
		alert('Item No #listnotimported# is not imported because item or location does not exist in system.');
		</cfoutput>
		</cfif>
		window.close();
		window.opener.releaseDirtyFlag();
		window.opener.location.href="../tran_edit2.cfm?tran=#type#&ttype=Edit&refno=#refno#&custno=#getartrandetail.custno#&first=0&posttrue=1";
		</script>
        
</cfif>
</cfoutput>
</body>
</html>