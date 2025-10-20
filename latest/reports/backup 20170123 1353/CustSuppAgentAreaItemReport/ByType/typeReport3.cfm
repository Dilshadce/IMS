<cfquery name="getgeneral" datasource="#dts#">
	select 
	compro,
	lastaccyear ,agentlistuserid
	from gsetup;
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select 
	decl_uprice 
	from gsetup2;
</cfquery>

<cfquery name="getagent" datasource="#dts#">
	select 
	a.agenno,
	b.desp 
	from ictran a 
	left join 
	(
		select 
		agent,
		desp 
		from icagent 
		order by agent
	) as b on a.agenno=b.agent 
	where a.type in ('INV','CS','CN','DN') 
	<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
	and a.custno between '#form.customerfrom#' and '#form.customerto#'
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
	and a.wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
	and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
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
    
	<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
	and a.category between '#form.categoryfrom#' and '#form.categoryto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif form.areafrom neq "" and form.areato neq "">
	and a.area between '#form.areafrom#' and '#form.areato#'
	</cfif>
	group by a.agenno 
	order by a.agenno;
</cfquery>

<cfparam name="gqty" default="0" type="numeric">
<cfparam name="ginv" default="0" type="numeric">
<cfparam name="total_foc_qty" default="0" type="numeric">
<cfparam name="gcs" default="0" type="numeric">
<cfparam name="gdn" default="0" type="numeric">
<cfparam name="gtotal" default="0" type="numeric">
<cfparam name="gcn" default="0" type="numeric">

