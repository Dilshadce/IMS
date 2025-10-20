<html>
<head>
<title>IMPORT EXCEL FILE TO IMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getallbranch" datasource="#dts#">
select branch from icbranch order by branch
</cfquery>

<cfquery name="getallcust" datasource="#dts#">
select custno,name from #target_arcust# order by custno
</cfquery>

<cfparam name="importicitem" default="">
<cfparam name="DELETEICITEM" default="">

<body>
<cfform action="import_excel.cfm" method="post" enctype="multipart/form-data">
<H1>Import EXCEL File To IMS</H1>
<table align="center" class="data">
	<tr>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/item_simplysiti_i.xls">item_format.xls</a></td>
    </tr>
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT SALES</strong></font></div></td></tr>
    <tr>
        <td>Branch</td>
        <td>
        <cfoutput>
        <cfselect name="branch" required="yes" message="Please Choose a Branch"> 
        <cfloop query="getallbranch">
        <option value="#getallbranch.branch#">#getallbranch.branch#</option>
        </cfloop>
        </cfselect>
        </cfoutput>
        </td>
    </tr>
    <tr>
        <td>Customer No</td>
        <td>
        <cfoutput>
        <cfselect name="custno" required="yes" message="Please Choose a Customer"> 
        <cfloop query="getallcust">
        <option value="#getallcust.custno#">#getallcust.custno# #getallcust.name#</option>
        </cfloop>
        </cfselect>
        </cfoutput>
        </td>
    </tr>
    <tr>
        <td>Get File (<cfoutput>item_#dts#.xls</cfoutput>) From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="geticitem" size="25">
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
<cfset currentDirectory = "C:\simplysiti">
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>

	<cftry>
		<cffile action = "delete" file = "C:\simplysiti\item_#dts#.xls">
		<h2>You have deleted item_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\simplysiti\item_#dts#.xls" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal">
		<h2>You have FTP item_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
    <cfquery name="truncatetempitem" datasource="#dts#">
			truncate simplysiti_temp
		</cfquery>
    
	<cfset filename="C:/simplysiti/item_#dts#.xls">
	
		<cfinclude template = "import_excel2.cfm">
	
    

	
		<cfquery name="gettempitem" datasource="#dts#">
			select * from simplysiti_temp
		</cfquery>
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
        
        <cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = 'SAM'
			and counter = '1'
		</cfquery>
        
        <cfset refno=getGeneralInfo.tranno>
        
        <cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='SAM' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>

		<cfif checkexistrefno.recordcount neq 0>
        
        <cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = 'SAM'
				and counter = 1
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
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = 'SAM'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = refno>
		</cfif>
        </cfloop>
		</cfif>
        <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(now(),'yyyy-mm-dd')#" returnvariable="fperiod"/>
        <cfset wos_date = dateformat(now(),'yyyy-mm-dd')>
        
        <cfquery name="getitemtotal" datasource="#dts#">
			select sum(amt) as amt from simplysiti_temp
		</cfquery>
        
        <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SAM">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemtotal.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemtotal.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemtotal.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemtotal.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemtotal.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemtotal.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        'Profile',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
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
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0'
        )
        </cfquery>
        <cfquery datasource="#dts#" name="updatelastrefno">
			update refnoset set lastUsedNo='#refno#'
			where type = 'SAM'
			and counter = '1'
		</cfquery>
        
        <cfset trancode=1>
        <cfset itemnomatchlist=''>
			<cfloop query="gettempitem">
            <cfquery name="getitemno" datasource="#dts#">
            select itemno from icbranchitemno where branchitemno='#gettempitem.itemno#' and branch='#form.branch#'
            </cfquery>
            
            <cfquery name="getbranch" datasource="#dts#">
            select startwith from icbranch where branch='#form.branch#'
            </cfquery>
            
            <cfquery name="getlocation" datasource="#dts#">
            select location from iclocation where left(location,2)='#getbranch.startwith#' and substring_index(location,'_',-1)='#gettempitem.location#'
            </cfquery>
            
            <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#getitemno.itemno#'
            </cfquery>
            <cfif gettempitem.qty neq 0>
            <cfset price=gettempitem.amt/gettempitem.qty>
            </cfif>
            <cfif getitemno.recordcount eq 0 or getlocation.recordcount eq 0  or gettempitem.qty eq 0>
            <cfset itemnomatchlist=itemnomatchlist&","&gettempitem.itemno>
            <cfelse>
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
        mc7_bil,wos_date,fperiod
        )
        values
        (
        'SAM',
        '#refno#',
        '#custno#',
        #trancode#,#trancode#,
        '',
        '#getitemno.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#getlocation.location#',
        #numberformat(val(gettempitem.qty),'._____')#,
        #numberformat(val(price),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(gettempitem.amt),'.__')#,
        '0',
        '0',
        '0',
        '0',
        #numberformat(val(gettempitem.amt),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(gettempitem.qty),'._____')#,
         #numberformat(val(price),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(gettempitem.amt),'.__')#,
            '0',
            #numberformat(val(gettempitem.amt),'.__')#,
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
             
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">
        )
					</cfquery>
                    <cfset trancode=trancode+1>
            </cfif>
			</cfloop>
		</cfif>
		<h2>
            <cfif itemnomatchlist neq ''>
            Items that are not imported :<br> 
            #itemnomatchlist#
            </cfif>
		</h2>
	
</cfif>

<cfif deleteicitem eq 'Delete File'>
	<cftry>
		<cffile action = "delete" file = "C:\item_format_#dts#.xls">
		<h2>You have deleted item_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
</cfoutput>
</body>
</html>