<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,costingcn,costingoai
	from gsetup
</cfquery>


<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>

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
INSERT INTO dolink SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>

</cfif> 

<cfif isdefined('form.dodate')>
<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif>
<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
 group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>
</cfif> 



<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">

<cfif lcase(hcomid) eq 'simplysiti_i'>

<!---Simplysiti--->

<cfquery name="getallitem" datasource="#dts#">
select itemno from icitem where 1=1
<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
</cfif>
</cfquery>
<cfloop query="getallitem">

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">
<cfparam name="grandstkval" default="0">


<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#getgeneral.cost#">
	<cfcase value="FIXED">
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfcase value="MONTH">
		<cfset costingmethod = "Month Average Method">
	</cfcase>
	<cfcase value="MOVING">
		<cfset costingmethod = "Moving Average Method">
	</cfcase>
	<cfcase value="FIFO">
		<cfset costingmethod = "First In First Out Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Last In First Out Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	select * from gsetup2
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ",.">
</cfif>

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfloop index="LoopCount" from="1" to="#iDecl_TPrice#">
  	<cfset stDecl_TPrice = stDecl_TPrice & "_">
</cfloop>

<h3 align="center"><font face="Times New Roman, Times, serif">Item - <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Status and Value</font></h3>
<h4 align="center"><font face="Times New Roman, Times, serif">Calculated by Fixed Cost<!--- <cfoutput>#costingmethod#</cfoutput> ---></font></h4>

	<cfinvoke component = "locationstatus" method = "get_group" returnvariable = "getgroup">
		<cfinvokeargument name = "dts" 			value = "#dts#">
		<cfinvokeargument name = "lastaccyear" 	value = "#getgeneral.lastaccyear#">
		<cfinvokeargument name = "form" 		value = "#form#">
		<cfinvokeargument name = "location" 	value = "ZZZZZZZZZZ">
	</cfinvoke>

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
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>

		  		</Style>
                 <Style ss:ID="s52">
                		<Borders>
							<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						</Borders>
						</Style>

		 	</Styles>
			
			<Worksheet ss:Name="Item-Location Status and Value">

			<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="180.25"/>
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
		<!---<cfif form.periodfrom neq "" and form.periodto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PERIOD: #wddxText#</Data></Cell>
			</Row>

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#dateformat(dateadd('m',form.periodfrom,getgeneral.lastaccyear),"mmm yy")# - 	       #dateformat(dateadd('m',form.periodto,getgeneral.lastaccyear),"mmm yy")#" output = "wddxText1">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText1#</Data></Cell>
			</Row>
		</cfif>--->
        
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText2">
            	<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText3">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText3#</Data></Cell>
            </Row>
		
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			 <Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">DESPCRIPTION</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">QTYBF</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">ON HAND</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">
				<cfif getgeneral.cost eq "FIXED">UNIT COST<cfelseif getgeneral.cost eq "MONTH">AVERAGE<cfelseif getgeneral.cost eq "MOVING">AVERAGE</cfif>
			</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">STOCK VALUE</Data></Cell>
	    </Row>
		
		<cfloop query="getgroup">
			<cfset target_group = getgroup.wos_group>
			<cfset target_group_desp = getgroup.group_desp>
			<cfset groupqtybf=0>
			<cfset groupqtyin=0>
			<cfset groupqtyout=0>
			<cfset groupbalanceqty=0>
			<cfset groupstkval=0>
			
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s51"><Data ss:Type="String">GROUP: #target_group#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#target_group_desp#</Data></Cell>
			</Row>
		<cfif getgeneral.cost eq "FIXED">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,b.ucost,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,ucost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					and itemno='#getallitem.itemno#'
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
                    <cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>

					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				and a.itemno='#getallitem.itemno#'
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
		<cfelseif getgeneral.cost eq "FIFO" or getgeneral.cost eq "LIFO">
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        
        <cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #thislastaccdate#
		limit 1
		</cfquery>
        
        <cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,b.ucost,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
					
				from locqdbf_last_year as a
		
				right join
				(
					select itemno,desp,ucost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					and itemno='#getallitem.itemno#'
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
					<cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
                    and operiod+0 < '#form.periodfrom#' 
                    </cfif>
                    and fperiod='99'
                    and wos_date > #getdate.LastAccDate#
                    and wos_date <= #getdate.ThisAccDate# 
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
					<cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
                    and operiod+0 < '#form.periodfrom#' 
                    </cfif>
                    and fperiod='99'
                    and wos_date > #getdate.LastAccDate#
                    and wos_date <= #getdate.ThisAccDate# 
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod='99' 
                	and operiod between '#form.periodfrom#' and '#form.periodto#' 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod='99' 
                	and operiod between '#form.periodfrom#' and '#form.periodto#' 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				and a.itemno='#getallitem.itemno#'
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
                and a.thisaccdate=#getdate.ThisAccDate#
				order by a.itemno,a.location
			</cfquery>
        
        
        
        <cfelse>
        
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,b.ucost,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,ucost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					and itemno='#getallitem.itemno#'
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					and itemno='#getallitem.itemno#'
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				and a.itemno='#getallitem.itemno#'
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
        </cfif>
		</cfif>		 
			<cfset thisitem="">
			<cfset itemqtybf=0>
			<cfset itemqtyin=0>
			<cfset itemqtyout=0>
			<cfset itembalanceqty=0>
			<cfset itemstkval=0>
			<cfset itemcounter=0>
			<cfloop query="getitem">
            
            <!---New Moving calculation--->
            
            <cfif getgeneral.cost eq "MOVING">
            	
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getqtybf" datasource="#dts#">
			select a.LastAccDate,a.ThisAccDate,a.avcost2,b.locqfield as qtybf FROM icitem_last_yearas a left join (select locqfield,itemno from locqdbf_last_year where itemno='#getitem.itemno#' and location='#getitem.location#' and LastAccDate = #thislastaccdate# )as b on a.itemno=b.itemno
			where a.itemno='#getitem.itemno#' and LastAccDate = #thislastaccdate# 
			limit 1
            </cfquery>
            
            <cfelse>
            <cfquery name="getqtybf" datasource="#dts#">
			select a.avcost2,b.locqfield as qtybf FROM icitem as a left join (select locqfield,itemno from locqdbf where itemno='#getitem.itemno#' and location='#getitem.location#')as b on a.itemno=b.itemno
			where a.itemno='#getitem.itemno#'
			 limit 1
            </cfquery>
           
            </cfif>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    if(a.taxincl='T',a.amt-a.taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a<!---,artran b--->

			where a.itemno='#getitem.itemno#' 
            and a.location='#getitem.location#'
            <!---and a.refno=b.refno and a.type=b.type--->
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod='99'
			and a.wos_date > #getdate.LastAccDate#
			and a.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= #date2#
			</cfif>
			order by a.wos_date,a.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a<!---,artran b--->
            
			where a.itemno='#getitem.itemno#' 
            and a.location='#getitem.location#'
            <!---and a.refno=b.refno and a.type=b.type--->
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= #date2#
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date,a.trdatetime
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
        
		<cfset getitem.stockbalance=movingbal*movingunitcost>
        <cfset getitem.ucost=movingunitcost>
        
        </cfif>
            
            
				<cfif getitem.itemno neq thisitem>
					<cfif thisitem neq "">
						<cfif itemcounter neq 0>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtybf,"0")#" output = "wddxText6">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyin,"0")#" output = "wddxText7">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyout,"0")#" output = "wddxText8">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itembalanceqty,"0")#" output = "wddxText9">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemstkval,stDecl_UPrice)#" output = "wddxText10">
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText6#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText7#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText8#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText9#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText10#</Data></Cell>
						    </Row>
						</cfif>
						
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			</Row>
					    <cfset itemqtybf=0>
						<cfset itemqtyin=0>
						<cfset itemqtyout=0>
						<cfset itembalanceqty=0>
						<cfset itemstkval=0>
						<cfset itemcounter=0>
					</cfif>
					<cfset thisitem=getitem.itemno>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText11">
            	<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxTex12">

			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText11#</Data></Cell>
            <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxTex12#</Data></Cell>
					</Row>
				</cfif>
				<cfset itemcounter=itemcounter+1>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getitem.location#" output = "wddxText13">
            	<cfwddx action = "cfml2wddx" input = "#getitem.locationdesp#" output = "wddxText14">
            	<cfwddx action = "cfml2wddx" input = "#getitem.qtybf#" output = "wddxText15">
            	<cfwddx action = "cfml2wddx" input = "#getitem.qin#" output = "wddxText16">
            	<cfwddx action = "cfml2wddx" input = "#getitem.qout#" output = "wddxText17">
            	<cfwddx action = "cfml2wddx" input = "#getitem.balance#" output = "wddxText18">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(val(getitem.ucost),stDecl_UPrice)#" output = "wddxText19">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(val(stockbalance),stDecl_UPrice)#" output = "wddxText20">
        
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText13#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText14#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText15#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText16#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText17#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText18#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText19#</Data></Cell>
			<Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText20#</Data></Cell>
				</Row>
				<cfset itemqtybf=itemqtybf+val(getitem.qtybf)>
				<cfset itemqtyin=itemqtyin+val(getitem.qin)>
				<cfset itemqtyout=itemqtyout+val(getitem.qout)>
				<cfset itembalanceqty=itembalanceqty+val(getitem.balance)>
				<cfset itemstkval=itemstkval+val(stockbalance)>
				<cfset groupqtybf=groupqtybf+val(getitem.qtybf)>
				<cfset groupqtyin=groupqtyin+val(getitem.qin)>
				<cfset groupqtyout=groupqtyout+val(getitem.qout)>
				<cfset groupbalanceqty=groupbalanceqty+val(getitem.balance)>
				<cfset groupstkval=groupstkval+val(stockbalance)>
				<cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
				<cfset grandqtyin=grandqtyin+val(getitem.qin)>
				<cfset grandqtyout=grandqtyout+val(getitem.qout)>
				<cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>
				<cfset grandstkval=grandstkval+val(stockbalance)>
			</cfloop>
			<cfif itemcounter neq 0>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtybf,"0")#" output = "wddxText21">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyin,"0")#" output = "wddxText22">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyout,"0")#" output = "wddxText23">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itembalanceqty,"0")#" output = "wddxText24">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemstkval,stDecl_UPrice)#" output = "wddxText25">

				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText21#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText22#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText23#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText24#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText25#</Data></Cell>
				</Row>
			</cfif>
					    
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupqtybf,"0")#" output = "wddxText26">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupqtyin,"0")#" output = "wddxText27">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupqtyout,"0")#" output = "wddxText28">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupbalanceqty,"0")#" output = "wddxText29">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupstkval,stDecl_UPrice)#" output = "wddxText30">

				<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">GROUP TOTAL:</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText26#</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText27#</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText28#</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText29#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText30#</Data></Cell>
		    </Row>
		</cfloop>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandqtybf,"0")#" output = "wddxText31">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandqtyin,"0")#" output = "wddxText32">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandqtyout,"0")#" output = "wddxText33">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandbalanceqty,"0")#" output = "wddxText34">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandstkval,stDecl_UPrice)#" output = "wddxText35">

				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL:</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText31#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText32#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText33#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText34#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText35#</Data></Cell>
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

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\#getallitem.itemno#.xls" output="#tostring(data)#" charset="utf-8">
        <cfheader name="Content-Disposition" value="inline; filename=#getallitem.itemno#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\#getallitem.itemno#.xls">

