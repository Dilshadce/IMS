<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
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
		  		<Style ss:ID="s30">
		   			<NumberFormat ss:Format="dd-mm-yy;@"/>
		  		</Style>
		  		<Style ss:ID="s31">
		  			<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s32">
		  	 		<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s33">
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s34">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="dd/mm/yyyy;@"/>
		  		</Style>
		  		<Style ss:ID="s35">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
		  		<Style ss:ID="s36">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s37">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s42">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="sheet 1">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">ITEMNO,C,60</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">DESP,C,100</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">DESPA,C,100</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">AITEMNO/ Product Code,C,40</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">BRAND,C,40</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">SUPP,C,12</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CATEGORY,C,80</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">WOS_GROUP,C,50</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">SIZEID (Size),C,20 </Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">COSTCODE (Rating) ,C,20 </Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">COLORID (Material),C,10</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">SHELF (Model),C,25</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PACKING,C,20</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">MINIMUM,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">MAXIMUM,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">REORDER,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">UNIT,C,12</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">UCOST,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PRICE,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PRICE2,D(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PRICE3,D(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PRICE4,D(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">SERIALNO(Y/N),C,1</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">GRADED(Y/N),C,1</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTY2 (Length),D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTY3 (Width),D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTY4 (Thickness),D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTY5 (Weight/Length),D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTY6 (Price/Weight),D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTYBF,D,(17,7)</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">SALEC (Credit Sales),C,8</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">SALECSC (Cash Sales),C,8</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">SALECNC (Sales Return),C,8</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PURC (Purchase),C,8</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PURPREC (Purchase Return),C,8</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">UNIT2,C,12</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FACTOR1,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FACTOR2,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PRICEU2,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">REMARK 1,C,100</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">BARCODEC,80</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CUST PRICE RATE(normal,offer,others)C,45</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN CURRCODE,C,45</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN COST,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN PRICE,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN CURRCODE2,C,45</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN COST2,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN PRICE2,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN CURRCODE3,C,45</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN COST3,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN PRICE3,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN CURRCODE 4,C,45</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN COST 4,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN PRICE 4,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN CURRCODE5,C,45</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN COST5,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FOREIGN PRICE5,D,(17,7)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">ITEM TYPE(S,P,SV),C,45</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">COMMENT</Data></Cell>
				</Row>
				   
				
			<cfquery name="getcust" datasource="#dts#">
            select * from icitem
            where 0=0
            <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno >= '#form.productfrom#' and itemno <= '#form.productto#'
  			</cfif>
			<cfif form.catefrom neq "" and form.cateto neq "">
			and category >= '#form.catefrom#' and category <= '#form.cateto#'
  			</cfif>
			<cfif form.sizeidfrom neq "" and form.sizeidto neq "">
			and sizeid >= '#form.sizeidfrom#' and sizeid <= '#form.sizeidto#'
  			</cfif>
			<cfif form.costcodefrom neq "" and form.costcodeto neq "">
			and costcode >= '#form.costcodefrom#' and costcode <= '#form.costcodeto#'
  			</cfif>
			<cfif form.coloridfrom neq "" and form.coloridto neq "">
			and colorid >= '#form.coloridfrom#' and colorid <= '#form.coloridto#'
  			</cfif>
			<cfif form.shelffrom neq "" and form.shelfto neq "">
			and shelf >= '#form.shelffrom#' and shelf <= '#form.shelfto#'
  			</cfif>
			<cfif form.groupfrom neq "" and form.groupto neq "">
			and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
  			</cfif>
            </cfquery>
			
			<cfloop query="getcust">

				<cfoutput>
					<cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText2">
					<cfwddx action = "cfml2wddx" input = "#DESPA#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#aitemno#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#brand#" output = "wddxText5">
                    <cfwddx action = "cfml2wddx" input = "#supp#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#category#" output = "wddxText7">
                    <cfwddx action = "cfml2wddx" input = "#wos_group#" output = "wddxText8">
                    <cfwddx action = "cfml2wddx" input = "#sizeid#" output = "wddxText9">
                    <cfwddx action = "cfml2wddx" input = "#costcode#" output = "wddxText10">
                    <cfwddx action = "cfml2wddx" input = "#colorid#" output = "wddxText11">
                    <cfwddx action = "cfml2wddx" input = "#shelf#" output = "wddxText12">
                    <cfwddx action = "cfml2wddx" input = "#packing#" output = "wddxText13">
                    <cfwddx action = "cfml2wddx" input = "#unit#" output = "wddxText14">
                    <cfwddx action = "cfml2wddx" input = "#WSERIALNO#" output = "wddxText15">
                    <cfwddx action = "cfml2wddx" input = "#graded#" output = "wddxText16">
                    <cfwddx action = "cfml2wddx" input = "#SALEC#" output = "wddxText17">
                    <cfwddx action = "cfml2wddx" input = "#SALECSC#" output = "wddxText18">
                    <cfwddx action = "cfml2wddx" input = "#SALECNC#" output = "wddxText19">
                    <cfwddx action = "cfml2wddx" input = "#PURC#" output = "wddxText20">
                    <cfwddx action = "cfml2wddx" input = "#PURPREC#" output = "wddxText21">
                    <cfwddx action = "cfml2wddx" input = "#unit2#" output = "wddxText22">
                    <cfwddx action = "cfml2wddx" input = "#remark1#" output = "wddxText23">
                    <cfwddx action = "cfml2wddx" input = "#barcode#" output = "wddxText24">
                    <cfwddx action = "cfml2wddx" input = "#custprice_rate#" output = "wddxText25">
                    <cfwddx action = "cfml2wddx" input = "#fcurrcode#" output = "wddxText26">
                    <cfwddx action = "cfml2wddx" input = "#fcurrcode2#" output = "wddxText27">
                    <cfwddx action = "cfml2wddx" input = "#fcurrcode3#" output = "wddxText28">
                    <cfwddx action = "cfml2wddx" input = "#fcurrcode4#" output = "wddxText29">
                    <cfwddx action = "cfml2wddx" input = "#fcurrcode5#" output = "wddxText30">
                    <cfwddx action = "cfml2wddx" input = "#itemtype#" output = "wddxText31">
                    <cfwddx action = "cfml2wddx" input = "#comment#" output = "wddxText32">
                    
					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText9#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText10#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText11#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText12#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText13#</Data></Cell>
						
						<Cell ss:StyleID="s33"><Data ss:Type="Number">#MINIMUM#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#MAXIMUM#</Data></Cell>
						<Cell ss:StyleID="s33"><Data ss:Type="Number">#REORDER#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText14#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#UCOST#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#price#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#price2#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#price3#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#price4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText15#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText16#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#QTY2#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#QTY3#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#QTY4#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#QTY5#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#QTY6#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#QTYBF#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText17#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText18#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText19#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText20#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText21#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText22#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#FACTOR1#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#FACTOR2#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#PRICEU2#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText23#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText24#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText25#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText26#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fucost#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fprice#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText27#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fucost2#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fprice2#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText28#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fucost3#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fprice3#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText29#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fucost4#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fprice4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText30#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fucost5#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#fprice5#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText31#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText32#</Data></Cell>
					</Row>
				</cfoutput>
                </cfloop>
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
                
			</Table>
		 	</cfoutput>
			<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		   	<Unsynced/>
		   	<Print>
				<ValidPrinterInfo/>
				<Scale>60</Scale>
				<HorizontalResolution>600</HorizontalResolution>
				<VerticalResolution>600</VerticalResolution>
		   	</Print>
		   	<Selected/>
		   	<Panes>
				<Pane>
					<Number>3</Number>
			 		<ActiveRow>20</ActiveRow>
			 		<ActiveCol>3</ActiveCol>
				</Pane>
		   	</Panes>
		   	<ProtectObjects>False</ProtectObjects>
		   	<ProtectScenarios>False</ProtectScenarios>
		  	</WorksheetOptions>
		 	</Worksheet>
			</Workbook>
		</cfxml>

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">