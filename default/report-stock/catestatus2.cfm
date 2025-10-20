<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
    <cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>
<cfset iDecl_UPrice = #getgsetup2.Decl_UPrice#>
<cfset stDecl_UPrice = "___.">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = #stDecl_UPrice# & "_">
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
		   			<Alignment ss:Horizontal="Left"/>
		  		</Style>
                <Style ss:ID="s28">
		   			<Alignment ss:Horizontal="Right"/>
					<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
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
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
                
		 	</Styles>
            
            <Worksheet ss:Name="Category Status and Value Summary">
            
            <cfif isdefined('form.dodate')>
<cfquery name="createtable" datasource="#dts#">
CREATE TABLE IF NOT EXISTS `dolink`  (
  `useddo` VARCHAR(50)
)
ENGINE = MyISAM;
</cfquery>
<cfquery name="truncatedolink" datasource="#dts#">
truncate dolink
</cfquery>
<cfquery name="getdoupdated" datasource="#dts#">
INSERT INTO dolink SELECT frrefno FROM iclink WHERE frtype = "DO" group by frrefno
</cfquery>

</cfif> 

	<cfset intrantype="'RC','CN','OAI','TRIN'">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU'">
    <cfset outtrantypewithinv1="'DO','DN','PR','CS','ISS','OAR','TROU'">

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(form.dateto, "DD")>

	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

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

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset totalbf=0>
<cfset totalin=0>
<cfset totalout=0>
<cfset totalbal=0>
<cfset totalstkval=0>
<cfset totalstkval2=0>


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
	select itemno,desp,wos_group,category,sum(qtybf) as qtybf,ucost from icitem where itemno <> '' and category <>''

	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
	and category >= '#form.catefrom#' and category <= '#form.cateto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
	</cfif>
	group by category order by category
</cfquery>

            
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="200.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="60.75"/>
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
    	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Category Status and Value Summary</Data></Cell>
        </Row>
        
   <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#costingmethod#" output = "wddxText">
        <Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Calculated by <cfoutput>#wddxText#</cfoutput></Data></Cell>
	</Row>

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
         	<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
            <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd-mm-yyyy")#" output = "wddxText2">
      	<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq ""></Data></Cell>
         <Cell ss:StyleID="s26"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
		 </cfif>
		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
    </Row>
	</cfoutput>
    
  	<Row>
  		<Cell ss:StyleID="s50"><Data ss:Type="String">No</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Category</Data></Cell>
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
		select sum(qty)as sumqty from ictran where type ="RC" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getrc.sumqty neq "">
        <cfset RCqty = #getrc.sumqty#>
      </cfif>

    <cfquery name="getpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getpr.sumqty neq "">
        <cfset PRqty = #getpr.sumqty#>
      </cfif>

    <cfquery name="getdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getdo.sumqty neq "">
        <cfset DOqty = #getdo.sumqty#>
      </cfif>

    <cfquery name="getinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        		<cfif isdefined('form.dodate')> 
				and (type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink)))
				<cfelse>
                and (toinv='' or toinv is null) 
                </cfif>
          and (void='' or void is null)
        
    </cfquery>

      <cfif getinv.sumqty neq "">
        <cfset INVqty = #getinv.sumqty#>
      </cfif>

    <cfquery name="getcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getcn.sumqty neq "">
        <cfset CNqty = #getcn.sumqty#>
      </cfif>

    <cfquery name="getdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getdn.sumqty neq "">
        <cfset DNqty = #getdn.sumqty#>
      </cfif>

	<cfquery name="getcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getcs.sumqty neq "">
        <cfset CSqty = #getcs.sumqty#>
      </cfif>

	<cfquery name="getiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getiss.sumqty neq "">
        <cfset ISSqty = #getiss.sumqty#>
      </cfif>

	<cfquery name="getoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getoai.sumqty neq "">
        <cfset OAIqty = #getoai.sumqty#>
      </cfif>

	<cfquery name="getoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getoar.sumqty neq "">
        <cfset OARqty = #getoar.sumqty#>
      </cfif>



	<!--- LAST ITEMBAL --->
	<cfquery name="lastgetrc" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type ="RC" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetrc.sumqty neq "">
        <cfset lastRCqty = #lastgetrc.sumqty#>
      </cfif>

    <cfquery name="lastgetpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetpr.sumqty neq "">
        <cfset lastPRqty = #lastgetpr.sumqty#>
      </cfif>

    <cfquery name="lastgetdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetdo.sumqty neq "">
        <cfset lastDOqty = #lastgetdo.sumqty#>
      </cfif>

    <cfquery name="lastgetinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        <cfif isdefined('form.dodate')> 
				and (type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink)))
				<cfelse>
                and (toinv='' or toinv is null) 
                </cfif>
          and (void='' or void is null)
        
    </cfquery>

      <cfif lastgetinv.sumqty neq "">
        <cfset lastINVqty = #lastgetinv.sumqty#>
      </cfif>

    <cfquery name="lastgetcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetcn.sumqty neq "">
        <cfset lastCNqty = #lastgetcn.sumqty#>
      </cfif>

    <cfquery name="lastgetdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetdn.sumqty neq "">
        <cfset lastDNqty = #lastgetdn.sumqty#>
      </cfif>

	<cfquery name="lastgetcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetcs.sumqty neq "">
        <cfset lastCSqty = #lastgetcs.sumqty#>
      </cfif>

	<cfquery name="lastgetiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetiss.sumqty neq "">
        <cfset lastISSqty = #lastgetiss.sumqty#>
      </cfif>

	<cfquery name="lastgetoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetoai.sumqty neq "">
        <cfset lastOAIqty = #lastgetoai.sumqty#>
      </cfif>

	<cfquery name="lastgetoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" <cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
			</cfif>
             and type = 'RC'
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" <cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
		</cfif>
			
			<!--- and month(wos_date) = '#monthnow#' ---> and type = 'PR'
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

