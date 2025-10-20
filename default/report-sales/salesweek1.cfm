<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,agentlistuserid from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
    
<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>


<cfif isdefined('form.agentbycust')>

<cfif form.agentfrom neq "" and form.agentto neq "">
<cfquery name="getagentlist" datasource="#dts#">
select custno from #target_arcust# where 0=0
and agent >='#form.agentfrom#' and agent <= '#form.agentto#'
</cfquery>
<cfset agentlist=valuelist(getagentlist.custno)>
</cfif>

<cfif form.teamfrom neq "" and form.teamto neq "">
<cfquery name="getteamlist" datasource="#dts#">
select custno from #target_arcust# where agent in (select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
</cfquery>
<cfset teamlist=valuelist(getteamlist.custno)>
</cfif>

</cfif>

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
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
                  <Style ss:ID="s52">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		 	</Style>
            
            <Style ss:ID="s53">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
			
		 	</Styles>
			<Worksheet ss:Name="Print Product Sales By weekly Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="180.25"/>
					<Column ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
						<cfset c=c+1>
                        
        <cfoutput>   
        
  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
 <cfif isdefined("form.include") and form.include eq "yes">
	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PRINT #url.trantype# SALES WEEKLY REPORT (Included DN/CN)</Data></Cell>
<cfelse>
	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PRINT #url.trantype# SALES WEEKLY REPORT (Excluded DN/CN)</Data></Cell>
</cfif>

</Row>
<cfquery name="getdisplaysetup" datasource="#dts#">
	select 
	* 
	from displaysetup;
</cfquery> 
            
  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.monthfrom#" output = "wddxText2">
    	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">MONTH: #form.monthfrom#</Data></Cell>
    </Row>
    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.catefrom# - #form.cateto#" output = "wddxText3">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">CATEGORY: #wddxText3#</Data></Cell>
        </Row>
    </cfif>
    <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.groupfrom# - #form.groupto#" output = "wddxText4">
        	<Cell ss:StyleID="s26"><Data ss:Type="String">GROUP: #wddxText4#</Data></Cell>
        </Row>
    </cfif>
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#form.itemfrom# - #form.itemto#" output = "wddxText5">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">ITEM NO: #wddxText5#</Data></Cell>
        </Row>
    </cfif>
  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText6">
  		   <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText7">
      	   <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#wddxText6#</cfif></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	   <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
    </Row>
 

	<cfset lastyear = year(getgeneral.lastaccyear)>
	<cfset lastmonth = month(getgeneral.lastaccyear)>
	<cfset lastday = 1>
	<cfset selectedmonth = val(form.periodfrom)>
	<cfset count = 1>
	<cfset noweek = 1>
	<cfset weekday = arraynew(1)>
	<cfset weeks = arraynew(1)>
	<cfset lastmonth = lastmonth + selectedmonth>

	<cfif lastmonth gt 24>
		<cfset lastyear = lastyear + 2>
		<cfset lastmonth = lastmonth -24>
        <cfelseif lastmonth gt 12>
        <cfset lastyear = lastyear + 1>
		<cfset lastmonth = lastmonth -12>
	</cfif>

	<cfset days = firstdayofmonth(createdate(lastyear,lastmonth,lastday)) - 2>

	<cfset totalday = daysinmonth(createdate(lastyear,lastmonth,1))>
	<cfset curweek = week(createdate(lastyear,lastmonth,1))>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif curweek neq curweek2>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfloop index="a" from="1" to="#noweek#">
		<cfset weekday[a] = 0>
	</cfloop>

	<cfset curweek = week(createdate(lastyear,lastmonth,1))>
	<cfset noweek = 1>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif a neq totalday>
			<cfset weeks[noweek] = curweek>
		<cfelse>
			<cfif week(createdate(lastyear,lastmonth,a-1)) eq week(createdate(lastyear,lastmonth,a))>
				<cfset weeks[noweek] = week(createdate(lastyear,lastmonth,a))>
			<cfelse>
				<cfset weeks[noweek + 1] = week(createdate(lastyear,lastmonth,a))>
			</cfif>
		</cfif>
		<cfif curweek eq curweek2>
			<cfset weekday[noweek] = weekday[noweek] + 1>
		<cfelse>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfset newtime = createdate(lastyear,1,1) + days>

  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  
		<Cell ss:StyleID="s51"><Data ss:Type="String">ITEM NO.</Data></Cell>
        <cfif getdisplaysetup.report_aitemno eq 'Y'>
        <Cell ss:StyleID="s51"><Data ss:Type="String">PRODUCT CODE</Data></Cell>
        </cfif>
		<Cell ss:StyleID="s51"><Data ss:Type="String">DESP</Data></Cell>
	<cfloop index="a" from="1" to="#noweek#">
		<Cell ss:StyleID="s51"><Data ss:Type="String">Week #a#</Data></Cell>
	</cfloop>
		<Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL</Data></Cell>
	
	</Row>

  <Row ss:AutoFitHeight="0" ss:Height="20.0625">

		   <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
		   <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
	<cfloop index="a" from="#count#" to="#noweek#">
		<cfset weekday[a] = weekday[a] + 1>

		<cfif count eq 1>
			<Cell ss:StyleID="s53"><Data ss:Type="String">#dateformat(newtime + 1,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</Data></Cell>
		<cfelse>
			<Cell ss:StyleID="s53"><Data ss:Type="String">#dateformat(newtime,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</Data></Cell>
		</cfif>

		<cfset newtime = newtime + weekday[a] >
		<cfset count = count + 1>
	</cfloop>
	</Row>

