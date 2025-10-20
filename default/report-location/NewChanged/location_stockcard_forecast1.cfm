<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select 
	cost,
	compro,
	lastaccyear 
	from gsetup;
</cfquery>

<cfparam name="i" default="1" type="numeric">

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>
<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">

<cfquery name="getictran" datasource="#dts#">
	select 
	a.itemno,
	b.* from icitem a,ictran b 
	where b.type not in ('QUO','SO','PO') 
	and a.itemno=b.itemno 
	and b.location <> '' 
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
	and a.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
	and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
	and b.wos_date between '#ndatefrom#' and '#ndateto#'
	</cfif>
	<cfif form.locfrom neq "" and form.locto neq "">
	and b.location between '#form.locfrom#' and '#form.locto#'
	group by b.itemno order by b.location
	</cfif>
	<cfif form.locfrom eq "" and form.locto eq "">
	group by b.itemno order by b.itemno
	</cfif>
</cfquery>

<cfif form.locfrom neq "" and form.locto neq "">
	<cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> - <cfoutput>#form.locfrom# - #form.locto#</cfoutput>
<cfelse>
	<cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> - All
</cfif>

   
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
                
              <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
				</Style>
             
                  
		 	</Styles>
			
			<Worksheet ss:Name="View Forecast">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="180.25"/>
					<Column ss:Width="220.75"/>
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

      	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">View Forecast</Data></Cell>
    </Row>
    
<Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
  		   <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText1">
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText1#</Data></Cell>
    </Row>
   
<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s51"><Data ss:Type="String">No</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">Item No.</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">Description</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">Purchase Order</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">Sales Order</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">On Hand</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">PO+OH-SO</Data></Cell>
    </Row>
</cfoutput>
	<cfoutput query="getictran">
		<cfset itembal = 0>
      	<cfset rcqty = 0>
      	<cfset invqty = 0>
      	<cfset cnqty = 0>
      	<cfset prqty = 0>
      	<cfset dnqty = 0>
      	<cfset csqty = 0>
      	<cfset doqty = 0>
      	<cfset poqty = 0>
      	<cfset soqty = 0>
	  	<cfset issqty = 0>
	  	<cfset oaiqty = 0>
	  	<cfset oarqty = 0>
	  	<cfset trinqty = 0>
	  	<cfset troutqty = 0>
      	
		<cfquery name="getitem" datasource="#dts#">
      		select * from icitem where itemno='#itemno#'
      	</cfquery>
		
		<cfquery name="getrc" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type ="RC" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getrc.recordcount gt 0>
        	<cfif getrc.sumqty neq "">
        		<cfset RCqty = getrc.sumqty>
        	</cfif>
      	</cfif>
		
      	<cfquery name="getpr" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "PR" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      
	  	<cfif getpr.recordcount gt 0>
       		<cfif getpr.sumqty neq "">
          		<cfset PRqty = getpr.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getdo" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getdo.recordcount gt 0>
        	<cfif getdo.sumqty neq "">
          		<cfset DOqty = getdo.sumqty>
        	</cfif>
      	</cfif>
		
		<cfquery name="getinv" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "INV"
      		and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq ""> 
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getinv.recordcount gt 0>
        	<cfif getinv.sumqty neq "">
          		<cfset INVqty = getinv.sumqty>
        	</cfif>
      	</cfif>
		
      	<cfquery name="getcn" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "CN" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getcn.recordcount gt 0>
        	<cfif getcn.sumqty neq "">
        		<cfset CNqty = getcn.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getdn" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "DN" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getdn.recordcount gt 0>
        	<cfif getdn.sumqty neq "">
          		<cfset DNqty = getdn.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getcs" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "CS" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getcs.recordcount gt 0>
        	<cfif getcs.sumqty neq "">
          		<cfset CSqty = getcs.sumqty>
        	</cfif>
      	</cfif>
		
	  	<cfquery name="getiss" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "ISS" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif getiss.recordcount gt 0>
        	<cfif getiss.sumqty neq "">
          		<cfset ISSqty = getiss.sumqty>
        	</cfif>
      	</cfif>

      	<cfquery name="getpo" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "PO" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getpo.recordcount gt 0>
        	<cfif getpo.sumqty neq "">
        		<cfset poqty = getpo.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getso" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "SO" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getso.recordcount gt 0>
        	<cfif getso.sumqty neq "">
          		<cfset soqty = getso.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="getoai" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "OAI" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif getoai.recordcount gt 0>
        	<cfif getoai.sumqty neq "">
          		<cfset oaiqty = getoai.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="getoar" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "OAR" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getoar.recordcount gt 0>
        	<cfif getoar.sumqty neq "">
          		<cfset oarqty = getoar.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="gettrin" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "TRIN" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif gettrin.recordcount gt 0>
        	<cfif gettrin.sumqty neq "">
          		<cfset trinqty = gettrin.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="gettrout" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "TROU" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif gettrout.recordcount gt 0>
        	<cfif gettrout.sumqty neq "">
          		<cfset troutqty = gettrout.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfif getitem.qtybf neq "">
        	<cfset itembal = getitem.qtybf>
      	</cfif>
      	
		<cfset balonhand = itembal + rcqty + oaiqty - oarqty + trinqty - troutqty - prqty - doqty - invqty + cnqty - dnqty - csqty - issqty>
      	<cfset poohso = poqty + balonhand - soqty>
        
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#i#" output = "wddxText2">
  		   <cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText3">
  		   <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText4">
  		   <cfwddx action = "cfml2wddx" input = "#poqty#" output = "wddxText5">
  		   <cfwddx action = "cfml2wddx" input = "#soqty#" output = "wddxText6">
  		   <cfwddx action = "cfml2wddx" input = "#balonhand#" output = "wddxText7">
  		   <cfwddx action = "cfml2wddx" input = "#poohso#" output = "wddxText8">

        	 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
        	 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
        	 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
        	 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
        	 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
        	 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
       	 	 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
      	</Row>

      	<cfset i = incrementvalue(i)>
    </cfoutput>
 
    </Table>

