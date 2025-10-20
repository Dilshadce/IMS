<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
  <cfset dd=#dateformat(form.datefrom, "DD")#>
  <cfif dd greater than '12'>
    <cfset ndatefrom=#dateformat(form.datefrom,"YYYYMMDD")#>
    <cfelse>
    <cfset ndatefrom=#dateformat(form.datefrom,"YYYYDDMM")#>
  </cfif>
  <cfset dd=#dateformat(form.dateto, "DD")#>
  <cfif dd greater than '12'>
    <cfset ndateto=#dateformat(form.dateto,"YYYYMMDD")#>
    <cfelse>
    <cfset ndateto=#dateformat(form.dateto,"YYYYDDMM")#>
  </cfif>
</cfif>
<cfif type eq "ref">
  <cfquery name="getdata" datasource="#dts#">
		select a.itemno,a.desp,b.*,c.* from icitem a,ictran b,iserial c where a.itemno = b.itemno
		and b.itemno = c.itemno	and b.refno = c.refno 
		and a.wserialno = 'T'
		<cfif form.dtype neq "">
		and c.type = '#form.dtype#'
		<cfelse>
		and (c.type <> 'QUO' or c.type <> 'SO' or c.type <> 'PO' or c.type <> 'SAM')
		</cfif>
        <cfif form.serialfrom neq "" and form.serialto neq "">
		and c.serialno >='#form.serialfrom#' and c.serialno <='#form.serialto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
		</cfif>
		<cfif form.locfrom neq "" and form.locto neq "">
		and c.location >= '#form.locfrom#' and c.location <= '#form.locto#'
		</cfif>
        and (c.void='' or c.void is null)
        <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and b.itemno >='#form.productfrom#' and b.itemno <='#form.productto#'
        </cfif>
        group by b.type,b.refno,c.serialno
		order by c.serialno,b.trdatetime,c.type,c.refno,c.wos_date
	</cfquery>
  <cfelseif type eq "item">
  <cfif isdefined("form.serialstatus") and form.serialstatus neq "All">
    <cfif form.serialstatus eq "Used">
      <cfquery name="getdata" datasource="#dts#">
                select a.itemno,a.desp,b.type,b.refno,b.wos_date,b.custno,b.location,c.serialno
                from icitem a,ictran b,iserial c,
                (select a.serialno,a.itemno,a.location,ifnull((ifnull(b.cntin,0) - ifnull(c.cntout,0)),0) as balance
                from iserial a
                left join
                (Select count(serialno) as cntin,serialno,itemno,location
                from iserial
                where sign='1'
                and (type <> 'QUO' or type <> 'SO' or type <> 'PO' or type <> 'SAM')
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and itemno >='#form.productfrom#' and itemno <='#form.productto#'
                </cfif>
                <cfif trim(form.serialfrom) neq "" and trim(form.serialto) neq "">
                    and serialno >='#form.serialfrom#' and serialno <='#form.serialto#'
                </cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and wos_date >= '#ndatefrom#' and wos_date <='#ndateto#'
                </cfif>
                <cfif form.locfrom neq "" and form.locto neq "">
                    and location >= '#form.locfrom#' and location <='#form.locto#'
                </cfif>
                and (void='' or void is null)
                group by serialno,itemno,location) as b on (a.serialno=b.serialno and a.itemno=b.itemno and a.location=b.location)
                left join (
                select count(serialno) as cntout,serialno,itemno,location,void
                from iserial
                where sign='-1'
                and (type <> 'QUO' or type <> 'SO' or type <> 'PO' or type <> 'SAM')
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and itemno >='#form.productfrom#' and itemno <='#form.productto#'
                </cfif>
                <cfif trim(form.serialfrom) neq "" and trim(form.serialto) neq "">
                    and serialno >='#form.serialfrom#' and serialno <='#form.serialto#'
                </cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and wos_date >= '#ndatefrom#' and wos_date <='#ndateto#'
                </cfif>
                <cfif form.locfrom neq "" and form.locto neq "">
                    and location >= '#form.locfrom#' and location <='#form.locto#'
                </cfif>
                and (void='' or void is null)
                group by serialno,itemno,location)as c on (a.serialno=c.serialno and a.itemno=c.itemno and a.location=c.location)
                where (a.type <> 'QUO' or a.type <> 'SO' or a.type <> 'PO' or a.type <> 'SAM')
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and a.itemno >='#form.productfrom#' and a.itemno <='#form.productto#'
                </cfif>
                <cfif trim(form.serialfrom) neq "" and trim(form.serialto) neq "">
                    and a.serialno >='#form.serialfrom#' and a.serialno <='#form.serialto#'
                </cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and a.wos_date >= '#ndatefrom#' and a.wos_date <='#ndateto#'
                </cfif>
                <cfif form.locfrom neq "" and form.locto neq "">
                    and a.location >= '#form.locfrom#' and a.location <='#form.locto#'
                </cfif>
                <cfif form.serialstatus eq "Used">
                    and ifnull((ifnull(b.cntin,0) - ifnull(c.cntout,0)),0) = 0
                <cfelse>
                    and ifnull((ifnull(b.cntin,0) - ifnull(c.cntout,0)),0) > 0
                </cfif>
                
                group by a.serialno,a.itemno,a.location) as d
                where a.itemno = b.itemno
                and b.itemno = c.itemno
                and c.serialno=d.serialno
                and c.itemno=d.itemno
                and c.location=d.location
                and b.refno = c.refno
                and (c.void='' or c.void is null)
                and b.type = c.type
                and a.wserialno = 'T'
                and (c.type <> 'QUO' or c.type <> 'SO' or c.type <> 'PO' or c.type <> 'SAM')
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and c.itemno >='#form.productfrom#' and c.itemno <='#form.productto#'
                </cfif>
                <cfif trim(form.serialfrom) neq "" and trim(form.serialto) neq "">
                    and c.serialno >='#form.serialfrom#' and c.serialno <='#form.serialto#'
                </cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and b.wos_date >= '#ndatefrom#' and b.wos_date <='#ndateto#'
                </cfif>
                <cfif form.locfrom neq "" and form.locto neq "">
                    and c.location >= '#form.locfrom#' and c.location <='#form.locto#'
                </cfif>
                order by c.serialno,b.trdatetime,c.itemno,c.wos_date;
            </cfquery>
      <cfelse>
      <cfquery name="getdata" datasource="#dts#">
             select a.*,c.itemno,c.desp from iserial as a
   			left join 
    (select itemno,desp from icitem where 0=0
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno >='#form.productfrom#' and itemno <='#form.productto#'
	</cfif>
    )as c on a.itemno=c.itemno
    left join
    (select a.serialno,a.itemno,c.void,a.location,ifnull((ifnull(b.cntin,0) - ifnull(c.cntout,0)),0) as balance
                from iserial a
                left join
                (Select count(serialno) as cntin,serialno,itemno,location
                from iserial
                where sign='1'
                and (type <> 'QUO' or type <> 'SO' or type <> 'PO' or type <> 'SAM')
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and itemno >='#form.productfrom#' and itemno <='#form.productto#'
                </cfif>
                <cfif trim(form.serialfrom) neq "" and trim(form.serialto) neq "">
                    and serialno >='#form.serialfrom#' and serialno <='#form.serialto#'
                </cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and wos_date >= '#ndatefrom#' and wos_date <='#ndateto#'
                </cfif>
                <cfif form.locfrom neq "" and form.locto neq "">
                    and location >= '#form.locfrom#' and location <='#form.locto#'
                </cfif>
                and (void='' or void is null)
                group by serialno,itemno,location) as b on (a.serialno=b.serialno and a.itemno=b.itemno and a.location=b.location)
                left join (
                select count(serialno) as cntout,serialno,itemno,location,void
                from iserial
                where sign='-1'
                and (type <> 'QUO' or type <> 'SO' or type <> 'PO' or type <> 'SAM')
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and itemno >='#form.productfrom#' and itemno <='#form.productto#'
                </cfif>
                <cfif trim(form.serialfrom) neq "" and trim(form.serialto) neq "">
                    and serialno >='#form.serialfrom#' and serialno <='#form.serialto#'
                </cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and wos_date >= '#ndatefrom#' and wos_date <='#ndateto#'
                </cfif>
                <cfif form.locfrom neq "" and form.locto neq "">
                    and location >= '#form.locfrom#' and location <='#form.locto#'
                </cfif>
                and (void='' or void is null)
                group by serialno,itemno,location)as c on (a.serialno=c.serialno and a.itemno=c.itemno and a.location=c.location)
                where (a.type <> 'QUO' or a.type <> 'SO' or a.type <> 'PO' or a.type <> 'SAM')
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and a.itemno >='#form.productfrom#' and a.itemno <='#form.productto#'
                </cfif>
                <cfif trim(form.serialfrom) neq "" and trim(form.serialto) neq "">
                    and a.serialno >='#form.serialfrom#' and a.serialno <='#form.serialto#'
                </cfif>
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and a.wos_date >= '#ndatefrom#' and a.wos_date <='#ndateto#'
                </cfif>
                <cfif form.locfrom neq "" and form.locto neq "">
                    and a.location >= '#form.locfrom#' and a.location <='#form.locto#'
                </cfif>
                group by a.serialno,a.itemno,a.location) as d on d.serialno=a.serialno and d.itemno=a.itemno
    where 0=0
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno >='#form.productfrom#' and a.itemno <='#form.productto#'
	</cfif>
	<cfif form.locfrom neq "" and form.locto neq "">
		and a.location >= '#form.locfrom#' and a.location <='#form.locto#'
	</cfif>
    <cfif form.serialfrom neq "" and form.serialto neq "">
		and a.serialno >='#form.serialfrom#' and a.serialno <='#form.serialto#'
	</cfif>
     <cfif form.serialstatus eq "Used">
                    and d.balance = 0
     <cfelse>
                    and d.balance > 0
     </cfif>

    group by a.serialno
		order by a.itemno,a.serialno,a.wos_date
            </cfquery>
    </cfif>
    <cfelse>
    <cfquery name="getdata" datasource="#dts#">
            select a.itemno,a.desp,b.*,c.* from icitem a,ictran b,iserial c where a.itemno = b.itemno
		and b.itemno = c.itemno	and b.refno = c.refno 
		and a.wserialno = 'T'
		and (c.type <> 'QUO' or c.type <> 'SO' or c.type <> 'PO' or c.type <> 'SAM')
        <cfif form.serialfrom neq "" and form.serialto neq "">
		and c.serialno >='#form.serialfrom#' and c.serialno <='#form.serialto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
		</cfif>
		<cfif form.locfrom neq "" and form.locto neq "">
		and c.location >= '#form.locfrom#' and c.location <= '#form.locto#'
		</cfif>
        and (c.void='' or c.void is null)
        <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and b.itemno >='#form.productfrom#' and b.itemno <='#form.productto#'
        </cfif>
        and (c.void='' or c.void is null)
        group by b.type,b.refno,c.serialno
		order by c.serialno,b.trdatetime,c.type,c.refno,c.wos_date
		</cfquery>
  </cfif>
  <cfelseif type eq "status">
  <cfquery name="getdata" datasource="#dts#">
    select a.*,c.itemno,c.desp from iserial as a
    left join 
    (select itemno,desp from icitem where 0=0
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno >='#form.productfrom#' and itemno <='#form.productto#'
	</cfif>
    )as c on a.itemno=c.itemno
    where 0=0
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno >='#form.productfrom#' and a.itemno <='#form.productto#'
	</cfif>
	<cfif form.locfrom neq "" and form.locto neq "">
		and a.location >= '#form.locfrom#' and a.location <='#form.locto#'
	</cfif>
    <cfif form.serialfrom neq "" and form.serialto neq "">
		and a.serialno >='#form.serialfrom#' and a.serialno <='#form.serialto#'
	</cfif>
    and (a.void='' or a.void is null)
    group by a.serialno
		order by a.itemno,a.serialno,a.wos_date

	</cfquery>
  <cfelseif type eq "sale">
  <cfquery name="getdata" datasource="#dts#">
		select a.itemno,a.desp,b.*,c.* from icitem a,ictran b,iserial c where a.itemno = b.itemno
        and b.itemno = c.itemno	and b.refno = c.refno 
		and (c.type = 'INV' or c.type = 'CS' or c.type = 'DN' or c.type = 'CN' or c.type = 'DO' or c.type = 'OAR')
		and a.wserialno = 'T'
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and c.itemno >='#form.productfrom#' and c.itemno <='#form.productto#'
		</cfif>
		<cfif form.serialfrom neq "" and form.serialto neq "">
		and c.serialno >='#form.serialfrom#' and c.serialno <='#form.serialto#'
		</cfif>
		<cfif form.locfrom neq "" and form.locto neq "">
		and c.location >= '#form.locfrom#' and c.location <='#form.locto#'
		</cfif>
        <cfif form.custfrom neq "" and form.custto neq "">
		and b.custno >= '#form.custfrom#' and b.custno <='#form.custto#'
		</cfif>
        and (c.void='' or c.void is null)
        group by b.type,b.refno,c.serialno
		order by c.itemno,c.serialno,c.wos_date
	</cfquery>
