<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

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

		<cfif form.showby eq "qty">
			<cfset msg = "By Sales Quantity">
		<cfelse>
			<cfset msg = "By Sales Value">
		</cfif>

		<cfset totalqty =0>
		<cfset totalamt =0>
		<cfif lcase(HcomID) eq "hyray_i">
        <cfquery name="getcategory" datasource="#dts#">
        select a.itemno,b.category from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
			where (void = '' or void is null)
           <cfif form.custfrom neq "">
			and a.custno = '#form.custfrom#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and  a.wos_date > #getgeneral.lastaccyear# 
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
			and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
			</cfif>
			group by b.category
            order by b.category
        </cfquery>
        <cfelse>
        <cfquery name="getcategory" datasource="#dts#">
        select itemno,category,desp,sum(qty) as sumqty,sum(amt) as sumamt from ictran 
			where (type = 'INV' or type = 'DN' or type = 'CS') and (void = '' or void is null)
           <cfif form.custfrom neq "" and form.custto neq "">
			and custno >= '#form.custfrom#' and custno <= '#form.custto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
            <cfelse>
            and  wos_date > #getgeneral.lastaccyear# 
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
			and agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and category >='#form.catefrom#' and category <='#form.cateto#'
			</cfif>
			group by category
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
        </cfquery>
        </cfif>
        <cfquery name="getcustname" datasource="#dts#">
        select name from #target_arcust# where custno='#form.custfrom#'
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
					<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
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


		 	</Styles>
			
			<Worksheet ss:Name="Lot Number Stock Movement Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="100.25"/>
					<Column ss:Width="250.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="80.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
						<cfset c=c+1>