<cfquery name="getgroup" datasource="#dts#">
	<cfif isdefined("form.include0") and form.include0 eq "yes">
		select if(wos_group is null,'',wos_group) as wos_group from icitem where itemno <> ''
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >='#form.catefrom#' and category <='#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >='#form.groupfrom#' and wos_group <='#form.groupto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
		</cfif>
		group by if(wos_group is null,'',wos_group) order by if(wos_group is null,'',wos_group)
	<cfelse>
		select if(b.wos_group is null,'',b.wos_group) as wos_group from ictran a, icitem b
		where a.wos_date > #getgeneral.lastaccyear# and a.itemno = b.itemno and (a.void = '' or a.void is null) and a.fperiod = '#form.periodfrom#'
		<cfif isdefined("form.include") and form.include eq "yes">
		and (a.type = 'INV' or a.type = 'CS' or a.type = 'DN')
		<cfelse>
		and (a.type = 'INV' or a.type = 'CS')
		</cfif>
        
        <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and a.custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and a.custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and a.custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or a.custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
        
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
		</cfif>
        <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
                
                <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
		</cfif>
		</cfif>
        </cfif>
		<cfif form.areafrom neq "" and form.areato neq "">
		and a.area >='#form.areafrom#' and a.area <='#form.areato#'
		</cfif>
        <cfif form.userfrom neq "" and form.userto neq "">
		and a.van >='#form.userfrom#' and a.van <='#form.userto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group >='#form.groupfrom#' and b.wos_group <='#form.groupto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and b.itemno >='#form.itemfrom#' and b.itemno <= '#form.itemto#'
		</cfif>
		group by if(b.wos_group is null,'',b.wos_group) order by if(b.wos_group is null,'',b.wos_group)
	</cfif>
</cfquery>

<cfset total = arraynew(1)>
<cfset subtotal = arraynew(1)>
<cfset grouptotal = arraynew(1)>
<cfset row = 0>

<cfloop index="a" from="1" to="#noweek#">
	<cfset total[a] = 0>
</cfloop>

