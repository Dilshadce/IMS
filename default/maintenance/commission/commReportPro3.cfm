<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
	<cfquery name="getgeneral" datasource="#dts#">
	select 
	compro,
	lastaccyear 
	from gsetup;
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select 
	decl_uprice 
	from gsetup2;
</cfquery>

<cfset dts1=replace(dts,'_i','_a','all')>


<cfquery name="getglpost" datasource="#dts#">
select entry 
from #dts1#.glpost  
where acc_code='INV'
</cfquery>

<cfset glpostvaluelist=valuelist(getglpost.entry)>

<cfquery name="getarpost" datasource="#dts#">
select post_ID from #dts1#.arpost where entry in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#glpostvaluelist#">)
</cfquery>
<cfset arpostvaluelist=valuelist(getarpost.post_ID)>

<cfquery name="getcate" datasource="#dts#">
select * from iccate where 0=0

<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
and cate between '#form.catefrom#' and '#form.cateto#'
</cfif>
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
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
    <Style ss:ID="s50">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
              <Style ss:ID="s51">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		   			
		  		</Style>  
                
                 <Style ss:ID="s52">
		   			<Borders>
					
		   			</Borders>
		  		</Style>
                                 <Style ss:ID="s53">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>  
                
	</Styles>
	<Worksheet ss:Name="SALES REPORT DETAIL BY CUSTOMER">
	<cfoutput>
	<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="100.25"/>
					<Column ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
                    <Column ss:AutoFitWidth="0" ss:Width="100.75"/>

					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
						<cfset c=c+1>
                        
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Agent Product Sales Commission Report</Data></Cell>
	</Row>

	<cfif form.periodfrom neq "" and form.periodto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
</Row>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">DATE: #lsdateformat(form.datefrom,"dd/mm/yyyy")# - #lsdateformat(form.dateto,"dd/mm/yyyy")#</Data></Cell>
				</Row>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">AGENT: #form.agentfrom# - #form.agentto#</Data></Cell>
</Row>
			</cfif>
			
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">CUST_NO: #form.custfrom# - #form.custto#</Data></Cell>
</Row>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">CATEGORY: #form.catefrom# - #form.cateto#</Data></Cell>
</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">GROUP: #form.groupfrom# - #form.groupto#</Data></Cell>
</Row>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">ITEM_NO: #form.itemfrom# - #form.itemto#</Data></Cell>
</Row>
			</cfif>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
             <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
              <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd-mm-yyyy")#" output = "wddxText2">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                     <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                      <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                       <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                         <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                          <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                           <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
</Row>
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				 <Cell ss:StyleID="s50"><Data ss:Type="String">Date.</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Ref No.</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Sales Man.</Data></Cell>
                  <Cell ss:StyleID="s50"><Data ss:Type="String">Item No.</Data></Cell>
				 <Cell ss:StyleID="s50"><Data ss:Type="String">Description.</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Qty</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Uom</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Price</Data></Cell>
               <Cell ss:StyleID="s50"><Data ss:Type="String">Line Disc %</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Disc. Amt</Data></Cell>
               <Cell ss:StyleID="s50"><Data ss:Type="String">Line Amt</Data></Cell>
               <Cell ss:StyleID="s50"><Data ss:Type="String">Bill Disc %</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Bill Disc Amt</Data></Cell>
                 <Cell ss:StyleID="s50"><Data ss:Type="String">Net Amt</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Comm %</Data></Cell>
               <Cell ss:StyleID="s50"><Data ss:Type="String">Comm Amt</Data></Cell>
</Row>
            <cfset totalnet = 0>
            <cfset totalcomm = 0>
            <cfset totallineamt = 0>
            <cfset subnet = 0>
            <cfset subcomm = 0>
 <cfquery name="getagent" datasource="#dts#">
select b.agenno from ictran as a

left join(
select net,disp1,fperiod,agenno,refno from artran where type='INV' and (void='' or void is null)

)as b on a.refno=b.refno

where  b.net>=0
and (a.void='' or a.void is null) and a.type='INV'

<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
and a.custno between '#form.custfrom#' and '#form.custto#'
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and a.wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
</cfif>
<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
and a.itemno between '#form.itemfrom#' and '#form.itemto#'
</cfif>
<cfif form.agentfrom neq "" and form.agentto neq "">
and b.agenno between '#form.agentfrom#' and '#form.agentto#'
</cfif>

<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
and a.cate between '#form.catefrom#' and '#form.cateto#'
</cfif>

<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
</cfif>
group by b.agenno
</cfquery>
            <cfloop query="getagent">
          
            <cfset subnet = 0>
            <cfset subcomm = 0>
 <cfset sublineamt = 0>
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:StyleID="s51"><Data ss:Type="String">Agent : #getagent.agenno#</Data></Cell>
					</Row>
