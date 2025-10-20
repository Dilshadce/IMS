<cfswitch expression="#form.result#">
	<cfcase value="HTML">


<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset dd = dateformat(form.datefrom, 'DD')>
		<cfif dd greater than '12'>
		<cfset date1 = dateformat(form.datefrom,"YYYYMMDD")>
		<cfelse>
		<cfset date1 = dateformat(form.datefrom,"YYYYDDMM")>
		</cfif>

						<cfset dd = dateformat(form.dateto, 'DD')>
		<cfif dd greater than '12'>
		<cfset date2 = dateformat(form.dateto,"YYYYMMDD")>
		<cfelse>
		<cfset date2 = dateformat(form.dateto,"YYYYDDMM")>
		</cfif>

<cfparam name="totalrc" default="0">
<cfparam name="totalpr" default="0">

</cfif>
<cfparam name="total" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="i" default="1" type="numeric">


		<html>
		<head>
		<title>Supplier - Service Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
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
			<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">

            <tr>
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> Supplier - Service Report</strong></font></div></td>
			</tr>
            <cfif form.Servicefrom neq "" and form.Serviceto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service Code #form.Servicefrom# - </font></div></td>
				</tr>
			</cfif>
            <cfif form.supplierfrom neq "" and form.supplierto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Supplier #form.supplierfrom# - #form.supplierto#</font></div></td>
				</tr>
			</cfif>
          
            			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Period  #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date #form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
				
				<tr>
			<tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			  <td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
</table>

    
    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      </table>

          <table width="100%" BORDER=0 class="" align="center" >
      <tr>
        <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Service Code</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Project</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Job</cfoutput></font></strong></td>
         <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Date</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>PR</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>RC</cfoutput></font></strong></td>

               <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">NET</font></strong></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
      			<cfquery name="getcustomer" datasource="#dts#">
				select a.itemno as itemno, b.desp as desp,a.custno as custno,a.name as name,a.agenno as agenno from ictran a, icservi b
				where (a.type = 'PR' or a.type = 'RC') and b.servi = a.itemno and (a.void = '' or a.void is null)
				<cfif form.supplierfrom neq "" and form.supplierto neq "">
				and a.custno >='#form.supplierfrom#' and a.custno <= '#form.supplierto#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and b.servi >='#form.servicefrom#' and b.servi <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
				</cfif>

				<cfif form.projectfrom neq "" and form.projectto neq "">
				and a.source >= '#form.projectfrom#' and a.source <= '#form.projectto#'
				</cfif>
				<cfif form.jobfrom neq "" and form.jobto neq "">
				and a.job >= '#form.jobfrom#' and a.job <= '#form.jobto#'
				</cfif>	



				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date >= '#datefrom#' and a.wos_date <= '#dateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
			</cfquery>
            
            	<cfloop query="getcustomer">
				<cfset subpr = 0>
				<cfset subrc = 0>
				<cfset subtotal = 0>

				<tr>
					<td width="20%"><div align="left" ><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.currentrow#.Supplier NO: #getcustomer.custno#</u></strong></font></div></td>
					<td width="20%"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.name#</u></strong>
					</div></td>
				</tr>
      
     <cfquery name="getdata" datasource="#dts#">
					select * from ictran where (type = 'RC' or type = 'PR')
					and custno = '#getcustomer.custno#' and (void = '' or void is null)
					<cfif form.supplierfrom neq "" and form.supplierto neq "">
				and custno >='#form.supplierfrom#' and custno <= '#form.supplierto#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>

				<cfif form.projectfrom neq "" and form.projectto neq "">
				and source >= '#form.projectfrom#' and source <= '#form.projectto#'
				</cfif>
				<cfif form.jobfrom neq "" and form.jobto neq "">
				and job >= '#form.jobfrom#' and job <= '#form.jobto#'
				</cfif>	
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#datefrom#' and wos_date <= '#dateto#'
				<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					 order by wos_date
				</cfquery>

				<cfloop query="getdata">
					<cfset pr = 0>
					<cfset rc = 0>
					<cfset amt = 0>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.refno#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.desp#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.source#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.job#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getdata.wos_date,"dd-mm-yyyy")#</font></div></td>

						<cfswitch expression="#getdata.type#">
							<cfcase value="pr">
								<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getdata.amt),stDecl_UPrice)#</font></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<cfset pr = pr + val(getdata.amt)>
								<cfset subpr = subpr + val(getdata.amt)>
								<cfset totalpr = totalpr + val(getdata.amt)>
							</cfcase>
							<cfcase value="rc">
								<td><div align="right"></div></td>
								<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getdata.amt),stDecl_UPrice)#</font></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<cfset rc = rc + val(getdata.amt)>
								<cfset subrc = subrc + val(getdata.amt)>
								<cfset totalrc = totalrc + val(getdata.amt)>
							</cfcase>
						
						</cfswitch>
					</tr>
				</cfloop>

				<cfset subtotal = subtotal + subrc>
				<tr>
					<td colspan="9"><hr></td>
				</tr>
				<tr>
					<td><div align="left"></div></td>
					<td><div align="left"></div></td>
					<td><div align="left"></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">SUB_TOTAL:</strong></font></div></td>
					<td><div align="left"></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subpr,stDecl_UPrice)#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subrc,stDecl_UPrice)#</font></div></td>
					<cfset subtotal = subtotal - subpr>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,stDecl_UPrice)#</font></div></td>
				</tr>
				<tr><td><br></td></tr>
			</cfloop>
			<cfflush>
			<cfset total = total + totalrc>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<tr>
				<td><div align="left"></div></td>
				<td><div align="left"></div></td>
				<td><div align="left"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="left"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalpr,",.__")#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalrc,",.__")#</strong></font></div></td>
				<cfset total = total - totalpr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total,",.__")#</strong></font></div></td>
			</tr>
    </table>
            			</cfoutput>
    <br>
    <div align="right">
      <!---       <cfif #start# neq 1>
        <cfoutput><a href="l_icitem.cfm">Previous</a> ||</cfoutput>
      </cfif>
      <cfif #page# neq #noOfPage#>
        <cfoutput> <a href="l_icitem.cfm">Next</a> ||</cfoutput>
      </cfif> --->
    </div>
		<cfif getcustomer.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
	
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>

        
		</html>
	</cfcase>

	<cfcase value="EXCELDEFAULT">
    
    <cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset dd = dateformat(form.datefrom, 'DD')>
		<cfif dd greater than '12'>
		<cfset date1 = dateformat(form.datefrom,"YYYYMMDD")>
		<cfelse>
		<cfset date1 = dateformat(form.datefrom,"YYYYDDMM")>
		</cfif>

						<cfset dd = dateformat(form.dateto, 'DD')>
		<cfif dd greater than '12'>
		<cfset date2 = dateformat(form.dateto,"YYYYMMDD")>
		<cfelse>
		<cfset date2 = dateformat(form.dateto,"YYYYDDMM")>
		</cfif>