<cfif getgroup.recordcount gt 0>
<cfloop query="getgroup">
	<cfloop index="a" from="1" to="#noweek#">
		<cfset grouptotal[a] = 0>
	</cfloop>

	<cfif getgroup.wos_group eq "">
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s41"><Data ss:Type="String">GROUP: No-Grouped</Data></Cell>
			<Cell ss:StyleID="s41"><Data ss:Type="String">No-Grouped</Data></Cell>
 			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>		</Row>
	<cfelse>
		<cfquery name="getgroupname" datasource="#dts#">
			select desp from icgroup where wos_group = "#getgroup.wos_group#"
		</cfquery>
        
        
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#getgroupname.desp#" output = "wddxText9">
			<Cell ss:StyleID="s41"><Data ss:Type="String">GROUP: #getgroup.wos_group#</Data></Cell>
			<Cell ss:StyleID="s41"><Data ss:Type="String">#wddxText9#</Data></Cell>
           
		</Row>
	</cfif>

	<cfquery name="getitem" datasource="#dts#">
		<cfif isdefined("form.include0") and form.include0 eq "yes">
			select itemno,desp,despa,aitemno from icitem where itemno <> '' and <cfif getgroup.wos_group eq "">(wos_group = '#getgroup.wos_group#' or wos_group is null)<cfelse>wos_group = '#getgroup.wos_group#'</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and category >='#form.catefrom#' and category <='#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and wos_group >='#form.groupfrom#' and wos_group <='#form.groupto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
			</cfif>
			group by itemno order by itemno
		<cfelse>
			select b.itemno,b.desp,b.despa,b.aitemno from ictran a,icitem b
			where <cfif getgroup.wos_group eq "">(b.wos_group = '#getgroup.wos_group#' or b.wos_group is null)<cfelse>b.wos_group = '#getgroup.wos_group#'</cfif> 
			and a.wos_date > #getgeneral.lastaccyear#
			and a.itemno = b.itemno and (a.void = '' or a.void is null) and a.fperiod = '#form.periodfrom#'
			<cfif isdefined("form.include") and form.include eq "yes">
			and (a.type = 'INV' or a.type = 'CS' or a.type = 'DN')
			<cfelse>
			and (a.type = 'INV' or a.type = 'CS')
			</cfif>
            
            <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and a.custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and a.custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and a.custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or a.custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
		</cfif>
        </cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
		and a.van >='#form.userfrom#' and a.van <='#form.userto#'
		</cfif>
			group by b.itemno order by b.itemno
		</cfif>
	</cfquery>

	<cfloop query="getitem">
		<cfset row = row + 1>
		<cfset itemno = getitem.itemno>

		<cfloop index="a" from="1" to="#noweek#">
			<cfset subtotal[a] = 0>
		</cfloop>

		<cfquery name="getintran" datasource="#dts#">
			select wos_date,qty,amt from ictran
			where wos_date > #getgeneral.lastaccyear# and fperiod = "#form.periodfrom#" and itemno = '#itemno#' and (void = "" or void is null)
			<cfif isdefined("form.include") and form.include eq "yes">
			and (type = 'INV' or type = 'CS' or type = 'DN')
			<cfelse>
			and (type = 'INV' or type = 'CS')
			</cfif>
            
            <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
		</cfif>
        </cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and van >='#form.userfrom#' and van <='#form.userto#'
			</cfif>
			order by fperiod
		</cfquery>

		<cfif isdefined("form.include") and form.include eq "yes">
			<cfquery name="getouttran" datasource="#dts#">
				select wos_date,qty,amt from ictran
				where wos_date > #getgeneral.lastaccyear# and fperiod = "#form.periodfrom#" and itemno = '#itemno#' and (void = "" or void is null)
				and type = "cn"
                
                <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
                <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
                
                <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
				</cfif>
				</cfif>
                </cfif>
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
                <cfif form.userfrom neq "" and form.userto neq "">
				and van >='#form.userfrom#' and van <='#form.userto#'
				</cfif>
				order by fperiod
			</cfquery>
		</cfif>

		<cfloop query="getintran">
			<cfset checkweek = week(getintran.wos_date)>
			<cfloop index="a" from="1" to="#noweek#">
				<cfif weeks[a] eq checkweek>
					<cfif form.label eq "salesqty">
						<cfset subtotal[a] = subtotal[a] + val(getintran.qty)>
						<cfset grouptotal[a] = grouptotal[a] + val(getintran.qty)>
						<cfset total[a] = total[a] + val(getintran.qty)>
					<cfelse>
						<cfset subtotal[a] = subtotal[a] + val(getintran.amt)>
						<cfset grouptotal[a] = grouptotal[a] + val(getintran.amt)>
						<cfset total[a] = total[a] + val(getintran.amt)>
					</cfif>
				</cfif>
			</cfloop>
		</cfloop>

		<!---<cfif isdefined("form.include") and form.include eq "yes">
			<cfloop query="getouttran">
				<cfset checkweek = week(getouttran.wos_date)>
				<cfloop index="a" from="1" to="#noweek#">
					<cfif weeks[a] eq checkweek>
						<cfif isdefined("form.label") and form.label neq "salesqty">
							<cfset subtotal[a] = subtotal[a] - val(getouttran.qty)>
							<cfset total[a] = total[a] - val(getouttran.qty)>
						<cfelse>
							<cfset subtotal[a] = subtotal[a] - val(getouttran.amt)>
							<cfset total[a] = total[a] - val(getouttran.amt)>
						</cfif>
					</cfif>
				</cfloop>
			</cfloop>
		</cfif>--->

	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
  		   <cfwddx action = "cfml2wddx" input = "#row#. #getitem.itemno#" output = "wddxText10">
  		   <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText11">
  		   <cfwddx action = "cfml2wddx" input = "#getitem.desp##getitem.despa#" output = "wddxText12">
           
  		  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
            <cfif getdisplaysetup.report_aitemno eq 'Y'>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
            </cfif>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
			<cfloop index="a" from="1" to="#noweek#">
				<cfif form.label eq "salesqty">
					<Cell ss:StyleID="s26"><Data ss:Type="String">#val(subtotal[a])#</Data></Cell>
				<cfelse>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(subtotal[a],stDecl_UPrice)#</Data></Cell>
				</cfif>
			</cfloop>
			<cfif form.label eq "salesqty">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#val(arraysum(subtotal))#</Data></Cell>
			<cfelse>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(arraysum(subtotal),stDecl_UPrice)#</Data></Cell>
			</cfif>
		</Row>
	</cfloop>
	
	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
         
		   <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String">SUB-TOTAL:</Data></Cell>
		<cfloop index="a" from="1" to="#noweek#">
			<cfif form.label eq "salesqty">
				<Cell ss:StyleID="s51"><Data ss:Type="String">#val(grouptotal[a])#</Data></Cell>
			<cfelse>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(grouptotal[a],stDecl_UPrice)#</Data></Cell>
			</cfif>
		</cfloop>
		<cfif form.label eq "salesqty">
			<Cell ss:StyleID="s51"><Data ss:Type="String">#val(arraysum(grouptotal))#</Data></Cell>
		<cfelse>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#numberformat(arraysum(grouptotal),stDecl_UPrice)#</Data></Cell>
		</cfif>
	</Row>
    
    	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		         <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
           	</Row>
