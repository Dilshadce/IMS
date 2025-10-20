<cfquery name="getgeneral" datasource="#dts#">
	select 
	cost,
	compro,
	lastaccyear,
    singlelocation
	from gsetup;
</cfquery>


<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">

<cfset totalqty=0>

<cfquery name="getlocationopeningqty" datasource="#dts#">
	select sum(a.locqfield) as locationqty ,a.itemno,b.aitemno,b.desp,a.location from locqdbf as a left join (select itemno,aitemno,desp from icitem)as b on a.itemno=b.itemno
    where 0=0
    <cfif form.locationfrom neq '' and form.locationto neq ''>
    and location between '#form.locationfrom#' and '#form.locationto#'
    </cfif>
    group by a.location,a.itemno
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
                
                <Style ss:ID="s50">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                 
                <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="200.75"/>
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
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Location Opening Quantity</Data></Cell>
		</Row>

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
            	<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText1">

            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:MergeAcross="#c#" ss:StyleID="s26"><Data ss:Type="String">#wddxText1#</Data></Cell>
	</Row>
	
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">PRODUCT CODE.</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s50"><Data ss:Type="String">DESPCRIPTION</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">LOCATION</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">LOCATION OPENING</Data></Cell>
    </Row>
	
	<cfloop query="getlocationopeningqty">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getlocationopeningqty.itemno#" output = "wddxText2">
            	<cfwddx action = "cfml2wddx" input = "#getlocationopeningqty.aitemno#" output = "wddxText3">
            	<cfwddx action = "cfml2wddx" input = "#getlocationopeningqty.desp#" output = "wddxText4">
            	<cfwddx action = "cfml2wddx" input = "#getlocationopeningqty.location#" output = "wddxText5">
            	<cfwddx action = "cfml2wddx" input = "#getlocationopeningqty.locationqty#" output = "wddxText6">
        
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
        </cfif>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
           <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
		</Row>
        <cfset totalqty=totalqty+getlocationopeningqty.locationqty>
</cfloop></cfoutput>

		<cfoutput>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#totalqty#" output = "wddxText7">

			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
        </cfif>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s51"><Data ss:Type="String">Total :</Data></Cell>
           <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText7#</Data></Cell>
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
<title>Location Opening Quantity</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select 
	cost,
	compro,
	lastaccyear,
    singlelocation
	from gsetup;
</cfquery>

<cfset totalqty=0>

<cfquery name="getlocationopeningqty" datasource="#dts#">
	select sum(a.locqfield) as locationqty ,a.itemno,b.aitemno,b.desp,a.location from locqdbf as a left join (select itemno,aitemno,desp from icitem)as b on a.itemno=b.itemno
    where 0=0
    <cfif form.locationfrom neq '' and form.locationto neq ''>
    and location between '#form.locationfrom#' and '#form.locationto#'
    </cfif>
    group by a.location,a.itemno
</cfquery>

<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>

<table align="center" border="0" width="100%">
	<tr>
		<td colspan="8"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Location Opening Quantity</strong></font></div></td>
	</tr>
	<cfoutput>

	<tr>
		<td colspan="3"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></div></td>
    	<td colspan="5"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr>
		<td colspan="8"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">PRODUCT CODE.</font></div></td>
        </cfif>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">DESPCRIPTION</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">LOCATION</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">LOCATION OPENING</font></div></td>
    </tr>
	<tr>
      	<td colspan="8"><hr></td>
    </tr>
	<cfloop query="getlocationopeningqty">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getlocationopeningqty.itemno#</font></div></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getlocationopeningqty.aitemno#</font></div></td>
        </cfif>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getlocationopeningqty.desp#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getlocationopeningqty.location#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getlocationopeningqty.locationqty#</font></div></td>
		</tr>
        <cfset totalqty=totalqty+getlocationopeningqty.locationqty>
</cfloop></cfoutput>
		<tr><td colspan="100%"><hr></td></tr>
		<cfoutput>
        <tr>
			<td></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <td></td>
        </cfif>
			<td></td>
            <td>Total :</td>
            <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalqty#</font></div></td>
		</tr>
        </cfoutput>
</table>

<cfif getlocationopeningqty.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>

</cfcase>
</cfswitch>