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
<cfform action="import_tranexcelCN.cfm?type=#type#&refno=#URLENCODEDFORMAT(refno)#" method="post" enctype="multipart/form-data">
<H1>Import EXCEL File To IMS</H1>
<table align="center" class="data">
	    <tr>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="itembodyCN.xls">itembodyCN.xls</a></td>
    	</tr>
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
        <td>Get File (<cfoutput>itembodyCN.xls</cfoutput>) From Local Disk</td>
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
		<cffile action = "delete" file = "C:\importtranbody\#dts#\itembodyCN.xls">
		<h2>You have deleted item_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	

		<CFFILE DESTINATION="C:\importtranbody\#dts#\itembodyCN.xls" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal">
		<h2>You have FTP item_format_#dts#.xls successfully.</h2>

	
    <cfquery name="truncatetemptable" datasource="#dts#">
			truncate ictran_excel
	</cfquery>
   
	<cfset filename="C:/importtranbody/#dts#/itembodyCN.xls">
	<cftry>
		<cfinclude template = "import_tranexcelCN2.cfm">
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
        	select max(trancode) as trancode from ictran where refno='#refno#' and type='#type#'
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
            
            <!---IF location is blank---->
            
            <cfif gettempitem.location eq ''>
            
            <cfif getitemdetail.recordcount neq 0>
            
            <cfif isdefined('form.itemprice')>
            <cfset price_bil=getitemdetail.price>
            <cfelse>
            <cfset price_bil=gettempitem.price>
            </cfif>
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty)>
            
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty)>
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
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty)-disamt_bil>
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
        #numberformat(val(gettempitem.qty),'._____')#,
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
            <cfset amt1_bil=(gettempitem.price*gettempitem.qty)>
<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
<cfset disamt_bil1 = numberformat(((round(val(((val(gettempitem.dispec1) / 100) * val(gettempitem.price) * -1*100)))/100)
*-1),'.__')*val(gettempitem.qty)>
<cfset netamttemp = amt1_bil - disamt_bil1>
<cfset disamt_bil2 = (numberformat((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))*val(gettempitem.qty)>
<cfset netamttemp = netamttemp - disamt_bil2>
<cfset disamt_bil3 = (numberformat((val(gettempitem.dispec3) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price))-((val(gettempitem.dispec2) / 100) * (val(gettempitem.price)-((val(gettempitem.dispec1) / 100) * val(gettempitem.price)))))))*val(gettempitem.qty)>
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
            
             
            <cfset amt_bil=(gettempitem.price*gettempitem.qty)-disamt_bil>
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
        #numberformat(val(gettempitem.qty),'._____')#,
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