</cfloop>

    	     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		         <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String">TOTAL:</Data></Cell>
		<cfloop index="a" from="1" to="#noweek#">
			<cfif form.label eq "salesqty">
				<Cell ss:StyleID="s52"><Data ss:Type="String">#val(total[a])#</Data></Cell>
			<cfelse>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(total[a],",.__")#</Data></Cell>
			</cfif>
		</cfloop>
		<cfif form.label eq "salesqty">
			<Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(arraysum(total),"0")#</Data></Cell>
		<cfelse>
			<Cell ss:StyleID="s52"><Data ss:Type="String">#numberformat(arraysum(total),",.__")#</Data></Cell>
		</cfif>
	</Row>
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
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
    
            <cfcase value="HTML">
<html>
<head>
<title>Product Sales By Weekly Report </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfif isdefined('form.agentbycust')>

<cfif form.agentfrom neq "" and form.agentto neq "">
<cfquery name="getagentlist" datasource="#dts#">
select custno from #target_arcust# where 0=0
and agent >='#form.agentfrom#' and agent <= '#form.agentto#'
</cfquery>
<cfset agentlist=valuelist(getagentlist.custno)>
</cfif>

<cfif form.teamfrom neq "" and form.teamto neq "">
<cfquery name="getteamlist" datasource="#dts#">
select custno from #target_arcust# where agent in (select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
</cfquery>
<cfset teamlist=valuelist(getteamlist.custno)>
</cfif>

</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,agentlistuserid from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<body>
<cfoutput>
<cfif isdefined("form.include") and form.include eq "yes">
	<h1 align="center">PRINT #url.trantype# SALES WEEKLY REPORT (Included DN/CN)</h1>
<cfelse>
	<h1 align="center">PRINT #url.trantype# SALES WEEKLY REPORT (Excluded DN/CN)</h1>
</cfif>
<cfquery name="getdisplaysetup" datasource="#dts#">
	select 
	* 
	from displaysetup;
