<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfset fccurr = DateAdd('m', form.periodfrom, "#getgeneral.LastAccYear#")>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">
    
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
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                 <Style ss:ID="s52">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
		 	</Styles>
			
			<Worksheet ss:Name="Print End User Sales Weekly Report(Excluded DN/ CN)">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.25"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.25"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="85.75"/>
						<cfset c=c+1>
                        
				<cfoutput>
                
                 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
               <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PRINT #url.trantype# SALES WEEKLY REPORT (Excluded DN/CN)</Data></Cell>
               </Row>


        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#dateformat(fccurr,'mmm yy')#" output = "wddxText">
    			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">MONTH: #wddxText#</Data></Cell>
    	</Row>
    
    <cfif form.enduserfrom neq "" and form.enduserto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#form.enduserfrom# - #form.enduserto#" output = "wddxText1">
          		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">END USER: #wddxText1#</Data></Cell>
        </Row>
    </cfif>
    
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText2">
                <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText3">
      	<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#wddxText2#</cfif></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
   		 </Row>

	<cfset lastyear = year(getgeneral.lastaccyear)>
	<cfset lastmonth = month(getgeneral.lastaccyear)>
	<cfset lastday = 1>
	<cfset selectedmonth = val(form.periodfrom)>
	<cfset count = 1>
	<cfset noweek = 1>
	<cfset weekday = arraynew(1)>
	<cfset weeks = arraynew(1)>
	<cfset lastmonth = lastmonth + selectedmonth>

	<cfif lastmonth gt 24>
		<cfset lastyear = lastyear + 2>
		<cfset lastmonth = lastmonth -24>
        <cfelseif lastmonth gt 12>
        <cfset lastyear = lastyear + 1>
		<cfset lastmonth = lastmonth -12>
	</cfif>

	<cfset days = firstdayofmonth(createdate(lastyear,lastmonth,lastday))-2>

	<cfset totalday = daysinmonth(createdate(lastyear,lastmonth,1))>
	<cfset curweek = week(createdate(lastyear,lastmonth,1))>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif curweek neq curweek2>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfloop index="a" from="1" to="#noweek#">
		<cfset weekday[a] = 0>
	</cfloop>

	<cfset curweek = week(createdate(lastyear,lastmonth,1))>
	<cfset noweek = 1>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif a neq totalday>
			<cfset weeks[noweek] = curweek>
		<cfelse>
			<cfif week(createdate(lastyear,lastmonth,a-1)) eq week(createdate(lastyear,lastmonth,a))>
				<cfset weeks[noweek] = week(createdate(lastyear,lastmonth,a))>
			<cfelse>
				<cfset weeks[noweek + 1] = week(createdate(lastyear,lastmonth,a))>
			</cfif>
		</cfif>
		<cfif curweek eq curweek2>
			<cfset weekday[noweek] = weekday[noweek] + 1>
		<cfelse>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfset newtime = createdate(lastyear,1,1) + days>

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                
		<Cell ss:StyleID="s50"><Data ss:Type="String">PRODUCT NO.</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">DESP</Data></Cell>
	<cfloop index="a" from="1" to="#noweek#">
		<Cell ss:StyleID="s50"><Data ss:Type="String">W#a#</Data></Cell>
	</cfloop>
		<Cell ss:StyleID="s50"><Data ss:Type="String">TOTAL</Data></Cell>
	</Row>
    
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">

            <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>

	<cfloop index="a" from="#count#" to="#noweek#">
		<cfset weekday[a] = weekday[a] + 1>

		<cfif count eq 1>
			 <Cell ss:StyleID="s52"><Data ss:Type="String">#dateformat(newtime + 1,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</Data></Cell>
		<cfelse>
			 <Cell ss:StyleID="s52"><Data ss:Type="String">#dateformat(newtime,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</Data></Cell>
		</cfif>

		<cfset newtime = newtime + weekday[a] >
		<cfset count = count + 1>
	</cfloop>
            <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
	</Row>

