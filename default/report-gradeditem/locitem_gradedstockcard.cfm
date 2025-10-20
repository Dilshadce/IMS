<cfset frgrade=11>
<cfset tograde=310>


<cfparam name="initializelocation" default="999999999">

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup
</cfquery>

<cfquery name="getiteminfo" datasource="#dts#">
	select 
	<cfloop from="#frgrade#" to="#tograde#" index="i">
		(ifnull(e.qin#i#,0)) as qin#i#,
		(ifnull(f.qout#i#,0)) as qout#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)) as qtybf#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)+ifnull(e.qin#i#,0)-ifnull(f.qout#i#,0)) as balance#i#,
	</cfloop>
	a.location,b.*,(select desp from iclocation where location=a.location) as locdesp
			
	from logrdob as a 
			
	left join
	(
		select x.itemno,x.desp as itemdesp,x.unit,x.wos_group,x.category,x.graded,y.desp as groupdesp
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			,y.gradd#i#
		</cfloop>
		from icitem x,icgroup y
		where x.wos_group = y.wos_group
		and
			(y.gradd#tograde# <> ''
			<cfloop from="#frgrade#" to="#tograde-1#" index="i">
				or y.gradd#i# <> ''
			</cfloop>)
	) as b on a.itemno = b.itemno
	
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as getlastin#i#,
		</cfloop>
		itemno,location
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and fperiod+0 < '#form.periodfrom#' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
		</cfif>
		group by itemno,location
	) as c on (a.itemno=c.itemno and a.location=c.location)
	
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as getlastout#i#,
		</cfloop>
		itemno,location
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and fperiod+0 < '#form.periodfrom#' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
		</cfif>
		group by itemno,location
	) as d on (a.itemno=d.itemno and a.location=d.location)
						
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qin#i#,
		</cfloop>
		itemno,location
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
    		and wos_date between #date1# and #date2#
    	</cfif> 
		group by itemno,location
	) as e on (a.itemno=e.itemno and a.location=e.location)
			
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qout#i#,
		</cfloop>
		itemno,location
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
   		<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
    		and wos_date between #date1# and #date2#
    	</cfif> 
		group by itemno,location
	) as f on (a.itemno=f.itemno and a.location=f.location)
		
	where b.graded = 'Y'
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and b.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and b.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and a.location between '#form.locfrom#' and '#form.locto#'
	</cfif>
	order by b.wos_group,a.location,b.itemno
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
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>

		 	</Styles>
			
			<Worksheet ss:Name="Graded Item Stock Card Summary">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="180.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="60.75"/>
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
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">LOCATION - GRADED ITEM STOCK CARD SUMMARY</Data></Cell>
      	</Row>

	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.catefrom# - #form.cateto#" output = "wddxText">
        	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">CATE: #wddxText#</Data></Cell>
      	</Row>
	</cfif>
    
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.groupfrom# - #form.groupto#" output = "wddxText1">
        	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">GROUP: #wddxText1#</Data></Cell>
      	</Row>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.itemfrom# - #form.itemto#" output = "wddxText2">
        	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">ITEM.NO. #wddxText2#</Data></Cell>
      	</Row>
	</cfif>
    
	<cfif form.periodfrom neq "" and form.periodto neq "">
      	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#periodfrom# To #periodto#" output = "wddxText3">
        	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Period From #wddxText3#</Data></Cell>
      	</Row>
    </cfif>
    
    <cfif form.datefrom neq "" and form.dateto neq "">
      	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#dateformat(date1,"dd-mm-yyyy")# To #dateformat(date2,"dd-mm-yyyy")#" output = "wddxText4">
        	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Date From #wddxText4#</Data></Cell>
      	</Row>
    </cfif>
    
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            </Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText5">
     		<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd-mm-yyyy")#" output = "wddxText6">
        	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
	</Row>
	</cfoutput>
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            </Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
    	<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">DESP</Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">GRADE</Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">QTY B/F</Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
    	<Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
   	 	<Cell ss:StyleID="s50"><Data ss:Type="String">BALANCE</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ACTION</Data></Cell>
  	</Row>
    
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            </Row>
            
	<cfset thisgroup = "">
	<cfset thislocation = initializelocation>
	<cfoutput query="getiteminfo">
		<cfif thisgroup neq getiteminfo.wos_group>
			<cfif thisgroup neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            </Row>
			</cfif>
			<cfset thisgroup = getiteminfo.wos_group>
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo.wos_group##getiteminfo.groupdesp#" output = "wddxText7">
				<Cell ss:StyleID="s26"><Data ss:Type="String">GROUP;#wddxText7#</Data></Cell>
            </Row>
		</cfif>
		<cfif thislocation neq getiteminfo.location>
			<cfset thislocation = getiteminfo.location>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo.location##getiteminfo.locdesp#" output = "wddxText8">
				<Cell ss:StyleID="s26"><Data ss:Type="String">LOCATION:#wddxText8#</Data></Cell>
            </Row>
		</cfif>
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			<cfif getiteminfo["gradd#i#"][getiteminfo.currentrow] neq "">
				<cfif isdefined("form.include_stock")>	<!--- Include 0 qty --->
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                    <cfwddx action = "cfml2wddx" input = "#getiteminfo.itemno#" output = "wddxText9">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo.itemdesp#" output = "wddxText10">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["gradd#i#"][getiteminfo.currentrow]#" output = "wddxText11">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#" output = "wddxText12">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["qin#i#"][getiteminfo.currentrow]#" output = "wddxText13">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["qout#i#"][getiteminfo.currentrow]#" output = "wddxText14">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["balance#i#"][getiteminfo.currentrow]# #getiteminfo.unit#" output = "wddxText15">

				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">
							<a href="locitem_gradedstockcard2.cfm?itemno=#urlencodedformat(getiteminfo.itemno)#&itemdesp=#urlencodedformat(getiteminfo.itemdesp)#&location=#getiteminfo.location#&locationdesp=#getiteminfo.locdesp#&itembal=#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#&pf=#urlencodedformat(form.itemfrom)#&pt=#urlencodedformat(form.itemto)#&cf=#form.catefrom#&ct=#form.cateto#&pef=#form.periodfrom#&pet=#form.periodto#&gpf=#form.groupfrom#&gpt=#form.groupto#&df=#form.datefrom#&dt=#form.dateto#&gradenum=#i#&gradedesp=#getiteminfo["gradd#i#"][getiteminfo.currentrow]#">View Details</a>
						</Data></Cell>
			</Row>
				<cfelse>
					<cfif getiteminfo["balance#i#"][getiteminfo.currentrow] neq 0>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                    <cfwddx action = "cfml2wddx" input = "#getiteminfo.itemno#" output = "wddxText16">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo.itemdesp#" output = "wddxText17">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["gradd#i#"][getiteminfo.currentrow]#" output = "wddxText18">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#" output = "wddxText19">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["qin#i#"][getiteminfo.currentrow]#" output = "wddxText20">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["qout#i#"][getiteminfo.currentrow]#" output = "wddxText21">
             		<cfwddx action = "cfml2wddx" input = "#getiteminfo["balance#i#"][getiteminfo.currentrow]# #getiteminfo.unit#" output = "wddxText22">
            
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText16#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText17#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText18#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText19#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText20#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText21#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText22#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">
								<a href="locitem_gradedstockcard2.cfm?itemno=#urlencodedformat(getiteminfo.itemno)#&itemdesp=#urlencodedformat(getiteminfo.itemdesp)#&location=#getiteminfo.location#&locationdesp=#getiteminfo.locdesp#&itembal=#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#&pf=#urlencodedformat(form.itemfrom)#&pt=#urlencodedformat(form.itemto)#&cf=#form.catefrom#&ct=#form.cateto#&pef=#form.periodfrom#&pet=#form.periodto#&gpf=#form.groupfrom#&gpt=#form.groupto#&df=#form.datefrom#&dt=#form.dateto#&gradenum=#i#&gradedesp=#getiteminfo["gradd#i#"][getiteminfo.currentrow]#">View Details</a>
							</Data></Cell>
						</Row>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
	</cfoutput>
