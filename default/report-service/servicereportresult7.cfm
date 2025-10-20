<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset dd = dateformat(form.datefrom, 'DD')>
		<cfif dd greater than '12'>
		<cfset date1 = dateformat(form.datefrom,"YYYYMMDD")>
		<cfelse>
		<cfset date1 = dateformat(form.datefrom,"YYYYDDMM")>
		</cfif>

						<cfset dd = dateformat(form.dateto, 'DD')>
		<cfif dd greater than '12'>
		<cfset date2 = dateformat(form.dateto,"YYYYMMDD")>
		<cfelse>
		<cfset date2 = dateformat(form.dateto,"YYYYDDMM")>
		</cfif>

<cfparam name="totalinv" default="0">
<cfparam name="totaldn" default="0">
<cfparam name="totalcs" default="0">
<cfparam name="totaltt" default="0">
<cfparam name="totalcn" default="0">
<cfparam name="totalnet" default="0">

</cfif>
<cfparam name="total" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="i" default="1" type="numeric">


<cfswitch expression="HTML">
	<cfcase value="HTML">
		<html>
		<head>
		<title>Service Listing Report</title>
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
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> Agent - Service Report</strong></font></div></td>
			</tr>
            <cfif form.Servicefrom neq "" and form.Serviceto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service Code #form.Servicefrom# - </font></div></td>
				</tr>
			</cfif>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Agent  #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
          
            			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Period  #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date #form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
				
				<tr>
			<tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			  <td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
