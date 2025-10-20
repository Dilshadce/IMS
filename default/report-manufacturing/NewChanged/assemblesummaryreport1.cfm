<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,concat(',.',repeat('_',b.decl_uprice)) as decl_uprice ,a.LASTACCYEAR
	from gsetup as a, gsetup2 as b
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

<cfquery datasource="#dts#" name="gettran">
	select refno from ictran
	where 
	type='RC' 
	and (void='' or void is null)
    and custno ='ASSM/999'
	
	<cfif ndatefrom neq "" and ndateto neq "">
		and wos_date between '#ndatefrom#' and '#ndateto#'
	<cfelse>
		and wos_date > #getgeneral.lastaccyear#
	</cfif>
		
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod between '#form.periodfrom#' and '#form.periodto#' 
	</cfif>
	<cfif form.billfrom neq "" and form.billto neq "">
		and refno between '#form.billfrom#' and '#form.billto#'
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
    group by refno
	order by refno
</cfquery>


<cfset totalqtyrec=0>

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
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>

				<Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
		 	</Styles>
			
			<Worksheet ss:Name="Assemble Summary Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>

				<cfoutput>
          <Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Assemble Summary Report</Data></Cell>
		</Row>

			<cfif form.billfrom neq "" and form.billto neq "">
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.billfrom# To #form.billto#" output = "wddxText">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Ref No From #wddxText#</Data></Cell>
		</Row>
			</cfif>
            
			<cfif ndatefrom neq "" and ndateto neq "">
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText1">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText1#</Data></Cell>
		</Row>
			</cfif>
            
			<cfif form.periodfrom neq "" and form.periodto neq "">
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.periodfrom# To #form.periodto#" output = "wddxText2">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Period From #wddxText2#</Data></Cell>
		</Row>
        
			</cfif>
			<cfif form.locationfrom neq "" and form.locationto neq "">
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.locationfrom# To #form.locationto#" output = "wddxText3">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Location From #wddxText3#</Data></Cell>
		</Row>
			</cfif>
    </cfoutput>
    
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText17">
  		   <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText18">
      	    <Cell ss:StyleID="s51"><Data ss:Type="String"><cfif getgeneral.compro neq ""><cfoutput>#wddxText17#</cfoutput></cfif></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s51"><Data ss:Type="String"><cfoutput>#wddxText18#</cfoutput></Data></Cell>
    </Row>
    
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
          <Cell ss:StyleID="s38"><Data ss:Type="String">ITEMNO</Data></Cell>
          <Cell ss:StyleID="s38"><Data ss:Type="String">RC NO</Data></Cell> 
          <Cell ss:StyleID="s26"><Data ss:Type="String">QTY REC</Data></Cell>
          <Cell ss:StyleID="s38"><Data ss:Type="String">MATERIAL</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">COST</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">ISS NO</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">QTY REQ</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">Price</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">Amount</Data></Cell>
        </Row>
    
   <cfloop query="gettran">
    <cfquery name="getpono" datasource="#dts#">
    select pono,refno from artran where refno='#gettran.refno#' and type='RC'
    </cfquery>
    
    <cftry>
    	  <cfif getpono.pono neq ''>
          <cfset issueno=getpono.pono>
          <cfelse>
          <cfset issueno=getpono.refno>
          </cfif>
          <cfcatch>
          <cfset issueno=''>
          </cfcatch>
          </cftry>
    
      <cfquery name="getdata" datasource="#dts#">
      select itemno,price,qty,desp,refno from ictran where refno='#issueno#' and type='ISS'
      </cfquery>
      <cfquery name="getitemrec" datasource="#dts#">
      select itemno,refno,qty from ictran where refno='#gettran.refno#' and type='RC'
      </cfquery>
        <cfoutput>
        <cfloop query="getitemrec">
        <cfset totalqtyrec=totalqtyrec+getitemrec.qty>
        <cfquery name="getcost" datasource="#dts#">