<cfquery name="getdriver" datasource="#dts#">
	select b.driverno, b.name, b.customerno from artran a, driver b
	where a.van = b.driverno 
	and (a.void = '' or a.void is null) and a.fperiod = '#form.periodfrom#'	and (a.type = 'INV' or a.type = 'CS')
    <cfif form.enduserfrom neq "" and form.enduserto neq "">
	 and b.driverno >='#form.enduserfrom#' and b.driverno <='#form.enduserto#'
	</cfif>
    group by driverno order by driverno
</cfquery>

<cfset total = arraynew(1)>
<cfset subtotal = arraynew(1)>

<cfloop index="a" from="1" to="#noweek#">
	<cfset total[a] = 0>
</cfloop>

<cfloop query="getdriver">
	<cfset van = getdriver.driverno>

	<cfloop index="a" from="1" to="#noweek#">
		<cfset subtotal[a] = 0>
	</cfloop>

	<cfquery name="getintran" datasource="#dts#">
		select wos_date,qty,amt from ictran
		where wos_date > #getgeneral.lastaccyear# and fperiod = '#form.periodfrom#' and van = '#van#' and (void = '' or void is null)
		and (type = 'INV' or type = 'CS')
		
		order by fperiod
	</cfquery>

	<cfloop query="getintran">
		<cfset checkweek = week(getintran.wos_date)>
		<cfloop index="a" from="1" to="#noweek#">
			<cfif weeks[a] eq checkweek>
				<cfset subtotal[a] = subtotal[a] + val(getintran.amt)>
				<cfset total[a] = total[a] + val(getintran.amt)>
			</cfif>
		</cfloop>
	</cfloop>
          

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#getdriver.driverno#" output = "wddxText6">
            	<cfwddx action = "cfml2wddx" input = "#getdriver.name#" output = "wddxText7">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(subtotal[a],stDecl_UPrice)#" output = "wddxText8">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(arraysum(subtotal),stDecl_UPrice)#" output = "wddxText9">
        
            <Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText6#</Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText7#</Data></Cell>
        <cfloop index="a" from="1" to="#noweek#">
			<Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText8#</Data></Cell>
		</cfloop>
			<Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText9#</Data></Cell>
	</Row>
	<cfflush>
</cfloop>
 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
            </Row>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
        
            <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL:</Data></Cell>
		<cfloop index="a" from="1" to="#noweek#">
			<Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(total[a],",.__")#</Data></Cell>
		</cfloop>
		    <Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(arraysum(total),",.__")#</Data></Cell>
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
<title>End User Sales By Week Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<body>
<cfoutput>
<h1 align="center">PRINT #url.trantype# SALES WEEKLY REPORT (Excluded DN/CN)</h1>