<cfparam name="totalrc" default="0">
<cfparam name="totalpr" default="0">

</cfif>
<cfparam name="total" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="i" default="1" type="numeric">

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>
        
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
		   			
		  		</Style>
                <Style ss:ID="s29">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
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
                <Style ss:ID="s42">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                <Style ss:ID="s43">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Underline="Single"/>
		  		</Style>
                <Style ss:ID="s44">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		  		</Style>
                
                <Style ss:ID="s45">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                 <Style ss:ID="s46">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                <Style ss:ID="s50">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                   <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
                <Style ss:ID="s90">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>

		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">

			<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="60.75"/>
					<Column ss:Width="80.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
                    <cfset d="8">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                        <cfset d=d+1>

        <cfoutput>
		     <Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"> Supplier - Service Report</Data></Cell>
			</Row>
            
            <cfif form.Servicefrom neq "" and form.Serviceto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.Servicefrom# - #form.Serviceto#" output = "wddxText">
        		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Service Code #wddxText#</Data></Cell>
			</Row>
			</cfif>
            
            <cfif form.supplierfrom neq "" and form.supplierto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.supplierfrom# - #form.supplierto#" output = "wddxText">
        		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Supplier #wddxText#</Data></Cell>
			</Row>
			</cfif>
          
            <cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText">
        		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Period  #wddxText#</Data></Cell>
			</Row>
			</cfif>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText">
        		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Date #wddxText#</Data></Cell>
			</Row>
			</cfif>
				
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText2">
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText1#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
        <Cell ss:StyleID="s50"><Data ss:Type="String">No</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Service Code</cfoutput></Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Project</cfoutput></Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Job</cfoutput></Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Date</cfoutput></Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>PR</cfoutput></Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>RC</cfoutput></Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">NET</Data></Cell>
      </Row>
      
      			<cfquery name="getcustomer" datasource="#dts#">
				select a.itemno as itemno, b.desp as desp,a.custno as custno,a.name as name,a.agenno as agenno from ictran a, icservi b
				where (a.type = 'PR' or a.type = 'RC') and b.servi = a.itemno and (a.void = '' or a.void is null)
				<cfif form.supplierfrom neq "" and form.supplierto neq "">
				and a.custno >='#form.supplierfrom#' and a.custno <= '#form.supplierto#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and b.servi >='#form.servicefrom#' and b.servi <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
				</cfif>

				<cfif form.projectfrom neq "" and form.projectto neq "">
				and a.source >= '#form.projectfrom#' and a.source <= '#form.projectto#'
				</cfif>
				<cfif form.jobfrom neq "" and form.jobto neq "">
				and a.job >= '#form.jobfrom#' and a.job <= '#form.jobto#'
				</cfif>	



				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date >= '#datefrom#' and a.wos_date <= '#dateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
			</cfquery>
            
            	<cfloop query="getcustomer">
				<cfset subpr = 0>
				<cfset subrc = 0>
				<cfset subtotal = 0>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
        <Cell ss:StyleID="s41"><Data ss:Type="String">#getcustomer.currentrow#.Supplier NO: #getcustomer.custno#</Data></Cell>
		<Cell ss:StyleID="s41"><Data ss:Type="String">#getcustomer.name#</Data></Cell>
	</Row>
      
     <cfquery name="getdata" datasource="#dts#">
					select * from ictran where (type = 'RC' or type = 'PR')
					and custno = '#getcustomer.custno#' and (void = '' or void is null)
					<cfif form.supplierfrom neq "" and form.supplierto neq "">
				and custno >='#form.supplierfrom#' and custno <= '#form.supplierto#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>

				<cfif form.projectfrom neq "" and form.projectto neq "">
				and source >= '#form.projectfrom#' and source <= '#form.projectto#'
				</cfif>
				<cfif form.jobfrom neq "" and form.jobto neq "">
				and job >= '#form.jobfrom#' and job <= '#form.jobto#'
				</cfif>	
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#datefrom#' and wos_date <= '#dateto#'
				<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					 order by wos_date
				</cfquery>

				<cfloop query="getdata">
					<cfset pr = 0>
					<cfset rc = 0>
					<cfset amt = 0>
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
       					<Cell ss:StyleID="s26"><Data ss:Type="String">#getdata.refno#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#getdata.desp#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#getdata.source#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#getdata.job#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(getdata.wos_date,"dd-mm-yyyy")#</Data></Cell>

						<cfswitch expression="#getdata.type#">
							<cfcase value="pr">
								<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(val(getdata.amt),stDecl_UPrice)#</Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
								<cfset pr = pr + val(getdata.amt)>
								<cfset subpr = subpr + val(getdata.amt)>
								<cfset totalpr = totalpr + val(getdata.amt)>
							</cfcase>
							<cfcase value="rc">
                    			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
								<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(val(getdata.amt),stDecl_UPrice)#</Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
								<cfset rc = rc + val(getdata.amt)>
								<cfset subrc = subrc + val(getdata.amt)>
								<cfset totalrc = totalrc + val(getdata.amt)>
							</cfcase>
						
						</cfswitch>
					</Row>
				</cfloop>

				<cfset subtotal = subtotal + subrc>
				
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                                <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
								<Cell ss:StyleID="s51"><Data ss:Type="String">SUB_TOTAL:</Data></Cell>
                                <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
								<Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(subpr,stDecl_UPrice)#</Data></Cell>
								<Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(subrc,stDecl_UPrice)#</Data></Cell>
					<cfset subtotal = subtotal - subpr>
								<Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(subtotal,stDecl_UPrice)#</Data></Cell>
				</Row>
                
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			</Row>
			</cfloop>
            
            				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			</Row>

			<cfset total = total + totalrc>
			
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                                <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s90"><Data ss:Type="String">TOTAL</Data></Cell>
                                <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
                                <Cell ss:StyleID="s90"><Data ss:Type="String">#numberformat(totalpr,",.__")#</Data></Cell>
                                <Cell ss:StyleID="s90"><Data ss:Type="String">#numberformat(totalrc,",.__")#</Data></Cell>
				<cfset total = total - totalpr>
				<Cell ss:StyleID="s90"><Data ss:Type="String">#numberformat(total,",.__")#</Data></Cell>
			</Row>

		<!---<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    		<Cell ss:MergeAcross="6" ss:StyleID="s31"><Data ss:Type="String">Top Sales Report - By Agent</Data></Cell>
   		</Row>
		<cfoutput>
   		<cfif form.datefrom neq "" and form.dateto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">Vehicle Number: #form.datefrom# - #form.dateto#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.datefrom2 neq "" and form.dateto2 neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">Customer Code: #form.datefrom2# - #form.dateto2#</Data></Cell>
			</Row>
		</cfif>

   		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
   	 		<Cell ss:MergeAcross="5" ss:StyleID="s34"><Data ss:Type="String">#wddxText#</Data></Cell>
    		<Cell ss:StyleID="s36"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
   		</Row>

		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <Cell ss:StyleID="s24"><Data ss:Type="String">Vehicles No</Data></Cell>
        <Cell ss:StyleID="s24"><Data ss:Type="String">Customer CODE</Data></Cell>
                               <cfif isdefined("form.cbmodel")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Model</Data></Cell></cfif>
            <cfif isdefined("form.cbcustname")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Customer Name</Data></Cell>
                    </cfif>
                            <cfif isdefined("form.cbcustic")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Customer IC</Data></Cell></cfif>
                    <cfif isdefined("form.cbgender")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Gender</Data></Cell></cfif>
                    <cfif isdefined("form.cbmarstatus")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Martial Status</Data></Cell></cfif>
                    <cfif isdefined("form.cbcustadd")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Customer Address</Data></Cell></cfif>
                   <cfif isdefined("form.cbdob")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Date Of Birth</Data></Cell></cfif>
                    <cfif isdefined("form.cbNCD")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">NCD</Data></Cell></cfif>
                    <cfif isdefined("form.cbcom")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">COM</Data></Cell></cfif>
                    <cfif isdefined("form.cbscheme")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Scheme</Data></Cell></cfif>
                    <cfif isdefined("form.cbmake")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Make</Data></Cell></cfif>
                    <cfif isdefined("form.cbchasisno")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Chasis No</Data></Cell></cfif>
                    <cfif isdefined("form.cbyearmade")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Year Of Manufacture</Data></Cell></cfif>
                    <cfif isdefined("form.cboriregdate")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Original Registration date</Data></Cell></cfif>
                    <cfif isdefined("form.cbcapacity")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Capacity</Data></Cell></cfif>
                    <cfif isdefined("form.cbcoveragetype")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Coverage Type</Data></Cell></cfif>
                    <cfif isdefined("form.cbsuminsured")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Sum insured</Data></Cell></cfif>
                    <cfif isdefined("form.cbinsurance")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Insurance</Data></Cell></cfif>
                    <cfif isdefined("form.cbpremium")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Premium</Data></Cell></cfif>
                    <cfif isdefined("form.cbfinancecom")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Finance</Data></Cell></cfif>
                    <cfif isdefined("form.cbcommision")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Commision</Data></Cell></cfif>
                    <cfif isdefined("form.cbcontract")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Contract</Data></Cell></cfif>
                    <cfif isdefined("form.cbpayment")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Payment</Data></Cell></cfif>
                    <cfif isdefined("form.cbcustrefer")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Customer Reference</Data></Cell></cfif>
   		</Row>
</cfoutput>
<cfparam name="i" default="1" type="numeric">
<cfquery name="getservice" datasource="#dts#">
  select * from vehicles 
  where 0=0
  <cfif form.datefrom neq "" and form.dateto neq "">
	and carno >= '#form.datefrom#' and carno <= '#form.dateto#'
  </cfif>
    <cfif form.datefrom2 neq "" and form.dateto2 neq "">
	and custcode >= '#form.datefrom2#' and custcode <= '#form.dateto2#'
  </cfif>
  order by #form.trantype#
</cfquery>

      <cfoutput query="getservice" startrow="1">

			<Row ss:Height="12">
				<cfif getservice.carno eq "">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Carno</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Carno</Data></Cell>
				<cfelse>
					<cfwddx action = "cfml2wddx" input = "#getservice.carno#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getservice.custcode#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.carno)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
                
			</Row>--->
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
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
</cfswitch>