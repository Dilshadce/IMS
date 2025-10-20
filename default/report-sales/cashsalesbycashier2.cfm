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

<cfquery name="getlist" datasource="#dts#">
select refno from ictran where 
location between '#form.locfrom#' and '#form.locto#' 
and type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) 
<cfif form.periodfrom neq "" and form.periodto neq "">
and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
</cfif> 
group by refno
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
		<cfxml variable="data">
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
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
		  	<Style ss:ID="s27">
		   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		  	</Style>
		  	<Style ss:ID="s29">
		   		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Top" ss:LineStyle="Double" ss:Weight="3"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  	</Style>
		  	<Style ss:ID="s30">
		   		<NumberFormat ss:Format="@"/>
		  	</Style>
		  	<Style ss:ID="s31">
		   		<NumberFormat ss:Format="@"/>
		  	</Style>

			<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>

		  	<Style ss:ID="s32">
		   		<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		  	</Style>
		  	<Style ss:ID="s33">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<NumberFormat ss:Format="@"/>
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
			   <NumberFormat ss:Format="#,###,###,##0.00"/>
		  	</Style>
		  	<Style ss:ID="s36">
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  	</Style>
		  	<Style ss:ID="s37">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   		</Borders>
		   		<NumberFormat ss:Format="#,###,###,##0.00"/>
		  	</Style>
		  	<Style ss:ID="s39">
		   		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  	</Style>
		  	<Style ss:ID="s40">
		   		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		  	<Style ss:ID="s42">
		   		<Alignment ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
	 	</Styles>
	 	<Worksheet ss:Name="Cash_Sales_Report">
	 	<cfoutput>
		<Table ss:ExpandedColumnCount="17" x:FullColumns="1" x:FullRows="1">
		<Column ss:Width="64.5"/>
		<Column ss:Width="47.25"/>
		<Column ss:Width="54.75"/>
		<Column ss:Width="60.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="5"/>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<Cell ss:MergeAcross="8" ss:StyleID="s22"><Data ss:Type="String">Daily Cash Sales Report By Cashier</Data></Cell>
		</Row>
	   <cfif form.periodfrom neq "" and form.periodto neq "">
	   		<cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
	   		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="8" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
	   		</Row>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<cfwddx action = "cfml2wddx" input = "DATE: #form.datefrom# - #form.dateto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="8" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
	   		</Row>
		</cfif>
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			<cfwddx action = "cfml2wddx" input = "AGENT: #form.agentfrom# - #form.agentto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="8" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
	   		</Row>
		</cfif>
        
        <cfif form.locfrom neq "" and form.locto neq "">
			<cfwddx action = "cfml2wddx" input = "LOCATION: #form.locfrom# - #form.locto#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="8" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
	   		</Row>
		</cfif>
		
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			<Cell ss:MergeAcross="7" ss:StyleID="s40"><Data ss:Type="String">#wddxText#</Data></Cell>
			<Cell ss:StyleID="s42"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
		</Row>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<Cell ss:StyleID="s27"><Data ss:Type="String">Date.</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Login Time</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Logout Time</Data></Cell>
			<Cell ss:StyleID="s27"><Data ss:Type="String">Sales Q'ty</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Rounding Adjustment</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Misc Charges</Data></Cell>
			<Cell ss:StyleID="s27"><Data ss:Type="String">Grand</Data></Cell>
			<Cell ss:StyleID="s27"><Data ss:Type="String">Cash</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Net</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Cash Card</Data></Cell>
			<Cell ss:StyleID="s27"><Data ss:Type="String">Visa</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Master</Data></Cell>
			<Cell ss:StyleID="s27"><Data ss:Type="String">Cheque</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Voucher</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Deposit</Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String">Agent</Data></Cell>
            
		</Row>
			<cfset totalqty=0>
		    <cfset totalsales = 0>
            <cfset totaldiscount = 0>
            <cfset totaltax = 0>
            <cfset totalgrand = 0>
			<cfset totalcash = 0>
            <cfset totalnet = 0>
            <cfset totalcashcd = 0>
			<cfset totalcrcd = 0>
            <cfset totalcrcd2 = 0>
			<cfset totalcheque = 0>
			<cfset totalvoucher = 0>
			<cfset totaldeposit = 0>
			<cfset totalmisc=0>
            <cfset totalroundadj=0>
            	

		<cfquery name="getagent" datasource="#dts#">
			select wos_date,refno,cashier,counter,sum(invgross) as invgross,sum(discount) as discount,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd) as CS_PM_crcd,sum(CS_PM_crc2) as CS_PM_crc2,sum(CS_PM_cheq) as  CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc, sum(deposit) as deposit,sum(CS_PM_dbcd) as CS_PM_dbcd,sum(CS_PM_cashcd) as CS_PM_cashcd,sum(m_charge1) as m_charge1,sum(roundadj) as roundadj,cashier from artran
			where type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locfrom neq "" and form.locto neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
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
			group by wos_date order by WOS_DATE
		</cfquery>

		<cfloop query="getagent">

