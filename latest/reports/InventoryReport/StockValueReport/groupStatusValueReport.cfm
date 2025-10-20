
<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="EXCEl">
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
                
                
                  <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Group Status and Value Summary">
				
<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfparam name="i" default="1" type="numeric">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">
<cfparam name="OAIqty" default="0">
<cfparam name="OARqty" default="0">
<cfparam name="xucost" default="0.0000000">
<cfparam name="balonhand" default="0">
<cfparam name="lastbalonhand" default="0">
  <cfset grandtotalqtybf = 0>
    <cfset grandtotalin = 0>
    <cfset grandtotalout = 0>
    <cfset grandtotalqty = 0>
    <cfset grandtotalstkval = 0>
    <cfset grandtotalunitcost = 0>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = #getgsetup2.Decl_UPrice#>
<cfset stDecl_UPrice = "___.">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = #stDecl_UPrice# & "_">
</cfloop>

<cfif getgeneral.cost eq "FIXED">
	<cfset costingmethod = "Fixed Cost Method">
<cfelseif getgeneral.cost eq "MONTH">
	<cfset costingmethod = "Month Average Method">
<cfelseif getgeneral.cost eq "MOVING">
	<cfset costingmethod = "Moving Average Method">
<cfelseif getgeneral.cost eq "FIFO">
	<cfset costingmethod = "First In First Out Method">
<cfelse>
	<cfset costingmethod = "Last In First Out Method">
</cfif>


<cfif getgeneral.cost neq "fifo" and getgeneral.cost neq "lifo">

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp,wos_group,category,qtybf,ucost from icitem where itemno <> '' and wos_group <>''

	<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
	and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
	</cfif>
	group by wos_group order by wos_group
</cfquery>

