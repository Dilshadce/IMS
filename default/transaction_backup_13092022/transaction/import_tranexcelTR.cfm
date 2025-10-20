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
<cfset consignment = url.consignment>

<cfquery name="getallbranch" datasource="#dts#">
select branch from icbranch order by branch
</cfquery>

<cfquery name="getallcust" datasource="#dts#">
select custno,name from #target_arcust# order by custno
</cfquery>

<cfparam name="importicitem" default="">
<cfparam name="DELETEICITEM" default="">

<body>
<cfform action="import_tranexcelTR.cfm?type=#type#&refno=#URLENCODEDFORMAT(refno)#&consignment=#consignment#" method="post" enctype="multipart/form-data">
<H1>Import EXCEL File To IMS</H1>
<table align="center" class="data">
		<tr>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/itembody.xls">itembody.xls</a></td>
    	</tr>
		<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT Item</strong></font></div></td></tr>
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
        <td>Get File (<cfoutput>itembody.xls</cfoutput>) From Local Disk</td>
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
		<cffile action = "delete" file = "C:\importtranbody\#dts#\itembody.xls">
		<h2>You have deleted item_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\importtranbody\#dts#\itembody.xls" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal">
		<h2>You have FTP item_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
    <cfquery name="truncatetemptable" datasource="#dts#">
			truncate ictran_excel
	</cfquery>
    
	<cfset filename="C:/importtranbody/#dts#/itembody.xls">
	<cftry>
		<cfinclude template = "import_tranexcelTR2.cfm">
	<cfcatch>
    <h3>Please wait 2min and try again.As the file is currently under progress</h3>
    <cfabort>
    </cfcatch>
    </cftry>
    
		<cfquery name="gettempitem" datasource="#dts#">
			select * from ictran_excel
		</cfquery>
        
        <cfquery name="getartrandetail" datasource="#dts#">
			select * from artran where refno='#refno#' and type='#type#'
		</cfquery>
        
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery name="getictrantrancode" datasource="#dts#">
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='TROU'
        </cfquery>
        <cfif getictrantrancode.recordcount eq 0 or getictrantrancode.trancode eq ''>
        <cfset trancode=1>
        <cfelse>
        <cfset trancode=val(getictrantrancode.trancode)+1>
        </cfif>
        
			<cfloop query="gettempitem">
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#gettempitem.itemno#'
            </cfquery>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            	<cfset price_bil=getitemdetail.price>
            <cfelse>
            	<cfset price_bil=gettempitem.price>
            </cfif>
            
            <cfif gettempitem.comment EQ ''>
            	<cfset comment=getitemdetail.comment>
            <cfelse>
            	<cfset comment=gettempitem.comment>
            </cfif>
            
            <cfset amt1_bil=(price_bil*gettempitem.qty)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(price_bil) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(price_bil)-((val(gettempitem.dispec1) / 100) * val(price_bil)))))*val(gettempitem.qty)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(price_bil)-((val(gettempitem.dispec1) / 100) * val(price_bil))-((val(gettempitem.dispec2) / 100) * (val(price_bil)-((val(gettempitem.dispec1) / 100) * val(price_bil)))))))*val(gettempitem.qty)>
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
            
             
            <cfset amt_bil=(price_bil*gettempitem.qty)-disamt_bil>
            <cfset taxamt_bil=(amt_bil/107)*(gettempitem.taxpec1)>
            
            
            <cfset pricelocal= price_bil>
            <cfset disamtlocal=disamt_bil>
            <cfset taxamtlocal=taxamt_bil>
            <cfset amt1local=amt1_bil>
            <cfset amtlocal=amt_bil>
            
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
        consignment
        )
        values
        (
        'TRIN',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.despa#', 
        '#getartrandetail.rem2#',
        #numberformat(val(gettempitem.qty),'._____')#,
        #numberformat(val(price_bil),'.__')#, 
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
        #numberformat(val(gettempitem.qty),'._____')#,
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
              '#gettempitem.brem1#', 
              '#gettempitem.brem2#', 
              '#gettempitem.brem3#', 
              '#gettempitem.brem4#', 
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
              '#comment#',
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
              '#consignment#'
        )
					</cfquery>
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
        consignment
        )
        values
        (
        'TROU',
        '#refno#',
        '#getartrandetail.custno#',
        #trancode#,#trancode#,
        '',
        '#getitemdetail.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.despa#', 
        '#getartrandetail.rem1#',
        #numberformat(val(gettempitem.qty),'._____')#,
        #numberformat(val(price_bil),'.__')#, 
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
        #numberformat(val(gettempitem.qty),'._____')#,
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
              '#gettempitem.brem1#', 
              '#gettempitem.brem2#', 
              '#gettempitem.brem3#', 
              '#gettempitem.brem4#', 
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
              '#comment#',
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
              '#consignment#'
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

			</cfloop>
		</cfif>
		
		<script language="javascript">
		<cfif listnotimported neq ''>
		<cfoutput>
		alert('Item No #listnotimported# is not imported because item or location does not exist in system.');
		</cfoutput>
		</cfif>
		window.close();

		window.opener.location.href="iss2.cfm?tran=#type#&ttype=Edit&refno=#refno#&custno=#getartrandetail.custno#&consignment=#consignment#&first=0&posttrue=1";
		
		</script>
        
</cfif>
</cfoutput>
</body>
</html>