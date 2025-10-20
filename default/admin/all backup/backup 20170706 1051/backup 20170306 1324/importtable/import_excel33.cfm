<html>
<head>
<title>IMPORT EXCEL FILE TO IMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<!--- SUBMIT --->
<cfparam name="submiticitem" default="">
<cfparam name="submitarcust" default="">
<cfparam name="submitapvend" default="">
<body>
<form action="import_excel33.cfm" method="post" enctype="multipart/form-data">
<H1>Import EXCEL File To IMS</H1>
<H1>*Please download latest excel format from step 1 for data import.</H1>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT ITEM</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th><cfoutput>item_format_#dts#.xls</cfoutput></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/item_format.xls" target="_blank">item_format.xls</a>
        <br>
        <a href="export_itemexcel.cfm" target="_blank">Excel With Item</a>
        </td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Get File <b>(<cfoutput>item_format_#dts#.xls</cfoutput>) </b>From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="geticitem" size="25">
        </font></td>
    </tr>
	<tr>
    	<td colspan="3" align="center"><font size="2">
        <input type="submit" name="submiticitem" value="Submit">
        </font></td>
    </tr>
</table>
<br>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT CUSTOMER</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th><cfoutput>cust_format_#dts#.xls</cfoutput></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/cust_format.xls" target="_blank">cust_format.xls</a>
        <br>
        <a href="export_custsuppexcel.cfm?type=debtor" target="_blank">Excel With Customer</a></td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Get File <b>(<cfoutput>cust_format_#dts#.xls</cfoutput>)</b> From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="getarcust" size="25">
        </font></td>
    </tr>
	<tr>
    	<td colspan="3" align="center"><font size="2">
        <input type="submit" name="submitarcust" value="Submit">
        </font></td>
    </tr>
</table>
<br>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT SUPPLIER</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th><cfoutput>supp_format_#dts#.xls</cfoutput></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/supp_format.xls" target="_blank">supp_format.xls</a><br>
        <a href="export_custsuppexcel.cfm?type=creditor" target="_blank">Excel With Supplier</a></td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Get File <b>(<cfoutput>supp_format_#dts#.xls</cfoutput>)</b> From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="getapvend" size="25">
        </font></td>
    </tr>
	<tr>
    	<td colspan="3" align="center"><font size="2">
        <input type="submit" name="submitapvend" value="Submit">
        </font></td>
    </tr>
</table>
</form>
<cfoutput>
<cfif submiticitem eq 'Submit'>
	<cftry>
		<cffile action = "delete" file = "C:\item_format_#dts#.xls">
		<h2>You have deleted item_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\item_format_#dts#.xls" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal">
		<h2>You have FTP item_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	<cfset filename="C:/item_format_#dts#.xls">
	<!---<cftry>--->
		<cfinclude template = "import_excel2.cfm">
	<!---<cfcatch type="any">
	</cfcatch>
	</cftry>--->
	<cftry>
		<cfquery name="gettempitem" datasource="#dts#">
			select * from icitem_temp
			where status='' and itemno<>''
		</cfquery>
		<cfset count=0>
		<cfset count1=0>
		<cfif gettempitem.recordcount neq 0>
			<cfloop query="gettempitem">
				<cfquery name="checkexist" datasource="#dts#">
					select itemno from icitem
					where itemno ='#gettempitem.itemno#'
				</cfquery>
				<cfset thisstatus="I">	<!--- STATUS=I:IMPORTED; E:EXIST; U:UPDATED --->
				<cfset thisid=gettempitem.id>
				<cfif checkexist.recordcount eq 0>
					<cfquery name="insert" datasource="#dts#">
						insert into icitem
						(`ITEMNO`,`DESP`,`DESPA`, `AITEMNO`,`BRAND`,`SUPP`,
						`CATEGORY`,`WOS_GROUP`,`SIZEID`, `COSTCODE`,`COLORID`,
						 `SHELF` ,`PACKING`,`UNIT2`, `MINIMUM` , `MAXIMUM` , `REORDER`,
						`UNIT`,`UCOST`,`PRICE`,`PRICE2`,`PRICE3`,`PRICE4`,`WSERIALNO`,`GRADED`,
						`QTY2`,`QTY3`,`QTY4`,`QTY5`,`QTY6`,`QTYBF`,
						`SALEC`,`SALECSC`,`SALECNC`,`PURC`,`PURPREC`,`CREATED_BY`,`CREATED_ON`,`factor1`,`factor2`,`priceu2`,`remark1`,`wos_date`,`barcode`,`custprice_rate`,`fcurrcode`,`fucost`,`fprice`,`fcurrcode2`,`fucost2`,`fprice2`,`fcurrcode3`,`fucost3`,`fprice3`,`fcurrcode4`,`fucost4`,`fprice4`,`fcurrcode5`,`fucost5`,`fprice5`,`itemtype`,`comment`,`NONSTKITEM`)
						values
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.itemno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.desp#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.despa#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.aitemno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.brand#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.supp#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.category#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.wos_group#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.sizeid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.costcode#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.colorid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.shelf#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.packing#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.unit2#">,
						'#gettempitem.minimum#','#gettempitem.maximum#','#gettempitem.reorder#',
						'#gettempitem.unit#','#gettempitem.ucost#','#gettempitem.price#',
						'#gettempitem.price2#','#gettempitem.price3#',
						'#gettempitem.price4#','#gettempitem.wserialno#','#gettempitem.graded#',
						'#gettempitem.qty2#','#gettempitem.qty3#','#gettempitem.qty4#','#gettempitem.qty5#','#gettempitem.qty6#',
						'#gettempitem.qtybf#','#gettempitem.salec#','#gettempitem.salecsc#','#gettempitem.salecnc#','#gettempitem.purc#',
						'#gettempitem.purprec#','#Huserid#',now(),'#gettempitem.factor1#','#gettempitem.factor2#','#gettempitem.priceu2#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.remark1#">,'#dateformat(now(),'YYYY-MM-DD')#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.barcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.custprice_rate#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode#">,'#gettempitem.fucost#','#gettempitem.fprice#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode2#">,'#gettempitem.fucost2#','#gettempitem.fprice2#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode3#">,'#gettempitem.fucost3#','#gettempitem.fprice3#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode4#">,'#gettempitem.fucost4#','#gettempitem.fprice4#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode5#">,'#gettempitem.fucost5#','#gettempitem.fprice5#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.itemtype#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.comment#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.nonstkitem#">)
					</cfquery>
					<cfset count=count+1>
				<cfelse>
					<cfset thisstatus="U">
					
					<cftry>
						<cfquery name="insert_audittrail" datasource="#dts#">
							insert into deleted_icitem ( 
							  `EDI_ID`,
							  `ITEMNO`,
							  `AITEMNO`,
							  `MITEMNO`,
							  `SHORTCODE`,
							  `DESP`,
							  `DESPA`,
							  `BRAND`,
							  `CATEGORY`,
							  `WOS_GROUP`,
							  `SHELF`,
							  `SUPP`,
							  `PACKING`,
							  `WEIGHT`,
							  `COSTCODE`,
							  `UNIT`,
							  `UCOST`,
							  `PRICE`,
							  `PRICE2`,
							  `PRICE3`,
							  `PRICE_MIN`,
							  `MINIMUM`,
							  `MAXIMUM`,
							  `REORDER`,
							  `UNIT2`,
							  `COLORID`,
							  `SIZEID`,
							  `FACTOR1`,
							  `FACTOR2`,
							  `PRICEU2`,
							  `UNIT3`,
							  `FACTORU3_A`,
							  `FACTORU3_B`,
							  `PRICEU3`,
							  `UNIT4`,
							  `FACTORU4_A`,
							  `FACTORU4_B`,
							  `PRICEU4`,
							  `UNIT5`,
							  `FACTORU5_A`,
							  `FACTORU5_B`,
							  `PRICEU5`,
							  `UNIT6`,
							  `FACTORU6_A`,
							  `FACTORU6_B`,
							  `PRICEU6`,
							  `DISPEC_A1`,
							  `DISPEC_A2`,
							  `DISPEC_A3`,
							  `DISPEC_B1`,
							  `DISPEC_B2`,
							  `DISPEC_B3`,
							  `DISPEC_C1`,
							  `DISPEC_C2`,
							  `DISPEC_C3`,
							  `PRICE_CATA`,
							  `PRICE_CATB`,
							  `PRICE_CATC`,
							  `COST_CATA`,
							  `COST_CATB`,
							  `COST_CATC`,
							  `QTY2`,
							  `QTY3`,
							  `QTY4`,
							  `QTY5`,
							  `QTY6`,
							  `WQFORMULA`,
							  `WPFORMULA`,
							  `GRADED`,
							  `MURATIO`,
							  `QTYBF`,
							  `QTYNET`,
							  `QTYACTUAL`,
							  `AVCOST`,
							  `AVCOST2`,
							  `BOM_COST`,
							  `TQ_OBAL`,
							  `TQ_IN`,
							  `TQ_OUT`,
							  `TQ_CBAL`,
							  `T_UCOST`,
							  `T_STKV`,
							  `TQ_INV`,
							  `TQ_CS`,
							  `TQ_CN`,
							  `TQ_DN`,
							  `TQ_RC`,
							  `TQ_PR`,
							  `TQ_ISS`,
							  `TQ_OAI`,
							  `TQ_OAR`,
							  `TA_INV`,
							  `TA_CS`,
							  `TA_CN`,
							  `TA_DN`,
							  `TA_RC`,
							  `TA_PR`,
							  `TA_ISS`,
							  `TA_OAI`,
							  `TA_OAR`,
							  `QIN11`,
							  `QIN12`,
							  `QIN13`,
							  `QIN14`,
							  `QIN15`,
							  `QIN16`,
							  `QIN17`,
							  `QIN18`,
							  `QIN19`,
							  `QIN20`,
							  `QIN21`,
							  `QIN22`,
							  `QIN23`,
							  `QIN24`,
							  `QIN25`,
							  `QIN26`,
							  `QIN27`,
							  `QIN28`,
							  `QOUT11`,
							  `QOUT12`,
							  `QOUT13`,
							  `QOUT14`,
							  `QOUT15`,
							  `QOUT16`,
							  `QOUT17`,
							  `QOUT18`,
							  `QOUT19`,
							  `QOUT20`,
							  `QOUT21`,
							  `QOUT22`,
							  `QOUT23`,
							  `QOUT24`,
							  `QOUT25`,
							  `QOUT26`,
							  `QOUT27`,
							  `QOUT28`,
							  `SALEC`,
							  `SALECSC`,
							  `SALECNC`,
							  `PURC`,
							  `PURPREC`,
							  `TEMPFIG`,
							  `TEMPFIG1`,
							  `CT_RATING`,
							  `POINT`,
							  `QCPOINT`,
							  `AWARD1`,
							  `AWARD2`,
							  `AWARD3`,
							  `AWARD4`,
							  `AWARD5`,
							  `AWARD6`,
							  `AWARD7`,
							  `AWARD8`,
							  `REMARK1`,
							  `REMARK2`,
							  `REMARK3`,
							  `REMARK4`,
							  `REMARK5`,
							  `REMARK6`,

							  `REMARK7`,
							  `REMARK8`,
							  `REMARK9`,
							  `REMARK10`,
							  `REMARK11`,
							  `REMARK12`,
							  `REMARK13`,
							  `REMARK14`,
							  `REMARK15`,
							  `REMARK16`,
							  `REMARK17`,
							  `REMARK18`,
							  `REMARK19`,
							  `REMARK20`,
							  `REMARK21`,
							  `REMARK22`,
							  `REMARK23`,
							  `REMARK24`,
							  `REMARK25`,
							  `REMARK26`,
							  `REMARK27`,
							  `REMARK28`,
							  `REMARK29`,
							  `REMARK30`,
							  `COMMRATE1`,
							  `COMMRATE2`,
							  `COMMRATE3`,
							  `COMMRATE4`,
							  `WOS_DATE`,
							  `QTYDEC`,
							  `TEMP_QTY`,
							  `QTY`,
							  `PHOTO`,
							  `COMPEC_A`,
							  `COMPEC_B`,
							  `COMPEC_C`,
							  `WOS_TIME`,
							  `EXPIRED`,
							  `WSERIALNO`,
							  `PROMOTOR`,
							  `TAXABLE`,
							  `TAXPERC1`,
							  `TAXPERC2`,
							  `NONSTKITEM`,
							  `GRAPHIC`,
							  `PRODCODE`,
							  `BRK_TO`,
							  `COLOR`,
							  `SIZE`,
							  `qtybf_actual`, 
							  `CREATED_BY`,
							  `CREATED_ON`,
							  `UPDATED_BY`,
							  `UPDATED_ON`,
							  `DELETED_BY`,
							  `DELETED_ON`)
							select 
				  a.EDI_ID,
				  a.ITEMNO,
				  a.AITEMNO,
				  a.MITEMNO,
				  a.SHORTCODE,
				  a.DESP,
				  a.DESPA,
				  a.BRAND,
				  a.CATEGORY,
				  a.WOS_GROUP,
				  a.SHELF,
				  a.SUPP,
				  a.PACKING,
				  a.WEIGHT,
				  a.COSTCODE,
				  a.UNIT,
				  a.UCOST,
				  a.PRICE,
				  a.PRICE2,
				  a.PRICE3,
				  a.PRICE_MIN,
				  a.MINIMUM,
				  a.MAXIMUM,
				  a.REORDER,
				  a.UNIT2,
				  a.COLORID,
				  a.SIZEID,
				  a.FACTOR1,
				  a.FACTOR2,
				  a.PRICEU2,
				  a.UNIT3,
				  a.FACTORU3_A,
				  a.FACTORU3_B,
				  a.PRICEU3,
				  a.UNIT4,
				  a.FACTORU4_A,
				  a.FACTORU4_B,
				  a.PRICEU4,
				  a.UNIT5,
				  a.FACTORU5_A,
				  a.FACTORU5_B,
				  a.PRICEU5,
				  a.UNIT6,
				  a.FACTORU6_A,
				  a.FACTORU6_B,
				  a.PRICEU6,
				  a.DISPEC_A1,
				  a.DISPEC_A2,
				  a.DISPEC_A3,
				  a.DISPEC_B1,
				  a.DISPEC_B2,
				  a.DISPEC_B3,
				  a.DISPEC_C1,
				  a.DISPEC_C2,
				  a.DISPEC_C3,
				  a.PRICE_CATA,
				  a.PRICE_CATB,
				  a.PRICE_CATC,
				  a.COST_CATA,
				  a.COST_CATB,
				  a.COST_CATC,
				  a.QTY2,
				  a.QTY3,
				  a.QTY4,
				  a.QTY5,
				  a.QTY6,
				  a.WQFORMULA,
				  a.WPFORMULA,
				  a.GRADED,
				  a.MURATIO,
				  a.QTYBF,
				  a.QTYNET,
				  a.QTYACTUAL,
				  a.AVCOST,
				  a.AVCOST2,
				  a.BOM_COST,
				  a.TQ_OBAL,
				  a.TQ_IN,
				  a.TQ_OUT,
				  a.TQ_CBAL,
				  a.T_UCOST,
				  a.T_STKV,
				  a.TQ_INV,
				  a.TQ_CS,
				  a.TQ_CN,
				  a.TQ_DN,
				  a.TQ_RC,
				  a.TQ_PR,
				  a.TQ_ISS,
				  a.TQ_OAI,
				  a.TQ_OAR,
				  a.TA_INV,
				  a.TA_CS,
				  a.TA_CN,
				  a.TA_DN,
				  a.TA_RC,
				  a.TA_PR,
				  a.TA_ISS,
				  a.TA_OAI,
				  a.TA_OAR,
				  a.QIN11,
				  a.QIN12,
				  a.QIN13,
				  a.QIN14,
				  a.QIN15,
				  a.QIN16,
				  a.QIN17,
				  a.QIN18,
				  a.QIN19,
				  a.QIN20,
				  a.QIN21,
				  a.QIN22,
				  a.QIN23,
				  a.QIN24,
				  a.QIN25,
				  a.QIN26,
				  a.QIN27,
				  a.QIN28,
				  a.QOUT11,
				  a.QOUT12,
				  a.QOUT13,
				  a.QOUT14,
				  a.QOUT15,
				  a.QOUT16,
				  a.QOUT17,
				  a.QOUT18,
				  a.QOUT19,
				  a.QOUT20,
				  a.QOUT21,
				  a.QOUT22,
				  a.QOUT23,
				  a.QOUT24,
				  a.QOUT25,
				  a.QOUT26,
				  a.QOUT27,
				  a.QOUT28,
				  a.SALEC,
				  a.SALECSC,
				  a.SALECNC,
				  a.PURC,
				  a.PURPREC,
				  a.TEMPFIG,
				  a.TEMPFIG1,
				  a.CT_RATING,
				  a.POINT,
				  a.QCPOINT,
				  a.AWARD1,
				  a.AWARD2,
				  a.AWARD3,
				  a.AWARD4,
				  a.AWARD5,
				  a.AWARD6,
				  a.AWARD7,
				  a.AWARD8,
				  a.REMARK1,
				  a.REMARK2,
				  a.REMARK3,
				  a.REMARK4,
				  a.REMARK5,
				  a.REMARK6,
				  a.REMARK7,
				  a.REMARK8,
				  a.REMARK9,
				  a.REMARK10,
				  a.REMARK11,
				  a.REMARK12,
				  a.REMARK13,
				  a.REMARK14,
				  a.REMARK15,
				  a.REMARK16,
				  a.REMARK17,
				  a.REMARK18,
				  a.REMARK19,
				  a.REMARK20,
				  a.REMARK21,
				  a.REMARK22,
				  a.REMARK23,
				  a.REMARK24,
				  a.REMARK25,
				  a.REMARK26,
				  a.REMARK27,
				  a.REMARK28,
				  a.REMARK29,
				  a.REMARK30,
				  a.COMMRATE1,
				  a.COMMRATE2,
				  a.COMMRATE3,
				  a.COMMRATE4,
				  a.WOS_DATE,
				  a.QTYDEC,
				  a.TEMP_QTY,
				  a.QTY,
				  a.PHOTO,
				  a.COMPEC_A,
				  a.COMPEC_B,
				  a.COMPEC_C,
				  a.WOS_TIME,
				  a.EXPIRED,
				  a.WSERIALNO,
				  a.PROMOTOR,
				  a.TAXABLE,
				  a.TAXPERC1,
				  a.TAXPERC2,
				  a.NONSTKITEM,
				  a.GRAPHIC,
				  a.PRODCODE,
				  a.BRK_TO,
				  a.COLOR,
				  a.SIZE,
				  a.qtybf_actual, 
				  a.CREATED_BY,
				  a.CREATED_ON,
				  a.UPDATED_BY,
				  a.UPDATED_ON,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,now()
							from icitem as a
							where a.itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.itemno#">
						</cfquery>
					<cfcatch type="any">
						<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><br>
					</cfcatch>
					</cftry>
					
					<cfquery name="update" datasource="#dts#">
						Update icitem
						set DESP=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.desp#">,
						DESPA=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.despa#">,
						AITEMNO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.aitemno#">,
						BRAND=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.brand#">,
						SUPP=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.supp#">,
						CATEGORY=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.category#">,
						WOS_GROUP=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.wos_group#">,
						SIZEID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.sizeid#">,
						COSTCODE=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.costcode#">,
						COLORID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.colorid#">,
						SHELF=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.shelf#">,
						PACKING=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.packing#">,
                        UNIT2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.unit2#">,
						MINIMUM='#gettempitem.minimum#',
						MAXIMUM='#gettempitem.maximum#',
						REORDER='#gettempitem.reorder#',
						UNIT='#gettempitem.unit#',
						UCOST='#gettempitem.ucost#',
						PRICE='#gettempitem.price#',
						PRICE2='#gettempitem.price2#',
                        PRICE3='#gettempitem.price3#',
                        PRICE4='#gettempitem.price4#',
						WSERIALNO='#gettempitem.wserialno#',
						GRADED='#gettempitem.graded#',
						QTY2='#gettempitem.qty2#',
						QTY3='#gettempitem.qty3#',
						QTY4='#gettempitem.qty4#',
						QTY5='#gettempitem.qty5#',
						QTY6='#gettempitem.qty6#',
                        <cfif gettempitem.qtybf neq 0>
						QTYBF='#gettempitem.qtybf#',
                        </cfif>
						SALEC='#gettempitem.salec#',
						SALECSC='#gettempitem.salecsc#',
						SALECNC='#gettempitem.salecnc#',
						PURC='#gettempitem.purc#',
						PURPREC='#gettempitem.purprec#',
                        UNIT2='#gettempitem.unit2#',
                        FACTOR1='#gettempitem.factor1#',
                        FACTOR2='#gettempitem.factor2#',
                        PRICEU2='#gettempitem.priceu2#',
						UPDATED_BY='#Huserid#',
						UPDATED_ON=now(),
                        remark1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.remark1#">,
                        barcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.barcode#">,
                        custprice_rate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.custprice_rate#">,
                        fcurrcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode#">,
                        fucost='#gettempitem.fucost#',
                        fprice='#gettempitem.fprice#',
                        fcurrcode2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode2#">,
                        fucost2='#gettempitem.fucost2#',
                        fprice2='#gettempitem.fprice2#',
                        fcurrcode3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode3#">,
                        fucost3='#gettempitem.fucost3#',
                        fprice3='#gettempitem.fprice3#',
                        fcurrcode4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode4#">,
                        fucost4='#gettempitem.fucost4#',
                        fprice4='#gettempitem.fprice4#',
                        fcurrcode5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.fcurrcode5#">,
                        fucost5='#gettempitem.fucost5#',
                        fprice5='#gettempitem.fprice5#',
                        itemtype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.itemtype#">,
                        nonstkitem=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.nonstkitem#">,
                        wos_date='#dateformat(now(),'YYYY-MM-DD')#'
						where ITEMNO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.itemno#">
					</cfquery>
					<cfset count1=count1+1>
				</cfif>
				<cfquery name="updatestatus" datasource="#dts#">
					update icitem_temp
					set status='#thisstatus#'
					where id='#thisid#'
				</cfquery>
			</cfloop>
		</cfif>
		<h2>
			You have import <cfoutput>#count#</cfoutput> record(s) and update <cfoutput>#count1#</cfoutput> record(s) into Icitem successfully.		
		</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	<cftry>
		<cffile action = "delete" file = "C:\item_format_#dts#.xls">
		<h2>You have deleted item_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
<cfif submitarcust eq 'Submit'>
	<cftry>
		<cffile action = "delete" file = "C:\cust_format_#dts#.xls">
		<h2>You have deleted cust_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">	
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\cust_format_#dts#.xls" ACTION="UPLOAD" FILEFIELD="form.getarcust" attributes="normal">
		<h2>You have FTP cust_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	<cfset filename="C:/cust_format_#dts#.xls">
	<!--- <cftry> --->
		<cfinclude template = "import_excel2.cfm">
	<!--- <cfcatch type="any">
	</cfcatch>
	</cftry> --->
	<cfabort>
		<cfquery name="gettempcust" datasource="#dts#">
			select * from arcust_temp
			where status='' and custno<>''
		</cfquery>
		<cfset count=0>
		<cfif Hlinkams eq "Y">
			<cfset dts1=replacenocase(dts,"_i","_a","all")>
		<cfelse>
			<cfset dts1=dts>
		</cfif>
		<cfif gettempcust.recordcount neq 0>
			<cfloop query="gettempcust">
				<cfquery name="checkexist" datasource="#dts1#">
					select custno from arcust
					where custno ='#gettempcust.custno#'
				</cfquery>
				<cfset thisstatus="I">	<!--- STATUS=I:IMPORTED; E:EXIST --->
				<cfset thisid=gettempcust.id>
				<cfif checkexist.recordcount eq 0>
                
					<cfquery name="insert" datasource="#dts1#">
						insert ignore into arcust
						(`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,
						`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`PHONEA`,
						`FAX`,`E_MAIL`,`WEB_SITE`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CRLIMIT`,
						`CURRCODE`,`CURRENCY`,`CURRENCY1`,`CURRENCY2`,
						`DATE`,`INVLIMIT`,`CREATED_BY`,`UPDATED_BY`,`CREATED_ON`,`UPDATED_ON`,`ngst_cust`,`comuen`,`gstno`
                        ,`arrem1`,`arrem2`,`arrem3`,`arrem4` <cfloop from="5" to="20" index="a"><cfif trim(evaluate('gettempcust.arrem#a#')) neq ''>,arrem#a#</cfif></cfloop>) 
						values
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.custno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.name2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CONTACT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.PHONE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.PHONE2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.FAX#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.E_MAIL#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.WEB_SITE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.AREA#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.AGENT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.BUSINESS#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.TERM#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CRLIMIT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRCODE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRENCY#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRENCY1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRENCY2#">,
						now(),
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.INVLIMIT#">,
						'#Huserid#','#Huserid#',now(),now(),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ngst_cust#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.comuen#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.gstno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.arrem1#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.arrem2#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.arrem3#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.arrem4#">
                        <cfloop from="5" to="20" index="a"><cfif trim(evaluate('gettempcust.arrem#a#')) neq ''>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('gettempcust.arrem#a#')#"></cfif></cfloop>
						)
					</cfquery>
					
					<cfif Hlinkams eq "Y">
		                <cfquery name="insertgldata" datasource="#dts1#">
			                insert ignore into gldata
			                (accno,desp,acctype,id,currcode,groupto)
			                values
			                (<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.custno#">,
			                <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.name#">,'F','1',
			                <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRCODE#">,'')
						</cfquery>
					</cfif>
					<cfset count=count+1>
				<cfelse>
					<cfset thisstatus="E">
				</cfif>
				<cfquery name="updatestatus" datasource="#dts#">
					update arcust_temp
					set status='#thisstatus#'
					where id='#thisid#'
				</cfquery>
			</cfloop>
			<cfif count neq 0>
				<cfquery name="insertbusiness" datasource="#dts#">
					insert ignore into business (business) select distinct business from #target_arcust# as a where (a.business <> '')
				</cfquery>
				<cfquery name="updatebusiness" datasource="#dts#">
					update business
					set desp=business
					where (desp='' or desp is null)
				</cfquery>
			</cfif>
		</cfif>
		<h2>You have import <cfoutput>#count#</cfoutput> record(s) into Arcust successfully.</h2>
	
	<cftry>
		<cffile action = "delete" file = "C:\cust_format_#dts#.xls">
		<h2>You have deleted cust_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
<cfif submitapvend eq 'Submit'>
	<cftry>
		<cffile action = "delete" file = "C:\supp_format_#dts#.xls">
		<h2>You have deleted supp_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\supp_format_#dts#.xls" ACTION="UPLOAD" FILEFIELD="form.getapvend" attributes="normal">
		<h2>You have FTP supp_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	<cfset filename="C:/supp_format_#dts#.xls">
	<!---<cftry>--->
		<cfinclude template = "import_excel2.cfm">
	<!---<cfcatch type="any">
	</cfcatch>
	</cftry>--->
	<!---<cftry>---->
		<cfquery name="gettempsupp" datasource="#dts#">
			select * from apvend_temp
			where status='' and custno<>''
		</cfquery>
		<cfset count=0>
		
		<cfif Hlinkams eq "Y">
			<cfset dts1=replacenocase(dts,"_i","_a","all")>
		<cfelse>
			<cfset dts1=dts>
		</cfif>
		<cfif gettempsupp.recordcount neq 0>
			<cfloop query="gettempsupp">
				<cfquery name="checkexist" datasource="#dts1#">
					select custno from apvend
					where custno ='#gettempsupp.custno#'
				</cfquery>
				<cfset thisstatus="I">	<!--- STATUS=I:IMPORTED; E:EXIST --->
				<cfset thisid=gettempsupp.id>
				<cfif checkexist.recordcount eq 0>
					<cfquery name="insert" datasource="#dts1#">
						insert into apvend
						(`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,
						`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`PHONEA`,
						`FAX`,`E_MAIL`,`WEB_SITE`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CRLIMIT`,
						`CURRCODE`,`CURRENCY`,`CURRENCY1`,`CURRENCY2`,
						`DATE`,`INVLIMIT`,`CREATED_BY`,`UPDATED_BY`,`CREATED_ON`,`UPDATED_ON`,`NGST_CUST`,`comuen`,`gstno`
                        ,`arrem1`,`arrem2`,`arrem3`,`arrem4`) 
						values
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.custno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.name2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CONTACT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.PHONE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.PHONE2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.FAX#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.E_MAIL#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.WEB_SITE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.AREA#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.AGENT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.BUSINESS#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.TERM#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CRLIMIT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRCODE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRENCY#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRENCY1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRENCY2#">,
						now(),
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.INVLIMIT#">,
						'#Huserid#','#Huserid#',now(),now(),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ngst_cust#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.comuen#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.gstno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.arrem1#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.arrem2#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.arrem3#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.arrem4#">
						)
					</cfquery>
					<cfif Hlinkams eq "Y">
		                <cfquery name="insertgldata" datasource="#dts1#">
			                insert ignore into gldata
			                (accno,desp,acctype,id,currcode,groupto)
			                values
			                (<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.custno#">,
			                <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.name#">,'G','2',
			                <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRCODE#">,'')
						</cfquery>
					</cfif>
					<cfset count=count+1>
				<cfelse>
					<cfset thisstatus="E">
				</cfif>
				<cfquery name="updatestatus" datasource="#dts#">
					update apvend_temp
					set status='#thisstatus#'
					where id='#thisid#'
				</cfquery>
			</cfloop>
		</cfif>
		<h2>You have import <cfoutput>#count#</cfoutput> record(s) into Apvend successfully.</h2>
	<!---<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>--->
	<cftry>
		<cffile action = "delete" file = "C:\supp_format_#dts#.xls">
		<h2>You have deleted supp_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
</cfoutput>
</body>
</html>