<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
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
	<cfcase value="EXCELDEFAULT">
    
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
	<Font ss:FontName="Verdana" x:Family="Swiss"/>
	</Style>
	<Style ss:ID="s28">
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s29">

	</Style>
	<Style ss:ID="s30">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s31">
	<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>

	</Style>
	<Style ss:ID="s32">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s33">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	
	</Style>
	<Style ss:ID="s34">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s35">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
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
	<Worksheet ss:Name="Vehicle Service Date Report">
	<cfoutput>
    <cfset columncount = 9>
    <cfset rowcom = 6>
    <cfset comcom = 6>
	<Table ss:ExpandedColumnCount="#columncount#" x:FullColumns="1" x:FullRows="1">
					<Column ss:Width="40"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.75"/>
	<cfwddx action = "cfml2wddx" input = "Vehicle Service Date Report" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
					
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                     </Row>
                     <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
                     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s26"><Data ss:Type="String">Date Printed : #dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>

		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s34"><Data ss:Type="String">No.</Data></Cell>
					<Cell ss:StyleID="s34"><Data ss:Type="String">Vehicle No.</Data></Cell>
					<Cell ss:StyleID="s34"><Data ss:Type="String">Contact</Data></Cell>
					<Cell ss:StyleID="s32"><Data ss:Type="String">Phone No. (1)</Data></Cell>
					<Cell ss:StyleID="s32"><Data ss:Type="String">Phone No. (2)</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="String">Next Service Mileage</Data></Cell>
					
				</Row>
                

			<cfquery name="getserdate" datasource="#dts#">
			select *
			from vehicles
            where 0=0
            <cfif trim(form.vehiclefrom) neq "">
            and entryno = '#form.vehiclefrom#'
            </cfif>
            
            <cfif form.datefrom neq "" and form.dateto neq "">
            and nextserdate between '#ndatefrom#' and '#ndateto#'
            <cfelse>
            </cfif>
            group by nextserdate 
            order by nextserdate;
            </cfquery>
            
            
			<cfloop query="getserdate">
            
            <cfwddx action = "cfml2wddx" input = "Next Service Date : #getserdate.nextserdate#" output = "wddxText1">

		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s35"><Data ss:Type="String">#wddxText1#</Data></Cell>

            <Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>
            
            <cfset runingno = 1>
            <cfquery name="getvehicle" datasource="#dts#">
				select 
				a.entryno,
                a.contactperson,
                a.phone,
                a.hp,
                a.nextmileage
                
				from vehicles  as a
				

				where a.nextserdate=#getserdate.nextserdate#
                and a.entryno='#getserdate.entryno#' 
				<cfif trim(form.vehiclefrom) neq "" >
				and a.entryno = '#form.vehiclefrom#'
				</cfif>
				order by a.entryno;
			</cfquery>

			<cfloop query="getvehicle">
            
            

			<cfwddx action = "cfml2wddx" input = "#entryno#" output = "wddxText2">
            <cfwddx action = "cfml2wddx" input = "#contactperson#" output ="wddxText3">
            <cfwddx action = "cfml2wddx" input = "#phone#" output = "wddxText4">
            <cfwddx action = "cfml2wddx" input = "#hp#" output = "wddxText5">
            <cfwddx action = "cfml2wddx" input = "#nextmileage#" output = "wddxText6">

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s27"><Data ss:Type="Number">#runingno#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
				<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText4#</Data></Cell>
                <Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText5#</Data></Cell>
                <Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText6#</Data></Cell>
			</Row>
           <cfset runingno=runingno+1>
		</cfloop>
	</cfloop>
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

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls" output="#tostring(data)#" >
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls">
<!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls">
--->
	</cfcase>
    
    <cfcase value="HTML">
	<html>
	<head>
	<title>Cust/Supp/Agent/Area Item Report</title>
	<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	</head>

	<body>

	<cfquery name="getserdate" datasource="#dts#">
		select 
		*
		from vehicles
        
        where 0=0
		<cfif trim(form.vehiclefrom) neq "">
		and entryno = '#form.vehiclefrom#'
		</cfif>
		
		<cfif form.datefrom neq "" and form.dateto neq "">
		and nextserdate between '#ndatefrom#' and '#ndateto#'
		<cfelse>
		</cfif>
		group by nextserdate 
        order by nextserdate;
	</cfquery>
	
	<cfoutput>
    
    <cfset columncount = 9>
    <cfset rowcom = 7>
    <cfset comcom = 3>


	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="100%"><div align="left"><font size="3" face="Times New Roman, Times, serif"><strong>Vehicle Service Date Report</strong></font></div></td>
		</tr>
        
        <tr>
			<td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif">Date Printed : #dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		
		<tr>
			<td colspan="100%"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		</tr>
		
        		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
		<tr>

        
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>No.</strong></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Vehicle No.</strong></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Contact</strong></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Phone No. (1)</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Phone No. (2)</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Next Service Mileage</strong></font></div></td>
            
            		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
		<tr>

			
		
		<cfloop query="getserdate">
			<td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Next Service Date : #dateformat(getserdate.nextserdate,'DD/MM/YYYY')#</strong></font></div></td>
			</tr>

<cfset runingno=1>
			<cfquery name="getvehicle" datasource="#dts#">
				select 
				a.entryno,
                a.contactperson,
                a.phone,
                a.hp,
                a.nextmileage
                
				from vehicles  as a
				

				
				where a.nextserdate=<cfif nextserdate eq ''>"0000-00-00"<cfelse>#getserdate.nextserdate#</cfif>
                and a.entryno='#getserdate.entryno#' 
				<cfif trim(form.vehiclefrom) neq "">
				and a.entryno = '#form.vehiclefrom#'
				</cfif>
   
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.nextserdate between '#ndatefrom#' and '#ndateto#'
				<cfelse>
                </cfif>
			   order by a.entryno;
			</cfquery>

			<cfloop query="getvehicle">

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#runingno#.</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getvehicle.entryno#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getvehicle.contactperson#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getvehicle.phone#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getvehicle.hp#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getvehicle.nextmileage#</font></div></td>
					
				 </tr>
                  <cfset runingno=runingno+1>
                 <tr><td><br></td></tr>
                
				 <cfflush>
			</cfloop>
	
			<cfflush>
		</cfloop>
	  </table>
	</cfoutput>



	<br>
	<br>
	<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
	<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
	</body>
	</html>
    	</cfcase>
</cfswitch>