<cfoutput>


     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"><cfif url.trantype eq "top">TOP CATEGORY PRODUCT SALES REPORT<cfelse>BOTTOM CATEGORY PRODUCT SALES REPORT</cfif></Data></Cell>
			</Row>
            
            <cfif form.custfrom neq "" and form.custto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getcustname.name#" output = "wddxText">
		   <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Customer: <cfif lcase(HcomID) eq "hyray_i">#wddxText#<cfelse>#form.custfrom# - #form.custto#</cfif>
           </Data></Cell>
			</Row>
			</cfif>
            
			<cfif form.periodfrom neq "" and form.periodto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText1">
			 <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PERIOD: #wddxText1#</Data></Cell>
			</Row>
			</cfif>
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.agentfrom# - #form.agentto#" output = "wddxText2">
			 <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">AGENT: #wddxText2#</Data></Cell>
			</Row>
			</cfif>
            
            <cfif form.teamfrom neq "" and form.teamto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.teamfrom# - #form.teamto#" output = "wddxText3">
			 <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">TEAM: #wddxText3#</Data></Cell>
			</Row>
			</cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.areafrom# - #form.areato#" output = "wddxText4">
			 <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">AREA: #wddxText4#</Data></Cell>
			</Row>
			</cfif>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText5">
  		   <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText6">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">DESP</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">QTY SOLD</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">SALES</Data></Cell>
			</Row>
            
			<cfloop query="getcategory">
            <cfset subqty=0>
            <cfset subamt=0>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s41"><Data ss:Type="String">#category#</Data></Cell>
            <cfquery name="getcatedesp" datasource="#dts#">
            select desp from iccate where cate='#getcategory.category#'
            </cfquery>
            <Cell ss:StyleID="s41"><Data ss:Type="String">#getcatedesp.desp#</Data></Cell>
            </Row>

            
            <cfif lcase(HcomID) eq "hyray_i">
            <cfquery name="getitem" datasource="#dts#">
			select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as sumqty,aa.itemno,aa.desp,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as sumamt from
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
             and a.custno = '#form.custfrom#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as aa left join
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (type = 'INV' or type = 'DN' or type = 'CS')  and (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
             and a.custno = '#form.custfrom#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as bb on aa.itemno=bb.itemno left join
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (type = 'CN')  and (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
             and a.custno = '#form.custfrom#'
           
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as cc on aa.itemno = cc.itemno
            
            group by aa.itemno
            <cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
		</cfquery>
        
        <cfelse>
        <cfquery name="getitem" datasource="#dts#">
			select itemno, desp, sum(qty) as sumqty, sum(amt) as sumamt from ictran
			where (type = 'INV' or type = 'DN' or type = 'CS') and (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
            and custno >= '#form.custfrom#' and custno <= '#form.custto#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
            <cfelse>
            and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            and category='#getcategory.category#'
			group by itemno
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
		</cfquery>
        </cfif>
				<cfloop query="getitem">
                <cfif getitem.sumqty neq 0>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText9">
  		   <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText10">
  		   <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText11">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(val(getitem.sumqty),"0")#" output = "wddxText12">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(val(getitem.sumamt),stDecl_UPrice)#" output = "wddxText13">
           
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#.</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
                            <cfset totalqty = totalqty + val(getitem.sumqty)>
                        <cfset subqty= subqty+val(getitem.sumqty)>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
						<cfset totalamt = totalamt + val(getitem.sumamt)>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
					</Row>
                    </cfif>
				</cfloop>

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(subqty,"0")#" output = "wddxText14">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(subamt,",___.__")#" output = "wddxText15">
		    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
		    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
		    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s38"><Data ss:Type="String">#wddxText14#</Data></Cell>
            <Cell ss:StyleID="s38"><Data ss:Type="String">#wddxText15#</Data></Cell>
            </Row>
            </cfloop>
			
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(totalqty,"0")#" output = "wddxText16">
  		   <cfwddx action = "cfml2wddx" input = "#numberformat(totalamt,",___.__")#" output = "wddxText17">
        
		    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
		    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
			<Cell ss:StyleID="s38"><Data ss:Type="String">#wddxText16#</Data></Cell>
			<Cell ss:StyleID="s38"><Data ss:Type="String">#wddxText17#</Data></Cell>
			</Row>

		<cfif getcategory.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
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
    
            <cfcase value="HTML">

		<html>
		<head>
		<title>TOP CATEGORY PRODUCT SALES REPORT</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

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

		<cfif form.showby eq "qty">
			<cfset msg = "By Sales Quantity">
		<cfelse>
			<cfset msg = "By Sales Value">
		</cfif>

		<cfset totalqty =0>
		<cfset totalamt =0>
		<cfif lcase(HcomID) eq "hyray_i">
        <cfquery name="getcategory" datasource="#dts#">
        select a.itemno,b.category from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
			where (void = '' or void is null)
           <cfif form.custfrom neq "">
			and a.custno = '#form.custfrom#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and  a.wos_date > #getgeneral.lastaccyear# 
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
			and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
			</cfif>
			group by b.category
            order by b.category
        </cfquery>
        <cfelse>
        <cfquery name="getcategory" datasource="#dts#">
        select itemno,category,desp,sum(qty) as sumqty,sum(amt) as sumamt from ictran 
			where (type = 'INV' or type = 'DN' or type = 'CS') and (void = '' or void is null)
           <cfif form.custfrom neq "" and form.custto neq "">
			and custno >= '#form.custfrom#' and custno <= '#form.custto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
            <cfelse>
            and  wos_date > #getgeneral.lastaccyear# 
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
			and agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and category >='#form.catefrom#' and category <='#form.cateto#'
			</cfif>
			group by category
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
        </cfquery>
        </cfif>
        <cfquery name="getcustname" datasource="#dts#">
        select name from #target_arcust# where custno='#form.custfrom#'
        </cfquery>

		<body>
		<cfoutput>
		  <table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				
					<td colspan="7"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong><cfif url.trantype eq "top">TOP CATEGORY PRODUCT SALES REPORT<cfelse>BOTTOM CATEGORY PRODUCT SALES REPORT</cfif></strong></font></div></td>
				
			</tr>
            <cfif form.custfrom neq "" and form.custto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">Customer: <cfif lcase(HcomID) eq "hyray_i">#getcustname.name#<cfelse>#form.custfrom# - #form.custto#</cfif></font></div></td>
				</tr>
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">TEAM: #form.teamfrom# - #form.teamto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="7"><hr></td>
			</tr>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NO</font></div></td>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY SOLD</font></div></td>
				<td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SALES</font></div></td>
			</tr>
			<tr>
				<td colspan="7"><hr></td>
			</tr>
			<cfloop query="getcategory">
            <cfset subqty=0>
            <cfset subamt=0>
            <tr>
            <td><div align="left"><font size="3" face="Times New Roman, Times, serif"><b><u>#category#</u></b></font></div></td>
            <cfquery name="getcatedesp" datasource="#dts#">
            select desp from iccate where cate='#getcategory.category#'
            </cfquery>
            <td colspan="3"><div align="left"><font size="3" face="Times New Roman, Times, serif"><b><u>#getcatedesp.desp#</u></b></font></div></td>
            </tr>

            
            <cfif lcase(HcomID) eq "hyray_i">
            <cfquery name="getitem" datasource="#dts#">
			select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as sumqty,aa.itemno,aa.desp,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as sumamt from
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
             and a.custno = '#form.custfrom#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as aa left join
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (type = 'INV' or type = 'DN' or type = 'CS')  and (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
             and a.custno = '#form.custfrom#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as bb on aa.itemno=bb.itemno left join
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (type = 'CN')  and (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
             and a.custno = '#form.custfrom#'
           
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
            <cfelse>
            and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as cc on aa.itemno = cc.itemno
            
            group by aa.itemno
            <cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
		</cfquery>
        
        <cfelse>
        <cfquery name="getitem" datasource="#dts#">
			select itemno, desp, sum(qty) as sumqty, sum(amt) as sumamt from ictran
			where (type = 'INV' or type = 'DN' or type = 'CS') and (void = '' or void is null)
            <cfif form.custfrom neq "" and form.custto neq "">
             
            and custno >= '#form.custfrom#' and custno <= '#form.custto#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
            <cfelse>
            and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent#  where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            and category='#getcategory.category#'
			group by itemno
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
		</cfquery>
        </cfif>
				<cfloop query="getitem">
                <cfif getitem.sumqty neq 0>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
						<td></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
						<cfset totalqty = totalqty + val(getitem.sumqty)>
                        <cfset subqty= subqty+val(getitem.sumqty)>
           
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumqty),"0")#</font></div></td>
						<td></td>
						<cfset totalamt = totalamt + val(getitem.sumamt)>
                         <cfset subamt= subamt+val(getitem.sumamt)>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumamt),stDecl_UPrice)#</font></div></td>
					</tr>
                    </cfif>
				</cfloop>

            <tr>
            <td colspan="100%">
            <hr>
            </td>
            </tr>
            <tr>
            <td colspan="4">&nbsp;</td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(subqty,"0")#</strong></font></div></td>
            <td></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(subamt,",___.__")#</strong></font></div></td>
            </tr>
            </cfloop>
			<tr>
				<td colspan="7"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,"0")#</strong></font></div></td>
				<td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalamt,",___.__")#</strong></font></div></td>
			</tr>
		</table>

		<cfif getcategory.recordcount eq 0>
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