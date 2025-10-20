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
<cfset grouptotal=0>
<cfset catetotal=0>
<cfset itemtotal=0>
<cfset billtotal=0>
<cfset agenttotal=0>


<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<cfquery name="gettotal" datasource="#dts#">
			select sum(invgross) as invgross,sum(discount) as discount,sum(net) as net,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd)+sum(CS_PM_crc2) as CS_PM_crcd,sum(CS_PM_cheq) as CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc from artran
			where type in ('CS','INV') and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
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
                
				<Style ss:ID="s54">
				<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                <Style ss:ID="s53">
				<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					</Style>
                
		 	</Styles>
			
			<Worksheet ss:Name="Daily Checkout Report2">
            
            <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="180.5"/>
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
			<Cell ss:StyleID="s22"><Data ss:Type="String">Daily Checkout Report 2</Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#dateformat(now(),'DD/MM/YYYY')# #timeformat(now(),'HH:MM')#" output = "wddxText1">
			<Cell ss:StyleID="s24"><Data ss:Type="String">Printing : #wddxText1#</Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#form.counter#" output = "wddxText2">
			<Cell ss:StyleID="s24"><Data ss:Type="String">Counter : #wddxText2#</Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s24"><Data ss:Type="String">Casher :</Data></Cell>
			</Row>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText3">
			<Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText3#</Data></Cell>
				</Row>
			</cfif>
			
            <cfquery name="getbilltran" datasource="#dts#">
			select grand,refno from artran
			where type in ('CS','INV') and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
		</cfquery>
	
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s54"><Data ss:Type="String">Transaction Detail : Cash Sales</Data></Cell>
			<Cell ss:StyleID="s54"><Data ss:Type="String"></Data></Cell>
			</Row>
            <cfloop query="getbilltran">
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#getbilltran.refno#" output = "wddxText4">
            <cfwddx action = "cfml2wddx" input = "#numberformat(getbilltran.grand,',_.__')#" output = "wddxText5">
            <Cell ss:StyleID="s54"><Data ss:Type="String">#wddxText4#</Data></Cell>
			<Cell ss:StyleID="s54"><Data ss:Type="String">#wddxText5#</Data></Cell>
			</Row>
            <cfset billtotal=billtotal+getbilltran.grand>

            </cfloop>

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(billtotal,',_.__')#" output = "wddxText6">
            	<Cell ss:StyleID="s53"><Data ss:Type="String">Total :</Data></Cell>
				<Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText6#</Data></Cell>
			</Row>
            
            <cfquery name="getagenttran" datasource="#dts#">
			select sum(grand) as grand,agenno from artran
			where type in ('CS','INV') and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            group by agenno
		</cfquery>

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s54"><Data ss:Type="String">Transaction Detail : Agent</Data></Cell>
			<Cell ss:StyleID="s54"><Data ss:Type="String"></Data></Cell>
			</Row>
            
            <cfloop query="getagenttran">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#getagenttran.agenno#" output = "wddxText7">
            <cfwddx action = "cfml2wddx" input = "#numberformat(getagenttran.grand,',_.__')#" output = "wddxText8">
            <Cell ss:StyleID="s54"><Data ss:Type="String">#wddxText7#</Data></Cell>
			<Cell ss:StyleID="s54"><Data ss:Type="String">#wddxText8#</Data></Cell>
			</Row>
            <cfset agenttotal=agenttotal+getagenttran.grand>

            </cfloop>

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(agenttotal,',_.__')#" output = "wddxText9">
            <Cell ss:StyleID="s53"><Data ss:Type="String">Total :</Data></Cell>
			<Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText9#</Data></Cell>
			</Row>
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
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
    
    <cfcase value="HTML">
                     

		<html>
		<head>
		<title>Cash Sales Summary Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<body>
		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<cfquery name="gettotal" datasource="#dts#">
			select sum(invgross) as invgross,sum(discount) as discount,sum(net) as net,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd)+sum(CS_PM_crc2) as CS_PM_crcd,sum(CS_PM_cheq) as CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc from artran
			where type in ('CS','INV') and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
		</cfquery>

		<cfoutput>
		<table width="230px" style="font-size:11px; border-width:thin;" cellpadding="0" cellspacing="0" >
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Daily Checkout Report 2</strong></font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Printing : #dateformat(now(),'DD/MM/YYYY')# #timeformat(now(),'HH:MM')#</font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Counter : #form.counter#</font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Casher :</font></div></td>
			</tr>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            
            <cfquery name="getbilltran" datasource="#dts#">
			select grand,refno from artran
			where type in ('CS','INV') and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
		</cfquery>
		<tr>
				<td colspan="100%"><br></td>
			</tr>
        <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Transaction Detail : Cash Sales</strong></font></td>
			</tr>
            <cfloop query="getbilltran">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">#getbilltran.refno#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getbilltran.grand,',_.__')#</font></td>
                
			</tr>
            <cfset billtotal=billtotal+getbilltran.grand>

            </cfloop>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(billtotal,',_.__')#</font></td>
                
			</tr>
            
            <cfquery name="getagenttran" datasource="#dts#">
			select sum(grand) as grand,agenno from artran
			where type in ('CS','INV') and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            group by agenno
		</cfquery>
		<tr>
				<td colspan="100%"><br></td>
			</tr>
        <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Transaction Detail : Agent</strong></font></td>
			</tr>
            <cfloop query="getagenttran">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">#getagenttran.agenno#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getagenttran.grand,',_.__')#</font></td>
                
			</tr>
            <cfset agenttotal=agenttotal+getagenttran.grand>

            </cfloop>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(agenttotal,',_.__')#</font></td>
                
			</tr>
            
			</tr>
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