<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfif form.result eq "html">

<html>
<head>
<title>Staff Attendance Report</title>
<link href="../../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">

</head>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-DD-MM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYY-DD-MM")>
	</cfif>
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	select lastaccyear,cost,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION 
	from gsetup
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select * from staffattendance
    where logintype='login'
	<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
	</cfif>
    group by wos_date,cashier,logintype
	order by cashier
</cfquery>

<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<p align="center"><font color="##000000" size="3" face="Arial, Helvetica, sans-serif"><strong>Staff Attendance</strong></font></p>
<cfif getitem.recordcount neq 0>
	<table width="100%" border="0" class="" align="center">
		<tr>
			<td colspan="8"><hr></td>
		</tr>
	  	<tr>
        	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Staff</font></strong></td>
    		<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Date</font></strong></td>
        	<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Check In Time</font></strong></td>
  			<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Check Out Time</font></strong></td>
            <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Login Duration</font></strong></td>
        </tr>
  		<tr>
			<td colspan="8"><hr></td>
		</tr>

		<cfoutput query="getitem">
		<cfquery name="getlogout" datasource="#dts#">
            select * from staffattendance
            where logintype='logout' and wos_date="#dateformat(getitem.wos_date,'yyyy-mm-dd')#" and cashier='#getitem.cashier#'
            
        </cfquery>
  			<tr>
    			<td><font size="2" face="Arial, Helvetica, sans-serif">#getitem.cashier#</font></td>
   	 			<td><font size="2" face="Arial, Helvetica, sans-serif">#dateformat(getitem.wos_date,'dd/mm/yyyy')#</font></td>
    			<td>#timeformat(getitem.time,'HH:MM:SS')#</td>
				<td>#timeformat(getlogout.time,'HH:MM:SS')#</td>
                <td>#DateDiff("n",getitem.time,getlogout.time)# Minutes</td>
			</tr>
  		</cfoutput>
	</table>
<cfelse>
  	<h3><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.</font></h3>
</cfif>

<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>

<cfelse>


<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-DD-MM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYY-DD-MM")>
	</cfif>
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	select lastaccyear,cost,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION 
	from gsetup
</cfquery>


		<cfset iDecl_UPrice = ",___.__">
		<cfset stDecl_UPrice = ",___.__">
	
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
			
			<Worksheet ss:Name="Staff Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="100.75"/>
                    <Column ss:Width="100.75"/>
                    <Column ss:Width="100.75"/>
					<Column ss:Width="100.25"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
                    <Column ss:Width="100.75"/>
					<cfset c="5">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
				<!---Heading---->
		   
                <cfwddx action = "cfml2wddx" input = "Staff Attendance" output = "wddxText">
                <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                    <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                </Row>

					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Staff</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Date</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Check In Time</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Check Out Time</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Login Duration</Data></Cell>
					
				</Row>
			<cfquery name="getitem" datasource="#dts#">
                select * from staffattendance
                where logintype='login'
                <cfif form.datefrom neq "" and form.dateto neq "">
                        and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
                </cfif>
                group by wos_date,cashier,logintype
                order by cashier
            </cfquery>
				
			<cfloop query="getitem">
			<cfquery name="getlogout" datasource="#dts#">
            select * from staffattendance
            where logintype='logout' and wos_date="#dateformat(getitem.wos_date,'yyyy-mm-dd')#" and cashier='#getitem.cashier#'
        	</cfquery>
				<cfoutput>
					<cfwddx action = "cfml2wddx" input = "#getitem.cashier#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'dd/mm/yyyy')#" output = "wddxText2">
					<cfwddx action = "cfml2wddx" input = "#timeformat(getitem.time,'HH:MM:SS')#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#timeformat(getlogout.time,'HH:MM:SS')#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#DateDiff("n",getitem.time,getlogout.time)# Minutes" output = "wddxText5">
					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
					
					</Row>
				</cfoutput>
                </cfloop>
				
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
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
</cfif>