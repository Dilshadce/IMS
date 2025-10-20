

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid from gsetup
</cfquery>


<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>
<cfquery name="getlocationlist" datasource="#dts#">
select refno from ictran where location >='#form.locationFrom#' and location <= '#form.locationTo#' group by refno
</cfquery>

<cfset locationlist=valuelist(getlocationlist.refno)>

    
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
	<cfcase value="EXCEL">
    



<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<cfquery name="gettotal" datasource="#dts#">
			select sum(invgross) as invgross,sum(discount) as discount,sum(net) as net,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd)+sum(CS_PM_crc2) as CS_PM_crcd,sum(CS_PM_cheq) as CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc,sum(CS_PM_dbcd) as CS_PM_dbcd,sum(CS_PM_cashcd) as CS_PM_cashcd,sum(roundadj) as roundadj,sum(m_charge1) as m_charge1 from artran
			where type='CS' and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
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
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                 <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
                 <Style ss:ID="s52">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                <Style ss:ID="s55">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                 <Style ss:ID="s56">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                  <Style ss:ID="s53">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                 <Style ss:ID="s54">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Cash Sales Summary Report">

<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="90.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                        
          <cfoutput>
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Cash Sales Summary Report</Data></Cell>
			</Row>
            
			<cfif form.periodfrom neq "" and form.periodto neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText1">
				<Cell ss:StyleID="s26"><Data ss:Type="String">PERIOD: #wddxText1#</Data></Cell>
			</Row>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText2">
					<Cell ss:StyleID="s26"><Data ss:Type="String">DATE: #wddxText2#</Data></Cell>
				</Row>
			</cfif>
			
			<cfif form.agentfrom neq "" and form.agentto neq "">
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText3">
				  <Cell ss:StyleID="s26"><Data ss:Type="String">AGENT: #wddxText3#</Data></Cell>
				</Row>
			</cfif>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText4">
                 <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText5">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
				<Cell></Cell>
				<Cell></Cell>
				<Cell></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
			</Row>
			
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s50"><Data ss:Type="String">Sales Record</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
			</Row>
			
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.invgross,',_.__')#" output = "wddxText6">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Gross Total :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.discount,',_.__')#" output = "wddxText7">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Discount Total :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.net,',_.__')#" output = "wddxText8">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Net Total :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.tax,',_.__')#" output = "wddxText9">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Tax Total :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
			</Row>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.roundadj,',_.__')#" output = "wddxText">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Rounding Adjustment Total :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.m_charge1,',_.__')#" output = "wddxText">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Misc Charge Total :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.grand,',_.__')#" output = "wddxText10">
            	<Cell ss:StyleID="s51"><Data ss:Type="String">Grand Total :</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText10#</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			</Row>
         
         <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			</Row>
            
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s55"><Data ss:Type="String">Collection Record</Data></Cell>
				<Cell ss:StyleID="s55"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s55"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s55"><Data ss:Type="String"></Data></Cell>
			</Row>
			
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<Cell ss:StyleID="s52"><Data ss:Type="String">Mode of Payment</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">Amount</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">%</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">No. of Transaction</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">%</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
			</Row>
     
            
            <cfquery name="gettotalrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcashrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_cash !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getdbcdrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_dbcd !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcashcdrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_cashcd !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcrcdrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and (CS_PM_crcd !=0 or CS_PM_crc2 !=0)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcheqrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_cheq !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getvoucrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_vouc !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>

