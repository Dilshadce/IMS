<cfswitch expression="#form.result#">
	<cfcase value="HTML">

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset dd = dateformat(form.datefrom, 'DD')>
		<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
		<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
		</cfif>

						<cfset dd = dateformat(form.dateto, 'DD')>
		<cfif dd greater than '12'>
		<cfset ndateto= dateformat(form.dateto,"YYYYMMDD")>
		<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
		</cfif>

</cfif>
<cfparam name="total" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getallservice" datasource="#dts#">
  select servi as servi from icservi where 0=0
  <cfif form.servicefrom neq "" and form.serviceto neq "">
	and itemno >= '#form.servicefrom#' and itemno <= '#form.serviceto#'
  </cfif>
  union all
  select itemno as servi from icitem where 0=0 and itemtype='SV'
  <cfif form.itemfrom neq "" and form.itemto neq "">
	and itemno >= '#form.itemfrom#' and itemno <= '#form.itemto#'
  </cfif>
</cfquery>

<cfset itemlist=valuelist(getallservice.servi)>


<cfquery name="getservice" datasource="#dts#">
  select * from ictran
  where fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#' and type in (#ListQualify(marktype,"'")#) 
  <cfif itemlist neq ''>
  and itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
  </cfif>
    <cfif form.customerfrom neq "" and form.customerto neq "">
	and custno >= '#form.customerfrom#' and custno <= '#form.customerto#'
  </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
	and agenno >= '#form.agentfrom#' and agenno<= '#form.agentto#'
  </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
  </cfif>


</cfquery>
		<html>
		<head>
		<title>Service Listing Report</title>
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

		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<cfoutput>
            <tr>
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> Service Listing report </strong></font></div></td>
			</tr>
            <cfif form.Servicefrom neq "" and form.Serviceto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service Code #form.Servicefrom# - #form.Serviceto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.customerfrom neq "" and form.customerto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Customer  #form.customerfrom# - #form.customerto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Agent  #form.agentfrom# - #form.agentto#</font></div></td>
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
            			</cfoutput>
</table>

  <cfif #getservice.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getPersonal.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif>
    
    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      </table>

          <table width="100%" BORDER=0 class="" align="center" >
      <tr>
        <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Date</cfoutput></font></strong></td>
         <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Type</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Ref No</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer Code</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer Name</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Description</cfoutput></font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Qty</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Amount</font></strong></td>
       
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
       
      <cfoutput query="getservice" startrow="1">
        <tr>
          <td align="center" width="2%"><div align="left">#i#</div></td>
          <td align="center" width="9%">#dateformat(wos_date,'DD-MM-YYYY')#</td>
          <td align="center" width="9%">#Type#</td>
          <td align="center" width="9%">#refno#</td>
       
          <td align="center" width="9%">#custno#</td>
          
            <td align="center" width="9%">#name#</td>
            <td align="center" width="9%">#desp#</td>
            <td align="center" width="9%">#qty_Bil#</td>
            <td align="center" width="9%">#NumberFormat(amt_bil, ",_.__")#</td>
        </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
        
        		<cfset total=total+val(getservice.amt_bil)>
      </cfoutput>
<td colspan="100%"><hr></td>
      <tr>
      <td></td><td></td><td></td>
      <td></td><td></td><td></td><td></td>
      <td><div align="right">Total :</div></td>
      <td><div align="left"><font size="3" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(total,",.__")#</cfoutput></strong></font></div></td>
      </tr>
    </table>
    <br>
    <div align="right">
      <!---       <cfif #start# neq 1>
        <cfoutput><a href="l_icitem.cfm">Previous</a> ||</cfoutput>
      </cfif>
      <cfif #page# neq #noOfPage#>
        <cfoutput> <a href="l_icitem.cfm">Next</a> ||</cfoutput>
      </cfif> --->
    </div>
    <cfelse>
    <h3><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.</font></h3>
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
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
		<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
		</cfif>

						<cfset dd = dateformat(form.dateto, 'DD')>
		<cfif dd greater than '12'>
		<cfset ndateto= dateformat(form.dateto,"YYYYMMDD")>
		<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
		</cfif>