<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">
		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = "">
	
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "0">
		</cfloop>
		
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
		<Style ss:ID="s24">
		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		<Borders>
		<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		</Borders>
		</Style>
		<Style ss:ID="s26">
		<NumberFormat ss:Format="@"/>
		</Style>
		<Style ss:ID="s27">
		<NumberFormat ss:Format="#,###,###,##0"/>
		</Style>
		<Style ss:ID="s28">
		<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		</Style>
		<Style ss:ID="s29">
		<Borders>
		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		</Borders>
		<NumberFormat ss:Format="@"/>
		</Style>
		<Style ss:ID="s30">
		<Borders>
		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		</Borders>
		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		</Style>
		<Style ss:ID="s31">
		<Borders>
		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		</Borders>
		<NumberFormat ss:Format="#,###,###,##0"/>
		</Style>
		<Style ss:ID="s32">
		<Borders>
		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		</Borders>
		<NumberFormat ss:Format="#,###,###,##0"/>
		</Style>
		<Style ss:ID="s33">
		<Borders>
		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		</Borders>
		<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		</Style>
		<Style ss:ID="s34">
		<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		</Style>
		<Style ss:ID="s35">
		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		</Style>
		<Style ss:ID="s36">
		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		</Style>
		<Style ss:ID="s38">
		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"
		ss:Underline="Single"/>
		</Style>
		<Style ss:ID="s39">
		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		<Borders>
		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		</Borders>
		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		</Style>
		<Style ss:ID="s41">
		<Alignment ss:Vertical="Center"/>
		<Borders>
		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		</Borders>
		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		</Style>
		</Styles>
		<Worksheet ss:Name="Sheet1">
		<cfoutput>
		<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="5"/>
		
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s35"><Data ss:Type="String">Agent Product Sales Report</Data></Cell>
		</Row>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<cfwddx action = "cfml2wddx" input = "DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.agentfrom neq "" and form.agentto neq "">
			<cfwddx action = "cfml2wddx" input = "AGENT: #form.agentfrom# - #form.agentto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.areafrom neq "" and form.areato neq "">
			<cfwddx action = "cfml2wddx" input = "AREA: #form.areafrom# - #form.areato#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			<cfwddx action = "cfml2wddx" input = "CUST_NO: #form.customerfrom# - #form.customerto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.categoryfrom# - #form.categoryto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<cfwddx action = "cfml2wddx" input = "PRODUCT_NO: #form.productfrom# - #form.productto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="7" ss:StyleID="s36"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
	
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="6" ss:StyleID="s39"><Data ss:Type="String">#getgeneral.compro#</Data></Cell>
			<Cell ss:StyleID="s41"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
		</Row>
	
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s24"><Data ss:Type="String">Product No.</Data></Cell>
		<Cell ss:StyleID="s24"><Data ss:Type="String">Description</Data></Cell>
		<Cell ss:StyleID="s24"><Data ss:Type="String">Qty Sold</Data></Cell>
        <cfif isdefined('form.foc')>
        <Cell ss:StyleID="s24"><Data ss:Type="String">Qty FOC</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s24"><Data ss:Type="String">INV</Data></Cell>
		<Cell ss:StyleID="s24"><Data ss:Type="String">CS</Data></Cell>
		<Cell ss:StyleID="s24"><Data ss:Type="String">DN</Data></Cell>
		<Cell ss:StyleID="s24"><Data ss:Type="String">Total</Data></Cell>
		<Cell ss:StyleID="s24"><Data ss:Type="String">CN</Data></Cell>
		</Row>
		
		<cfloop query="getagent">
			<cfquery name="getcontent" datasource="#dts#">
				select 
				a.agenno,
				a.itemno,
				a.desp,
				ifnull(g.sumqty,0) as qty,
				
				ifnull(b.invamt,0) as invamt,
				ifnull(c.csamt,0) as csamt,
				ifnull(d.dnamt,0) as dnamt,
				ifnull(e.cnamt,0) as cnamt
                <cfif isdefined('form.foc')>
                ,f.foc_qty
                </cfif>
				from ictran a 
				
				left join
				(
					select 
					itemno,
					sum(amt) as invamt 
					from ictran 
					where type='INV' 
					and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#' 
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
					and custno between '#form.customerfrom#' and '#form.customerto#' 
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#' 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#' 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and category between '#form.categoryfrom#' and '#form.categoryto#' 
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between '#form.groupfrom#' and '#form.groupto#' 
					</cfif>
					<cfif form.areafrom neq "" and form.areato neq "">
					and area between '#form.areafrom#' and '#form.areato#' 
					</cfif>
					group by itemno
					order by itemno
				) as b on a.itemno=b.itemno
				
				left join
				(
					select 
					itemno,
					sum(amt) as csamt 
					from ictran 
					where type='CS' 
					and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
					and custno between '#form.customerfrom#' and '#form.customerto#' 
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#' 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#' 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and category between '#form.categoryfrom#' and '#form.categoryto#' 
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between '#form.groupfrom#' and '#form.groupto#' 
					</cfif>
					<cfif form.areafrom neq "" and form.areato neq "">
					and area between '#form.areafrom#' and '#form.areato#' 
					</cfif>
					group by itemno
					order by itemno
				) as c on a.itemno=c.itemno
				
				left join
				(
					select 
					itemno,
					sum(amt) as dnamt 
					from ictran 
					where type='DN' 
					and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif form.customerfrom neq "" and form.customerto neq "">
					and custno between '#form.customerfrom#' and '#form.customerto#' 
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#' 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#' 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and category between '#form.categoryfrom#' and '#form.categoryto#' 
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between '#form.groupfrom#' and '#form.groupto#' 
					</cfif>
					<cfif form.areafrom neq "" and form.areato neq "">
					and area between '#form.areafrom#' and '#form.areato#' 
					</cfif>
					group by itemno
					order by itemno
				) as d on a.itemno=d.itemno
				
				left join
				(
					select 
					itemno,
					sum(amt) as cnamt 
					from ictran 
					where type='CN' 
					and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
					<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
					and custno between '#form.customerfrom#' and '#form.customerto#' 
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#' 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#' 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and category between '#form.categoryfrom#' and '#form.categoryto#' 
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between '#form.groupfrom#' and '#form.groupto#' 
					</cfif>
					<cfif form.areafrom neq "" and form.areato neq "">
					and area between '#form.areafrom#' and '#form.areato#' 
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
				and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
				and (void = '' or void is null)
                and FOC = "Y"
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
                <cfif form.customerfrom neq "" and form.customerto neq "">
					and custno between '#form.customerfrom#' and '#form.customerto#' 
					</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear# 
				</cfif>
				group by itemno 
				order by itemno
			) as f on a.itemno=f.itemno
			</cfif>
                left join
					(
						select 
						itemno,
						sum(qty) as sumqty 
						from ictran 
						where (type='INV' or type='DN' or type='CN' or type='CS')
						and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#' 
                        <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
						<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
						and custno between '#form.customerfrom#' and '#form.customerto#' 
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod between '#form.periodfrom#' and '#form.periodto#' 
						</cfif>
						<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#' 
						</cfif>
						<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#' 
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and wos_group between '#form.groupfrom#' and '#form.groupto#' 
						</cfif>
						<cfif form.areafrom neq "" and form.areato neq "">
						and area between '#form.areafrom#' and '#form.areato#' 
						</cfif>
						group by itemno
						order by itemno
					) as g on a.itemno=g.itemno
                
				where a.type in ('INV','CS','CN','DN') 
				and a.agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and a.custno between '#form.customerfrom#' and '#form.customerto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and a.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				<cfif form.areafrom neq "" and form.areato neq "">
				and a.area between '#form.areafrom#' and '#form.areato#'
				</cfif>
				group by itemno
				order by itemno;
			</cfquery>
			
			<cfwddx action = "cfml2wddx" input = "AGENT: #getagent.desp#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="15">
			<Cell ss:MergeAcross="7" ss:StyleID="s38"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		
			<cfset sqty = 0>
			<cfset sinv = 0>
			<cfset scs = 0>
			<cfset sdn = 0>
			<cfset scn = 0>
			<cfset stotal = 0>
            <cfset subfocqty = 0>
				
			<cfloop query="getcontent">
				<cfset sqty = sqty + getcontent.qty>
				<cfset sinv = sinv + getcontent.invamt>
				<cfset scs = scs + getcontent.csamt>
				<cfset scn = scn + getcontent.cnamt>
				<cfset sdn = sdn + getcontent.dnamt>
				<cfset stotal = stotal + (getcontent.invamt+getcontent.csamt+getcontent.dnamt)>
				<cfset gqty = gqty + getcontent.qty>
				<cfset ginv = ginv + getcontent.invamt>
				<cfset gcs = gcs + getcontent.csamt>
				<cfset gcn = gcn + getcontent.cnamt>
				<cfset gdn = gdn + getcontent.dnamt>
				<cfset gtotal = gtotal + (getcontent.invamt+getcontent.csamt+getcontent.dnamt)>
                <cfif isdefined('form.foc')>
				<cfset foc_qty1 = val(getcontent.foc_qty)>
                <cfset subfocqty = subfocqty + val(foc_qty1)>
                <cfset total_foc_qty = total_foc_qty + foc_qty1>
                </cfif>
					
			<cfwddx action = "cfml2wddx" input = "#getcontent.itemno#" output = "wddxText">
			<cfwddx action = "cfml2wddx" input = "#getcontent.desp#" output = "wddxText2">
			<Row>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
			<Cell ss:StyleID="s27"><Data ss:Type="Number">#getcontent.qty#</Data></Cell>
            <cfif isdefined('form.foc')>
            <Cell ss:StyleID="s28"><Data ss:Type="Number">#getcontent.foc_qty#</Data></Cell>
            </cfif>
			<Cell ss:StyleID="s28"><Data ss:Type="Number">#getcontent.invamt#</Data></Cell>
			<Cell ss:StyleID="s28"><Data ss:Type="Number">#getcontent.csamt#</Data></Cell>
			<Cell ss:StyleID="s28"><Data ss:Type="Number">#getcontent.dnamt#</Data></Cell>
			<Cell ss:StyleID="s28"><Data ss:Type="Number">#(getcontent.invamt+getcontent.csamt+getcontent.dnamt)#</Data></Cell>
			<Cell ss:StyleID="s28"><Data ss:Type="Number">#getcontent.cnamt#</Data></Cell>
			</Row>
			</cfloop>
	
			<Row ss:Height="12">
			<Cell ss:StyleID="s30"/>
			<Cell ss:StyleID="s30"/>
			<Cell ss:Index="3" ss:StyleID="s31"><Data ss:Type="Number">#sqty#</Data></Cell>
            <cfif isdefined('form.foc')>
            <Cell ss:StyleID="s31"><Data ss:Type="Number">#subfocqty#</Data></Cell>
            </cfif>
			<Cell ss:StyleID="s33"><Data ss:Type="Number">#sinv#</Data></Cell>
			<Cell ss:StyleID="s33"><Data ss:Type="Number">#scs#</Data></Cell>
			<Cell ss:StyleID="s33"><Data ss:Type="Number">#sdn#</Data></Cell>
			<Cell ss:StyleID="s33"><Data ss:Type="Number">#stotal#</Data></Cell>
			<Cell ss:StyleID="s33"><Data ss:Type="Number">#scn#</Data></Cell>
			</Row>
			<Row ss:Height="12"/>
		</cfloop>
		
		<Row ss:Height="12"/>
		<Row ss:Height="12">
		<Cell ss:StyleID="s30"/>
		<Cell ss:StyleID="s30"><Data ss:Type="String">Grand Total</Data></Cell>
		<Cell ss:StyleID="s31"><Data ss:Type="Number">#gqty#</Data></Cell>
        <cfif isdefined('form.foc')>
        <Cell ss:StyleID="s31"><Data ss:Type="Number">#total_foc_qty#</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#ginv#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#gcs#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#gdn#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#gtotal#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#gcn#</Data></Cell>
		</Row>
		<Row ss:Height="12"/>
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
	
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_CSAAIR_APS_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#HRootPath#\Excel_Report\#dts#_CSAAIR_APS_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_CSAAIR_APS_#huserid#.xls">
	</cfcase>

	<cfcase value="HTML">
		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">
	
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>
		
		<html>
		<head>
		<title>Report - Agent Product Sales Report</title>
		<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>
			
		<body>
		<cfoutput>
		<table width="100%" border="0" cellspacing="2" cellpadding="0">
			<tr>
				<td colspan="8" class="title"><div align="center">Agent Product Sales Report</div></td>
			</tr>
			
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">DATE: #lsdateformat(form.datefrom,"dd/mm/yyyy")# - #lsdateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">CUST_NO: #form.customerfrom# - #form.customerto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">CATEGORY: #form.categoryfrom# - #form.categoryto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">PRODUCT_NO: #form.productfrom# - #form.productto#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="2"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr><td colspan="9"><hr></td></tr>
			<tr>
				<th align="left" width="10%"><font size="2" face="Times New Roman,Times,serif">PRODUCT NO.</font></th>
				<th align="left" width="32%"><font size="2" face="Times New Roman,Times,serif">DESCRIPTION</font></th>
				<th width="8%"><font size="2" face="Times New Roman,Times,serif">QTY SOLD</font></th>
                <cfif isdefined('form.foc')>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY FOC</font></div></td>
				</cfif>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">INV</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">CS</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">DN</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">TOTAL</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">CN</font></th>
			</tr>
			<tr><td colspan="9"><hr></td></tr>
			
			<cfloop query="getagent">
				<cfquery name="getcontent" datasource="#dts#">
					select 
					a.agenno,
					a.itemno,
					a.desp,
					ifnull(g.sumqty,0) as qty,
					
					ifnull(b.invamt,0) as invamt,
					ifnull(c.csamt,0) as csamt,
					ifnull(d.dnamt,0) as dnamt,
					ifnull(e.cnamt,0) as cnamt
                    <cfif isdefined('form.foc')>
           			,f.foc_qty
            		</cfif>
					from ictran a 
					
					left join
					(
						select 
						itemno,
						sum(amt) as invamt 
						from ictran 
						where type='INV' 
						and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#' 
                        <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
						<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
						and custno between '#form.customerfrom#' and '#form.customerto#' 
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod between '#form.periodfrom#' and '#form.periodto#' 
						</cfif>
						<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#' 
						</cfif>
						<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#' 
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and wos_group between '#form.groupfrom#' and '#form.groupto#' 
						</cfif>
						<cfif form.areafrom neq "" and form.areato neq "">
						and area between '#form.areafrom#' and '#form.areato#' 
						</cfif>
						group by itemno
						order by itemno
					) as b on a.itemno=b.itemno
					
					left join
					(
						select 
						itemno,
						sum(amt) as csamt 
						from ictran 
						where type='CS' 
						and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
                        <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
						<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
						and custno between '#form.customerfrom#' and '#form.customerto#' 
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod between '#form.periodfrom#' and '#form.periodto#' 
						</cfif>
						<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#' 
						</cfif>
						<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#' 
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and wos_group between '#form.groupfrom#' and '#form.groupto#' 
						</cfif>
						<cfif form.areafrom neq "" and form.areato neq "">
						and area between '#form.areafrom#' and '#form.areato#' 
						</cfif>
						group by itemno
						order by itemno
					) as c on a.itemno=c.itemno
					
					left join
					(
						select 
						itemno,
						sum(amt) as dnamt 
						from ictran 
						where type='DN' 
						and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
                        <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
						<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
						and custno between '#form.customerfrom#' and '#form.customerto#' 
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod between '#form.periodfrom#' and '#form.periodto#' 
						</cfif>
						<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#' 
						</cfif>
						<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#' 
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and wos_group between '#form.groupfrom#' and '#form.groupto#' 
						</cfif>
						<cfif form.areafrom neq "" and form.areato neq "">
						and area between '#form.areafrom#' and '#form.areato#' 
						</cfif>
						group by itemno
						order by itemno
					) as d on a.itemno=d.itemno
					
					left join
					(
						select 
						itemno,
						sum(amt) as cnamt 
						from ictran 
						where type='CN' 
						and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
						<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
						and custno between '#form.customerfrom#' and '#form.customerto#' 
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod between '#form.periodfrom#' and '#form.periodto#' 
						</cfif>
						<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#' 
						</cfif>
						<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#' 
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and wos_group between '#form.groupfrom#' and '#form.groupto#' 
						</cfif>
						<cfif form.areafrom neq "" and form.areato neq "">
						and area between '#form.areafrom#' and '#form.areato#' 
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
				and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
				and (void = '' or void is null)
                and FOC = "Y"
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
                <cfif form.customerfrom neq "" and form.customerto neq "">
					and custno between '#form.customerfrom#' and '#form.customerto#' 
					</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear# 
				</cfif>
				group by itemno 
				order by itemno
			) as f on a.itemno=f.itemno
			</cfif>
                    left join
					(
						select 
						itemno,
						sum(qty) as sumqty 
						from ictran 
						where (type='INV' or type='DN' or type='CN' or type='CS')
						and agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#' 
                        <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
						<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
						and custno between '#form.customerfrom#' and '#form.customerto#' 
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#' 
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod between '#form.periodfrom#' and '#form.periodto#' 
						</cfif>
						<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#' 
						</cfif>
						<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#' 
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and wos_group between '#form.groupfrom#' and '#form.groupto#' 
						</cfif>
						<cfif form.areafrom neq "" and form.areato neq "">
						and area between '#form.areafrom#' and '#form.areato#' 
						</cfif>
						group by itemno
						order by itemno
					) as g on a.itemno=g.itemno
                    
					
					where a.type in ('INV','CS','CN','DN') 
					and a.agenno='#jsstringformat(preservesinglequotes(getagent.agenno))#'
					<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
					and a.custno between '#form.customerfrom#' and '#form.customerto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and a.wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and a.category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
					</cfif>
					<cfif form.areafrom neq "" and form.areato neq "">
					and a.area between '#form.areafrom#' and '#form.areato#'
					</cfif>
					group by itemno
					order by itemno;
				</cfquery>
				<tr>
					<td colspan="8"><font size="2" face="Times New Roman,Times,serif"><u><b>AGENT: #getagent.desp#</b></u></font></td>
				</tr>
				
				<cfset sqty = 0>
                <cfset subfocqty = 0>
				<cfset sinv = 0>
				<cfset scs = 0>
				<cfset sdn = 0>
				<cfset scn = 0>
				<cfset stotal = 0>
				
				<cfloop query="getcontent">
					<cfset sqty = sqty + getcontent.qty>
					<cfset sinv = sinv + getcontent.invamt>
					<cfset scs = scs + getcontent.csamt>
					<cfset scn = scn + getcontent.cnamt>
					<cfset sdn = sdn + getcontent.dnamt>
                    <cfif isdefined('form.foc')>
				<cfset foc_qty1 = val(getcontent.foc_qty)>
                <cfset subfocqty = subfocqty + val(foc_qty1)>
                <cfset total_foc_qty = total_foc_qty + foc_qty1>
                </cfif>
                    
					<cfset stotal = stotal + (getcontent.invamt+getcontent.csamt+getcontent.dnamt)>
					<cfset gqty = gqty + getcontent.qty>
					<cfset ginv = ginv + getcontent.invamt>
					<cfset gcs = gcs + getcontent.csamt>
					<cfset gcn = gcn + getcontent.cnamt>
					<cfset gdn = gdn + getcontent.dnamt>
					<cfset gtotal = gtotal + (getcontent.invamt+getcontent.csamt+getcontent.dnamt)>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getcontent.itemno#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getcontent.desp#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getcontent.qty#</font></div></td>
                        <cfif isdefined('form.foc')>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#foc_qty1#</font></div></td>
					</cfif>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getcontent.invamt,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getcontent.csamt,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getcontent.dnamt,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat((getcontent.invamt+getcontent.csamt+getcontent.dnamt),stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getcontent.cnamt,stDecl_UPrice)#</font></div></td>
					</tr>
				</cfloop>
				<tr>
					<td colspan="9"><hr></td>
				</tr>
				<tr>
					<td></td>
					<td><div align="center"><font size="2" face="Times New Roman,Times,serif">Sub-Total</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#sqty#</font></div></td>
                    <cfif isdefined('form.foc')>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subfocqty,"0")#</font></div></td>
				</cfif>
					<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(sinv,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(scs,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(sdn,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(stotal,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(scn,stDecl_UPrice)#</font></div></td>
				</tr>
				<tr>
					<td colspan="9"><br></td>
				</tr>
			</cfloop>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td><div align="center"><font size="3" face="Times New Roman,Times,serif">Total</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><b>#gqty#</b></font></div></td>
                <cfif isdefined('form.foc')>
            	<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total_foc_qty,"0")#</strong></font></div></td>
            	</cfif>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><b>#numberformat(ginv,stDecl_UPrice)#</b></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><b>#numberformat(gcs,stDecl_UPrice)#</b></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><b>#numberformat(gdn,stDecl_UPrice)#</b></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><b>#numberformat(gtotal,stDecl_UPrice)#</b></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><b>#numberformat(gcn,stDecl_UPrice)#</b></font></div></td>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
		</table>
		</cfoutput>
		</body>
		</html>
	</cfcase>
</cfswitch>