<cfquery name="showcomm" datasource="#dts#">
select ifnull(b.disp1,0) as disp1,a.itemno,a.desp,a.category,c.brand,c.wos_group,a.refno,a.type,ifnull(a.price,0) as price,ifnull(a.dispec1,0) as dispec1,ifnull(a.disamt,0) as disamt,ifnull(a.amt,0) as amt,a.wos_date,b.agenno,a.qty,ifnull(b.disp1,0) as disp1,a.unit from ictran as a

left join(
select net,disp1,fperiod,agenno,refno from artran where type='INV' and (void='' or void is null)

)as b on a.refno=b.refno

left join(
select itemno,category,wos_group,brand from icitem 
)as c on a.itemno=c.itemno

where  b.net>=0
and (a.void='' or a.void is null) and a.type='INV'

<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
and a.custno between '#form.custfrom#' and '#form.custto#'
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and a.wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
</cfif>
<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
and a.itemno between '#form.itemfrom#' and '#form.itemto#'
</cfif>
and b.agenno ='#getagent.agenno#'


<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
and a.cate between '#form.catefrom#' and '#form.cateto#'
</cfif>

<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
</cfif>
</cfquery>

            
            <cfloop query="showcomm">
            
            <cfquery name="getcommission" datasource="#dts#">
            select ifnull(b.rate,0) as rate from commission a,commrate b
            where a.commname=b.commname
            and 
            (1=0
			<cfif showcomm.category neq "">or a.cate="#showcomm.category#"</cfif>
            <cfif showcomm.wos_group neq "">or a.wos_group="#showcomm.wos_group#"</cfif>
            <cfif showcomm.brand neq "">or a.brand="#showcomm.brand#"</cfif>)
            </cfquery>
            
             <Row ss:AutoFitHeight="0" ss:Height="20.0625">
						 <Cell ss:StyleID="s52"><Data ss:Type="String">#dateformat(showcomm.wos_date,'DD/MM/YYYY')#</Data></Cell>
						<Cell ss:StyleID="s52"><Data ss:Type="String">#showcomm.refno#</Data></Cell>
                        <Cell ss:StyleID="s52"><Data ss:Type="String">#showcomm.agenno#</Data></Cell>
                        <Cell ss:StyleID="s52"><Data ss:Type="String">#showcomm.itemno#</Data></Cell>
                        <Cell ss:StyleID="s52"><Data ss:Type="String">#showcomm.desp#</Data></Cell>
                        <Cell ss:StyleID="s52"><Data ss:Type="String">#showcomm.qty#</Data></Cell>
                          <Cell ss:StyleID="s52"><Data ss:Type="String">#showcomm.unit#</Data></Cell>
                          <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(showcomm.price,stDecl_UPrice)#</Data></Cell>
                          <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(showcomm.dispec1,stDecl_UPrice)#</Data></Cell>
                           <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(showcomm.disamt,stDecl_UPrice)#</Data></Cell>
                           <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(showcomm.amt,stDecl_UPrice)#</Data></Cell>
                             <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(showcomm.disp1,stDecl_UPrice)#</Data></Cell>
                          <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat((showcomm.disp1/100)*showcomm.amt,stDecl_UPrice)#</Data></Cell>
                          <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(((100-showcomm.disp1)/100)*showcomm.amt,stDecl_UPrice)#</Data></Cell>
                        
						<Cell ss:StyleID="s52"><Data ss:Type="String">#getcommission.rate#</Data></Cell>
                        <Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat((((100-val(showcomm.disp1))/100)*val(showcomm.amt))*(val(getcommission.rate)/100),stDecl_UPrice)#</Data></Cell>
</Row>


            <cfset totalnet = totalnet+((100-val(showcomm.disp1))/100)*val(showcomm.amt)>
            <cfset totalcomm = totalcomm+(((100-val(showcomm.disp1))/100)*val(showcomm.amt))*(val(getcommission.rate)/100)>
            <cfset totallineamt = totallineamt + showcomm.amt>
            <cfset subnet = subnet+((100-val(showcomm.disp1))/100)*val(showcomm.amt)>
            <cfset sublineamt =sublineamt+showcomm.amt>
            <cfset subcomm = subcomm+(((100-val(showcomm.disp1))/100)*val(showcomm.amt))*(val(getcommission.rate)/100)>
           
            </cfloop>
            
           <Row ss:AutoFitHeight="0" ss:Height="20.0625">
           <Cell ss:StyleID="s53"><Data ss:Type="String">Total:</Data></Cell>
			<Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String">#numberformat(sublineamt,stDecl_UPrice)#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s53"><Data ss:Type="String">#numberformat(subnet,stDecl_UPrice)#</Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>

			<Cell ss:StyleID="s53"><Data ss:Type="String">#numberformat(subcomm,stDecl_UPrice)#</Data></Cell>                          
