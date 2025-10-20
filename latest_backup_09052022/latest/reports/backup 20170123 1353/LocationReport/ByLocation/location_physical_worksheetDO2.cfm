<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,singlelocation from gsetup;
</cfquery>


<cfif isdefined('form.generateitem')>
<cfquery name="getalllocation" datasource="#dts#">
select location from iclocation
</cfquery>
<cfloop query="getalllocation">
<cfquery name="getallitem" datasource="#dts#">
select itemno from icitem
</cfquery>

<cfloop query="getallitem">
<cfquery name="insertlocqdbf" datasource="#dts#">
insert ignore into locqdbf (itemno,location) values ('#getallitem.itemno#','#getalllocation.location#')
</cfquery>

</cfloop>

</cfloop>
</cfif>

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif form.productfrom neq "" and form.productto neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<!---<cfif form.submit eq "print">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,singlelocation from gsetup;
</cfquery></cfif>--->
<cfquery name="getlocation" datasource="#dts#">
	select 
	a.itemno,
    a.aitemno,
    a.category,
    a.wos_group,
	a.shelf,
    a.desp,
    a.unit,
	b.location,
	b.locationdesp,
	c.balance,
    c.locqactual
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
        <cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "" >
		and location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
        a.locqactual,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
            and (void = '' or void is null)
			<cfif form.periodfrom neq ""> 
			and fperiod <='#form.periodfrom#' and fperiod<>'99' 
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif getgeneral.singlelocation eq 'Y'>
            <cfif form.locationfrom neq "">
			and location = '#form.locationfrom#'
			</cfif>
            <cfelse>
			<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.datefrom neq "">
			and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and (void = '' or void is null)
			<cfif form.periodfrom neq "">
			and fperiod <='#form.periodfrom#' and fperiod<>'99'
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif getgeneral.singlelocation eq 'Y'>
			<cfif form.locationfrom neq "">
			and location = '#form.locationfrom#' 
			</cfif>
            <cfelse>
            <cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.datefrom neq "">
			and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
       	<cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "">
		and a.location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
     <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.categoryfrom neq "" and form.categoryto neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
	<cfif form.modelfrom neq "" and form.modelto neq "">
	and a.shelf between '#form.modelfrom#' and '#form.modelto#'
	</cfif>
    <cfif getgeneral.singlelocation eq 'Y'>
    <cfif form.locationfrom neq "" >
	and b.location = '#form.locationfrom#'
	</cfif>
    <cfelse>
	<cfif form.locationfrom neq "" and form.locationto neq "">
	and b.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
    </cfif>
    <cfif form.brandfrom neq "" and form.brandto neq "">
	and a.brand between '#form.brandfrom#' and '#form.brandto#'
	</cfif>
	<cfif not isdefined("form.include_stock")>
	and c.balance<>0
	</cfif> 

	order by b.location;
</cfquery>

<cfquery name="getGSetup" datasource="#dts#">
  	select compro,compro2,compro3,compro4,compro5,compro6,compro7 from gsetup 
</cfquery>

	<!---<cfreport template="REPORT_iCBIL_ServiceOrder.cfr" format="PDF" query="getlocation">


	<cfreportparam name="dts" value="#dts#">
	<cfreportparam name="amsLink" value="#IIF(Hlinkams eq 'Y',DE('yes'),DE('no'))#">
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="itemfrom" value="#form.productfrom#">
    <cfreportparam name="itemto" value="#form.productto#">
    <cfreportparam name="catefrom" value="#form.categoryfrom#">
    <cfreportparam name="cateto" value="#form.categoryto#">
    <cfreportparam name="groupfrom" value="#form.groupfrom#">
    <cfreportparam name="groupto" value="#form.groupto#">
    <cfreportparam name="period" value="#form.periodfrom#">
    <cfreportparam name="locationfrom" value="#form.locationfrom#">
    <cfreportparam name="locationto" value="#form.locationto#">
    </cfreport>--->