<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
    	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">MONTH: #dateformat(fccurr,"mmm yy")#</font></div></td>
    </tr>
    <cfif form.enduserfrom neq "" and form.enduserto neq "">
        <tr>
          	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">END USER: #form.enduserfrom# - #form.enduserto#</font></div></td>
        </tr>
    </cfif>
    <tr>
      	<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="10"><hr></td>
    </tr>

	<cfset lastyear = year(getgeneral.lastaccyear)>
	<cfset lastmonth = month(getgeneral.lastaccyear)>
	<cfset lastday = 1>
	<cfset selectedmonth = val(form.periodfrom)>
	<cfset count = 1>
	<cfset noweek = 1>
	<cfset weekday = arraynew(1)>
	<cfset weeks = arraynew(1)>
	<cfset lastmonth = lastmonth + selectedmonth>

	<cfif lastmonth gt 24>
		<cfset lastyear = lastyear + 2>
		<cfset lastmonth = lastmonth -24>
        <cfelseif lastmonth gt 12>
        <cfset lastyear = lastyear + 1>
		<cfset lastmonth = lastmonth -12>
	</cfif>

	<cfset days = firstdayofmonth(createdate(lastyear,lastmonth,lastday))-2>

	<cfset totalday = daysinmonth(createdate(lastyear,lastmonth,1))>
	<cfset curweek = week(createdate(lastyear,lastmonth,1))>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif curweek neq curweek2>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfloop index="a" from="1" to="#noweek#">
		<cfset weekday[a] = 0>
	</cfloop>

	<cfset curweek = week(createdate(lastyear,lastmonth,1))>
	<cfset noweek = 1>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif a neq totalday>
			<cfset weeks[noweek] = curweek>
		<cfelse>
			<cfif week(createdate(lastyear,lastmonth,a-1)) eq week(createdate(lastyear,lastmonth,a))>
				<cfset weeks[noweek] = week(createdate(lastyear,lastmonth,a))>
			<cfelse>
				<cfset weeks[noweek + 1] = week(createdate(lastyear,lastmonth,a))>
			</cfif>
		</cfif>
		<cfif curweek eq curweek2>
			<cfset weekday[noweek] = weekday[noweek] + 1>
		<cfelse>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfset newtime = createdate(lastyear,1,1) + days>

	<tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
	<cfloop index="a" from="1" to="#noweek#">
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">W#a#</font></div></td>
	</cfloop>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
	<cfloop index="a" from="#count#" to="#noweek#">
		<cfset weekday[a] = weekday[a] + 1>

		<cfif count eq 1>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(newtime + 1,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(newtime,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</font></div></td>
		</cfif>

		<cfset newtime = newtime + weekday[a] >
		<cfset count = count + 1>
	</cfloop>
	</tr>
	<tr>
      	<td colspan="10"><hr></td>
    </tr>

<cfquery name="getdriver" datasource="#dts#">
	select b.driverno, b.name, b.customerno from artran a, driver b
	where a.van = b.driverno 
	and (a.void = '' or a.void is null) and a.fperiod = '#form.periodfrom#'	and (a.type = 'INV' or a.type = 'CS')
    <cfif form.enduserfrom neq "" and form.enduserto neq "">
	 and b.driverno >='#form.enduserfrom#' and b.driverno <='#form.enduserto#'
	</cfif>
    group by driverno order by driverno
</cfquery>

<cfset total = arraynew(1)>
<cfset subtotal = arraynew(1)>

<cfloop index="a" from="1" to="#noweek#">
	<cfset total[a] = 0>
</cfloop>

<cfloop query="getdriver">
	<cfset van = getdriver.driverno>

	<cfloop index="a" from="1" to="#noweek#">
		<cfset subtotal[a] = 0>
	</cfloop>

	<cfquery name="getintran" datasource="#dts#">
		select wos_date,qty,amt from ictran
		where wos_date > #getgeneral.lastaccyear# and fperiod = '#form.periodfrom#' and van = '#van#' and (void = '' or void is null)
		and (type = 'INV' or type = 'CS')
		
		order by fperiod
	</cfquery>

	<cfloop query="getintran">
		<cfset checkweek = week(getintran.wos_date)>
		<cfloop index="a" from="1" to="#noweek#">
			<cfif weeks[a] eq checkweek>
				<cfset subtotal[a] = subtotal[a] + val(getintran.amt)>
				<cfset total[a] = total[a] + val(getintran.amt)>
			</cfif>
		</cfloop>
	</cfloop>

	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdriver.driverno#</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdriver.name#</font></div></td>
		<cfloop index="a" from="1" to="#noweek#">
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal[a],stDecl_UPrice)#</font></div></td>
		</cfloop>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(arraysum(subtotal),stDecl_UPrice)#</font></div></td>
	</tr>
	<cfflush>
</cfloop>
	<tr>
      	<td colspan="10"><hr></td>
    </tr>
	<tr>
		<td></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<cfloop index="a" from="1" to="#noweek#">
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total[a],",.__")#</strong></font></div></td>
		</cfloop>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(arraysum(total),",.__")#</strong></font></div></td>
	</tr>
</table>

<cfif getdriver.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
</cfif>
</cfoutput>
<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>

</cfcase>
</cfswitch>