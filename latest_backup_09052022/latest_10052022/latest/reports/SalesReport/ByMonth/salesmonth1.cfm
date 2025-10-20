 <cfset uuid = CreateUUID()>
<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice,agentlistuserid
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>

		<cfset stDecl_UPrice = getgeneral.decl_uprice>
        
<cfquery name="getitem" datasource="#dts#">
    SELECT agenno,type,count(distinct(custno)) as custnocount,fperiod FROM artran
    WHERE type in("INV","CS"<cfif isdefined('form.include')>,"DN"</cfif>)
    and (void = '' or void is null) 
    and wos_date > "#getgeneral.lastaccyear#"
    <cfif form.periodfrom neq "" and form.periodto neq "">
        and fperiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
    <cfelse>
    	and fperiod between "01" and "18"
    </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
        and agenno between "#form.agentfrom#" and "#form.agentto#"
    </cfif>
    <cfif form.areafrom neq "" and form.areato neq "">
        and area between "#form.areafrom#" and "#form.areato#"
    </cfif>
    <cfif form.teamfrom neq "" and form.teamto neq "">
        and agenno in(select agent from #target_icagent# where  team >= '#form.teamfrom#' and  <= '#form.teamto#')
    </cfif>
    <cfif url.alown eq "1">
		<cfif getgeneral.agentlistuserid eq "Y">
            and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
        <cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
        </cfif>
    <cfelse>
		<cfif Huserloc neq "All_loc">
            and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
        </cfif>
    </cfif>
    group by agenno,fperiod
</cfquery>


<cfquery name="emptyold" datasource="#dts#">
DELETE from salesmonthreport WHERE reportime < "#dateformat(dateadd('d','-1',now()),'YYYY-MM-DD')#"
</cfquery>

<cfquery name="insertitem" datasource="#dts#">
INSERT INTO salesmonthreport (subject,uuid,desp) select agent,"#uuid#" as uuid,desp from #target_icagent# WHERE 1=1
<cfif form.agentfrom neq "" and form.agentto neq "">
and agent between '#form.agentfrom#' and '#form.agentto#' 
</cfif>
</cfquery>

<cfloop query="getitem">
<cfquery name="updatedata" datasource="#dts#">
    UPDATE salesmonthreport 
    SET p#numberformat(getitem.fperiod,'00')# = "#getitem.custnocount#"
    WHERE subject = "#getitem.agenno#"
    and uuid = "#uuid#"
</cfquery>
</cfloop>
<cfquery name="updatetabletotal" datasource="#dts#">
    UPDATE salesmonthreport SET totalrow = 
    <cfif form.periodfrom neq "" and form.periodto neq "">
		<cfset startloop = form.periodfrom>
        <cfset endloop = form.periodto>
        <cfloop from="#startloop#" to="#endloop#" index="i">
            P#numberformat(i,'00')#<cfif i neq endloop>+</cfif>
        </cfloop>
    <cfelse>
		<cfset startloop = 01>
        <cfset endloop = 18>
        <cfloop from="#startloop#" to="#endloop#" index="i">
            P#numberformat(i,'00')#<cfif i neq endloop>+</cfif>
        </cfloop>
    </cfif>
    WHERE uuid = "#uuid#"
    </cfquery>
    
    <cfquery name="getdata" datasource="#dts#">
    SELECT * FROM salesmonthreport WHERE uuid = "#uuid#"
    <cfif isdefined('form.include0')>
    <cfelse>
    and totalrow <> 0
    </cfif>
    order by subject
</cfquery>

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
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                 <Style ss:ID="s51">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>

		  		</Style>
                
                 <Style ss:ID="s52">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>

		  		</Style>
                
		 	</Styles>
			
			<Worksheet ss:Name="Active Customer SALES BY MONTH REPORT (Included DN/CN)">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="100.25"/>
					<Column ss:Width="180.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
						<cfset c=c+1>
 				<cfoutput>
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
	<cfif isdefined("form.include")>
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Active Customer SALES BY MONTH REPORT (Included DN/CN)</Data></Cell>
    <cfelse>
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Active Customer SALES BY MONTH REPORT (Excluded DN/CN)</Data></Cell>
	</cfif>
	</Row>
    
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText11">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">
	  		<cfif form.periodfrom neq "" and form.periodto neq "">
            	PERIOD #wddxText11#
            <cfelse>
				ONE YEAR
			</cfif>
	  	</Data></Cell>
	  	</Row>

   
    <cfif form.agentfrom neq "" and form.agentto neq "">
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">AGENT: #wddxText#</Data></Cell>
        </Row>
    </cfif>
    
    <cfif form.teamfrom neq "" and form.teamto neq "">
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#form.teamfrom# - #form.teamto#" output = "wddxText1">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">: #wddxText1#</Data></Cell>
        </Row>
    </cfif>
    
    <cfif form.areafrom neq "" and form.areato neq "">
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#form.areafrom# - #form.areato#" output = "wddxText2">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">AREA: #wddxText2#</Data></Cell>
        </Row>
    </cfif>
	
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText3">
         <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText4">
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
    </Row>
    
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
      	<Cell ss:StyleID="s50"><Data ss:Type="String">PRODUCT NO.</Data></Cell>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">DESP</Data></Cell>
		<cfif form.periodfrom neq "" and form.periodto neq "">
            <cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
                <Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
            </cfloop>
		<cfelse>
            <cfloop index="l" from="1" to="18">
                <Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
            </cfloop>
		</cfif>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">TOTAL</Data></Cell>
    </Row>
            <cfif form.periodfrom neq "" and form.periodto neq "">
            <cfset startloop = form.periodfrom>
            <cfset endloop = form.periodto>
            <cfelse>
            <cfset startloop = 01>
            <cfset endloop = 18>            
            </cfif>
            <cfloop index="a" from="#startloop#" to="#endloop#">
			<cfset monthtotal[a] = 0>
			</cfloop>
	<cfloop query="getdata">
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     
             <cfwddx action = "cfml2wddx" input = "#getdata.currentrow#" output = "wddxText5">
             <cfwddx action = "cfml2wddx" input = "#getdata.subject#" output = "wddxText6">
             <cfwddx action = "cfml2wddx" input = "#getdata.desp#" output = "wddxText7">
             <cfwddx action = "cfml2wddx" input = "#getdata.totalrow#" output = "wddxText8">

			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
			
            <cfloop from="#startloop#" to="#endloop#" index="i">
            <cfset columvalue = evaluate('getdata.p#numberformat(i,'00')#')>
            <Cell ss:StyleID="s26"><Data ss:Type="String">
			#columvalue#
            </Data></Cell>
            <cfset monthtotal[i] = monthtotal[i] + columvalue>
            </cfloop>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
            <cfset grandtotal = grandtotal + getdata.totalrow>
		</Row>
	</cfloop>
    
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
</Row>     
     
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">

             <cfwddx action = "cfml2wddx" input = "#val(grandtotal)#" output = "wddxText10">

      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    	<Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL:</Data></Cell>
        <cfloop from="#startloop#" to="#endloop#" index="i">
            <Cell ss:StyleID="s26"><Data ss:Type="String">#val(monthtotal[i])#</Data></Cell>
        </cfloop>
		
		<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText10#</Data></Cell>
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
<title>Product Sales By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
	<cfif isdefined("form.include")>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Active Customer SALES BY MONTH REPORT (Included DN/CN)</strong></font></div></td>
    <cfelse>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Active Customer SALES BY MONTH REPORT (Excluded DN/CN)</strong></font></div></td>
	</cfif>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		<cfif form.periodfrom neq "" and form.periodto neq "">
            	PERIOD #form.periodfrom# - #form.periodto#
            <cfelse>
            	ONE YEAR
            </cfif>
	  	</font></div>
	  	</td>
    </tr>
   
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
        </tr>
    </cfif>
    
    <cfif form.teamfrom neq "" and form.teamto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">: #form.teamfrom# - #form.teamto#</font></div></td>
        </tr>
    </cfif>
    
    <cfif form.areafrom neq "" and form.areato neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
        </tr>
    </cfif>
	
    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
      	<td><font size="2" face="Times New Roman, Times, serif">PRODUCT NO.</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">DESP</font></td>
		<cfif form.periodfrom neq "" and form.periodto neq "">
            <cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
            </cfloop>
        <cfelse>
            <cfloop index="l" from="1" to="18">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
            </cfloop>
		</cfif>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
            <cfset startloop = form.periodfrom>
            <cfset endloop = form.periodto>
            <cfelse>
            <cfset startloop = 01>
            <cfset endloop = 18>            
            </cfif>
            <cfloop index="a" from="#startloop#" to="#endloop#">
			<cfset monthtotal[a] = 0>
			</cfloop>
	<cfloop query="getdata">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.subject#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.desp#</font></td>
			
            <cfloop from="#startloop#" to="#endloop#" index="i">
            <cfset columvalue = evaluate('getdata.p#numberformat(i,'00')#')>
            <td><div align="right">
            <font size="2" face="Times New Roman, Times, serif">
			#columvalue#
            </font></div></td>
            <cfset monthtotal[i] = monthtotal[i] + columvalue>
            </cfloop>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getdata.totalrow#</font></div></td>
            <cfset grandtotal = grandtotal + getdata.totalrow>

		</tr>
	</cfloop>
	<tr>
    	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td></td>
		<td></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
        <cfloop from="#startloop#" to="#endloop#" index="i">
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(monthtotal[i])#<strong></strong></font></div></td>
        </cfloop>
		
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#val(grandtotal)#</strong></font></div></td>
	</tr>
</table>
</cfoutput>
<cfquery name="emptyall" datasource="#dts#">
DELETE from salesmonthreport WHERE uuid = "#uuid#" 
</cfquery>

<cfif getdata.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>

</cfcase>
</cfswitch>