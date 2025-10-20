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

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="HTML">
		<html>
		<head>
		<title>Top 50 Sales By Agent Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<body>
		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>AGENT SALES REPORT BY #trantype#</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST_NO: #form.customerfrom# - #form.customerto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">TEAM: #form.teamfrom# - #form.teamto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			  <td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<tr>
				<td><font size="2" face="Times New Roman, Times, serif">AGENT</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">NAME</font></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">INV</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DN</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CS</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CN</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">NET</font></div></td>
                 <td><div align="right"><font size="2" face="Times New Roman, Times, serif">COMMSION</font></div></td>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<!---Agent from Customer Profile--->
			<cfif isdefined('form.agentbycust')>
            <cfquery name="getagentdata" datasource="#dts#">
				select a.agent,a.custno,f.desp,f.commsion1,sum(b.suminvamt) as  suminvamt,sum(c.sumcsamt) as sumcsamt,sum(d.sumdnamt) as sumdnamt,sum(e.sumcnamt) as sumcnamt,(ifnull(sum(b.suminvamt),0)+ifnull(sum(c.sumcsamt),0)+ifnull(sum(d.sumdnamt),0)) as total,
				(ifnull(sum(b.suminvamt),0)+ifnull(sum(c.sumcsamt),0)+ifnull(sum(d.sumdnamt),0)-ifnull(sum(e.sumcnamt),0)) as net   
                from #target_arcust# as a
				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as suminvamt from artran where type = 'INV' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as b on a.custno=b.custno

				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as sumcsamt from artran where type = 'CS' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as c on a.custno=c.custno

				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as sumdnamt from artran where type = 'DN' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as d on a.custno=d.custno

				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as sumcnamt from artran where type = 'CN' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as e on a.custno=e.custno
				left join
                (select desp,agent,commsion1 from #target_icagent# )as f on a.agent=f.agent
				<cfif form.agentfrom neq "" and form.agentto neq "">
				where a.agent >='#form.agentfrom#' and a.agent <= '#form.agentto#'
				</cfif>
                <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agent in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
				group by a.agent order by net desc
                limit 50
			</cfquery>			
            <cfelse>
      		<!---Agent from Bill--->
			<cfquery name="getagentdata" datasource="#dts#">
				select a.agent,a.desp,b.suminvamt,c.sumcsamt,d.sumdnamt,e.sumcnamt,(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)) as total,
				(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) as net,commsion1 from #target_icagent# as a
				left join
				(select agenno,sum(if(taxincl="T",grand-tax,net))as suminvamt from artran where type = 'INV' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as b on a.agent=b.agenno

				left join
				(select agenno,sum(if(taxincl="T",grand-tax,net))as sumcsamt from artran where type = 'CS' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as c on a.agent=c.agenno

				left join
				(select agenno,sum(if(taxincl="T",grand-tax,net))as sumdnamt from artran where type = 'DN' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as d on a.agent=d.agenno

				left join
				(select agenno,sum(if(taxincl="T",grand-tax,net))as sumcnamt from artran where type = 'CN' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno) as e on a.agent=e.agenno
				where 0=0
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and a.agent >='#form.agentfrom#' and a.agent <= '#form.agentto#'
				</cfif>
                <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agent in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
				group by a.agent order by net desc
                limit 50
			</cfquery>
			</cfif>
			<cfset totalinv = 0>
			<cfset totalcs = 0>
			<cfset totaldn = 0>
			<cfset totalcn = 0>
			<cfset totalamt = 0>
			<cfset netamt = 0>
            <cfset commsion = 0>
            <cfset acommsion = 0>
            <cfset netcommision = 0>

			<cfloop query="getagentdata">
				<cfset totalinv = totalinv + val(getagentdata.suminvamt)>
				<cfset totalcs = totalcs + val(getagentdata.sumcsamt)>
				<cfset totaldn = totaldn + val(getagentdata.sumdnamt)>
				<cfset totalcn = totalcn + val(getagentdata.sumcnamt)>
				<cfset totalamt = totalamt + val(getagentdata.total)>
				<cfset netamt = netamt + val(getagentdata.net)>
                <cfset commsion =  val (getagentdata.commsion1) / 100>
                <cfset acommsion = val(getagentdata.net) * commsion>
               <cfset netcommision = netamt * commsion>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<cfif getagentdata.agent eq "">
						<td><font size="2" face="Times New Roman, Times, serif">No - Agent</font></td>
						<td><font size="2" face="Times New Roman, Times, serif">No - Agent</font></td>
					<cfelse>
						<td><font size="2" face="Times New Roman, Times, serif">#getagentdata.agent#</font></td>
						<td><font size="2" face="Times New Roman, Times, serif">#getagentdata.desp#</font></td>
					</cfif>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getagentdata.suminvamt),stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getagentdata.sumdnamt),stDecl_UPrice)#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getagentdata.sumcnamt),stDecl_UPrice)#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getagentdata.total),stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getagentdata.sumcnamt),stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getagentdata.net),stDecl_UPrice)#</font></div></td>
                                      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(acommsion),stDecl_UPrice)#</font></div></td>
				</tr>
			</cfloop>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<tr>
				<td align="right">&nbsp;</td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalinv,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totaldn,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcs,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalamt,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcn,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(netamt,",.__")#</strong></font></div></td>
                              <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(netcommision,",.__")#</strong></font></div></td>
			</tr>
		</table>

	  <cfif getagentdata.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
		</cfoutput>
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
	</cfcase>

	<cfcase value="EXCEL">
		<cfxml variable="data">
		<?mso-application progid="Excel.Sheet"?>
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
		  	<Style ss:ID="s24">
		  		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		  	</Style>
		  	<Style ss:ID="s27">
		   		<NumberFormat ss:Format="@"/>
		  	</Style>
		  	<Style ss:ID="s28">
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  	</Style>
		  	<Style ss:ID="s29">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<NumberFormat ss:Format="#,###,###,##0.00"/>
		  	</Style>

			<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>

		  	<Style ss:ID="s30">
		   		<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		  	</Style>
		  	<Style ss:ID="s31">
		  	 	<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  	</Style>
		  	<Style ss:ID="s32">
		   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		  	<Style ss:ID="s34">
		   		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		  	<Style ss:ID="s36">
		   		<Alignment ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		</Styles>
		<Worksheet ss:Name="Top_Sales_Report - By Agent">
  		<Table ss:ExpandedColumnCount="7" x:FullColumns="1" x:FullRows="1">
   		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
   		<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
   		<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="4"/>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    		<Cell ss:MergeAcross="6" ss:StyleID="s31"><Data ss:Type="String">Top Sales Report - By Agent</Data></Cell>
   		</Row>
		<cfoutput>
   		<cfif form.periodfrom neq "" and form.periodto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</Data></Cell>
			</Row>
		</cfif>
		<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "CUSTOMER: #form.customerfrom# - #form.customerto#" output = "wddxText">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.agentfrom neq "" and form.agentto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "AGENT: #form.agentfrom# - #form.agentto#" output = "wddxText">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.areafrom neq "" and form.areato neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "AREA: #form.areafrom# - #form.areato#" output = "wddxText">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
		</cfif>

   		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
   	 		<Cell ss:MergeAcross="5" ss:StyleID="s34"><Data ss:Type="String">#wddxText#</Data></Cell>
    		<Cell ss:StyleID="s36"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
   		</Row>

		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Agent</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Description</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">INV</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">DN</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">CS</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">CN</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">NET</Data></Cell>
   		</Row>
		
        
        <!---Agent from Customer Profile--->
			<cfif isdefined('form.agentbycust')>
            <cfquery name="getagentdata" datasource="#dts#">
				select a.agent,a.custno,f.desp,f.commsion1,sum(b.suminvamt) as  suminvamt,sum(c.sumcsamt) as sumcsamt,sum(d.sumdnamt) as sumdnamt,sum(e.sumcnamt) as sumcnamt,(ifnull(sum(b.suminvamt),0)+ifnull(sum(c.sumcsamt),0)+ifnull(sum(d.sumdnamt),0)) as total,
				(ifnull(sum(b.suminvamt),0)+ifnull(sum(c.sumcsamt),0)+ifnull(sum(d.sumdnamt),0)-ifnull(sum(e.sumcnamt),0)) as net   
                from #target_arcust# as a
				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as suminvamt from artran where type = 'INV' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as b on a.custno=b.custno

				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as sumcsamt from artran where type = 'CS' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as c on a.custno=c.custno

				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as sumdnamt from artran where type = 'DN' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as d on a.custno=d.custno

				left join
				(select custno,sum(if(taxincl="T",grand-tax,net))as sumcnamt from artran where type = 'CN' and (void = '' or void is null)
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif ndatefrom neq "" and ndateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno) as e on a.custno=e.custno
				left join
                (select desp,agent,commsion1 from #target_icagent# )as f on a.agent=f.agent
				<cfif form.agentfrom neq "" and form.agentto neq "">
				where a.agent >='#form.agentfrom#' and a.agent <= '#form.agentto#'
				</cfif>
                <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agent in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
				group by a.agent order by net desc
                limit 50
			</cfquery>			
            <cfelse>
      		<!---Agent from Bill--->
		<cfquery name="getagentdata" datasource="#dts#">
			select a.agent,a.desp,b.suminvamt,c.sumcsamt,d.sumdnamt,e.sumcnamt,(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)) as total,
			(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) as net from #target_icagent# as a
			left join
			(select agenno,sum(if(taxincl="T",grand-tax,net))as suminvamt from artran where type = 'INV' and (void = '' or void is null)
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
			<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			group by agenno) as b on a.agent=b.agenno

			left join
			(select agenno,sum(if(taxincl="T",grand-tax,net))as sumcsamt from artran where type = 'CS' and (void = '' or void is null)
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
			<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			group by agenno) as c on a.agent=c.agenno

			left join
			(select agenno,sum(if(taxincl="T",grand-tax,net))as sumdnamt from artran where type = 'DN' and (void = '' or void is null)
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
			<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			group by agenno) as d on a.agent=d.agenno

			left join
			(select agenno,sum(if(taxincl="T",grand-tax,net))as sumcnamt from artran where type = 'CN' and (void = '' or void is null)
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
			<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			group by agenno) as e on a.agent=e.agenno
			where 0=0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agent >='#form.agentfrom#' and a.agent <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agent in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			group by a.agent order by net desc
            limit 50
		</cfquery>
		</cfif>
		<cfset totalinv = 0>
		<cfset totalcs = 0>
		<cfset totaldn = 0>
		<cfset totalcn = 0>
		<cfset totalamt = 0>
		<cfset netamt = 0>

		<cfloop query="getagentdata">
			<cfset totalinv = totalinv + val(getagentdata.suminvamt)>
			<cfset totalcs = totalcs + val(getagentdata.sumcsamt)>
			<cfset totaldn = totaldn + val(getagentdata.sumdnamt)>
			<cfset totalcn = totalcn + val(getagentdata.sumcnamt)>
			<cfset totalamt = totalamt + val(getagentdata.total)>
			<cfset netamt = netamt + val(getagentdata.net)>

			<Row ss:Height="12">
				<cfif getagentdata.agent eq "">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Agent</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Agent</Data></Cell>
				<cfelse>
					<cfwddx action = "cfml2wddx" input = "#getagentdata.agent#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getagentdata.desp#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getagentdata.suminvamt)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getagentdata.sumdnamt)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getagentdata.sumcsamt)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getagentdata.sumcnamt)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getagentdata.net)#</Data></Cell>
                
			</Row>
			</cfloop>
			<Row ss:Height="12">
				<Cell ss:StyleID="s28"/>
				<Cell ss:Index="3" ss:StyleID="s29"><Data ss:Type="Number">#totalinv#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#totaldn#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#totalcs#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#totalcn#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#netamt#</Data></Cell>
			</Row>
   		</cfoutput>
		<Row ss:Height="12"/>
		</Table>
		</Worksheet>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_Report_By-Type_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=Agent_Sales_Report_By-Type_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_Report_By-Type_#huserid#.xls">
	</cfcase>
</cfswitch>