</Table>

<WorksheetOptions xmlns="urn:schemas-misscrosoft-com:office:excel">
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
<title>Location - Graded Item Stock Card</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="initializelocation" default="999999999">

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup
</cfquery>

<cfquery name="getiteminfo" datasource="#dts#">
	select 
	<cfloop from="#frgrade#" to="#tograde#" index="i">
		(ifnull(e.qin#i#,0)) as qin#i#,
		(ifnull(f.qout#i#,0)) as qout#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)) as qtybf#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)+ifnull(e.qin#i#,0)-ifnull(f.qout#i#,0)) as balance#i#,
	</cfloop>
	a.location,b.*,(select desp from iclocation where location=a.location) as locdesp
			
	from logrdob as a 
			
	left join
	(
		select x.itemno,x.desp as itemdesp,x.unit,x.wos_group,x.category,x.graded,y.desp as groupdesp
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			,y.gradd#i#
		</cfloop>
		from icitem x,icgroup y
		where x.wos_group = y.wos_group
		and
			(y.gradd#tograde# <> ''
			<cfloop from="#frgrade#" to="#tograde-1#" index="i">
				or y.gradd#i# <> ''
			</cfloop>)
	) as b on a.itemno = b.itemno
	
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as getlastin#i#,
		</cfloop>
		itemno,location
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and fperiod+0 < '#form.periodfrom#' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
		</cfif>
		group by itemno,location
	) as c on (a.itemno=c.itemno and a.location=c.location)
	
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as getlastout#i#,
		</cfloop>
		itemno,location
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and fperiod+0 < '#form.periodfrom#' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
		</cfif>
		group by itemno,location
	) as d on (a.itemno=d.itemno and a.location=d.location)
						
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qin#i#,
		</cfloop>
		itemno,location
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
    		and wos_date between #date1# and #date2#
    	</cfif> 
		group by itemno,location
	) as e on (a.itemno=e.itemno and a.location=e.location)
			
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qout#i#,
		</cfloop>
		itemno,location
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
   		<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
    		and wos_date between #date1# and #date2#
    	</cfif> 
		group by itemno,location
	) as f on (a.itemno=f.itemno and a.location=f.location)
		
	where b.graded = 'Y'
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and b.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and b.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and a.location between '#form.locfrom#' and '#form.locto#'
	</cfif>
	order by b.wos_group,a.location,b.itemno
