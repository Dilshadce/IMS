<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
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
    <Worksheet ss:Name="Batch Code Report"><cfoutput>
        <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
          <Column ss:AutoFitWidth="0" ss:Width="103.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="103.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="120.75"/>
          <Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="5"/>
          <Row ss:AutoFitHeight="0" ss:Height="23.0625">
            <Cell ss:MergeAcross="7" ss:StyleID="s22">
              <Data ss:Type="String">Print Location Item
                <cfif checkcustom.customcompany eq "Y">
                  - Lot Number
                  <cfelse>
                  Batch
                </cfif>
                Sales Report</Data>
            </Cell>
          </Row>
          <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
            <cfif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "jaynbtrading_i" or lcase(hcomid) eq "laihock_i">
              <cfset varbatch="LOT NUMBER">
              <cfelse>
              <cfset varbatch="BATCH CODE">
            </cfif>
            <cfwddx action = "cfml2wddx" input = "#varbatch#: #form.batchcodefrom# - #form.batchcodeto#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="7" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
            <cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="7" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
            <cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="7" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
            <cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <Cell ss:MergeAcross="7" ss:StyleID="s24">
                <Data ss:Type="String">#wddxText#</Data>
              </Cell>
            </Row>
          </cfif>
          <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:MergeAcross="6" ss:StyleID="s26">
              <Data ss:Type="String">
                <cfif getgeneral.compro neq "">
                  #getgeneral.compro#
                </cfif>
              </Data>
            </Cell>
            <Cell ss:StyleID="s26">
              <Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data>
            </Cell>
          </Row>
          <Row ss:AutoFitHeight="0" ss:Height="23.0625">
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">ITEM NO.</Data>
            </Cell>
            <cfif checkcustom.customcompany eq "Y">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">PERMIT NO</Data>
              </Cell>
            </cfif>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">
                <cfif checkcustom.customcompany eq "Y">
                  LOT NUMBER
                  <cfelse>
                  ITEM BATCH
                </cfif>
              </Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">
                <cfif lcase(hcomid) eq "marquis_i">
                  Lot Number
                  <cfelse>
                  Mil Cert
                </cfif>
              </Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">Import Permit</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">QTY SOLD</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">UNITS</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">INV</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">CS</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">DN</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">TOTAL</Data>
            </Cell>
            <Cell ss:StyleID="s27">
              <Data ss:Type="String">CN</Data>
            </Cell>
          </Row>
          
          <cfquery name="getlocation" datasource="#dts#">
			select a.location,c.desp,b.unit
			from ictran a,icitem b,iclocation c
			where a.location=c.location 
			and a.itemno=b.itemno 
			and (a.type='INV' or a.type='CS' or a.type='DN' or a.type='CN') 
			and (a.void = '' or a.void is null) and a.batchcode<>'' and a.location<>''
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and b.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and b.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and b.wos_group between"#form.groupfrom#" and "#form.groupto#"
			</cfif>
			<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
				and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
			</cfif>
            <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
			</cfif>
            <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
			<cfif form.locationfrom neq "" and form.locationto neq "">
				and a.location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date between '#ndatefrom#' and '#ndateto#'
			</cfif>
			<cfif isdefined("form.figure") and form.figure eq "yes">
			<cfelse>
				and a.amt <> 0
			</cfif>
			<cfif checkcustom.customcompany eq "Y">
				<cfif trim(form.permitno) neq "">
					and a.brem5='#form.permitno#'
				</cfif>
			</cfif>
			group by a.location order by a.location
		</cfquery>
          <cfset xqty = 0>
          <cfset xinv = 0>
          <cfset xcs = 0>
          <cfset xdn = 0>
          <cfset xtotal = 0>
          <cfset xcn = 0>
          <cfif getlocation.recordcount gt 0>
            <cfloop query="getlocation">
              <cfset xlocation = getlocation.location>
              <!--- Add on 18-11-2008 --->
              <cfwddx action = "cfml2wddx" input = "LOCATION: #getlocation.location#" output = "wddxText1">
              <cfif getlocation.location neq "">
                <cfquery name="locationname" datasource="#dts#">
						select desp from iclocation where location='#getlocation.location#'
					</cfquery>
                <cfwddx action = "cfml2wddx" input = "#locationname.desp#" output = "wddxText2">
                <cfelse>
                <cfwddx action = "cfml2wddx" input = "No-Location" output = "wddxText2">
              </cfif>
              <Row ss:AutoFitHeight="0" ss:Height="12">
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText1#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText2#</Data>
                </Cell>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText3#</Data>
                </Cell>
              </Row>
              
              <cfquery name="getgroup" datasource="#dts#">
					select b.wos_group,b.unit
					from ictran a,icitem b,
					where a.itemno=b.itemno and (a.void = '' or a.void is null)
					and (a.type='INV' or a.type='CS' or a.type='DN' or a.type='CN') 
					and a.location='#xlocation#' and a.batchcode<>''
					<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
						and b.category between '#form.catefrom#' and '#form.cateto#'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and b.itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and b.wos_group between"#form.groupfrom#" and "#form.groupto#"
					</cfif>
					<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
						and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and a.wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif>
					<cfif isdefined("form.figure") and form.figure eq "yes">
					<cfelse>
						and a.amt <> 0
					</cfif>
					<cfif checkcustom.customcompany eq "Y">
						<cfif trim(form.permitno) neq "">
							and a.brem5='#form.permitno#'
						</cfif>
					</cfif>
					group by b.wos_group order by b.wos_group
				</cfquery>
              <cfloop query="getgroup">
                <cfset xgroup = getgroup.wos_group>
                <!--- Add on 18-11-2008 --->
                <cfwddx action = "cfml2wddx" input = "Group: #getgroup.wos_group#" output = "wddxText1">
                <cfif getgroup.wos_group neq "">
                  <cfquery name="groupname" datasource="#dts#">
							select desp from icgroup where wos_group='#getgroup.wos_group#'
						</cfquery>
                  <cfwddx action = "cfml2wddx" input = "" output = "wddxText2">
                  <cfelse>
                  <cfwddx action = "cfml2wddx" input = "Non-Grouped" output = "wddxText2">
                </cfif>
                <Row ss:AutoFitHeight="0" ss:Height="12">
                  <Cell ss:StyleID="s28">
                    <Data ss:Type="String">#wddxText1#</Data>
                  </Cell>
                  <Cell ss:StyleID="s28">
                    <Data ss:Type="String">#wddxText2#</Data>
                  </Cell>
                  <Cell ss:StyleID="s29"/>
                  <Cell ss:StyleID="s29"/>
                  <Cell ss:StyleID="s29"/>
                  <Cell ss:StyleID="s29"/>
                  <Cell ss:StyleID="s29"/>
                  <Cell ss:StyleID="s29"/>
                  <Cell ss:StyleID="s28">
                    <Data ss:Type="String">#wddxText3#</Data>
                  </Cell>
                </Row>
                <cfset yqty = 0>
                <cfset yinv = 0>
                <cfset ycs = 0>
                <cfset ydn = 0>
                <cfset ytotal = 0>
                <cfset ycn = 0>
                
                <cfquery name="getitem" datasource="#dts#">
						select a.itemno,a.desp,b.location,b.batchcode,b.unit
						from icitem a,ictran b 
						where b.wos_group='#xgroup#' 
						and b.itemno=a.itemno and (b.void = '' or b.void is null)
						and b.location='#xlocation#' and b.batchcode<>'' 
						and (b.type='INV' or b.type='CS' or b.type='DN' or b.type='CN')
						<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
							and a.category between '#form.catefrom#' and '#form.cateto#'
						</cfif>
						<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
							and a.itemno between '#form.itemfrom#' and '#form.itemto#'
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
							and a.wos_group between"#form.groupfrom#" and "#form.groupto#"
						</cfif>
						<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
							and b.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
							and b.wos_date between '#ndatefrom#' and '#ndateto#'
						</cfif>
						<cfif isdefined("form.figure") and form.figure eq "yes">
						<cfelse>
							and b.amt <> 0
						</cfif>
						<cfif checkcustom.customcompany eq "Y">
							<cfif trim(form.permitno) neq "">
								and b.brem5='#form.permitno#'
							</cfif>
						</cfif>
						group by a.itemno,b.batchcode,b.location order by a.itemno,b.batchcode,b.location
					</cfquery>
                <cfloop query="getitem">
                  <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
                  <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText2">
                  <Row ss:AutoFitHeight="0" ss:Height="12">
                    <Cell ss:StyleID="s28">
                      <Data ss:Type="String">#wddxText1#</Data>
                    </Cell>
                    <Cell ss:StyleID="s28">
                      <Data ss:Type="String">#wddxText2#</Data>
                    </Cell>
                    <Cell ss:StyleID="s29"/>
                    <Cell ss:StyleID="s29"/>
                    <Cell ss:StyleID="s29"/>
                    <Cell ss:StyleID="s29"/>
                    <Cell ss:StyleID="s29"/>
                    <Cell ss:StyleID="s29"/>
                    <Cell ss:StyleID="s28">
                      <Data ss:Type="String">#wddxText3#</Data>
                    </Cell>
                  </Row>
                  <cfset zqty = 0>
                  <cfset zinv = 0>
                  <cfset zcs = 0>
                  <cfset zdn = 0>
                  <cfset ztotal = 0>
                  <cfset zcn = 0>
                  
                   
                  <cfquery name="gettran" datasource="#dts#">
							select a.itemno,a.unit,a.batchcodea,milcert,a.importpermit,a.brem5,a.location,b.sumqty,c.suminv,d.sumcs,e.sumdn,f.sumcn,(ifnull(c.suminv,0)+ifnull(d.sumcs,0)+ifnull(e.sumdn,0)) as total 
							from ictran as a
							
							left join
							(	select itemno,sum(qty) as sumqty,batchcode,location 
								from ictran 
								where (type='INV' or type='CS' or type='DN') 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and brem5='#form.permitno#'
									</cfif>
								</cfif>
								group by itemno,batchcode,location 
								order by itemno,batchcode,location
							) as b on a.itemno=b.itemno and a.location=b.location and a.batchcode=b.batchcode

							left join
							(	select itemno,sum(amt) as suminv,batchcode,location 
								from ictran where type='INV' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and brem5='#form.permitno#'
									</cfif>
								</cfif>
								group by itemno,batchcode,location 
								order by itemno,batchcode,location
							) as c on a.itemno=c.itemno and a.location=c.location and a.batchcode=c.batchcode

							left join
							(	select itemno,sum(amt) as sumcs,batchcode,location 
								from ictran 
								where type='CS' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and brem5='#form.permitno#'
									</cfif>
								</cfif>
								group by itemno,batchcode,location 
								order by itemno,batchcode,location
							) as d on a.itemno=d.itemno and a.location=d.location and a.batchcode=d.batchcode

							left join
							(	select itemno,sum(amt) as sumdn,batchcode,location 
								from ictran where type='DN' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and brem5='#form.permitno#'
									</cfif>
								</cfif>
								group by itemno,batchcode,location 
								order by itemno,batchcode,location
							) as e on a.itemno=e.itemno and a.location=e.location and a.batchcode=e.batchcode

							left join
							(	select itemno,sum(amt) as sumcn,batchcode,location 
								from ictran 
								where type='CN' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and brem5='#form.permitno#'
									</cfif>
								</cfif>
								group by itemno,batchcode,location 
								order by itemno,batchcode,location
							) as f on a.itemno=f.itemno  and a.location=f.location and a.batchcode=f.batchcode

							where a.itemno='#getitem.itemno#'  and (a.void = '' or a.void is null)
							and a.batchcode='#getitem.batchcode#'  and a.location='#getitem.location#'
							<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
								and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
							</cfif>
                            <cfif form.milcert neq "">
							and a.milcert = "#form.milcert#"
							</cfif>
       					    <cfif form.importpermit neq "">
							and a.importpermit = "#form.importpermit#"
							</cfif>
							<cfif form.periodfrom neq "" and form.periodto neq "">
								and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
							</cfif>
							<cfif form.datefrom neq "" and form.dateto neq "">
								and a.wos_date between '#ndatefrom#' and '#ndateto#'
							</cfif>
							<cfif isdefined("form.figure") and form.figure eq "yes">
							<cfelse>
								and a.amt <> 0
							</cfif>
							<cfif checkcustom.customcompany eq "Y">
								<cfif trim(form.permitno) neq "">
									and a.brem5='#form.permitno#'
								</cfif>
							</cfif>
							group by a.itemno,a.batchcode,a.location 
							order by a.itemno,a.batchcode,a.location
						</cfquery>
                  <cfloop query="gettran">
                    <cfset zqty = zqty + val(gettran.sumqty)>
                    <cfset zinv = zinv + val(gettran.suminv)>
                    <cfset zcs = zcs + val(gettran.sumcs)>
                    <cfset zdn = zdn + val(gettran.sumdn)>
                    <cfset ztotal = ztotal + val(gettran.total)>
                    <cfset zcn = zcn + val(gettran.sumcn)>
                    <cfset yqty = yqty + val(gettran.sumqty)>
                    <cfset yinv = yinv + val(gettran.suminv)>
                    <cfset ycs = ycs + val(gettran.sumcs)>
                    <cfset ydn = ydn + val(gettran.sumdn)>
                    <cfset ytotal = ytotal + val(gettran.total)>
                    <cfset ycn = ycn + val(gettran.sumcn)>
                    <cfset xqty = xqty + val(gettran.sumqty)>
                    <cfset xinv = xinv + val(gettran.suminv)>
                    <cfset xcs = xcs + val(gettran.sumcs)>
                    <cfset xdn = xdn + val(gettran.sumdn)>
                    <cfset xtotal = xtotal + val(gettran.total)>
                    <cfset xcn = xcn + val(gettran.sumcn)>
                    <cfwddx action = "cfml2wddx" input = "#gettran.batchcode#" output = "wddxText1">
                    <cfwddx action = "cfml2wddx" input = "#gettran.milcert#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#gettran.importpermit#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#gettran.importpermit#" output = "wddxText5">
                    <cfif checkcustom.customcompany eq "Y">
                      <cfwddx action = "cfml2wddx" input = "#gettran.brem5#" output = "wddxText2">
                    </cfif>
                    <Row ss:AutoFitHeight="0" ss:Height="12">
                      <Cell ss:StyleID="s28"/>
                      <cfif checkcustom.customcompany eq "Y">
                        <Cell ss:StyleID="s28">
                          <Data ss:Type="String">#wddxText2#</Data>
                        </Cell>
                      </cfif>
                      <Cell ss:StyleID="s28">
                        <Data ss:Type="String">#wddxText1#</Data>
                      </Cell>
                      <Cell ss:StyleID="s28">
                        <Data ss:Type="String">#wddxText3#</Data>
                      </Cell>
                      <Cell ss:StyleID="s28">
                        <Data ss:Type="String">#wddxText4#</Data>
                      </Cell>
                      <Cell ss:StyleID="s35">
                        <Data ss:Type="Number">#gettran.sumqty#</Data>
                      </Cell>
                      <Cell ss:StyleID="s28">
                        <Data ss:Type="String">#wddxText5#</Data>
                      </Cell>
                      <Cell ss:StyleID="s29">
                        <Data ss:Type="Number">#gettran.suminv#</Data>
                      </Cell>
                      <Cell ss:StyleID="s29">
                        <Data ss:Type="Number">#gettran.sumcs#</Data>
                      </Cell>
                      <Cell ss:StyleID="s29">
                        <Data ss:Type="Number">#gettran.sumdn#</Data>
                      </Cell>
                      <Cell ss:StyleID="s29">
                        <Data ss:Type="Number">#gettran.total#</Data>
                      </Cell>
                      <Cell ss:StyleID="s29">
                        <Data ss:Type="Number">#gettran.sumcn#</Data>
                      </Cell>
                    </Row>
                  </cfloop>
                  <Row ss:AutoFitHeight="0" ss:Height="12">
                    <Cell ss:StyleID="s28"/>
                    <Cell ss:StyleID="s28"/>
                    <Cell ss:StyleID="s28"/>
                    <Cell ss:StyleID="s28"/>
                    <cfif checkcustom.customcompany eq "Y">
                      <Cell ss:StyleID="s28"/>
                    </cfif>
                    <Cell ss:StyleID="s35">
                      <Data ss:Type="Number">#zqty#</Data>
                    </Cell>
                    <Cell ss:StyleID="s29">
                      <Data ss:Type="Number">#zinv#</Data>
                    </Cell>
                    <Cell ss:StyleID="s29">
                      <Data ss:Type="Number">#zcs#</Data>
                    </Cell>
                    <Cell ss:StyleID="s29">
                      <Data ss:Type="Number">#zdn#</Data>
                    </Cell>
                    <Cell ss:StyleID="s29">
                      <Data ss:Type="Number">#ztotal#</Data>
                    </Cell>
                    <Cell ss:StyleID="s29">
                      <Data ss:Type="Number">#zcn#</Data>
                    </Cell>
                  </Row>
                </cfloop>
                <Row ss:AutoFitHeight="0" ss:Height="12"/>
                <Row ss:AutoFitHeight="0" ss:Height="12">
                  <Cell ss:StyleID="s30">
                    <Data ss:Type="String">GROUP TOTAL:</Data>
                  </Cell>
                  <Cell ss:StyleID="s30"/>
                  <Cell ss:StyleID="s30"/>
                  <Cell ss:StyleID="s30"/>
                  <cfif checkcustom.customcompany eq "Y">
                    <Cell ss:StyleID="s30"/>
                  </cfif>
                  <Cell ss:StyleID="s36">
                    <Data ss:Type="Number">#yqty#</Data>
                  </Cell>
                  <Cell ss:StyleID="s31">
                    <Data ss:Type="Number">#yinv#</Data>
                  </Cell>
                  <Cell ss:StyleID="s31">
                    <Data ss:Type="Number">#ycs#</Data>
                  </Cell>
                  <Cell ss:StyleID="s31">
                    <Data ss:Type="Number">#ydn#</Data>
                  </Cell>
                  <Cell ss:StyleID="s31">
                    <Data ss:Type="Number">#ytotal#</Data>
                  </Cell>
                  <Cell ss:StyleID="s31">
                    <Data ss:Type="Number">#ycn#</Data>
                  </Cell>
                </Row>
              </cfloop>
            </cfloop>
            <Row ss:AutoFitHeight="0" ss:Height="12"/>
            <Row ss:AutoFitHeight="0" ss:Height="12"/>
            <Row ss:AutoFitHeight="0" ss:Height="12">
              <Cell ss:StyleID="s32"/>
              <Cell ss:StyleID="s32"/>
              <Cell ss:StyleID="s32"/>
              <Cell ss:StyleID="s32"/>
              <cfif checkcustom.customcompany eq "Y">
                <Cell ss:StyleID="s32"/>
              </cfif>
              <Cell ss:StyleID="s37">
                <Data ss:Type="Number">#xqty#</Data>
              </Cell>
              <Cell ss:StyleID="s33">
                <Data ss:Type="Number">#xinv#</Data>
              </Cell>
              <Cell ss:StyleID="s33">
                <Data ss:Type="Number">#xcs#</Data>
              </Cell>
              <Cell ss:StyleID="s33">
                <Data ss:Type="Number">#xdn#</Data>
              </Cell>
              <Cell ss:StyleID="s33">
                <Data ss:Type="Number">#xtotal#</Data>
              </Cell>
              <Cell ss:StyleID="s33">
                <Data ss:Type="Number">#xcn#</Data>
              </Cell>
            </Row>
          </cfif>
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
  <cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\BatchCodeR_LIBSales_#huserid#.xls" output="#tostring(data)#">
  <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\BatchCodeR_LIBSales_#huserid#.xls">

  </cfcase>
  <cfcase value="HTML">
  <html>
  <head>
  <title>Location Item Batch Sales Report</title>
  <link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
  <style type="text/css" media="print">
