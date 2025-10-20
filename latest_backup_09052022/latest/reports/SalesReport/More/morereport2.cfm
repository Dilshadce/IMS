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
		<title>End User Sales Report</title>
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
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>END USER SALES REPORT</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST_NO: #form.customerfrom# - #form.customerto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.enduserfrom neq "" and form.enduserto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">END USER: #form.enduserfrom# - #form.enduserto#</font></div></td>
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
				<td><font size="2" face="Times New Roman, Times, serif">End User</font></td>
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

			<cfquery name="getagentdata" datasource="#dts#">
				select a.driverno,a.name,b.suminvamt,c.sumcsamt,d.sumdnamt,e.sumcnamt,(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)) as total,
				(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) as net,commission1 from driver as a
				left join
				(select van,sum(net)as suminvamt from artran where type = 'INV' and (void = '' or void is null)
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
				group by van) as b on a.driverno=b.van

				left join
				(select van,sum(net)as sumcsamt from artran where type = 'CS' and (void = '' or void is null)
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
				group by van) as c on a.driverno=c.van

				left join
				(select van,sum(net)as sumdnamt from artran where type = 'DN' and (void = '' or void is null)
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
				group by van) as d on a.driverno=d.van

				left join
				(select van,sum(net)as sumcnamt from artran where type = 'CN' and (void = '' or void is null)
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
				group by van) as e on a.driverno=e.van
				where 0=0
				<cfif form.enduserfrom neq "" and form.enduserto neq "">
				and a.driverno >='#form.enduserfrom#' and a.driverno <='#form.enduserto#'
				</cfif>
				group by a.driverno order by net desc
				
			</cfquery>

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
                <cfset commsion =  val (getagentdata.commission1) / 100>
                <cfset acommsion = val(getagentdata.net) * commsion>
               <cfset netcommision = netamt * commsion>


				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<cfif getagentdata.driverno eq "">
						<td><font size="2" face="Times New Roman, Times, serif">No - End User</font></td>
						<td><font size="2" face="Times New Roman, Times, serif">No - End User</font></td>
					<cfelse>
						<td><font size="2" face="Times New Roman, Times, serif">#getagentdata.driverno#</font></td>
						<td><font size="2" face="Times New Roman, Times, serif">#getagentdata.name#</font></td>
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
		<Worksheet ss:Name="End User Sales Report">
  		<Table ss:ExpandedColumnCount="7" x:FullColumns="1" x:FullRows="1">
   		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
   		<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
   		<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="4"/>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    		<Cell ss:MergeAcross="6" ss:StyleID="s31"><Data ss:Type="String">End User Sales Report</Data></Cell>
   		</Row>
		<cfoutput>
   		<cfif form.periodfrom neq "" and form.periodto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">DATE: #form.datefrom# - #form.dateto#</Data></Cell>
			</Row>
		</cfif>
		<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "CUSTOMER: #form.customerfrom# - #form.customerto#" output = "wddxText">
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
    		<Cell ss:StyleID="s24"><Data ss:Type="String">End User</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Name</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">INV</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">DN</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">CS</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">CN</Data></Cell>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">NET</Data></Cell>
   		</Row>

		<cfquery name="getagentdata" datasource="#dts#">
			select a.driverno,a.name,b.suminvamt,c.sumcsamt,d.sumdnamt,e.sumcnamt,(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)) as total,
			(ifnull(b.suminvamt,0)+ifnull(c.sumcsamt,0)+ifnull(d.sumdnamt,0)-ifnull(e.sumcnamt,0)) as net from driver as a
			left join
			(select van,sum(net)as suminvamt from artran where type = 'INV' and (void = '' or void is null)
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
			group by van) as b on a.driverno=b.van

			left join
			(select van,sum(net)as sumcsamt from artran where type = 'CS' and (void = '' or void is null)
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
			group by van) as c on a.driverno=c.van

			left join
			(select van,sum(net)as sumdnamt from artran where type = 'DN' and (void = '' or void is null)
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
			group by van) as d on a.driverno=d.van

			left join
			(select van,sum(net)as sumcnamt from artran where type = 'CN' and (void = '' or void is null)
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
			group by van) as e on a.driverno=e.van
			where 0=0
			<cfif form.enduserfrom neq "" and form.enduserto neq "">
				and a.driverno >='#form.enduserfrom#' and a.driverno <='#form.enduserto#'
				</cfif>
			group by a.driverno order by net desc
			
		</cfquery>

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
				<cfif getagentdata.driverno eq "">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - End User</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - End User</Data></Cell>
				<cfelse>
					<cfwddx action = "cfml2wddx" input = "#getagentdata.driverno#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getagentdata.name#" output = "wddxText">
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
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\End_User_Sales_Report_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=End_User_Sales_Report_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\End_User_Sales_Report_#huserid#.xls">
	</cfcase>
</cfswitch>