</cfif>

<cfswitch expression="#form.result#">
  <cfcase value="EXCELDEFAULT">
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
      <Style ss:ID="s30">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="@"/>
	</Style>
      <Style ss:ID="s32">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
      <Style ss:ID="s34">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
	</Style>
    </Styles>
    <Worksheet ss:Name="Others Report"><cfoutput>
        <cfif type eq "ref">
          <Table ss:ExpandedColumnCount="8" x:FullColumns="1" x:FullRows="1">
            <Column ss:AutoFitWidth="0" ss:Width="73.75"/>
            <Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="4"/>
            <Column ss:AutoFitWidth="0" ss:Width="100.75"/>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:MergeAcross="6" ss:StyleID="s22">
                <Data ss:Type="String">Transaction Listing by Reference No</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
              <Cell ss:MergeAcross="4" ss:StyleID="s26">
                <Data ss:Type="String">#wddxText1#</Data>
              </Cell>
              <Cell ss:StyleID="s26">
                <Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Type</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Refno</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Date</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item Description</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Serial No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Customer No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Location</Data>
              </Cell>
            </Row>
            <cfloop query="getdata">
              <cfif type eq 'RC'>
                <cfquery name="getcust" datasource="#dts#">
					select name from #target_apvend# where custno = '#custno#'
				</cfquery>
                <cfelse>
                <cfquery name="getcust" datasource="#dts#">
					select name from #target_arcust# where custno = '#custno#'
				</cfquery>
              </cfif>
              <cfwddx action = "cfml2wddx" input = "#type#" output = "wddxText1">
              <cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText2">
              <cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText3">
              <cfwddx action = "cfml2wddx" input = "#serialno#" output = "wddxText4">
              <cfwddx action = "cfml2wddx" input = "#custno# - #getcust.name#" output = "wddxText5">
              <cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText6">
              <cfwddx action = "cfml2wddx" input = "#location#" output = "wddxText7">
              <Row ss:AutoFitHeight="0" ss:Height="12">
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText1#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText2#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#dateformat(wos_date,"dd/mm/yy")#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText3#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText6#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText4#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText5#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText7#</Data>
                </Cell>
              </Row>
            </cfloop>
          </Table>
          <cfelseif type eq "item">
          <Table ss:ExpandedColumnCount="9" x:FullColumns="1" x:FullRows="1">
            <Column ss:AutoFitWidth="0" ss:Width="73.75"/>
            <Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="4"/>
            <Column ss:AutoFitWidth="0" ss:Width="100.75"/>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:MergeAcross="6" ss:StyleID="s22">
                <Data ss:Type="String">Transaction Listing by Item</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
              <Cell ss:MergeAcross="5" ss:StyleID="s26">
                <Data ss:Type="String">#wddxText1#</Data>
              </Cell>
              <Cell ss:StyleID="s26">
                <Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item No</Data>
              </Cell>
              <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
                <Cell ss:StyleID="s27">
                  <Data ss:Type="String">Product Code</Data>
                </Cell>
              </cfif>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item Description</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Serial No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Type</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Refno</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Date</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Customer No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Location</Data>
              </Cell>
            </Row>
            <cfloop query="getdata">
              <cfif type eq 'RC'>
                <cfquery name="getcust" datasource="#dts#">
					select name from #target_apvend# where custno = '#custno#'
				</cfquery>
                <cfelse>
                <cfquery name="getcust" datasource="#dts#">
					select name from #target_arcust# where custno = '#custno#'
				</cfquery>
              </cfif>
              <cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText1">
              <cfwddx action = "cfml2wddx" input = "#serialno#" output = "wddxText2">
              <cfwddx action = "cfml2wddx" input = "#type#" output = "wddxText3">
              <cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText4">
              <cfwddx action = "cfml2wddx" input = "#custno# - #getcust.name#" output = "wddxText5">
              <cfwddx action = "cfml2wddx" input = "#location#" output = "wddxText6">
              <cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText7">
              <cfquery name="getproductcode" datasource="#dts#">
                    select aitemno,desp from icitem where itemno='#itemno#'
                    </cfquery>
              <cfwddx action = "cfml2wddx" input = "#getproductcode.aitemno#" output = "wddxText8">
              <Row ss:AutoFitHeight="0" ss:Height="12">
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText1#</Data>
                </Cell>
                <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
                  <Cell ss:StyleID="s28">
                    <Data ss:Type="String">#wddxText8#</Data>
                  </Cell>
                </cfif>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText7#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText2#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText3#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText4#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#dateformat(wos_date,"dd/mm/yy")#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText5#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText6#</Data>
                </Cell>
              </Row>
            </cfloop>
          </Table>
          <cfelseif type eq "status">
          <Table ss:ExpandedColumnCount="7" x:FullColumns="1" x:FullRows="1">
            <Column ss:AutoFitWidth="0" ss:Width="73.75"/>
            <Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="3"/>
            <Column ss:AutoFitWidth="0" ss:Width="100.75"/>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:MergeAcross="5" ss:StyleID="s22">
                <Data ss:Type="String">Item - Serial No. Status</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
              <Cell ss:MergeAcross="4" ss:StyleID="s26">
                <Data ss:Type="String">#wddxText1#</Data>
              </Cell>
              <Cell ss:StyleID="s26">
                <Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item Description</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Serial No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">In</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Out</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Bal</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Location</Data>
              </Cell>
            </Row>
            <cfloop query="getdata">
              <cfquery name="getrecord" datasource="#dts#">
				select <!--- a.itemno,b.itemno, --->c.* from <!--- icitem a,ictran b, ---> iserial c where <!--- a.itemno = b.itemno  --->
				<!--- and b.itemno = c.itemno and b.refno = c.refno and --->
				c.serialno = '#serialno#' and (c.type = 'RC' or c.type = 'CN'  or c.type='ADD')
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and c.itemno >='#form.productfrom#' and c.itemno <='#form.productto#'
				</cfif>
				<cfif form.locfrom neq "" and form.locto neq "">
				and c.location >= '#form.locfrom#' and c.location <= '#form.locto#'
				</cfif>
			</cfquery>
              <cfif getrecord.recordcount neq 0>
                <cfset inqty = #getrecord.recordcount#>
                <cfelse>
                <cfset inqty = 0>
              </cfif>
              <cfquery name="getrecord2" datasource="#dts#">
				select <!--- a.itemno,b.*, --->c.* from <!--- icitem a,ictran b, ---> iserial c where <!--- a.itemno = b.itemno
				and b.itemno = c.itemno and b.refno = c.refno and --->
				c.serialno = '#serialno#' and (c.type = 'CS'
				or c.type = 'DN' or c.type = 'INV' or c.type = 'PR' or c.type = 'ISS' or c.type='DO' or c.type = 'OAR')
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and c.itemno >='#form.productfrom#' and c.itemno <='#form.productto#'
				</cfif>
				<cfif form.locfrom neq "" and form.locto neq "">
				and c.location >= '#form.locfrom#' and c.location <='#form.locto#'
				</cfif>
                and (c.void='' or c.void is null)
			</cfquery>
              <cfquery name="getrecord3" datasource="#dts#">
				select <!--- a.itemno, --->b.itemno, c.itemno from  <!--- icitem a, --->ictran b,  iserial c where <!--- a.itemno = b.itemno
				and --->b.type = c.type and b.type = 'DO'  and b.itemno = c.itemno and b.refno = c.refno and
				c.serialno = '#serialno#'

				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and c.itemno >='#form.productfrom#' and c.itemno <='#form.productto#'
				</cfif>
				<cfif form.locfrom neq "" and form.locto neq "">
				and c.location >= '#form.locfrom#' and c.location <='#form.locto#'
				</cfif>
			</cfquery>
              <cfif getrecord2.recordcount neq 0>
                <cfset outqty = #getrecord2.recordcount#>
                <cfelse>
                <cfset outqty = 0>
              </cfif>
              <cfif getrecord3.recordcount neq 0>
                <cfset outqty =  #outqty# + #getrecord3.recordcount#>
              </cfif>
              <cfset bal = #inqty# - #outqty#>
              <cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText1">
              <cfwddx action = "cfml2wddx" input = "#serialno#" output = "wddxText2">
              <cfwddx action = "cfml2wddx" input = "#inqty#" output = "wddxText3">
              <cfwddx action = "cfml2wddx" input = "#outqty#" output = "wddxText4">
              <cfwddx action = "cfml2wddx" input = "#bal#" output = "wddxText5">
                <cfquery name="getlocationdesp" datasource="#dts#">
                    select desp from iclocation where location='#location#';
                </cfquery>
              <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
              	<cfwddx action = "cfml2wddx" input = "#getlocationdesp.desp#" output = "wddxText6">
              <cfelse>
              	<cfwddx action = "cfml2wddx" input = "#location#" output = "wddxText6">
              </cfif>
              <cfquery name="getdesp" datasource="#dts#">
                    select desp from icitem where itemno='#itemno#';
                </cfquery>
              
              <cfwddx action = "cfml2wddx" input = "#getdesp.desp#" output = "wddxText7">
              <Row ss:AutoFitHeight="0" ss:Height="12">
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText1#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText7#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText2#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText3#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">
                    <cfif outqty gt 0>
                      -
                    </cfif>
                    #wddxText4#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText5#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText6#</Data>
                </Cell>
              </Row>
            </cfloop>
          </Table>
          <cfelseif type eq "sale">
          <Table ss:ExpandedColumnCount="7" x:FullColumns="1" x:FullRows="1">
            <Column ss:AutoFitWidth="0" ss:Width="73.75"/>
            <Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="3"/>
            <Column ss:AutoFitWidth="0" ss:Width="100.75"/>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:MergeAcross="5" ss:StyleID="s22">
                <Data ss:Type="String">Serial No. Sales Listing</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
              <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
              <Cell ss:MergeAcross="4" ss:StyleID="s26">
                <Data ss:Type="String">#wddxText1#</Data>
              </Cell>
              <Cell ss:StyleID="s26">
                <Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data>
              </Cell>
            </Row>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Item Description</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Serial No</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Type</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Refno</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Date</Data>
              </Cell>
              <Cell ss:StyleID="s27">
                <Data ss:Type="String">Customer No</Data>
              </Cell>
            </Row>
            <cfloop query="getdata">
              <cfquery name="getcust" datasource="#dts#">
			select name from #target_arcust# where custno = '#custno#'
			</cfquery>
              <cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText1">
              <cfwddx action = "cfml2wddx" input = "#serialno#" output = "wddxText2">
              <cfwddx action = "cfml2wddx" input = "#type#" output = "wddxText3">
              <cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText4">
              <cfwddx action = "cfml2wddx" input = "#custno# - #name#" output = "wddxText5">
              <cfwddx action = "cfml2wddx" input = "#desp#" output = "wddxText6">
              <Row ss:AutoFitHeight="0" ss:Height="12">
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText1#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText6#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText2#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText3#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText4#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#dateformat(wos_date,"dd/mm/yy")#</Data>
                </Cell>
                <Cell ss:StyleID="s28">
                  <Data ss:Type="String">#wddxText5#</Data>
                </Cell>
              </Row>
            </cfloop>
          </Table>
        </cfif>
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
  <cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\OthersR_#type#_#huserid#.xls" output="#tostring(data)#">
  <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\OthersR_#type#_#huserid#.xls">
  <!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\OthersR_#type#_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\OthersR_#type#_#huserid#.xls">
