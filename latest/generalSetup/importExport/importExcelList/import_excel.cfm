<html>
<head>
	<title>IMPORT EXCEL FILE TO IMS</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

	
	<script>
		function checkFileType(fileName){
			var file = fileName;
			var formName = document.getElementById("form1");
			var ext = file.match(/\.([^\.]+)$/)[1];
			switch(ext){
				case 'xls':	
					break;
				default:
				   alert('Incorrect file type! Kindly use .xls file type only!');
				   formName.reset();
			}
		}
	</script>

</head>

<!--- SUBMIT --->
<cfparam name="submiticitem" default="">
<cfparam name="submitarcust" default="">
<cfparam name="submitapvend" default="">
<body>
<form name="form1" id="form1" action="import_excel.cfm" method="post" enctype="multipart/form-data">
<H1>Import EXCEL File To IMS</H1>
<H1>*Please download latest excel format from step 1 for data import.</H1>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT ITEM</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td>
			<a href="download/item_format.xls" target="_blank">item_format.xls</a>
			<br>
			<a href="export_itemexcel.cfm" target="_blank">Excel With Item</a>
        </td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Get File <b>(<cfoutput>item_format_#dts#.xls</cfoutput>) </b>From Local Disk</td>
        <td>
			<font size="2">
				<input type="file" name="geticitem" size="25">
			</font>
		</td>
    </tr>
	<tr>
    	<td colspan="3" align="center">
			<font size="2">
				<input type="submit" name="submiticitem" id="submiticitem" value="Submit" onClick="this.disabled='true';this.value='Uploading, please wait...';document.getElementById("form1").submit();">
			</font>
		</td>
    </tr>
</table>
<br>

<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT CUSTOMER</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td>
			<a href="downloadExcelTemplate/CUSTOMER_TEMPLATE.xls" target="_blank">CUSTOMER_TEMPLATE.xls</a> 
			<br>
			<a href="export_custsuppexcel.cfm?type=debtor" target="_blank">Excel With Customer</a>
		</td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Get File <b>(<cfoutput>CUSTOMER_TEMPLATE_#dts#.xls</cfoutput>)</b> From Local Disk</td>
        <td>
			<font size="2">
				<input type="file" name="getarcust" id="getarcust" size="25" onChange="checkFileType(this.value);">
			</font>
		</td>
    </tr>
	<tr>
    	<td colspan="3" align="center">
			<font size="2">
				<input type="submit" name="submitarcust" value="Submit" onClick="this.disabled='true';this.value='Uploading, please wait...';document.getElementById("form1").submit();">
			</font>
		</td>
    </tr>
</table>
<br>

<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT SUPPLIER</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td>
			<a href="downloadExcelTemplate/SUPPLIER_TEMPLATE.xls" target="_blank">SUPPLIER_TEMPLATE.xls</a> 
			<br>
			<a href="export_custsuppexcel.cfm?type=creditor" target="_blank">Excel With Supplier</a>
		</td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Get File <b>(<cfoutput>SUPPLIER_TEMPLATE_#dts#.xls</cfoutput>)</b> From Local Disk</td>
        <td>
			<font size="2">
				<input type="file" name="getapvend" id="getapvend" size="25" onChange="checkFileType(this.value);">
			</font>
		</td>
    </tr>
	<tr>
    	<td colspan="3" align="center">
			<font size="2">
				<input type="submit" name="submitapvend" value="Submit" onClick="this.disabled='true';this.value='Uploading, please wait...';document.getElementById("form1").submit();">
			</font>
		</td>
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
		<cffile action = "delete" file = "C:\CUSTOMER_TEMPLATE_#dts#.xls">
		<h2>You have deleted cust_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">	
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE ACTION="UPLOAD" 
        		DESTINATION="C:\CUSTOMER_TEMPLATE_#dts#.xls"  
                FILEFIELD="form.getarcust" 
                ATTRIBUTES="normal" >
                
			<h2>You have FTP cust_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">	
	</cfcatch>
	</cftry>
    
	<cfset filename="C:/CUSTOMER_TEMPLATE_#dts#.xls">

	<cfinclude template = "import_excel2.cfm">

		<cfquery name="get_arcustTemp" datasource="#dts#">
			SELECT * 
            FROM arcust_temp
			WHERE status = '' 
            AND custno != '';
		</cfquery>
        
		<cfset count=0>
		<cfif Hlinkams EQ "Y">
			<cfset dts1=replaceNoCase(dts,"_i","_a","all")>
		<cfelse>
			<cfset dts1=dts>
		</cfif>
		<cfif get_arcustTemp.recordcount neq 0>
			<cfloop query="get_arcustTemp">
				<cfquery name="checkExist" datasource="#dts1#">
					SELECT custno 
                    FROM arcust
					WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.custno#">;
				</cfquery>
                
                <!--- STATUS=I:IMPORTED; E:EXIST --->
				<cfset thisstatus="I">	
				<cfset thisid=get_arcustTemp.id>
                
				<cfif checkExist.recordcount EQ 0>
                
					<cfquery name="insertInto_arcust" datasource="#dts1#">
						INSERT IGNORE INTO arcust (	custno,name,name2,comUEN,
                                        			add1,add2,add3,add4,country,postalCode,attn,phone,phonea,fax,e_mail,
                                        			daddr1,daddr2,daddr3,daddr4,d_country,d_postalCode,dattn,dphone,contact,dfax,d_email,
                                          			ngst_cust,GSTno,saleC,saleCNC,
                                        			currCode,currency,currency1,term,crLimit,invLimit,
                                        			dispec_cat,dispec1,dispec2,dispec3,normal_rate,offer_rate,others_rate,
                                         			business,area,end_user,agent,groupTo,arrem1,arrem2,arrem3,arrem4,badStatus,
                                                    created_by,created_on )
						VALUES (	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.custno#">,	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.name#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.name2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.comUEN#">,	
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add3#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add4#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.country#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.postalCode#">,	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.attn#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.phone#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.phonea#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.fax#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.e_mail#">,
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr3#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr4#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_country#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_postalCode#">,	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dattn#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dphone#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.contact#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dfax#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_email#">,
                                    
                                    '#get_arcustTemp.ngst_cust#',
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.GSTno#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.saleC#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.saleCNC#">,
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currCode#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currency#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currency1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.term#">,
                                    '#val(get_arcustTemp.crLimit)#',
                                    '#val(get_arcustTemp.invLimit)#',
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dispec_cat#">,
                                    '#val(get_arcustTemp.dispec1)#',
                                    '#val(get_arcustTemp.dispec2)#',
                                    '#val(get_arcustTemp.dispec3)#',
                                    '#val(get_arcustTemp.normal_rate)#',
                                    '#val(get_arcustTemp.offer_rate)#',
                                    '#val(get_arcustTemp.others_rate)#',
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.business#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.area#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.end_user#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.agent#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.groupTo#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem3#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem4#">,
                                    '#get_arcustTemp.badStatus#',
                                    '#HuserID#',
                                    NOW()
                             );
					</cfquery>
					
					<cfif Hlinkams eq "Y">
		                <cfquery name="insertInto_gldata" datasource="#dts1#">
			                INSERT IGNORE INTO gldata (accno,desp,acctype,id,currcode,groupto)
			                VALUES(
                            		<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.custno#">,
			                		<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.name#">,
                                    'F',
                                    '1',
			                		<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.CURRCODE#">,
                                    ''
                                  );
						</cfquery>
					</cfif>
					<cfset count=count+1>
				<cfelse>
                    <cfquery name="update_arcust" datasource="#dts1#">
						UPDATE arcust 
                        SET	
                            name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.name#">,
                            name2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.name2#">,
                            comUEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.comUEN#">,	
                            
                            add1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add1#">,
                            add2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add2#">,
                            add3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add3#">,
                            add4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add4#">,
                            country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.country#">,
                            postalCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.postalCode#">,	
                            attn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.attn#">,
                            phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.phone#">,
                            phonea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.phonea#">,
                            fax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.fax#">,
                            e_mail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.e_mail#">,
                            
                            daddr1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr1#">,
                            daddr2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr2#">,
                            daddr3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr3#">,
                            daddr4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr4#">,
                            d_country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_country#">,
                            d_postalCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_postalCode#">,	
                            dattn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dattn#">,
                            dphone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dphone#">,
                            contact = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.contact#">,
                            dfax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dfax#">,
                            d_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_email#">,
                            
                            ngst_cust = '#get_arcustTemp.ngst_cust#',
                            GSTno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.GSTno#">,
                            saleC = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.saleC#">,
                            saleCNC = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.saleCNC#">,
                            
                            currCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currCode#">,
                            currency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currency#">,
                            currency1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currency1#">,
                            term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.term#">,
                            crLimit = '#val(get_arcustTemp.crLimit)#',
                            invLimit = '#val(get_arcustTemp.invLimit)#',
                            
                            dispec_cat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dispec_cat#">,
                            dispec1 = '#val(get_arcustTemp.dispec1)#',
                            dispec2 = '#val(get_arcustTemp.dispec2)#',
                            dispec3 = '#val(get_arcustTemp.dispec3)#',
                            normal_rate = '#val(get_arcustTemp.normal_rate)#',
                            offer_rate = '#val(get_arcustTemp.offer_rate)#',
                            others_rate = '#val(get_arcustTemp.others_rate)#',
                            
                            business = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.business#">,
                            area = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.area#">,
                            end_user = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.end_user#">,
                            agent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.agent#">,
                            groupTo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.groupTo#">,
                            arrem1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem1#">,
                            arrem2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem2#">,
                            arrem3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem3#">,
                            arrem4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem4#">,
                            badStatus = '#get_arcustTemp.badStatus#',
                            updated_by = '#HuserID#',
                            updated_on = NOW()
                            
                    	WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.custno#">;
					</cfquery>
                    
					<cfset thisstatus="E">
				</cfif>
                
				<cfquery name="updateStatus" datasource="#dts#">
					UPDATE arcust_temp
					SET
                    	status='#thisstatus#'
					WHERE id='#thisid#';
				</cfquery>    
			</cfloop>
			
                      
            <!--- 
					Perform checking for new CURRENCY(s) being insert directly
					from EXCEL file		
			--->
            <cfquery name="checkCurrencyCode" datasource="#dts1#">
            	SELECT currcode
                FROM arcust
                WHERE currcode != ''
                GROUP BY currcode;
            </cfquery>
            
            <cfquery name="insertInto_currency" datasource="#dts1#">
            	INSERT IGNORE INTO currency (currcode,currency,currency1)
                	SELECT currcode,currency,currency1 FROM arcust
                    WHERE currcode != '';
            </cfquery>
            
            <!--- 
					Perform checking for new TERM(s) being insert directly
					from EXCEL file		
			--->
            <cfquery name="checkCurrencyCode" datasource="#dts1#">
            	SELECT term
                FROM arcust
                WHERE term != ''
                GROUP BY term;
            </cfquery>
            
            <cfquery name="insertInto_currency" datasource="#dts1#">
            	INSERT IGNORE INTO icterm (term)
                	SELECT term FROM arcust
                    WHERE term != '';
            </cfquery>
            
            <!--- 
					Perform checking for new BUSINESS(s) being insert directly
					from EXCEL file		
			--->
            <cfquery name="checkCurrencyCode" datasource="#dts1#">
            	SELECT business
                FROM arcust
                WHERE business != ''
                GROUP BY business;
            </cfquery>
            
            <cfquery name="insertInto_currency" datasource="#dts1#">
            	INSERT IGNORE INTO #dts#.business (business)
                	SELECT business FROM arcust
                    WHERE business != '';
            </cfquery>
            
            <!--- 
					Perform checking for new AREA value(s) being insert directly
					from EXCEL file		
			--->
            <cfquery name="checkArea" datasource="#dts1#">
            	SELECT area
                FROM arcust
                WHERE area != ''
                GROUP BY area;
            </cfquery>
            
            <cfquery name="insertInto_icarea" datasource="#dts1#">
            	INSERT IGNORE INTO icarea (area)
                	SELECT area FROM arcust
                    WHERE area != '';
            </cfquery>
            
            <!--- 
					Perform checking for new END USER value(s) being insert directly
					from EXCEL file		
			--->
            <cfquery name="checkArea" datasource="#dts1#">
            	SELECT end_user
                FROM arcust
                WHERE end_user != ''
                GROUP BY end_user;
            </cfquery>
            
            <cfquery name="insertInto_icarea" datasource="#dts1#">
            	INSERT IGNORE INTO #dts#.driver (driverNo)
                	SELECT end_user FROM arcust
                    WHERE end_user != '';
            </cfquery>
            
		</cfif>
		<h2>You have import <cfoutput>#count#</cfoutput> record(s) into Arcust successfully.</h2>
	
	<cftry>
		<cffile action = "delete" file = "C:\CUSTOMER_TEMPLATE_#dts#.xls">
		<h2>You have deleted cust_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
<cfif submitapvend eq 'Submit'>
	<cftry>
		<cffile action = "delete" file = "C:\SUPPLIER_TEMPLATE_#dts#.xls">
		<h2>You have deleted supp_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\SUPPLIER_TEMPLATE_#dts#.xls" ACTION="UPLOAD" FILEFIELD="form.getapvend" attributes="normal">
		<h2>You have FTP supp_format_#dts#.xls successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	<cfset filename="C:/SUPPLIER_TEMPLATE_#dts#.xls">
    
	<cfinclude template = "import_excel2.cfm">

		<cfquery name="get_apvendTemp" datasource="#dts#">
			SELECT * 
            FROM apvend_temp
			WHERE status='' 
            AND custno !='';
		</cfquery>
		<cfset count=0>
		
		<cfif Hlinkams EQ "Y">
			<cfset dts1=replaceNoCase(dts,"_i","_a","all")>
		<cfelse>
			<cfset dts1=dts>
		</cfif>
		<cfif get_apvendTemp.recordcount NEQ 0>
			<cfloop query="get_apvendTemp">
            
				<cfquery name="checkExist" datasource="#dts1#">
					SELECT custno 
                    FROM apvend
					WHERE custno ='#get_apvendTemp.custno#';
				</cfquery>
                
                <!--- STATUS=I:IMPORTED; E:EXIST --->
				<cfset thisstatus="I">	
				<cfset thisid=get_apvendTemp.id>
                
				<cfif checkExist.recordcount EQ 0>
					<cfquery name="insertInto_apvend" datasource="#dts1#">
						INSERT IGNORE INTO apvend (	custno,name,name2,comUEN,
                                        			add1,add2,add3,add4,country,postalCode,attn,phone,phonea,fax,e_mail,
                                        			daddr1,daddr2,daddr3,daddr4,d_country,d_postalCode,dattn,dphone,contact,dfax,d_email,
                                          			ngst_cust,GSTno,saleC,saleCNC,
                                        			currCode,currency,currency1,term,crLimit,invLimit,
                                        			dispec_cat,dispec1,dispec2,dispec3,
                                         			business,area,end_user,agent,groupTo,arrem1,arrem2,arrem3,arrem4,badStatus,
                                                    created_by,created_on )
						VALUES (	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.custno#">,	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.name#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.name2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.comUEN#">,	
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.add1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.add2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.add3#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.add4#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.country#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.postalCode#">,	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.attn#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.phone#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.phonea#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.fax#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.e_mail#">,
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.daddr1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.daddr2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.daddr3#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.daddr4#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.d_country#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.d_postalCode#">,	
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.dattn#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.dphone#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.contact#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.dfax#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.d_email#">,
                                    
                                    '#get_apvendTemp.ngst_cust#',
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.GSTno#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.saleC#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.saleCNC#">,
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.currCode#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.currency#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.currency1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.term#">,
                                    '#val(get_apvendTemp.crLimit)#',
                                    '#val(get_apvendTemp.invLimit)#',
                                    
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.dispec_cat#">,
                                    '#val(get_apvendTemp.dispec1)#',
                                    '#val(get_apvendTemp.dispec2)#',
                                    '#val(get_apvendTemp.dispec3)#',
                                                                        
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.business#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.area#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.end_user#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.agent#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.groupTo#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.arrem1#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.arrem2#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.arrem3#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.arrem4#">,
                                    '#get_apvendTemp.badStatus#',
                                    '#HuserID#',
                                    NOW()
                             );
					</cfquery>
                    
					<cfif Hlinkams eq "Y">
                    
		                <cfquery name="insertInto_gldata" datasource="#dts1#">
			                INSERT IGNORE INTO gldata (accno,desp,acctype,id,currcode,groupto)
			                VALUES (
                            		 <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.custno#">,
			                		 <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.name#">,
                                     'G',
                                     '2',
			                		 <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_apvendTemp.currCode#">,
                                     ''
                                   )
						</cfquery>
					</cfif>
                    
					<cfset count=count+1>
				<cfelse>
                	<cfquery name="update_apvend" datasource="#dts1#">
						UPDATE apvend 
                        SET	
                            name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.name#">,
                            name2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.name2#">,
                            comUEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.comUEN#">,	
                            
                            add1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add1#">,
                            add2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add2#">,
                            add3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add3#">,
                            add4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.add4#">,
                            country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.country#">,
                            postalCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.postalCode#">,	
                            attn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.attn#">,
                            phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.phone#">,
                            phonea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.phonea#">,
                            fax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.fax#">,
                            e_mail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.e_mail#">,
                            
                            daddr1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr1#">,
                            daddr2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr2#">,
                            daddr3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr3#">,
                            daddr4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.daddr4#">,
                            d_country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_country#">,
                            d_postalCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_postalCode#">,	
                            dattn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dattn#">,
                            dphone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dphone#">,
                            contact = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.contact#">,
                            dfax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dfax#">,
                            d_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.d_email#">,
                            
                            ngst_cust = '#get_arcustTemp.ngst_cust#',
                            GSTno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.GSTno#">,
                            saleC = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.saleC#">,
                            saleCNC = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.saleCNC#">,
                            
                            currCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currCode#">,
                            currency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currency#">,
                            currency1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.currency1#">,
                            term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.term#">,
                            crLimit = '#val(get_arcustTemp.crLimit)#',
                            invLimit = '#val(get_arcustTemp.invLimit)#',
                            
                            dispec_cat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.dispec_cat#">,
                            dispec1 = '#val(get_arcustTemp.dispec1)#',
                            dispec2 = '#val(get_arcustTemp.dispec2)#',
                            dispec3 = '#val(get_arcustTemp.dispec3)#',
                            
                            business = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.business#">,
                            area = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.area#">,
                            end_user = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.end_user#">,
                            agent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.agent#">,
                            groupTo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.groupTo#">,
                            arrem1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem1#">,
                            arrem2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem2#">,
                            arrem3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem3#">,
                            arrem4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.arrem4#">,
                            badStatus = '#get_arcustTemp.badStatus#',
                            updated_by = '#HuserID#',
                            updated_on = NOW()
                            
                    	WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_arcustTemp.custno#">;
					</cfquery>
                    
					<cfset thisstatus="E">
				</cfif>
				<cfquery name="update_apvendTemp" datasource="#dts#">
					UPDATE apvend_temp
					SET
                    	status='#thisstatus#'
					WHERE id='#thisid#';
				</cfquery>
			</cfloop>
		</cfif>
		<h2>You have import <cfoutput>#count#</cfoutput> record(s) into Apvend successfully.</h2>
	<cftry>
		<cffile action = "delete" file = "C:\SUPPLIER_TEMPLATE_#dts#.xls">
		<h2>You have deleted supp_format_#dts#.xls successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
</cfoutput>
</body>
</html>