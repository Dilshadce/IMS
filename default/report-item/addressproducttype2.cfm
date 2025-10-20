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

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = "">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "0">
	</cfloop>

	<cfquery name="getcustomer" datasource="#dts#">
		select 
		a.custno,
		a.name,a.frem0,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,a.rem1,a.comm0,a.comm1,a.comm2,a.comm3,a.comm4
		from artran as a
		
		left join 
		(
			select 
			type,
			refno,
			itemno 
			from ictran 
			where type in ('INV','CS','DN','CN') 
			and (void = '' or void is null)
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
            
            <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
			and area between '#form.areafrom#' and '#form.areato#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date between '#ndatefrom#' and '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif> 
			group by type,refno,itemno 
			order by itemno
		) as b on a.type=b.type and a.refno=b.refno
		
		left join 
		(
			select 
			itemno 
			from icitem 
			where itemno=itemno 
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
		) as c on b.itemno=c.itemno

		where a.type in ('INV','CS','DN','CN') 
		and (a.void = '' or a.void is null)
        and c.itemno is not null
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
		</cfif>
        
        <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
        
		<cfif form.areafrom neq "" and form.areato neq "">
		and a.area between '#form.areafrom#' and '#form.areato#'
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and a.wos_date between '#ndatefrom#' and '#ndateto#'
		<cfelse>
		and a.wos_date > #getgeneral.lastaccyear#
		</cfif>
       
		<cfif form.addressfrom neq "" and form.addressto neq "">
		and a.rem1 between '#form.addressfrom#' and '#form.addressto#'
		</cfif>
        <cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			and a.custno between '#form.custfrom#' and '#form.custto#'
		</cfif>
		group by a.custno,a.rem1
		order by a.custno;
	</cfquery>

	<cfxml variable="data">
	<?xml version="1.0"?>
	<?mso-application progid="Excel.Sheet"?>
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:html="http://www.w3.org/TR/REC-html40">
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
	<Style ss:ID="s28">
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s29">
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s30">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s31">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s32">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s33">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s34">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
	</Style>
	<Style ss:ID="s35">
	<NumberFormat ss:Format="0"/>
	</Style>
	<Style ss:ID="s36">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
	</Style>
	<Style ss:ID="s37">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
	</Style>
	</Styles>
	<Worksheet ss:Name="ITEM SALES REPORT BY TYPE">
	<cfoutput>
    <cfif isdefined('form.foc')>
    <cfset columncount = 10>
    <cfset rowcom = 8>
    <cfset comcom = 7>
    <cfelse>
    <cfset columncount = 9>
    <cfset rowcom = 7>
    <cfset comcom = 6>
	</cfif>
	<Table ss:ExpandedColumnCount="#columncount#" x:FullColumns="1" x:FullRows="1">
	<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="5"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s22"><Data ss:Type="String">#trantype# REPORT</Data></Cell>
	</Row>

	<cfif form.periodfrom neq "" and form.periodto neq "">
		<cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<cfwddx action = "cfml2wddx" input = "DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		<cfwddx action = "cfml2wddx" input = "AGENT: #form.agentfrom# - #form.agentto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.areafrom neq "" and form.areato neq "">
		<cfwddx action = "cfml2wddx" input = "AREA: #form.areafrom# - #form.areato#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<cfwddx action = "cfml2wddx" input = "ITEM_NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
    	<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
		<Cell ss:MergeAcross="#comcom#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM NO.</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">DESCRIPTION</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">QTY SOLD</Data></Cell>
		<cfif isdefined('form.foc')>
        <Cell ss:StyleID="s27"><Data ss:Type="String">QTY FOC</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s27"><Data ss:Type="String">INV</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">DN</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">CS</Data></Cell>
        
		<Cell ss:StyleID="s27"><Data ss:Type="String">TOTAL</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">CN</Data></Cell>
	</Row>

	<cfset totalinv = 0>
	<cfset totalcs = 0>
	<cfset totaldn = 0>
	<cfset totalcn = 0>
	<cfset totalqty = 0>
    <cfset total_foc_qty = 0>
	<cfset total = 0>

	<cfloop query="getcustomer">
    <cfquery name="getdeladd" datasource="#dts#">
            select refno from artran where type in ('INV','CS','DN','CN') and custno='#getcustomer.custno#' and rem1='#getcustomer.rem1#'
            </cfquery>
            
            <cfset deladdlist=valuelist(getdeladd.refno)>
		<cfset subinv = 0>
		<cfset subcs = 0>
		<cfset subdn = 0>
		<cfset subcn = 0>
		<cfset subqty = 0>
		<cfset subtotal = 0>
        <cfset subfocqty = 0>
		
        <cfquery name="getdeladd" datasource="#dts#">
            select refno from artran where type in ('INV','CS','DN','CN') and custno='#getcustomer.custno#' and rem1='#getcustomer.rem1#'
            </cfquery>
        
		<cfwddx action = "cfml2wddx" input = "#getcustomer.custno#" output = "wddxText1">
		<cfwddx action = "cfml2wddx" input = "#getcustomer.name#" output = "wddxText2">
		<cfwddx action = "cfml2wddx" input = "#getcustomer.comm0##getcustomer.comm1##getcustomer.comm2##getcustomer.comm3#" output = "wddxText3">
		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText1#</Data></Cell>
			<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText2#</Data></Cell>
            <Cell ss:StyleID="s29"/>
            <cfif isdefined('form.foc')>
			<Cell ss:StyleID="s29"/>
            </cfif>
			<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText3#</Data></Cell>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>

		<cfquery name="getitem" datasource="#dts#">
				select 
				a.itemno,
                a.category,
				aa.desp,
				b.inv_qty,
				b.inv_amt,
				c.cs_qty,
				c.cs_amt,
				d.dn_qty,
				d.dn_amt,
				e.cn_qty,
				e.cn_amt
                <cfif isdefined('form.foc')>
                ,f.foc_qty
                </cfif>
				from ictran  as a
				
				left join 
				(
					select 
					itemno,
					desp 
					from icitem 
					where itemno=itemno
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between '#form.groupfrom#' and '#form.groupto#'
					</cfif>
					<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					order by itemno
				) as aa on aa.itemno=a.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as inv_qty,
					sum(amt) as inv_amt 
					from ictran 
					where type='INV' 
					and custno='#getcustomer.custno#' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as b on a.itemno=b.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as cs_qty,
					sum(amt) as cs_amt 
					from ictran 
					where type='CS' 
					and custno='#getcustomer.custno#' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as c on a.itemno=c.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as dn_qty,
					sum(amt) as dn_amt 
					from ictran 
					where type='DN' 
					and custno='#getcustomer.custno#' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as d on a.itemno=d.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as cn_qty,
					sum(amt) as cn_amt 
					from ictran 
					where type='CN' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and custno='#getcustomer.custno#' 
					and (void = '' or void is null)
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as e on a.itemno=e.itemno
                
                 <cfif isdefined('form.foc')>
            left join
			(
				select 
				itemno,
				sum(qty) as foc_qty
				from ictran 
				where type in ('INV','CS','DN') 
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
				and custno='#getcustomer.custno#' 
				and (void = '' or void is null)
                and FOC = "Y"
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
                <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear# 
				</cfif>
                <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
				group by itemno 
				order by itemno
			) as f on a.itemno=f.itemno
			</cfif>
				where a.type in ('INV','CS','DN','CN') 
				and a.custno='#getcustomer.custno#' 
                and a.refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
				and (a.void = '' or a.void is null)
                and aa.desp is not null
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
                <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and a.category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear# 
				</cfif>
                <cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
				group by a.itemno
				order by a.itemno;
			</cfquery>

		<cfloop query="getitem">
			<cfset inv = 0>
			<cfset dn = 0>
			<cfset cs = 0>
			<cfset cn = 0>
			<cfset qty = 0>
			<cfset amt = 0>
            <cfif isdefined('form.foc')>
            <cfset foc_qty1 = val(getitem.foc_qty)>
            <cfset subfocqty = subfocqty + val(foc_qty1)>
			<cfset total_foc_qty = total_foc_qty + foc_qty1>
			</cfif>
			<cfset qty = qty + val(getitem.inv_qty)+ val(getitem.dn_qty)+ val(getitem.cs_qty)+ val(getitem.cn_qty)>
            
			<cfset inv = val(getitem.inv_amt)>
			<cfset subinv = subinv + inv>
			<cfset totalinv = totalinv + inv>
			<cfset dn = val(getitem.dn_amt)>
			<cfset subdn = subdn + dn>
			<cfset totaldn = totaldn + dn>
			<cfset cs = val(getitem.cs_amt)>
			<cfset subcs = subcs + cs>
			<cfset totalcs = totalcs + cs>
			<cfset cn = val(getitem.cn_amt)>
			<cfset subcn = subcn + cn>
			<cfset totalcn = totalcn + cn>
			<cfset subqty = subqty + qty>
			<cfset totalqty = totalqty + qty>
			<cfset amt = inv + dn + cs>
			<cfset total = total + amt>

			<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
				<Cell ss:StyleID="s35"><Data ss:Type="Number">#qty#</Data></Cell>
                <cfif isdefined('form.foc')>
                <Cell ss:StyleID="s35"><Data ss:Type="Number">#foc_qty#</Data></Cell>
				</cfif>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#inv#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#dn#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#cs#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#amt#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#cn#</Data></Cell>
			</Row>
		</cfloop>
		<cfset subtotal = subtotal + subinv + subdn + subcs>
		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s30"><Data ss:Type="String">SUB-TOTAL</Data></Cell>
			<Cell ss:StyleID="s30"/>
			<Cell ss:StyleID="s36"><Data ss:Type="Number">#subqty#</Data></Cell>
            <cfif isdefined('form.foc')>
                <Cell ss:StyleID="s36"><Data ss:Type="Number">#subfocqty#</Data></Cell>
				</cfif>
			<Cell ss:StyleID="s31"><Data ss:Type="Number">#subinv#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="Number">#subdn#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="Number">#subcs#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="Number">#subtotal#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="Number">#subcn#</Data></Cell>
		</Row>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</cfloop>
	<Row ss:AutoFitHeight="0" ss:Height="12">
		<Cell ss:StyleID="s32"><Data ss:Type="String">TOTAL</Data></Cell>
		<Cell ss:StyleID="s32"/>
		<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalqty#</Data></Cell>
        <cfif isdefined('form.foc')>
        <Cell ss:StyleID="s37"><Data ss:Type="Number">#total_foc_qty#</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totalinv#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totaldn#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totalcs#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#total#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totalcn#</Data></Cell>
	</Row>
	</Table>
	</cfoutput>
	<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
	<Unsynced/>
	<Print>
	<ValidPrinterInfo/>
	<HorizontalResolution>600</HorizontalResolution>
	<VerticalResolution>600</VerticalResolution>
	</Print>
	<Selected/>
	<Panes>
	<Pane>
	<Number>3</Number>
	<ActiveRow>12</ActiveRow>
	<ActiveCol>1</ActiveCol>
	</Pane>
	</Panes>
	<ProtectObjects>False</ProtectObjects>
	<ProtectScenarios>False</ProtectScenarios>
	</WorksheetOptions>
	</Worksheet>
	</Workbook>
	</cfxml>

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls" output="#tostring(data)#" >
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls">
<!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls">
--->
	</cfcase>

	<cfcase value="HTML">
	<html>
	<head>
	<title>Cust/Supp/Agent/Area Item Report</title>
	<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	</head>

	<body>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",___.">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "_">
	</cfloop>

	<cfquery name="getcustomer" datasource="#dts#">
		select 
		a.custno,a.name,a.frem0,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,a.rem1,a.comm0,a.comm1,a.comm2,a.comm3,a.comm4,
		a.name
		from artran as a
		
		left join 
		(
			select 
			type,
			refno,
			itemno 
			from ictran 
			where type in ('INV','CS','DN','CN') 
			and (void = '' or void is null)
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
            
            <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
			and area between '#form.areafrom#' and '#form.areato#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date between '#ndatefrom#' and '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif> 
			group by type,refno,itemno
			order by custno,itemno
		) as b on a.type=b.type and a.refno=b.refno
		
		left join 
		(
			select 
			itemno 
			from icitem 
			where itemno=itemno 
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
		) as c on b.itemno=c.itemno

		where a.type in ('INV','CS','DN','CN') 
		and (a.void = '' or a.void is null)
        and c.itemno is not null
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
		</cfif>
        
        <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
                        
		<cfif form.areafrom neq "" and form.areato neq "">
		and a.area between '#form.areafrom#' and '#form.areato#'
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and a.wos_date between '#ndatefrom#' and '#ndateto#'
		<cfelse>
		and a.wos_date > #getgeneral.lastaccyear#
		</cfif>
      
        <cfif form.addressfrom neq "" and form.addressto neq "">
		and a.rem1 between '#form.addressfrom#' and '#form.addressto#'
		</cfif>
        <cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			and a.custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		group by a.custno,a.rem1
		order by a.custno;
	</cfquery>
	
	<cfoutput>
    <cfif isdefined('form.foc')>
    <cfset columncount = 10>
    <cfset rowcom = 8>
    <cfset comcom = 4>
    <cfelse>
    <cfset columncount = 9>
    <cfset rowcom = 7>
    <cfset comcom = 3>
    </cfif>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="#columncount#"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# REPORT</strong></font></div></td>
		</tr>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
			</tr>
		</cfif>
		<cfif form.agentfrom neq "" and form.agentto neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.areafrom neq "" and form.areato neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM_NO: #form.itemfrom# - #form.itemto#</font></div></td>
			</tr>
		</cfif>
        
		<tr>
			<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="#comcom#"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">CATEGORY</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY SOLD</font></div></td>
            <cfif isdefined('form.foc')>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY FOC</font></div></td>
			</cfif>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">INV</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CS</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CN</font></div></td>
		</tr>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>

		<cfset totalinv = 0>
		<cfset totalcs = 0>
		<cfset totaldn = 0>
		<cfset totalcn = 0>
		<cfset totalqty = 0>
        <cfset total_foc_qty = 0>
		<cfset total = 0>

		<cfloop query="getcustomer">
			<cfset subinv = 0>
			<cfset subcs = 0>
			<cfset subdn = 0>
			<cfset subcn = 0>
			<cfset subqty = 0>
			<cfset subtotal = 0>
            <cfset subfocqty = 0>
			<cfquery name="getdeladd" datasource="#dts#">
            select refno from artran where type in ('INV','CS','DN','CN') and custno='#getcustomer.custno#' and rem1='#getcustomer.rem1#'
            </cfquery>
            
            <cfset deladdlist=valuelist(getdeladd.refno)>
			<tr>
				<td><div align="left"><strong><u>#getcustomer.custno#</u></strong></div></td>
				<td><div align="left"><strong><u>#getcustomer.name#</u></strong></div></td>
                <td><div align="left"><strong><u>#getcustomer.comm0##getcustomer.comm1##getcustomer.comm2##getcustomer.comm3#</u></strong></div></td>
			</tr>

			<cfquery name="getitem" datasource="#dts#">
				select 
				a.itemno,
                a.category,
				aa.desp,
				b.inv_qty,
				b.inv_amt,
				c.cs_qty,
				c.cs_amt,
				d.dn_qty,
				d.dn_amt,
				e.cn_qty,
				e.cn_amt
                <cfif isdefined('form.foc')>
                ,f.foc_qty
                </cfif>
				from ictran  as a
				
				left join 
				(
					select 
					itemno,
					desp 
					from icitem 
					where itemno=itemno
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between '#form.groupfrom#' and '#form.groupto#'
					</cfif>
					<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					order by itemno
				) as aa on aa.itemno=a.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as inv_qty,
					sum(amt) as inv_amt 
					from ictran 
					where type='INV' 
					and custno='#getcustomer.custno#' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as b on a.itemno=b.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as cs_qty,
					sum(amt) as cs_amt 
					from ictran 
					where type='CS' 
					and custno='#getcustomer.custno#' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as c on a.itemno=c.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as dn_qty,
					sum(amt) as dn_amt 
					from ictran 
					where type='DN' 
					and custno='#getcustomer.custno#' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as d on a.itemno=d.itemno
				
				left join
				(
					select 
					itemno,
					sum(qty) as cn_qty,
					sum(amt) as cn_amt 
					from ictran 
					where type='CN' 
                    and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
					and custno='#getcustomer.custno#' 
					and (void = '' or void is null)
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
					group by itemno 
					order by itemno
				) as e on a.itemno=e.itemno
                
                 <cfif isdefined('form.foc')>
            left join
			(
				select 
				itemno,
				sum(qty) as foc_qty
				from ictran 
				where type in ('INV','CS','DN') 
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
				and custno='#getcustomer.custno#' 
				and (void = '' or void is null)
                and FOC = "Y"
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
                <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear# 
				</cfif>
                <cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
				group by itemno 
				order by itemno
			) as f on a.itemno=f.itemno
			</cfif>
				where a.type in ('INV','CS','DN','CN') 
				and a.custno='#getcustomer.custno#' 
                and a.refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#deladdlist#">)
				and (a.void = '' or a.void is null)
                and aa.desp is not null
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
                <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and a.category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear# 
				</cfif>
                <cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
				group by a.itemno
				order by a.itemno;
			</cfquery>

			<cfloop query="getitem">
				<cfset inv = 0>
				<cfset dn = 0>
				<cfset cs = 0>
				<cfset cn = 0>
				<cfset qty = 0>
				<cfset amt = 0>
				<cfset qty = qty + val(getitem.inv_qty)+ val(getitem.dn_qty)+ val(getitem.cs_qty)+ val(getitem.cn_qty)>
                <cfif isdefined('form.foc')>
				<cfset foc_qty1 = val(getitem.foc_qty)>
                <cfset subfocqty = subfocqty + val(foc_qty1)>
                <cfset total_foc_qty = total_foc_qty + foc_qty1>
                </cfif>
				<cfset inv = val(getitem.inv_amt)>
				<cfset subinv = subinv + inv>
				<cfset totalinv = totalinv + inv>
				<cfset dn = val(getitem.dn_amt)>
				<cfset subdn = subdn + dn>
				<cfset totaldn = totaldn + dn>
				<cfset cs = val(getitem.cs_amt)>
				<cfset subcs = subcs + cs>
				<cfset totalcs = totalcs + cs>
				<cfset cn = val(getitem.cn_amt)>
				<cfset subcn = subcn + cn>
				<cfset totalcn = totalcn + cn>
				<cfset subqty = subqty + qty>
				<cfset totalqty = totalqty + qty>
				<cfset amt = inv + dn + cs>
				<cfset total = total + amt>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.category#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qty#</font></div></td>
					<cfif isdefined('form.foc')>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#foc_qty1#</font></div></td>
					</cfif>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(inv,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(dn,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(cs,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(amt,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(cn,stDecl_UPrice)#</font></div></td>
				 </tr>
				 <cfflush>
			</cfloop>
			<cfset subtotal = subtotal + subinv + subdn + subcs>
			<tr>
				<td colspan="#columncount#"><hr></td>
			</tr>
			<tr>
				<td><div align="right"></div></td>
                <td><div align="right"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">SUB_TOTAL:</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subqty,"0")#</font></div></td>
				
                <cfif isdefined('form.foc')>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subfocqty,"0")#</font></div></td>
				</cfif>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subinv,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subdn,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subcs,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subcn,stDecl_UPrice)#</font></div></td>
			</tr>
			<tr><td><br></td></tr>
			<cfflush>
		</cfloop>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
		<tr>
			<td><div align="right"></div></td>
            <td><div align="right"></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,"0")#</strong></font></div></td>
            <cfif isdefined('form.foc')>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total_foc_qty,"0")#</strong></font></div></td>
            </cfif>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalinv,",___.__")#</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totaldn,",___.__")#</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcs,",___.__")#</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total,",___.__")#</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcn,",___.__")#</strong></font></div></td>
		</tr>
	  </table>
	</cfoutput>

	<cfif getcustomer.recordcount eq 0>
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