<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="200.25"/>
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
				<cfwddx action = "cfml2wddx" input = "Group Status and Value Summary" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>

				<cfwddx action = "cfml2wddx" input = "Calculated by #costingmethod#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>      
                    
				<cfif form.periodfrom neq "" and form.periodto neq "">
                <cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
			
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
                <cfwddx action = "cfml2wddx" input = "CATEGORY: #form.categoryFrom# - #form.categoryTo#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
                <cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
                    	</cfif>
			
			                     
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
					<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText2">
                    
      				<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#wddxText1#</cfif></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
                    </Row>
    				</cfoutput>
 
   
  	<Row>
  		<Cell ss:StyleID="s50"><Data ss:Type="String">No</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Group</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Unit Cost</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Qty Bf</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">In</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Out</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Balance</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Stock Value ($)</Data></Cell></cfif>
	</Row>
 	
  <cfoutput query="getitem">
    <cfset itembal = 0>
	<cfset fixedcost = 0>
    <cfset rcqty = 0>
    <cfset invqty = 0>
    <cfset cnqty = 0>
    <cfset prqty = 0>
    <cfset dnqty = 0>
    <cfset doqty = 0>
	<cfset csqty = 0>
	<cfset issqty = 0>
	<cfset oaiqty = 0>
	<cfset oarqty = 0>
	<cfset xucost = 0.0000000>
	<cfset lastitembal = 0>
	<cfset lastrcqty = 0>
    <cfset lastinvqty = 0>
    <cfset lastcnqty = 0>
    <cfset lastprqty = 0>
    <cfset lastdnqty = 0>
    <cfset lastdoqty = 0>
	<cfset lastcsqty = 0>
	<cfset lastissqty = 0>
	<cfset lastoaiqty = 0>
	<cfset lastoarqty = 0>
   
    <cfquery name="getrc" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type ="RC" and wos_group = "#getitem.wos_group#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getrc.sumqty neq "">
        <cfset RCqty = #getrc.sumqty#>
      </cfif>

    <cfquery name="getpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and wos_group = "#getitem.wos_group#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getpr.sumqty neq "">
        <cfset PRqty = #getpr.sumqty#>
      </cfif>

    <cfquery name="getdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and wos_group = "#getitem.wos_group#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getdo.sumqty neq "">
        <cfset DOqty = #getdo.sumqty#>
      </cfif>

    <cfquery name="getinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getinv.sumqty neq "">
        <cfset INVqty = #getinv.sumqty#>
      </cfif>

    <cfquery name="getcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getcn.sumqty neq "">
        <cfset CNqty = #getcn.sumqty#>
      </cfif>

    <cfquery name="getdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getdn.sumqty neq "">
        <cfset DNqty = #getdn.sumqty#>
      </cfif>

	<cfquery name="getcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getcs.sumqty neq "">
        <cfset CSqty = #getcs.sumqty#>
      </cfif>

	<cfquery name="getiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getiss.sumqty neq "">
        <cfset ISSqty = #getiss.sumqty#>
      </cfif>

	<cfquery name="getoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getoai.sumqty neq "">
        <cfset OAIqty = #getoai.sumqty#>
      </cfif>

	<cfquery name="getoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getoar.sumqty neq "">
        <cfset OARqty = #getoar.sumqty#>
      </cfif>



	<!--- LAST ITEMBAL --->
	<cfquery name="lastgetrc" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type ="RC" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetrc.sumqty neq "">
        <cfset lastRCqty = #lastgetrc.sumqty#>
      </cfif>

    <cfquery name="lastgetpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetpr.sumqty neq "">
        <cfset lastPRqty = #lastgetpr.sumqty#>
      </cfif>

    <cfquery name="lastgetdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetdo.sumqty neq "">
        <cfset lastDOqty = #lastgetdo.sumqty#>
      </cfif>

    <cfquery name="lastgetinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetinv.sumqty neq "">
        <cfset lastINVqty = #lastgetinv.sumqty#>
      </cfif>

    <cfquery name="lastgetcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetcn.sumqty neq "">
        <cfset lastCNqty = #lastgetcn.sumqty#>
      </cfif>

    <cfquery name="lastgetdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetdn.sumqty neq "">
        <cfset lastDNqty = #lastgetdn.sumqty#>
      </cfif>

	<cfquery name="lastgetcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetcs.sumqty neq "">
        <cfset lastCSqty = #lastgetcs.sumqty#>
      </cfif>

	<cfquery name="lastgetiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetiss.sumqty neq "">
        <cfset lastISSqty = #lastgetiss.sumqty#>
      </cfif>

	<cfquery name="lastgetoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetoai.sumqty neq "">
        <cfset lastOAIqty = #lastgetoai.sumqty#>
      </cfif>

	<cfquery name="lastgetoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetoar.sumqty neq "">
        <cfset lastOARqty = #lastgetoar.sumqty#>
      </cfif>

	<cfif getitem.qtybf neq "">
		<cfset itembal = getitem.qtybf>
	</cfif>

	<cfset laststockin = #lastrcqty# + #lastcnqty# + #lastoaiqty#>
    <cfset laststockout = #lastoarqty# + #lastdoqty# + #lastinvqty# + #lastdnqty# + #lastcsqty# + #lastprqty# + #lastissqty#>
	<cfset lastbalonhand = #itembal# + #laststockin# - #laststockout#>

	<!--- END LAST ITEMBAL --->

	<cfif getitem.ucost neq "">
		<cfset fixedcost = getitem.ucost>
	</cfif>

    <cfset stockin = #rcqty# + #cnqty# + #oaiqty#>
    <cfset stockout = #oarqty# + #doqty# + #invqty# + #dnqty# + #csqty# + #prqty# + #issqty#>
    <cfset balonhand = #lastbalonhand# + #stockin# - #stockout#>


	<cfif getgeneral.cost eq 'month'>

		<cfquery datasource="#dts#" name="rcpricenow">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" <cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif> and type = 'RC'
		</cfquery>
		<cfif rcpricenow.sumamt neq "">
			<cfset rcpricenowamt = rcpricenow.sumamt>
		<cfelse>

			<cfset rcpricenowamt = 0>
		</cfif>
		<cfif rcpricenow.qty neq "">
			<cfset rcpricenowqty = rcpricenow.qty>
		<cfelse>
			<cfset rcpricenowqty = 0>
		</cfif>

		<cfquery datasource="#dts#" name="prpricenow">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" <cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif><!--- and month(wos_date) = '#monthnow#' ---> and type = 'PR'
		</cfquery>
		<cfif prpricenow.sumamt neq "">
			<cfset prpricenowamt = prpricenow.sumamt>
		<cfelse>
			<cfset prpricenowamt = 0>
		</cfif>
		<cfif prpricenow.qty neq "">
			<cfset prpricenowqty = prpricenow.qty>
		<cfelse>
			<cfset prpricenowqty = 0>
		</cfif>

		<cfset up =  (itembal * fixedcost)  + rcpricenowamt - prpricenowamt>
		<cfset down = itembal + rcpricenowqty - prpricenowqty>

		<cfif down neq 0>
			<cfset xucost = up/ down>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>
		<cfelse>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>
		</cfif>

	<cfelseif getgeneral.cost eq 'moving'>
		<cfset getinvqty = 0>
		<cfset getprqty = 0>
		<cfset getcnqty = 0>

		<cfset xucost = numberformat(fixedcost,#stDecl_UPrice#)>

		<cfquery datasource="#dts#" name="get1stRC">
			select refno,type,wos_date from ictran where wos_group = "#getitem.wos_group#" and type = 'RC'
			<!--- <cfif form.periodfrom neq "" and form.periodto neq "">and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'</cfif> --->
			order by wos_date
		</cfquery>


		<cfloop query="get1stRC" endrow="1">

			<cfquery name="getinv" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where wos_group = "#getitem.wos_group#" and type = 'INV' and wos_date < #get1stRC.wos_date#
                and (void='' or void is null)
				<!--- <cfif form.periodfrom neq "" and form.periodto neq "">and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'</cfif>  --->
				group by itemno
			</cfquery>
			<cfif getinv.sumamt neq "">
				<cfset getinvamt = getinv.sumamt>
			<cfelse>
				<cfset getinvamt = 0>
			</cfif>

			<cfif getinv.qty neq "">
				<cfset getinvqty = getinv.qty>
			<cfelse>
				<cfset getinvqty = 0>
			</cfif>

			<cfquery name="getpr" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where wos_group = "#getitem.wos_group#" and type = 'PR' and wos_date < #get1stRC.wos_date# and (void='' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
				group by itemno
			</cfquery>
			<cfif getpr.sumamt neq "">
				<cfset getpramt = getpr.sumamt>
			<cfelse>
				<cfset getpramt = 0>
			</cfif>

			<cfif getpr.qty neq "">
				<cfset getprqty = getpr.qty>
			<cfelse>
				<cfset getprqty = 0>
			</cfif>

			<cfquery name="getcn" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where wos_group = "#getitem.wos_group#" and type = 'PR' and wos_date < #get1stRC.wos_date# and (void='' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
				group by itemno
			</cfquery>
			<cfif getcn.sumamt neq "">
				<cfset getcnamt = getcn.sumamt>
			<cfelse>
				<cfset getcnamt = 0>
			</cfif>

			<cfif getcn.qty neq "">
				<cfset getcnqty = getcn.qty>
			<cfelse>
				<cfset getcnqty = 0>
			</cfif>

		</cfloop>


		<cfquery datasource="#dts#" name="getrcprice">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" and type = 'RC'
            and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
		</cfquery>
		<cfif getrcprice.sumamt neq "">
			<cfset getrcpriceamt = getrcprice.sumamt>
		<cfelse>
			<cfset getrcpriceamt = 0>
		</cfif>
		<cfif getrcprice.qty neq "">
			<cfset getrcpriceqty = getrcprice.qty>
		<cfelse>
			<cfset getrcpriceqty = 0>
		</cfif>

		<cfquery datasource="#dts#" name="getprprice">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" and type = 'PR'
            and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
		</cfquery>
		<cfif getprprice.sumamt neq "">
			<cfset getprpriceamt = getprprice.sumamt>
		<cfelse>
			<cfset getprpriceamt = 0>
		</cfif>
		<cfif getprprice.qty neq "">
			<cfset getprpriceqty = getprprice.qty>
		<cfelse>
			<cfset getprpriceqty = 0>
		</cfif>


		<!--- <cfoutput>#itembal# #getinvqty# cost #xucost#<br></cfoutput> --->
		<cfset up = ((itembal - getinvqty - getprqty + getcnqty) * xucost) + getrcpriceamt - getprpriceamt>
		<cfset down = itembal - getinvqty - getprqty + getcnqty + getrcpriceqty - getprpriceqty>

		<cfif down neq 0>
			<cfset xucost = up/ down>
		<cfelse>
			<cfset xucost = 0>
		</cfif>

		<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>

	<cfelse>

		<cfquery datasource="#dts#" name="getprice">
			select sum(ucost)as ucost from icitem where wos_group = "#getitem.wos_group#"
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
			and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
			</cfif>
		</cfquery>
		<cfif getprice.ucost neq "">
			<cfset xucost = #getprice.ucost#>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>

		</cfif>
	</cfif>

	<cfquery datasource="#dts#" name="getdesp">
		select desp from icgroup where wos_group = "#getitem.wos_group#"
	</cfquery>
	<cfset stkval = #val(balonhand)# * #val(xucost)#>
  	<cfif isdefined('form.include0')>
        <cfset grandtotalunitcost=grandtotalunitcost+val(xucost)>
      <cfset grandtotalqtybf=grandtotalqtybf+lastbalonhand>
      <cfset grandtotalin=grandtotalin+stockin>
       <cfset grandtotalout=grandtotalout+stockout>
        <cfset grandtotalqty=grandtotalqty+balonhand>
         <cfset grandtotalstkval=grandtotalstkval+stkval>
         
    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<cfwddx action = "cfml2wddx" input = "#i#" output = "wddxText5">
					<cfwddx action = "cfml2wddx" input = "#wos_group# - #getdesp.desp#" output = "wddxText6">
					<cfwddx action = "cfml2wddx" input = "#NumberFormat(val(xucost), stDecl_UPrice)#" output = "wddxText7">
					<cfwddx action = "cfml2wddx" input = "#lastbalonhand#" output = "wddxText8">
					<cfwddx action = "cfml2wddx" input = "#stockin#" output = "wddxText9">
					<cfwddx action = "cfml2wddx" input = "#stockout#" output = "wddxText10">
					<cfwddx action = "cfml2wddx" input = "#balonhand#" output = "wddxText11">
					<cfwddx action = "cfml2wddx" input = "#numberformat(stkval,"___.__")#" output = "wddxText12">
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell><cfif getpin2.h42A0 eq 'T'>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell></cfif>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
      <cfif getpin2.h42A0 eq 'T'>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell></cfif>
    </Row>
    
    <cfset i = incrementvalue(#i#)>
    <cfelse>
    <cfif stkval neq 0>
        <cfset grandtotalunitcost=grandtotalunitcost+val(xucost)>

      <cfset grandtotalqtybf=grandtotalqtybf+lastbalonhand>
      <cfset grandtotalin=grandtotalin+stockin>
       <cfset grandtotalout=grandtotalout+stockout>
        <cfset grandtotalqty=grandtotalqty+balonhand>
         <cfset grandtotalstkval=grandtotalstkval+stkval>
    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<cfwddx action = "cfml2wddx" input = "#i#" output = "wddxText13">
					<cfwddx action = "cfml2wddx" input = "#wos_group# - #getdesp.desp#" output = "wddxText14">
					<cfwddx action = "cfml2wddx" input = "#NumberFormat(val(xucost), stDecl_UPrice)#" output = "wddxText15">
					<cfwddx action = "cfml2wddx" input = "#lastbalonhand#" output = "wddxText16">
					<cfwddx action = "cfml2wddx" input = "#stockin#" output = "wddxText17">
					<cfwddx action = "cfml2wddx" input = "#stockout#" output = "wddxText18">
					<cfwddx action = "cfml2wddx" input = "#balonhand#" output = "wddxText19">
					<cfwddx action = "cfml2wddx" input = "#numberformat(stkval,"___.__")#" output = "wddxText20">
    
     <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell><cfif getpin2.h42A0 eq 'T'>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText16#</Data></Cell></cfif>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText17#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText18#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText19#</Data></Cell>
     <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText20#</Data></Cell>
      <cfif getpin2.h42A0 eq 'T'>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText22#</Data></Cell></cfif>
    </Row>
    <cfset i = incrementvalue(#i#)>
    </cfif>
    </cfif>
    </cfoutput>
    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
      <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      </Row>
  <cfoutput>
      <Row>
					<cfwddx action = "cfml2wddx" input = "#grandtotalunitcost#" output = "wddxText23">
					<cfwddx action = "cfml2wddx" input = "#grandtotalqtybf#" output = "wddxText24">
					<cfwddx action = "cfml2wddx" input = "#grandtotalin#" output = "wddxText25">
					<cfwddx action = "cfml2wddx" input = "#grandtotalout#" output = "wddxText26">
					<cfwddx action = "cfml2wddx" input = "#grandtotalqty#" output = "wddxText27">
					<cfwddx action = "cfml2wddx" input = "#numberformat(grandtotalstkval,".__")#" output = "wddxText28">
      <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
	  <Cell ss:StyleID="s26"><Data ss:Type="String"> TOTAL :</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText23#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText24#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText25#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText26#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText27#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText28#</Data></Cell>
     
      </Row>  
</cfoutput>

</Table>

<cfelseif getgeneral.cost eq "lifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,wos_group,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by wos_group order by wos_group
	</cfquery>
    
<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="200.25"/>
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
				<cfwddx action = "cfml2wddx" input = "Group Status and Value Summary" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>

				<cfwddx action = "cfml2wddx" input = "Calculated by #costingmethod#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>      
                    
				<cfif form.periodfrom neq "" and form.periodto neq "">
                <cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
			
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
                <cfwddx action = "cfml2wddx" input = "CATEGORY: #form.categoryFrom# - #form.categoryTo#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
                <cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
                    	</cfif>
			
			                     
			
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText29">
					<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText30">
                    <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#wddxText29#</cfif></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText30#</Data></Cell>
					</Row>
			</cfoutput>
        
	  	<Row>
	  		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM DESCRIPTION</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">B/F</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">QTY</Data></Cell>
            <cfif getpin2.h42A0 eq 'T'>
			<Cell ss:StyleID="s50"><Data ss:Type="String">STK VAL</Data></Cell>
            </cfif>
	  	</Row>
	  
	<cfloop query="getitem">
		<cfquery name="check" datasource="#dts#">
			select a.itemno,b.itemno from fifoopq a, icitem b
			where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
		</cfquery>

		<cfif getitem.qtybf neq "">
			<cfset bfqty = #getitem.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitem.wos_group#' and (type = 'RC' or type = 'CN' or type = 'OAI' or type='TRIN')
            and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
		</cfquery>

		<cfif getin.qty neq "">
			<cfset inqty = #getin.qty#>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitem.wos_group#' and type = 'DO' and toinv = '' and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
		</cfquery>

		<cfif getdo.qty neq "">
			<cfset doqty = #getdo.qty#>
		<cfelse>
			<cfset doqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitem.wos_group#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU' or type = 'CT')
            and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
		</cfquery>
		<cfif getout.qty neq "">
			<cfset outqty = #getout.qty#>
		<cfelse>
			<cfset outqty = 0>
		</cfif>

		<cfset ttoutqty = outqty + doqty>

		<cfset balqty =  bfqty + inqty - ttoutqty>

		<cfset fifoqty = 0>
		<cfset ttnewffstkval =0>

		<cfquery name="getrc" datasource="#dts#">
			select qty, amt, amt_bil, price, price_bil from ictran where wos_group = '#getitem.wos_group#' and type = 'RC'
            and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			order by trdatetime desc
		</cfquery>

		<cfif getrc.recordcount gt 0 and check.recordcount gt 0>
			<cfset totalrcqty = 0>
			<cfset cnt = 0>
			<cfloop query="getrc">
				<cfset cnt = cnt + 1>
				<cfif getrc.qty neq "">
					<cfset rcqty = getrc.qty>
				<cfelse>
					<cfset rcqty = 0>
				</cfif>
				<cfset totalrcqty = totalrcqty + rcqty>
				<cfif totalrcqty gte ttoutqty>
					<cfset minusqty = totalrcqty - ttoutqty>
					<cfif minusqty gt 0>
						<cfset stkval = minusqty * getrc.price>
					<cfelse>
						<cfset stkval = 0>
					</cfif>
					<cfbreak>
				</cfif>
			</cfloop>
			<cfif totalrcqty gte ttoutqty>
				<cfset cnt = cnt + 1> <!--- next record --->
				<cfset newstkval = 0>
				<cfoutput query="getrc" startrow="#cnt#">
					<cfset newstkval = newstkval + getrc.amt>
				</cfoutput>
				<cfloop index="i" from="11" to="50">
					<cfset ffq = "sum(a.ffq"&"#i#)">
					<cfset ffc = "sum(a.ffc"&"#i#)">
					<cfquery name="getfifoopq" datasource="#dts#">
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
					</cfquery>

					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>
				</cfloop>

				<cfset totalstkval = stkval + newstkval + ttnewffstkval>

			<cfelse> <!--- rc less than out --->
				<cfset ttnewffstkval = 0>
				<cfset fifoqty = totalrcqty>
				<cfloop index="i" from="11" to="50">
					<cfset ffq = "sum(a.ffq"&"#i#)">
					<cfset ffc = "sum(a.ffc"&"#i#)">
					<cfquery name="getfifoopq" datasource="#dts#">
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
					</cfquery>

					<cfset fifoqty = fifoqty + getfifoopq.xffq>
					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>

					<cfif fifoqty gte ttoutqty>
						<cfset minusfifoqty = fifoqty - ttoutqty>
						<cfif minusfifoqty gt 0>
							<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
						<cfelse>
							<cfset stkvalff = 0>
						</cfif>
						<cfset fifocnt = #i# + 1>
						<cfbreak>
					</cfif>
				</cfloop>

				<cfif fifoqty gte ttoutqty>
					<cfset ttnewffstkval = 0>
					<cfloop index="i" from="#fifocnt#" to="50">
						<cfset ffq = "sum(a.ffq"&"#i#)">
						<cfset ffc = "sum(a.ffc"&"#i#)">
						<cfquery name="getfifoopq2" datasource="#dts#">
							select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
						</cfquery>

						<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
						<cfset ttnewffstkval = ttnewffstkval + newffstkval>
					</cfloop>
				</cfif>
				<cfset totalstkval = stkvalff + ttnewffstkval>
			</cfif>

		<cfelseif getrc.recordcount eq 0 and check.recordcount gt 0>

			<cfset ttnewffstkval = 0>

			<cfloop index="i" from="11" to="50">
				<cfset ffq = "sum(a.ffq"&"#i#)">
				<cfset ffc = "sum(a.ffc"&"#i#)">
				<cfquery name="getfifoopq2" datasource="#dts#">
					select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group= '#getitem.wos_group#'
				</cfquery>

				<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
				<cfset ttnewffstkval = ttnewffstkval + newffstkval>
			</cfloop>
			<cfset totalstkval = ttnewffstkval>

		<cfelse>

			<cfset totalrcqty = 0>
			<cfset cnt = 0>
			<cfset stkval = 0>
			<cfset newstkval = 0>
			<cfif getrc.recordcount gt 0>
				<cfloop query="getrc">
					<cfset cnt = cnt + 1>
					<cfif getrc.qty neq "">
						<cfset rcqty = getrc.qty>
					<cfelse>
						<cfset rcqty = 0>
					</cfif>

					<cfset totalrcqty = totalrcqty + rcqty>
					<cfif totalrcqty gte ttoutqty>
						<cfset minusqty = totalrcqty - ttoutqty>
						<cfif minusqty gt 0>
							<cfset stkval = minusqty * getrc.price>
						<cfelse>
							<cfset stkval = 0>
						</cfif>
						<cfbreak>
					</cfif>
				</cfloop>
				<cfif getrc.recordcount gt cnt>
					<cfset cnt = cnt + 1> <!--- next record --->
					<cfset newstkval = 0>
					<cfoutput query="getrc" startrow="#cnt#">

						<cfset newstkval = newstkval + getrc.amt>
					</cfoutput>
				<cfelse>
					<cfset newstkval = 0>
				</cfif>
			</cfif>
			<cfset totalstkval = stkval + newstkval>
          
            
            
            
		</cfif>
  
	  <cfoutput>
      <cfif isdefined('form.include0')>
       <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+inqty>
       <cfset grandtotalout=grandtotalout+ttoutqty>
        <cfset grandtotalqty=grandtotalqty+balqty>
         <cfset grandtotalstkval=grandtotalstkval+totalstkval>
   		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText31">
					<cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText32">
					<cfwddx action = "cfml2wddx" input = "#qtybf#" output = "wddxText33">
					<cfwddx action = "cfml2wddx" input = "#inqty#" output = "wddxText34">
					<cfwddx action = "cfml2wddx" input = "#outqty#" output = "wddxText35">
					<cfwddx action = "cfml2wddx" input = "#balqty#" output = "wddxText36">
					<cfwddx action = "cfml2wddx" input = "#numberformat(totalstkval,",___.__")#" output = "wddxText37">
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText31#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText32#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText33#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText34#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText35#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText36#</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText37#</Data></Cell></cfif>
	  </Row>
     
      <cfelse>
      <cfif totalstkval neq 0>
         <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+inqty>
       <cfset grandtotalout=grandtotalout+ttoutqty>
        <cfset grandtotalqty=grandtotalqty+balqty>
         <cfset grandtotalstkval=grandtotalstkval+totalstkval>
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    
    				<cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText38">
					<cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText39">
					<cfwddx action = "cfml2wddx" input = "#qtybf#" output = "wddxText40">
					<cfwddx action = "cfml2wddx" input = "#inqty#" output = "wddxText41">
					<cfwddx action = "cfml2wddx" input = "#outqty#" output = "wddxText42">
					<cfwddx action = "cfml2wddx" input = "#balqty#" output = "wddxText43">
					<cfwddx action = "cfml2wddx" input = "#numberformat(totalstkval,",___.__")#" output = "wddxText44">

		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText38#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText39#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText40#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText41#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText42#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText43#</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText44#</Data></Cell></cfif>
	  </Row>
      </cfif>
           </cfif>
	  </cfoutput>
	 </cfloop>
<cfoutput>
     
       <Row>
      <Cell></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">TOTAL :</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#grandtotalqtybf#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#grandtotalin#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#grandtotalout#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#grandtotalqty#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(grandtotalstkval,".__")#</Data></Cell>
     
      </Row>
      </cfoutput>
	</Table>

<cfelseif getgeneral.cost eq "fifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,wos_group,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by wos_group order by wos_group
	</cfquery>

	
<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="200.25"/>
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
				<cfwddx action = "cfml2wddx" input = "Group Status and Value Summary" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>

				<cfwddx action = "cfml2wddx" input = "Calculated by #costingmethod#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>      
                    
				<cfif form.periodfrom neq "" and form.periodto neq "">
                <cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
			
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
                <cfwddx action = "cfml2wddx" input = "CATEGORY: #form.categoryFrom# - #form.categoryTo#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
                <cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
                    	</cfif>
			
			       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText3">
					<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText4">
                    
      				<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#wddxText3#</cfif></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
                    </Row>
    				</cfoutput>
               
	
	  	<Row>
			<Cell ss:StyleID="s50"><Data ss:Type="String">GROUP</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">GROUP DESCRIPTION</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">B/F</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
		    <Cell ss:StyleID="s50"><Data ss:Type="String">QTY</Data></Cell>
            <cfif getpin2.h42A0 eq 'T'>
			<Cell ss:StyleID="s50"><Data ss:Type="String">STK VAL</Data></Cell>
            </cfif>
	   </Row>
	  
	<cfloop query="getitem">
    <cfset grandout=0>
    <cfset grandin=0>
    <cfset granbal=0>
    <cfset grandstkval=0>
  
    
    <cfquery name="getitemdetail" datasource="#dts#">
		select itemno,desp,wos_group,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
		</cfif>
		and wos_group ='#getitem.wos_group#'
		group by itemno order by itemno
	</cfquery>
    
    <cfloop query="getitemdetail">
		<cfquery name="check" datasource="#dts#">
			select a.itemno,b.itemno from fifoopq a, icitem b
			where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
		</cfquery>



		<cfif getitemdetail.qtybf neq "">
			<cfset bfqty = #getitemdetail.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitemdetail.wos_group#'
			and (type = 'RC' or type = 'CN' or type = 'OAI' or type='TRIN') and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            and itemno='#getitemdetail.itemno#'
		</cfquery>

		<cfif getin.qty neq "">
			<cfset inqty = #getin.qty#>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitemdetail.wos_group#' and type = 'DO' and (toinv = '' or toinv is null)  and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            and itemno='#getitemdetail.itemno#'
		</cfquery>

		<cfif getdo.qty neq "">
			<cfset doqty = #getdo.qty#>
		<cfelse>
			<cfset doqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitemdetail.wos_group#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU') and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            and itemno='#getitemdetail.itemno#'
		</cfquery>
		<cfif getout.qty neq "">
			<cfset outqty = #getout.qty#>
		<cfelse>
			<cfset outqty = 0>
		</cfif>

		<cfset ttoutqty = outqty + doqty>

		<cfset balqty =  bfqty + inqty - ttoutqty>

		<cfset fifoqty = 0>
		<cfset ttnewffstkval =0>

		<cfif bfqty neq 0 and check.recordcount gt 0>

			<cfloop index="i" from="50" to="11" step="-1">
				<cfset ffq = "sum(a.ffq"&"#i#)">
				<cfset ffc = "sum(a.ffc"&"#i#)">
				<cfquery name="getfifoopq" datasource="#dts#">
					select #ffq# as xffq, #ffc# as xffc from fifoopq a,icitem b where a.itemno=b.itemno and
					b.wos_group = '#getitemdetail.wos_group#'
                    
                    and a.itemno='#getitemdetail.itemno#'
				</cfquery>
				<cfif getfifoopq.recordcount gt 0>
                <cfset getfifoopq.xffq = val(getfifoopq.xffq)>
                <cfset getfifoopq.xffc = val(getfifoopq.xffc)>
					<cfset fifoqty = val(fifoqty) + val(getfifoopq.xffq)>
					<cfset newffstkval = val(getfifoopq.xffq) * val(getfifoopq.xffc)>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>

					<cfif fifoqty gte ttoutqty>
						<cfset minusfifoqty = fifoqty - ttoutqty>
						<cfif minusfifoqty gt 0>
							<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
						<cfelse>
							<cfset stkvalff = 0>
						</cfif>
						<cfset fifocnt = #i# - 1>
						<cfbreak>
					</cfif>
				</cfif>
			</cfloop>
			<cfif fifoqty gte ttoutqty>
				<cfset ttnewffstkval = 0>

				<cfloop index="i" from="#fifocnt#" to="11" step="-1">
					<cfset ffq = "sum(a.ffq"&"#i#)">
					<cfset ffc = "sum(a.ffc"&"#i#)">
					<cfquery name="getfifoopq2" datasource="#dts#">
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b
						where a.itemno = b.itemno and b.wos_group = '#getitemdetail.wos_group#'
                        and a.itemno='#getitemdetail.itemno#'
					</cfquery>
					<cfset getfifoopq2.xffq = val(getfifoopq2.xffq)>
                    <cfset getfifoopq2.xffc = val(getfifoopq2.xffc)>
					<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>
				</cfloop>
				<cfquery name="getallrc" datasource="#dts#">
					select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(price) as price1,sum(price_bil)as price_bil1 
								from ictran 
								where itemno='#getitemdetail.itemno#' and type in ('RC','OAI') and (void = '' or void is null)							
                                
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitemdetail.itemno#' and type='CN' and (void = '' or void is null) 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitemdetail.itemno#';
				</cfquery>
				<cfquery name="getrc" datasource="#dts#">
					select qty,
						if(type='CN',it_cos,<cfif isdefined('form.misccost')>amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7<cfelse>amt</cfif>)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						<cfif isdefined('form.misccost')>((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)<cfelse>price</cfif>) as price,
						if(type='CN',((it_cos/currrate)/qty),price_bil) as price_bil 
						from ictran 
						where itemno='#getitemdetail.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					order by trdatetime
				</cfquery>

				<cfif getallrc.sumamt eq "">
					<cfset sumamt = 0>
				<cfelse>
					<cfset sumamt = getallrc.sumamt>
				</cfif>

				<cfset totalstkval = stkvalff + ttnewffstkval + sumamt>
			<cfelse>
				<cfset totalrcqty = #fifoqty#>
				<cfset stkval = 0>
				<cfquery name="getrc" datasource="#dts#">
					select qty,
						if(type='CN',it_cos,<cfif isdefined('form.misccost')>amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7<cfelse>amt</cfif>)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						<cfif isdefined('form.misccost')>((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)<cfelse>price</cfif>) as price,
						if(type='CN',((it_cos/currrate)/qty),price_bil) as price_bil 
						from ictran 
						where itemno='#getitemdetail.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					order by trdatetime
				</cfquery>
				<cfset cnt = 0>
				<cfloop query="getrc">
					<cfset cnt = cnt + 1>
					<cfif getrc.qty neq "">
						<cfset rcqty = getrc.qty>
					<cfelse>
						<cfset rcqty = 0>
					</cfif>

					<cfset totalrcqty = totalrcqty + rcqty>
					<cfif totalrcqty gte ttoutqty>
						<cfset minusqty = totalrcqty - ttoutqty>
						<cfif minusqty gt 0>
							<cfset stkval = minusqty * getrc.price>
						<cfelse>
							<cfset stkval = 0>
						</cfif>
						<cfbreak>
					</cfif>
				</cfloop>
				<cfif getrc.recordcount gt cnt>
					<cfset cnt = cnt + 1> <!--- next record --->
					<cfset newstkval = 0>
					<cfoutput query="getrc" startrow="#cnt#">

						<cfset newstkval = newstkval + getrc.amt>
					</cfoutput>
				<cfelse>
					<cfset newstkval = 0>
				</cfif>
				<cfset totalstkval = stkval + newstkval>
			</cfif>
		<cfelse>
			<cfset totalrcqty = 0>
			<cfset stkval = 0>
			<cfquery name="getrc" datasource="#dts#">
				select qty,
						if(type='CN',it_cos,<cfif isdefined('form.misccost')>amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7<cfelse>amt</cfif>)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						<cfif isdefined('form.misccost')>((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)<cfelse>price</cfif>) as price,
						if(type='CN',((it_cos/currrate)/qty),price_bil) as price_bil 
						from ictran 
						where itemno='#getitemdetail.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				order by trdatetime
			</cfquery>
			<cfset cnt = 0>
			<cfloop query="getrc">
				<cfset cnt = cnt + 1>
				<cfif getrc.qty neq "">
					<cfset rcqty = getrc.qty>
				<cfelse>
					<cfset rcqty = 0>
				</cfif>

				<cfset totalrcqty = totalrcqty + rcqty>
				<cfif totalrcqty gte ttoutqty>
					<cfset minusqty = totalrcqty - ttoutqty>
					<cfif minusqty gt 0>
						<cfset stkval = minusqty * getrc.price>
					<cfelse>
						<cfset stkval = 0>
					</cfif>
					<cfbreak>
				</cfif>
			</cfloop>
			<cfif getrc.recordcount gt cnt>
				<cfset cnt = cnt + 1> <!--- next record --->
				<cfset newstkval = 0>
				<cfoutput query="getrc" startrow="#cnt#">

					<cfset newstkval = newstkval + getrc.amt>
				</cfoutput>
			<cfelse>
				<cfset newstkval = 0>
			</cfif>
			<cfset totalstkval = stkval + newstkval>
		</cfif>
        
        <cfset grandout=grandout+ttoutqty>
        <cfset grandin=grandin+inqty>
    <cfset granbal=granbal+balqty>
    <cfset grandstkval=grandstkval+totalstkval>
   <cfset grandtotalstkval=grandtotalstkval+totalstkval>
    
	  </cfloop>
      
	  <cfoutput>
	  	<cfquery name="getdesp" datasource="#dts#">
			select desp from icgroup where wos_group = '#getitem.wos_group#'
		</cfquery>
     <cfif isdefined('form.include0')>
                     <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+grandin>
       <cfset grandtotalout=grandtotalout+grandout>
        <cfset grandtotalqty=grandtotalqty+granbal>
         <!---<cfset grandtotalstkval=grandtotalstkval+totalstkval>--->
     <Row ss:AutoFitHeight="0" ss:Height="23.0625">
     
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wos_group#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#getdesp.desp#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#qtybf#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#grandin#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#grandout#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#granbal#</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(grandstkval,",_.__")#</Data></Cell>
        </cfif>
	  </Row>
     
        <cfelse>
      
        <cfif grandstkval neq 0>
            <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+grandin>
       <cfset grandtotalout=grandtotalout+grandout>
        <cfset grandtotalqty=grandtotalqty+granbal>
        <!--- <cfset grandtotalstkval=grandtotalstkval+totalstkval>--->
	 <Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wos_group#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#getdesp.desp#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#qtybf#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#grandin#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#grandout#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#granbal#</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
	<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(grandstkval,",_.__")#</Data></Cell>
        </cfif>
	  </Row>
      </cfif>
      </cfif>
     
	  </cfoutput>
	 </cfloop>
     <cfoutput>
      <Row>
      <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
      <Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL :</Data></Cell>
      <Cell ss:StyleID="s51"><Data ss:Type="String">#grandtotalqtybf#</Data></Cell>
      <Cell ss:StyleID="s51"><Data ss:Type="String">#grandtotalin#</Data></Cell>
      <Cell ss:StyleID="s51"><Data ss:Type="String">#grandtotalout#</Data></Cell>
      <Cell ss:StyleID="s51"><Data ss:Type="String">#grandtotalqty#</Data></Cell>
      <Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(grandtotalstkval,".__")#</Data></Cell>
     
      </Row>
      
      </cfoutput>
	</Table>
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
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
	
<cfcase value="HTML">

<html>
<head>
<title>Stock Card2</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfparam name="i" default="1" type="numeric">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">
<cfparam name="OAIqty" default="0">
<cfparam name="OARqty" default="0">
<cfparam name="xucost" default="0.0000000">
<cfparam name="balonhand" default="0">
<cfparam name="lastbalonhand" default="0">
  <cfset grandtotalqtybf = 0>
    <cfset grandtotalin = 0>
    <cfset grandtotalout = 0>
    <cfset grandtotalqty = 0>
    <cfset grandtotalstkval = 0>
    <cfset grandtotalunitcost = 0>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = #getgsetup2.Decl_UPrice#>
<cfset stDecl_UPrice = "___.">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = #stDecl_UPrice# & "_">
</cfloop>

<cfif getgeneral.cost eq "FIXED">
	<cfset costingmethod = "Fixed Cost Method">
<cfelseif getgeneral.cost eq "MONTH">
	<cfset costingmethod = "Month Average Method">
<cfelseif getgeneral.cost eq "MOVING">
	<cfset costingmethod = "Moving Average Method">
<cfelseif getgeneral.cost eq "FIFO">
	<cfset costingmethod = "First In First Out Method">
<cfelse>
	<cfset costingmethod = "Last In First Out Method">
</cfif>


<body>
<h1 align="center">Group Status and Value Summary</h1>
<h2 align="center">Calculated by <cfoutput>#costingmethod#</cfoutput></h2>

<cfif getgeneral.cost neq "fifo" and getgeneral.cost neq "lifo">

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp,wos_group,category,qtybf,ucost from icitem where itemno <> '' and wos_group <>''

	<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
	and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
	</cfif>
	group by wos_group order by wos_group
</cfquery>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<tr><cfoutput>
      	<td colspan="4"><font size="2" face="Times New Roman, Times, serif">
        <cfif getgeneral.compro neq "">
          #getgeneral.compro#
        </cfif>
        </font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr></cfoutput>
    <tr>
      	<td colspan="10"><hr></td>
    </tr>
  	<tr>
  		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">No</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Group</font></div></td>
        <cfif getpin2.h42A0 eq 'T'>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Unit Cost</font></div></td>
        </cfif>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Qty Bf</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">In</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Out</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Balance</font></div></td>
        <cfif getpin2.h42A0 eq 'T'>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Stock Value ($)</font></div></td></cfif>
	</tr>
 	 <tr>
      	<td colspan="10"><hr></td>
    </tr>
  <cfoutput query="getitem">
    <cfset itembal = 0>
	<cfset fixedcost = 0>
    <cfset rcqty = 0>
    <cfset invqty = 0>
    <cfset cnqty = 0>
    <cfset prqty = 0>
    <cfset dnqty = 0>
    <cfset doqty = 0>
	<cfset csqty = 0>
	<cfset issqty = 0>
	<cfset oaiqty = 0>
	<cfset oarqty = 0>
	<cfset xucost = 0.0000000>
	<cfset lastitembal = 0>
	<cfset lastrcqty = 0>
    <cfset lastinvqty = 0>
    <cfset lastcnqty = 0>
    <cfset lastprqty = 0>
    <cfset lastdnqty = 0>
    <cfset lastdoqty = 0>
	<cfset lastcsqty = 0>
	<cfset lastissqty = 0>
	<cfset lastoaiqty = 0>
	<cfset lastoarqty = 0>
   
    <cfquery name="getrc" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type ="RC" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getrc.sumqty neq "">
        <cfset RCqty = #getrc.sumqty#>
      </cfif>

    <cfquery name="getpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getpr.sumqty neq "">
        <cfset PRqty = #getpr.sumqty#>
      </cfif>

    <cfquery name="getdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getdo.sumqty neq "">
        <cfset DOqty = #getdo.sumqty#>
      </cfif>

    <cfquery name="getinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getinv.sumqty neq "">
        <cfset INVqty = #getinv.sumqty#>
      </cfif>

    <cfquery name="getcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getcn.sumqty neq "">
        <cfset CNqty = #getcn.sumqty#>
      </cfif>

    <cfquery name="getdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getdn.sumqty neq "">
        <cfset DNqty = #getdn.sumqty#>
      </cfif>

	<cfquery name="getcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getcs.sumqty neq "">
        <cfset CSqty = #getcs.sumqty#>
      </cfif>

	<cfquery name="getiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getiss.sumqty neq "">
        <cfset ISSqty = #getiss.sumqty#>
      </cfif>

	<cfquery name="getoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getoai.sumqty neq "">
        <cfset OAIqty = #getoai.sumqty#>
      </cfif>

	<cfquery name="getoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif getoar.sumqty neq "">
        <cfset OARqty = #getoar.sumqty#>
      </cfif>



	<!--- LAST ITEMBAL --->
	<cfquery name="lastgetrc" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type ="RC" and wos_group = "#getitem.wos_group#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"

		</cfif>
    </cfquery>

      <cfif lastgetrc.sumqty neq "">
        <cfset lastRCqty = #lastgetrc.sumqty#>
      </cfif>

    <cfquery name="lastgetpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetpr.sumqty neq "">
        <cfset lastPRqty = #lastgetpr.sumqty#>
      </cfif>

    <cfquery name="lastgetdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetdo.sumqty neq "">
        <cfset lastDOqty = #lastgetdo.sumqty#>
      </cfif>

    <cfquery name="lastgetinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and wos_group = "#getitem.wos_group#"
        and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetinv.sumqty neq "">
        <cfset lastINVqty = #lastgetinv.sumqty#>
      </cfif>

    <cfquery name="lastgetcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetcn.sumqty neq "">
        <cfset lastCNqty = #lastgetcn.sumqty#>
      </cfif>

    <cfquery name="lastgetdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetdn.sumqty neq "">
        <cfset lastDNqty = #lastgetdn.sumqty#>
      </cfif>

	<cfquery name="lastgetcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetcs.sumqty neq "">
        <cfset lastCSqty = #lastgetcs.sumqty#>
      </cfif>

	<cfquery name="lastgetiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetiss.sumqty neq "">
        <cfset lastISSqty = #lastgetiss.sumqty#>
      </cfif>

	<cfquery name="lastgetoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetoai.sumqty neq "">
        <cfset lastOAIqty = #lastgetoai.sumqty#>
      </cfif>

	<cfquery name="lastgetoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and wos_group = "#getitem.wos_group#" and (void='' or void is null)
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
		</cfif>
    </cfquery>

      <cfif lastgetoar.sumqty neq "">
        <cfset lastOARqty = #lastgetoar.sumqty#>
      </cfif>

	<cfif getitem.qtybf neq "">
		<cfset itembal = getitem.qtybf>
	</cfif>

	<cfset laststockin = #lastrcqty# + #lastcnqty# + #lastoaiqty#>
    <cfset laststockout = #lastoarqty# + #lastdoqty# + #lastinvqty# + #lastdnqty# + #lastcsqty# + #lastprqty# + #lastissqty#>
	<cfset lastbalonhand = #itembal# + #laststockin# - #laststockout#>

	<!--- END LAST ITEMBAL --->

	<cfif getitem.ucost neq "">
		<cfset fixedcost = getitem.ucost>
	</cfif>

    <cfset stockin = #rcqty# + #cnqty# + #oaiqty#>
    <cfset stockout = #oarqty# + #doqty# + #invqty# + #dnqty# + #csqty# + #prqty# + #issqty#>
    <cfset balonhand = #lastbalonhand# + #stockin# - #stockout#>


	<cfif getgeneral.cost eq 'month'>

		<cfquery datasource="#dts#" name="rcpricenow">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" <cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif> and type = 'RC'
		</cfquery>
		<cfif rcpricenow.sumamt neq "">
			<cfset rcpricenowamt = rcpricenow.sumamt>
		<cfelse>
			<cfset rcpricenowamt = 0>
		</cfif>
		<cfif rcpricenow.qty neq "">
			<cfset rcpricenowqty = rcpricenow.qty>
		<cfelse>
			<cfset rcpricenowqty = 0>
		</cfif>

		<cfquery datasource="#dts#" name="prpricenow">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" 
			and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif><!--- and month(wos_date) = '#monthnow#' ---> and type = 'PR'
		</cfquery>
		<cfif prpricenow.sumamt neq "">
			<cfset prpricenowamt = prpricenow.sumamt>
		<cfelse>
			<cfset prpricenowamt = 0>
		</cfif>
		<cfif prpricenow.qty neq "">
			<cfset prpricenowqty = prpricenow.qty>
		<cfelse>
			<cfset prpricenowqty = 0>
		</cfif>

		<cfset up =  (itembal * fixedcost)  + rcpricenowamt - prpricenowamt>
		<cfset down = itembal + rcpricenowqty - prpricenowqty>

		<cfif down neq 0>
			<cfset xucost = up/ down>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>
		<cfelse>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>
		</cfif>

	<cfelseif getgeneral.cost eq 'moving'>
		<cfset getinvqty = 0>
		<cfset getprqty = 0>
		<cfset getcnqty = 0>

		<cfset xucost = numberformat(fixedcost,#stDecl_UPrice#)>

		<cfquery datasource="#dts#" name="get1stRC">
			select refno,type,wos_date from ictran where wos_group = "#getitem.wos_group#" and type = 'RC'
			<!--- <cfif form.periodfrom neq "" and form.periodto neq "">and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'</cfif> --->
			order by wos_date
		</cfquery>


		<cfloop query="get1stRC" endrow="1">

			<cfquery name="getinv" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where wos_group = "#getitem.wos_group#" and type = 'INV' and wos_date < #get1stRC.wos_date# and (void='' or void is null)
				<!--- <cfif form.periodfrom neq "" and form.periodto neq "">and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'</cfif>  --->
				group by itemno
			</cfquery>
			<cfif getinv.sumamt neq "">
				<cfset getinvamt = getinv.sumamt>
			<cfelse>
				<cfset getinvamt = 0>
			</cfif>

			<cfif getinv.qty neq "">
				<cfset getinvqty = getinv.qty>
			<cfelse>
				<cfset getinvqty = 0>
			</cfif>

			<cfquery name="getpr" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where wos_group = "#getitem.wos_group#" and type = 'PR' and wos_date < #get1stRC.wos_date# and (void='' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
				group by itemno
			</cfquery>
			<cfif getpr.sumamt neq "">
				<cfset getpramt = getpr.sumamt>
			<cfelse>
				<cfset getpramt = 0>
			</cfif>

			<cfif getpr.qty neq "">
				<cfset getprqty = getpr.qty>
			<cfelse>
				<cfset getprqty = 0>
			</cfif>

			<cfquery name="getcn" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where wos_group = "#getitem.wos_group#" and type = 'PR' and wos_date < #get1stRC.wos_date# and (void='' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
				group by itemno
			</cfquery>
			<cfif getcn.sumamt neq "">
				<cfset getcnamt = getcn.sumamt>
			<cfelse>
				<cfset getcnamt = 0>
			</cfif>

			<cfif getcn.qty neq "">
				<cfset getcnqty = getcn.qty>
			<cfelse>
				<cfset getcnqty = 0>
			</cfif>

		</cfloop>


		<cfquery datasource="#dts#" name="getrcprice">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" and type = 'RC' and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
		</cfquery>
		<cfif getrcprice.sumamt neq "">
			<cfset getrcpriceamt = getrcprice.sumamt>
		<cfelse>
			<cfset getrcpriceamt = 0>
		</cfif>
		<cfif getrcprice.qty neq "">
			<cfset getrcpriceqty = getrcprice.qty>
		<cfelse>
			<cfset getrcpriceqty = 0>
		</cfif>

		<cfquery datasource="#dts#" name="getprprice">
			select sum(amt)as sumamt,sum(qty) as qty from ictran where wos_group = "#getitem.wos_group#" and type = 'PR' and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
		</cfquery>
		<cfif getprprice.sumamt neq "">
			<cfset getprpriceamt = getprprice.sumamt>
		<cfelse>
			<cfset getprpriceamt = 0>
		</cfif>
		<cfif getprprice.qty neq "">
			<cfset getprpriceqty = getprprice.qty>
		<cfelse>
			<cfset getprpriceqty = 0>
		</cfif>


		<!--- <cfoutput>#itembal# #getinvqty# cost #xucost#<br></cfoutput> --->
		<cfset up = ((itembal - getinvqty - getprqty + getcnqty) * xucost) + getrcpriceamt - getprpriceamt>
		<cfset down = itembal - getinvqty - getprqty + getcnqty + getrcpriceqty - getprpriceqty>

		<cfif down neq 0>
			<cfset xucost = up/ down>
		<cfelse>
			<cfset xucost = 0>
		</cfif>

		<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>

	<cfelse>

		<cfquery datasource="#dts#" name="getprice">
			select sum(ucost)as ucost from icitem where wos_group = "#getitem.wos_group#"
			<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
			and category >= "#form.categoryFrom#" and category <= "#form.categoryTo#"
			</cfif>
		</cfquery>
		<cfif getprice.ucost neq "">
			<cfset xucost = #getprice.ucost#>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>

		</cfif>
	</cfif>

	<cfquery datasource="#dts#" name="getdesp">
		select desp from icgroup where wos_group = "#getitem.wos_group#"
	</cfquery>
	<cfset stkval = #val(balonhand)# * #val(xucost)#>
  	<cfif isdefined('form.include0')>
        <cfset grandtotalunitcost=grandtotalunitcost+val(xucost)>
      <cfset grandtotalqtybf=grandtotalqtybf+lastbalonhand>
      <cfset grandtotalin=grandtotalin+stockin>
       <cfset grandtotalout=grandtotalout+stockout>
        <cfset grandtotalqty=grandtotalqty+balonhand>
         <cfset grandtotalstkval=grandtotalstkval+stkval>
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#i#</font></div></td>
      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#wos_group# - #getdesp.desp#</font></div></td><cfif getpin2.h42A0 eq 'T'>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(val(xucost), stDecl_UPrice)#</font></div></td></cfif>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#lastbalonhand#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#stockin#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#stockout#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
      <cfif getpin2.h42A0 eq 'T'>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(stkval,"___.__")#</font></div></td></cfif>
    </tr>
    <cfset i = incrementvalue(#i#)>
    <cfelse>
    <cfif stkval neq 0>
        <cfset grandtotalunitcost=grandtotalunitcost+val(xucost)>

      <cfset grandtotalqtybf=grandtotalqtybf+lastbalonhand>
      <cfset grandtotalin=grandtotalin+stockin>
       <cfset grandtotalout=grandtotalout+stockout>
        <cfset grandtotalqty=grandtotalqty+balonhand>
         <cfset grandtotalstkval=grandtotalstkval+stkval>
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#i#</font></div></td>
      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#wos_group# - #getdesp.desp#</font></div></td><cfif getpin2.h42A0 eq 'T'>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(val(xucost), stDecl_UPrice)#</font></div></td></cfif>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#lastbalonhand#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#stockin#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#stockout#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
      <cfif getpin2.h42A0 eq 'T'>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(stkval,"___.__")#</font></div></td></cfif>
    </tr>
    <cfset i = incrementvalue(#i#)>
    </cfif>
    </cfif>
  </cfoutput>
  <cfoutput>
     <tr>
     <td colspan="10"><hr></td>
     </tr>
       <tr>
      <td></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b> TOTAL :</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalunitcost#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalqtybf#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalin#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalout#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalqty#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#numberformat(grandtotalstkval,",_.__")#</b></font></div></td>
     
      </tr>
      <tr>     <td colspan="10"><hr></td>
</tr>
</cfoutput>
</table>
<cfelseif getgeneral.cost eq "lifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,wos_group,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by wos_group order by wos_group
	</cfquery>

	<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0">
		<tr>
			<td colspan="4"><font size="2" face="Times New Roman, Times, serif">
			<cfif getgeneral.compro neq "">
			  #getgeneral.compro#
			</cfif>
			</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="10"><hr></td>
		</tr>
	  	<tr>
	  		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
            <cfif getpin2.h42A0 eq 'T'>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td>
            </cfif>
	  	</tr>
	  	<tr>
			<td colspan="10"><hr></td>
		</tr>
	<cfloop query="getitem">
		<cfquery name="check" datasource="#dts#">
			select a.itemno,b.itemno from fifoopq a, icitem b
			where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
		</cfquery>

		<cfif getitem.qtybf neq "">
			<cfset bfqty = #getitem.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitem.wos_group#' and (type = 'RC' or type = 'CN' or type = 'OAI' or type='TRIN') and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
		</cfquery>

		<cfif getin.qty neq "">
			<cfset inqty = #getin.qty#>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitem.wos_group#' and type = 'DO' and toinv = '' and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
		</cfquery>

		<cfif getdo.qty neq "">
			<cfset doqty = #getdo.qty#>
		<cfelse>
			<cfset doqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitem.wos_group#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU' or type = 'CT') and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
		</cfquery>
		<cfif getout.qty neq "">
			<cfset outqty = #getout.qty#>
		<cfelse>
			<cfset outqty = 0>
		</cfif>

		<cfset ttoutqty = outqty + doqty>

		<cfset balqty =  bfqty + inqty - ttoutqty>

		<cfset fifoqty = 0>
		<cfset ttnewffstkval =0>

		<cfquery name="getrc" datasource="#dts#">
			select qty, amt, amt_bil, price, price_bil from ictran where wos_group = '#getitem.wos_group#' and type = 'RC' and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			order by trdatetime desc
		</cfquery>

		<cfif getrc.recordcount gt 0 and check.recordcount gt 0>
			<cfset totalrcqty = 0>
			<cfset cnt = 0>
			<cfloop query="getrc">
				<cfset cnt = cnt + 1>
				<cfif getrc.qty neq "">
					<cfset rcqty = getrc.qty>
				<cfelse>
					<cfset rcqty = 0>
				</cfif>
				<cfset totalrcqty = totalrcqty + rcqty>
				<cfif totalrcqty gte ttoutqty>
					<cfset minusqty = totalrcqty - ttoutqty>
					<cfif minusqty gt 0>
						<cfset stkval = minusqty * getrc.price>
					<cfelse>
						<cfset stkval = 0>
					</cfif>
					<cfbreak>
				</cfif>
			</cfloop>
			<cfif totalrcqty gte ttoutqty>
				<cfset cnt = cnt + 1> <!--- next record --->
				<cfset newstkval = 0>
				<cfoutput query="getrc" startrow="#cnt#">
					<cfset newstkval = newstkval + getrc.amt>
				</cfoutput>
				<cfloop index="i" from="11" to="50">
					<cfset ffq = "sum(a.ffq"&"#i#)">
					<cfset ffc = "sum(a.ffc"&"#i#)">
					<cfquery name="getfifoopq" datasource="#dts#">
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
					</cfquery>

					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>
				</cfloop>

				<cfset totalstkval = stkval + newstkval + ttnewffstkval>

			<cfelse> <!--- rc less than out --->
				<cfset ttnewffstkval = 0>
				<cfset fifoqty = totalrcqty>
				<cfloop index="i" from="11" to="50">
					<cfset ffq = "sum(a.ffq"&"#i#)">
					<cfset ffc = "sum(a.ffc"&"#i#)">
					<cfquery name="getfifoopq" datasource="#dts#">
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
					</cfquery>

					<cfset fifoqty = fifoqty + getfifoopq.xffq>
					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>

					<cfif fifoqty gte ttoutqty>
						<cfset minusfifoqty = fifoqty - ttoutqty>
						<cfif minusfifoqty gt 0>
							<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
						<cfelse>
							<cfset stkvalff = 0>
						</cfif>
						<cfset fifocnt = #i# + 1>
						<cfbreak>
					</cfif>
				</cfloop>

				<cfif fifoqty gte ttoutqty>
					<cfset ttnewffstkval = 0>
					<cfloop index="i" from="#fifocnt#" to="50">
						<cfset ffq = "sum(a.ffq"&"#i#)">
						<cfset ffc = "sum(a.ffc"&"#i#)">
						<cfquery name="getfifoopq2" datasource="#dts#">
							select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
						</cfquery>

						<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
						<cfset ttnewffstkval = ttnewffstkval + newffstkval>
					</cfloop>
				</cfif>
				<cfset totalstkval = stkvalff + ttnewffstkval>
			</cfif>

		<cfelseif getrc.recordcount eq 0 and check.recordcount gt 0>

			<cfset ttnewffstkval = 0>

			<cfloop index="i" from="11" to="50">
				<cfset ffq = "sum(a.ffq"&"#i#)">
				<cfset ffc = "sum(a.ffc"&"#i#)">
				<cfquery name="getfifoopq2" datasource="#dts#">
					select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.wos_group= '#getitem.wos_group#'
				</cfquery>

				<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
				<cfset ttnewffstkval = ttnewffstkval + newffstkval>
			</cfloop>
			<cfset totalstkval = ttnewffstkval>

		<cfelse>

			<cfset totalrcqty = 0>
			<cfset cnt = 0>
			<cfset stkval = 0>
			<cfset newstkval = 0>
			<cfif getrc.recordcount gt 0>
				<cfloop query="getrc">
					<cfset cnt = cnt + 1>
					<cfif getrc.qty neq "">
						<cfset rcqty = getrc.qty>
					<cfelse>
						<cfset rcqty = 0>
					</cfif>

					<cfset totalrcqty = totalrcqty + rcqty>
					<cfif totalrcqty gte ttoutqty>
						<cfset minusqty = totalrcqty - ttoutqty>
						<cfif minusqty gt 0>
							<cfset stkval = minusqty * getrc.price>
						<cfelse>
							<cfset stkval = 0>
						</cfif>
						<cfbreak>
					</cfif>
				</cfloop>
				<cfif getrc.recordcount gt cnt>
					<cfset cnt = cnt + 1> <!--- next record --->
					<cfset newstkval = 0>
					<cfoutput query="getrc" startrow="#cnt#">

						<cfset newstkval = newstkval + getrc.amt>
					</cfoutput>
				<cfelse>
					<cfset newstkval = 0>
				</cfif>
			</cfif>
			<cfset totalstkval = stkval + newstkval>
          
            
            
            
		</cfif>
  
	  <cfoutput>
      <cfif isdefined('form.include0')>
             <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+inqty>
       <cfset grandtotalout=grandtotalout+ttoutqty>
        <cfset grandtotalqty=grandtotalqty+balqty>
         <cfset grandtotalstkval=grandtotalstkval+totalstkval>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtybf#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#inqty#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttoutqty#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balqty#</font></div></td>
        <cfif getpin2.h42A0 eq 'T'>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,",___.__")#</font></div></td></cfif>
	  </tr>
     
      <cfelse>
      <cfif totalstkval neq 0>
         <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+inqty>
       <cfset grandtotalout=grandtotalout+ttoutqty>
        <cfset grandtotalqty=grandtotalqty+balqty>
         <cfset grandtotalstkval=grandtotalstkval+totalstkval>
	  <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtybf#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#inqty#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttoutqty#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balqty#</font></div></td>
        <cfif getpin2.h42A0 eq 'T'>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,",___.__")#</font></div></td></cfif>
	  </tr>
      </cfif>
           </cfif>
	  </cfoutput>
	 </cfloop>
<cfoutput>
     <tr>
     <td colspan="10"><hr></td>
     </tr>
       <tr>
      <td></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b> TOTAL :</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalqtybf#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalin#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalout#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#grandtotalqty#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#numberformat(grandtotalstkval,",_.__")#</b></font></div></td>
     
      </tr>
      <tr>     <td colspan="10"><hr></td>
</tr>
</cfoutput>
	</table>

<cfelseif getgeneral.cost eq "fifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,wos_group,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by wos_group order by wos_group
	</cfquery>

	<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0">
		<cfoutput>
		<tr>
			<td colspan="4"><font size="2" face="Times New Roman, Times, serif">
			<cfif getgeneral.compro neq "">
			  #getgeneral.compro#
			</cfif>
			</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		</cfoutput>
		<tr>
			<td colspan="10"><hr></td>
		</tr>
	  	<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">GROUP</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">GROUP DESCRIPTION</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
            <cfif getpin2.h42A0 eq 'T'>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td>
            </cfif>
	   </tr>
	  	<tr>
			<td colspan="10"><hr></td>
		</tr>
	<cfloop query="getitem">
    <cfset grandout=0>
    <cfset grandin=0>
    <cfset granbal=0>
    <cfset grandstkval=0>
  
    
    <cfquery name="getitemdetail" datasource="#dts#">
		select itemno,desp,wos_group,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
		and category >= '#form.categoryFrom#' and category <= '#form.categoryTo#'
		</cfif>
		and wos_group ='#getitem.wos_group#'
		group by itemno order by itemno
	</cfquery>
    
    <cfloop query="getitemdetail">
		<cfquery name="check" datasource="#dts#">
			select a.itemno,b.itemno from fifoopq a, icitem b
			where a.itemno = b.itemno and b.wos_group = '#getitem.wos_group#'
		</cfquery>



		<cfif getitemdetail.qtybf neq "">
			<cfset bfqty = #getitemdetail.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitemdetail.wos_group#'
			and (type = 'RC' or type = 'CN' or type = 'OAI' or type='TRIN') and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            and itemno='#getitemdetail.itemno#'
		</cfquery>

		<cfif getin.qty neq "">
			<cfset inqty = #getin.qty#>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitemdetail.wos_group#' and type = 'DO' and (toinv = '' or toinv is null)  and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            and itemno='#getitemdetail.itemno#'
		</cfquery>

		<cfif getdo.qty neq "">
			<cfset doqty = #getdo.qty#>
		<cfelse>
			<cfset doqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select sum(qty) as qty from ictran where wos_group = '#getitemdetail.wos_group#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU') and (void='' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            and itemno='#getitemdetail.itemno#'
		</cfquery>
		<cfif getout.qty neq "">
			<cfset outqty = #getout.qty#>
		<cfelse>
			<cfset outqty = 0>
		</cfif>

		<cfset ttoutqty = outqty + doqty>

		<cfset balqty =  bfqty + inqty - ttoutqty>

		<cfset fifoqty = 0>
		<cfset ttnewffstkval =0>

		<cfif bfqty neq 0 and check.recordcount gt 0>

			<cfloop index="i" from="50" to="11" step="-1">
				<cfset ffq = "sum(a.ffq"&"#i#)">
				<cfset ffc = "sum(a.ffc"&"#i#)">
				<cfquery name="getfifoopq" datasource="#dts#">
					select #ffq# as xffq, #ffc# as xffc from fifoopq a,icitem b where a.itemno=b.itemno and
					b.wos_group = '#getitemdetail.wos_group#'
                    
                    and a.itemno='#getitemdetail.itemno#'
				</cfquery>
				<cfif getfifoopq.recordcount gt 0>
                <cfset getfifoopq.xffq = val(getfifoopq.xffq)>
                <cfset getfifoopq.xffc = val(getfifoopq.xffc)>
					<cfset fifoqty = val(fifoqty) + val(getfifoopq.xffq)>
					<cfset newffstkval = val(getfifoopq.xffq) * val(getfifoopq.xffc)>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>

					<cfif fifoqty gte ttoutqty>
						<cfset minusfifoqty = fifoqty - ttoutqty>
						<cfif minusfifoqty gt 0>
							<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
						<cfelse>
							<cfset stkvalff = 0>
						</cfif>
						<cfset fifocnt = #i# - 1>
						<cfbreak>
					</cfif>
				</cfif>
			</cfloop>
			<cfif fifoqty gte ttoutqty>
				<cfset ttnewffstkval = 0>

				<cfloop index="i" from="#fifocnt#" to="11" step="-1">
					<cfset ffq = "sum(a.ffq"&"#i#)">
					<cfset ffc = "sum(a.ffc"&"#i#)">
					<cfquery name="getfifoopq2" datasource="#dts#">
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b
						where a.itemno = b.itemno and b.wos_group = '#getitemdetail.wos_group#'
                        and a.itemno='#getitemdetail.itemno#'
					</cfquery>
					<cfset getfifoopq2.xffq = val(getfifoopq2.xffq)>
                    <cfset getfifoopq2.xffc = val(getfifoopq2.xffc)>
					<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>
				</cfloop>
				<cfquery name="getallrc" datasource="#dts#">
					select a.itemno,(ifnull(b.amt1,0)+ifnull(c.amt2,0)) as sumamt,(ifnull(b.amt_bil1,0)+ifnull(c.amt_bil2,0)) as sumamtbil,
							(ifnull(b.price1,0)+ifnull(c.price2,0)) as price,(ifnull(b.price_bil1,0)+ifnull(c.price_bil2,0)) as price_bil 
							from icitem as a 
							left join 
							(
								select itemno,sum(amt) as amt1,sum(amt_bil) as amt_bil1,sum(price) as price1,sum(price_bil)as price_bil1 
								from ictran 
								where itemno='#getitemdetail.itemno#' and type in ('RC','OAI') and (void = '' or void is null)							
                                
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
								group by itemno
							) as b on a.itemno=b.itemno 
							
							left join 
							(
								select itemno,sum(it_cos) as amt2,sum(it_cos/currrate) as amt_bil2,sum(it_cos/qty) as price2,sum((it_cos/currrate)/qty)as price_bil2 
								from ictran 
								where itemno='#getitemdetail.itemno#' and type='CN' and (void = '' or void is null) 
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod+0 <= '#form.periodto#'
								</cfif>
								group by itemno 
							) as c on a.itemno=c.itemno 
							where a.itemno='#getitemdetail.itemno#';
				</cfquery>
				<cfquery name="getrc" datasource="#dts#">
					select qty,
						if(type='CN',it_cos,<cfif isdefined('form.misccost')>amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7<cfelse>amt</cfif>)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						<cfif isdefined('form.misccost')>((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)<cfelse>price</cfif>) as price,
						if(type='CN',((it_cos/currrate)/qty),price_bil) as price_bil 
						from ictran 
						where itemno='#getitemdetail.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					order by trdatetime
				</cfquery>

				<cfif getallrc.sumamt eq "">
					<cfset sumamt = 0>
				<cfelse>
					<cfset sumamt = getallrc.sumamt>
				</cfif>

				<cfset totalstkval = stkvalff + ttnewffstkval + sumamt>
			<cfelse>
				<cfset totalrcqty = #fifoqty#>
				<cfset stkval = 0>
				<cfquery name="getrc" datasource="#dts#">
					select qty,
						if(type='CN',it_cos,<cfif isdefined('form.misccost')>amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7<cfelse>amt</cfif>)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						<cfif isdefined('form.misccost')>((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)<cfelse>price</cfif>) as price,
						if(type='CN',((it_cos/currrate)/qty),price_bil) as price_bil 
						from ictran 
						where itemno='#getitemdetail.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					order by trdatetime
				</cfquery>
				<cfset cnt = 0>
				<cfloop query="getrc">
					<cfset cnt = cnt + 1>
					<cfif getrc.qty neq "">
						<cfset rcqty = getrc.qty>
					<cfelse>
						<cfset rcqty = 0>
					</cfif>

					<cfset totalrcqty = totalrcqty + rcqty>
					<cfif totalrcqty gte ttoutqty>
						<cfset minusqty = totalrcqty - ttoutqty>
						<cfif minusqty gt 0>
							<cfset stkval = minusqty * getrc.price>
						<cfelse>
							<cfset stkval = 0>
						</cfif>
						<cfbreak>
					</cfif>
				</cfloop>
				<cfif getrc.recordcount gt cnt>
					<cfset cnt = cnt + 1> <!--- next record --->
					<cfset newstkval = 0>
					<cfoutput query="getrc" startrow="#cnt#">

						<cfset newstkval = newstkval + getrc.amt>
					</cfoutput>
				<cfelse>
					<cfset newstkval = 0>
				</cfif>
				<cfset totalstkval = stkval + newstkval>
			</cfif>
		<cfelse>
			<cfset totalrcqty = 0>
			<cfset stkval = 0>
			<cfquery name="getrc" datasource="#dts#">
				select qty,
						if(type='CN',it_cos,<cfif isdefined('form.misccost')>amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7<cfelse>amt</cfif>)as amt,
						if(type='CN',(it_cos/currrate),
						amt_bil) as amt_bil,
						if(type='CN',(it_cos/qty),
						<cfif isdefined('form.misccost')>((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)<cfelse>price</cfif>) as price,
						if(type='CN',((it_cos/currrate)/qty),price_bil) as price_bil 
						from ictran 
						where itemno='#getitemdetail.itemno#' and type in ('RC','CN','OAI') and (void = '' or void is null) 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				order by trdatetime
			</cfquery>
			<cfset cnt = 0>
			<cfloop query="getrc">
				<cfset cnt = cnt + 1>
				<cfif getrc.qty neq "">
					<cfset rcqty = getrc.qty>
				<cfelse>
					<cfset rcqty = 0>
				</cfif>

				<cfset totalrcqty = totalrcqty + rcqty>
				<cfif totalrcqty gte ttoutqty>
					<cfset minusqty = totalrcqty - ttoutqty>
					<cfif minusqty gt 0>
						<cfset stkval = minusqty * getrc.price>
					<cfelse>
						<cfset stkval = 0>
					</cfif>
					<cfbreak>
				</cfif>
			</cfloop>
			<cfif getrc.recordcount gt cnt>
				<cfset cnt = cnt + 1> <!--- next record --->
				<cfset newstkval = 0>
				<cfoutput query="getrc" startrow="#cnt#">

					<cfset newstkval = newstkval + getrc.amt>
				</cfoutput>
			<cfelse>
				<cfset newstkval = 0>
			</cfif>
			<cfset totalstkval = stkval + newstkval>
		</cfif>
        
        <cfset grandout=grandout+ttoutqty>
        <cfset grandin=grandin+inqty>
    <cfset granbal=granbal+balqty>
    <cfset grandstkval=grandstkval+totalstkval>
   <cfset grandtotalstkval=grandtotalstkval+totalstkval>
    
	  </cfloop>
      
	  <cfoutput>
	  	<cfquery name="getdesp" datasource="#dts#">
			select desp from icgroup where wos_group = '#getitem.wos_group#'
		</cfquery>
     <cfif isdefined('form.include0')>
                     <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+grandin>
       <cfset grandtotalout=grandtotalout+grandout>
        <cfset grandtotalqty=grandtotalqty+granbal>
         <!---<cfset grandtotalstkval=grandtotalstkval+totalstkval>--->
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#wos_group#</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdesp.desp#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtybf#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#grandin#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#grandout#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#granbal#</font></div></td>
        <cfif getpin2.h42A0 eq 'T'>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandstkval,",_.__")#</font></div></td>
        </cfif>
	  </tr>
     
        <cfelse>
      
        <cfif grandstkval neq 0>
            <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+grandin>
       <cfset grandtotalout=grandtotalout+grandout>
        <cfset grandtotalqty=grandtotalqty+granbal>
        <!--- <cfset grandtotalstkval=grandtotalstkval+totalstkval>--->
	  <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#wos_group#</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdesp.desp#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtybf#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#grandin#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#grandout#</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#granbal#</font></div></td>
        <cfif getpin2.h42A0 eq 'T'>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandstkval,",_.__")#</font></div></td>
        </cfif>
	  </tr>
      </cfif>
      </cfif>
     
	  </cfoutput>
	 </cfloop>
     <cfoutput>
     <tr>
     <td colspan="10"><hr></td>
     </tr>
       <tr>
      <td></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b> TOTAL :</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b> #grandtotalqtybf#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b> #grandtotalin#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b> #grandtotalout#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b> #grandtotalqty#</b></font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><b>#numberformat(grandtotalstkval,",_.__")#</b></font></div></td>
     
      </tr>
      <tr>     <td colspan="10"><hr></td>
</tr>
      </cfoutput>
	</table>
</cfif>
<cfif getitem.recordcount eq 0>
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