</cfif>
<cfparam name="total" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getallservice" datasource="#dts#">
  select servi as servi from icservi where 0=0
  <cfif form.servicefrom neq "" and form.serviceto neq "">
	and itemno >= '#form.servicefrom#' and itemno <= '#form.serviceto#'
  </cfif>
  union all
  select itemno as servi from icitem where 0=0 and itemtype='SV'
  <cfif form.itemfrom neq "" and form.itemto neq "">
	and itemno >= '#form.itemfrom#' and itemno <= '#form.itemto#'
  </cfif>
</cfquery>

<cfset itemlist=valuelist(getallservice.servi)>


<cfquery name="getservice" datasource="#dts#">
  select * from ictran
  where fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#' and type in (#ListQualify(marktype,"'")#) 
  <cfif itemlist neq ''>
  and itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
  </cfif>
    <cfif form.customerfrom neq "" and form.customerto neq "">
	and custno >= '#form.customerfrom#' and custno <= '#form.customerto#'
  </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
	and agenno >= '#form.agentfrom#' and agenno<= '#form.agentto#'
  </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
  </cfif>


</cfquery>

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
				 		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>

		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                 <Style ss:ID="s47">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
					
		  		</Style>
                  <Style ss:ID="s80">
				  <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" />
					
		  		</Style>
                 <Style ss:ID="s90">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                 <Style ss:ID="s91">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
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
		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
		<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="60.75"/>
					<Column ss:Width="80.75"/>
					<Column ss:Width="150.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="200.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
                    <cfset d="8">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                        <cfset d=d+1>

		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Service Listing report </Data></Cell>
					</Row>
                    
            <cfif form.Servicefrom neq "" and form.Serviceto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.Servicefrom# - #form.Serviceto#" output = "wddxText">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Service Code #wddxText#</Data></Cell>
      			</Row>
			</cfif>
            
            <cfif form.customerfrom neq "" and form.customerto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.customerfrom# - #form.customerto#" output = "wddxText1">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Customer  #wddxText1#</Data></Cell>
      			</Row>
			</cfif>
            
            <cfif form.agentfrom neq "" and form.agentto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText2">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Agent  #wddxText2#</Data></Cell>
      			</Row>
			</cfif>
            
            <cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText3">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Period  #wddxText3#</Data></Cell>
      			</Row>
			</cfif>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText4">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Date #wddxText4#</Data></Cell>
      			</Row>
			</cfif>
        
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText5">
     				<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText6">
        			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
           </Row>

 <cfif #getservice.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getPersonal.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif></cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
       <Cell ss:StyleID="s50"><Data ss:Type="String">No</Data></Cell>
       <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Date</cfoutput></Data></Cell>
       <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Type</cfoutput></Data></Cell>
   	   <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Ref No</cfoutput></Data></Cell>
       <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Customer Code</cfoutput></Data></Cell>
       <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Customer Name</cfoutput></Data></Cell>
       <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Description</cfoutput></Data></Cell>>
       <Cell ss:StyleID="s50"><Data ss:Type="String">Qty</Data></Cell>
       <Cell ss:StyleID="s50"><Data ss:Type="String">Amount</Data></Cell>
       
      </Row>
     </cfoutput>
       
      <cfoutput query="getservice" startrow="1">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#i#" output = "wddxText7">
     				<cfwddx action = "cfml2wddx" input = "#dateformat(wos_date,'DD-MM-YYYY')#" output = "wddxText8">
     				<cfwddx action = "cfml2wddx" input = "#Type#" output = "wddxText9">
     				<cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText10">
     				<cfwddx action = "cfml2wddx" input = "#custno#" output = "wddxText11">
     				<cfwddx action = "cfml2wddx" input = "#name#" output = "wddxText12">
     				<cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText13">
     				<cfwddx action = "cfml2wddx" input = "#qty_Bil#" output = "wddxText14">
     				<cfwddx action = "cfml2wddx" input = "#NumberFormat(amt_bil, ",_.__")#" output = "wddxText15">
    
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
    </Row>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
        
        		<cfset total=total+val(getservice.amt_bil)>
    </cfoutput>
    	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    </Row>

      <cfoutput>          
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                        <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
      					<Cell ss:StyleID="s51"><Data ss:Type="String">Total :</Data></Cell>
      					<Cell ss:StyleID="s46"><Data ss:Type="String"><cfoutput>#numberformat(total,",.__")#</cfoutput></Data></Cell>
      </Row>

        
        
   		<!---<cfif form.datefrom neq "" and form.dateto neq "">
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