</Row>
             <Row ss:AutoFitHeight="0" ss:Height="20.0625"><Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell></Row>
 
             </cfloop>
 <Row ss:AutoFitHeight="0" ss:Height="20.0625"><Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell></Row>
 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
             <Cell ss:StyleID="s53"><Data ss:Type="String">Total:</Data></Cell>
			<Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
          <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
          <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s53"><Data ss:Type="String">#numberformat(totallineamt,stDecl_UPrice)#</Data></Cell>
                      <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>

			<Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s53"><Data ss:Type="String">#numberformat(totalnet,stDecl_UPrice)#</Data></Cell>
            <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s53"><Data ss:Type="String">#numberformat(totalcomm,stDecl_UPrice)#</Data></Cell>                          
</Row>
            <Row ss:AutoFitHeight="0" ss:Height="20.0625"><Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell></Row>
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

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\ProductR_PP_Type_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\ProductR_PP_Type_#huserid#.xls">
	</cfcase>
    
    <cfcase value="HTML">

<cfquery name="getgeneral" datasource="#dts#">
	select 
	compro,
	lastaccyear 
	from gsetup;
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select 
	decl_uprice 
	from gsetup2;
</cfquery>

<cfset dts1=replace(dts,'_i','_a','all')>


<cfquery name="getglpost" datasource="#dts#">
select entry from #dts1#.glpost  where acc_code='INV'
</cfquery>

<cfset glpostvaluelist=valuelist(getglpost.entry)>

<cfquery name="getarpost" datasource="#dts#">
select post_ID from #dts1#.arpost where entry in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#glpostvaluelist#">)
</cfquery>
<cfset arpostvaluelist=valuelist(getarpost.post_ID)>


<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfoutput>
		<table width="100%" border="0" cellspacing="2" cellpadding="0">
			<tr>
				<td colspan="100%" class="title"><div align="center">Agent Product Sales Commission Report</div></td>
			</tr>
			
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">DATE: #lsdateformat(form.datefrom,"dd/mm/yyyy")# - #lsdateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
			
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">CUST_NO: #form.custfrom# - #form.custto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">ITEM_NO: #form.itemfrom# - #form.itemto#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="2"><font size="2" face="Times New Roman,Times,serif"><b>#getgeneral.compro#</b></font></td>
                <td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr><td colspan="100%"><hr></td></tr>
            <tr>
				<th align="left"><font size="2" face="Times New Roman,Times,serif">Date.</font></th>
                <th align="left"><font size="2" face="Times New Roman,Times,serif">Ref No.</font></th>
                <th align="left"><font size="2" face="Times New Roman,Times,serif">Sales Man.</font></th>
                <th align="left"><font size="2" face="Times New Roman,Times,serif">Item No.</font></th>
				<th align="left"><font size="2" face="Times New Roman,Times,serif">Description.</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Qty</font></th>
                <th align="left"><font size="2" face="Times New Roman,Times,serif">Uom</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Price</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Line Disc %</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Disc. Amt</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Line Amt</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Bill Disc %</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Bill Disc Amt</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Net Amt</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Comm %</font></th>
                <th align="right"><font size="2" face="Times New Roman,Times,serif">Comm Amt</font></th>
			</tr>
			<tr><td colspan="100%"><hr></td></tr>
            <cfset totalnet = 0>
            <cfset totalcomm = 0>
            <cfset totallineamt = 0>
            <cfset sublineamt = 0>
            <cfset subnet = 0>
            <cfset subcomm = 0>

           
            
            <cfquery name="getagent" datasource="#dts#">
select b.agenno from ictran as a

left join(
select net,disp1,fperiod,agenno,refno from artran where type='INV' and (void='' or void is null)

)as b on a.refno=b.refno

where  b.net>=0
and (a.void='' or a.void is null) and a.type='INV'

<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
and a.custno between '#form.custfrom#' and '#form.custto#'
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and a.wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
</cfif>
<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
and a.itemno between '#form.itemfrom#' and '#form.itemto#'
</cfif>
<cfif form.agentfrom neq "" and form.agentto neq "">
and b.agenno between '#form.agentfrom#' and '#form.agentto#'
</cfif>

<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
and a.category between '#form.catefrom#' and '#form.cateto#'
</cfif>

<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
</cfif>
group by b.agenno
</cfquery>

 <cfloop query="getagent">
  <cfset subnet = 0>
            <cfset subcomm = 0>
 <cfset sublineamt = 0>
   <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td colspan="100%"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u>Agent : #getagent.agenno#</u></strong></font></div></td>
					</tr>
            
          <!---  <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td colspan="100%"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u>Category : #getcate.cate#</u></strong></font></div></td>
					</tr>--->