<cfif form.datefrom neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset form.datefrom = ndate >
</cfif>
<cfset totalqty=0>
<cfset totalact=0>
<cfquery name="getlocation" datasource="#dts#">
	select 
	a.itemno,
    a.category,
    a.wos_group,
	a.shelf,
	b.location,
	b.locationdesp,
	c.balance 
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
        <cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "" >
		and location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
            and (void = '' or void is null)
			<cfif form.periodfrom neq ""> 
			and fperiod <='#form.periodfrom#' and fperiod<>'99' 
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif getgeneral.singlelocation eq 'Y'>
            <cfif form.locationfrom neq "">
			and location = '#form.locationfrom#'
			</cfif>
            <cfelse>
			<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.datefrom neq "">
			and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and (void = '' or void is null)
			<cfif form.periodfrom neq "">
			and fperiod <='#form.periodfrom#' and fperiod<>'99'
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif getgeneral.singlelocation eq 'Y'>
			<cfif form.locationfrom neq "">
			and location = '#form.locationfrom#' 
			</cfif>
            <cfelse>
            <cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.datefrom neq "">
			and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
       	<cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "">
		and a.location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
     <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.categoryfrom neq "" and form.categoryto neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
	<cfif form.modelfrom neq "" and form.modelto neq "">
	and a.shelf between '#form.modelfrom#' and '#form.modelto#'
	</cfif>
    <cfif getgeneral.singlelocation eq 'Y'>
    <cfif form.locationfrom neq "" >
	and b.location = '#form.locationfrom#'
	</cfif>
    <cfelse>
	<cfif form.locationfrom neq "" and form.locationto neq "">
	and b.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
    </cfif>
    <cfif form.brandfrom neq "" and form.brandto neq "">
	and a.brand between '#form.brandfrom#' and '#form.brandto#'
	</cfif>
	<cfif not isdefined("form.include_stock")>
	and c.balance<>0
	</cfif> 
	group by b.location
	order by b.location;