<cfif getictran.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
</cfif>

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
<title>View Forecast</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select 
	cost,
	compro,
	lastaccyear 
	from gsetup;
</cfquery>

<cfparam name="i" default="1" type="numeric">

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getictran" datasource="#dts#">
	select 
	a.itemno,
	b.* from icitem a,ictran b 
	where b.type not in ('QUO','SO','PO') 
	and a.itemno=b.itemno 
	and b.location <> '' 
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
	and a.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
	and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
	and b.wos_date between '#ndatefrom#' and '#ndateto#'
	</cfif>
	<cfif form.locfrom neq "" and form.locto neq "">
	and b.location between '#form.locfrom#' and '#form.locto#'
	group by b.itemno order by b.location
	</cfif>
	<cfif form.locfrom eq "" and form.locto eq "">
	group by b.itemno order by b.itemno
	</cfif>
</cfquery>

<cfif form.locfrom neq "" and form.locto neq "">
	<cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> - <cfoutput>#form.locfrom# - #form.locto#</cfoutput>
<cfelse>
	<cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> - All
</cfif>

<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>

<table border="0" align="center" width="100%">
  	<tr>
      	<td colspan="7"><div align="center"><font size="4" face="Times New Roman, Times, serif"><strong>View Forecast</strong></font></div></td>
    </tr>
	<tr>
		<cfoutput>
      	<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</cfoutput>
    </tr>
    <tr>
      	<td colspan="7"><hr></td>
    </tr>
    <tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">No</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item No.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Description</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Purchase Order</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Sales Order</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">On Hand</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PO+OH-SO</font></div></td>
    </tr>
	<tr>
      	<td colspan="7"><hr></td>
    </tr>
	<cfoutput query="getictran">
		<cfset itembal = 0>
      	<cfset rcqty = 0>
      	<cfset invqty = 0>
      	<cfset cnqty = 0>
      	<cfset prqty = 0>
      	<cfset dnqty = 0>
      	<cfset csqty = 0>
      	<cfset doqty = 0>
      	<cfset poqty = 0>
      	<cfset soqty = 0>
	  	<cfset issqty = 0>
	  	<cfset oaiqty = 0>
	  	<cfset oarqty = 0>
	  	<cfset trinqty = 0>
	  	<cfset troutqty = 0>
      	
		<cfquery name="getitem" datasource="#dts#">
      		select * from icitem where itemno='#itemno#'
      	</cfquery>
		
		<cfquery name="getrc" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type ="RC" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getrc.recordcount gt 0>
        	<cfif getrc.sumqty neq "">
        		<cfset RCqty = getrc.sumqty>
        	</cfif>
      	</cfif>
		
      	<cfquery name="getpr" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "PR" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      
	  	<cfif getpr.recordcount gt 0>
       		<cfif getpr.sumqty neq "">
          		<cfset PRqty = getpr.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getdo" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getdo.recordcount gt 0>
        	<cfif getdo.sumqty neq "">
          		<cfset DOqty = getdo.sumqty>
        	</cfif>
      	</cfif>
		
		<cfquery name="getinv" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "INV"
      		and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq ""> 
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getinv.recordcount gt 0>
        	<cfif getinv.sumqty neq "">
          		<cfset INVqty = getinv.sumqty>
        	</cfif>
      	</cfif>
		
      	<cfquery name="getcn" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "CN" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getcn.recordcount gt 0>
        	<cfif getcn.sumqty neq "">
        		<cfset CNqty = getcn.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getdn" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "DN" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getdn.recordcount gt 0>
        	<cfif getdn.sumqty neq "">
          		<cfset DNqty = getdn.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getcs" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "CS" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getcs.recordcount gt 0>
        	<cfif getcs.sumqty neq "">
          		<cfset CSqty = getcs.sumqty>
        	</cfif>
      	</cfif>
		
	  	<cfquery name="getiss" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "ISS" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif getiss.recordcount gt 0>
        	<cfif getiss.sumqty neq "">
          		<cfset ISSqty = getiss.sumqty>
        	</cfif>
      	</cfif>

      	<cfquery name="getpo" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "PO" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getpo.recordcount gt 0>
        	<cfif getpo.sumqty neq "">
        		<cfset poqty = getpo.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfquery name="getso" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "SO" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getso.recordcount gt 0>
        	<cfif getso.sumqty neq "">
          		<cfset soqty = getso.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="getoai" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "OAI" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif getoai.recordcount gt 0>
        	<cfif getoai.sumqty neq "">
          		<cfset oaiqty = getoai.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="getoar" datasource="#dts#">
      		select sum(qty)as sumqty from ictran where type = "OAR" and itemno = '#itemno#'
      		<cfif form.locfrom neq "" and form.locto neq "">
        	and location = '#location#'
      		</cfif>
      		<cfif form.periodfrom neq "" and form.periodto neq "">
        	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      		</cfif>
      		<cfif form.datefrom neq "" and form.dateto neq "">
        	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
      		</cfif>
      	</cfquery>
      	
		<cfif getoar.recordcount gt 0>
        	<cfif getoar.sumqty neq "">
          		<cfset oarqty = getoar.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="gettrin" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "TRIN" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif gettrin.recordcount gt 0>
        	<cfif gettrin.sumqty neq "">
          		<cfset trinqty = gettrin.sumqty>
        	</cfif>
      	</cfif>
	  	
		<cfquery name="gettrout" datasource="#dts#">
			select sum(qty)as sumqty from ictran where type = "TROU" and itemno = '#itemno#'
			<cfif form.locfrom neq "" and form.locto neq "">
			and location = '#location#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			</cfif>
      	</cfquery>
      	
		<cfif gettrout.recordcount gt 0>
        	<cfif gettrout.sumqty neq "">
          		<cfset troutqty = gettrout.sumqty>
        	</cfif>
      	</cfif>
      	
		<cfif getitem.qtybf neq "">
        	<cfset itembal = getitem.qtybf>
      	</cfif>
      	
		<cfset balonhand = itembal + rcqty + oaiqty - oarqty + trinqty - troutqty - prqty - doqty - invqty + cnqty - dnqty - csqty - issqty>
      	<cfset poohso = poqty + balonhand - soqty>
      	
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#i#</font></div></td>
        	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
        	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
        	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty#</font></div></td>
        	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#soqty#</font></div></td>
        	<td width="8%"><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
       	 <td width="9%"><div align="right"><font size="2" face="Times New Roman, Times, serif">#poohso#</font></div></td>
      	</tr>
      	<cfset i = incrementvalue(i)>
    </cfoutput>
</table>
  
<cfif getictran.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>

</body>
</html>

</cfcase>
</cfswitch>