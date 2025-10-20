<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">

	
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
			
			<Worksheet ss:Name="Calculate Cost">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
				<cfoutput>
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">
	<cfswitch expression="#url.type#">
		<cfcase value="fixed">Calculated by Fixed Cost Method</cfcase>
		<cfcase value="month">Calculated by Month Average Method</cfcase>
		<cfcase value="moving">Calculated by Moving Average Method</cfcase>
		<cfcase value="fifo">Calculated by First In First Out Method</cfcase>
		<cfcase value="lifo">Calculated by Last In First Out Method</cfcase>
	</cfswitch>
</Data></Cell>
</Row>

     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
<cfswitch expression="#url.type#">
	<cfcase value="fixed">
		<cfinvoke component="calculatecost1" method="calculate_fixed_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
	<cfcase value="month">
		<cfinvoke component="calculatecost2" method="calculate_month_average_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
	<cfcase value="moving">
		<cfinvoke component="calculatecost3" method="calculate_moving_average_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
            <cfif isdefined('form.cbbylocation')>
            <cfinvokeargument name="bylocation" value="Y">
            <cfelse>
            <cfinvokeargument name="bylocation" value="">
            </cfif>
		</cfinvoke>
	</cfcase>
	<cfcase value="fifo">
		<cfinvoke component="calculatecost4" method="calculate_first_in_fist_out_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
	<cfcase value="lifo">
		<cfinvoke component="calculatecost5" method="calculate_last_in_first_out_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
</cfswitch>
</Row>                
                </cfoutput>
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
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>

<cfcase value="HTML">

<html>
<head>
<title>Calculate Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<h2 align="center"><font face="Times New Roman, Times, serif">
	<cfswitch expression="#url.type#">
		<cfcase value="fixed">Calculated by Fixed Cost Method</cfcase>
		<cfcase value="month">Calculated by Month Average Method</cfcase>
		<cfcase value="moving">Calculated by Moving Average Method</cfcase>
		<cfcase value="fifo">Calculated by First In First Out Method</cfcase>
		<cfcase value="lifo">Calculated by Last In First Out Method</cfcase>
	</cfswitch>
</font></h2>

<cfswitch expression="#url.type#">
	<cfcase value="fixed">
		<cfinvoke component="calculatecost1" method="calculate_fixed_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
	<cfcase value="month">
		<cfinvoke component="calculatecost2" method="calculate_month_average_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
	<cfcase value="moving">
		<cfinvoke component="calculatecost3" method="calculate_moving_average_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
            <cfif isdefined('form.cbbylocation')>
            <cfinvokeargument name="bylocation" value="Y">
            <cfelse>
            <cfinvokeargument name="bylocation" value="">
            </cfif>
		</cfinvoke>
	</cfcase>
	<cfcase value="fifo">
		<cfinvoke component="calculatecost4" method="calculate_first_in_fist_out_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
	<cfcase value="lifo">
		<cfinvoke component="calculatecost5" method="calculate_last_in_first_out_cost">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="itemfrom" value="#trim(form.productFrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.productTo)#">
		</cfinvoke>
	</cfcase>
</cfswitch>

<h2 align="center"><font face="Times New Roman, Times, serif" color="red">Finish !!!</font></h2>
<div align="center"><input type="button" name="Close This Window" value="Close This Window" onClick="javascript:window.close();"></div>
</body>
</html>

</cfcase>
</cfswitch>