<cfquery name="getictran" datasource="#dts#">
                select sum(qty)as qty from ictran
                where type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
             <cfif form.locfrom neq "" and form.locto neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
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
            and wos_date=#getagent.wos_date#
                </cfquery>
                
        <cfquery name="getmaster" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where  type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
             and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype1='MASTER')
		</cfquery>
        
        <cfquery name="getmaster2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crc2 from artran
			where   type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
             and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype2='MASTER')
		</cfquery>
        
        <cfquery name="getvisa" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where   type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
            and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype1='VISA')
		</cfquery>
        
        <cfquery name="getvisa2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crc2 from artran
			where   type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
             and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype2='VISA')
		</cfquery>
                

				<Row ss:AutoFitHeight="0">
                <cfset listagent=''>
           		<cfquery name="getagentlist" datasource="#dts#">
                 select agenno from artran 
                 where 
                 type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) 
                 and (void = '' or void is null) 
                 and wos_date=#getagent.wos_date# 
				<cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>

                 group by agenno
                </cfquery>
                <cfloop query="getagentlist">
                <cfif listagent eq ''>
                 <cfset listagent=listagent&getagentlist.agenno>
                <cfelse>
                <cfset listagent=listagent&","&getagentlist.agenno>
                </cfif>
                </cfloop>
                
                <cfquery name="getlogintime" datasource="#dts#">
                        select userlogtime from poslog where status='Success' and userlogtime like '#dateformat(getagent.WOS_DATE,"yyyy-mm-dd")#%'
                        <cfif form.locfrom neq "" and form.locto neq "">
						and location between'#form.locfrom#' and '#form.locto#'
						</cfif>
                        order by userlogtime
                        </cfquery>
                        
                        <cfquery name="getlogouttime" datasource="#dts#">
                        select userlogtime from poslog where status='Logout' and userlogtime like '#dateformat(getagent.WOS_DATE,"yyyy-mm-dd")#%'
                        <cfif form.locfrom neq "" and form.locto neq "">
						and location between'#form.locfrom#' and '#form.locto#'
						</cfif>
                        order by userlogtime desc
                        </cfquery>
                
                <cfwddx action = "cfml2wddx" input = "#listagent#" output = "wddxText">
                <cfwddx action = "cfml2wddx" input = "#timeformat(getlogintime.userlogtime,'HH:MM:SS')#" output = "wddxText2">
                <cfwddx action = "cfml2wddx" input = "#timeformat(getlogouttime.userlogtime,'HH:MM:SS')#" output = "wddxText3">
					<Cell ss:StyleID="s30"><Data ss:Type="String">#DateFormat(getagent.WOS_DATE,"dd/mm/yyyy")#</Data></Cell>
                    <Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText2#</Data></Cell>
                    <Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText3#</Data></Cell>
                    
					<Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getictran.qty)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.roundadj)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.m_charge1)#</Data></Cell>
					<Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.grand)#</Data></Cell>
					<Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.CS_PM_cash)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.CS_PM_dbcd)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.CS_PM_cashcd)#</Data></Cell>
					<Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crc2)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crc2)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.CS_PM_cheq)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.CS_PM_vouc)#</Data></Cell>
                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getagent.deposit)#</Data></Cell>
                     
                      <Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText#</Data></Cell>
                                
								<cfset totalqty = totalqty + val(getictran.qty)>
								<cfset totalgrand = totalgrand + val(getagent.grand)>
								<cfset totalcash = totalcash + val(getagent.CS_PM_cash)>
                                <cfset totalnet = totalnet + val(getagent.CS_PM_dbcd)>
                                <cfset totalcashcd = totalcashcd + val(getagent.CS_PM_cashcd)>
								<cfset totalcheque = totalcheque + val(getagent.CS_PM_cheq)>
								<cfset totalvoucher = totalvoucher + val(getagent.CS_PM_vouc)>
								<cfset totaldeposit = totaldeposit + val(getagent.deposit)>
                                <cfset totalmisc = totalmisc + val(getagent.M_charge1)>
                                <cfset totalroundadj = totalroundadj + val(getagent.roundadj)>
                                
								<cfset totalcrcd = totalcrcd + val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crc2)>
								<cfset totalcrcd2 = totalcrcd2 + val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crc2)>
			   	</Row>
			</cfloop>
            
	   	<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s36"><Data ss:Type="String">Grand Total</Data></Cell>
            <Cell ss:StyleID="s36"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s36"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalqty#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totalroundadj#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totalmisc#</Data></Cell>
			<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalgrand#</Data></Cell>
			<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalcash#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totalnet#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totalcashcd#</Data></Cell>
			<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalcrcd#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totalcrcd2#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totalcheque#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totalvoucher#</Data></Cell>
            <Cell ss:StyleID="s37"><Data ss:Type="Number">#totaldeposit#</Data></Cell>
            
            
	   	</Row>
	   	<Row ss:AutoFitHeight="0" ss:Height="12"/>
	  	</Table>
	  	</cfoutput>
	 	</Worksheet>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_List_#huserid#.xls" output="#tostring(data)#">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_List_#huserid#.xls">
	</cfcase>

	<cfcase value="HTML">
		<html>
		<head>
		<title>Daily Cash Sales Report By Cashier</title>
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

		<cfquery name="getagent" datasource="#dts#">
			select wos_date,refno,cashier,counter,sum(invgross) as invgross,sum(discount) as discount,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd) as CS_PM_crcd,sum(CS_PM_crc2) as CS_PM_crc2,sum(CS_PM_cheq) as  CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc,sum(CS_PM_dbcd) as CS_PM_dbcd,sum(CS_PM_cashcd) as CS_PM_cashcd, sum(deposit) as deposit, sum(m_charge1) as m_charge1, sum(roundadj) as roundadj from artran
			where type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
           <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
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
			group by wos_date order by WOS_DATE
		</cfquery>

		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Daily Cash Sales Report</strong></font></div></td>
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
            <cfif form.locfrom neq "" and form.locto neq "">
				<tr>
				  <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Location: #form.locfrom# - #form.locto#</font></div></td>
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
				<td><font size="2" face="Times New Roman, Times, serif">Date</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Login Time</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Logout Time</font></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Sales Q'ty</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Rounding Adjustment</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Misc Charges</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Grand</font></div></td>
				
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Cash</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Nets</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Cash Card</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Visa</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Master</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Cheque</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Voucher</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Deposit</font></div></td>
               
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Agent</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            
			<cfset totalqty=0>
            <cfset totalsales = 0>
            <cfset totaldiscount = 0>
            <cfset totaltax = 0>
            <cfset totalgrand = 0>
			<cfset totalcash = 0>
			<cfset totalcrcd = 0>
            <cfset totalcrcd2 = 0>
			<cfset totalcheque = 0>
			<cfset totalvoucher = 0>
			<cfset totaldeposit = 0>
            <cfset totalnet = 0>
            <cfset totalcashcd = 0>
            <cfset totalmisc=0>
            <cfset totalroundadj=0>

				<cfloop query="getagent">
                
                <cfquery name="getictran" datasource="#dts#">
                select sum(qty)as qty from ictran
                where type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
           <cfif form.locfrom neq "" and form.locto neq "">
			and location between'#form.locfrom#' and '#form.locto#'
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
            and wos_date=#getagent.wos_date#
                </cfquery>
                
          <cfquery name="getmaster" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where  type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
            and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype1='MASTER')
		</cfquery>
        
        <cfquery name="getmaster2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crc2 from artran
			where   type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
             and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype2='MASTER')
		</cfquery>
        
        <cfquery name="getvisa" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where   type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
             and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype1='VISA')
		</cfquery>
        
        <cfquery name="getvisa2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crc2 from artran
			where   type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) and wos_date=#getagent.wos_date#
             and (void = "" or void is null)
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
            and (creditcardtype2='VISA')
		</cfquery>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                    
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#DateFormat(getagent.WOS_DATE,"dd/mm/yyyy")#</font></div></td>
                        <cfquery name="getlogintime" datasource="#dts#">
                        select userlogtime from poslog where status='Success' and userlogtime like '#dateformat(getagent.WOS_DATE,"yyyy-mm-dd")#%'
                        <cfif form.locfrom neq "" and form.locto neq "">
						and location between'#form.locfrom#' and '#form.locto#'
						</cfif>
                        order by userlogtime
                        </cfquery>
                        
                        <cfquery name="getlogouttime" datasource="#dts#">
                        select userlogtime from poslog where status='Logout' and userlogtime like '#dateformat(getagent.WOS_DATE,"yyyy-mm-dd")#%'
                        <cfif form.locfrom neq "" and form.locto neq "">
						and location between'#form.locfrom#' and '#form.locto#'
						</cfif>
                        order by userlogtime desc
                        </cfquery>
                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#timeformat(getlogintime.userlogtime,"HH:MM:SS")#</font></div></td>
                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#timeformat(getlogouttime.userlogtime,"HH:MM:SS")#</font></div></td>
								<td><div align="right">#val(getictran.qty)#</div></td>
                                <td><div align="right">#numberformat(val(getagent.roundadj),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getagent.m_charge1),',_.__')#</div></td>
								<td><div align="right">#numberformat(val(getagent.grand),',_.__')#</div></td>
								<td><div align="right">#numberformat(val(getagent.CS_PM_cash),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getagent.CS_PM_dbcd),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getagent.CS_PM_cashcd),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crc2),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crc2),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getagent.CS_PM_cheq),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getagent.CS_PM_vouc),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getagent.deposit),',_.__')#</div></td>
                                
                                <cfquery name="getagentlist" datasource="#dts#">
                                select agenno from artran where 
                                type in ("CS"<cfif isdefined('form.include_CN')>,"CN"</cfif>) 
                                and (void = '' or void is null) 
                                and wos_date=#getagent.wos_date#
            <cfif form.locfrom neq "" and form.locto neq "">
                and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.refno)#" list="yes" separator=",">)
                </cfif>
                                 group by agenno
                                </cfquery>
                                <td><div align="right">
                                <cfset listagent=''>
                                <cfloop query="getagentlist">
								<cfif getagentlist.agenno neq ''> 
								<cfif listagent eq ''>
								<cfset listagent=getagentlist.agenno>
                                <cfelse>
                                <cfset listagent=listagent&","&getagentlist.agenno>
                                </cfif>
                                #listagent#</cfif></cfloop></div></td>
                                
								<cfset totalqty = totalqty + val(getictran.qty)>
								<cfset totaldiscount = totaldiscount + numberformat(val(getagent.discount),'.__')>
								<cfset totaltax = totaltax + numberformat(val(getagent.tax),'.__')>
								<cfset totalgrand = totalgrand + numberformat(val(getagent.grand),'.__')>
								<cfset totalcash = totalcash + numberformat(val(getagent.CS_PM_cash),'.__')>
								<cfset totalcrcd = totalcrcd + numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crc2),'.__')>
								<cfset totalcrcd2 = totalcrcd2 + numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crc2),'.__')>
								<cfset totalcheque = totalcheque +numberformat( val(getagent.CS_PM_cheq),'.__')>
								<cfset totalvoucher = totalvoucher + numberformat(val(getagent.CS_PM_vouc),'.__')>
								<cfset totaldeposit = totaldeposit + numberformat(val(getagent.deposit),'.__')>
                                <cfset totalnet = totalnet + numberformat(val(getagent.CS_PM_dbcd),'.__')>
                                <cfset totalcashcd = totalcashcd + numberformat(val(getagent.CS_PM_cashcd),'.__')>
                                <cfset totalmisc = totalmisc + numberformat(val(getagent.m_charge1),'.__')>
                                <cfset totalroundadj = totalroundadj + numberformat(val(getagent.roundadj),'.__')>
							
					</tr>
				</cfloop>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
            <td></td>
            <td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalroundadj,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalmisc,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalgrand,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcash,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalnet,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcashcd,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcrcd,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcrcd2,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcheque,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalvoucher,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totaldeposit,",.__")#</strong></font></div></td>
                
			</tr>
		  </table>
		</cfoutput>

		<cfif getagent.recordcount eq 0>
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