<cfif val(gettotal.grand) eq 0>
<cfset gettotal.grand=1>
</cfif>
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_Cash,',_.__')#" output = "wddxText11">
                 <cfwddx action = "cfml2wddx" input = "#numberformat((val(gettotal.cs_pm_cash)/val(gettotal.grand))*100,',_.__')#" output = "wddxText12">
                 <cfwddx action = "cfml2wddx" input = "#getcashrecord.recordcount#" output = "wddxText13">
                
                 <Cell ss:StyleID="s26"><Data ss:Type="String">Cash :</Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#%</Data></Cell>
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
                 <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcashrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_dbcd,',_.__')#" output = "wddxText15">
                 <cfwddx action = "cfml2wddx" input = "#numberformat((val(gettotal.cs_pm_cash)/val(gettotal.grand))*100,',_.__')#" output = "wddxText16">
                 <cfwddx action = "cfml2wddx" input = "#getdbcdrecord.recordcount#" output = "wddxText17">

            	<Cell ss:StyleID="s26"><Data ss:Type="String">Net :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText16#%</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText17#</Data></Cell>
              	<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getdbcdrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_Cashcd,',_.__')#" output = "wddxText19">
                 <cfwddx action = "cfml2wddx" input = "#numberformat((val(gettotal.cs_pm_cash)/val(gettotal.grand))*100,',_.__')#" output = "wddxText20">
                 <cfwddx action = "cfml2wddx" input = "#getcashcdrecord.recordcount#" output = "wddxText21">

            	<Cell ss:StyleID="s26"><Data ss:Type="String">Cash Card :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText19#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText20#%</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText21#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcashcdrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_crcd,',_.__')#" output = "wddxText23">
                 <cfwddx action = "cfml2wddx" input = "#numberformat((val(gettotal.CS_PM_crcd)/val(gettotal.grand))*100,',_.__')#" output = "wddxText24">
                 <cfwddx action = "cfml2wddx" input = "#getcrcdrecord.recordcount#" output = "wddxText25">

            	<Cell ss:StyleID="s26"><Data ss:Type="String">Credit Card :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText23#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText24#%</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText25#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcrcdrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_cheq,',_.__')#" output = "wddxText27">
                 <cfwddx action = "cfml2wddx" input = "#numberformat((val(gettotal.CS_PM_cheq)/val(gettotal.grand))*100,',_.__')#" output = "wddxText28">
                 <cfwddx action = "cfml2wddx" input = "#getcheqrecord.recordcount#" output = "wddxText29">

            	<Cell ss:StyleID="s26"><Data ss:Type="String">Cheque :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText27#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText28#%</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText29#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcheqrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></Data></Cell>

			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                  <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_vouc,',_.__')#" output = "wddxText31">
                 <cfwddx action = "cfml2wddx" input = "#numberformat((val(gettotal.CS_PM_vouc)/val(gettotal.grand))*100,',_.__')#" output = "wddxText32">
                 <cfwddx action = "cfml2wddx" input = "#getvoucrecord.recordcount#" output = "wddxText33">

            	<Cell ss:StyleID="s51"><Data ss:Type="String">Voucher :</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText31#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText32#%</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText33#</Data></Cell>
                <Cell ss:StyleID="s51"><Data ss:Type="String"><cfif gettotalrecord.recordcount eq 0><cfelse>
                
                #numberformat((val(getvoucrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></Data></Cell>
                                <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>

			</Row>
         <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			</Row>
           
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s56"><Data ss:Type="String">Credit Card Record</Data></Cell>
			</Row>
		
            <cfquery name="getvisa" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='VISA')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getmaster" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='MASTER')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getamex" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='AMEX')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getjcb" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='JCB')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getdiners" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='DINERS')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        
        <cfquery name="getvisa2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='VISA')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getmaster2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='MASTER')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getamex2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='AMEX')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getjcb2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='JCB')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getdiners2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='DINERS')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<Cell ss:StyleID="s53"><Data ss:Type="String">Type</Data></Cell>
				<Cell ss:StyleID="s53"><Data ss:Type="String">Total</Data></Cell>
                <Cell ss:StyleID="s53"><Data ss:Type="String">Charges</Data></Cell>
                <Cell ss:StyleID="s53"><Data ss:Type="String">Usage%</Data></Cell>
                <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s53"><Data ss:Type="String"></Data></Cell>
			</Row>
            
            <cfif val(gettotal.CS_PM_crcd) eq 0>
            <cfset gettotal.CS_PM_crcd=1>
            </cfif>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd),',_.__')#" output = "wddxText35">
		 <cfwddx action = "cfml2wddx" input = "#numberformat(((val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#" output = "wddxText36">
    
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Visa</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText35#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText36#%</Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd),',_.__')#" output = "wddxText37">
        <cfwddx action = "cfml2wddx" input = "#numberformat(((val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#" output = "wddxText38">
    
          <Cell ss:StyleID="s26"><Data ss:Type="String">Master</Data></Cell>
		  <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText37#</Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
          <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText38#%</Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#numberformat(val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd),',_.__')#" output = "wddxText39">
         <cfwddx action = "cfml2wddx" input = "#numberformat(((val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#" output = "wddxText40">

            	<Cell ss:StyleID="s26"><Data ss:Type="String">Amex</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText39#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText40#%</Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#numberformat(val(getjcb.CS_PM_crcd)+val(getjcb2.CS_PM_crcd),',_.__')#" output = "wddxText41">
         <cfwddx action = "cfml2wddx" input = "#numberformat(((val(getjcb.CS_PM_crcd)+val(getjcb2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#" output = "wddxText42">
    
            	<Cell ss:StyleID="s26"><Data ss:Type="String">JCB</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText41#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
               <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText42#%</Data></Cell>
			</Row>
            
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
         <cfwddx action = "cfml2wddx" input = "#numberformat(val(getdiners.CS_PM_crcd)+val(getdiners2.CS_PM_crcd),',_.__')#" output = "wddxText43">
        <cfwddx action = "cfml2wddx" input = "#numberformat(((val(getdiners.CS_PM_crcd)+val(getdiners2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#" output = "wddxText44">
    
            	<Cell ss:StyleID="s26"><Data ss:Type="String">DINERS</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText43#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText44#%</Data></Cell>
			</Row>

		  </Table>
		</cfoutput>
        
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
		<title>Cash Sales Summary Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<body>
		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<cfquery name="gettotal" datasource="#dts#">
			select sum(invgross) as invgross,sum(discount) as discount,sum(net) as net,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd)+sum(CS_PM_crc2) as CS_PM_crcd,sum(CS_PM_cheq) as CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc,sum(CS_PM_dbcd) as CS_PM_dbcd,sum(CS_PM_cashcd) as CS_PM_cashcd,sum(roundadj) as roundadj,sum(m_charge1) as m_charge1 from artran
			where type='CS' and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>

		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Cash Sales Summary Report</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
				  <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Sales Record</strong></font></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            
			<tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Gross Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.invgross,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Discount Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.discount,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Net Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.net,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Tax Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.tax,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Rounding Adjustment Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.roundadj,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Misc Charge Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.m_charge1,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Grand Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.grand,',_.__')#</font></td>
			</tr>
            
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td colspan="100%"><br></td>
			</tr>
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Collection Record</strong></font></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Mode of Payment</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">Amount</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">%</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">No. of Transaction</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">%</font></td>
			</tr>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            
            <cfquery name="gettotalrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcashrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_cash !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getdbcdrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_dbcd !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcashcdrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_cashcd !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcrcdrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and (CS_PM_crcd !=0 or CS_PM_crc2 !=0)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getcheqrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_cheq !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getvoucrecord" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null) and CS_PM_vouc !=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>