select * from icitem where itemno='#getitemrec.itemno#'
</cfquery>
<>
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            </Row>

	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getitemrec.Itemno#" output = "wddxText13">
  		   <cfwddx action = "cfml2wddx" input = "#getitemrec.refno#" output = "wddxText14">
  		   <cfwddx action = "cfml2wddx" input = "#getitemrec.qty#" output = "wddxText15">
  		   <cfwddx action = "cfml2wddx" input = "#getcost.ucost#" output = "wddxText16">
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText16#</Data></Cell>
          </Row>
          </cfloop>
        </cfoutput>
        <cfset totalcost = 0>
        <cfset totalqty = 0>
        <cfoutput>
        <cfloop query="getdata">
          
          <cfif getdata.recordcount neq 0>
          <cfset itemcost = getdata.price*getdata.qty>
          <cfset totalcost = totalcost + itemcost>
          <cfset totalqty = totalqty + getdata.qty>
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
</Row>         
         
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getdata.itemno#" output = "wddxText6">
  		   <cfwddx action = "cfml2wddx" input = "#getdata.desp#" output = "wddxText7">
  		   <cfwddx action = "cfml2wddx" input = "#getdata.refno#" output = "wddxText8">
  		   <cfwddx action = "cfml2wddx" input = "#getdata.qty#" output = "wddxText9">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(getdata.price,getgeneral.decl_uprice)#" output = "wddxText10">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(itemcost,getgeneral.decl_uprice)#" output = "wddxText11">
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
          </Row>
          </cfif>
          </cfloop>
        </cfoutput>
        <!--- getdata --->
	           <cfoutput>
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">________________________________________________</Data></Cell>
          </Row>
          
          <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            </Row>
            
         <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		</Row>

	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
           <cfwddx action = "cfml2wddx" input = "#totalqty#" output = "wddxText20">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(totalcost,getgeneral.decl_uprice)#" output = "wddxText21">

            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String">Total Qty</Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText20#</Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String">Total Amount</Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText21#</Data></Cell>
          </Row>
        </cfoutput>
  
     </cfloop>
    
    <cfoutput>
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
    	    <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
  	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
    </Row>
    
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#totalqtyrec#" output = "wddxText12">
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
    	    <Cell ss:StyleID="s50"><Data ss:Type="String">Total:</Data></Cell>
  	        <Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText12#</Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
    </Row>
    </cfoutput>
    <!--- gettran --->

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
<title>Print Assemble Summary Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,concat(',.',repeat('_',b.decl_uprice)) as decl_uprice ,a.LASTACCYEAR
	from gsetup as a, gsetup2 as b
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

<cfquery datasource="#dts#" name="gettran">
	select refno from ictran
	where 
	type='RC' 
	and (void='' or void is null)
    and custno ='ASSM/999'
	
	<cfif ndatefrom neq "" and ndateto neq "">
		and wos_date between '#ndatefrom#' and '#ndateto#'
	<cfelse>
		and wos_date > #getgeneral.lastaccyear#
	</cfif>
		
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod between '#form.periodfrom#' and '#form.periodto#' 
	</cfif>
	<cfif form.billfrom neq "" and form.billto neq "">
		and refno between '#form.billfrom#' and '#form.billto#'
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
    group by refno
	order by refno
</cfquery>


<cfset totalqtyrec=0>

<body>
<div align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif">Assemble Summary Report</font></div>

