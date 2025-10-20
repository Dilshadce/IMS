
<cfif result eq 'HTML'>
<cfoutput>
<html>
<head>
<title>Finished Good Summary</title>
</head>
<body>
<cfquery name="getproject" datasource="#dts#">
SELECT * FROM finishedgoodar WHERE
1=1
<cfif form.projectfrom neq "" and form.projectto neq "">
and project between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and fperiod between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodto#">
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
and created_on between "#dateformat(ndate,'YYYY-MM-DD')#" and "#dateformat(ndate1,'YYYY-MM-DD')#"
</cfif>
order by project
</cfquery>
<table width="80%" align="center">
<tr>
<th colspan="100%"><h3>Finished Goods Summary</h3></th>
</tr>
<tr>
<td colspan="100%" align="center"> 
<cfif form.projectfrom neq "" and form.projectto neq "">
SALES ORDER FROM #form.projectfrom# TO #form.projectto#
</cfif>
</td>
</tr>
<tr>
<td colspan="100%" align="center"> 
<cfif form.periodfrom neq "" and form.periodto neq "">
PERIOD FROM #form.periodfrom# TO #form.periodto#
</cfif>
</td>
</tr>
<tr>
<td colspan="100%" align="center"> 
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
DATE FROM #dateformat(ndate,'YYYY-MM-DD')# TO #dateformat(ndate1,'YYYY-MM-DD')#
</cfif>
</td>
</tr>
<cfloop query="getproject">
<tr><td colspan="100%"><hr /></td></tr>
<tr>
<th align="left">Sales Order</th>
<td colspan="2">#getproject.project#</td>
<th align="left">Itemno</th>
<td colspan="2">#getproject.itemno#</td>
<th align="left">Quantity</th>
<td colspan="2">#getproject.quantity#</td>
</tr>
<tr>
<th align="left">Item No</th>

<th align="right">Used Qty</th>
<th align="right">Reject Qty</th>
<th align="right">Return Qty</th>
<th align="right">Write Off Qty</th>
<th align="right">BOM Qty</th>
<th align="right">Usage</th>
</tr>
<cfquery name="getprojectitem" datasource="#dts#">
SELECT * FROM finishedgoodic WHERE arid = "#getproject.id#"
</cfquery>
<cfloop query="getprojectitem">
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td>#getprojectitem.itemno#</td>
<td align="right">#getprojectitem.usedqty#</td>
<td align="right">#getprojectitem.rejectqty#</td>
<td align="right">#getprojectitem.returnqty#</td>
<td align="right">#getprojectitem.writeoffqty#</td>
<cfquery name="getbmqty" datasource="#dts#">
select bmqty from billmat where itemno='#getproject.itemno#' and bmitemno='#getprojectitem.itemno#'
</cfquery>
<cfset bomqty=val(getbmqty.bmqty)*val(getproject.quantity)>
<td align="right">#bomqty#</td>
<td align="right">#getprojectitem.usedqty-getprojectitem.returnqty-bomqty#</td>
</tr>
</cfloop>
<tr>
<td>&nbsp;&nbsp;</td>
</tr>
</cfloop>
</table>
</body>
</html>
</cfoutput>
<cfelse>

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
			
			<Worksheet ss:Name="Finished Goods Summary">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="104.5"/>
					<Column ss:Width="100.25"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="9">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>

		   
					<cfwddx action = "cfml2wddx" input = "Finished Goods Summary" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			
					<cfquery name="getproject" datasource="#dts#">
                    SELECT * FROM finishedgoodar WHERE
                    1=1
                    <cfif form.projectfrom neq "" and form.projectto neq "">
                    and project between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
                    </cfif>
                    <cfif form.periodfrom neq "" and form.periodto neq "">
                    and fperiod between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodto#">
                    </cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
                    <cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
                    <cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
                    and created_on between "#dateformat(ndate,'YYYY-MM-DD')#" and "#dateformat(ndate1,'YYYY-MM-DD')#"
                    </cfif>
                    order by project
                    </cfquery>
                    
                    <cfif form.projectfrom neq "" and form.projectto neq "">
						<cfwddx action = "cfml2wddx" input = "SALES ORDER FROM #form.projectfrom# TO #form.projectto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
					</cfif>
			
					<cfif form.periodfrom neq "" and form.periodto neq "">
					<cfwddx action = "cfml2wddx" input = "PERIOD FROM #form.periodfrom# TO #form.periodto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
					<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
                    <cfwddx action = "cfml2wddx" input = "DATE FROM #dateformat(ndate,'YYYY-MM-DD')# TO #dateformat(ndate1,'YYYY-MM-DD')#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
                    
                    
                    </cfif>
				</cfoutput>
				
                
				
				   
				<cfloop query="getproject">
                <cfoutput>
                <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                	<cfwddx action = "cfml2wddx" input = "#getproject.project#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#getproject.itemno#" output = "wddxText2">
					<cfwddx action = "cfml2wddx" input = "#getproject.quantity#" output = "wddxText3">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Sales Order</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Itemno</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText2#</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Quantity</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText3#</Data></Cell>
					
				</Row>
                </cfoutput>
                <Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Item No</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Used Qty</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Reject Qty</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Return Qty</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">BOM Qty</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Usage</Data></Cell>
					
				</Row>
                

                <cfquery name="getprojectitem" datasource="#dts#">
                SELECT * FROM finishedgoodic WHERE arid = "#getproject.id#"
                </cfquery>
                <cfloop query="getprojectitem">
                
                <cfoutput>
                
                <cfquery name="getbmqty" datasource="#dts#">
                select bmqty from billmat where itemno='#getproject.itemno#' and bmitemno='#getprojectitem.itemno#'
                </cfquery>
                <cfset bomqty=val(getbmqty.bmqty)*val(getproject.quantity)>
                
               <cfwddx action = "cfml2wddx" input = "#getprojectitem.itemno#" output = "wddxText">
                <cfwddx action = "cfml2wddx" input = "#getprojectitem.usedqty#" output = "wddxText2">
                <cfwddx action = "cfml2wddx" input = "#getprojectitem.rejectqty#" output = "wddxText3">
				<cfwddx action = "cfml2wddx" input = "#getprojectitem.returnqty#" output = "wddxText4">
                <cfwddx action = "cfml2wddx" input = "#bomqty#" output = "wddxText5">
                
                
                
                <Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#getprojectitem.usedqty-getprojectitem.returnqty-bomqty#</Data></Cell>

	
					
					</Row>
				</cfoutput>
                </cfloop>
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
                </cfloop>

				
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
			</Table>
		 	
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

</cfif>