</cfquery>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
    	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">MONTH: #form.monthfrom#</font></div></td>
    </tr>
    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
        <tr>
          	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
        </tr>
    </cfif>
    <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
        <tr>
        	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
        </tr>
    </cfif>
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
        <tr>
          	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
        </tr>
    </cfif>
    <tr>
      	<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="10"><hr></td>
    </tr>

	<cfset lastyear = year(getgeneral.lastaccyear)>
	<cfset lastmonth = month(getgeneral.lastaccyear)>
	<cfset lastday = 1>
	<cfset selectedmonth = val(form.periodfrom)>
	<cfset count = 1>
	<cfset noweek = 1>
	<cfset weekday = arraynew(1)>
	<cfset weeks = arraynew(1)>
	<cfset lastmonth = lastmonth + selectedmonth>

	<cfif lastmonth gt 24>
		<cfset lastyear = lastyear + 2>
		<cfset lastmonth = lastmonth -24>
        <cfelseif lastmonth gt 12>
        <cfset lastyear = lastyear + 1>
		<cfset lastmonth = lastmonth -12>
	</cfif>

	<cfset days = firstdayofmonth(createdate(lastyear,lastmonth,lastday)) - 2>

	<cfset totalday = daysinmonth(createdate(lastyear,lastmonth,1))>
	<cfset curweek = week(createdate(lastyear,lastmonth,1))>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif curweek neq curweek2>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfloop index="a" from="1" to="#noweek#">
		<cfset weekday[a] = 0>
	</cfloop>

	<cfset curweek = week(createdate(lastyear,lastmonth,1))>
	<cfset noweek = 1>

	<cfloop index="a" from="1" to="#totalday#">
		<cfset curweek2 = week(createdate(lastyear,lastmonth,a))>
		<cfif a neq totalday>
			<cfset weeks[noweek] = curweek>
		<cfelse>
			<cfif week(createdate(lastyear,lastmonth,a-1)) eq week(createdate(lastyear,lastmonth,a))>
				<cfset weeks[noweek] = week(createdate(lastyear,lastmonth,a))>
			<cfelse>
				<cfset weeks[noweek + 1] = week(createdate(lastyear,lastmonth,a))>
			</cfif>
		</cfif>
		<cfif curweek eq curweek2>
			<cfset weekday[noweek] = weekday[noweek] + 1>
		<cfelse>
			<cfset noweek = noweek + 1>
			<cfset curweek = curweek2>
		</cfif>
	</cfloop>

	<cfset newtime = createdate(lastyear,1,1) + days>

	<tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
        <cfif getdisplaysetup.report_aitemno eq 'Y'>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT CODE</font></div></td>
        </cfif>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
	<cfloop index="a" from="1" to="#noweek#">
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Week #a#</font></div></td>
	</cfloop>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
	<cfloop index="a" from="#count#" to="#noweek#">
		<cfset weekday[a] = weekday[a] + 1>

		<cfif count eq 1>
			<td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(newtime + 1,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</font></div></td>
		<cfelse>
			<td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(newtime,"ddd dd")# - #dateformat(newtime + weekday[a] - 1,"ddd dd")#</font></div></td>
		</cfif>

		<cfset newtime = newtime + weekday[a] >
		<cfset count = count + 1>
	</cfloop>
	</tr>
	<tr>
      	<td colspan="10"><hr></td>
    </tr>

<cfquery name="getgroup" datasource="#dts#">
	<cfif isdefined("form.include0") and form.include0 eq "yes">
		select if(wos_group is null,'',wos_group) as wos_group from icitem where itemno <> ''
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >='#form.catefrom#' and category <='#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >='#form.groupfrom#' and wos_group <='#form.groupto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
		</cfif>
		group by if(wos_group is null,'',wos_group) order by if(wos_group is null,'',wos_group)
	<cfelse>
		select if(b.wos_group is null,'',b.wos_group) as wos_group from ictran a, icitem b
		where a.wos_date > #getgeneral.lastaccyear# and a.itemno = b.itemno and (a.void = '' or a.void is null) and a.fperiod = '#form.periodfrom#'
		<cfif isdefined("form.include") and form.include eq "yes">
		and (a.type = 'INV' or a.type = 'CS' or a.type = 'DN')
		<cfelse>
		and (a.type = 'INV' or a.type = 'CS')
		</cfif>
        
        <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and a.custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and a.custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and a.custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or a.custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
        
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
		</cfif>
        <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
                
                <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
		</cfif>
		</cfif>
        </cfif>
		<cfif form.areafrom neq "" and form.areato neq "">
		and a.area >='#form.areafrom#' and a.area <='#form.areato#'
		</cfif>
        <cfif form.userfrom neq "" and form.userto neq "">
		and a.van >='#form.userfrom#' and a.van <='#form.userto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group >='#form.groupfrom#' and b.wos_group <='#form.groupto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and b.itemno >='#form.itemfrom#' and b.itemno <= '#form.itemto#'
		</cfif>
		group by if(b.wos_group is null,'',b.wos_group) order by if(b.wos_group is null,'',b.wos_group)
	</cfif>
</cfquery>

<cfset total = arraynew(1)>
<cfset subtotal = arraynew(1)>
<cfset grouptotal = arraynew(1)>
<cfset row = 0>

<cfloop index="a" from="1" to="#noweek#">
	<cfset total[a] = 0>
</cfloop>

<cfif getgroup.recordcount gt 0>
<cfloop query="getgroup">
	<cfloop index="a" from="1" to="#noweek#">
		<cfset grouptotal[a] = 0>
	</cfloop>

	<cfif getgroup.wos_group eq "">
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>GROUP: No-Grouped </u></strong></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>No-Grouped</u></strong></div></td>
		</tr>
	<cfelse>
		<cfquery name="getgroupname" datasource="#dts#">
			select desp from icgroup where wos_group = "#getgroup.wos_group#"
		</cfquery>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>GROUP: #getgroup.wos_group#</u></strong></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getgroupname.desp#</u></strong></div></td>
		</tr>
	</cfif>

	<cfquery name="getitem" datasource="#dts#">
		<cfif isdefined("form.include0") and form.include0 eq "yes">
			select itemno,desp,despa,aitemno from icitem where itemno <> '' and <cfif getgroup.wos_group eq "">(wos_group = '#getgroup.wos_group#' or wos_group is null)<cfelse>wos_group = '#getgroup.wos_group#'</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and category >='#form.catefrom#' and category <='#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and wos_group >='#form.groupfrom#' and wos_group <='#form.groupto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
			</cfif>
			group by itemno order by itemno
		<cfelse>
			select b.itemno,b.desp,b.despa,b.aitemno from ictran a,icitem b
			where <cfif getgroup.wos_group eq "">(b.wos_group = '#getgroup.wos_group#' or b.wos_group is null)<cfelse>b.wos_group = '#getgroup.wos_group#'</cfif> 
			and a.wos_date > #getgeneral.lastaccyear#
			and a.itemno = b.itemno and (a.void = '' or a.void is null) and a.fperiod = '#form.periodfrom#'
			<cfif isdefined("form.include") and form.include eq "yes">
			and (a.type = 'INV' or a.type = 'CS' or a.type = 'DN')
			<cfelse>
			and (a.type = 'INV' or a.type = 'CS')
			</cfif>
            
            <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and a.custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and a.custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and a.custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or a.custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
		</cfif>
        </cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
		and a.van >='#form.userfrom#' and a.van <='#form.userto#'
		</cfif>
			group by b.itemno order by b.itemno
		</cfif>
	</cfquery>

	<cfloop query="getitem">
		<cfset row = row + 1>
		<cfset itemno = getitem.itemno>

		<cfloop index="a" from="1" to="#noweek#">
			<cfset subtotal[a] = 0>
		</cfloop>

		<cfquery name="getintran" datasource="#dts#">
			select wos_date,qty,amt from ictran
			where wos_date > #getgeneral.lastaccyear# and fperiod = "#form.periodfrom#" and itemno = '#itemno#' and (void = "" or void is null)
			<cfif isdefined("form.include") and form.include eq "yes">
			and (type = 'INV' or type = 'CS' or type = 'DN')
			<cfelse>
			and (type = 'INV' or type = 'CS')
			</cfif>
            
            <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
            
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
		</cfif>
        </cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and van >='#form.userfrom#' and van <='#form.userto#'
			</cfif>
			order by fperiod
		</cfquery>

		<cfif isdefined("form.include") and form.include eq "yes">
			<cfquery name="getouttran" datasource="#dts#">
				select wos_date,qty,amt from ictran
				where wos_date > #getgeneral.lastaccyear# and fperiod = "#form.periodfrom#" and itemno = '#itemno#' and (void = "" or void is null)
				and type = "cn"
                
                <!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
<cfelse>
       <!---Agent from Bill--->
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
                <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
                
                <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
				</cfif>
				</cfif>
                </cfif>
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
                <cfif form.userfrom neq "" and form.userto neq "">
				and van >='#form.userfrom#' and van <='#form.userto#'
				</cfif>
				order by fperiod
			</cfquery>
		</cfif>

		<cfloop query="getintran">
			<cfset checkweek = week(getintran.wos_date)>
			<cfloop index="a" from="1" to="#noweek#">
				<cfif weeks[a] eq checkweek>
					<cfif form.label eq "salesqty">
						<cfset subtotal[a] = subtotal[a] + val(getintran.qty)>
						<cfset grouptotal[a] = grouptotal[a] + val(getintran.qty)>
						<cfset total[a] = total[a] + val(getintran.qty)>
					<cfelse>
						<cfset subtotal[a] = subtotal[a] + val(getintran.amt)>
						<cfset grouptotal[a] = grouptotal[a] + val(getintran.amt)>
						<cfset total[a] = total[a] + val(getintran.amt)>
					</cfif>
				</cfif>
			</cfloop>
		</cfloop>

		<!---<cfif isdefined("form.include") and form.include eq "yes">
			<cfloop query="getouttran">
				<cfset checkweek = week(getouttran.wos_date)>
				<cfloop index="a" from="1" to="#noweek#">
					<cfif weeks[a] eq checkweek>
						<cfif isdefined("form.label") and form.label neq "salesqty">
							<cfset subtotal[a] = subtotal[a] - val(getouttran.qty)>
							<cfset total[a] = total[a] - val(getouttran.qty)>
						<cfelse>
							<cfset subtotal[a] = subtotal[a] - val(getouttran.amt)>
							<cfset total[a] = total[a] - val(getouttran.amt)>
						</cfif>
					</cfif>
				</cfloop>
			</cfloop>
		</cfif>--->

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#row#. #getitem.itemno#</font></div></td>
            <cfif getdisplaysetup.report_aitemno eq 'Y'>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.aitemno#</font></div></td>
            </cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp##getitem.despa#</font></div></td>
			<cfloop index="a" from="1" to="#noweek#">
				<cfif form.label eq "salesqty">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(subtotal[a])#</font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal[a],stDecl_UPrice)#</font></div></td>
				</cfif>
			</cfloop>
			<cfif form.label eq "salesqty">
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(arraysum(subtotal))#</font></div></td>
			<cfelse>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(arraysum(subtotal),stDecl_UPrice)#</font></div></td>
			</cfif>
		</tr>
		<cfflush>
	</cfloop>
	<tr>
      	<td colspan="10"><hr></td>
    </tr>
	<tr>
		<td></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">SUB-TOTAL:</font></div></td>
		<cfloop index="a" from="1" to="#noweek#">
			<cfif form.label eq "salesqty">
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(grouptotal[a])#</font></div></td>
			<cfelse>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grouptotal[a],stDecl_UPrice)#</font></div></td>
			</cfif>
		</cfloop>
		<cfif form.label eq "salesqty">
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(arraysum(grouptotal))#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(arraysum(grouptotal),stDecl_UPrice)#</font></div></td>
		</cfif>
	</tr>
	<tr><td><br></td></tr>
</cfloop>
	<tr>
      	<td colspan="10"><hr></td>
    </tr>
	<tr>
		<td></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<cfloop index="a" from="1" to="#noweek#">
			<cfif form.label eq "salesqty">
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#val(total[a])#</strong></font></div></td>
			<cfelse>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total[a],",.__")#</strong></font></div></td>
			</cfif>
		</cfloop>
		<cfif form.label eq "salesqty">
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(arraysum(total),"0")#</strong></font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(arraysum(total),",.__")#</strong></font></div></td>
		</cfif>
	</tr>
</table>
</cfif>

<cfif getgroup.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
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