<cfif gettran.recordcount gt 0>
  <table width="100%" border="0" cellpadding="3" align="center">
    <cfoutput>
			<cfif form.billfrom neq "" and form.billto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Ref No From #form.billfrom# To #form.billto#</font></div></td>
				</tr>
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Period From #form.periodfrom# To #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.locationfrom neq "" and form.locationto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Location From #form.locationfrom# To #form.locationto#</font></div></td>
				</tr>
			</cfif>
    </cfoutput>
    <tr>
      <td colspan="7"><cfif getgeneral.compro neq "">
          <font size="2" face="Times New Roman, Times, serif"><cfoutput>#getgeneral.compro#</cfoutput></font> </cfif> </td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#dateformat(now(),"dd/mm/yyyy")#</cfoutput></font></div></td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <tr>
      <td><font size="2" face="Times New Roman, Times, serif"><strong>ITEM
        NO</strong></font></td>
       <td><font size="2" face="Times New Roman, Times, serif"><strong>RC NO</strong></font></td> 
        
      <td><font size="2" face="Times New Roman, Times, serif"><div align="right">QTY REC</div></font></td>
      <td colspan="2"><font size="2" face="Times New Roman, Times, serif"><strong>MATERIAL</strong></font></td>
       <td><div align="center"><font size="2" face="Times New Roman, Times, serif">COST</font></div></td>
      <td><div align="center"><font size="2" face="Times New Roman, Times, serif">ISS NO</font></div></td>
	  <td><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY REQ</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Price</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Amount</font></div></td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <cfloop query="gettran">
    <cfquery name="getpono" datasource="#dts#">
    select pono,refno from artran where refno='#gettran.refno#' and type='RC'
    </cfquery>
    
    <cftry>
    	  <cfif getpono.pono neq ''>
          <cfset issueno=getpono.pono>
          <cfelse>
          <cfset issueno=getpono.refno>
          </cfif>
          <cfcatch>
          <cfset issueno=''>
          </cfcatch>
          </cftry>
    
      <cfquery name="getdata" datasource="#dts#">
      select itemno,price,qty,desp,refno from ictran where refno='#issueno#' and type='ISS'
      </cfquery>
      <cfquery name="getitemrec" datasource="#dts#">
      select itemno,refno,qty from ictran where refno='#gettran.refno#' and type='RC'
      </cfquery>
        <cfoutput>
        <cfloop query="getitemrec">
        <cfset totalqtyrec=totalqtyrec+getitemrec.qty>
        <cfquery name="getcost" datasource="#dts#">
select * from icitem where itemno='#getitemrec.itemno#'
</cfquery>
          <tr>
            <td><font size="2" face="Times New Roman, Times, serif">#getitemrec.Itemno#</font> <div align="left"></div></td>
            <td> <font size="2" face="Times New Roman, Times, serif">#getitemrec.refno# </font> <div align="center"><font size="2" face="Times New Roman, Times, serif"></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitemrec.qty# </font> </div></td>
            <td></td>
            <td></td>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getcost.ucost#</font></div></td>
          </tr>
          </cfloop>
        </cfoutput>
        <cfset totalcost = 0>
        <cfset totalqty = 0>
        <cfoutput>
        <cfloop query="getdata">
          
          <cfif getdata.recordcount neq 0>
          <cfset itemcost = getdata.price*getdata.qty>
          <cfset totalcost = totalcost + itemcost>
          <cfset totalqty = totalqty + getdata.qty>

          <tr>
            <td><div align="center"></div></td>
            <td></td>
            <TD></TD>
            <td><font size="2" face="Times New Roman, Times, serif">&nbsp;#getdata.itemno#</font></td>
            <td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.desp#</font></div></td>
            <td></td>
                         <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getdata.refno#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getdata.qty#</font></div></td>
            <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.price,getgeneral.decl_uprice)#</font></div></td>
            <td> <div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemcost,getgeneral.decl_uprice)#</font></div></td>
          </tr>
          </cfif>
          </cfloop>
        </cfoutput>
        <!--- getdata --->
        <cfoutput>
          <tr>
            <td colspan="5">&nbsp;</td>
            <td></td>
            <td colspan="4"><div align="right">________________________________________________</div></td>
          </tr>
          <tr>
            <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
          
            <td colspan="4"><font size="2" face="Times New Roman, Times, serif"></font></td>
            <td></td>
            <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">Total Qty</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalqty#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Total Amount</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalcost,getgeneral.decl_uprice)#</font></div></td>
          </tr>
        </cfoutput>

      <tr>
        <td colspan="100%"><hr></td>
      </tr>

    </cfloop>
    <cfoutput>
    <tr>
    <td></td>
    <td nowrap><font size="2" face="Times New Roman, Times, serif">Total:</font></td>
    <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalqtyrec#</font></div></td>
    </tr>
    </cfoutput>
    <!--- gettran --->
  </table>

<cfelse>
  Sorry. No Records.

</cfif>
</body>
</html>

</cfcase>
</cfswitch>