<cfif val(gettotal.grand) eq 0>
<cfset gettotal.grand=1>
</cfif>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Cash :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_Cash,',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat((val(gettotal.cs_pm_cash)/val(gettotal.grand))*100,',_.__')#%</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#getcashrecord.recordcount#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcashrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></font></td>
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Net :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_dbcd,',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat((val(gettotal.cs_pm_cash)/val(gettotal.grand))*100,',_.__')#%</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#getdbcdrecord.recordcount#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getdbcdrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></font></td>
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Cash Card :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_Cashcd,',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat((val(gettotal.cs_pm_cash)/val(gettotal.grand))*100,',_.__')#%</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#getcashcdrecord.recordcount#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcashcdrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></font></td>
			</tr>

            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Credit Card :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_crcd,',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat((val(gettotal.CS_PM_crcd)/val(gettotal.grand))*100,',_.__')#%</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#getcrcdrecord.recordcount#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcrcdrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Cheque :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_cheq,',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat((val(gettotal.CS_PM_cheq)/val(gettotal.grand))*100,',_.__')#%</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#getcheqrecord.recordcount#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getcheqrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Voucher :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_vouc,',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat((val(gettotal.CS_PM_vouc)/val(gettotal.grand))*100,',_.__')#%</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#getvoucrecord.recordcount#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"><cfif gettotalrecord.recordcount eq 0><cfelse>#numberformat((val(getvoucrecord.recordcount)/val(gettotalrecord.recordcount))*100,',_.__')#</cfif></font></td>
			</tr>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td colspan="100%"><br></td>
			</tr>
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Credit Card Record</strong></font></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            <cfquery name="getvisa" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='VISA')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getmaster" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='MASTER')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getamex" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='AMEX')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getjcb" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='JCB')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getdiners" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem10='DINERS')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        
        <cfquery name="getvisa2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='VISA')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getmaster2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='MASTER')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getamex2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='AMEX')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getjcb2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='JCB')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
        
        <cfquery name="getdiners2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type='CS' and (void = '' or void is null) and (rem8='DINERS')
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#locationlist#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			
		</cfquery>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Type</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">Total</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Charges</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Usage%</font></td>
			</tr>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            <cfif val(gettotal.CS_PM_crcd) eq 0>
            <cfset gettotal.CS_PM_crcd=1>
            </cfif>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Visa</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd),',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"></font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat(((val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#%</font></td>
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Master</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd),',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"></font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat(((val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#%</font></td>
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Amex</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd),',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"></font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat(((val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#%</font></td>
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">JCB</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getjcb.CS_PM_crcd)+val(getjcb2.CS_PM_crcd),',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"></font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat(((val(getjcb.CS_PM_crcd)+val(getjcb2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#%</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">DINERS</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getdiners.CS_PM_crcd)+val(getdiners2.CS_PM_crcd),',_.__')#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif"></font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#numberformat(((val(getdiners.CS_PM_crcd)+val(getdiners2.CS_PM_crcd))/val(gettotal.CS_PM_crcd))*100,',_.__')#%</font></td>
			</tr>

		  </table>
		</cfoutput>

		
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
 </cfcase>
</cfswitch>