<cfquery name="showcomm" datasource="#dts#">
select ifnull(b.disp1,0) as disp1,a.itemno,a.desp,a.category,c.brand,c.wos_group,a.refno,a.type,ifnull(a.price,0) as price,ifnull(a.dispec1,0) as dispec1,ifnull(a.disamt,0) as disamt,ifnull(a.amt,0) as amt,a.wos_date,b.agenno,a.qty,ifnull(b.disp1,0) as disp1,a.unit from ictran as a

left join(
select net,disp1,fperiod,agenno,refno from artran where type='INV' and (void='' or void is null)

)as b on a.refno=b.refno

left join(
select itemno,category,wos_group,brand from icitem 
)as c on a.itemno=c.itemno

where  b.net>=0
and (a.void='' or a.void is null) and a.type='INV'

<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
and a.custno between '#form.custfrom#' and '#form.custto#'
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and a.wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
</cfif>
<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
and a.itemno between '#form.itemfrom#' and '#form.itemto#'
</cfif>
and b.agenno ='#getagent.agenno#'


<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
and a.category between '#form.catefrom#' and '#form.cateto#'
</cfif>

<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
</cfif>
</cfquery>
            
            <cfloop query="showcomm">
            
            <cfquery name="getcommission" datasource="#dts#">
            select ifnull(b.rate,0) as rate from commission a,commrate b
            where a.commname=b.commname
            and 
            (1=0
			<cfif showcomm.category neq "">or a.cate="#showcomm.category#"</cfif>
            <cfif showcomm.wos_group neq "">or a.wos_group="#showcomm.wos_group#"</cfif>
            <cfif showcomm.brand neq "">or a.brand="#showcomm.brand#"</cfif>)
            </cfquery>
            
            
            <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#dateformat(showcomm.wos_date,'DD/MM/YYYY')#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#showcomm.refno#</font></div></td>
                        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#showcomm.agenno#</font></div></td>
                        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#showcomm.itemno#</font></div></td>
                        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#showcomm.desp#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#showcomm.qty#</font></div></td>
                          <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#showcomm.unit#</font></div></td>
                           <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(showcomm.price,stDecl_UPrice)#</font></div></td>
                           <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(showcomm.dispec1,stDecl_UPrice)#</font></div></td>
                           <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(showcomm.disamt,stDecl_UPrice)#</font></div></td>
                           <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(showcomm.amt,stDecl_UPrice)#</font></div></td>
                           <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(showcomm.disp1,stDecl_UPrice)#</font></div></td>
                           <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat((showcomm.disp1/100)*showcomm.amt,stDecl_UPrice)#</font></div></td>
                           <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(((100-showcomm.disp1)/100)*showcomm.amt,stDecl_UPrice)#</font></div></td>
                        
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getcommission.rate#</font></div></td>
                        <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat((((100-val(showcomm.disp1))/100)*val(showcomm.amt))*(val(getcommission.rate)/100),stDecl_UPrice)#</font></div></td>
					</tr>
            <cfset totalnet = totalnet+((100-val(showcomm.disp1))/100)*val(showcomm.amt)>
            <cfset totalcomm = totalcomm+(((100-val(showcomm.disp1))/100)*val(showcomm.amt))*(val(getcommission.rate)/100)>
            <cfset totallineamt = totallineamt+showcomm.amt>
           <cfset sublineamt = sublineamt+showcomm.amt>
           
            <cfset subnet = subnet+((100-val(showcomm.disp1))/100)*val(showcomm.amt)>
            <cfset subcomm = subcomm+(((100-val(showcomm.disp1))/100)*val(showcomm.amt))*(val(getcommission.rate)/100)>
           
            </cfloop>
            
            <tr><td colspan="100%"><hr></td></tr>
            <tr>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u><b>Total:</b></u></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
           <td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(sublineamt,stDecl_UPrice)#</b></u></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(subnet,stDecl_UPrice)#</b></u></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(subcomm,stDecl_UPrice)#</b></u></font></div></td>                          
			</tr>
            <tr><td colspan="100%"><hr></td></tr>
            <tr><td colspan="100%">&nbsp;</td></tr>
            </cfloop>
            <tr><td colspan="100%"><hr></td></tr>
            <tr>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u><b>Total:</b></u></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totallineamt,stDecl_UPrice)#</b></u></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totalnet,stDecl_UPrice)#</b></u></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totalcomm,stDecl_UPrice)#</b></u></font></div></td>                          
			</tr>
            <tr><td colspan="100%"><hr></td></tr>
                </table>
                
                </cfoutput>
                </cfcase></cfswitch>
                
                
            
				