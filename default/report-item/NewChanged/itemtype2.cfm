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

	<cfquery name="getgroup" datasource="#dts#">
		select a.wos_group,(select z.desp from icgroup z where a.wos_group=z.wos_group) as desp
		from icitem a,artran b,ictran c
		where a.itemno=c.itemno and b.type=c.type and b.refno=c.refno and (b.void = '' or b.void is null) and (b.type = 'INV' or b.type = 'DN' or b.type = 'CN' or b.type = 'CS')
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and b.agenno between '#form.agentfrom#' and '#form.agentto#'
		</cfif>
        <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(b.agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(b.agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
        
		<cfif form.areafrom neq "" and form.areato neq "">
		and b.area between '#form.areafrom#' and '#form.areato#'
		</cfif>
		<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
		and b.custno between '#form.custfrom#' and '#form.custto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and a.category between '#form.catefrom#' and '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and b.wos_date between '#ndatefrom#' and '#ndateto#'
		<cfelse>
		and b.wos_date > #getgeneral.lastaccyear#
		</cfif>
		group by a.wos_group order by a.wos_group
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
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
	</Style>
	</Styles>
	<Worksheet ss:Name="ITEM SALES REPORT BY TYPE">
	<cfoutput>
	<Table ss:ExpandedColumnCount="9" x:FullColumns="1" x:FullRows="1">
	<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="5"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s22"><Data ss:Type="String">#trantype# REPORT</Data></Cell>
	</Row>

	<cfif form.periodfrom neq "" and form.periodto neq "">
		<cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<cfwddx action = "cfml2wddx" input = "DATE: #form.datefrom# - #form.dateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		<cfwddx action = "cfml2wddx" input = "AGENT: #form.agentfrom# - #form.agentto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.areafrom neq "" and form.areato neq "">
		<cfwddx action = "cfml2wddx" input = "AREA: #form.areafrom# - #form.areato#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
		<cfwddx action = "cfml2wddx" input = "CUST_NO: #form.custfrom# - #form.custto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<cfwddx action = "cfml2wddx" input = "ITEM_NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="6" ss:StyleID="s26"><Data ss:Type="String">#getgeneral.compro#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s27"><Data ss:Type="String">CUST NO</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">NAME</Data></Cell>
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
	<cfset totals = 0>
    <cfset total_foc_qty = 0>

	<cfloop query="getgroup">
		<cfset groupinv = 0>
		<cfset groupcs = 0>
		<cfset groupdn = 0>
		<cfset groupcn = 0>
		<cfset groupqty = 0>
		<cfset grouptotal = 0>
        <cfset group_foc_qty = 0>

		<cfwddx action = "cfml2wddx" input = "GROUP: #getgroup.wos_group#" output = "wddxText1">
		<cfwddx action = "cfml2wddx" input = "#getgroup.desp#" output = "wddxText2">

		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText1#</Data></Cell>
			<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>

		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.desp from icitem a,artran b,ictran c
			where a.itemno=c.itemno and b.type=c.type and b.refno=c.refno and (b.void = '' or b.void is null) and (b.type = 'INV' or b.type = 'DN' or b.type = 'CN' or b.type = 'CS') and a.wos_group='#getgroup.wos_group#'
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and b.agenno between '#form.agentfrom#' and '#form.agentto#'
			</cfif>
            <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(b.agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(b.agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
			and b.area between '#form.areafrom#' and '#form.areato#'
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			and b.custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and a.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and b.wos_date between '#ndatefrom#' and '#ndateto#'
			<cfelse>
			and b.wos_date > #getgeneral.lastaccyear#
			</cfif>
			group by a.itemno order by a.itemno
		</cfquery>

		<cfloop query="getitem">
			<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText2#</Data></Cell>
				<Cell ss:StyleID="s29"/>
				<Cell ss:StyleID="s29"/>
				<Cell ss:StyleID="s29"/>
				<Cell ss:StyleID="s29"/>
				<Cell ss:StyleID="s29"/>
				<Cell ss:StyleID="s29"/>
			</Row>

			<cfquery name="getcust" datasource="#dts#">
				select a.custno,a.name,b.sumqty,c.suminv,d.sumcs,e.sumdn,f.sumcn,(ifnull(c.suminv,0)+ifnull(d.sumcs,0)+ifnull(e.sumdn,0)) as total
                <cfif isdefined('form.foc')>
            		,g.foc_qty
            		</cfif>
                 from artran as a
				left join
				(select custno,sum(qty) as sumqty from ictran where
				(type='INV' or type='DN' or type='CN' or type='CS') and itemno='#getitem.itemno#'  and (void = '' or void is null)
                <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno between '#form.agentfrom#' and '#form.agentto#'
				</cfif>
                
                 <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
				)as b on a.custno=b.custno

				left join
				(select custno,sum(amt) as suminv from ictran where
				type='INV' and itemno='#getitem.itemno#'  and (void = '' or void is null)
                <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno between '#form.agentfrom#' and '#form.agentto#'
				</cfif>
                
                 <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
				)as c on a.custno=c.custno

				left join
				(select custno,sum(amt) as sumcs from ictran where
				type='CS' and itemno='#getitem.itemno#' and (void = '' or void is null)
                <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno between '#form.agentfrom#' and '#form.agentto#'
				</cfif>
                
                 <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
				)as d on a.custno=d.custno

				left join
				(select custno,sum(amt) as sumdn from ictran where
				type='DN' and itemno='#getitem.itemno#' and (void = '' or void is null)
                <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno between '#form.agentfrom#' and '#form.agentto#'
				</cfif>
                
                 <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
				)as e on a.custno=e.custno

				left join
				(select custno,sum(amt) as sumcn from ictran where
				type='CN' and itemno='#getitem.itemno#' and (void = '' or void is null)
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno between '#form.agentfrom#' and '#form.agentto#'
				</cfif>
                
                 <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
				)as f on a.custno=f.custno
				
                <cfif isdefined('form.foc')>
            left join
			(
				select 
				custno,
				sum(qty) as foc_qty
				from ictran 
				where type in ('INV','CS','DN') 
				and itemno='#getitem.itemno#'
				and (void = '' or void is null)
                and FOC = "Y"
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
				group by custno order by custno
					)as g on a.custno=g.custno
			</cfif>
                
				where (a.void = '' or a.void is null) and (a.type='INV' or a.type='DN' or a.type='CN' or a.type='CS')
				and (b.sumqty<>0 or c.suminv<>0 or d.sumcs<>0 or e.sumdn<>0 or f.sumcn<>0)
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and a.agenno between '#form.agentfrom#' and '#form.agentto#'
				</cfif>
                
                 <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and a.custno between '#form.custfrom#' and '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by a.custno order by a.custno
			</cfquery>

			<cfset subinv = 0>
			<cfset subcs = 0>
			<cfset subdn = 0>
			<cfset subcn = 0>
			<cfset subqty = 0>
			<cfset subtotal = 0>
            <cfset subfocqty = 0>

			<cfloop query="getcust">
				<cfwddx action = "cfml2wddx" input = "#getcust.custno#" output = "wddxText1">
				<cfwddx action = "cfml2wddx" input = "#getcust.name#" output = "wddxText2">

				<Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
					<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
					<Cell ss:StyleID="s35"><Data ss:Type="Number">#getcust.sumqty#</Data></Cell>
                     <cfif isdefined('form.foc')>
                     <Cell ss:StyleID="s35"><Data ss:Type="Number">#getcust.foc_qty#</Data></Cell>
                     </cfif>
					<Cell ss:StyleID="s29"><Data ss:Type="Number">#getcust.suminv#</Data></Cell>
					<Cell ss:StyleID="s29"><Data ss:Type="Number">#getcust.sumcs#</Data></Cell>
					<Cell ss:StyleID="s29"><Data ss:Type="Number">#getcust.sumdn#</Data></Cell>
					<Cell ss:StyleID="s29"><Data ss:Type="Number">#getcust.total#</Data></Cell>
					<Cell ss:StyleID="s29"><Data ss:Type="Number">#getcust.sumcn#</Data></Cell>
				</Row>

				<cfset subinv = subinv + val(getcust.suminv)>
				<cfset subcs = subcs + val(getcust.sumcs)>
				<cfset subdn = subdn + val(getcust.sumdn)>
				<cfset subcn = subcn + val(getcust.sumcn)>
				<cfset subqty = subqty + val(getcust.sumqty)>
				<cfset subtotal = subtotal + val(getcust.total)>
				<cfset groupinv = groupinv + val(getcust.suminv)>
				<cfset groupcs = groupcs + val(getcust.sumcs)>
				<cfset groupdn = groupdn + val(getcust.sumdn)>
				<cfset groupcn = groupcn  + val(getcust.sumcn)>
				<cfset groupqty = groupqty + val(getcust.sumqty)>
				<cfset grouptotal = grouptotal  + val(getcust.total)>
				<cfset totalinv = totalinv + val(getcust.suminv)>
				<cfset totalcs = totalcs + val(getcust.sumcs)>
				<cfset totaldn = totaldn + val(getcust.sumdn)>
				<cfset totalcn = totalcn  + val(getcust.sumcn)>
				<cfset totalqty = totalqty + val(getcust.sumqty)>
				<cfset totals = totals  + val(getcust.total)>
                <cfif isdefined('form.foc')>
					<cfset foc_qty1 = val(getcust.foc_qty)>
                	<cfset subfocqty = subfocqty + val(foc_qty1)>
                    <cfset group_foc_qty = group_foc_qty + foc_qty1>
                	<cfset total_foc_qty = total_foc_qty + foc_qty1>
                	</cfif>
			</cfloop>
				<Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:StyleID="s30"/>
					<Cell ss:StyleID="s30"/>
					<Cell ss:StyleID="s36"><Data ss:Type="Number">#subqty#</Data></Cell>
                    <cfif isdefined('form.foc')>
                    <Cell ss:StyleID="s36"><Data ss:Type="Number">#subfocqty#</Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s31"><Data ss:Type="Number">#subinv#</Data></Cell>
					<Cell ss:StyleID="s31"><Data ss:Type="Number">#subcs#</Data></Cell>
					<Cell ss:StyleID="s31"><Data ss:Type="Number">#subdn#</Data></Cell>
					<Cell ss:StyleID="s31"><Data ss:Type="Number">#subtotal#</Data></Cell>
					<Cell ss:StyleID="s31"><Data ss:Type="Number">#subcn#</Data></Cell>
				</Row>
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
		</cfloop>

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"><Data ss:Type="String">GROUP TOTAL:</Data></Cell>
				<Cell ss:StyleID="s28"/>
				<Cell ss:StyleID="s37"><Data ss:Type="Number">#groupqty#</Data></Cell>
                <cfif isdefined('form.foc')>
                <Cell ss:StyleID="s37"><Data ss:Type="Number">#group_foc_qty#</Data></Cell>
                </cfif>
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#groupinv#</Data></Cell>
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#groupcs#</Data></Cell>
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#groupdn#</Data></Cell>
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#grouptotal#</Data></Cell>
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#groupcn#</Data></Cell>
			</Row>
	</cfloop>
	<Row ss:AutoFitHeight="0" ss:Height="12"/>
	<Row ss:AutoFitHeight="0" ss:Height="12">
		<Cell ss:StyleID="s32"><Data ss:Type="String">TOTAL</Data></Cell>
		<Cell ss:StyleID="s32"/>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totalqty#</Data></Cell>
        <cfif isdefined('form.foc')>
        <Cell ss:StyleID="s33"><Data ss:Type="Number">#total_foc_qty#</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totalinv#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totalcs#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totaldn#</Data></Cell>
		<Cell ss:StyleID="s33"><Data ss:Type="Number">#totals#</Data></Cell>
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

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_PC_Sales_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_PC_Sales_#huserid#.xls">
<!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_PC_Sales_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_PC_Sales_#huserid#.xls">
--->
	</cfcase>

	<cfcase value="HTML">
	<html>
	<head>
	<title>Cust/Supp/Agent/Area Item Report</title>
	<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	<style type="text/css" media="print">
		.noprint { display: none; }
	</style>
	<style type="text/css">
		.borderformat {border-top-style:double;border-bottom-style:double;border-bottom-color:black;border-top-color:black}
	</style>
	</head>

	<body>

	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",___.">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	  <cfset stDecl_UPrice = stDecl_UPrice & "_">
	</cfloop>

	<cfquery name="getgroup" datasource="#dts#">
		select a.wos_group,(select z.desp from icgroup z where a.wos_group=z.wos_group) as desp
		from icitem a,artran b,ictran c
		where a.itemno=c.itemno and b.type=c.type and b.refno=c.refno and (b.void = '' or b.void is null) and (b.type = 'INV' or b.type = 'DN' or b.type = 'CN' or b.type = 'CS')
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and b.agenno between '#form.agentfrom#' and '#form.agentto#'
		</cfif>
        
         <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(b.agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(b.agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
        
		<cfif form.areafrom neq "" and form.areato neq "">
		and b.area between '#form.areafrom#' and '#form.areato#'
		</cfif>
		<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
		and b.custno between '#form.custfrom#' and '#form.custto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and a.category between '#form.catefrom#' and '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
		and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and b.wos_date between '#ndatefrom#' and '#ndateto#'
		<cfelse>
		and b.wos_date > #getgeneral.lastaccyear#
		</cfif>
		group by a.wos_group order by a.wos_group
	</cfquery>

	<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="8"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# REPORT</strong></font></div></td>
		</tr>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #form.datefrom# - #form.dateto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.agentfrom neq "" and form.agentto neq "">
			<tr>
				<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.areafrom neq "" and form.areato neq "">
			<tr>
				<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			<tr>
				<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST_NO: #form.custfrom# - #form.custto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			<tr>
				<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM_NO: #form.itemfrom# - #form.itemto#</font></div></td>
			</tr>
		</cfif>
		<tr>
			<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="9"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CUST NO</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NAME</font></div></td>
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
			<td colspan="9"><hr></td>
		</tr>

		<cfset totalinv = 0>
		<cfset totalcs = 0>
		<cfset totaldn = 0>
		<cfset totalcn = 0>
		<cfset totalqty = 0>
		<cfset totals = 0>
        <cfset total_foc_qty = 0>

		<cfloop query="getgroup">
			<cfset groupinv = 0>
            <cfset group_foc_qty = 0>
			<cfset groupcs = 0>
			<cfset groupdn = 0>
			<cfset groupcn = 0>
			<cfset groupqty = 0>
			<cfset grouptotal = 0>
            
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>GROUP: #getgroup.wos_group#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#getgroup.desp#</strong></font></div></td>
			</tr>

			<cfquery name="getitem" datasource="#dts#">
				select a.itemno,a.desp from icitem a,artran b,ictran c
				where a.itemno=c.itemno and b.type=c.type and b.refno=c.refno and (b.void = '' or b.void is null) and (b.type = 'INV' or b.type = 'DN' or b.type = 'CN' or b.type = 'CS') and a.wos_group='#getgroup.wos_group#'
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and b.agenno between '#form.agentfrom#' and '#form.agentto#'
				</cfif>
                
                 <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(b.agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
						<cfelse>
           				and (ucase(userid)='#ucase(huserid)#' or ucase(b.agenno)='#ucase(huserid)#')  
						</cfif>
						<cfelse>
						<cfif Huserloc neq "All_loc">
						and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
						</cfif>
						</cfif>
                
				<cfif form.areafrom neq "" and form.areato neq "">
				and b.area between '#form.areafrom#' and '#form.areato#'
				</cfif>
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and b.custno between '#form.custfrom#' and '#form.custto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and a.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date between '#ndatefrom#' and '#ndateto#'
				<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by a.itemno order by a.itemno
			</cfquery>

			<cfloop query="getitem">
				<tr>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><u>#getitem.itemno#</u></font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><u>#getitem.desp#</u></font></div></td>
				</tr>
				<cfquery name="getcust" datasource="#dts#">
					select a.custno,a.name,b.sumqty,c.suminv,d.sumcs,e.sumdn,f.sumcn,(ifnull(c.suminv,0)+ifnull(d.sumcs,0)+ifnull(e.sumdn,0)) as total 
                    <cfif isdefined('form.foc')>
            		,g.foc_qty
            		</cfif>
                     from artran as a
					left join
					(select custno,sum(qty) as sumqty from ictran where
					(type='INV' or type='DN' or type='CN' or type='CS') and itemno='#getitem.itemno#'  and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    
                     <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
					<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and custno between '#form.custfrom#' and '#form.custto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by custno order by custno
					)as b on a.custno=b.custno

					left join
					(select custno,sum(amt) as suminv from ictran where
					type='INV' and itemno='#getitem.itemno#'  and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    
                     <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
					<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and custno between '#form.custfrom#' and '#form.custto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by custno order by custno
					)as c on a.custno=c.custno

					left join
					(select custno,sum(amt) as sumcs from ictran where
					type='CS' and itemno='#getitem.itemno#' and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    
                     <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
					<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and custno between '#form.custfrom#' and '#form.custto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by custno order by custno
					)as d on a.custno=d.custno

					left join
					(select custno,sum(amt) as sumdn from ictran where
					type='DN' and itemno='#getitem.itemno#' and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    
                     <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
					<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and custno between '#form.custfrom#' and '#form.custto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by custno order by custno
					)as e on a.custno=e.custno

					left join
					(select custno,sum(amt) as sumcn from ictran where
					type='CN' and itemno='#getitem.itemno#' and (void = '' or void is null)
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    
                     <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
					<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and custno between '#form.custfrom#' and '#form.custto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by custno order by custno
					)as f on a.custno=f.custno
					
                    <cfif isdefined('form.foc')>
            left join
			(
				select 
				custno,
				sum(qty) as foc_qty
				from ictran 
				where type in ('INV','CS','DN') 
				and itemno='#getitem.itemno#'
				and (void = '' or void is null)
                and FOC = "Y"
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
				group by custno order by custno
					)as g on a.custno=g.custno
			</cfif>
					where (a.void = '' or a.void is null) and (a.type='INV' or a.type='DN' or a.type='CN' or a.type='CS')
					and (b.sumqty<>0 or c.suminv<>0 or d.sumcs<>0 or e.sumdn<>0 or f.sumcn<>0)
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and a.agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    
                     <cfif url.alown eq 1>
						<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
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
					<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and a.custno between '#form.custfrom#' and '#form.custto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and a.wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and a.wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by a.custno order by a.custno
				</cfquery>

				<cfset subinv = 0>
				<cfset subcs = 0>
				<cfset subdn = 0>
				<cfset subcn = 0>
				<cfset subqty = 0>
				<cfset subtotal = 0>
                <cfset subfocqty = 0>

				<cfloop query="getcust">
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getcust.custno#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getcust.name#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getcust.sumqty)#</font></div></td>
                        <cfif isdefined('form.foc')>
                        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getcust.foc_qty#</font></div></td>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getcust.suminv),stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getcust.sumcs),stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getcust.sumdn),stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getcust.total),stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getcust.sumcn),stDecl_UPrice)#</font></div></td>
					</tr>
					<cfset subinv = subinv + val(getcust.suminv)>
					<cfset subcs = subcs + val(getcust.sumcs)>
					<cfset subdn = subdn + val(getcust.sumdn)>
					<cfset subcn = subcn + val(getcust.sumcn)>
					<cfset subqty = subqty + val(getcust.sumqty)>
					<cfset subtotal = subtotal + val(getcust.total)>
					<cfset groupinv = groupinv + val(getcust.suminv)>
					<cfset groupcs = groupcs + val(getcust.sumcs)>
					<cfset groupdn = groupdn + val(getcust.sumdn)>
					<cfset groupcn = groupcn  + val(getcust.sumcn)>
					<cfset groupqty = groupqty + val(getcust.sumqty)>
					<cfset grouptotal = grouptotal  + val(getcust.total)>
					<cfset totalinv = totalinv + val(getcust.suminv)>
					<cfset totalcs = totalcs + val(getcust.sumcs)>
					<cfset totaldn = totaldn + val(getcust.sumdn)>
					<cfset totalcn = totalcn  + val(getcust.sumcn)>
					<cfset totalqty = totalqty + val(getcust.sumqty)>
					<cfset totals = totals  + val(getcust.total)>
                    <cfif isdefined('form.foc')>
					<cfset foc_qty1 = val(getcust.foc_qty)>
                	<cfset subfocqty = subfocqty + val(foc_qty1)>
                    <cfset group_foc_qty = group_foc_qty + foc_qty1>
                	<cfset total_foc_qty = total_foc_qty + foc_qty1>
                	</cfif>
				</cfloop>
					<tr>
						<td colspan="2"></td>
						<td colspan="7"><hr/></td>
					</tr>
					<tr>
						<td colspan="2"></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#subqty#</font></div></td>
                        <cfif isdefined('form.foc')>
               			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subfocqty,"0")#</font></div></td>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subinv,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subcs,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subdn,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,stDecl_UPrice)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subcn,stDecl_UPrice)#</font></div></td>
					</tr>
			</cfloop>
			<tr>
				<td colspan="2"></td>
				<td colspan="7"><hr/></td>
			</tr>
			<tr>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#groupqty#</font></div></td>
                <cfif isdefined('form.foc')>
           		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(group_foc_qty,"0")#</strong></font></div></td>
            	</cfif>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupinv,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupcs,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupdn,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grouptotal,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupcn,stDecl_UPrice)#</font></div><br/></td>
			</tr>
		</cfloop>
		<tr>
			<td colspan="2"></td>
			<td colspan="6"><br/></td>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td class="borderformat"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#totalqty#</strong></font></div></td>
            <cfif isdefined('form.foc')>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total_foc_qty,"0")#</strong></font></div></td>
            </cfif>
			<td class="borderformat"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalinv,",.__")#</strong></font></div></td>
			<td class="borderformat"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcs,",.__")#</strong></font></div></td>
			<td class="borderformat"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totaldn,",.__")#</strong></font></div></td>
			<td class="borderformat"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totals,",.__")#</strong></font></div></td>
			<td class="borderformat"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcn,",.__")#</strong></font></div></td>
		</tr>
	</table>
	</cfoutput>

	<cfif getgroup.recordcount eq 0>
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