<cfif #stDecl_UPrice# neq ''>
		<cfset xucost = numberformat(fixedcost,#stDecl_UPrice#)>
</cfif>
		<cfquery datasource="#dts#" name="get1stRC">
			select refno,type,wos_date from ictran where category = "#getitem.category#" and type = 'RC'
			<!--- <cfif form.periodfrom neq "" and form.periodto neq "">and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'</cfif> --->
			order by wos_date
		</cfquery>


		<cfloop query="get1stRC" endrow="1">

			<cfquery name="getinv" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where category = "#getitem.category#" and type = 'INV' and wos_date < #get1stRC.wos_date#
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
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where category = "#getitem.category#" and type = 'PR' and wos_date < #get1stRC.wos_date#
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
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
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where category = "#getitem.category#" and type = 'PR' and wos_date < #get1stRC.wos_date#
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" and type = 'RC'
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" and type = 'PR'
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
            
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
			select sum(ucost)as ucost from icitem where category = "#getitem.category#"
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and category >= "#form.catefrom#" and category <= "#form.cateto#"
			</cfif>
		</cfquery>
		<cfif getprice.ucost neq "">
			<cfset xucost = #getprice.ucost#>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>

		</cfif>
	</cfif>


	<cfquery datasource="#dts#" name="getdesp">
		select desp from iccate where cate = "#getitem.category#"
	</cfquery>
    
    <cfquery name="getstkvalue" datasource="#dts#">
    select sum(stockbalance) as stockbalance,sum(qin) as qin,sum(qout) as qout,sum(balance) as balance,sum(qtybf) as qtybf,category from
    (
			select a.itemno,a.aitemno,a.unit,a.category,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as cc on aa.itemno=cc.itemno
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif isdefined("form.include0")>
				<!--- <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >= 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase>
					<!--- REMARK ON 07-04-2009 --->
					<!--- <cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase> --->
				</cfswitch> --->
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
            
        )as ccc
        where category='#category#'
        group by category
		</cfquery>
        
        <!---New Moving calculation--->
            
            <cfif getgeneral.cost eq "MOVING">
            <cfset stkval=0>
            
            <cfquery name="getcateitem" datasource="#dts#">
            select itemno from icitem where category='#getitem.category#'
            </cfquery>
            
            <cfloop query="getcateitem">
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getqtybf" datasource="#dts#">
			select LastAccDate,ThisAccDate,avcost2,qtybf FROM icitem_last_year
			where itemno='#getcateitem.itemno#' and LastAccDate = #thislastaccdate# 
			limit 1
            </cfquery>
            
            <cfelse>
            <cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#getcateitem.itemno#'
			 limit 1
            </cfquery>
           
            </cfif>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b

			where a.itemno='#getcateitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod='99'
			and a.wos_date > #getdate.LastAccDate#
			and a.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by a.wos_date,b.created_on,a.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#getcateitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date,b.created_on,a.trdatetime
		</cfquery>
		</cfif>
        
        <cfloop query="getmovingictran">
        <cfif isdefined('form.dodate')>
  		<cfif type eq "INV">
  		<cfquery name="checkexist2" datasource="#dts#">
  		select toinv,refno,type,itemno from ictran a  where refno ='#getmovingictran.refno#' and itemno =			
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmovingictran.itemno#"> and type = "#getmovingictran.type#" and 
        trancode = "#getmovingictran.trancode#" and (dono = "" or dono is null or dono not in (select 
        frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  		</cfquery>
  		</cfif>
  		</cfif>
        <!---exclude CN --->
        <cfif getgeneral.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        </cfif>
        
        <cfif getgeneral.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>
        
        <cfif isdefined('form.dodate')>
                    
        <cfif getmovingictran.type eq "DO">
        <cfset movingbal=movingbal-getmovingictran.qty>
		<cfelseif getmovingictran.type eq "INV" and checkexist2.recordcount eq 0>
        <cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        <!---
        <cfif huserid eq 'ultralung'>
        <cfoutput>
        #movingunitcost#
        #movingbal#
        #refno#
        <br>
        </cfoutput>
        </cfif>--->
        
        </cfloop>
        
		<cfset movingstockbal=movingbal*movingunitcost>
        <cfset stkval=stkval+movingstockbal>
        </cfloop>
        </cfif>
        
        
    <cfset stkval =val(getstkvalue.stockbalance)>
    <!---
	<cfset stkval = #val(balonhand)# * #val(xucost)#>--->

    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
      <cfwddx action = "cfml2wddx" input = "#i#" output = "wddxText1">
 	  <cfwddx action = "cfml2wddx" input = "#category# - #getdesp.desp#" output = "wddxTex2">
      <cfwddx action = "cfml2wddx" input = "#NumberFormat(val(xucost), stDecl_UPrice)#" output = "wddxTex3">
      <cfwddx action = "cfml2wddx" input = "#getstkvalue.qtybf#" output = "wddxTex4">
      <cfwddx action = "cfml2wddx" input = "#getstkvalue.qin#" output = "wddxTex5">
      <cfwddx action = "cfml2wddx" input = "#getstkvalue.qout#" output = "wddxTex6">
      <cfwddx action = "cfml2wddx" input = "#getstkvalue.balance#" output = "wddxTex7">
      <cfwddx action = "cfml2wddx" input = "#numberformat(stkval,"___.__")#" output = "wddxTex8">


      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText1#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxTex2#</Data></Cell><cfif getpin2.h42A0 eq 'T'>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxTex3#</Data></Cell></cfif>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxTex4#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxTex5#</Data></Cell>
      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxTex6#</Data></Cell>
   	  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxTex7#</Data></Cell>
      <cfif getpin2.h42A0 eq 'T'>
       <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxTex8#</Data></Cell></cfif>
    </Row>
    <cfset i = incrementvalue(#i#)>
    <cfset totalbf=totalbf +lastbalonhand>
    <cfset totalin=totalin+stockin>
    <cfset totalout=totalout+stockout>
    <cfset totalbal=totalbal+balonhand>
    <cfset totalstkval=totalstkval+stkval>
  </cfoutput>
  <cfoutput>

    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
 		 <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
         </Row>

    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
      <cfwddx action = "cfml2wddx" input = "Total :" output = "wddxText9">
   	  <cfwddx action = "cfml2wddx" input = "#totalbf#" output = "wddxText10">
      <cfwddx action = "cfml2wddx" input = "#totalin#" output = "wddxText11">
      <cfwddx action = "cfml2wddx" input = "#totalout#" output = "wddxText12">
      <cfwddx action = "cfml2wddx" input = "#totalbal#" output = "wddxText13">
      <cfwddx action = "cfml2wddx" input = "#totalstkval#" output = "wddxText14">
 		 <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">Total :</Data></Cell>
  <cfif getpin2.h42A0 eq 'T'><Cell></Cell></cfif>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
   <cfif getpin2.h42A0 eq 'T'>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
  </cfif>
  </Row>
  </cfoutput>
</Table>

<cfelseif getgeneral.cost eq "lifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,wos_group,unit,category, sum(qtybf) as qtybf from icitem where itemno <> '' and category <>''
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= '#form.catefrom#' and category <= '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by category order by category
	</cfquery>

<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="200.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="60.75"/>
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
   			 <cfwddx action = "cfml2wddx" input = "#costingmethod#" output = "wddxText">
             <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Category Status and Value Summary</Data></Cell>
             <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Calculated by <cfoutput>#wddxText#</cfoutput></Data></Cell>
        </Row>


                 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                      <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText44">
                      <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText42">
        
                    <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#wddxText44#</cfif></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText42#</Data></Cell>
		</Row>
        </cfoutput>
		
	  	<Row>
	  		<Cell ss:StyleID="s26"><Data ss:Type="String">ITEM NO.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">ITEM DESCRIPTION</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">B/F</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">IN</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">OUT</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">QTY</Data></Cell>
            <cfif getpin2.h42A0 eq 'T'>
			<Cell ss:StyleID="s26"><Data ss:Type="String">STK VAL</Data></Cell>
            </cfif>
	  	</Row>
	  	
	<cfloop query="getitem">
		<cfquery name="check" datasource="#dts#">
			select a.itemno,b.itemno from fifoopq a, icitem b
			where a.itemno = b.itemno and b.category = '#getitem.category#'
		</cfquery>

		<cfif getitem.qtybf neq "">
			<cfset bfqty = #getitem.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and (type = 'RC' or type = 'CN' or type = 'OAI' or type='TRIN')
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		</cfquery>

		<cfif getin.qty neq "">
			<cfset inqty = #getin.qty#>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and type = 'DO' and toinv = ''
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		</cfquery>

		<cfif getdo.qty neq "">
			<cfset doqty = #getdo.qty#>
		<cfelse>
			<cfset doqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU' or type = 'CT')
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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
			select qty, amt, amt_bil, price, price_bil from ictran where category = '#getitem.category#' and type = 'RC'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category = '#getitem.category#'
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
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category = '#getitem.category#'
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
							select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category = '#getitem.category#'
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
					select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category= '#getitem.category#'
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
	  	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
       	<cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText15">
        <cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText16">
        <cfwddx action = "cfml2wddx" input = "#qtybf#" output = "wddxText17">
        <cfwddx action = "cfml2wddx" input = "#inqty#" output = "wddxText18">
        <cfwddx action = "cfml2wddx" input = "#ttoutqty#" output = "wddxText19">
        <cfwddx action = "cfml2wddx" input = "#balqty#" output = "wddxText20">
        <cfwddx action = "cfml2wddx" input = "#numberformat(totalstkval,"___.__")#" output = "wddxText21">

		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText16#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText17#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText18#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText19#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText20#</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText21#</Data></Cell></cfif>
	  </Row>
      <cfset totalbf=totalbf +lastbalonhand>
    <cfset totalin=totalin+inqty>
    <cfset totalout=totalout+ttoutqty>
    <cfset totalbal=totalbal+balqty>
    <cfset totalstkval2=totalstkval2+totalstkval>
	  </cfoutput>
	 </cfloop>
     <cfoutput>

	  	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
  
  	<cfwddx action = "cfml2wddx" input = "Total :" output = "wddxText22">
    <cfwddx action = "cfml2wddx" input = "#totalbf#" output = "wddxText23">
    <cfwddx action = "cfml2wddx" input = "#totalin#" output = "wddxText24">
    <cfwddx action = "cfml2wddx" input = "#totalout#" output = "wddxText25">	
    <cfwddx action = "cfml2wddx" input = "#totalbal#" output = "wddxText26">
    <cfwddx action = "cfml2wddx" input = "#totalstkval#" output = "wddxText27">  
  
  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">Total :</Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText23#</Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText24#</Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText25#</Data></Cell>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText26#</Data></Cell>
   <cfif getpin2.h42A0 eq 'T'>
  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText27#</Data></Cell>
  </cfif>
  </Row>
  </cfoutput>
	</Table>

<cfelseif getgeneral.cost eq "fifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,wos_group,unit,category, sum(qtybf) as qtybf from icitem where itemno <> '' and category <>''
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= '#form.catefrom#' and category <= '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by category order by category
	</cfquery>

<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="200.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="60.75"/>
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
    	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Category Status and Value Summary</Data></Cell>
        </Row>
        
   <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#costingmethod#" output = "wddxText">
        <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Calculated by <cfoutput>#wddxText#</cfoutput></Data></Cell>
	</Row>

        
	  	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
          	<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText51">
          	<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText41">
            
			<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#wddxText51#</cfif></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText41#</Data></Cell>
		</Row>
		</cfoutput>
		
	  	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<Cell ss:StyleID="s50"><Data ss:Type="String">CATEGORY</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">CATEGORY DESCRIPTION</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">B/F</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String">QTY</Data></Cell>
            <cfif getpin2.h42A0 eq 'T'>
			<Cell ss:StyleID="s50"><Data ss:Type="String">STK VAL</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
            </cfif>
	   </Row>
	  
		<cfloop query="getitem">
		<cfquery name="check" datasource="#dts#">
			select a.itemno,b.itemno from fifoopq a, icitem b
			where a.itemno = b.itemno and b.category = '#getitem.category#'
		</cfquery>



		<cfif getitem.qtybf neq "">
			<cfset bfqty = #getitem.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#'
			and (type = 'RC' or type = 'CN' or type = 'OAI' or type='TRIN')
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		</cfquery>

		<cfif getin.qty neq "">
			<cfset inqty = #getin.qty#>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and type = 'DO' and toinv = ''
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		</cfquery>

		<cfif getdo.qty neq "">
			<cfset doqty = #getdo.qty#>
		<cfelse>
			<cfset doqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU')
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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

		<cfif bfqty neq 0 and check.recordcount gt 0>

			<cfloop index="i" from="50" to="11" step="-1">
				<cfset ffq = "sum(a.ffq"&"#i#)">
				<cfset ffc = "sum(a.ffc"&"#i#)">
				<cfquery name="getfifoopq" datasource="#dts#">
					select #ffq# as xffq, #ffc# as xffc from fifoopq a,icitem b where a.itemno=b.itemno and
					b.category = '#getitem.category#'
				</cfquery>
				<cfif getfifoopq.recordcount gt 0>
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
						where a.itemno = b.itemno and b.category = '#getitem.category#'
					</cfquery>

					<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
					<cfset ttnewffstkval = ttnewffstkval + newffstkval>
				</cfloop>
				<cfquery name="getallrc" datasource="#dts#">
					select sum(amt) as sumamt, sum(amt_bil)as sumamtbil,sum(price) as price, sum(price_bil)as price_bil from ictran where category = '#getitem.category#' and type = 'RC'
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
					group by itemno
				</cfquery>
				<cfquery name="getrc" datasource="#dts#">
					select qty, amt, amt_bil, price, price_bil from ictran where category = '#getitem.category#' and type = 'RC'
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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
					select qty, amt, amt_bil, price, price_bil from ictran where category = '#getitem.category#' and type = 'RC'
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
                    <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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
				select qty, amt, amt_bil, price, price_bil from ictran where category = '#getitem.category#' and type = 'RC'
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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



	  <cfoutput>
	  	<cfquery name="getdesp" datasource="#dts#">
			select desp from iccate where cate = '#getitem.category#'
		</cfquery>
	   <Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#category#" output = "wddxText28">  
	 	<cfwddx action = "cfml2wddx" input = "#getdesp.desp#" output = "wddxText29">
     	<cfwddx action = "cfml2wddx" input = "#qtybf#" output = "wddxText30">
        <cfwddx action = "cfml2wddx" input = "#inqty#" output = "wddxText31">
        <cfwddx action = "cfml2wddx" input = "#ttoutqty#" output = "wddxText32">
        <cfwddx action = "cfml2wddx" input = "#balqty#" output = "wddxText33">
        <cfwddx action = "cfml2wddx" input = "#numberformat(totalstkval,"_.__")#" output = "wddxText34">
       
       
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText28#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText29#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText30#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText31#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText32#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText33#</Data></Cell>
        <cfif getpin2.h42A0 eq 'T'>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText34#</Data></Cell>
        </cfif>
	  </Row>
      <cfset totalbf=totalbf +lastbalonhand>
    <cfset totalin=totalin+inqty>
    <cfset totalout=totalout+ttoutqty>
    <cfset totalbal=totalbal+balqty>
    <cfset totalstkval2=totalstkval2+totalstkval>
	  </cfoutput>
	 </cfloop>
    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
 		 <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
         </Row>
  
     <cfoutput>
 
	  	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
          <cfwddx action = "cfml2wddx" input = "Total :" output = "wddxText35">
        <cfwddx action = "cfml2wddx" input = "#totalbf#" output = "wddxText36">
        <cfwddx action = "cfml2wddx" input = "#totalin#" output = "wddxText37">
        <cfwddx action = "cfml2wddx" input = "#totalout#" output = "wddxText38">
        <cfwddx action = "cfml2wddx" input = "#totalbal#" output = "wddxText39">
        <cfwddx action = "cfml2wddx" input = "#totalstkval#" output = "wddxText40">
        

  <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
  <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
  <Cell ss:StyleID="s51"><Data ss:Type="String">Total :</Data></Cell>
  <cfif getpin2.h42A0 eq 'T'></cfif>
  <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText36#</Data></Cell>
  <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText37#</Data></Cell>
  <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText38#</Data></Cell>
  <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText39#</Data></Cell>
   <cfif getpin2.h42A0 eq 'T'>
  <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText40#</Data></Cell>
  </cfif>
  </Row>
  </cfoutput>
    
	</Table></cfif>
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
<title>Category Status and Value Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfif isdefined('form.dodate')>
<cfquery name="createtable" datasource="#dts#">
CREATE TABLE IF NOT EXISTS `dolink`  (
  `useddo` VARCHAR(50)
)
ENGINE = MyISAM;
</cfquery>
<cfquery name="truncatedolink" datasource="#dts#">
truncate dolink
</cfquery>
<cfquery name="getdoupdated" datasource="#dts#">
INSERT INTO dolink SELECT frrefno FROM iclink WHERE frtype = "DO" group by frrefno
</cfquery>

</cfif> 

	<cfset intrantype="'RC','CN','OAI','TRIN'">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU'">
    <cfset outtrantypewithinv1="'DO','DN','PR','CS','ISS','OAR','TROU'">

<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(form.dateto, "DD")>

	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

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

<cfset totalbf=0>
<cfset totalin=0>
<cfset totalout=0>
<cfset totalbal=0>
<cfset totalstkval=0>
<cfset totalstkval2=0>

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
<h1 align="center">Category Status and Value Summary</h1>
<h2 align="center">Calculated by <cfoutput>#costingmethod#</cfoutput></h2>

<cfif getgeneral.cost neq "fifo" and getgeneral.cost neq "lifo">

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp,wos_group,category,sum(qtybf) as qtybf,ucost from icitem where itemno <> '' and category <>''

	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
	and category >= '#form.catefrom#' and category <= '#form.cateto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
	</cfif>
	group by category order by category
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
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Category</font></div></td>
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
		select sum(qty)as sumqty from ictran where type ="RC" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getrc.sumqty neq "">
        <cfset RCqty = #getrc.sumqty#>
      </cfif>

    <cfquery name="getpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getpr.sumqty neq "">
        <cfset PRqty = #getpr.sumqty#>
      </cfif>

    <cfquery name="getdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getdo.sumqty neq "">
        <cfset DOqty = #getdo.sumqty#>
      </cfif>

    <cfquery name="getinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        		<cfif isdefined('form.dodate')> 
				and (type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink)))
				<cfelse>
                and (toinv='' or toinv is null) 
                </cfif>
          and (void='' or void is null)
        
    </cfquery>

      <cfif getinv.sumqty neq "">
        <cfset INVqty = #getinv.sumqty#>
      </cfif>

    <cfquery name="getcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getcn.sumqty neq "">
        <cfset CNqty = #getcn.sumqty#>
      </cfif>

    <cfquery name="getdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getdn.sumqty neq "">
        <cfset DNqty = #getdn.sumqty#>
      </cfif>

	<cfquery name="getcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getcs.sumqty neq "">
        <cfset CSqty = #getcs.sumqty#>
      </cfif>

	<cfquery name="getiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getiss.sumqty neq "">
        <cfset ISSqty = #getiss.sumqty#>
      </cfif>

	<cfquery name="getoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getoai.sumqty neq "">
        <cfset OAIqty = #getoai.sumqty#>
      </cfif>

	<cfquery name="getoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif getoar.sumqty neq "">
        <cfset OARqty = #getoar.sumqty#>
      </cfif>



	<!--- LAST ITEMBAL --->
	<cfquery name="lastgetrc" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type ="RC" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif> 
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetrc.sumqty neq "">
        <cfset lastRCqty = #lastgetrc.sumqty#>
      </cfif>

    <cfquery name="lastgetpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetpr.sumqty neq "">
        <cfset lastPRqty = #lastgetpr.sumqty#>
      </cfif>

    <cfquery name="lastgetdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetdo.sumqty neq "">
        <cfset lastDOqty = #lastgetdo.sumqty#>
      </cfif>

    <cfquery name="lastgetinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        <cfif isdefined('form.dodate')> 
				and (type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink)))
				<cfelse>
                and (toinv='' or toinv is null) 
                </cfif>
          and (void='' or void is null)
        
    </cfquery>

      <cfif lastgetinv.sumqty neq "">
        <cfset lastINVqty = #lastgetinv.sumqty#>
      </cfif>

    <cfquery name="lastgetcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetcn.sumqty neq "">
        <cfset lastCNqty = #lastgetcn.sumqty#>
      </cfif>

    <cfquery name="lastgetdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetdn.sumqty neq "">
        <cfset lastDNqty = #lastgetdn.sumqty#>
      </cfif>

	<cfquery name="lastgetcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetcs.sumqty neq "">
        <cfset lastCSqty = #lastgetcs.sumqty#>
      </cfif>

	<cfquery name="lastgetiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetiss.sumqty neq "">
        <cfset lastISSqty = #lastgetiss.sumqty#>
      </cfif>

	<cfquery name="lastgetoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
    </cfquery>

      <cfif lastgetoai.sumqty neq "">
        <cfset lastOAIqty = #lastgetoai.sumqty#>
      </cfif>

	<cfquery name="lastgetoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and category = "#getitem.category#"
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod < '#form.periodfrom#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= "#form.catefrom#" and category <= "#form.cateto#"
		</cfif>
        and (toinv ='' or toinv is null)
        and (void='' or void is null)
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" <cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
			</cfif>
             and type = 'RC'
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" <cfif form.periodfrom neq "" and form.periodto neq ""> and fperiod <= '#form.periodto#'</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
		</cfif>
			
			<!--- and month(wos_date) = '#monthnow#' ---> and type = 'PR'
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
			select refno,type,wos_date from ictran where category = "#getitem.category#" and type = 'RC'
			<!--- <cfif form.periodfrom neq "" and form.periodto neq "">and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'</cfif> --->
			order by wos_date
		</cfquery>


		<cfloop query="get1stRC" endrow="1">

			<cfquery name="getinv" datasource="#dts#">
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where category = "#getitem.category#" and type = 'INV' and wos_date < #get1stRC.wos_date#
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
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where category = "#getitem.category#" and type = 'PR' and wos_date < #get1stRC.wos_date#
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
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
				select sum(amt)as sumamt, sum(qty) as qty, refno, type from ictran where category = "#getitem.category#" and type = 'PR' and wos_date < #get1stRC.wos_date#
				<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" and type = 'RC'
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
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
			select sum(amt)as sumamt,sum(qty) as qty from ictran where category = "#getitem.category#" and type = 'PR'
			<cfif form.periodfrom neq "" and form.periodto neq "">and fperiod <= '#form.periodto#'</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date <= '#ndateto#' 
				</cfif>
            
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
			select sum(ucost)as ucost from icitem where category = "#getitem.category#"
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and category >= "#form.catefrom#" and category <= "#form.cateto#"
			</cfif>
		</cfquery>
		<cfif getprice.ucost neq "">
			<cfset xucost = #getprice.ucost#>
			<cfset xucost = numberformat(xucost,#stDecl_UPrice#)>

		</cfif>
	</cfif>


	<cfquery datasource="#dts#" name="getdesp">
		select desp from iccate where cate = "#getitem.category#"
	</cfquery>
    
    <cfquery name="getstkvalue" datasource="#dts#">
    select sum(stockbalance) as stockbalance,sum(qin) as qin,sum(qout) as qout,sum(balance) as balance,sum(qtybf) as qtybf,category from
    (
			select a.itemno,a.aitemno,a.unit,a.category,a.desp,a.despa,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
			<cfswitch expression="#getgeneral.cost#">
				<cfcase value="FIXED">
				((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) as stockbalance
				</cfcase>
				<cfcase value="MONTH">
				((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
				<cfcase value="MOVING">
				((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				(((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) as stockbalance
				</cfcase>
			</cfswitch>
			from icitem as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 < '#form.periodfrom#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#'
	    		</cfif> 
				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where 
                <cfif isdefined('form.dodate')>
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (select useddo from dolink))))
				<cfelse>
                type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (toinv='' or toinv is null)
                </cfif>
                and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif> 
                <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date <= '#ndateto#'
	    		</cfif> 
				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as cc on aa.itemno=cc.itemno
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and aa.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and aa.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				group by aa.itemno
			) as j on a.itemno = j.itemno
	
			where a.itemno <> ''
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif isdefined("form.include0")>
				<!--- <cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) >= 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase>
					<!--- REMARK ON 07-04-2009 --->
					<!--- <cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) >= 0
					</cfcase> --->
				</cfswitch> --->
			<cfelse>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
					and ((ifnull(a.qtybf,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*ifnull(a.ucost,0)) > 0
					</cfcase>
					<cfcase value="MONTH">
					and (((ifnull(a.qtybf,0)) + ifnull(b.lastin,0) - ifnull(c.lastout,0) + ifnull(d.qin,0) - ifnull(e.qout,0))*(((ifnull(a.qtybf,0)*ifnull(a.avcost,0))+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
					<cfcase value="MOVING">
					and (((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0))*(((ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/(ifnull(a.qtybf,0)+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))) > 0
					</cfcase>
				</cfswitch>
			</cfif>
			<cfif isdefined("form.qty0")>
			<cfelse>
			and ((ifnull(a.qtybf,0))+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) <> 0
			</cfif>
            
        )as ccc
        where category='#category#'
        group by category
		</cfquery>
        
        <!---New Moving calculation--->
            
            <cfif getgeneral.cost eq "MOVING">
            <cfset stkval=0>
            
            <cfquery name="getcateitem" datasource="#dts#">
            select itemno from icitem where category='#getitem.category#'
            </cfquery>
            
            <cfloop query="getcateitem">
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getqtybf" datasource="#dts#">
			select LastAccDate,ThisAccDate,avcost2,qtybf FROM icitem_last_year
			where itemno='#getcateitem.itemno#' and LastAccDate = #thislastaccdate# 
			limit 1
            </cfquery>
            
            <cfelse>
            <cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#getcateitem.itemno#'
			 limit 1
            </cfquery>
           
            </cfif>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b

			where a.itemno='#getcateitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod='99'
			and a.wos_date > #getdate.LastAccDate#
			and a.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			</cfif>
			order by a.wos_date,b.created_on,a.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#getcateitem.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date,b.created_on,a.trdatetime
		</cfquery>
		</cfif>
        
        <cfloop query="getmovingictran">
        <cfif isdefined('form.dodate')>
  		<cfif type eq "INV">
  		<cfquery name="checkexist2" datasource="#dts#">
  		select toinv,refno,type,itemno from ictran a  where refno ='#getmovingictran.refno#' and itemno =			
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmovingictran.itemno#"> and type = "#getmovingictran.type#" and 
        trancode = "#getmovingictran.trancode#" and (dono = "" or dono is null or dono not in (select 
        frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  		</cfquery>
  		</cfif>
  		</cfif>
        <!---exclude CN --->
        <cfif getgeneral.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        </cfif>
        
        <cfif getgeneral.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>
        
        <cfif isdefined('form.dodate')>
                    
        <cfif getmovingictran.type eq "DO">
        <cfset movingbal=movingbal-getmovingictran.qty>
		<cfelseif getmovingictran.type eq "INV" and checkexist2.recordcount eq 0>
        <cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        <!---
        <cfif huserid eq 'ultralung'>
        <cfoutput>
        #movingunitcost#
        #movingbal#
        #refno#
        <br>
        </cfoutput>
        </cfif>--->
        
        </cfloop>
        
		<cfset movingstockbal=movingbal*movingunitcost>
        <cfset stkval=stkval+movingstockbal>
        </cfloop>
        </cfif>
        
        
        
        
    <cfset stkval =val(getstkvalue.stockbalance)>
    <!---
	<cfset stkval = #val(balonhand)# * #val(xucost)#>--->

    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#i#</font></div></td>
      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#category# - #getdesp.desp#</font></div></td><cfif getpin2.h42A0 eq 'T'>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(val(xucost), stDecl_UPrice)#</font></div></td></cfif>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getstkvalue.qtybf#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getstkvalue.qin#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getstkvalue.qout#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getstkvalue.balance#</font></div></td>
      <cfif getpin2.h42A0 eq 'T'>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(stkval,"___.__")#</font></div></td></cfif>
    </tr>
    <cfset i = incrementvalue(#i#)>
    <cfset totalbf=totalbf +lastbalonhand>
    <cfset totalin=totalin+stockin>
    <cfset totalout=totalout+stockout>
    <cfset totalbal=totalbal+balonhand>
    <cfset totalstkval=totalstkval+stkval>
  </cfoutput>
  <cfoutput>
  <tr>
  <td colspan="100%"><hr>
  </td></tr>
  <tr>
  <td></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Total :</font></div></td>
  <cfif getpin2.h42A0 eq 'T'><td></td></cfif>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalbf#</font></div></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalin#</font></div></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalout#</font></div></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalbal#</font></div></td>
   <cfif getpin2.h42A0 eq 'T'>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,",_.__")#</font></div></td>
  </cfif>
  </tr>
  </cfoutput>
</table>
<cfelseif getgeneral.cost eq "lifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,wos_group,unit,category, sum(qtybf) as qtybf from icitem where itemno <> '' and category <>''
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= '#form.catefrom#' and category <= '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by category order by category
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
			where a.itemno = b.itemno and b.category = '#getitem.category#'
		</cfquery>

		<cfif getitem.qtybf neq "">
			<cfset bfqty = #getitem.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and (type = 'RC' or type = 'CN' or type = 'OAI' or type='TRIN')
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		</cfquery>

		<cfif getin.qty neq "">
			<cfset inqty = #getin.qty#>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and type = 'DO' and toinv = ''
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
		</cfquery>

		<cfif getdo.qty neq "">
			<cfset doqty = #getdo.qty#>
		<cfelse>
			<cfset doqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitem.category#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU' or type = 'CT')
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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
			select qty, amt, amt_bil, price, price_bil from ictran where category = '#getitem.category#' and type = 'RC'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
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
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category = '#getitem.category#'
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
						select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category = '#getitem.category#'
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
							select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category = '#getitem.category#'
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
					select #ffq# as xffq, #ffc# as xffc from fifoopq a, icitem b where a.itemno = b.itemno and b.category= '#getitem.category#'
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
      <cfset totalbf=totalbf +lastbalonhand>
    <cfset totalin=totalin+inqty>
    <cfset totalout=totalout+ttoutqty>
    <cfset totalbal=totalbal+balqty>
    <cfset totalstkval2=totalstkval2+totalstkval>
	  </cfoutput>
	 </cfloop>
     <cfoutput>
  <tr>
  <td colspan="100%"><hr>
  </td></tr>
  <tr>
  <td></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Total :</font></div></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalbf#</font></div></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalin#</font></div></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalout#</font></div></td>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalbal#</font></div></td>
   <cfif getpin2.h42A0 eq 'T'>
  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval2,",_.__")#</font></div></td>
  </cfif>
  </tr>
  </cfoutput>
	</table>

<cfelseif getgeneral.cost eq "fifo">
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,category,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= '#form.catefrom#' and category <= '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		group by category order by category
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
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CATEGORY</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CATEGORY DESCRIPTION</font></div></td>
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
		select itemno,desp,category,unit, sum(qtybf) as qtybf from icitem where itemno <> '' and wos_group <>''
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
		</cfif>
		and category ='#getitem.category#'
		group by itemno order by itemno
	</cfquery>
    
    <cfloop query="getitemdetail">
		<cfquery name="check" datasource="#dts#">
			select a.itemno,b.itemno from fifoopq a, icitem b
			where a.itemno = b.itemno and b.category = '#getitem.category#'
		</cfquery>



		<cfif getitemdetail.qtybf neq "">
			<cfset bfqty = #getitemdetail.qtybf#>
		<cfelse>
			<cfset bfqty = 0>
		</cfif>

		<cfquery name="getin" datasource="#dts#">
			select sum(qty) as qty from ictran where category = '#getitemdetail.category#'
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
			select sum(qty) as qty from ictran where category = '#getitemdetail.category#' and type = 'DO' and (toinv = '' or toinv is null)  and (void='' or void is null)
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
			select sum(qty) as qty from ictran where category = '#getitemdetail.category#' and (type = 'INV' or type = 'PR' or type = 'DN' or type = 'CS' or type = 'ISS' or type = 'OAR' or type='TROU') and (void='' or void is null)
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
					b.category = '#getitemdetail.category#'
                    
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
						where a.itemno = b.itemno and b.category = '#getitemdetail.category#'
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
			select desp from iccate where cate = '#getitem.category#'
		</cfquery>
     <cfif isdefined('form.include0')>
                     <cfset grandtotalqtybf=grandtotalqtybf+qtybf>
      <cfset grandtotalin=grandtotalin+grandin>
       <cfset grandtotalout=grandtotalout+grandout>
        <cfset grandtotalqty=grandtotalqty+granbal>
         <!---<cfset grandtotalstkval=grandtotalstkval+totalstkval>--->
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#category#</font></div></td>
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
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#category#</font></div></td>
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