.noprint {
	display: none;
}
</style>
  <style>
.bstyle {
	border-style: solid;
	border-color: black;
	border-width: 1;
	border-left: none;
	border-right: none;
	border-bottom: none
}
</style>
  </head>
  <cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
  <cfset stDecl_UPrice = ",___.">
  <cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
    <cfset stDecl_UPrice = stDecl_UPrice & "_">
  </cfloop>
  
  <body>
  <cfoutput>
    <table width="100%" border="0" cellspacing="1" cellpadding="2">
      <tr>
        <td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Print Location Item
            <cfif checkcustom.customcompany eq "Y">
              - Lot Number
              <cfelse>
              Batch
            </cfif>
            Sales Report</strong></font></div></td>
      </tr>
      <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
        <tr>
          <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">
              <cfif checkcustom.customcompany eq "Y">
                LOT NUMBER
                <cfelse>
                BATCH CODE
              </cfif>
              : #form.batchcodefrom# - #form.batchcodeto#</font></div></td>
        </tr>
      </cfif>
      <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
        <tr>
          <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
        </tr>
      </cfif>
      <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
        <tr>
          <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
        </tr>
      </cfif>
      <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
        <tr>
          <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
        </tr>
      </cfif>
      <tr>
        <td colspan="2"><font size="2" face="Times New Roman, Times, serif">
          <cfif getgeneral.compro neq "">
            #getgeneral.compro#
          </cfif>
          </font></td>
        <td colspan="6"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
        <cfif checkcustom.customcompany eq "Y">
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">PERMIT NO</font></div></td>
        </cfif>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">
            <cfif checkcustom.customcompany eq "Y">
              LOT NUMBER
              <cfelse>
              ITEM BATCH
            </cfif>
            </font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">
            <cfif lcase(hcomid) eq "marquis_i">
              Lot Number
              <cfelse>
              Mil Cert
            </cfif>
            </font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY SOLD</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNITS</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">INV</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">CS</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">DN</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">CN</font></div></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfquery name="getlocation" datasource="#dts#">
			select a.location,c.desp ,b.unit
			from ictran a,icitem b,iclocation c
			where a.location=c.location 
			and a.itemno=b.itemno 
			and (a.type='INV' or a.type='CS' or a.type='DN' or a.type='CN') 
			and (a.void = '' or a.void is null) and a.batchcode<>'' and a.location<>''
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and b.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and b.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and b.wos_group between"#form.groupfrom#" and "#form.groupto#"
			</cfif>
			<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
				and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
			</cfif>
            <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
			</cfif>
            <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
			</cfif>
			<cfif form.locationfrom neq "" and form.locationto neq "">
				and a.location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date between '#ndatefrom#' and '#ndateto#'
			</cfif>
			<cfif isdefined("form.figure") and form.figure eq "yes">
			<cfelse>
				and a.amt <> 0
			</cfif>
			<cfif checkcustom.customcompany eq "Y">
				<cfif trim(form.permitno) neq "">
					and (a.brem8='#form.permitno#' or a.brem9='#form.permitno#' or a.brem10='#form.permitno#')
				</cfif>
			</cfif>
			group by a.location order by a.location
		</cfquery>
      <cfset xqty = 0>
      <cfset xinv = 0>
      <cfset xcs = 0>
      <cfset xdn = 0>
      <cfset xtotal = 0>
      <cfset xcn = 0>
      <cfif getlocation.recordcount gt 0>
        <cfloop query="getlocation">
          <cfset xlocation = getlocation.location>
          <!--- Add on 18-11-2008 --->
          <tr>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>LOCATION: #getlocation.location#</strong></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>
                <cfif getlocation.location neq "">
                  #getlocation.desp#
                  <cfelse>
                  No-Location
                </cfif>
                </strong></font></div></td>
          </tr>
          <cfquery name="getgroup" datasource="#dts#">
					select b.wos_group 
					from ictran a,icitem b 
					where a.itemno=b.itemno and (a.void = '' or a.void is null)
					and (a.type='INV' or a.type='CS' or a.type='DN' or a.type='CN') 
					and a.location='#xlocation#' and a.batchcode<>''
					<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
						and b.category between '#form.catefrom#' and '#form.cateto#'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and b.itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
						and b.wos_group between"#form.groupfrom#" and "#form.groupto#"
					</cfif>
					<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
						and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
					</cfif>
                    <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
			</cfif>
            <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
			</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and a.wos_date between '#ndatefrom#' and '#ndateto#'
					</cfif>
					<cfif isdefined("form.figure") and form.figure eq "yes">
					<cfelse>
						and a.amt <> 0
					</cfif>
					<cfif checkcustom.customcompany eq "Y">
						<cfif trim(form.permitno) neq "">
							and (a.brem8='#form.permitno#' or a.brem9='#form.permitno#' or a.brem10='#form.permitno#')
						</cfif>
					</cfif>
					group by b.wos_group order by b.wos_group
				</cfquery>
          <cfloop query="getgroup">
            <cfset xgroup = getgroup.wos_group>
            <!--- Add on 18-11-2008 --->
            <tr>
              <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Group: #getgroup.wos_group#</font></div></td>
              <td><div align="left"><font size="1" face="Times New Roman, Times, serif">
                  <cfif getgroup.wos_group neq "">
                    <cfquery name="groupname" datasource="#dts#">
								select desp from icgroup where wos_group='#getgroup.wos_group#'
							</cfquery>
                    <cfelse>
                    Non-Grouped
                  </cfif>
                  </font></div></td>
            </tr>
            <cfset yqty = 0>
            <cfset yinv = 0>
            <cfset ycs = 0>
            <cfset ydn = 0>
            <cfset ytotal = 0>
            <cfset ycn = 0>
            <cfquery name="getitem" datasource="#dts#">
						select a.itemno,a.desp,b.location,b.batchcode 
						from icitem a,ictran b 
						where b.wos_group='#xgroup#' 
						and b.itemno=a.itemno and (b.void = '' or b.void is null)
						and b.location='#xlocation#' and b.batchcode<>'' 
						and (b.type='INV' or b.type='CS' or b.type='DN' or b.type='CN')
						<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
							and a.category between '#form.catefrom#' and '#form.cateto#'
						</cfif>
						<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
							and a.itemno between '#form.itemfrom#' and '#form.itemto#'
						</cfif>
						<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
							and a.wos_group between"#form.groupfrom#" and "#form.groupto#"
						</cfif>
						<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
							and b.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
							and b.fperiod between '#form.periodfrom#' and '#form.periodto#'
						</cfif>
						<cfif form.datefrom neq "" and form.dateto neq "">
							and b.wos_date between '#ndatefrom#' and '#ndateto#'
						</cfif>
						<cfif isdefined("form.figure") and form.figure eq "yes">
						<cfelse>
							and b.amt <> 0
						</cfif>
						<cfif checkcustom.customcompany eq "Y">
							<cfif trim(form.permitno) neq "">
								and (b.brem8='#form.permitno#' or b.brem9='#form.permitno#' or b.brem10='#form.permitno#')
							</cfif>
						</cfif>
						group by a.itemno,b.batchcode,b.location order by a.itemno,b.batchcode,b.location
					</cfquery>
            <cfloop query="getitem">
              <tr>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif"><u>#getitem.itemno#</u></font></div></td>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif"><u>#getitem.desp#</u></font></div></td>
              </tr>
              <cfset zqty = 0>
              <cfset zinv = 0>
              <cfset zcs = 0>
              <cfset zdn = 0>
              <cfset ztotal = 0>
              <cfset zcn = 0>
              <cfquery name="gettran" datasource="#dts#">
							select a.itemno,a.unit,a.batchcode,a.milcert,a.importpermit,a.brem8,a.brem9,a.brem10,a.location,b.sumqty,c.suminv,d.sumcs,e.sumdn,f.sumcn,(ifnull(c.suminv,0)+ifnull(d.sumcs,0)+ifnull(e.sumdn,0)) as total 
							from ictran as a
							
							left join
							(	select itemno,sum(qty) as sumqty,batchcode,location,brem8,brem9,brem10
								from ictran 
								where (type='INV' or type='CS' or type='DN') 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and (brem8='#form.permitno#' or brem9='#form.permitno#' or brem10='#form.permitno#')
									</cfif>
								</cfif>
								group by itemno,batchcode,location<cfif checkcustom.customcompany eq "Y">,brem8,brem9,brem10</cfif>  
								order by itemno,batchcode,location
							) as b on (a.itemno=b.itemno and a.location=b.location and a.batchcode=b.batchcode and a.brem8=b.brem8 and a.brem9=b.brem9 and a.brem10=b.brem10)

							left join
							(	select itemno,sum(amt) as suminv,batchcode,location,brem8,brem9,brem10
								from ictran where type='INV' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and (brem8='#form.permitno#' or brem9='#form.permitno#' or brem10='#form.permitno#')
									</cfif>
								</cfif>
								group by itemno,batchcode,location<cfif checkcustom.customcompany eq "Y">,brem8,brem9,brem10</cfif>  
								order by itemno,batchcode,location
							) as c on (a.itemno=c.itemno and a.location=c.location and a.batchcode=c.batchcode and a.brem8=c.brem8 and a.brem9=c.brem9 and a.brem10=c.brem10)

							left join
							(	select itemno,sum(amt) as sumcs,batchcode,location,brem8,brem9,brem10 
								from ictran 
								where type='CS' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and (brem8='#form.permitno#' or brem9='#form.permitno#' or brem10='#form.permitno#')
									</cfif>
								</cfif>
								group by itemno,batchcode,location<cfif checkcustom.customcompany eq "Y">,brem8,brem9,brem10</cfif>  
								order by itemno,batchcode,location
							) as d on (a.itemno=d.itemno and a.location=d.location and a.batchcode=d.batchcode and a.brem8=d.brem8 and a.brem9=d.brem9 and a.brem10=d.brem10)

							left join
							(	select itemno,sum(amt) as sumdn,batchcode,location,brem8,brem9,brem10
								from ictran where type='DN' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and (brem8='#form.permitno#' or brem9='#form.permitno#' or brem10='#form.permitno#')
									</cfif>
								</cfif>
								group by itemno,batchcode,location<cfif checkcustom.customcompany eq "Y">,brem8,brem9,brem10</cfif>  
								order by itemno,batchcode,location
							) as e on (a.itemno=e.itemno and a.location=e.location and a.batchcode=e.batchcode and a.brem8=e.brem8 and a.brem9=e.brem9 and a.brem10=e.brem10)

							left join
							(	select itemno,sum(amt) as sumcn,batchcode,location,brem8,brem9,brem10
								from ictran 
								where type='CN' 
								and (void = '' or void is null) and batchcode='#getitem.batchcode#'
								and itemno='#getitem.itemno#'
								<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
									and batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									and fperiod between '#form.periodfrom#' and '#form.periodto#'
								</cfif>
								<cfif form.datefrom neq "" and form.dateto neq "">
									and wos_date between '#ndatefrom#' and '#ndateto#'
								</cfif>
								<cfif checkcustom.customcompany eq "Y">
									<cfif trim(form.permitno) neq "">
										and (brem8='#form.permitno#' or brem9='#form.permitno#' or brem10='#form.permitno#')
									</cfif>
								</cfif>
								group by itemno,batchcode,location,brem8,brem9,brem10 
								order by itemno,batchcode,location
							) as f on (a.itemno=f.itemno and a.location=f.location and a.batchcode=f.batchcode and a.brem8=f.brem8 and a.brem9=f.brem9 and a.brem10=f.brem10)

							where a.itemno='#getitem.itemno#'  and (a.void = '' or a.void is null) 
							and a.type in ('INV','DN','CN','CS')
							and a.batchcode='#getitem.batchcode#'  and a.location='#getitem.location#'
							<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
								and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
							</cfif>
                            <cfif form.milcert neq "">
							and a.milcert = "#form.milcert#"
							</cfif>
        				    <cfif form.importpermit neq "">
							and a.importpermit = "#form.importpermit#"
							</cfif>
							<cfif form.periodfrom neq "" and form.periodto neq "">
								and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
							</cfif>
							<cfif form.datefrom neq "" and form.dateto neq "">
								and a.wos_date between '#ndatefrom#' and '#ndateto#'
							</cfif>
							<cfif isdefined("form.figure") and form.figure eq "yes">
							<cfelse>
								and a.amt <> 0
							</cfif>
							<cfif checkcustom.customcompany eq "Y">
								<cfif trim(form.permitno) neq "">
									and (a.brem8='#form.permitno#' or a.brem9='#form.permitno#' or a.brem10='#form.permitno#')
								</cfif>
							</cfif>
							group by a.itemno,a.batchcode,a.location<cfif checkcustom.customcompany eq "Y">,a.brem8,a.brem9,a.brem10</cfif> 
							order by a.itemno,a.batchcode,a.location
						</cfquery>
              <cfloop query="gettran">
                <cfset zqty = zqty + val(gettran.sumqty)>
                <cfset zinv = zinv + val(gettran.suminv)>
                <cfset zcs = zcs + val(gettran.sumcs)>
                <cfset zdn = zdn + val(gettran.sumdn)>
                <cfset ztotal = ztotal + val(gettran.total)>
                <cfset zcn = zcn + val(gettran.sumcn)>
                <cfset yqty = yqty + val(gettran.sumqty)>
                <cfset yinv = yinv + val(gettran.suminv)>
                <cfset ycs = ycs + val(gettran.sumcs)>
                <cfset ydn = ydn + val(gettran.sumdn)>
                <cfset ytotal = ytotal + val(gettran.total)>
                <cfset ycn = ycn + val(gettran.sumcn)>
                <cfset xqty = xqty + val(gettran.sumqty)>
                <cfset xinv = xinv + val(gettran.suminv)>
                <cfset xcs = xcs + val(gettran.sumcs)>
                <cfset xdn = xdn + val(gettran.sumdn)>
                <cfset xtotal = xtotal + val(gettran.total)>
                <cfset xcn = xcn + val(gettran.sumcn)>
                <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                  <td></td>
                  <cfif checkcustom.customcompany eq "Y">
                    <td><div align="left"><font size="1" face="Times New Roman, Times, serif">
                        <cfif gettran.brem8 neq "">
                          #gettran.brem8#
                          <cfelseif gettran.brem9 neq "">
                          #gettran.brem9#
                          <cfelseif gettran.brem10 neq "">
                          #gettran.brem10#
                        </cfif>
                        </font></div></td>
                  </cfif>
                  <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#gettran.batchcode#</font></div></td>
                  <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#gettran.milcert#</font></div></td>
                  <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#gettran.importpermit#</font></div></td>
                  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#NumberFormat(gettran.sumqty,"0")#</font></div></td>
                  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#gettran.unit#</font></div></td>
                  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#NumberFormat(gettran.suminv,stDecl_UPrice)#</font></div></td>
                  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#NumberFormat(gettran.sumcs,stDecl_UPrice)#</font></div></td>
                  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#NumberFormat(gettran.sumdn,stDecl_UPrice)#</font></div></td>
                  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#NumberFormat(gettran.total,stDecl_UPrice)#</font></div></td>
                  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#NumberFormat(gettran.sumcn,stDecl_UPrice)#</font></div></td>
                </tr>
              </cfloop>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <cfif checkcustom.customcompany eq "Y">
                  <td></td>
                </cfif>
                <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(zqty,"0")#</font></div></td>
                <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(zinv,stDecl_UPrice)#</font></div></td>
                <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(zcs,stDecl_UPrice)#</font></div></td>
                <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(zdn,stDecl_UPrice)#</font></div></td>
                <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(ztotal,stDecl_UPrice)#</font></div></td>
                <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(zcn,stDecl_UPrice)#</font></div></td>
              </tr>
            </cfloop>
            <tr>
              <td><br></td>
            </tr>
            <tr>
              <td></td>
              <td></td>
              <td></td>
              <cfif checkcustom.customcompany eq "Y">
                <td></td>
              </cfif>
              <td><div align="left"><font size="1" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
              <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(yqty,"0")#</font></div></td>
              <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(yinv,stDecl_UPrice)#</font></div></td>
              <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(ycs,stDecl_UPrice)#</font></div></td>
              <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(ydn,stDecl_UPrice)#</font></div></td>
              <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(ytotal,stDecl_UPrice)#</font></div></td>
              <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(ycn,stDecl_UPrice)#</font></div></td>
            </tr>
          </cfloop>
        </cfloop>
        <tr>
          <td><br>
            <br></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <cfif checkcustom.customcompany eq "Y">
          <td></td>
          <td></td>
          </cfif>
          <td></td>
            <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Grand Total:</strong></font></div></td>       
          <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>#numberformat(xqty,"0")#</strong></font></div></td>
          <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>#numberformat(xinv,stDecl_UPrice)#</strong></font></div></td>
          <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>#numberformat(xcs,stDecl_UPrice)#</strong></font></div></td>
          <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>#numberformat(xdn,stDecl_UPrice)#</strong></font></div></td>
          <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>#numberformat(xtotal,stDecl_UPrice)#</strong></font></div></td>
          <td nowrap width="7%" class="bstyle"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>#numberformat(xcn,stDecl_UPrice)#</strong></font></div></td>
        </tr>
      </cfif>
    </table>
    <cfif getlocation.recordcount eq 0>
      <h3>Sorry, No records were found.</h3>
    </cfif>
  </cfoutput> <br>
  <br>
  <div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
  <p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
  </body>
  </html>
  </cfcase>
</cfswitch>