</cfquery>

<body>
<table width="80%" border="0" align="center" cellspacing="0" cellpadding="2">
	<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>LOCATION - GRADED ITEM STOCK CARD SUMMARY</strong></font></div>
		</td>
	</tr>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.catefrom# - #form.cateto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
      	<tr>
        	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Period From #periodfrom# To #periodto#</font></div></td>
      	</tr>
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
      	<tr>
        	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #dateformat(date1,"dd-mm-yyyy")# To #dateformat(date2,"dd-mm-yyyy")#</font></div></td>
      	</tr>
    </cfif>
	<tr><td height="10"></td></tr>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5"></td></tr>
	<tr>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" height="24" width="15%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" width="*"><div align="center"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="15%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GRADE</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY B/F </font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
   	 	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>
  	</tr>
	<tr><td height="5"></td></tr>
	<cfset thisgroup = "">
	<cfset thislocation = initializelocation>
	<cfoutput query="getiteminfo">
		<cfif thisgroup neq getiteminfo.wos_group>
			<cfif thisgroup neq "">
				<tr><td height="10"></td></tr>
			</cfif>
			<cfset thisgroup = getiteminfo.wos_group>
			<tr>
				<td colspan="100%"><div align="left"><font size="2" face="Times New Roman,Times,serif"><u>GROUP:&nbsp;&nbsp;#getiteminfo.wos_group#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#getiteminfo.groupdesp#</u></font></div></td>
			</tr>
		</cfif>
		<cfif thislocation neq getiteminfo.location>
			<cfset thislocation = getiteminfo.location>
			<tr>
				<td colspan="100%"><div align="left"><font size="2" face="Times New Roman,Times,serif"><b>LOCATION:&nbsp;&nbsp;#getiteminfo.location#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#getiteminfo.locdesp#</b></font></div></td>
			</tr>
		</cfif>
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			<cfif getiteminfo["gradd#i#"][getiteminfo.currentrow] neq "">
				<cfif isdefined("form.include_stock")>	<!--- Include 0 qty --->
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemno#</font></div></td>
						<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemdesp#</font></div></td>
						<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qin#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qout#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["balance#i#"][getiteminfo.currentrow]# #getiteminfo.unit#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">
							<a href="locitem_gradedstockcard2.cfm?itemno=#urlencodedformat(getiteminfo.itemno)#&itemdesp=#urlencodedformat(getiteminfo.itemdesp)#&location=#getiteminfo.location#&locationdesp=#getiteminfo.locdesp#&itembal=#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#&pf=#urlencodedformat(form.itemfrom)#&pt=#urlencodedformat(form.itemto)#&cf=#form.catefrom#&ct=#form.cateto#&pef=#form.periodfrom#&pet=#form.periodto#&gpf=#form.groupfrom#&gpt=#form.groupto#&df=#form.datefrom#&dt=#form.dateto#&gradenum=#i#&gradedesp=#getiteminfo["gradd#i#"][getiteminfo.currentrow]#">View Details</a>
						</font></div></td>
					</tr>
				<cfelse>
					<cfif getiteminfo["balance#i#"][getiteminfo.currentrow] neq 0>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
							<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemno#</font></div></td>
							<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemdesp#</font></div></td>
							<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qin#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qout#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["balance#i#"][getiteminfo.currentrow]# #getiteminfo.unit#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">
								<a href="locitem_gradedstockcard2.cfm?itemno=#urlencodedformat(getiteminfo.itemno)#&itemdesp=#urlencodedformat(getiteminfo.itemdesp)#&location=#getiteminfo.location#&locationdesp=#getiteminfo.locdesp#&itembal=#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#&pf=#urlencodedformat(form.itemfrom)#&pt=#urlencodedformat(form.itemto)#&cf=#form.catefrom#&ct=#form.cateto#&pef=#form.periodfrom#&pet=#form.periodto#&gpf=#form.groupfrom#&gpt=#form.groupto#&df=#form.datefrom#&dt=#form.dateto#&gradenum=#i#&gradedesp=#getiteminfo["gradd#i#"][getiteminfo.currentrow]#">View Details</a>
							</font></div></td>
						</tr>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
	</cfoutput>
</table>
</body>
</html>

</cfcase>
</cfswitch>