</table>

    
    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      </table>

          <table width="100%" BORDER=0 class="" align="center" >
      <tr>
        <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Service Code</cfoutput></font></strong></td>
         <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Date</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>INV</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>DN</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>CS</cfoutput></font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">TOTAL</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">CN</font></strong></td>
               <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">NET</font></strong></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
      			<cfquery name="getcustomer" datasource="#dts#">
				select a.itemno as itemno, b.desp as desp,a.custno as custno,c.desp as name,a.agenno as agenno from ictran a, icservi b , icagent c
				where (a.type = 'INV' or a.type = 'DN' or a.type = 'CN' or a.type = 'CS') and b.desp = a.desp and (a.void = '' or a.void is null)
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and b.desp >='#form.servicefrom#' and b.desp <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
				<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by agenno order by agenno
			</cfquery>
            
            	<cfloop query="getcustomer">
				<cfset subinv = 0>
				<cfset subcs = 0>
				<cfset subdn = 0>
				<cfset subcn = 0>
				<cfset subtotal = 0>

				<tr>
					<td width="20%"><div align="left" ><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.currentrow#.Agent NO: #getcustomer.agenno#</u></strong></font></div></td>
					<td width="20%"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.name#</u></strong>
					</div></td>
				</tr>
      
     <cfquery name="getdata" datasource="#dts#">
					select * from ictran where (type = 'INV' or type = 'DN' or type = 'CN' or type = 'CS')
					and agenno = '#getcustomer.agenno#' and desp = '#getcustomer.desp#' and (void = '' or void is null)
					<cfif form.agentfrom neq "" and form.agentto neq "">
				and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and b.desp >='#form.servicefrom#' and b.desp <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and a.wos_date >= '#ndatefrom#' and a.wos_date <= '#ndateto#'
				<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by refno order by wos_date
				</cfquery>

				<cfloop query="getdata">
					<cfset inv = 0>
					<cfset dn = 0>
					<cfset cs = 0>
					<cfset cn = 0>
					<cfset amt = 0>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.refno#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.desp#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getdata.wos_date,"dd-mm-yyyy")#</font></div></td>

						<cfswitch expression="#getdata.type#">
							<cfcase value="INV">
								<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getdata.amt),stDecl_UPrice)#</font></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<cfset inv = inv + val(getdata.amt)>
								<cfset subinv = subinv + val(getdata.amt)>
								<cfset totalinv = totalinv + val(getdata.amt)>
							</cfcase>
							<cfcase value="DN">
								<td><div align="right"></div></td>
								<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getdata.amt),stDecl_UPrice)#</font></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<cfset dn = dn + val(getdata.amt)>
								<cfset subdn = subdn + val(getdata.amt)>
								<cfset totaldn = totaldn + val(getdata.amt)>
							</cfcase>
							<cfcase value="CS">
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getdata.amt),stDecl_UPrice)#</font></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<cfset cs = cs + val(getdata.amt)>
								<cfset subcs = subcs + val(getdata.amt)>
								<cfset totalcs = totalcs + val(getdata.amt)>
							</cfcase>
							<cfcase value="CN">
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getdata.amt),stDecl_UPrice)#</font></div></td>
								<td><div align="right"></div></td>
								
								<cfset cn = cn + val(getdata.amt)>
								<cfset subcn = subcn + val(getdata.amt)>
								<cfset totalcn = totalcn + val(getdata.amt)>
							</cfcase>
						</cfswitch>
					</tr>
				</cfloop>

				<cfset subtotal = subtotal + subinv + subdn + subcs>
				<tr>
					<td colspan="9"><hr></td>
				</tr>
				<tr>
					<td><div align="left"></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">SUB_TOTAL:</strong></font></div></td>
					<td><div align="left"></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subinv,stDecl_UPrice)#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subdn,stDecl_UPrice)#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subcs,stDecl_UPrice)#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,stDecl_UPrice)#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subcn,stDecl_UPrice)#</font></div></td>
					<cfset subtotal = subtotal - subcn>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,stDecl_UPrice)#</font></div></td>
				</tr>
				<tr><td><br></td></tr>
			</cfloop>
			<cfflush>
			<cfset total = total + totalinv + totaldn + totalcs>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<tr>
				<td><div align="left"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="left"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalinv,",.__")#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totaldn,",.__")#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcs,",.__")#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total,",.__")#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalcn,",.__")#</strong></font></div></td>
				<cfset total = total - totalcn>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total,",.__")#</strong></font></div></td>
			</tr>
    </table>
            			</cfoutput>
    <br>
    <div align="right">
      <!---       <cfif #start# neq 1>
        <cfoutput><a href="l_icitem.cfm">Previous</a> ||</cfoutput>
      </cfif>
      <cfif #page# neq #noOfPage#>
        <cfoutput> <a href="l_icitem.cfm">Next</a> ||</cfoutput>
      </cfif> --->
    </div>
		<cfif getcustomer.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
	
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>

        
		</html>
	</cfcase>

	<cfcase value="EXCELDEFAULT">


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
   		<cfif form.datefrom neq "" and form.dateto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">Vehicle Number: #form.datefrom# - #form.dateto#</Data></Cell>
			</Row>
		</cfif>
		<cfif form.datefrom2 neq "" and form.dateto2 neq "">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="6" ss:StyleID="s32"><Data ss:Type="String">Customer Code: #form.datefrom2# - #form.dateto2#</Data></Cell>
			</Row>
		</cfif>

   		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
   	 		<Cell ss:MergeAcross="5" ss:StyleID="s34"><Data ss:Type="String">#wddxText#</Data></Cell>
    		<Cell ss:StyleID="s36"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
   		</Row>

		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <Cell ss:StyleID="s24"><Data ss:Type="String">Vehicles No</Data></Cell>
        <Cell ss:StyleID="s24"><Data ss:Type="String">Customer CODE</Data></Cell>
                               <cfif isdefined("form.cbmodel")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Model</Data></Cell></cfif>
            <cfif isdefined("form.cbcustname")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Customer Name</Data></Cell>
                    </cfif>
                            <cfif isdefined("form.cbcustic")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Customer IC</Data></Cell></cfif>
                    <cfif isdefined("form.cbgender")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Gender</Data></Cell></cfif>
                    <cfif isdefined("form.cbmarstatus")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Martial Status</Data></Cell></cfif>
                    <cfif isdefined("form.cbcustadd")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Customer Address</Data></Cell></cfif>
                   <cfif isdefined("form.cbdob")>
    		<Cell ss:StyleID="s24"><Data ss:Type="String">Date Of Birth</Data></Cell></cfif>
                    <cfif isdefined("form.cbNCD")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">NCD</Data></Cell></cfif>
                    <cfif isdefined("form.cbcom")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">COM</Data></Cell></cfif>
                    <cfif isdefined("form.cbscheme")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Scheme</Data></Cell></cfif>
                    <cfif isdefined("form.cbmake")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Make</Data></Cell></cfif>
                    <cfif isdefined("form.cbchasisno")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Chasis No</Data></Cell></cfif>
                    <cfif isdefined("form.cbyearmade")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Year Of Manufacture</Data></Cell></cfif>
                    <cfif isdefined("form.cboriregdate")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Original Registration date</Data></Cell></cfif>
                    <cfif isdefined("form.cbcapacity")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Capacity</Data></Cell></cfif>
                    <cfif isdefined("form.cbcoveragetype")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Coverage Type</Data></Cell></cfif>
                    <cfif isdefined("form.cbsuminsured")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Sum insured</Data></Cell></cfif>
                    <cfif isdefined("form.cbinsurance")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Insurance</Data></Cell></cfif>
                    <cfif isdefined("form.cbpremium")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Premium</Data></Cell></cfif>
                    <cfif isdefined("form.cbfinancecom")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Finance</Data></Cell></cfif>
                    <cfif isdefined("form.cbcommision")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Commision</Data></Cell></cfif>
                    <cfif isdefined("form.cbcontract")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Contract</Data></Cell></cfif>
                    <cfif isdefined("form.cbpayment")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Payment</Data></Cell></cfif>
                    <cfif isdefined("form.cbcustrefer")>
                    <Cell ss:StyleID="s24"><Data ss:Type="String">Customer Reference</Data></Cell></cfif>
   		</Row>
</cfoutput>
<cfparam name="i" default="1" type="numeric">
<cfquery name="getservice" datasource="#dts#">
  select * from vehicles 
  where 0=0
  <cfif form.datefrom neq "" and form.dateto neq "">
	and carno >= '#form.datefrom#' and carno <= '#form.dateto#'
  </cfif>
    <cfif form.datefrom2 neq "" and form.dateto2 neq "">
	and custcode >= '#form.datefrom2#' and custcode <= '#form.dateto2#'
  </cfif>
  order by #form.trantype#
</cfquery>

      <cfoutput query="getservice" startrow="1">

			<Row ss:Height="12">
				<cfif getservice.carno eq "">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Carno</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Carno</Data></Cell>
				<cfelse>
					<cfwddx action = "cfml2wddx" input = "#getservice.carno#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getservice.custcode#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.carno)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getservice.custcode)#</Data></Cell>
                
			</Row>
            
   		</cfoutput>
		<Row ss:Height="12"/>
		</Table>
		</Worksheet>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_Report_By-Type_#huserid#.xls" output="#tostring(data)#">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\Agent_Sales_Report_By-Type_#huserid#.xls">
	</cfcase>
</cfswitch>