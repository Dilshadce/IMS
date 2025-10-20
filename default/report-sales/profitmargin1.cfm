<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfif getgeneral.cost eq "FIXED">
	<cfset costingmethod = "Fixed Cost Method">
<cfelseif getgeneral.cost eq "MONTH">
	<cfset costingmethod = "Month Average Method">
<cfelseif getgeneral.cost eq "MOVING">
	<cfset costingmethod = "Moving Average Method">
<cfelseif getgeneral.cost eq "FIFO">
	<cfset costingmethod = "First In First Out Method">
<cfelse>
	<cfset costingmethod = "Last In First Out Method">
</cfif>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="columncount" default="8">

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

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
		<cfxml variable="data">
		<?mso-application progid="Excel.Sheet"?>
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
		<Styles>
			<Style ss:ID="Default" ss:Name="Normal">
				<Alignment ss:Vertical="Bottom"/>
				<Borders/>
				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
				<Interior/>
				<NumberFormat/>
				<Protection/>
			</Style>
			<Style ss:ID="s24">
				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
			</Style>
			<Style ss:ID="s25">
				<NumberFormat ss:Format="@"/>
			</Style>
			<Style ss:ID="s26">
				<NumberFormat ss:Format="#,###,###,##0"/>
			</Style>
			<Style ss:ID="s27">
				<NumberFormat ss:Format="#,###,###,##0.00"/>
			</Style>
			<Style ss:ID="s28">
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<NumberFormat ss:Format="@"/>
			</Style>
			<Style ss:ID="s29">
				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
			</Style>
			<Style ss:ID="s31">
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<NumberFormat ss:Format="#,###,###,##0"/>
			</Style>

			<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>

			<Style ss:ID="s33">
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<NumberFormat ss:Format="#,###,###,##0.00"/>
			</Style>
			<Style ss:ID="s34">
				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
			</Style>
			<Style ss:ID="s35">
				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
				<Font ss:FontName="Verdana" x:Family="Swiss"/>
			</Style>
			<Style ss:ID="s39">
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<NumberFormat ss:Format="#,###,###,##0"/>
			</Style>
			<Style ss:ID="s40">
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<NumberFormat ss:Format="#,###,###,##0.00"/>
			</Style>
			<Style ss:ID="s41">
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<Interior/>
				<NumberFormat ss:Format="Fixed"/>
			</Style>
			<Style ss:ID="s42">
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<NumberFormat ss:Format="Fixed"/>
			</Style>
			<Style ss:ID="s43">
				<NumberFormat ss:Format="Fixed"/>
			</Style>
			<Style ss:ID="s44">
				<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<Font ss:FontName="Verdana" x:Family="Swiss"/>
			</Style>
			<Style ss:ID="s46">
				<Alignment ss:Vertical="Center"/>
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<Font ss:FontName="Verdana" x:Family="Swiss"/>
			</Style>
			<Style ss:ID="s49">
				<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
				<Font ss:FontName="Verdana" x:Family="Swiss"/>
			</Style>
		</Styles>
		<Worksheet ss:Name="Product_Profit_Margin_Report">
        <cfset c=8>
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
        
        <cfoutput>
		<Table ss:ExpandedColumnCount="25" x:FullColumns="1" x:FullRows="1">
			<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
			<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
			<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
			<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="2"/>
			<Column ss:Index="7" ss:AutoFitWidth="0" ss:Width="63.75"/>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s34"><Data ss:Type="String">Product Profit Margin Report</Data></Cell>
			</Row>
			
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">Calculated by #costingmethod#</Data></Cell>
			</Row>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
				</Row>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CUST NO: #form.custfrom# - #form.custto#" output = "wddxText">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
				<Cell ss:MergeAcross="#c-2#" ss:StyleID="s44"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:MergeAcross="1" ss:StyleID="s49"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
			</Row>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:StyleID="s24"><Data ss:Type="String">Item No.</Data></Cell>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">Product Code.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lbrand#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lcategory#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lgroup#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lsize#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lmaterial#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lrating#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lmodel#.</Data></Cell>
                </cfif>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Item Description</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Qty Sold</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Sales</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Cost</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Profit</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Margin</Data></Cell>
			</Row>

			<cfset totalqty = 0>
			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>

			<cfquery name="getactualsales" datasource="#dts#">
				select a.itemno,a.desp,a.despa,a.category,a.aitemno,a.wos_group,a.brand,a.sizeid,a.colorid,a.costcode,a.shelf,b.sumqty,b.sumamt,b.sumcost,(ifnull(b.sumamt,0)-ifnull(b.sumcost,0))as profit,
				(((ifnull(b.sumamt,0)-ifnull(b.sumcost,0))/ifnull(b.sumamt,0))*100) as margin from icitem as a
				left join
				(select itemno,sum(qty)-sum(cnqty) as sumqty,sum(amt)-sum(cnamt) as sumamt,sum(it_cos) as sumcost,wos_group
				from ictran where (void = '' or void is null) and (type = 'INV' or type = 'CS' or type = 'DN')
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno >= '#form.custfrom#' and custno <= '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by itemno order by itemno) as b on a.itemno=b.itemno

				where a.itemno <> ""
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and form.itemto neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and d.wos_group between "#form.groupfrom#" and "#form.groupto#"
				</cfif>
                <cfif isdefined('form.include0')>
                and b.sumqty <> 0 
				</cfif>
				order by a.category,a.wos_group,a.itemno
			</cfquery>

			<cfloop query="getactualsales">
				<cfset totalqty = totalqty + val(getactualsales.sumqty)>
				<cfset totalsales = totalsales + val(getactualsales.sumamt)>
				<cfset totalcost =totalcost + val(getactualsales.sumcost)>
				<cfset totalprofit = totalprofit + val(getactualsales.profit)>
				<Row>
					<cfwddx action = "cfml2wddx" input = "#getactualsales.itemno#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.aitemno#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    <cfif getdisplaydetail.report_brand eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.brand#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    <cfif getdisplaydetail.report_category eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.category#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    <cfif getdisplaydetail.report_group eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.wos_group#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    <cfif getdisplaydetail.report_sizeid eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.sizeid#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    <cfif getdisplaydetail.report_colorid eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.colorid#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    <cfif getdisplaydetail.report_costcode eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.costcode#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    <cfif getdisplaydetail.report_shelf eq 'Y'>
                    <cfwddx action = "cfml2wddx" input = "#getactualsales.shelf#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
                    
                    
					<cfwddx action = "cfml2wddx" input = "#getactualsales.desp##getactualsales.despa#" output = "wddxText">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
					<Cell ss:StyleID="s31"><Data ss:Type="Number">#val(getactualsales.sumqty)#</Data></Cell>
					<Cell ss:StyleID="s33"><Data ss:Type="Number">#val(getactualsales.sumamt)#</Data></Cell>
					<Cell ss:StyleID="s33"><Data ss:Type="Number">#val(getactualsales.sumcost)#</Data></Cell>
					<Cell ss:StyleID="s33"><Data ss:Type="Number">#val(getactualsales.profit)#</Data></Cell>
					<Cell ss:StyleID="s42"><Data ss:Type="Number">#val(getactualsales.margin)#</Data></Cell>
				</Row>
			</cfloop>

			<Row ss:Height="12">
				<Cell ss:StyleID="s29"/>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <Cell ss:StyleID="s29"/>
                </cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                    <Cell ss:StyleID="s29"/>
                    </cfif>
                    <cfif getdisplaydetail.report_category eq 'Y'>
                    <Cell ss:StyleID="s29"/>
                    </cfif>
                    <cfif getdisplaydetail.report_group eq 'Y'>
                    <Cell ss:StyleID="s29"/>
                    </cfif>
                    <cfif getdisplaydetail.report_sizeid eq 'Y'>
                    <Cell ss:StyleID="s29"/>
                    </cfif>
                    <cfif getdisplaydetail.report_colorid eq 'Y'>
                    <Cell ss:StyleID="s29"/>
                    </cfif>
                    <cfif getdisplaydetail.report_costcode eq 'Y'>
                    <Cell ss:StyleID="s29"/>
                    </cfif>
                    <cfif getdisplaydetail.report_shelf eq 'Y'>
                    <Cell ss:StyleID="s29"/>
                    </cfif>
                
				<Cell ss:StyleID="s29"/>
				<Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totalqty,"0")#</Data></Cell>
				<Cell ss:StyleID="s40"><Data ss:Type="Number">#numberformat(totalsales,",.__")#</Data></Cell>
				<Cell ss:StyleID="s40"><Data ss:Type="Number">#numberformat(totalcost,",.__")#</Data></Cell>
				<Cell ss:StyleID="s40"><Data ss:Type="Number">#numberformat(totalprofit,",.__")#</Data></Cell>
				<cfif totalsales neq 0 and totalprofit neq 0>
					<Cell ss:StyleID="s41"><Data ss:Type="Number">#val(((totalprofit / totalsales)* 100))#</Data></Cell>
				<cfelse>
					<Cell ss:StyleID="s41"><Data ss:Type="Number">0</Data></Cell>
				</cfif>
			</Row>
			
			<Row ss:Height="12"/>
		</Table>
        </cfoutput>
		</Worksheet>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin_#huserid#.xls">
	</cfcase>

	<cfcase value="EXCELGROUP">
		<cfxml variable="data">
		<?mso-application progid="Excel.Sheet"?>
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
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
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
  			<Style ss:ID="s28">
   				<Alignment ss:Vertical="Center"/>
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
  			<Style ss:ID="s30">
   				<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
  			<Style ss:ID="s32">
   				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
  			</Style>
  			<Style ss:ID="s33">
   				<Alignment ss:Vertical="Center"/>
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
  			</Style>
  			<Style ss:ID="s34">
   				<NumberFormat ss:Format="@"/>
  			</Style>
  			<Style ss:ID="s35">
   				<NumberFormat ss:Format="#,###,###,##0"/>
  			</Style>

			<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>

			<Style ss:ID="s36">
   				<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
  			</Style>
  			<Style ss:ID="s37">
   				<NumberFormat ss:Format="Fixed"/>
  			</Style>
  			<Style ss:ID="s38">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="@"/>
  			</Style>
  			<Style ss:ID="s39">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="#,###,###,##0"/>
  			</Style>
  			<Style ss:ID="s40">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="#,###,###,##0.00"/>
  			</Style>
  			<Style ss:ID="s41">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="Fixed"/>
  			</Style>
  			<Style ss:ID="s42">
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
  			</Style>
  			<Style ss:ID="s43">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="#,###,###,##0"/>
  			</Style>
  			<Style ss:ID="s44">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
  			</Style>
  			<Style ss:ID="s45">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="Fixed"/>
  			</Style>
 		</Styles>
		<Worksheet ss:Name="Product_Profit_Margin_Report">
		<Table ss:ExpandedColumnCount="10" x:FullColumns="1" x:FullRows="1">
			<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
			<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
			<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
			<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="2"/>
			<Column ss:Index="7" ss:AutoFitWidth="0" ss:Width="63.75"/>

			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s22"><Data ss:Type="String">Product Profit Margin Report - By Group</Data></Cell>
			</Row>
			<cfoutput>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s24"><Data ss:Type="String">Calculated by #costingmethod#</Data></Cell>
			</Row>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="6" ss:StyleID="s24"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
				</Row>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="6" ss:StyleID="s24"><Data ss:Type="String">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CUST NO: #form.custfrom# - #form.custto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
				<Cell ss:MergeAcross="2" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
				<Cell ss:StyleID="s28"/>
				<Cell ss:StyleID="s28"/>
				<Cell ss:MergeAcross="1" ss:StyleID="s30"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
			</Row>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:StyleID="s32"><Data ss:Type="String">Item No.</Data></Cell>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <Cell ss:StyleID="s32"><Data ss:Type="String">Product Code.</Data></Cell>
                </cfif>
                
				<Cell ss:StyleID="s32"><Data ss:Type="String">Item Description</Data></Cell>
				<Cell ss:StyleID="s32"><Data ss:Type="String">Qty Sold</Data></Cell>
				<Cell ss:StyleID="s32"><Data ss:Type="String">Sales</Data></Cell>
				<Cell ss:StyleID="s32"><Data ss:Type="String">Cost</Data></Cell>
				<Cell ss:StyleID="s32"><Data ss:Type="String">Profit</Data></Cell>
				<Cell ss:StyleID="s32"><Data ss:Type="String">Margin</Data></Cell>
			</Row> --->

			<cfquery name="getgroup" datasource="#dts#">
				select wos_group from icitem where itemno <> ''
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and category >= '#form.catefrom#' and category <= '#form.cateto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and itemno >= '#form.itemfrom#' and itemno <= '#form.itemto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and wos_group >= "#form.groupfrom#" and wos_group <= "#form.groupto#"
				</cfif>
				group by wos_group order by wos_group
			</cfquery>

			<cfset totalqty = 0>
			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>
			<cfset row = 0>

			<cfloop query="getgroup">
				<cfset wos_group = getgroup.wos_group>
				<cfset subqty = 0>
				<cfset subsales = 0>
				<cfset subcost = 0>
				<cfset subprofit = 0>

				<Row ss:AutoFitHeight="0" ss:Height="12"/>
				<Row ss:AutoFitHeight="0" ss:Height="15">
					<cfif getgroup.wos_group eq "">
						<Cell ss:StyleID="s33"><Data ss:Type="String">GROUP: No-Grouped</Data></Cell>
						<Cell ss:StyleID="s33"><Data ss:Type="String">No-Grouped</Data></Cell>
					<cfelse>
						<cfquery name="getgroupname" datasource="#dts#">
							select desp from icgroup where wos_group = '#wos_group#'
						</cfquery>
						<cfwddx action = "cfml2wddx" input = "GROUP: #wos_group#" output = "wddxText">
						<Cell ss:StyleID="s33"><Data ss:Type="String">#wddxText#</Data></Cell>
						<cfwddx action = "cfml2wddx" input = "#getgroupname.desp#" output = "wddxText">
						<Cell ss:StyleID="s33"><Data ss:Type="String">#wddxText#</Data></Cell>
					</cfif>
					<Cell ss:StyleID="s33"/>
					<Cell ss:StyleID="s33"/>
					<Cell ss:StyleID="s33"/>
					<Cell ss:StyleID="s33"/>
					<Cell ss:StyleID="s33"/>
				</Row>
				<cfquery name="getitem" datasource="#dts#">
					select itemno,desp,despa,aitemno from icitem where itemno <> '' and wos_group = '#wos_group#'
					<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category >= '#form.catefrom#' and category <= '#form.cateto#'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno >= '#form.itemfrom#' and itemno <= '#form.itemto#'
					</cfif>
					group by itemno order by itemno
				</cfquery>

				<cfloop query="getitem">
					<cfquery name="getactualsales" datasource="#dts#">
						select sum(qty)-sum(cnqty) as sumqty, sum(amt)-sum(cnamt) as sumamt, sum(it_cos) as sumcost,(sum(amt)-sum(it_cos)) as profit,
						(((sum(amt)-sum(it_cos))/sum(amt))*100) as margin
						from ictran where (void = '' or void is null) and itemno = '#getitem.itemno#' and (type = 'inv' or type = 'cs' or type = 'dn')
						<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
						and custno >= '#form.custfrom#' and custno <= '#form.custto#'
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
						<cfelse>
						and wos_date > #getgeneral.lastaccyear#
						</cfif>
						group by itemno order by itemno
					</cfquery>

					<cfset subqty = subqty + val(getactualsales.sumqty)>
					<cfset totalqty = totalqty + val(getactualsales.sumqty)>
					<cfset subsales = subsales + val(getactualsales.sumamt)>
					<cfset totalsales = totalsales + val(getactualsales.sumamt)>
					<cfset subcost = subcost + val(getactualsales.sumcost)>
					<cfset totalcost = totalcost + val(getactualsales.sumcost)>
					<cfset subprofit = subprofit + val(getactualsales.profit)>
					<cfset totalprofit = totalprofit + val(getactualsales.profit)>

					<Row ss:AutoFitHeight="0">
						<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText">
						<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText#</Data></Cell>
                        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText">
						<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </cfif>
						<cfwddx action = "cfml2wddx" input = "#getitem.desp##getitem.despa#" output = "wddxText">
						<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s35"><Data ss:Type="Number">#val(getactualsales.sumqty)#</Data></Cell>
						<Cell ss:StyleID="s36"><Data ss:Type="Number">#val(getactualsales.sumamt)#</Data></Cell>
						<Cell ss:StyleID="s36"><Data ss:Type="Number">#val(getactualsales.sumcost)#</Data></Cell>
						<Cell ss:StyleID="s36"><Data ss:Type="Number">#val(getactualsales.profit)#</Data></Cell>
						<Cell ss:StyleID="s37"><Data ss:Type="Number">#val(getactualsales.margin)#</Data></Cell>
					</Row>
				</cfloop>
				<Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:StyleID="s42"/>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <Cell ss:Index="4" ss:StyleID="s43"><Data ss:Type="Number">#val(subqty)#</Data></Cell>
                    <cfelse>
					<Cell ss:Index="3" ss:StyleID="s43"><Data ss:Type="Number">#val(subqty)#</Data></Cell>
					</cfif>
                    <Cell ss:StyleID="s44"><Data ss:Type="Number">#val(subsales)#</Data></Cell>
					<Cell ss:StyleID="s44"><Data ss:Type="Number">#val(subcost)#</Data></Cell>
					<Cell ss:StyleID="s44"><Data ss:Type="Number">#val(subprofit)#</Data></Cell>
					<cfif subsales neq 0 and subprofit neq 0>
						<Cell ss:StyleID="s45"><Data ss:Type="Number">#val(((subprofit / subsales)* 100))#</Data></Cell>
					<cfelse>
						<Cell ss:StyleID="s45"><Data ss:Type="Number">0</Data></Cell>
					</cfif>
				</Row>
			</cfloop>
			<Row ss:AutoFitHeight="0" ss:Height="12"/>
		   	<Row ss:AutoFitHeight="0"/>
		   	<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s42"><Data ss:Type="String">Grand Total</Data></Cell>
				<Cell ss:Index="3" ss:StyleID="s43"><Data ss:Type="Number">#val(totalqty)#</Data></Cell>
				<Cell ss:StyleID="s44"><Data ss:Type="Number">#val(totalsales)#</Data></Cell>
				<Cell ss:StyleID="s44"><Data ss:Type="Number">#val(totalcost)#</Data></Cell>
				<Cell ss:StyleID="s44"><Data ss:Type="Number">#val(totalprofit)#</Data></Cell>
				<cfif totalsales neq 0 and totalprofit neq 0>
					<Cell ss:StyleID="s45"><Data ss:Type="Number">#val(((totalprofit / totalsales)* 100))#</Data></Cell>
				<cfelse>
					<Cell ss:StyleID="s45"><Data ss:Type="Number">0</Data></Cell>
				</cfif>
		   	</Row>
			</cfoutput>
			<Row ss:AutoFitHeight="0" ss:Height="12"/>
		</Table>
		</Worksheet>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin-By_Group_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin-By_Group_#huserid#.xls">
	</cfcase>

	<cfcase value="EXCELNODISCOUNT">
		<cfxml variable="data">
		<?mso-application progid="Excel.Sheet"?>
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
		<Styles>
  			<Style ss:ID="Default" ss:Name="Normal">
   				<Alignment ss:Vertical="Bottom"/>
   				<Borders/>
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
   				<Interior/>
   				<NumberFormat/>
   				<Protection/>
  			</Style>
  			<Style ss:ID="s24">
   				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   				<Borders>
    			<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    			<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
  			</Style>
  			<Style ss:ID="s25">
   				<NumberFormat ss:Format="@"/>
  			</Style>
  			<Style ss:ID="s26">
   				<NumberFormat ss:Format="#,###,###,##0"/>
  			</Style>

			<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>

  			<Style ss:ID="s27">
   				<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
  			</Style>
  			<Style ss:ID="s29">
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
  			</Style>
  			<Style ss:ID="s34">
   				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
  			</Style>
  			<Style ss:ID="s35">
   				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
  			<Style ss:ID="s38">
   				<NumberFormat ss:Format="Fixed"/>
  			</Style>
  			<Style ss:ID="s40">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="#,###,###,##0"/>
  			</Style>
  			<Style ss:ID="s41">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="#,###,###,##0.00"/>
  			</Style>
  			<Style ss:ID="s42">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<Interior/>
   				<NumberFormat ss:Format="Fixed"/>
  			</Style>
  			<Style ss:ID="s43">
   				<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
  			<Style ss:ID="s45">
   				<Alignment ss:Vertical="Center"/>
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
  			<Style ss:ID="s48">
   				<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
 		</Styles>

		<Worksheet ss:Name="Product_Profit_Margin_Report">
  		<Table ss:ExpandedColumnCount="10" x:FullColumns="1" x:FullRows="1">
   			<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="2"/>
   			<Column ss:Index="7" ss:AutoFitWidth="0" ss:Width="63.75"/>
   			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    			<Cell ss:MergeAcross="6" ss:StyleID="s34"><Data ss:Type="String">Product Profit Margin Report - Sales Without Discount</Data></Cell>
   			</Row>
   			<cfoutput>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
    			<Cell ss:MergeAcross="6" ss:StyleID="s35"><Data ss:Type="String">Calculated by #costingmethod#</Data></Cell>
   			</Row>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="6" ss:StyleID="s35"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
				</Row>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="6" ss:StyleID="s35"><Data ss:Type="String">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CUST NO: #form.custfrom# - #form.custto#" output = "wddxText">
					<Cell ss:MergeAcross="6" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
    			<Cell ss:MergeAcross="2" ss:StyleID="s43"><Data ss:Type="String">#wddxText#</Data></Cell>
    			<Cell ss:StyleID="s45"/>
    			<Cell ss:StyleID="s45"/>
    			<Cell ss:MergeAcross="1" ss:StyleID="s48"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
   			</Row>

			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Item No.</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Item Description</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Qty Sold</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Sales</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Cost</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Profit</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Margin</Data></Cell>
   			</Row>

   			<cfset totalqty = 0>
			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>

			<cfquery name="getactualsales" datasource="#dts#">
				select a.itemno,a.desp,a.despa,b.sumqty,b.sumamt,b.sumcost,(ifnull(b.sumamt,0)-ifnull(b.sumcost,0))as profit,
				(((ifnull(b.sumamt,0)-ifnull(b.sumcost,0))/ifnull(b.sumamt,0))*100) as margin from icitem as a
				left join
				(select itemno,sum(qty)-sum(cnqty) as sumqty,sum(amt)-sum(cnamt) as sumamt,sum(it_cos) as sumcost
				from ictran where (void = '' or void is null) and (type = 'INV' or type = 'CS' or type = 'DN') and disamt = '0'
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno >= '#form.custfrom#' and custno <= '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by itemno order by itemno) as b on a.itemno=b.itemno

				where a.itemno <> ""
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between "#form.groupfrom#" and "#form.groupto#"
				</cfif>
                <cfif isdefined('form.include0')>
                and b.sumqty <> 0 
				</cfif>
			</cfquery>

			<cfloop query="getactualsales">
				<cfset totalqty = totalqty + val(getactualsales.sumqty)>
				<cfset totalsales = totalsales + val(getactualsales.sumamt)>
				<cfset totalcost =totalcost + val(getactualsales.sumcost)>
				<cfset totalprofit = totalprofit + val(getactualsales.profit)>

				<Row ss:Height="12">
					<cfwddx action = "cfml2wddx" input = "#getactualsales.itemno#" output = "wddxText">
    				<Cell ss:StyleID="s25"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getactualsales.desp##getactualsales.despa#" output = "wddxText">
    				<Cell ss:StyleID="s25"><Data ss:Type="String">#wddxText#</Data></Cell>
    				<Cell ss:StyleID="s26"><Data ss:Type="Number">#val(getactualsales.sumqty)#</Data></Cell>
    				<Cell ss:StyleID="s27"><Data ss:Type="Number">#val(getactualsales.sumamt)#</Data></Cell>
    				<Cell ss:StyleID="s27"><Data ss:Type="Number">#val(getactualsales.sumcost)#</Data></Cell>
    				<Cell ss:StyleID="s27"><Data ss:Type="Number">#val(getactualsales.profit)#</Data></Cell>
    				<Cell ss:StyleID="s38"><Data ss:Type="Number">#val(getactualsales.margin)#</Data></Cell>
   				</Row>
			</cfloop>
   			<Row ss:Height="12">
    			<Cell ss:StyleID="s29"/>
    			<Cell ss:Index="3" ss:StyleID="s40"><Data ss:Type="Number">#val(totalqty)#</Data></Cell>
    			<Cell ss:StyleID="s41"><Data ss:Type="Number">#val(totalsales)#</Data></Cell>
    			<Cell ss:StyleID="s41"><Data ss:Type="Number">#val(totalcost)#</Data></Cell>
    			<Cell ss:StyleID="s41"><Data ss:Type="Number">#val(totalprofit)#</Data></Cell>
    			<cfif totalsales neq 0 and totalprofit neq 0>
					<Cell ss:StyleID="s42"><Data ss:Type="Number">#val(((totalprofit / totalsales)* 100))#</Data></Cell>
				<cfelse>
					<Cell ss:StyleID="s42"><Data ss:Type="Number">0</Data></Cell>
				</cfif>
   			</Row>
			</cfoutput>
   			<Row ss:Height="12"/>
  		</Table>
 		</Worksheet>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin-Discount_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin-Discount_#huserid#.xls">
	</cfcase>

	<cfcase value="EXCELXCOST">
		<cfxml variable="data">
		<?mso-application progid="Excel.Sheet"?>
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
		<Styles>
  			<Style ss:ID="Default" ss:Name="Normal">
   				<Alignment ss:Vertical="Bottom"/>
   				<Borders/>
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
   				<Interior/>
   				<NumberFormat/>
   				<Protection/>
  			</Style>
  			<Style ss:ID="s24">
   				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
  			</Style>
  			<Style ss:ID="s25">
   				<NumberFormat ss:Format="@"/>
  			</Style>
  			<Style ss:ID="s26">
   				<NumberFormat ss:Format="#,###,###,##0"/>
  			</Style>

			<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>

			<Style ss:ID="s27">
   				<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
  			</Style>
  			<Style ss:ID="s29">
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
  			</Style>
  			<Style ss:ID="s34">
   				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
  			</Style>
  			<Style ss:ID="s35">
   				<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   				<Font ss:FontName="Verdana" x:Family="Swiss"/>
  			</Style>
  			<Style ss:ID="s37">
   				<Borders>
    				<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    				<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   				</Borders>
   				<NumberFormat ss:Format="#,###,###,##0"/>
  			</Style>
  			<Style ss:ID="s38">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<NumberFormat ss:Format="#,###,###,##0.00"/>
		  	</Style>
		  	<Style ss:ID="s39">
		   		<NumberFormat ss:Format="Fixed"/>
		  	</Style>
		  	<Style ss:ID="s40">
		  	 	<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<NumberFormat ss:Format="Fixed"/>
		  	</Style>
		  	<Style ss:ID="s41">
		   		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		  	<Style ss:ID="s43">
		  	 	<Alignment ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		  	<Style ss:ID="s46">
		   		<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		</Styles>
 		<Worksheet ss:Name="Product_Profit_Margin_Report">
  		<Table ss:ExpandedColumnCount="10" x:FullColumns="1" x:FullRows="1">
   			<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="3"/>
   			<Column ss:Index="8" ss:AutoFitWidth="0" ss:Width="63.75"/>
   			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    			<Cell ss:MergeAcross="7" ss:StyleID="s34"><Data ss:Type="String">Product Profit Margin Report - With Additional Cost</Data></Cell>
   			</Row>
			<cfoutput>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
    			<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">Calculated by #costingmethod#</Data></Cell>
   			</Row>

			<cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
				</Row>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
					<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
					<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
					<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "CUST NO: #form.custfrom# - #form.custto#" output = "wddxText">
					<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfif>
   			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
    			<Cell ss:MergeAcross="2" ss:StyleID="s41"><Data ss:Type="String">
                <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
                #wddxText#
                </Data></Cell>
    			<Cell ss:StyleID="s43"/>
    			<Cell ss:StyleID="s43"/>
    			<Cell ss:StyleID="s43"/>
    			<Cell ss:MergeAcross="1" ss:StyleID="s46"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
   			</Row>

			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Item No.</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Item Description</Data></Cell>
   				<Cell ss:StyleID="s24"><Data ss:Type="String">Qty Sold</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Sales</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Oth.Charges</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Cost</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Profit</Data></Cell>
    			<Cell ss:StyleID="s24"><Data ss:Type="String">Margin</Data></Cell>
   			</Row>

			<cfset totalqty = 0>
			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>
			<cfset totalxcost = 0>

			<cfquery name="getactualsales" datasource="#dts#">
				select a.itemno,a.desp,a.despa,b.sumqty,b.sumamt,b.sumcost,(ifnull(b.sumamt,0)-ifnull(b.sumcost,0))as profit,
				(((ifnull(b.sumamt,0)-ifnull(b.sumcost,0))/ifnull(b.sumamt,0))*100) as margin,b.sumxcost from icitem as a
				left join
				(select itemno,sum(qty)-sum(cnqty) as sumqty,sum(amt)-sum(cnamt) as sumamt,sum(it_cos) as sumcost,
				sum(m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7) as sumxcost
				from ictran where (void = '' or void is null) and (type = 'INV' or type = 'CS' or type = 'DN') and disamt = '0'
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno >= '#form.custfrom#' and custno <= '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by itemno order by itemno) as b on a.itemno=b.itemno

				where a.itemno <> ""
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between "#form.groupfrom#" and "#form.groupto#"
				</cfif>
                <cfif isdefined('form.include0')>
                and b.sumqty <> 0 
				</cfif>
			</cfquery>

			<cfloop query="getactualsales">
				<cfset totalqty = totalqty + val(getactualsales.sumqty)>
				<cfset totalsales = totalsales + val(getactualsales.sumamt)>
				<cfset totalcost =totalcost + val(getactualsales.sumcost)>
				<cfset totalprofit = totalprofit + val(getactualsales.profit)>
				<cfset totalxcost = totalxcost + val(getactualsales.sumxcost)>
				<Row ss:Height="12">
					<cfwddx action = "cfml2wddx" input = "#getactualsales.itemno#" output = "wddxText">
    				<Cell ss:StyleID="s25"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getactualsales.desp##getactualsales.despa#" output = "wddxText">
    				<Cell ss:StyleID="s25"><Data ss:Type="String">#wddxText#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="Number">#val(getactualsales.sumqty)#</Data></Cell>
    				<Cell ss:StyleID="s27"><Data ss:Type="Number">#val(getactualsales.sumamt)#</Data></Cell>
    				<Cell ss:StyleID="s27"><Data ss:Type="Number">#val(getactualsales.sumxcost)#</Data></Cell>
    				<Cell ss:StyleID="s27"><Data ss:Type="Number">#val(getactualsales.sumcost)#</Data></Cell>
    				<Cell ss:StyleID="s27"><Data ss:Type="Number">#val(getactualsales.profit)#</Data></Cell>
    				<Cell ss:StyleID="s39"><Data ss:Type="Number">#val(getactualsales.margin)#</Data></Cell>
   				</Row>
			</cfloop>
   			<Row ss:Height="12">
    			<Cell ss:StyleID="s29"/>
    			<Cell ss:Index="3" ss:StyleID="s37"><Data ss:Type="Number">#val(totalqty)#</Data></Cell>
    			<Cell ss:StyleID="s38"><Data ss:Type="Number">#val(totalsales)#</Data></Cell>
    			<Cell ss:StyleID="s38"><Data ss:Type="Number">#val(totalxcost)#</Data></Cell>
    			<Cell ss:StyleID="s38"><Data ss:Type="Number">#val(totalcost)#</Data></Cell>
    			<Cell ss:StyleID="s38"><Data ss:Type="Number">#val(totalprofit)#</Data></Cell>
				<cfif totalsales neq 0 and totalprofit neq 0>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">#val(((totalprofit / totalsales)* 100))#</Data></Cell>
				<cfelse>
					<Cell ss:StyleID="s40"><Data ss:Type="Number">0</Data></Cell>
				</cfif>
   			</Row>
			</cfoutput>
   			<Row ss:Height="12"/>
  		</Table>
 		</Worksheet>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin-Additional_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Product_Profit_Margin-Additional_#huserid#.xls">
	</cfcase>

	<cfcase value="HTML">
		<html>
		<head>
		<title>Profit Margin By Product Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<body>
		<cfif isdefined("form.withcategory")>
			<cfset columncount = columncount + 1>		
		</cfif>
		<cfset firstcolcnt = round(columncount/2)>
		<cfset secondcolcnt = columncount - val(firstcolcnt)>
		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Print #url.trantype# Report</strong></font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Calculated by #costingmethod#</strong></font></div></td>
			</tr>

			<tr>
				<td colspan="#firstcolcnt#"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				
				<td colspan="#secondcolcnt#"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(date1,"dd/mm/yyyy")# - #dateformat(date2,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST NO: #form.custfrom# - #form.custto#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td><font size="2" face="Times New Roman, Times, serif">NO.</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></td>
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
				<td><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY SOLD</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SALES</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PROFIT</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">% PROFIT</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>

			<cfset subqty = 0>
			<cfset subsales = 0>
			<cfset subcost = 0>
			<cfset subprofit = 0>
			<cfset totalqty = 0>
			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>
			<cfset row = 0>
			
			<cfquery name="getitem" datasource="#dts#">
				select a.itemno,a.desp,a.despa,a.category,a.wos_group,a.brand,a.sizeid,a.colorid,a.costcode,a.shelf,a.aitemno,b.categorydesp,c.groupdesp,
				d.sumqty,d.sumamt,d.sumcost
				from icitem a
				
				left join
				(
					select cate,desp as categorydesp
					from iccate
					<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
						where cate >= '#form.catefrom#' and cate <= '#form.cateto#'
					</cfif>
				)as b on a.category=b.cate
				
				left join
				(
					select wos_group,desp as groupdesp
					from icgroup
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						where wos_group >= '#form.catefrom#' and wos_group <= '#form.cateto#'
					</cfif>
				)as c on a.wos_group=c.wos_group
				
				left join
				(
					select sum(qty)-sum(cnqty) as sumqty,sum(amt)-sum(cnamt) as sumamt, sum(it_cos) as sumcost,itemno,wos_group
					from ictran 
					where (void = '' or void is null) and (type = 'inv' or type = 'cs' or type = 'dn')
					<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
						and custno >= '#form.custfrom#' and custno <= '#form.custto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date >= #date1# and wos_date <= #date2#
					<cfelse>
						and wos_date > #getgeneral.lastaccyear#
					</cfif>
                    <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group >='#form.groupfrom#' and wos_group <= '#form.groupto#'
					</cfif>
					group by itemno
				)as d on a.itemno=d.itemno
				
				where a.itemno <> '' 
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and a.category >= '#form.catefrom#' and a.category <= '#form.cateto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and a.itemno >= '#form.itemfrom#' and a.itemno <= '#form.itemto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and d.wos_group >='#form.groupfrom#' and d.wos_group <= '#form.groupto#'
				</cfif>
                <cfif isdefined('form.include0')>
                and d.sumqty <> 0 
				</cfif>
				order by a.itemno
			</cfquery>
			
			<cfset thisgroup = "XXXXXXXXXXXXXXXX">
			<cfset thiscolumncount = columncount - 5>
			<cfloop query="getitem">
				<cfif thisgroup neq getitem.wos_group>
					<cfif isdefined("form.withgroup")>				
					<cfelse>
						<cfif thisgroup neq "XXXXXXXXXXXXXXXX">
							<tr>
								<td colspan="100%"><hr></td>
							</tr>
							<tr>
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
                                
								<td colspan="#thiscolumncount#"><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
                                
								<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subqty,"0")#</font></div></td>
								<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subsales,stDecl_UPrice)#</font></div></td>
								<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subcost,stDecl_UPrice)#</font></div></td>
								<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subprofit,stDecl_UPrice)#</font></div></td>
								<cfif subsales neq 0 and subprofit neq 0>
									<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(((subprofit / subsales)* 100),"0.00")#</font></div></td>
								<cfelse>
									<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(0,"0.00")#</font></div></td>
								</cfif>
							</tr>
							<tr><td><br></td></tr>
						</cfif>
					</cfif>
								
					<cfset subqty = 0>
					<cfset subsales = 0>
					<cfset subcost = 0>
					<cfset subprofit = 0>
					<cfset thisgroup = getitem.wos_group>
					
					<cfif isdefined("form.withgroup")>
					<cfelse>
						<cfif thisgroup eq "">
							<cfset getitem.wos_group = "No - Grouped">
							<cfset getitem.groupdesp = "No - Grouped">
						</cfif>
						<tr>
							<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><u><strong>Group: #getitem.wos_group#</strong></u></font></td>
							<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><u><strong>#getitem.groupdesp#</strong></u></font></td>	
						</tr>
					</cfif>
				</cfif>

				<cfset cost = val(getitem.sumcost)>
				<cfset profit = val(getitem.sumamt) - cost>
				<cfset subqty = subqty + val(getitem.sumqty)>
				<cfset totalqty = totalqty + val(getitem.sumqty)>
				<cfset subsales = subsales + val(getitem.sumamt)>
				<cfset totalsales = totalsales + val(getitem.sumamt)>
				<cfset subcost = subcost + cost>
				<cfset totalcost = totalcost + cost>
				<cfset subprofit = subprofit + profit>
				<cfset totalprofit = totalprofit + profit>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<cfset row = row + 1>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#row#.</font></div></td>
					
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.aitemno#</font></div></td>
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
                    
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp##getitem.despa#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(getitem.sumqty,"0")#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(getitem.sumamt,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(cost,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(profit,stDecl_UPrice)#</font></div></td>
					<cfif getitem.sumamt neq 0 and profit neq 0 and getitem.sumamt neq "">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(profit / getitem.sumamt * 100,"0.00")#</font></div></td>
					<cfelse>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(0,"0.00")#</font></div></td>
					</cfif>
				</tr>
			</cfloop>
			<cfif isdefined("form.withgroup")>				
			<cfelse>
				<tr>
					<td colspan="100%"><hr></td>
				</tr>
					<tr>
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
						<td colspan="#thiscolumncount#"><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subqty,"0")#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subsales,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subcost,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(subprofit,stDecl_UPrice)#</font></div></td>
						<cfif subsales neq 0 and subprofit neq 0>
							<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(((subprofit / subsales)* 100),"0.00")#</font></div></td>
						<cfelse>
							<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(0,"0.00")#</font></div></td>
						</cfif>
					</tr>
					<tr><td><br></td></tr>
			</cfif>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
                                <td></td>
                                </cfif>
				<td colspan="#thiscolumncount#"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalqty,"0")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalsales,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalcost,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalprofit,",.__")#</strong></font></div></td>
				<cfif totalsales neq 0 and totalprofit neq 0>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(((totalprofit / totalsales)* 100),"0.00")#</strong></font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(0,"0.00")#</strong></font></div></td>
				</cfif>
			</tr>
		</table>

		<cfif getitem.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>

		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		</cfoutput>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
	</cfcase>
</cfswitch>