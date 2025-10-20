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
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Customer">
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
					<Cell ss:StyleID="s27"><Data ss:Type="String">CUSTNO,C,8,(3000/zzz)</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">NAME,C,40</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">NAME2,C,40</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ADD1,C,35</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ADD2,C,35</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ADD3,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">ADD4,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">ATTN,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">DADDR1,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">DADDR2,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">DADDR3,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">DADDR4,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">DATTN,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CONTACT,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PHONE,C,25</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PHONE2,C,25</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">FAX,C,35</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">E_MAIL,C,90</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">WEB_SITE,C,50</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">AGENT,C,20</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">TERM,C,12</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">AREA,C,12</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">BUSINESS,C,20</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CRLIMIT</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CURRCODE</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CURRENCY</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CURRENCY1</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CURRENCY2</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">DATE</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">INVLIMIT</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">STATUS</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CREATED_ON</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CREATED_BY</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">ID</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">GST Customer (T,F)</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">COMUEN</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">GST NO</Data></Cell>
                   </Row>
				   	
			<cfquery name="getcust" datasource="#dts#">
            select * from #target_arcust#
            where 0=0
            <cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			and custno >= '#form.customerfrom#' and custno <= '#form.customerto#'
  			</cfif>

            </cfquery>
			
			<cfloop query="getcust">

				<cfoutput>
					<cfwddx action = "cfml2wddx" input = "#custno#" output = "wddxText">
                    <cfwddx action = "cfml2wddx" input = "#name#" output = "wddxText2">
                    <cfwddx action = "cfml2wddx" input = "#name2#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#add1#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#add2#" output = "wddxText5">
                    <cfwddx action = "cfml2wddx" input = "#add3#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#add4#" output = "wddxText7">
                    
                    <cfwddx action = "cfml2wddx" input = "#attn#" output = "wddxText8">
                    <cfwddx action = "cfml2wddx" input = "#daddr1#" output = "wddxText9">
                    <cfwddx action = "cfml2wddx" input = "#daddr2#" output = "wddxText10">
                    <cfwddx action = "cfml2wddx" input = "#daddr3#" output = "wddxText11">
                    <cfwddx action = "cfml2wddx" input = "#daddr4#" output = "wddxText12">
                    <cfwddx action = "cfml2wddx" input = "#dattn#" output = "wddxText13">
                    <cfwddx action = "cfml2wddx" input = "#contact#" output = "wddxText14">
                    <cfwddx action = "cfml2wddx" input = "#phone#" output = "wddxText15">
                    <cfwddx action = "cfml2wddx" input = "#phonea#" output = "wddxText16">
                    <cfwddx action = "cfml2wddx" input = "#fax#" output = "wddxText17">
                    
                    <cfwddx action = "cfml2wddx" input = "#e_mail#" output = "wddxText18">
                    <cfwddx action = "cfml2wddx" input = "#web_site#" output = "wddxText19">
                    <cfwddx action = "cfml2wddx" input = "#agent#" output = "wddxText20">
                    <cfwddx action = "cfml2wddx" input = "#term#" output = "wddxText21">
                    
                    <cfwddx action = "cfml2wddx" input = "#area#" output = "wddxText22">
                    <cfwddx action = "cfml2wddx" input = "#business#" output = "wddxText23">
                    <cfwddx action = "cfml2wddx" input = "#crlimit#" output = "wddxText24">
                    <cfwddx action = "cfml2wddx" input = "#currcode#" output = "wddxText25">
                    <cfwddx action = "cfml2wddx" input = "#currency#" output = "wddxText26">
                    
                    <cfwddx action = "cfml2wddx" input = "#currency1#" output = "wddxText27">
                    <cfwddx action = "cfml2wddx" input = "#currency2#" output = "wddxText28">
                    <cfwddx action = "cfml2wddx" input = "#date#" output = "wddxText29">
                    <cfwddx action = "cfml2wddx" input = "#invlimit#" output = "wddxText30">
                    <cfwddx action = "cfml2wddx" input = "#status#" output = "wddxText31">
                    <cfwddx action = "cfml2wddx" input = "#dateformat(created_on,'yyyy-mm-dd')# #timeformat(created_on,'hh:mm:ss')#" output = "wddxText32">
                    <cfwddx action = "cfml2wddx" input = "#created_by#" output = "wddxText33">
                    <cfwddx action = "cfml2wddx" input = "#ngst_cust#" output = "wddxText34">
                    <cfwddx action = "cfml2wddx" input = "#comuen#" output = "wddxText35">
                    <cfwddx action = "cfml2wddx" input = "#gstno#" output = "wddxText36">
                    
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
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText14#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText15#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText16#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText17#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText18#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText19#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText20#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText21#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText22#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText23#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText24#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText25#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText26#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText27#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText28#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText29#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText30#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText31#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText32#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText33#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText34#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText35#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText36#</Data></Cell>
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