--->
  </cfcase>
  <cfcase value="HTML">
  <html>
  <head>
  <title>Serial Report</title>
  <link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
  <style type="text/css" media="print">
.noprint {
	display: none;
}
</style>
  </head>
  
  <body>
  <cfif type eq "ref">
    <h1 align="center">Transaction Listing by Reference No</h1>
    <table width="100%" border="0" align="center">
        <tr>
      <cfoutput>
        <td colspan="2"><font size="2" face="Times New Roman, Times, serif">
          <cfif getgeneral.compro neq "">
            #getgeneral.compro#
          </cfif>
          </font></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
          </tr>
      </cfoutput>
      <tr>
        <td colspan="8"><hr></td>
      </tr>
      <tr>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Type</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Refno</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Date</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item No</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item Description</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Serial No</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Customer No</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Location</font></div></td>
      </tr>
      <tr>
        <td colspan="8"><hr></td>
      </tr>
      <cfoutput query="getdata">
        <cfif type eq 'RC'>
          <cfquery name="getcust" datasource="#dts#">
			select name from #target_apvend# where custno = '#custno#'
		</cfquery>
          <cfelse>
          <cfquery name="getcust" datasource="#dts#">
			select name from #target_arcust# where custno = '#custno#'
		</cfquery>
        </cfif>
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#type#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#refno#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#serialno#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#custno# - #getcust.name#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#location#</font></div></td>
        </tr>
      </cfoutput>
    </table>
    <cfelseif type eq "item">
    <h1 align="center">Transaction Listing by Item</h1>
    <table width="100%" border="0" align="center">
        <tr>
      <cfoutput>
        <td colspan="2"><font size="2" face="Times New Roman, Times, serif">
          <cfif getgeneral.compro neq "">
            #getgeneral.compro#
          </cfif>
          </font></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
          </tr>
      </cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item No</font></div></td>
        <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Product Code</font></div></td>
        </cfif>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item Description</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Serial No</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Type</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Refno</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Date</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Customer No</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Location</font></div></td>
      </tr>
      <cfoutput query="getdata">
        <cfif isdefined("form.serialstatus") and form.serialstatus neq "Unused">
          <cfif type eq 'RC'>
            <cfquery name="getcust" datasource="#dts#">
                        select name from #target_apvend# where custno = '#custno#'
                    </cfquery>
            <cfelse>
            <cfquery name="getcust" datasource="#dts#">
                        select name from #target_arcust# where custno = '#custno#'
                    </cfquery>
          </cfif>
          <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
            <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
              <cfquery name="getproductcode" datasource="#dts#">
                    select aitemno from icitem where itemno='#itemno#'
                    </cfquery>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.aitemno#</font></div></td>
            </cfif>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#serialno#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#type#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#refno#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#custno# - #getcust.name#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#location#</font></div></td>
          </tr>
          <cfelse>
          <cfquery name="getdata2" datasource="#dts#">
                    select a.* 
                    from iserial a 
                    where (a.type <> 'QUO' or a.type <> 'SO' or a.type <> 'PO' or a.type <> 'SAM')
                    and a.itemno ='#getdata.itemno#'
                    and a.serialno ='#getdata.serialno#'
                    <cfif form.locfrom neq "" and form.locto neq "">
                    and a.location = '#getdata.location#'
                    </cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
                    	and a.wos_date >= '#ndatefrom#' and a.wos_date <='#ndateto#'
                	</cfif>
                    order by a.wos_date <!---desc---> <!---limit #getdata.balance#--->
                </cfquery>
          <cfloop query="getdata2">
            <cfif getdata2.type eq 'RC'>
              <cfquery name="getcust" datasource="#dts#">
                            select name from #target_apvend# where custno = '#getdata2.custno#'
                        </cfquery>
              <cfelse>
              <cfquery name="getcust" datasource="#dts#">
                            select name from #target_arcust# where custno = '#getdata2.custno#'
                        </cfquery>
            </cfif>
            <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata2.itemno#</font></div></td>
              <cfquery name="getproductcode" datasource="#dts#">
                    		SELECT aitemno,desp 
                            FROM icitem 
                            WHERE itemno='#getdata2.itemno#';
                    	</cfquery>
              <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.aitemno#</font></div></td>
              </cfif>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.desp#</font></div></td>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata2.serialno#</font></div></td>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata2.type#</font></div></td>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata2.refno#</font></div></td>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getdata2.wos_date,"dd/mm/yy")#</font></div></td>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata2.custno# - #getcust.name#</font></div></td>
              <cfquery name="getlastseriallocation" datasource="#dts#">
        select location from iserial where serialno='#serialno#' and itemno='#itemno#' and sign='1' order by wos_date desc
        </cfquery>
              <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata2.location#</font></div></td>
            </tr>
          </cfloop>
        </cfif>
      </cfoutput>
    </table>
    <cfelseif type eq "status">
    <h1 align="center">Item - Serial No. Status</h1>
    <table width="100%" border="0" align="center">
        <tr>
      <cfoutput>
        <td colspan="1"><font size="2" face="Times New Roman, Times, serif">
          <cfif getgeneral.compro neq "">
            #getgeneral.compro#
          </cfif>
          </font></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
          </tr>
      </cfoutput>
      <tr>
        <td colspan="7"><hr></td>
      </tr>
      <tr>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item No</font></div></td>
        <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Product Code</font></div></td>
        </cfif>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item Description</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Serial No</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">In</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Out</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Bal</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Location</font></div></td>
      </tr>
      <tr>
        <td colspan="7"><hr></td>
      </tr>
      <cfoutput query="getdata">
        <cfquery name="getrecord" datasource="#dts#">
		select <!--- a.itemno,b.itemno, --->c.* from <!--- icitem a,ictran b, ---> iserial c where <!--- a.itemno = b.itemno  --->
		<!--- and b.itemno = c.itemno and b.refno = c.refno and --->
		c.serialno = '#serialno#' and (c.type = 'RC' or c.type = 'CN' or c.type='OAI' or c.type='ADD')
		and c.itemno ='#getdata.itemno#'
		<cfif form.locfrom neq "" and form.locto neq "">
		and c.location >= '#form.locfrom#' and c.location <= '#form.locto#'
		</cfif>
        and (c.void='' or c.void is null)
	</cfquery>
        <cfif getrecord.recordcount neq 0>
          <cfset inqty = #getrecord.recordcount#>
          <cfelse>
          <cfset inqty = 0>
        </cfif>
        <cfquery name="getrecord2" datasource="#dts#">
		select <!--- a.itemno,b.*, --->c.* from <!--- icitem a,ictran b, ---> iserial c where <!--- a.itemno = b.itemno
		and b.itemno = c.itemno and b.refno = c.refno and --->
		c.serialno = '#serialno#' and (c.type = 'CS'
		or c.type = 'DN' or c.type = 'INV' or c.type = 'PR' or c.type = 'ISS' or c.type = 'OAR')
		and c.itemno ='#getdata.itemno#'
		<cfif form.locfrom neq "" and form.locto neq "">
		and c.location >= '#form.locfrom#' and c.location <='#form.locto#'
		</cfif>
         and (c.void='' or c.void is null)
	</cfquery>
        <cfquery name="getrecord3" datasource="#dts#">
		select <!--- a.itemno, --->b.itemno, c.itemno from  <!--- icitem a, --->ictran b,  iserial c where <!--- a.itemno = b.itemno
		and --->b.type = c.type and b.type = 'DO' and b.itemno = c.itemno and b.refno = c.refno and
		c.serialno = '#serialno#'

		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and c.itemno >='#form.productfrom#' and c.itemno <='#form.productto#'
		</cfif>
		<cfif form.locfrom neq "" and form.locto neq "">
		and c.location >= '#form.locfrom#' and c.location <='#form.locto#'
		</cfif>
         and (c.void='' or c.void is null)
	</cfquery>
        <cfif getrecord2.recordcount neq 0>
          <cfset outqty = #getrecord2.recordcount#>
          <cfelse>
          <cfset outqty = 0>
        </cfif>
        <cfif getrecord3.recordcount neq 0>
          <cfset outqty =  #outqty# + #getrecord3.recordcount#>
        </cfif>
        <cfset bal = #inqty# - #outqty#>
        <!--- <cfif bal gt 0> --->
        <cfquery name="getlastseriallocation" datasource="#dts#">
        select * from (select sum(sign)as sign,location from iserial where serialno='#serialno#' and itemno='#itemno#' and (void='' or void is null)  group by location order by wos_date desc) as b where sign=1
        </cfquery>
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
          <cfquery name="getproductcode" datasource="#dts#">
                SELECT aitemno,desp 
                FROM icitem 
                WHERE itemno='#itemno#';
            </cfquery>
          <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.aitemno#</font></div></td>
          </cfif>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.desp#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#serialno#</font></div></td>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#inqty#</font></div></td>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif">
              <cfif outqty gt 0>
                -
              </cfif>
              #outqty#</font></div></td>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#bal#</font></div></td>
          <cfquery name="getlocationdesp" datasource="#dts#">
        		SELECT desp 
                FROM iclocation 
                WHERE location='#getlastseriallocation.location#'; 
        	</cfquery>
          <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getlocationdesp.desp#</font></div></td>
            <cfelse>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getlastseriallocation.location#</font></div></td>
          </cfif>
        </tr>
        <!--- 	</cfif> ---> 
      </cfoutput>
    </table>
    <cfelseif type eq "sale">
    <h1 align="center">Serial No. Sales Listing</h1>
    <table width="100%" border="0" align="center">
        <tr>
      <cfoutput>
        <td colspan="1"><font size="2" face="Times New Roman, Times, serif">
          <cfif getgeneral.compro neq "">
            #getgeneral.compro#
          </cfif>
          </font></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
          </tr>
      </cfoutput>
      <tr>
        <td colspan="7"><hr></td>
      </tr>
      <tr>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item No</font></div></td>
        <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Product Code</font></div></td>
        </cfif>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item Description</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Serial No</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Type</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Refno</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Date</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Customer No</font></div></td>
      </tr>
      <tr>
        <td colspan="7"><hr></td>
      </tr>
      <cfoutput query="getdata">
        <cfquery name="getcust" datasource="#dts#">
			select name from #target_arcust# where custno = '#custno#'
		</cfquery>
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
          <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
            <cfquery name="getproductcode" datasource="#dts#">
                    select aitemno from icitem where itemno='#itemno#'
                    </cfquery>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.aitemno#</font></div></td>
          </cfif>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#serialno#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#type#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#refno#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
          <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#custno# - #name#</font></div></td>
        </tr>
      </cfoutput>
    </table>
  </cfif>
  <cfif getdata.recordcount eq 0>
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