</cfquery>

 <cfswitch expression="#form.result#">
	<cfcase value="EXCEL">

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
                
                           <Style ss:ID="s90">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>


		 	</Styles>
			
			<Worksheet ss:Name="Location Physical Worksheet DO">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="220.25"/>
					<Column ss:Width="180.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="90.75"/>
					<Column ss:Width="90.75"/>
					<Column ss:Width="90.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
 <cfoutput>
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"><cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Physical Worksheet DO</Data></Cell>
		</Row>
        
	<!--- <cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.categoryfrom# - #form.categoryto#</font></div></td>
		</tr>
	</cfif> --->
	<!--- <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif> --->
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.productfrom# - #form.productto#" output = "wddxText">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">ITEM.NO. #wddxText#</Data></Cell>
		</Row>
	</cfif>
    <cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.categoryfrom# - #form.categoryto#" output = "wddxText">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">CATEGORY : #wddxText#</Data></Cell>
		</Row>
	</cfif>
    <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.groupfrom# - #form.groupto#" output = "wddxText">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">GROUP : #wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.periodfrom neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.periodfrom#" output = "wddxText">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PERIOD: #wddxText#</Data></Cell>
		</Row>
	</cfif>
    
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText2">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText1#</Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
		</Row>
	</cfoutput>
    
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
      	<Cell ss:StyleID="s50"><Data ss:Type="String">NO.</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i")>
        <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
        <Cell ss:StyleID="s50"><Data ss:Type="String">PRODUCT CODE.</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM DESCRIPTION</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">UNIT MEASURED</Data></Cell>
        <cfif lcase(hcomid) eq "ssuni_i">
        <Cell ss:StyleID="s50"><Data ss:Type="String">PRICE</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s50"><Data ss:Type="String">BOOK QTY</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ACTUAL QTY</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ADJ.QTY</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">SHELF</Data></Cell>
	</Row>
	
	<cfoutput query="getlocation">
		<cfset location = getlocation.location>
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getlocation.locationdesp#" output = "wddxText3">
			<Cell ss:StyleID="s41"><Data ss:Type="String"><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif>: #getlocation.location#</Data></Cell>
			<Cell ss:StyleID="s41"><Data ss:Type="String">#wddxText3#</Data></Cell>
		</Row>
        
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			a.itemno,
            a.category,
            a.wos_group,
            a.aitemno,
			a.desp,
			a.unit,
            a.price,
			a.shelf,
			b.location,
			b.locqactual,
			b.balance 
			
			from icitem as a 
					
			left join 
			(
				select 
				a.location,
				a.itemno,
				a.locqactual,
				(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
				
				from locqdbf as a 
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_in 
					
					from ictran
					
					where type in ('RC','CN','OAI','TRIN') 
                    and (void = '' or void is null)
					and location='#location#'
					<cfif form.periodfrom neq ""> 
					and fperiod <='#form.periodfrom#' and fperiod<>'99' 
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
                   
					<cfif form.datefrom neq "">
					and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as b on a.location=b.location and a.itemno=b.itemno
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_out 
					
					from ictran 
					
					where (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    and (void = '' or void is null) 
					and location='#location#'
					<cfif form.periodfrom neq "">
					and fperiod <='#form.periodfrom#' and fperiod<>'99'
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
                  
					<cfif form.datefrom neq "">
					and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as c on a.location=c.location and a.itemno=c.itemno 
				
				where a.location='#location#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
              
			) as b on a.itemno=b.itemno and b.location='#location#'
			
			where b.location='#location#'
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.categoryfrom neq "" and form.categoryto neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif form.modelfrom neq "" and form.modelto neq "">
			and a.shelf between '#form.modelfrom#' and '#form.modelto#'
			</cfif>
			<cfif not isdefined("form.include_stock")>
			and b.balance<>0 
			</cfif> 
            <cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
            <cfif lcase(hcomid) eq "simplysiti_i">
            order by a.itemno;	
            <cfelse>
			order by <cfif isdefined('form.itemdespsort')>a.desp<cfelse>a.shelf,a.itemno</cfif>
            </cfif>	
		</cfquery>
		
		<cfloop query="getiteminfo">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.currentrow#" output = "wddxText4">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.itemno#" output = "wddxText5">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.Aitemno#" output = "wddxText6">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.desp#" output = "wddxText7">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.unit#" output = "wddxText8">
			<cfwddx action = "cfml2wddx" input = "#numberformat(getiteminfo.price,",_.__")#" output = "wddxText9">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.balance#" output = "wddxText10">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.locqactual#" output = "wddxText11">
			<cfwddx action = "cfml2wddx" input = "#val(getiteminfo.balance)-val(getiteminfo.locqactual)#" output = "wddxText12">
			<cfwddx action = "cfml2wddx" input = "#getiteminfo.shelf#" output = "wddxText13">
            
      			  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#.</Data></Cell>
				  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
                <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i")>
                <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
                </cfif>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
                <cfif lcase(hcomid) eq "ssuni_i">
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
                </cfif>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
			</Row>
            <cfset totalqty=totalqty+getiteminfo.balance>
            <cfset totalact=totalact+getiteminfo.locqactual>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			</Row>
	</cfoutput>
    <Row ss:AutoFitHeight="0" ss:Height="20.0625">
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
                  </Row>
    <cfoutput>
    
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
        	<cfwddx action = "cfml2wddx" input = "#totalqty#" output = "wddxText14">
			<cfwddx action = "cfml2wddx" input = "#totalact#" output = "wddxText15">
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    			<cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i")>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
   				 </cfif>
          	<Cell ss:StyleID="s26"><Data ss:Type="String">Total :</Data></Cell>
          	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
          	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
    </Row>
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
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>

            <cfcase value="HTML">

<html>
<head>
<title>Physical Worksheet Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,singlelocation from gsetup;
</cfquery>

<cfset totalqty=0>
<cfset totalact=0>
<cfquery name="getlocation" datasource="#dts#">
	select 
	a.itemno,
    a.category,
    a.wos_group,
	a.shelf,
	b.location,
	b.locationdesp,
	c.balance 
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
        <cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "" >
		and location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
            and (void = '' or void is null)
			<cfif form.periodfrom neq ""> 
			and fperiod <='#form.periodfrom#' and fperiod<>'99' 
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif getgeneral.singlelocation eq 'Y'>
            <cfif form.locationfrom neq "">
			and location = '#form.locationfrom#'
			</cfif>
            <cfelse>
			<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.datefrom neq "">
			and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and (void = '' or void is null)
			<cfif form.periodfrom neq "">
			and fperiod <='#form.periodfrom#' and fperiod<>'99'
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif getgeneral.singlelocation eq 'Y'>
			<cfif form.locationfrom neq "">
			and location = '#form.locationfrom#' 
			</cfif>
            <cfelse>
            <cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.datefrom neq "">
			and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
       	<cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "">
		and a.location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
     <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.categoryfrom neq "" and form.categoryto neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
	<cfif form.modelfrom neq "" and form.modelto neq "">
	and a.shelf between '#form.modelfrom#' and '#form.modelto#'
	</cfif>
    <cfif getgeneral.singlelocation eq 'Y'>
    <cfif form.locationfrom neq "" >
	and b.location = '#form.locationfrom#'
	</cfif>
    <cfelse>
	<cfif form.locationfrom neq "" and form.locationto neq "">
	and b.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
    </cfif>
    <cfif form.brandfrom neq "" and form.brandto neq "">
	and a.brand between '#form.brandfrom#' and '#form.brandto#'
	</cfif>
	<cfif not isdefined("form.include_stock")>
	and c.balance<>0
	</cfif> 
	group by b.location
	order by b.location;
</cfquery>

<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>

<table align="center" width="100%" border="0" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="8"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong><cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Physical Worksheet DO</strong></font></div></td>
	</tr>
	<!--- <cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.categoryfrom# - #form.categoryto#</font></div></td>
		</tr>
	</cfif> --->
	<!--- <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif> --->
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.productfrom# - #form.productto#</font></div></td>
		</tr>
	</cfif>
    <cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY : #form.categoryfrom# - #form.categoryto#</font></div></td>
		</tr>
	</cfif>
    <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP : #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.periodfrom neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="8"><hr/></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i")>
        <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">PRODUCT CODE.</font></div></td>
        </cfif>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM DESCRIPTION</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman,Times,serif">UNIT MEASURED</font></div></td>
        <cfif lcase(hcomid) eq "ssuni_i">
        <td><div align="center"><font size="2" face="Times New Roman,Times,serif">PRICE</font></div></td>
        </cfif>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">BOOK QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ACTUAL QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ADJ.QTY</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman,Times,serif">SHELF</font></div></td>
	</tr>
	<tr>
		<td colspan="8"><hr/></td>
	</tr>
	<cfoutput query="getlocation">
		<cfset location = getlocation.location>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif>: #getlocation.location#</u></strong></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u>#getlocation.locationdesp#</u></strong></font></div></td>
		</tr>
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			a.itemno,
            a.category,
            a.wos_group,
            a.aitemno,
			a.desp,
			a.unit,
            a.price,
			a.shelf,
			b.location,
			b.locqactual,
			b.balance 
			
			from icitem as a 
					
			left join 
			(
				select 
				a.location,
				a.itemno,
				a.locqactual,
				(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
				
				from locqdbf as a 
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_in 
					
					from ictran
					
					where type in ('RC','CN','OAI','TRIN') 
                    and (void = '' or void is null)
					and location='#location#'
					<cfif form.periodfrom neq ""> 
					and fperiod <='#form.periodfrom#' and fperiod<>'99' 
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
                   
					<cfif form.datefrom neq "">
					and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as b on a.location=b.location and a.itemno=b.itemno
				
				left join
				(
					select 
					location,
					itemno,
					sum(qty) as sum_out 
					
					from ictran 
					
					where (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    and (void = '' or void is null) 
					and location='#location#'
					<cfif form.periodfrom neq "">
					and fperiod <='#form.periodfrom#' and fperiod<>'99'
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
                  
					<cfif form.datefrom neq "">
					and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'
					</cfif>
					group by location,itemno
					order by location,itemno
				) as c on a.location=c.location and a.itemno=c.itemno 
				
				where a.location='#location#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
              
			) as b on a.itemno=b.itemno and b.location='#location#'
			
			where b.location='#location#'
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
            <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.categoryfrom neq "" and form.categoryto neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif form.modelfrom neq "" and form.modelto neq "">
			and a.shelf between '#form.modelfrom#' and '#form.modelto#'
			</cfif>
			<cfif not isdefined("form.include_stock")>
			and b.balance<>0 
			</cfif> 
            <cfif form.brandfrom neq "" and form.brandto neq "">
			and a.brand between '#form.brandfrom#' and '#form.brandto#'
			</cfif>
            <cfif lcase(hcomid) eq "simplysiti_i">
            order by a.itemno;	
            <cfelse>
			order by <cfif isdefined('form.itemdespsort')>a.desp<cfelse>a.shelf,a.itemno</cfif>
            </cfif>	
		</cfquery>
		
		<cfloop query="getiteminfo">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.currentrow#.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.itemno#</font></div></td>
                <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i")>
                <cfelseif lcase(hcomid) eq "vsolutionspteltd_i">
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.Aitemno#</font></div></td>
                </cfif>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.desp#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.unit#</font></div></td>
                <cfif lcase(hcomid) eq "ssuni_i">
                <td><div align="center"><font size="2" face="Times New Roman,Times,serif">#numberformat(getiteminfo.price,",_.__")#</font></div></td>
                </cfif>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.balance#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.locqactual#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#val(getiteminfo.balance)-val(getiteminfo.locqactual)#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.shelf#</font></div></td>
			</tr>
            <cfset totalqty=totalqty+getiteminfo.balance>
            <cfset totalact=totalact+getiteminfo.locqactual>
		</cfloop>
		<tr>
			<td><br/></td>
		</tr>
	</cfoutput>
    <cfoutput>
    <tr><td colspan="100%"><hr></td></tr>
    <tr>
    <td colspan="3"></td>
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i")>
    <td></td>
    </cfif>
    <td>Total :</td>
    <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalqty#</font></div></td>
    <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalact#</font></div></td>
    </tr>
    </cfoutput>
</table>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>
        </cfcase>
</cfswitch>