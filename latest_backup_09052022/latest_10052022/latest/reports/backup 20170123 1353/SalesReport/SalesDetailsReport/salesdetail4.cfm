<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = "">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "0">
	</cfloop>

	<cfquery name="getgroup" datasource="#dts#">
		select a.refno,a.type,a.custno, a.name from ictran a, icitem b
		where (type = 'INV' or type = 'CS') and b.itemno = a.itemno and (void = '' or void is null)
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		and b.category >='#form.categoryfrom#' and b.category <='#form.categoryto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group >='#form.groupfrom#' and b.wos_group <='#form.groupto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and b.itemno >='#form.productfrom#' and b.itemno <= '#form.productto#'
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod+0 >= '#form.periodfrom#' and a.fperiod+0 <= '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
		<cfelse>
		and a.wos_date > #getgeneral.lastaccyear#
		</cfif>
        <cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and a.custno >='#form.customerfrom#' and a.custno <= '#form.customerto#'
				</cfif>
        <cfif form.projectfrom neq "" and form.projectto neq "">
            and a.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
            and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
        </cfif>
        <cfif form.jobfrom neq "" and form.jobto neq "">
            and a.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
            and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
        </cfif>
         <cfif trim(form.locationfrom) neq "" and trim(form.locationto) neq "">
        and location >='#form.locationfrom#' and custno <= '#form.locationto#'
        </cfif>
        <cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
				and a.refno >='#form.refnofrom#' and a.refno <= '#form.refnoto#'
		</cfif>
		group by a.type,a.refno order by a.type,a.refno
	</cfquery>

	<cfxml variable="data">
	<?xml version="1.0"?>
	<?mso-application progid="Excel.Sheet"?>
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:html="http://www.w3.org/TR/REC-html40">
	<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
	<Author>Netiquette Technology</Author>
	<LastAuthor>Netiquette Technology</LastAuthor>
	<Company>Netiquette Technology</Company>
	</DocumentProperties>
	<Styles>
	<Style ss:ID="Default" ss:Name="Normal">
	<Alignment ss:Vertical="Bottom"/>
	<Borders/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
	<Interior/>
	<NumberFormat/>
	<Protection/>
	</Style>
	<Style ss:ID="s22">
	<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s24">
	<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss"/>
	</Style>
	<Style ss:ID="s26">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss"/>
	</Style>
	<Style ss:ID="s27">
	<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	</Style>
	<Style ss:ID="s28">
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s29">
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s30">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s31">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s32">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s33">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s34">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
	</Style>
	<Style ss:ID="s35">
	<NumberFormat ss:Format="0"/>
	</Style>
	<Style ss:ID="s36">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
	</Style>
	<Style ss:ID="s37">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
	</Style>
	</Styles>
	<Worksheet ss:Name="Sales REPORT DETAIL BY REFNO">
	<cfoutput>
    <cfset c=9>
    <cfif getdisplaydetail.report_aitemno eq 'Y'>
	<cfset c=c+1>
    </cfif>
    <cfif getdisplaydetail.report_brand eq 'Y'>
    <cfset c=c+1>
    </cfif>
    <cfif getdisplaydetail.report_category eq 'Y'>
    <cfset c=c+1>
    </cfif>
    <cfif getdisplaydetail.report_group eq 'Y'>
    <cfset c=c+1>
    </cfif>
    <cfif getdisplaydetail.report_sizeid eq 'Y'>
    <cfset c=c+1>
    </cfif>
    <cfif getdisplaydetail.report_colorid eq 'Y'>
    <cfset c=c+1>
    </cfif>
    <cfif getdisplaydetail.report_costcode eq 'Y'>
    <cfset c=c+1>
    </cfif>
    <cfif getdisplaydetail.report_shelf eq 'Y'>
    <cfset c=c+1>
    </cfif>
    
	<Table ss:ExpandedColumnCount="25" x:FullColumns="1" x:FullRows="1">
	<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="4"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Sales REPORT DETAIL(BY REFNO)</Data></Cell>
	</Row>

	<cfif isdefined("form.periodfrom") and form.periodfrom neq "" and form.periodto neq "">
		<cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
		<cfwddx action = "cfml2wddx" input = "DATE: #form.datefrom# - #form.dateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif isdefined("form.categoryfrom") and trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.categoryfrom# - #form.categoryto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif isdefined("form.groupfrom") and trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif isdefined("form.productfrom") and trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<cfwddx action = "cfml2wddx" input = "PRODUCT NO: #form.productfrom# - #form.productto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
    <cfif isdefined("form.locationfrom") and trim(form.locationfrom) neq "" and trim(form.locationto) neq "">
		<cfwddx action = "cfml2wddx" input = "Location: #form.locationfrom# - #form.locationto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c-2#" ss:StyleID="s26"><Data ss:Type="String">
			<cfif getgeneral.compro neq "">
            <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
        		#wddxText#
            </cfif></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
   		<Cell ss:StyleID="s27"><Data ss:Type="String">Customer No.</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">Product No.</Data></Cell>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">Product Code.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_brand eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">#getgeneral.lbrand#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_category eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">#getgeneral.lcategory#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_group eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">#getgeneral.lgroup#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_sizeid eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">#getgeneral.lsize#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_colorid eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">#getgeneral.lmaterial#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_costcode eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">#getgeneral.lrating#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_shelf eq 'Y'>
        <Cell ss:StyleID="s27"><Data ss:Type="String">#getgeneral.lmodel#.</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s27"><Data ss:Type="String">PRODUCT DESP</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">REF NO</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">DATE</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">QTY</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">UNIT PRICE</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">AMOUNT</Data></Cell>
	</Row>

	<cfset totalqty = 0>
		<cfset totalamt = 0>

		<cfloop query="getgroup">
        <cfset subqty = 0>
		<cfset subamt = 0>
		<Row ss:AutoFitHeight="0" ss:Height="12">

				<cfwddx action = "cfml2wddx" input = "Customer No: #getgroup.custno#" output = "wddxText1">
				<cfwddx action = "cfml2wddx" input = "#getgroup.name#" output = "wddxText2">
				<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText2#</Data></Cell>
                
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>

		<cfquery name="getitem" datasource="#dts#">
				select a.*,b.* from ictran as a
                left join (select aitemno,brand,category,wos_group,costcode,sizeid,colorid,shelf,itemno from icitem)as b on a.itemno=b.itemno
				where a.type='#getgroup.type#' and a.refno='#getgroup.refno#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 >= '#form.periodfrom#' and a.fperiod+0 <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
				</cfif>
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno >='#form.productfrom#' and a.itemno <= '#form.productto#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and a.custno >='#form.customerfrom#' and a.custno <= '#form.customerto#'
				</cfif>
                and (a.void = '' or a.void is null)
                <cfif form.projectfrom neq "" and form.projectto neq "">
					and a.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
                <cfif form.jobfrom neq "" and form.jobto neq "">
					and a.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
                        and a.refno >='#form.refnofrom#' and a.refno <= '#form.refnoto#'
                </cfif>
			</cfquery>

		<cfloop query="getitem">
			
				<cfset subqty = subqty + val(getitem.qty)>
				<cfset subamt = subamt + val(getitem.amt)>
			<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#getitem.desp##getitem.despa#" output = "wddxText2">
			<cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText3">
			<cfwddx action = "cfml2wddx" input = "#dateformat(wos_date,'DD-MM-YYYY')#" output = "wddxText4">
            <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText5">
			<Row ss:AutoFitHeight="0" ss:Height="12">
            	<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
            	<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText5#</Data></Cell>
            	</cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.brand#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.category#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.wos_group#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.sizeid#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.colorid#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.costcode#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.shelf#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText3#</Data></Cell>
				<Cell ss:StyleID="s35"><Data ss:Type="Number">#wddxText4#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.qty#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.price#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.amt#</Data></Cell>
			</Row>
		</cfloop>

		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s30"><Data ss:Type="String">SUB-TOTAL</Data></Cell>
			<Cell ss:StyleID="s30"/>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            	<Cell ss:StyleID="s30"/>
            </cfif>
            <cfif getdisplaydetail.report_brand eq 'Y'>
            <Cell ss:StyleID="s30"/>
            </cfif>
            <cfif getdisplaydetail.report_category eq 'Y'>
            <Cell ss:StyleID="s30"/>
            </cfif>
            <cfif getdisplaydetail.report_group eq 'Y'>
            <Cell ss:StyleID="s30"/>
            </cfif>
            <cfif getdisplaydetail.report_sizeid eq 'Y'>
            <Cell ss:StyleID="s30"/>
            </cfif>
            <cfif getdisplaydetail.report_colorid eq 'Y'>
            <Cell ss:StyleID="s30"/>
            </cfif>
            <cfif getdisplaydetail.report_costcode eq 'Y'>
            <Cell ss:StyleID="s30"/>
            </cfif>
            <cfif getdisplaydetail.report_shelf eq 'Y'>
            <Cell ss:StyleID="s30"/>
            </cfif>
			<Cell ss:StyleID="s30"/>
            <Cell ss:StyleID="s30"/>
            <Cell ss:StyleID="s30"/>
			<Cell ss:StyleID="s36"><Data ss:Type="Number">#subqty#</Data></Cell>
			<Cell ss:StyleID="s30"/>
			<Cell ss:StyleID="s31"><Data ss:Type="Number">#subamt#</Data></Cell>
		</Row>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</cfloop>
	<Row ss:AutoFitHeight="0" ss:Height="12">
		<Cell ss:StyleID="s32"><Data ss:Type="String">TOTAL</Data></Cell>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
            	<Cell ss:StyleID="s32"/>
        </cfif>
        <cfif getdisplaydetail.report_brand eq 'Y'>
        <Cell ss:StyleID="s32"/>
        </cfif>
        <cfif getdisplaydetail.report_category eq 'Y'>
        <Cell ss:StyleID="s32"/>
        </cfif>
        <cfif getdisplaydetail.report_group eq 'Y'>
        <Cell ss:StyleID="s32"/>
        </cfif>
        <cfif getdisplaydetail.report_sizeid eq 'Y'>
        <Cell ss:StyleID="s32"/>
        </cfif>
        <cfif getdisplaydetail.report_colorid eq 'Y'>
        <Cell ss:StyleID="s32"/>
        </cfif>
        <cfif getdisplaydetail.report_costcode eq 'Y'>
        <Cell ss:StyleID="s32"/>
        </cfif>
        <cfif getdisplaydetail.report_shelf eq 'Y'>
        <Cell ss:StyleID="s32"/>
        </cfif>
		<Cell ss:StyleID="s32"/>
		<Cell ss:StyleID="s32"/>
        <Cell ss:StyleID="s30"/>
        <Cell ss:StyleID="s30"/>
		<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalqty#</Data></Cell>
		<Cell ss:StyleID="s30"/>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totalamt#</Data></Cell>
	</Row>
    </Table>
	</cfoutput>
	<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
	<Unsynced/>
	<Print>
	<ValidPrinterInfo/>
	<HorizontalResolution>600</HorizontalResolution>
	<VerticalResolution>600</VerticalResolution>
	</Print>
	<Selected/>
	<Panes>
	<Pane>
	<Number>3</Number>
	<ActiveRow>12</ActiveRow>
	<ActiveCol>1</ActiveCol>
	</Pane>
	</Panes>
	<ProtectObjects>False</ProtectObjects>
	<ProtectScenarios>False</ProtectScenarios>
	</WorksheetOptions>
	</Worksheet>
	</Workbook>
	</cfxml>

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\ProductR_PP_Type_#huserid#.xls" output="#tostring(data)#">
    <cfheader name="Content-Disposition" value="inline; filename=ProductR_PP_Type_#huserid#.xls">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\ProductR_PP_Type_#huserid#.xls">
	</cfcase>

	<cfcase value="HTML">
    <html>
	<head>
	<title>Product Sales Report By REFNO</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	</head>
	<body>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",___.">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "_">
	</cfloop>
	<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Sales REPORT DETAIL (BY REFNO)</strong></font></div></td>
		</tr>
		<cfif isdefined("form.periodfrom") and form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
		</cfif>
		<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #form.datefrom# - #form.dateto#</font></div></td>
			</tr>
		</cfif>
		<cfif isdefined("form.categoryfrom") and trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.categoryfrom# - #form.categoryto#</font></div></td>
			</tr>
		</cfif>
		<cfif isdefined("form.groupfrom") and trim(form.groupfrom )neq "" and trim(form.groupto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif isdefined("form.productfrom") and trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">PRODUCT NO: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
        <cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">PROJECT: #form.projectfrom# - #form.projectto#</font></div></td>
			</tr>
		</cfif>
        <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">JOB: #form.jobfrom# - #form.jobto#</font></div></td>
			</tr>
		</cfif>
        <cfif trim(form.locationfrom) neq "" and trim(form.locationto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Location: #form.locationfrom# - #form.locationto#</font></div></td>
			</tr>
		</cfif>
        <cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Reference No.: #form.refnofrom# - #form.refnoto#</font></div></td>
			</tr>
		</cfif>
		<tr>
			<td colspan="3"><font size="2" face="Times New Roman, Times, serif">
			  #getgeneral.compro#
			</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="1"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td><font size="2" face="Times New Roman, Times, serif">A/C NAME</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">PRODUCT NO</font></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td><font size="2" face="Times New Roman, Times, serif">PRODUCT CODE</font></td>
            </cfif>
            <cfif getdisplaydetail.report_brand eq 'Y'>
            <td><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lbrand#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_category eq 'Y'>
            <td><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lcategory#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_group eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lgroup#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_sizeid eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lsize#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_colorid eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lmaterial#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_costcode eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lrating#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_shelf eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lmodel#</font></td>
            </cfif>
			<td><font size="2" face="Times New Roman, Times, serif">PRODUCT DESCRIPTION</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">CUST NO</font></td>
            <cfif lcase(hcomid) eq 'tcds_i'>
            <td><font size="2" face="Times New Roman, Times, serif">MEMBER</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">SALES PERSON</font></td>
            </cfif>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT PRICE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>

		<cfset totalqty = 0>
		<cfset totalamt = 0>
		<cfquery name="getgroup" datasource="#dts#">
		select a.refno,a.type,a.custno, a.name from ictran a, icitem b
		where (type = 'INV' or type = 'CS') and b.itemno = a.itemno and (void = '' or void is null)
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		and b.category >='#form.categoryfrom#' and b.category <='#form.categoryto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group >='#form.groupfrom#' and b.wos_group <='#form.groupto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and b.itemno >='#form.productfrom#' and b.itemno <= '#form.productto#'
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod+0 >= '#form.periodfrom#' and a.fperiod+0 <= '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
		<cfelse>
		and a.wos_date > #getgeneral.lastaccyear#
		</cfif>
        <cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
            and a.custno >='#form.customerfrom#' and a.custno <= '#form.customerto#'
        </cfif>
        
        <cfif form.projectfrom neq "" and form.projectto neq "">
            and a.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
            and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
        </cfif>
        <cfif form.jobfrom neq "" and form.jobto neq "">
            and a.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
            and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
        </cfif>
       <cfif trim(form.locationfrom) neq "" and trim(form.locationto) neq "">
        and location >='#form.locationfrom#' and location <= '#form.locationto#'
        </cfif>
		
        <cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
            and a.refno >='#form.refnofrom#' and a.refno <= '#form.refnoto#'
		</cfif>
        group by a.type,a.refno order by a.type,a.refno
	</cfquery>
		<cfloop query="getgroup">
        <cfset subqty = 0>
		<cfset subamt = 0>
			<tr>
				
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u>Bill No: #getgroup.type#</u></strong></font></td>
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u><a href='/billformat/#dts#/transactionformat.cfm?tran=#getgroup.type#&nexttranno=#getgroup.refno#'>#getgroup.refno#</a></u></strong></font></td>
			</tr>
			<cfquery name="getitem" datasource="#dts#">
				select a.*,b.* from ictran as a
                left join (select aitemno,brand,category,wos_group,costcode,sizeid,colorid,shelf,itemno from icitem)as b on a.itemno=b.itemno
				where a.type='#getgroup.type#' and a.refno='#getgroup.refno#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 >= '#form.periodfrom#' and a.fperiod+0 <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
				</cfif>
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno >='#form.productfrom#' and a.itemno <= '#form.productto#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and a.custno >='#form.customerfrom#' and a.custno <= '#form.customerto#'
				</cfif>
                and (a.void = '' or a.void is null)
                <cfif form.projectfrom neq "" and form.projectto neq "">
					and a.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
                <cfif form.jobfrom neq "" and form.jobto neq "">
					and a.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
                <cfif trim(form.refnofrom) neq "" and trim(form.refnoto) neq "">
                    and a.refno >='#form.refnofrom#' and a.refno <= '#form.refnoto#'
                </cfif>
			</cfquery>
            
            <cfloop query="getitem">
           <cfquery name="gettaxincl" datasource="#dts#">
            select taxincl from artran where type='#getitem.type#' and refno='#getitem.refno#'
            </cfquery>
            <cfif gettaxincl.taxincl eq 'T'>
            <cfset getitem.amt=getitem.amt-getitem.taxamt>
            <cfif getitem.qty neq 0>
            <cfset getitem.price=getitem.amt/getitem.qty>
            <cfelse>
            <cfset getitem.price=0>
            </cfif>
			</cfif>
				<cfset subqty = subqty + val(getitem.qty)>
				<cfset subamt = subamt + val(getitem.amt)>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
               		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
					<td><font size="2" face="Times New Roman, Times, serif"><a href='l_purchasereportITEM.cfm?itemno=#urlencodedformat(getitem.itemno)#'>#getitem.itemno#</font></a></td>
					<cfif getdisplaydetail.report_aitemno eq 'Y'>
            		<td><font size="2" face="Times New Roman, Times, serif">#getitem.aitemno#</font></td>
            		</cfif>
                    <cfif getdisplaydetail.report_brand eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.brand#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_category eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.category#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_group eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.wos_group#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_sizeid eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.sizeid#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_colorid eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.colorid#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_costcode eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.costcode#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_shelf eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.shelf#</font></div></td>
                    </cfif>
                    <td><font size="2" face="Times New Roman, Times, serif">#getitem.desp##getitem.despa#</font></td>
					<td><font size="2" face="Times New Roman, Times, serif"><a href='l_purchasereportCUST.cfm?custno=#urlencodedformat(getitem.custno)#'>#getitem.custno#</font></a></td>
                    <cfif lcase(hcomid) eq 'tcds_i'>
            		<td><font size="2" face="Times New Roman, Times, serif">#getitem.van#</font></td>
            		<td><font size="2" face="Times New Roman, Times, serif">#getitem.agenno#</font></td>
            		</cfif>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,'dd-mm-yyyy')#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(qty,"0")# #unit#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.price,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.amt,stDecl_UPrice)#</font></div></td>
				</tr>

			</cfloop>
            <cfset totalqty = totalqty + subqty>
			<cfset totalamt = totalamt + subamt>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td colspan="1"></td>
				<td><font size="2" face="Times New Roman, Times, serif">SUB-TOTAL</font></td>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
            	<td></td>
            	</cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
               <td></td>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <td></td>
                </cfif>
                <cfif lcase(hcomid) eq 'tcds_i'>
                <td colspan="2"></td>
                </cfif>
				<td colspan="2"></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subqty,"0")#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subamt,stDecl_UPrice)#</font></div></td>
			</tr>

		</cfloop>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td colspan="1"></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            	<td></td>
            	</cfif>
            <cfif getdisplaydetail.report_brand eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
               <td></td>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <td></td>
                </cfif>
                <cfif lcase(hcomid) eq 'tcds_i'>
                <td colspan="2"></td>
                </cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
			<td colspan="2"></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,"0")#</strong></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalamt,",.__")#</strong></font></div></td>
		</tr>
	  </table>

	<cfif getgroup.recordcount eq 0>
		<h3>Sorry, No records were found.</h3>
		<cfabort>
	</cfif>
	</cfoutput>
	<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()"><u>Print</u></a></font></div>
	<p><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
	</body>
	</html>
	</cfcase>
</cfswitch>