</cfloop>


<cfelse>
<!---others--->

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">
<cfparam name="grandstkval" default="0">


<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#getgeneral.cost#">
	<cfcase value="FIXED">
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfcase value="MONTH">
		<cfset costingmethod = "Month Average Method">
	</cfcase>
	<cfcase value="MOVING">
		<cfset costingmethod = "Moving Average Method">
	</cfcase>
	<cfcase value="FIFO">
		<cfset costingmethod = "First In First Out Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Last In First Out Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	select * from gsetup2
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ",.">
</cfif>

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfloop index="LoopCount" from="1" to="#iDecl_TPrice#">
  	<cfset stDecl_TPrice = stDecl_TPrice & "_">
</cfloop>

<h3 align="center"><font face="Times New Roman, Times, serif">Item - <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Status and Value</font></h3>
<h4 align="center"><font face="Times New Roman, Times, serif">Calculated by Fixed Cost<!--- <cfoutput>#costingmethod#</cfoutput> ---></font></h4>

	<cfinvoke component = "locationstatus" method = "get_group" returnvariable = "getgroup">
		<cfinvokeargument name = "dts" 			value = "#dts#">
		<cfinvokeargument name = "lastaccyear" 	value = "#getgeneral.lastaccyear#">
		<cfinvokeargument name = "form" 		value = "#form#">
		<cfinvokeargument name = "location" 	value = "ZZZZZZZZZZ">
	</cfinvoke>

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
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>

		  		</Style>
                 <Style ss:ID="s52">
                		<Borders>
							<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						</Borders>
						</Style>

		 	</Styles>
			
			<Worksheet ss:Name="Item-Location Status and Value">

			<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="180.25"/>
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
		<!---<cfif form.periodfrom neq "" and form.periodto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PERIOD: #wddxText#</Data></Cell>
			</Row>

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#dateformat(dateadd('m',form.periodfrom,getgeneral.lastaccyear),"mmm yy")# - 	       #dateformat(dateadd('m',form.periodto,getgeneral.lastaccyear),"mmm yy")#" output = "wddxText1">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText1#</Data></Cell>
			</Row>
		</cfif>
        --->
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText2">
            	<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText3">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText3#</Data></Cell>
            </Row>
		
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			 <Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">DESPCRIPTION</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">QTYBF</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">ON HAND</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">
				<cfif getgeneral.cost eq "FIXED">UNIT COST<cfelseif getgeneral.cost eq "MONTH">AVERAGE<cfelseif getgeneral.cost eq "MOVING">AVERAGE</cfif>
			</Data></Cell>
			 <Cell ss:StyleID="s50"><Data ss:Type="String">STOCK VALUE</Data></Cell>
	    </Row>
		
		<cfloop query="getgroup">
			<cfset target_group = getgroup.wos_group>
			<cfset target_group_desp = getgroup.group_desp>
			<cfset groupqtybf=0>
			<cfset groupqtyin=0>
			<cfset groupqtyout=0>
			<cfset groupbalanceqty=0>
			<cfset groupstkval=0>
			
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
        	<cfwddx action = "cfml2wddx" input = "#target_group#" output = "wddxText">
            <cfwddx action = "cfml2wddx" input = "#target_group_desp#" output = "wddxText2">
			<Cell ss:StyleID="s51"><Data ss:Type="String">GROUP: #wddxText#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText2#</Data></Cell>
			</Row>
		<cfif getgeneral.cost eq "FIXED">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,b.ucost,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,ucost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
                    <cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
		<cfelseif getgeneral.cost eq "MONTH">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0))) as ucost,
				(((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,avcost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)			
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
				
				left join
				(
					select sum(qty) as rcqty,sum(amt) as rcamt,itemno,location   
					from ictran
					where type='RC' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as g on (a.itemno=g.itemno and a.location=g.location)
				
				left join
				(
					select sum(qty) as prqty,sum(amt) as pramt,itemno,location   
					from ictran
					where type='PR' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as h on (a.itemno=h.itemno and a.location=h.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
		<cfelseif getgeneral.cost eq "MOVING">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0))) as ucost,
				(((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,avcost2,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 					
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
					and fperiod < '#form.periodfrom#' 
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
				
				left join
				(
					select sum(qty) as rcqty,sum(amt) as rcamt,itemno,location   
					from ictran
					where type='RC' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as g on (a.itemno=g.itemno and a.location=g.location)
				
				left join
				(
					select sum(qty) as prqty,sum(amt) as pramt,itemno,location   
					from ictran
					where type='PR' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as h on (a.itemno=h.itemno and a.location=h.location)
				
				left join
				(
					select sum(qty) as movqin,itemno,location  
					from ictran
					where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null) )	and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as i on (a.itemno=i.itemno and a.location=i.location)

				left join
				(
					select sum(qty) as movqout,itemno,location 
					from ictran
					where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null) ) and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as j on (a.itemno=j.itemno and a.location=j.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>	
		<cfelseif getgeneral.cost eq "FIFO" or getgeneral.cost eq "LIFO">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,b.ucost,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,ucost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
		</cfif>		 
			<cfset thisitem="">
			<cfset itemqtybf=0>
			<cfset itemqtyin=0>
			<cfset itemqtyout=0>
			<cfset itembalanceqty=0>
			<cfset itemstkval=0>
			<cfset itemcounter=0>
			<cfloop query="getitem">
            
            <!---New Moving calculation--->
            
            <cfif getgeneral.cost eq "MOVING">
            	
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getqtybf" datasource="#dts#">
			select a.LastAccDate,a.ThisAccDate,a.avcost2,b.locqfield as qtybf FROM icitem_last_yearas a left join (select locqfield,itemno from locqdbf_last_year where itemno='#getitem.itemno#' and location='#getitem.location#' and LastAccDate = #thislastaccdate# )as b on a.itemno=b.itemno
			where a.itemno='#getitem.itemno#' and LastAccDate = #thislastaccdate# 
			limit 1
            </cfquery>
            
            <cfelse>
            <cfquery name="getqtybf" datasource="#dts#">
			select a.avcost2,b.locqfield as qtybf FROM icitem as a left join (select locqfield,itemno from locqdbf where itemno='#getitem.itemno#' and location='#getitem.location#')as b on a.itemno=b.itemno
			where a.itemno='#getitem.itemno#'
			 limit 1
            </cfquery>
           
            </cfif>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    if(a.taxincl='T',a.amt-a.taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a<!---,artran b--->

			where a.itemno='#getitem.itemno#' 
            and a.location='#getitem.location#'
            <!---and a.refno=b.refno and a.type=b.type--->
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod='99'
			and a.wos_date > #getdate.LastAccDate#
			and a.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= #date2#
			</cfif>
			order by a.wos_date,a.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a<!---,artran b--->
            
			where a.itemno='#getitem.itemno#' 
            and a.location='#getitem.location#'
            <!---and a.refno=b.refno and a.type=b.type--->
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= #date2#
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date,a.trdatetime
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
        
		<cfset getitem.stockbalance=movingbal*movingunitcost>
        <cfset getitem.ucost=movingunitcost>
        
        </cfif>
            
            
				<cfif getitem.itemno neq thisitem>
					<cfif thisitem neq "">
						<cfif itemcounter neq 0>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtybf,"0")#" output = "wddxText6">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyin,"0")#" output = "wddxText7">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyout,"0")#" output = "wddxText8">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itembalanceqty,"0")#" output = "wddxText9">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemstkval,stDecl_UPrice)#" output = "wddxText10">
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText6#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText7#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText8#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText9#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText10#</Data></Cell>
						    </Row>
						</cfif>
						
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			</Row>
					    <cfset itemqtybf=0>
						<cfset itemqtyin=0>
						<cfset itemqtyout=0>
						<cfset itembalanceqty=0>
						<cfset itemstkval=0>
						<cfset itemcounter=0>
					</cfif>
					<cfset thisitem=getitem.itemno>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText11">
            	<cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxTex12">

			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText11#</Data></Cell>
            <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxTex12#</Data></Cell>
					</Row>
				</cfif>
				<cfset itemcounter=itemcounter+1>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getitem.location#" output = "wddxText13">
            	<cfwddx action = "cfml2wddx" input = "#getitem.locationdesp#" output = "wddxText14">
            	<cfwddx action = "cfml2wddx" input = "#getitem.qtybf#" output = "wddxText15">
            	<cfwddx action = "cfml2wddx" input = "#getitem.qin#" output = "wddxText16">
            	<cfwddx action = "cfml2wddx" input = "#getitem.qout#" output = "wddxText17">
            	<cfwddx action = "cfml2wddx" input = "#getitem.balance#" output = "wddxText18">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(val(getitem.ucost),stDecl_UPrice)#" output = "wddxText19">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(val(stockbalance),stDecl_UPrice)#" output = "wddxText20">
        
			<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText13#</Data></Cell>
			<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText14#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText15#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText16#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText17#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText18#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText19#</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText20#</Data></Cell>
				</Row>
				<cfset itemqtybf=itemqtybf+val(getitem.qtybf)>
				<cfset itemqtyin=itemqtyin+val(getitem.qin)>
				<cfset itemqtyout=itemqtyout+val(getitem.qout)>
				<cfset itembalanceqty=itembalanceqty+val(getitem.balance)>
				<cfset itemstkval=itemstkval+val(stockbalance)>
				<cfset groupqtybf=groupqtybf+val(getitem.qtybf)>
				<cfset groupqtyin=groupqtyin+val(getitem.qin)>
				<cfset groupqtyout=groupqtyout+val(getitem.qout)>
				<cfset groupbalanceqty=groupbalanceqty+val(getitem.balance)>
				<cfset groupstkval=groupstkval+val(stockbalance)>
				<cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
				<cfset grandqtyin=grandqtyin+val(getitem.qin)>
				<cfset grandqtyout=grandqtyout+val(getitem.qout)>
				<cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>
				<cfset grandstkval=grandstkval+val(stockbalance)>
			</cfloop>
			<cfif itemcounter neq 0>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtybf,"0")#" output = "wddxText21">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyin,"0")#" output = "wddxText22">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemqtyout,"0")#" output = "wddxText23">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itembalanceqty,"0")#" output = "wddxText24">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(itemstkval,stDecl_UPrice)#" output = "wddxText25">

				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText21#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText22#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText23#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText24#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText25#</Data></Cell>
				</Row>
			</cfif>
					    
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupqtybf,"0")#" output = "wddxText26">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupqtyin,"0")#" output = "wddxText27">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupqtyout,"0")#" output = "wddxText28">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupbalanceqty,"0")#" output = "wddxText29">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(groupstkval,stDecl_UPrice)#" output = "wddxText30">

				<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">GROUP TOTAL:</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText26#</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText27#</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText28#</Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText29#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		        <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText30#</Data></Cell>
		    </Row>
		</cfloop>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandqtybf,"0")#" output = "wddxText31">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandqtyin,"0")#" output = "wddxText32">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandqtyout,"0")#" output = "wddxText33">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandbalanceqty,"0")#" output = "wddxText34">
            	<cfwddx action = "cfml2wddx" input = "#numberformat(grandstkval,stDecl_UPrice)#" output = "wddxText35">

				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL:</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText31#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText32#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText33#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText34#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText35#</Data></Cell>
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

</cfif>
    </cfcase>
    
     
    <cfcase value="HTML">
    

<html>
<head>
<title>Item Status & Value Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">
<cfparam name="grandstkval" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,costingcn,costingoai
	from gsetup
</cfquery>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#getgeneral.cost#">
	<cfcase value="FIXED">
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfcase value="MONTH">
		<cfset costingmethod = "Month Average Method">
	</cfcase>
	<cfcase value="MOVING">
		<cfset costingmethod = "Moving Average Method">
	</cfcase>
	<cfcase value="FIFO">
		<cfset costingmethod = "First In First Out Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Last In First Out Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	select * from gsetup2
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ",.">
</cfif>

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<cfloop index="LoopCount" from="1" to="#iDecl_TPrice#">
  	<cfset stDecl_TPrice = stDecl_TPrice & "_">
</cfloop>

<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>

<h3 align="center"><font face="Times New Roman, Times, serif">Item - <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Status and Value</font></h3>
<h4 align="center"><font face="Times New Roman, Times, serif">Calculated by <cfif getgeneral.cost eq "MOVING">Moving Average<cfelse>Fixed Cost</cfif><!--- <cfoutput>#costingmethod#</cfoutput> ---></font></h4>

	<cfinvoke component = "locationstatus" method = "get_group" returnvariable = "getgroup">
		<cfinvokeargument name = "dts" 			value = "#dts#">
		<cfinvokeargument name = "lastaccyear" 	value = "#getgeneral.lastaccyear#">
		<cfinvokeargument name = "form" 		value = "#form#">
		<cfinvokeargument name = "location" 	value = "ZZZZZZZZZZ">
	</cfinvoke>
	<table align="center" border="0" width="100%">
		<cfoutput>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">
					#dateformat(dateadd('m',form.periodfrom,getgeneral.lastaccyear),"mmm yy")# - #dateformat(dateadd('m',form.periodto,getgeneral.lastaccyear),"mmm yy")#
				</font></div></td>		
			</tr>
		</cfif>
		<tr>
			<td colspan="4"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></div></td>
	    	<td colspan="5"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">DESPCRIPTION</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">QTYBF</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">IN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">OUT</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ON HAND</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">
				<cfif getgeneral.cost eq "FIXED">UNIT COST<cfelseif getgeneral.cost eq "MONTH">AVERAGE<cfelseif getgeneral.cost eq "MOVING">AVERAGE</cfif>
			</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">STOCK VALUE</font></div></td>
	    </tr>
		<tr>
	      	<td colspan="100%"><hr></td>
	    </tr>
	
		<cfloop query="getgroup">
			<cfset target_group = getgroup.wos_group>
			<cfset target_group_desp = getgroup.group_desp>
			<cfset groupqtybf=0>
			<cfset groupqtyin=0>
			<cfset groupqtyout=0>
			<cfset groupbalanceqty=0>
			<cfset groupstkval=0>
			
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>GROUP: #target_group#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>#target_group_desp#</strong></font></div></td>
			</tr>
		<cfif getgeneral.cost eq "FIXED">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,b.ucost,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,ucost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
                    <cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
		<cfelseif getgeneral.cost eq "MONTH">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0))) as ucost,
				(((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,avcost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)			
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where 
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
				
				left join
				(
					select sum(qty) as rcqty,sum(amt) as rcamt,itemno,location   
					from ictran
					where type='RC' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as g on (a.itemno=g.itemno and a.location=g.location)
				
				left join
				(
					select sum(qty) as prqty,sum(amt) as pramt,itemno,location   
					from ictran
					where type='PR' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as h on (a.itemno=h.itemno and a.location=h.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))*ifnull(b.avcost,0))+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
		<cfelseif getgeneral.cost eq "MOVING">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0))) as ucost,
				(((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,avcost2,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 					
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
                    <cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
				
				left join
				(
					select sum(qty) as rcqty,sum(amt) as rcamt,itemno,location   
					from ictran
					where type='RC' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as g on (a.itemno=g.itemno and a.location=g.location)
				
				left join
				(
					select sum(qty) as prqty,sum(amt) as pramt,itemno,location   
					from ictran
					where type='PR' and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location  
				) as h on (a.itemno=h.itemno and a.location=h.location)
				
				left join
				(
					select sum(qty) as movqin,itemno,location  
					from ictran
					where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as i on (a.itemno=i.itemno and a.location=i.location)

				left join
				(
					select sum(qty) as movqout,itemno,location 
					from ictran
					where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null) ) and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 <= '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as j on (a.itemno=j.itemno and a.location=j.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and (((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*((((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0))*ifnull(b.avcost2,0)+ifnull(g.rcamt,0)-ifnull(h.pramt,0))/((ifnull(a.locqfield,0))+ifnull(i.movqin,0)-ifnull(j.movqout,0)+ifnull(g.rcqty,0)-ifnull(h.prqty,0)))) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>	
		<cfelseif getgeneral.cost eq "FIFO" or getgeneral.cost eq "LIFO">
			<cfquery name="getitem" datasource="#dts#">
				select a.location,bb.locationdesp,a.itemno,b.desp,b.ucost,
				(ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)) as qtybf,
				ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,
				((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) as balance,
				((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) as stockbalance
					
				from locqdbf as a
		
				right join
				(
					select itemno,desp,ucost,wos_group
					from icitem 
					where itemno<>'' 
					and wos_group ='#target_group#'
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
				) as b on a.itemno=b.itemno
				
				left join 
				(
					select 
					location,
					desp as locationdesp 
					from iclocation 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						where location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					order by location
				) as bb on a.location=bb.location
			
				left join
				(
					select location,itemno,sum(qty) as lastin 
					from ictran
					where type in ('RC','CN','OAI','TRIN') 
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null) 
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif> 
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by location,itemno
				) as c on (a.itemno=c.itemno and a.location=c.location)
				
				left join
				(
					select sum(qty) as lastout,itemno,location 
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
                    <cfelse>
					and fperiod < '#form.periodfrom#' 
                    </cfif>
					and fperiod<>'99'
					and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < #date1# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as d on (a.itemno=d.itemno and a.location=d.location)
		
				left join
				(
					select sum(qty) as qin,itemno,location 
					from ictran
					where type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location
				) as e on (a.itemno=e.itemno and a.location=e.location)
				
				left join
				(
					select sum(qty) as qout,itemno,location  
					from ictran
					where
                    <cfif isdefined('form.dodate')>
                    (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
                    (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    <cfelse>
                    type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') and (toinv='' or toinv is null) 
                    </cfif>
                    and (void = '' or void is null)
					and fperiod <> '99'
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
					</cfif> 
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between #date1# and #date2# 
					</cfif>
					<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
						and category between '#form.categoryfrom#' and '#form.categoryto#'
					</cfif>
					<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
						and itemno between '#form.productfrom#' and '#form.productto#'
					</cfif>
					<cfif form.locationfrom neq "" and form.locationto neq "">
						and location between '#form.locationfrom#' and '#form.locationto#'
					</cfif>
					<cfif trim(form.supplierfrom) neq "" and trim(form.supplierto) neq "">
						and custno between '#form.supplierfrom#' and '#form.supplierto#'
					</cfif>
					group by itemno,location 
				) as f on (a.itemno=f.itemno and a.location=f.location)
		
				where a.itemno <> ''
				and b.wos_group ='#target_group#'
				<cfif isdefined("form.include0")>
				<cfelse>
					and ((ifnull(a.locqfield,0)+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0))*ifnull(b.ucost,0)) > 0
				</cfif>
				<cfif isdefined("form.qty0")>
				<cfelse>
					and ((ifnull(a.locqfield,0))+ifnull(c.lastin,0)-ifnull(d.lastout,0)+ifnull(e.qin,0)-ifnull(f.qout,0)) > 0
				</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
					and b.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.locationfrom neq "" and form.locationto neq "">
					and a.location between '#form.locationfrom#' and '#form.locationto#'
				</cfif>
				order by a.itemno,a.location
			</cfquery>
		</cfif>		 
			<cfset thisitem="">
			<cfset itemqtybf=0>
			<cfset itemqtyin=0>
			<cfset itemqtyout=0>
			<cfset itembalanceqty=0>
			<cfset itemstkval=0>
			<cfset itemcounter=0>
			<cfloop query="getitem">
            
            <!---New Moving calculation--->
            
            <cfif getgeneral.cost eq "MOVING">
            	
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getqtybf" datasource="#dts#">
			select LastAccDate,ThisAccDate,avcost2,qtybf FROM icitem_last_year
			where itemno='#getitem.itemno#' and LastAccDate = #thislastaccdate# 
			limit 1
            </cfquery>
            
            <cfelse>
            <cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#getitem.itemno#'
			 limit 1
            </cfquery>
           
            </cfif>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    if(a.taxincl='T',a.amt-a.taxamt,a.amt) as amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a

			where a.itemno='#getitem.itemno#' 
            and a.location='#getitem.location#'
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod='99'
			and a.wos_date > #getdate.LastAccDate#
			and a.wos_date <= #getdate.ThisAccDate#
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= #date2#
			</cfif>
			order by a.wos_date,a.trdatetime
			</cfquery>
            
            <cfelse>
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a
            
			where a.itemno='#getitem.itemno#' 
            and a.location='#getitem.location#'
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod<>'99'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod+0 <= '#periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date <= #date2#
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
			
			order by a.wos_date,a.trdatetime
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
        
		<cfset getitem.stockbalance=movingbal*movingunitcost>
        <cfset getitem.ucost=movingunitcost>
        
        </cfif>
            
            
            
            
            
				<cfif getitem.itemno neq thisitem>
					<cfif thisitem neq "">
						<cfif itemcounter neq 0>
							<tr>
				        		<td></td>
						        <td></td>
						        <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemqtybf,"0")#</font></div></td>
						        <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemqtyin,"0")#</font></div></td>
						        <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemqtyout,"0")#</font></div></td>
						        <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itembalanceqty,"0")#</font></div></td>
						        <td></td>
						        <td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemstkval,stDecl_UPrice)#</font></div></td>
						    </tr>
						</cfif>
						
					    <tr><td height="5"></td></tr>
					    <cfset itemqtybf=0>
						<cfset itemqtyin=0>
						<cfset itemqtyout=0>
						<cfset itembalanceqty=0>
						<cfset itemstkval=0>
						<cfset itemcounter=0>
					</cfif>
					<cfset thisitem=getitem.itemno>
					<tr>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><u>#getitem.itemno#</u></font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><u>#getitem.desp#</u></font></div></td>
					</tr>
				</cfif>
				<cfset itemcounter=itemcounter+1>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.location#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.locationdesp#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qtybf#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qin#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qout#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.balance#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(ucost),stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(stockbalance),stDecl_UPrice)#</font></div></td>
				</tr>
				<cfset itemqtybf=itemqtybf+val(getitem.qtybf)>
				<cfset itemqtyin=itemqtyin+val(getitem.qin)>
				<cfset itemqtyout=itemqtyout+val(getitem.qout)>
				<cfset itembalanceqty=itembalanceqty+val(getitem.balance)>
				<cfset itemstkval=itemstkval+val(stockbalance)>
				<cfset groupqtybf=groupqtybf+val(getitem.qtybf)>
				<cfset groupqtyin=groupqtyin+val(getitem.qin)>
				<cfset groupqtyout=groupqtyout+val(getitem.qout)>
				<cfset groupbalanceqty=groupbalanceqty+val(getitem.balance)>
				<cfset groupstkval=groupstkval+val(stockbalance)>
				<cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
				<cfset grandqtyin=grandqtyin+val(getitem.qin)>
				<cfset grandqtyout=grandqtyout+val(getitem.qout)>
				<cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>
				<cfset grandstkval=grandstkval+val(stockbalance)>
			</cfloop>
			<cfif itemcounter neq 0>
				<tr>
				    <td></td>
					<td></td>
					<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemqtybf,"0")#</font></div></td>
					<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemqtyin,"0")#</font></div></td>
					<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemqtyout,"0")#</font></div></td>
					<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itembalanceqty,"0")#</font></div></td>
					<td></td>
					<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemstkval,stDecl_UPrice)#</font></div></td>
				</tr>
			</cfif>
					    
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
        		<td></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupqtybf,"0")#</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupqtyin,"0")#</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupqtyout,"0")#</font></div></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupbalanceqty,"0")#</font></div></td>
		        <td></td>
		        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(groupstkval,stDecl_UPrice)#</font></div></td>
		    </tr>
		</cfloop>
		<tr><td height="10"></td></tr>
		<tr>
        	<td></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandqtybf,"0")#</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandqtyin,"0")#</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandqtyout,"0")#</strong></font></div></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandbalanceqty,"0")#</strong></font></div></td>
		    <td></td>
		    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandstkval,stDecl_UPrice)#</strong></font></div></td>
		</tr>
		</cfoutput>
	</table>
<br><br>
<div align="right">
	<font size="1" face="Arial, Helvetica, sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>
<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>
</body>
</html>
</cfcase>
</cfswitch>