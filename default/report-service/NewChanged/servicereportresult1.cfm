<cfswitch expression="#form.result#">
	<cfcase value="HTML">


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



		<cfquery name="getservice" datasource="#dts#">
			select p.servi,p.desp,ifnull(b.suminvamt,0) as suminvamt,ifnull(c.sumdnamt,0) as sumdnamt,
			ifnull(d.sumcsamt,0) as sumcsamt,ifnull(e.sumcnamt,0) as sumcnamt,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)) as sumtotal,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)-ifnull(e.sumcnamt,0)) as sumnet
			from icservi p
			
			left join(
				select sum(amt) as suminvamt,desp,itemno
				from ictran
				where type='INV'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as b on b.itemno=p.servi
			
			left join(
				select sum(amt) as sumdnamt,desp,itemno
				from ictran
				where type='DN'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as c on c.itemno=p.servi
			
            
			left join(
				select sum(amt) as sumcsamt,desp,itemno
				from ictran
				where type='CS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as d on d.itemno=p.servi
			
                        left join(
				select sum(amt) as sumcnamt,desp,itemno
				from ictran
				where type='CN'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as e on e.itemno=p.servi
            
			where 
			(ifnull(b.suminvamt,0) <> 0 or ifnull(c.sumdnamt,0) <> 0 or ifnull(d.sumcsamt,0) <> 0 or ifnull(e.sumcnamt,0) <> 0)
	<cfif form.servicefrom neq "" and form.serviceto neq "">
				and p.servi between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
			</cfif>
			order by p.servi
		</cfquery>


		<html>
		<head>
		<title>Service Income Report</title>
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

		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<cfoutput>
            <tr>
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> Service Income Report </strong></font></div></td>
			</tr>
            <cfif form.Servicefrom neq "" and form.Serviceto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service Code #form.Servicefrom# - #form.Serviceto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.projectfrom neq "" and form.projectto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">project  #form.projectfrom# - #form.projectto#</font></div></td>
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
            			</cfoutput>
</table>

  <cfif #getservice.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getservice.recordcount#/20)>
      <cfif #getservice.recordcount# mod 20 LT 20 and #getservice.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif>
    
    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      </table>

          <table width="100%" BORDER=0 class="" align="center" >
      <tr>
        <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Service Code</cfoutput></font></strong></td>
         <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>INV</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>DN</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>CS</cfoutput></font></strong></td>
<td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>TOTAL</cfoutput></font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">CN</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">NET</font></strong></td>
       
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <cfoutput query="getservice" startrow="1">
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <td align="center" width="2%"><div align="left">#i#</div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#servi# - #desp#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getservice.suminvamt),stDecl_UPrice)#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getservice.sumdnamt),stDecl_UPrice)#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getservice.sumcsamt),stDecl_UPrice)#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getservice.sumtotal),stDecl_UPrice)#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getservice.sumcnamt),stDecl_UPrice)#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getservice.sumnet),stDecl_UPrice)#</font></div></td>
		</tr>
		<cfset totalinv=totalinv+val(getservice.suminvamt)>
		<cfset totaldn=totaldn+val(getservice.sumdnamt)>
		<cfset totalcs=totalcs+val(getservice.sumcsamt)>
		<cfset totaltt=totaltt+val(getservice.sumtotal)>
		<cfset totalcn=totalcn+val(getservice.sumcnamt)>
		<cfset totalnet=totalnet+val(getservice.sumnet)>
        
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
        
      </cfoutput>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalinv,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totaldn,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalcs,",.__")#</cfoutput></strong></font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totaltt,",.__")#</cfoutput></strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalcn,",.__")#</cfoutput></strong></font></div></td>

		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalnet,",.__")#</cfoutput></strong></font></div></td>
	</tr>
      </tr>
    </table>

    <br>
    <div align="right">
      <!---       <cfif #start# neq 1>
        <cfoutput><a href="l_icitem.cfm">Previous</a> ||</cfoutput>
      </cfif>
      <cfif #page# neq #noOfPage#>
        <cfoutput> <a href="l_icitem.cfm">Next</a> ||</cfoutput>
      </cfif> --->
    </div>
    <cfelse>
    <h3><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.</font></h3>
  </cfif>

	
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>

        
		</html>
	</cfcase>

	<cfcase value="EXCELDEFAULT">
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



		<cfquery name="getservice" datasource="#dts#">
			select p.servi,p.desp,ifnull(b.suminvamt,0) as suminvamt,ifnull(c.sumdnamt,0) as sumdnamt,
			ifnull(d.sumcsamt,0) as sumcsamt,ifnull(e.sumcnamt,0) as sumcnamt,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)) as sumtotal,
			(ifnull(b.suminvamt,0)+ifnull(c.sumdnamt,0)+ifnull(d.sumcsamt,0)-ifnull(e.sumcnamt,0)) as sumnet
			from icservi p
			
			left join(
				select sum(amt) as suminvamt,desp,itemno
				from ictran
				where type='INV'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as b on b.itemno=p.servi
			
			left join(
				select sum(amt) as sumdnamt,desp,itemno
				from ictran
				where type='DN'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as c on c.itemno=p.servi
			
            
			left join(
				select sum(amt) as sumcsamt,desp,itemno
				from ictran
				where type='CS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as d on d.itemno=p.servi
			
                        left join(
				select sum(amt) as sumcnamt,desp,itemno
				from ictran
				where type='CN'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
				</cfif>
				<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#date1#' and '#date2#' 
				</cfif>
				group by itemno
			)as e on e.itemno=p.servi
            
			where 
			(ifnull(b.suminvamt,0) <> 0 or ifnull(c.sumdnamt,0) <> 0 or ifnull(d.sumcsamt,0) <> 0 or ifnull(e.sumcnamt,0) <> 0)
	<cfif form.servicefrom neq "" and form.serviceto neq "">
				and p.servi between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.servicefrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serviceto#">
			</cfif>
			order by p.servi
		</cfquery>
        
        		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

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
		   			
		  		</Style>
                <Style ss:ID="s29">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
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
                <Style ss:ID="s42">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                <Style ss:ID="s43">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Underline="Single"/>
		  		</Style>
                <Style ss:ID="s44">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		  		</Style>
                
                <Style ss:ID="s45">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                 <Style ss:ID="s46">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                 <Style ss:ID="s47">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
					
		  		</Style>
                  <Style ss:ID="s80">
				  <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" />
					
		  		</Style>
                 <Style ss:ID="s90">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                 <Style ss:ID="s91">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
                
                <Style ss:ID="s50">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">

				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="60.75"/>
					<Column ss:Width="80.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
                    <cfset d="8">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                        <cfset d=d+1>

        <cfoutput>


            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Service Income Report </Data></Cell>
			</Row>
                    
            <cfif form.Servicefrom neq "" and form.Serviceto neq "">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.Servicefrom# - #form.Serviceto#" output = "wddxText">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Service Code #wddxText#</Data></Cell>
					</Row>
			</cfif>
            
            <cfif form.projectfrom neq "" and form.projectto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.projectfrom# - #form.projectto#" output = "wddxText1">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">project  #wddxText1#</Data></Cell>
					</Row>
			</cfif>
          
            <cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.projectfrom# - #form.projectto#" output = "wddxText2">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Period  #wddxText2#</Data></Cell>
					</Row>
			</cfif>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText3">
        				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Date #wddxText3#</Data></Cell>
					</Row>
			</cfif>
            
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText4">
     				<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText5">
        			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				   <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
			</Row>
            
            
                        
            
  <cfif #getservice.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getservice.recordcount#/20)>
      <cfif #getservice.recordcount# mod 20 LT 20 and #getservice.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif></cfif>
    
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
        	<Cell ss:StyleID="s50"><Data ss:Type="String">No</Data></Cell>
        	<Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>Service Code</cfoutput></Data></Cell>
        	<Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>INV</cfoutput></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>DN</cfoutput></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>CS</cfoutput></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>TOTAL</cfoutput></Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String">CN</Data></Cell>
            <Cell ss:StyleID="s50"><Data ss:Type="String">NET</Data></Cell>
       
      </Row>
      </cfoutput>
      
      <cfoutput query="getservice" startrow="1">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
     				<cfwddx action = "cfml2wddx" input = "#i#" output = "wddxText6">
     				<cfwddx action = "cfml2wddx" input = "#servi# - #desp#" output = "wddxText7">
     				<cfwddx action = "cfml2wddx" input = "#numberformat(val(getservice.suminvamt),stDecl_UPrice)#" output = "wddxText8">
     				<cfwddx action = "cfml2wddx" input = "#numberformat(val(getservice.sumdnamt),stDecl_UPrice)#" output = "wddxText9">
     				<cfwddx action = "cfml2wddx" input = "#numberformat(val(getservice.sumcsamt),stDecl_UPrice)#" output = "wddxText10">
     				<cfwddx action = "cfml2wddx" input = "#numberformat(val(getservice.sumtotal),stDecl_UPrice)#" output = "wddxText11">
     				<cfwddx action = "cfml2wddx" input = "#numberformat(val(getservice.sumcnamt),stDecl_UPrice)#" output = "wddxText12">
     				<cfwddx action = "cfml2wddx" input = "#numberformat(val(getservice.sumnet),stDecl_UPrice)#" output = "wddxText13">
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
			<Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText8#</Data></Cell>
			<Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText9#</Data></Cell>
			<Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText10#</Data></Cell>
			<Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText11#</Data></Cell>
            <Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText12#</Data></Cell>
			<Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText13#</Data></Cell>
		</Row>
		<cfset totalinv=totalinv+val(getservice.suminvamt)>
		<cfset totaldn=totaldn+val(getservice.sumdnamt)>
		<cfset totalcs=totalcs+val(getservice.sumcsamt)>
		<cfset totaltt=totaltt+val(getservice.sumtotal)>
		<cfset totalcn=totalcn+val(getservice.sumcnamt)>
		<cfset totalnet=totalnet+val(getservice.sumnet)>
        
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
        
      </cfoutput>
  <cfoutput>    
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s90"><Data ss:Type="String">TOTAL:</Data></Cell>
		    <Cell ss:StyleID="s90"><Data ss:Type="String"><cfoutput>#numberformat(totalinv,",.__")#</cfoutput></Data></Cell>
		    <Cell ss:StyleID="s90"><Data ss:Type="String"><cfoutput>#numberformat(totaldn,",.__")#</cfoutput></Data></Cell>
		    <Cell ss:StyleID="s90"><Data ss:Type="String"><cfoutput>#numberformat(totalcs,",.__")#</cfoutput></Data></Cell>
		    <Cell ss:StyleID="s90"><Data ss:Type="String"><cfoutput>#numberformat(totaltt,",.__")#</cfoutput></Data></Cell>
            <Cell ss:StyleID="s90"><Data ss:Type="String"><cfoutput>#numberformat(totalcn,",.__")#</cfoutput></Data></Cell>
			<Cell ss:StyleID="s90"><Data ss:Type="String"><cfoutput>#numberformat(totalnet,",.__")#</cfoutput></Data></Cell>
		</Row>
<!---<Cell ss:MergeAcross="6" ss:StyleID="s31"><Data ss:Type="String">Top Sales Report - By Agent</Data></Cell>
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
                
			</Row>--->
            
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
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
</cfswitch>
    		