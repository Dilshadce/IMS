<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>
             
            < cfif isdefined("form.datefrom") and isdefined("form.dateto")>
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


<cfquery name="getcustomer" datasource="#dts#">
			SELECT custno, name FROM artran

            where type='RC'
            and ((grand_bil-cs_pm_cash-cs_pm_cheq-cs_pm_crcd-cs_pm_crc2-cs_pm_dbcd-cs_pm_vouc-deposit)>0)
            <cfif trim(form.custfrom) neq "">
						and custno = '#form.custfrom#'
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
						</cfif>
						<cfif ndatefrom neq "" and ndateto neq "">
						and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
						<cfelse>
						and wos_date > #getgeneral.lastaccyear#
						</cfif>

            group by custno       
            order by custno
			</cfquery>

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
                
                       <Style ss:ID="s50">

		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						
		   			</Borders>
				</Style>
                
                       
                     
		   <Style ss:ID="s60">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
				</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Lot Number Stock Movement Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="400.5"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="80.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
						<cfset c=c+1>
	
	<cfoutput>
    <cfset columncount = "100%">
    <cfset rowcom = 7>
    <cfset comcom = 3>

	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s38"><Data ss:Type="String">Supplier Payment Status Report</Data></Cell>
		</Row>
        
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>

		     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText1">
			<Cell ss:StyleID="s50"><Data ss:Type="String">Date printed : #wddxText1#</Data></Cell>
            			<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            			<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            			<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            			<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            </Row>
            
        
        <cfloop query="getcustomer">
		     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		    <cfwddx action = "cfml2wddx" input = "#getcustomer.name#" output = "wddxText2">
			<Cell ss:StyleID="s38"><Data ss:Type="String">Supplier:#wddxText2#(#getcustomer.custno#)</Data></Cell>
		 
            </Row>
            
		   <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>

		</Row>
        
			<cfquery name="getbill" datasource="#dts#">
			SELECT wos_date, refno, refno2, grand_bil, (grand_bil-cs_pm_cash-cs_pm_cheq-cs_pm_crcd-cs_pm_crc2-cs_pm_dbcd-cs_pm_vouc-deposit) as grandsum FROM artran

            where type='RC'
            and ((grand_bil-cs_pm_cash-cs_pm_cheq-cs_pm_crcd-cs_pm_crc2-cs_pm_dbcd-cs_pm_vouc-deposit)>0)
			and custno='#getcustomer.custno#'
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
						</cfif>
						<cfif ndatefrom neq "" and ndateto neq "">
						and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
						<cfelse>
						and wos_date > #getgeneral.lastaccyear#
						</cfif>
            group by refno
            order by wos_date
			</cfquery>
				          
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s38"><Data ss:Type="String">Date</Data></Cell>
              <Cell ss:StyleID="s38"><Data ss:Type="String">Reference No.</Data></Cell>
                <Cell ss:StyleID="s38"><Data ss:Type="String">Reference No. 2</Data></Cell>
                <Cell ss:StyleID="s38"><Data ss:Type="String">Debt Amount</Data></Cell>
                 <Cell ss:StyleID="s38"><Data ss:Type="String">Total Amount</Data></Cell>
            </Row>
            
            <cfloop query="getbill">
            
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#dateformat(getbill.wos_date,"dd/mm/yyyy")#" output = "wddxText3">
  		   <cfwddx action = "cfml2wddx" input = "#getbill.refno#" output = "wddxText4">
  		   <cfwddx action = "cfml2wddx" input = "#getbill.refno2#" output = "wddxText5">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(getbill.grandsum,',_.__')#" output = "wddxText6">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(getbill.grand_bil,',_.__')#" output = "wddxText7">
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
            <Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText4#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
            <Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText6#</Data></Cell>
            <Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText7#</Data></Cell>
                 </Row>
                 
			</cfloop>
            
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s60"><Data ss:Type="String"></Data></Cell>

			</Row>
            

		</cfloop>
		
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
	<title>Supplier Payment Status Report</title>
	<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	</head>

	<body>

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


<cfquery name="getcustomer" datasource="#dts#">
			SELECT custno, name FROM artran

            where type='RC'
            and ((grand_bil-cs_pm_cash-cs_pm_cheq-cs_pm_crcd-cs_pm_crc2-cs_pm_dbcd-cs_pm_vouc-deposit)>0)
            <cfif trim(form.custfrom) neq "">
						and custno = '#form.custfrom#'
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
						</cfif>
						<cfif ndatefrom neq "" and ndateto neq "">
						and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
						<cfelse>
						and wos_date > #getgeneral.lastaccyear#
						</cfif>

            group by custno       
            order by custno
			</cfquery>


	
	<cfoutput>
    <cfset columncount = "100%">
    <cfset rowcom = 7>
    <cfset comcom = 3>

	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="100%"><div align="left"><font size="3" face="Times New Roman, Times, serif"><strong>Supplier Payment Status Report</strong></font></div></td>
		</tr>
         <tr>
			<td colspan="100%"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		</tr>

		<tr><td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif">Date printed : #dateformat(now(),"dd/mm/yyyy")#</font></div></td></tr>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
        
        <cfloop query="getcustomer">
		<tr>
			<td colspan="4"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Supplier:&nbsp;&nbsp;#getcustomer.name#&nbsp;(#getcustomer.custno#)</strong></font></div></td>

            <td></td>
			
            </tr>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
        
			<cfquery name="getbill" datasource="#dts#">
			SELECT wos_date, refno, refno2, grand_bil, (grand_bil-cs_pm_cash-cs_pm_cheq-cs_pm_crcd-cs_pm_crc2-cs_pm_dbcd-cs_pm_vouc-deposit) as grandsum FROM artran

            where type='RC'
            and ((grand_bil-cs_pm_cash-cs_pm_cheq-cs_pm_crcd-cs_pm_crc2-cs_pm_dbcd-cs_pm_vouc-deposit)>0)
			and custno='#getcustomer.custno#'
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
						</cfif>
						<cfif ndatefrom neq "" and ndateto neq "">
						and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
						<cfelse>
						and wos_date > #getgeneral.lastaccyear#
						</cfif>
            group by refno
            order by wos_date
			</cfquery>
				          
            <tr>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Date</strong></font></div></td>
             <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><strong>Reference No.</strong></font></div></td>

               <td><div align="center"><font size="2" face="Times New Roman, Times, serif"><strong>Reference No. 2</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Debt Amount</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Total Amount</strong></font></div></td>
            </tr>
            
            <cfloop query="getbill">
            
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getbill.wos_date,"dd/mm/yyyy")#</font></div></td>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getbill.refno#</font></div></td>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getbill.refno2#</font></div></td>
             <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getbill.grandsum,',_.__')#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getbill.grand_bil,',_.__')#</font></div></td>

                 </tr>
                 
				 <cfflush>
			</cfloop>
            <tr>
				<td colspan="#columncount#"><hr></td>
			</tr>

            <tr><td>&nbsp;</td></tr>
            <tr><td>&nbsp;</td></tr>

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
