<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>


<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">

	<cfparam name="i" default="1" type="numeric">

<cfquery name="getgsetup" datasource="#dts#">
	select lastaccyear,cost,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION 
	from gsetup
</cfquery>

<cfquery name="getservi" datasource="#dts#">
	select * from icservi where 0=0

	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and servi >= '#form.productfrom#' and servi <= '#form.productto#'
  	</cfif>
	
	order by servi
</cfquery>


<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

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
			
			<Worksheet ss:Name="Service Listing">
				<cfoutput>
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
					<cfset c="55">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>

		   
					<cfwddx action = "cfml2wddx" input = " Service Listing" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			
					
						<cfwddx action = "cfml2wddx" input = "" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>

			
				
					
					<cfwddx action = "cfml2wddx" input = "" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				    <Cell ss:StyleID="s27"><Data ss:Type="String">Service Code</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Description</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Credit Sale</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Cash Sale</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Sales Return</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Purchase</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Purchase Return</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Service Cost</Data></Cell>
        		    <Cell ss:StyleID="s27"><Data ss:Type="String">Service Price</Data></Cell>
            
            
                </Row>
				   
				<cfoutput query="getservi" >
								
                                
        
					<cfwddx action = "cfml2wddx" input = "#servi#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText2">
                    <cfwddx action = "cfml2wddx" input = "#salec#" output = "wddxText3"> 
                    <cfwddx action = "cfml2wddx" input = "#salecsc#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#salecnc#" output = "wddxText5">
                    <cfwddx action = "cfml2wddx" input = "#purc#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#purprc#" output = "wddxText7">
                    <cfwddx action = "cfml2wddx" input = "#sercost#" output = "wddxText8">
                    <cfwddx action = "cfml2wddx" input = "#serprice#" output = "wddxText9">
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

					</Row>
				<cfset i = incrementvalue(i)>
	</cfoutput>
		
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
	</cfcase>
   
    
	<cfcase value="HTML">
<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery name="getgsetup" datasource="#dts#">
	select lastaccyear,cost,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION 
	from gsetup
</cfquery>

<cfquery name="getservi" datasource="#dts#">
	select * from icservi where 0=0

	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and servi >= '#form.productfrom#' and servi <= '#form.productto#'
  	</cfif>
	
	order by servi
</cfquery>






<!--- Control The Decimal Point --->
<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<body>
<p>&nbsp;</p>
<p><font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
</p>
<p align="center"><font color="##000000" size="3" face="Arial, Helvetica, sans-serif"><strong>Service Listing</strong></font></p>

<cfif getservi.recordCount neq 0>

	<table width="100%" border="0" class="" align="center">
		<tr>
			<td colspan="9"><hr></td>
		</tr>
	  	<tr>
    		<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Services code</font></strong></td>
        	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Description</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Credit Sale</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Cash Sale</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Sales Return</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Purchase</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Purchase Return</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Service Cost</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Service Price</font></strong></td>
            
        </tr>
  		<tr>
			<td colspan="9"><hr></td>
		</tr>
  		<cfset i = ((page - 1) * 20) + 1>
		
		<cfoutput query="getservi" startrow="#start#">
        
		  <tr>
   			    <td>#servi#</td>
    			<td>#desp#</td>
                <td>#salec#</td>
                <td>#salecsc#</td>
                <td>#salecnc#</td>
                <td>#purc#</td>
                <td>#purprc#</td>
                <td>#sercost#</td>
                <td>#serprice#</td>
           </tr>
           
			<cfset i = incrementvalue(i)>
	  </cfoutput>
	</table>
<cfelse>

  	<h3><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.</font></h3>
</cfif>

<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>
</cfcase>
</cfswitch>