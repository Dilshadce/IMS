<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<html>
<head>
<title>Outstanding Report</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="totalorderqty" default="0">
<cfparam name="totalrcqty" default="0">
<cfparam name="totaloutstand" default="0">
<cfparam name="totalamt" default="0">
<cfparam name="totalrightamt" default="0">
<cfparam name="totaldisamt" default="0">
<cfparam name="totaltax" default="0">
<cfparam name="totalgrandamt" default="0">


<cfparam name="ttgross" default="0">
<cfparam name="row" default="0">
<cfparam name="ttorderqty" default="0">
<cfparam name="ttrcqty" default="0">
<cfparam name="ttoutstand" default="0">
<cfparam name="totwriteoff" default="0">
<cfparam name="ttamt" default="0">
<cfparam name="ttdisamt" default="0">
<cfparam name="ttgrandamt" default="0">
<cfparam name="tttax" default="0">


<cfif isdefined('url.submit')>
<cfset form.customerFrom=''>
<cfset form.customerTo=''>

<cfset form.agentfrom=''>
<cfset form.agentto=''>

<cfset form.refnofrom=''>
<cfset form.refnoto=''>

<cfset form.periodfrom='01'>
<cfset form.periodto='18'>

<cfset form.datefrom=''>
<cfset form.dateto=''>

<cfset form.cbpriceamt='1'>

<cfset form.deldatefrom=''>
<cfset form.deldateto=''>

</cfif>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=dateformat(form.datefrom, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>
	
	<cfset dd=dateformat(form.dateto, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(form.dateto,"YYYYDDMM")>
	</cfif>	
</cfif>

<cfif isdefined("form.deldatefrom") and isdefined("form.deldateto")>
	<cfset dd=dateformat(form.deldatefrom, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndeldatefrom=dateformat(form.deldatefrom,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndeldatefrom=dateformat(form.deldatefrom,"YYYY-DD-MM")>
	</cfif>
	
	<cfset dd=dateformat(form.deldateto, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndeldateto=dateformat(form.deldateto,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndeldateto=dateformat(form.deldateto,"YYYY-DD-MM")>
	</cfif>	
</cfif>

<body>
<cfif type eq "QUO" or type eq "DO">
	<cfquery name="getheader" datasource="#dts#">
		select refno,refno2,type,custno,name,invgross,wos_date,pono,rem5,rem7,agenno,source,job 
        from artran 
        where type = '#type#' 
        and (void = '' or void is null)
        and (toinv = '' or toinv is null)
		<cfif trim(customerFrom) neq "" and trim(customerTo) neq "">
        	and custno >= '#customerFrom#' and custno <= '#customerTo#'
        </cfif>
        <cfif trim(supplierFrom) neq "" and trim(supplierTo) neq "">
        	and a.custno >= '#supplierFrom#' and a.custno <= '#supplierTo#'
        </cfif>
		<cfif refnofrom neq "" and refnoto neq "">and refno >= '#refnofrom#' and refno <= '#refnoto#'</cfif>
		<cfif datefrom neq "" and dateto neq ""> and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'</cfif>
		<cfif periodfrom neq "" and periodto neq "">and fperiod between '#periodfrom#' and '#periodto#'</cfif>
        <cfif projectfrom neq "" and projectto neq "">and source between '#projectfrom#' and '#projectto#'</cfif>
        <cfif form.agentfrom neq "" and form.agentto neq "">
		and agenno between '#form.agentfrom#' and '#form.agentto#'
		</cfif>
        <cfif jobfrom neq "" and jobto neq "">and job between '#jobfrom#' and '#jobto#'</cfif>
		order by refno
	</cfquery>
    
			<cfelseif isdefined('form.checkbox')>
            <cfif type eq "3">
            	<cfset billtype = "PO">
            <cfelseif type eq "4">
            	<cfset billtype = "PO">
            <cfelseif type eq "5">
            	<cfset billtype = "SO">
            <cfelseif type eq "6">
            	<cfset billtype = "SO">
            <cfelseif type eq "7">
            	<cfset billtype = "SO">
            <cfelseif type eq "8">
            	<cfset billtype = "SO">
			</cfif>
            <cfquery name="getheader" datasource="#dts#">
 				select a.refno,a.refno2,a.type,a.custno,a.name,a.agenno,a.invgross,a.wos_date,b.itemno,b.desp,a.pono,a.rem5,a.rem7,a.discount 
 				from artran a,ictran b 
                where a.refno = b.refno 
                and a.type = b.type 
                and a.type = '#billtype#' 
                and a.order_cl = '' 
                and (b.shipped+b.writeoff) < qty 
				and (a.void = '' or a.void is null)
                and (toinv = '' or toinv is null
            	<cfif trim(customerFrom) neq "" and trim(customerTo) neq "">
                	and a.custno >= '#customerFrom#' and a.custno <= '#customerTo#'
                </cfif>
                <cfif trim(supplierFrom) neq "" and trim(supplierTo) neq "">
       				and a.custno >= '#supplierFrom#' and a.custno <= '#supplierTo#'
                </cfif>
		<cfif refnofrom neq "" and refnoto neq "">and a.refno >= '#refnofrom#' and a.refno <= '#refnoto#'</cfif>
		<cfif datefrom neq "" and dateto neq ""> and a.wos_date >= '#datefrom#' and a.wos_date <= '#dateto#'</cfif>
		<cfif url.type neq "6">
			<cfif trim(itemfrom) neq "" and trim(itemto) neq ""> and b.itemno >= '#itemfrom#' and b.itemno <= '#itemto#' </cfif> 
		</cfif>
		<cfif deldatefrom neq "" and deldateto neq "">
        <cfif lcase(hcomid) eq "dgalleria_i">
        	and a.rem7 between '#ndeldatefrom#' and '#ndeldateto#'
        <cfelse>
			and <!---cast(concat_ws('-',substring(b.brem1,1,2),substring(b.brem1,4,2),substring(b.brem1,7,2)) as date)--->b.deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
		</cfif>
        </cfif>
		<cfif periodfrom neq "" and periodto neq "">and a.fperiod between '#periodfrom#' and '#periodto#'</cfif>
        <cfif projectfrom neq "" and projectto neq "">and a.source between '#projectfrom#' and '#projectto#'</cfif>
        <cfif jobfrom neq "" and jobto neq "">and a.job between '#jobfrom#' and '#jobto#'</cfif>
        	<cfif isdefined('form.agentfrom') and isdefined('form.agentto')>
			<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
	</cfif>
    </cfif>
 group by b.itemno <cfif isdefined('form.sortbydelivery')>order by a.rem7<cfelse>order by b.itemno</cfif>
    </cfquery>
            <cfelse>
            
	<cfquery name="getheader" datasource="#dts#">
		<cfswitch expression="#url.type#">
			<cfcase value="3">
            select a.refno,a.refno2,a.type,a.custno,a.name,a.invgross,a.discount,a.agenno,a.wos_date,a.pono,a.currcode ,a.rem5,a.rem7 
            from artran a,ictran b 
            where a.refno = b.refno 
            and a.type = b.type 
            and a.type = 'PO' 
            <cfif isdefined("form.checkbox1")><cfelse>
            and a.order_cl = ''
            and (b.shipped+b.writeoff) < qty 
            and (b.toinv='' or b.toinv is null)
            </cfif>
            and (a.void='' or a.void is null)

            
			</cfcase>
			<cfcase value="4">
			select a.refno,a.refno2,a.type,a.custno,a.name,a.invgross,a.discount,a.wos_date,a.agenno,a.pono,a.rem5,a.rem7,
			b.brem1,b.brem2,a.pono,a.currcode 
            from artran a, ictran b 
            where a.refno = b.refno 
            and a.type = b.type 
            and a.type = 'PO' <cfif isdefined("form.checkbox1")><cfelse>and a.order_cl = '' and (b.shipped+b.writeoff) < qty
            and (b.toinv='' or b.toinv is null)
            </cfif> 
            and (a.void='' or a.void is null)
            
			</cfcase>
			<cfcase value="5">
			select a.refno,a.refno2,a.type,a.custno,a.name,a.invgross,a.discount,a.wos_date,a.agenno,a.exported,a.pono,a.currcode,a.rem5,a.rem7 from artran a,ictran b where 
			a.refno = b.refno and a.type = b.type and a.type = 'SO' and a.order_cl ='' and (b.shipped+b.writeoff) < qty and (a.void='' or a.void is null)
            and (b.toinv='' or b.toinv is null)
			</cfcase>
			<cfcase value="6">
           
			select a.refno,a.refno2,a.type,a.custno,a.name,a.invgross,a.discount,a.agenno,a.wos_date,b.itemno,a.currcode,a.rem5,a.rem7,
			b.brem1,b.brem2,b.exported,b.deliveryDate,a.pono from artran a, ictran b where a.refno = b.refno and a.type = b.type and
			a.type = 'SO' <cfif isdefined("form.checkbox1")><cfelse>and a.order_cl = '' and (b.shipped+b.writeoff) < qty </cfif> and (a.void='' or a.void is null)

			</cfcase>
			<cfcase value="7">
			select a.refno,a.refno2,a.type,a.custno,a.name,a.invgross,a.discount,a.agenno,a.wos_date,a.pono,a.currcode ,a.rem5,a.rem7 from artran a,ictran b where 
			a.refno=b.refno and a.type = b.type and a.type = 'SO' and <!--- a.exported = '' --->a.order_cl = '' and (a.void='' or a.void is null)
			</cfcase>
            <cfcase value="8">
			select a.refno,a.refno2,a.type,a.custno,a.name,a.invgross,a.discount,a.agenno,a.wos_date,a.pono,a.currcode ,a.rem5,a.rem7 from artran a,ictranmat b where 
			a.refno=b.refno and a.type = b.type and a.type = 'SO' and  a.exported = '' and a.order_cl = '' and (a.void='' or a.void is null)
			</cfcase>
		</cfswitch>
        
		<cfif trim(customerFrom) neq "" and trim(customerTo) neq "">
        and a.custno >= '#customerFrom#' and a.custno <= '#customerTo#'
        </cfif>
        <cfif trim(supplierFrom) neq "" and trim(supplierTo) neq "">
        and a.custno >= '#supplierFrom#' and a.custno <= '#supplierTo#'
        </cfif>
        
		<cfif refnofrom neq "" and refnoto neq "">and a.refno >= '#refnofrom#' and a.refno <= '#refnoto#'</cfif>
		<cfif datefrom neq "" and dateto neq ""> and a.wos_date >= '#datefrom#' and a.wos_date <= '#dateto#'</cfif>
		<cfif url.type neq "6">
			<cfif trim(itemfrom) neq "" and trim(itemto) neq ""> and b.itemno >= '#itemfrom#' and b.itemno <= '#itemto#'</cfif> 
		</cfif>
		<cfif deldatefrom neq "" and deldateto neq "">
        <cfif lcase(hcomid) eq "dgalleria_i">
        	and a.rem7 between '#ndeldatefrom#' and '#ndeldateto#'
        <cfelse>
			and <!---cast(concat_ws('-',substring(b.brem1,1,2),substring(b.brem1,4,2),substring(b.brem1,7,2)) as date)--->b.deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
		</cfif>
        </cfif>
		<cfif periodfrom neq "" and periodto neq "">and a.fperiod between '#periodfrom#' and '#periodto#'</cfif>
        <cfif projectfrom neq "" and projectto neq "">and a.source between '#projectfrom#' and '#projectto#'</cfif>
        <cfif jobfrom neq "" and jobto neq "">and a.job between '#jobfrom#' and '#jobto#'</cfif>
        	<cfif isdefined('form.agentfrom') and isdefined('form.agentto')>
			<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
	</cfif>
    </cfif>

		group by a.refno <cfif isdefined('form.sortbydelivery')>order by a.rem7<cfelse>order by a.refno</cfif>
	</cfquery>
</cfif>
<cfoutput>
<cfswitch expression="#type#">
	<cfcase value="DO">
		<h1 align="center">Outstanding #gettranname.lDO#</h1>
		<cfset ttype = 'DO'>
	</cfcase>
	<cfcase value="QUO">
		<h1 align="center">Outstanding #gettranname.lQUO#</h1>
		<cfset ttype = 'QUO'>
	</cfcase>
	<cfcase value="3">
		<h1 align="center">Outstanding #gettranname.lPO# Status</h1>
		<cfset ttype = 'PO'>
	</cfcase>
	<cfcase value="4">
		<h1 align="center">Outstanding #gettranname.lPO# Details</h1>
		<cfset ttype = 'PO'>
		<cfset ttype2= 'RC'>
	</cfcase>
	<cfcase value="5">
		<h1 align="center">Outstanding #gettranname.lSO# Status</h1>
		<cfset ttype = 'SO'>
	</cfcase>
	<cfcase value="6">
		<h1 align="center">Outstanding #gettranname.lSO# Details</h1>
		<cfset ttype = 'SO'>
		<cfset ttype2= 'INV'>
	</cfcase>
	<cfcase value="7">
		<h1 align="center">Outstanding #gettranname.lSO# to #gettranname.lPO#</h1>
		<cfset ttype = 'SO'>
		<cfset ttype2= 'PO'>
	</cfcase>
    <cfcase value="8">
		<h1 align="center">Outstanding #gettranname.lSO# to #gettranname.lPO# Material</h1>
		<cfset ttype = 'SO'>
		<cfset ttype2= 'PO'>
	</cfcase>
</cfswitch>
</cfoutput>

<cfif type eq "DO">
	<table width="90%" border="0" class="data1" align="center" cellspacing="0" cellpadding="3">
    	<tr> 
      		<th>Type</th>
      		<th>Date</th>
      		<th>Ref No.</th>
      		<th>Customer</th>
      		<th>Gross</th>
      		<th>Qty</th>
      		<th>Price</th>
      		<th>Amount</th>
    	</tr>
    	
		<cfloop query="getheader">
   		  <cfif invgross neq "">
        		<cfset xgross = invgross>
        	<cfelse>
        		<cfset xgross = 0>
   		  </cfif>
      		
			<cfoutput> 
        	<tr> 
          		<td>#type#</td>
          		<td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          		<td nowrap>
				<a href="/default/transaction/tran_edit2.cfm?tran=#type#&ttype=Edit&refno=#refno#&custno=#custno#&first=0">#refno#</a>
			</td>
          		<td nowrap>#custno# - #name#</td>
         	 	<td><div align="right">#numberformat(xgross,",_.__")#</div></td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
        	</tr>
        	</cfoutput>
			
			<cfset ttgross = ttgross + xgross>
      		
			<cfquery name="getbody" datasource="#dts#">
      			select qty,price,amt,itemno,desp,despa,expdate,taxamt,disamt from ictran where refno = '#refno#' and type = '#ttype#' 
      		</cfquery>
      		
			<cfoutput query="getbody"> 
				<tr> 
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="3">#Itemno# - #desp#</td>
					<td><div align="center">#qty#</div></td>
					<td><div align="right">#price#</div></td>
					<td><div align="right">#numberformat(amt,",_.__")#</div></td>
				</tr>
				<cfset totalamt = totalamt + amt>
				<cfset totalorderqty = totalorderqty + qty>
      		</cfoutput> 
      		
			<tr> 
        		<td colspan="8"><hr></td>
      		</tr>
      		
			<cfset row = row + 1>
    	</cfloop>
    	
		<cfoutput> 
      	<tr bgcolor="##83B8ED"> 
        	<td colspan="3">No of Records : #row#</td>
        	<td><div align="right">Total</div></td>
        	<td><div align="right">#numberformat(ttgross,",_.__")#</div></td>
        	<td><div align="center">#totalorderqty#</div></td>
        	<td><div align="right"></div></td>
        	<td><div align="right">#numberformat(totalamt,",_.__")#</div></td>
      	</tr>
    	</cfoutput> 
  	</table>

<cfelseif url.type eq "4" or url.type eq "6" or url.type eq "7" or url.type eq "8">
	
    <cfif form.result eq 'EXCEL'>
	
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
				<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
				<Font ss:FontName="Verdana" x:Family="Swiss"/>
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
                <Style ss:ID="s40">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		  		</Style>                
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>
			
       
            
			<Worksheet ss:Name="Outstanding">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="70.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:Width="75.75"/>
					<Column ss:Width="100.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
		   			<cfif url.type eq "4">
					<cfwddx action = "cfml2wddx" input = "Outstanding #gettranname.lPO# Details" output = "wddxText">
                    <cfelseif url.type eq "6">
                    <cfwddx action = "cfml2wddx" input = "Outstanding #gettranname.lSO# Details" output = "wddxText">
                    <cfelseif url.type eq "7">
                    <cfwddx action = "cfml2wddx" input = "Outstanding #gettranname.lSO# to #gettranname.lPO#" output = "wddxText">
                    <cfelseif url.type eq "8">
                    <cfwddx action = "cfml2wddx" input = "Outstanding #gettranname.lSO# to #gettranname.lPO# Material" output = "wddxText">
                    </cfif>
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
				
				</cfoutput>
				<cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
                <cfif lcase(HcomID) eq "bestform_i">
					<Cell ss:StyleID="s27"><Data ss:Type="String">S/No</Data></Cell>
                </cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Date</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Type</Data></Cell>
                    <cfif lcase(HcomID) neq "bestform_i">
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Ref No.</Data></Cell>
                    </cfif>
                    <cfif lcase(HcomID) eq "sumiden_i" and url.type eq "6">
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Ref No 2.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PO No.</Data></Cell>
                    </cfif>
                    <cfif lcase(HcomID) eq "sumiden_i" and url.type eq "4">
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Ref No 2.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">SO No.</Data></Cell>
                    </cfif>
                    <cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Ref 2</Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">
					<cfif type eq 'PO' or type eq '4'>
					Supplier 
					<cfelse>
					Customer
					</cfif>
                    </Data></Cell>
                    <cfif lcase(HcomID) eq "bestform_i">
					<Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Drawing No</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">In-house Job No.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PO/SO No.</Data></Cell>
                    </cfif>
                    <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PO/SO No.</Data></Cell>
                    </cfif>
					
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Ordered</Data></Cell>
                    <cfif url.type neq "7" and url.type neq "8">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Write Off</Data></Cell>
                    </cfif>
                    <!---<Cell ss:StyleID="s27"><Data ss:Type="String">Qty Ordered</Data></Cell>--->
                    <Cell ss:StyleID="s27"><Data ss:Type="String">#ttype2# Date</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">#ttype2# No</Data></Cell>
                    <cfif url.type eq '7' or url.type eq '8'>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">#ttype2# Req Date/C.firm Date</Data></Cell>
                    </cfif>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Updated</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Outstanding</Data></Cell>
                    
                    <cfif type eq '6'>
            		<cfif isdefined('form.cbpriceamt')>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Price</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Amount</Data></Cell>
            		<cfelse>
            		</cfif>
            		<cfelse>
            		<Cell ss:StyleID="s27"><Data ss:Type="String">Price</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Amount</Data></Cell>
           			</cfif>
				</Row>
				</cfoutput>
                
    	<cfset sno=1>
		<cfloop query="getheader">
      		<cfoutput> 
            
            	<cfwddx action = "cfml2wddx" input = "#dateformat(wos_date,'dd/mm/yy')#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#type#" output = "wddxText2">
					<cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#refno2#" output = "wddxText4">
                    
                    
                    <cfwddx action = "cfml2wddx" input = "#custno# - #name#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#getheader.pono#" output = "wddxText7">
					<Row ss:AutoFitHeight="0">
                    
                    	<cfif url.type eq '4'>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
						<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        </cfif>
                        <cfif lcase(HcomID) eq "sumiden_i" and url.type eq "4">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        </cfif>
                        <cfelse>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                        <cfif lcase(HcomID) neq "bestform_i">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        </cfif>
                        <cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        </cfif>
                        <cfif lcase(HcomID) eq "sumiden_i" and url.type eq "6">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        </cfif>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        
                        </cfif>
					</Row>
      		</cfoutput> 
			<cfquery name="getbody" datasource="#dts#">
				select deliverydate,refno,trancode,qty,price,amt,itemno,desp,despa,comment,brem1,brem2,brem4,exported,writeoff,batchcode,expdate,source,dodate from 
				<cfif url.type eq '8'>ictranmat<cfelse>ictran</cfif> where refno = '#refno#' and type = '#ttype#' 
                <cfif url.type eq '6'>
                <cfif lcase(HcomID) eq "bestform_i"><cfif isdefined("form.checkbox1")><cfelse>and shipped < qty</cfif></cfif>
                </cfif>
				<cfif url.type eq '6' or url.type eq '7' or url.type eq '8'>
					<cfif deldatefrom neq "" and deldateto neq "">
                    <cfif lcase(hcomid) eq "dgalleria_i">
       				<cfelse>
					and <!---cast(concat_ws('-',substring(brem1,1,2),substring(brem1,4,2),substring(brem1,7,2)) as date)--->deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
					</cfif>
                    </cfif>
				</cfif>
				<cfif url.type eq '4' or url.type eq '7' or url.type eq '8'>
					<cfif trim(itemfrom) neq "" and trim(itemto) neq "">
					and itemno >= '#itemfrom#' and itemno <= '#itemto#' 
					</cfif>
				</cfif>
				order by <cfif lcase(HcomID) eq "bestform_i">source<cfelse>itemcount </cfif>
      		</cfquery>
      		
			<cfloop query="getbody">
				<cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
        		<cfset totalrcqty = 0>
				<cfset rcqty = 0>
        		
				<cfif getbody.qty neq "">
          			<cfset orderqty = getbody.qty>
          		<cfelse>
          			<cfset orderqty = 0>
        		</cfif>
        		
				<cfquery name="getrcqty" datasource="#dts#">
        			select qty ,refno,type,itemno,trancode from iclink where frrefno = '#getbody.refno#' 
        			and itemno = '#getbody.itemno#' and frtrancode = '#getbody.trancode#' 
        			<cfif url.type eq '4'>
          				and type = 'RC' 
          			<cfelseif url.type eq '6'>
          				and (type = 'DO' or type = 'INV') 
          			<cfelseif url.type eq '7' or url.type eq '8'>
          				and type = 'PO' 
        			</cfif>
        			and frtype = '#ttype#' order by refno 
        		</cfquery>
        		
				
				<!--- <cfdump var="#getrcqty#">
				<cfdump var="#geticdata#"> --->
        		<!--- type = '#ttype2#' --->
				
				<cfset thiswriteoff = writeoff>
				<cfset thisprice = price>
				<cfset thisamt = amt>
        		<cfif getrcqty.recordcount gt 0>
          			<cfset cnt = 0>
          			
					<cfoutput query="getrcqty">
						<!---  <cfif getrcqty.qty neq geticdata.qty> ---><!--- Edited --->
            			<cfquery name="geticdata" datasource="#dts#">
        					select type,refno,qty,price,amt,itemno,desp,wos_date,dodate,brem1,brem2,source,batchcode,expdate,comment from <cfif url.type eq '8'>ictranmat<cfelse>ictran</cfif> 
        					where refno = '#getrcqty.refno#' and itemno = '#getrcqty.itemno#' and 
        					trancode = '#getrcqty.trancode#' 
        					<cfif url.type eq '4'>
          						and type = 'RC' 
          					<cfelseif url.type eq '6'>
          						and (type = 'DO' or type = 'INV')
                                 <cfif lcase(HcomID) eq "bestform_i"><cfif isdefined("form.checkbox1")><cfelse>and shipped < qty</cfif></cfif>
          					<cfelseif url.type eq '7' or url.type eq '8'>
          						and type = 'PO' 
        					</cfif>
        				</cfquery>
						<cfif getrcqty.qty neq "">
              				<cfset rcqty = getrcqty.qty>
              			<cfelse>
              				<cfset rcqty = 0>
            			</cfif>
            			
						<cfset totalrcqty = totalrcqty + rcqty>
            			<cfset outstand = orderqty - totalrcqty>
            			<Row ss:AutoFitHeight="0">
                        <cfif lcase(HcomID) eq "bestform_i">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#sno#</Data></Cell>
                <cfset sno=sno+1>
                </cfif>
                		<Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
              				<Cell ss:StyleID="s32"><Data ss:Type="String"><cfif cnt eq 0>#trim(Itemno)# - <cfif lcase(HcomID) neq "bestform_i"><cfwddx action = "cfml2wddx" input = "#trim(getbody.desp)#" output = "wddxText"><Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell><cfelse><cfif itemno eq '..'><cfwddx action = "cfml2wddx" input = "#tostring(getbody.comment)#" output = "wddxText">#wddxText#<cfelse><cfwddx action = "cfml2wddx" input = "#trim(getbody.desp)#" output = "wddxText">#wddxText#</cfif>
                            </cfif>
							</cfif>		
                            </Data>				
                            </Cell>
							
                            <cfif lcase(HcomID) eq "sumiden_i" and (url.type eq "6" or url.type eq "4")>
                            <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                            <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                            </cfif>
                            

							<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></cfif>
              				<Cell ss:StyleID="s32"><Data ss:Type="String">
                            <cfwddx action = "cfml2wddx" input = "#getbody.exported#" output = "wddxText">
                            #wddxText#<cfif lcase(HcomID) neq "bestform_i">
                            <cfwddx action = "cfml2wddx" input = "#getbody.brem4#" output = "wddxText">
                            #wddxText#</cfif></Data></Cell>
              				<Cell ss:StyleID="s32"><Data ss:Type="String">
								<cfif getbody.brem1 neq "" or getbody.brem2 neq "">
                  					<cfif ttype2 eq 'RC'>
                    					Req 
                    				<cfelse>
                    					Del 
                  					</cfif>
                  					
									Date <cfif lcase(HcomID) eq "bestform_i">
                                    <cfwddx action = "cfml2wddx" input = "#dateformat(getbody.dodate,'DD/MM/YYYY')#" output = "wddxText">
                                    #wddxText#
                                    <cfelseif lcase(HcomID) eq "sumiden_i">
                                    <cfwddx action = "cfml2wddx" input = "#getheader.rem5#" output = "wddxText">
                                    #wddxText#
                                    <cfelse>
                                    <cfwddx action = "cfml2wddx" input = "#getbody.brem1#" output = "wddxText">
                                    #wddxText#
                                    </cfif>
                  					
									<cfif lcase(HcomID) eq "bestform_i">Material :<cfelse>Cf Date</cfif> #getbody.brem2#
								</cfif>							
                                </Data></Cell>
                                
                                <cfif lcase(HcomID) eq "bestform_i">
                                <Cell ss:StyleID="s32"><Data ss:Type="String">
				<cfquery name='getexpdate' datasource='#dts#'>
				select rc_expdate from obbatch where batchcode='#geticdata.batchcode#'
				</cfquery>
                <cfwddx action = "cfml2wddx" input = "#geticdata.batchcode#" output = "wddxText">
                <cfwddx action = "cfml2wddx" input = "#dateformat(geticdata.expdate,'dd/mm/yyyy')#" output = "wddxText2">
#wddxText# Expire Date: #wddxText2#
								</Data></Cell>

<cfwddx action = "cfml2wddx" input = "#geticdata.source#" output = "wddxText3">
                                <Cell ss:StyleID="s32"><Data ss:Type="String"><div align="center">#wddxText3#</Data></Cell>
                                <cfwddx action = "cfml2wddx" input = "#getheader.pono#" output = "wddxText4">
                                <Cell ss:StyleID="s32"><Data ss:Type="String"><div align="center">#wddxText4#</Data></Cell>
                                </cfif>
                                <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">					
                                <cfwddx action = "cfml2wddx" input = "#getheader.pono#" output = "wddxText4">
                                	<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                                </cfif>
                                 <cfwddx action = "cfml2wddx" input = "#orderqty#" output = "wddxText5">
              				<Cell ss:StyleID="s32"><Data ss:Type="String"><cfif cnt eq 0>#wddxText5#</cfif></Data></Cell>
                            
							<cfif url.type neq "7" and url.type neq "8">
                            <cfwddx action = "cfml2wddx" input = "#thiswriteoff#" output = "wddxText6">
								<Cell ss:StyleID="s32"><Data ss:Type="String"><cfif cnt eq 0>#wddxText6#</cfif></Data></Cell>
							</cfif>
                            <cfwddx action = "cfml2wddx" input = "#dateformat(geticdata.wos_date,"dd/mm/yy")#" output = "wddxText7">
              				<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                            <cfwddx action = "cfml2wddx" input = "#geticdata.refno#" output = "wddxText8">
              				<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
              				
                            
                            
							<cfif url.type eq '7' or url.type eq '8'>
                            <cfwddx action = "cfml2wddx" input = "#geticdata.brem1#" output = "wddxText9">
                            <cfwddx action = "cfml2wddx" input = "#geticdata.brem2#" output = "wddxText10">
                				<Cell ss:StyleID="s32"><Data ss:Type="String">
								<cfif geticdata.brem1 neq "" or geticdata.brem2 neq "">
                                Req Date #wddxText9#
								<cfif lcase(HcomID) eq "bestform_i">
                                Material :<cfelse>Cf Date</cfif>
                                  #wddxText10#</cfif></Data></Cell>
              				</cfif>
              				<cfwddx action = "cfml2wddx" input = "#rcqty#" output = "wddxText11">
                            <cfwddx action = "cfml2wddx" input = "#outstand#" output = "wddxText12">
							<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText11#</Data></Cell>
              				<Cell ss:StyleID="s32"><Data ss:Type="String"><cfif getrcqty.currentrow eq getrcqty.recordcount><cfif url.type neq "7" and url.type neq "8"><cfset outstand = outstand - thiswriteoff></cfif>#wddxText12#</cfif>
							</Data></Cell>
                            <cfif type eq '6'>
                            <cfif isdefined('form.cbpriceamt')>
                            <cfif getrcqty.currentrow eq getrcqty.recordcount>
                            <cfwddx action = "cfml2wddx" input = "#numberformat(thisprice,",_.__")#" output = "wddxText13">
                            
              				<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText13#</Data></Cell>
              				<Cell ss:StyleID="s32"><Data ss:Type="String">
							<cfif lcase(HcomID) eq "bestform_i">
                            <cfwddx action = "cfml2wddx" input = "#getheader.currcode#" output = "wddxText14">#wddxText14#</cfif>
                             <cfwddx action = "cfml2wddx" input = "#numberformat(outstand*thisprice,",_.__")#" output = "wddxText14">#wddxText14#</Data></Cell>
                            </cfif>
                            <cfelse>
                            </cfif>
                            <cfelse>
                            <cfif getrcqty.currentrow eq getrcqty.recordcount>
                            <cfwddx action = "cfml2wddx" input = "#numberformat(thisprice,",_.__")#" output = "wddxText15">
                            <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText15#</Data></Cell>
              				<Cell ss:StyleID="s32"><Data ss:Type="String">
							<cfif lcase(HcomID) eq "bestform_i">
                            <cfwddx action = "cfml2wddx" input = "#getheader.currcode#" output = "wddxText16">#getheader.currcode#</cfif>
                            <cfwddx action = "cfml2wddx" input = " #numberformat(outstand*thisprice,",_.__")#" output = "wddxText16">#wddxText16#</Data></Cell>
                            </cfif>
                            </cfif>
            			</Row>
						<cfif cnt eq 0>
							<cfset ttorderqty = ttorderqty + orderqty>
						</cfif>
						<cfset ttrcqty = ttrcqty + rcqty>
                        <cfif getrcqty.currentrow eq getrcqty.recordcount>
                        <cfset ttamt = ttamt + outstand*thisprice>
                        </cfif>
            			<cfset cnt = cnt + 1>
						<!--- </cfif> ---><!--- Edited --->
          			</cfoutput> 
          		<cfelse>
					<cfif url.type neq "7" and url.type neq "8">
						<cfset rcqty = 0>
						<cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
					<cfelse>
						<cfset rcqty = 0>
						<cfset outstand = orderqty - rcqty>
					</cfif>	
						  	
          			<cfoutput> 
            		<Row ss:AutoFitHeight="0">
                    <cfif lcase(HcomID) eq "bestform_i">
                <Cell ss:StyleID="s32"><Data ss:Type="String">#sno#</Data></Cell>
                <cfset sno=sno+1>
                </cfif>
						<Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                        
					  	<Cell ss:StyleID="s32"><Data ss:Type="String">#Itemno# - 
						<cfif lcase(HcomID) neq "bestform_i">
                        <cfwddx action = "cfml2wddx" input = "#getbody.desp#" output = "wddxText">
                        #wddxText#
                        <cfelse>
						<cfif itemno eq '..'>
                        <cfwddx action = "cfml2wddx" input = "#tostring(getbody.comment)#" output = "wddxText">
                        #wddxText#<cfelse>
                        <cfwddx action = "cfml2wddx" input = "#getbody.desp#" output = "wddxText">
                        #wddxText#</cfif></cfif></Data></Cell>
                        <cfif lcase(HcomID) eq "sumiden_i" and (url.type eq "6" or url.type eq "4")>
                            <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                            <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                            </cfif>
                        
						<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></cfif>
                        <cfwddx action = "cfml2wddx" input = "#getbody.exported#" output = "wddxText2">
					  	<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#
                         <cfif lcase(HcomID) neq "bestform_i">
                         <cfwddx action = "cfml2wddx" input = "#getbody.brem4#" output = "wddxText3">#wddxText3#</cfif></Data></Cell>
					  	<Cell ss:StyleID="s32"><Data ss:Type="String"><cfif ttype2 eq 'RC'><b>Request</b> <cfelse><b>Delivery</b> 
						  		</cfif>
						  		<b>Date :</b><cfif lcase(HcomID) eq "bestform_i">
                                <cfwddx action = "cfml2wddx" input = "#dateformat(getbody.dodate,'DD/MM/YYYY')#" output = "wddxText4">#wddxText4#
								<cfelseif lcase(HcomID) eq "sumiden_i">
                                 <cfwddx action = "cfml2wddx" input = " #getheader.rem5#" output = "wddxText4">#wddxText4#
                                <cfelse>
                                <cfwddx action = "cfml2wddx" input = " #dateformat(getbody.deliverydate,'dd/mm/yyyy')#" output = "wddxText4">#wddxText4#</cfif>
						  		<b>
								<cfif lcase(HcomID) eq "bestform_i">
                                Material :
                                <cfelse>
                                Cf Date
                                </cfif>
                                 </b> 
                                  <cfwddx action = "cfml2wddx" input = " #getbody.brem2#" output = "wddxText5">#wddxText5#
								</Data></Cell>
                            <cfif lcase(HcomID) eq "bestform_i">
                                <Cell ss:StyleID="s32"><Data ss:Type="String"><div align="center">
				<cfquery name='getexpdate' datasource='#dts#'>
				select rc_expdate from obbatch where batchcode='#batchcode#'
				</cfquery>
                <cfwddx action = "cfml2wddx" input = "#batchcode# " output = "wddxText6">
                <cfwddx action = "cfml2wddx" input = "#dateformat(expdate,'dd/mm/yyyy')# " output = "wddxText7">
                <cfwddx action = "cfml2wddx" input = "#source# " output = "wddxText8">
                <cfwddx action = "cfml2wddx" input = "#getheader.pono# " output = "wddxText9">
				#wddxText6#  Expire Date : #wddxText7#</div></Data></Cell>
                                <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                                <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText9#</Data></Cell>
                                </cfif>
                             <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">			
                              <cfwddx action = "cfml2wddx" input = "#getheader.pono# " output = "wddxText10">			
  <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText10#</Data></Cell>
                                </cfif>
                                <cfwddx action = "cfml2wddx" input = "#orderqty# " output = "wddxText11">			
					  	 <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText11#</Data></Cell>
                         
					  	<cfif url.type neq "7" and  url.type neq "8">
                         <cfwddx action = "cfml2wddx" input = "#thiswriteoff# " output = "wddxText12">			
							 <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText12#</Data></Cell>
						</cfif>
					  	<Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
					  	<Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
					  	<cfif url.type eq '7' or url.type eq '8'><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></cfif>
                         <cfwddx action = "cfml2wddx" input = "#rcqty# " output = "wddxText13">	
                         <cfwddx action = "cfml2wddx" input = "#outstand# " output = "wddxText14">			
              			<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText13#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText14#</Data></Cell>
                        <cfif type eq '6'>
                        <cfif isdefined('form.cbpriceamt')>
                         <cfwddx action = "cfml2wddx" input = "#getbody.price# " output = "wddxText15">
                         <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText15#</Data></Cell>
                          <Cell ss:StyleID="s32"><Data ss:Type="String">
						  <cfif lcase(HcomID) eq "bestform_i">
                          <cfwddx action = "cfml2wddx" input = "#getheader.currcode# " output = "wddxText16">#wddxText16#</cfif>
                          <cfwddx action = "cfml2wddx" input = "#outstand*getbody.price# " output = "wddxText17">#wddxText17#</Data></Cell>

                        <cfelse>
                        </cfif>
                        <cfelse>
                        <cfwddx action = "cfml2wddx" input = "#getbody.price# " output = "wddxText18">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText18#</Data></Cell>
                          <Cell ss:StyleID="s32"><Data ss:Type="String">
						  <cfif lcase(HcomID) eq "bestform_i">
                          <cfwddx action = "cfml2wddx" input = "#getheader.currcode#" output = "wddxText19">#wddxText19#</cfif> 
                          <cfwddx action = "cfml2wddx" input = "#outstand*getbody.price#" output = "wddxText20">#wddxText20#</Data></Cell></cfif>
            		</Row>
          			</cfoutput>
		   			
					<cfset ttorderqty = ttorderqty + orderqty>
					<cfset ttrcqty = ttrcqty + rcqty>
                    <cfset ttamt = ttamt + outstand*getbody.price>
        			<!--- <cfset ttoutstand = ttorderqty - ttrcqty> --->
        		</cfif>
      		</cfloop>
      		
    	</cfloop>
		<cfoutput> 
        
        <Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <cfif lcase(HcomID) eq "sumiden_i" and (url.type eq "6" or url.type eq "4")>
                            <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                            <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                            </cfif>
                    <cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    </cfif>
                    <cfif lcase(HcomID) eq "bestform_i">
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    </cfif>
                    <Cell ss:StyleID="s38"><Data ss:Type="String">Total</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#ttorderqty#</Data></Cell>
                    
                    <cfif url.type neq "7" and url.type neq "8">
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#totwriteoff#</Data></Cell>
					<cfset ttoutstand = ttorderqty - ttrcqty - totwriteoff>
					<cfelse>
					<cfset ttoutstand = ttorderqty - ttrcqty>
					</cfif>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <cfif url.type eq '7' or url.type eq '8'>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#ttrcqty#</Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#ttoutstand#</Data></Cell>
                    <cfif type eq '6'>
					<cfif isdefined('form.cbpriceamt')>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#ttamt#</Data></Cell>
                    <cfelse>
                    </cfif>
                    <cfelse>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#ttamt#</Data></Cell>
                    </cfif>
					
		</Row>
    	</cfoutput> 
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
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
    
    
    
    <cfelse>
	
	<table width="100%" border="0" class="data1" align="center" cellspacing="0" cellpadding="3">
    	<tr> 
      		<cfif lcase(HcomID) eq "bestform_i">
            <th>S/No</th>
            </cfif>
      		<th>Date</th>
			<th>Type</th>
            <cfif lcase(HcomID) neq "bestform_i">
      		<th>Ref No.</th>
            </cfif>
            <cfif lcase(HcomID) eq "sumiden_i" and url.type eq "6">
            <th>Ref No 2.</th>
            <th>PO No.</th>
            </cfif>
            <cfif lcase(HcomID) eq "sumiden_i" and url.type eq "4">
            <th>Ref No 2.</th>
            <th>SO No.</th>
            </cfif>
      		<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><th>Ref 2</th></cfif>
      		<th nowrap>
				<cfif type eq 'PO' or type eq '4'>
					Supplier 
				<cfelse>
					Customer
				</cfif>			</th>
            <cfif lcase(HcomID) eq "bestform_i">
            <td></td>
            <th>Drawing No</th>
            <th nowrap><div align="center">In-house Job No.</div></th>
            <th><div align="center">PO/SO No.</div></th>
            </cfif>    
            <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
            <th><div align="center">PO/SO No.</div></th>
            </cfif>
                
      		<th>Qty Ordered</th>
            
			<cfif url.type neq "7" and url.type neq "8">
				<th>Write Off</th>
			</cfif>
      		<cfoutput> 
        	<th>#ttype2# Date</th>
        	<th>#ttype2# No</th>
      		</cfoutput> 
      		
			<cfif url.type eq '7' or url.type eq '8'>
        		<th><cfoutput>#ttype2#</cfoutput> Req Date/C.firm Date</th>
      		</cfif>
      		
			<th>Qty Updated</th>
      		<th>Qty Outstanding</th>
            <cfif type eq '6'>
            <cfif isdefined('form.cbpriceamt')>
            <th>Price</th>
            <th>Discount</th>
      		<th>Amount</th>
            <cfelse>
            </cfif>
            <cfelse>
            <th>Price</th>
      		<th>Amount</th>
            </cfif>
    	</tr>
    	<cfset sno=1>
		<cfloop query="getheader">
      		<cfoutput> 
        	<tr> 
          		
          		<td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
                <cfif url.type eq '4'>
			<td>#type#
          		</td>
                <td>
				<a href="/../../../billformat/#dts#/transactionformat.cfm?tran=#type#&nexttranno=#refno#" target="_blank">#refno#</a>
                </td>
      			<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><td>#refno2#</td></cfif>
                <td>#getheader.refno2#</td>
                <td>#getheader.pono#</td>
                <td colspan="100%">
          		#custno# - #name#
                </td>
                <cfelse>
                <td>#type#</td>
                <cfif lcase(HcomID) neq "bestform_i">
          		<td nowrap>
                
				<a href="/../../../billformat/#dts#/transactionformat.cfm?tran=#type#&nexttranno=#refno#" target="_blank">#refno#</a> 
			
			</td></cfif>
      			<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><td>#refno2#</td></cfif>
                <cfif lcase(HcomID) eq "sumiden_i" and url.type eq "6">
                            <td><div align="right">#getheader.refno2#</div></td>
                            <td>#getheader.pono#</td>
                </cfif>
                
          		<td colspan="3" nowrap>#custno# - #name#</td>
                </cfif>
          		<cfif url.type eq '7' or url.type eq '8'>
                
            		<td>&nbsp;</td>
          		</cfif>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
        	</tr>
      		</cfoutput> 
      		
			<cfquery name="getbody" datasource="#dts#">
				select deliverydate,refno,trancode,qty,disamt,price,amt,itemno,desp,despa,comment,brem1,brem2,brem4,exported,writeoff,batchcode,expdate,source,dodate from 
				<cfif url.type eq '8'>ictranmat<cfelse>ictran</cfif> where refno = '#refno#' and type = '#ttype#' 
                <cfif url.type eq '6'>
                <cfif lcase(HcomID) eq "bestform_i"><cfif isdefined("form.checkbox1")><cfelse>and shipped < qty</cfif></cfif>
                </cfif>
				<cfif url.type eq '6' or url.type eq '7' or url.type eq '8'>
					<cfif deldatefrom neq "" and deldateto neq "">
                    <cfif lcase(hcomid) eq "dgalleria_i">
       				<cfelse>
					and <!---cast(concat_ws('-',substring(brem1,1,2),substring(brem1,4,2),substring(brem1,7,2)) as date)--->deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
					</cfif>
                    </cfif>
				</cfif>
				<cfif url.type eq '4' or url.type eq '7' or url.type eq '8'>
					<cfif trim(itemfrom) neq "" and trim(itemto) neq "">
					and itemno >= '#itemfrom#' and itemno <= '#itemto#' 
					</cfif>
				</cfif>
				order by <cfif lcase(HcomID) eq "bestform_i">source<cfelse>itemcount </cfif>
      		</cfquery>
      		
			<cfloop query="getbody">
				<cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
        		<cfset totalrcqty = 0>
				<cfset rcqty = 0>
        		
				<cfif getbody.qty neq "">
          			<cfset orderqty = getbody.qty>
          		<cfelse>
          			<cfset orderqty = 0>
        		</cfif>
        		
				<cfquery name="getrcqty" datasource="#dts#">
        			select qty ,refno,type,itemno,trancode from iclink where frrefno = '#getbody.refno#' 
        			and itemno = '#getbody.itemno#' and frtrancode = '#getbody.trancode#' 
        			<cfif url.type eq '4'>
          				and type = 'RC' 
          			<cfelseif url.type eq '6'>
          				and (type = 'DO' or type = 'INV') 
          			<cfelseif url.type eq '7' or url.type eq '8'>
          				and type = 'PO' 
        			</cfif>
        			and frtype = '#ttype#' order by refno 
        		</cfquery>
        		
				
				<!--- <cfdump var="#getrcqty#">
				<cfdump var="#geticdata#"> --->
        		<!--- type = '#ttype2#' --->
				
				<cfset thiswriteoff = writeoff>
				<cfset thisprice = price>
                <cfset thisdisamt = disamt>
				<cfset thisamt = amt>
        		<cfif getrcqty.recordcount gt 0>
          			<cfset cnt = 0>
          			
					<cfoutput query="getrcqty">
						<!---  <cfif getrcqty.qty neq geticdata.qty> ---><!--- Edited --->
            			<cfquery name="geticdata" datasource="#dts#">
        					select type,refno,qty,price,disamt_bil,itemno,desp,wos_date,dodate,brem1,brem2,source,batchcode,expdate,comment from <cfif url.type eq '8'>ictranmat<cfelse>ictran</cfif> 
        					where refno = '#getrcqty.refno#' and itemno = '#getrcqty.itemno#' and 
        					trancode = '#getrcqty.trancode#' 
        					<cfif url.type eq '4'>
          						and type = 'RC' 
          					<cfelseif url.type eq '6'>
          						and (type = 'DO' or type = 'INV')
                                 <cfif lcase(HcomID) eq "bestform_i"><cfif isdefined("form.checkbox1")><cfelse>and shipped < qty</cfif></cfif>
          					<cfelseif url.type eq '7' or url.type eq '8'>
          						and type = 'PO' 
        					</cfif>
        				</cfquery>
						<cfif getrcqty.qty neq "">
              				<cfset rcqty = getrcqty.qty>
              			<cfelse>
              				<cfset rcqty = 0>
            			</cfif>
            			
						<cfset totalrcqty = totalrcqty + rcqty>
            			<cfset outstand = orderqty - totalrcqty>
            			<tr> 
                        <cfif lcase(HcomID) eq "bestform_i">
                <td><div align="center">#sno#</div></td>
                <cfset sno=sno+1>
                </cfif>
              				<td>&nbsp;</td>
            				<td nowrap>
							<cfif cnt eq 0><a href="inforecastreport2e1.cfm?itemno=#urlencodedformat(itemno)#&itembal=0&pf=&pt=&cf=&ct=&gpf=&gpt=&projfr=&projto=" target="_self">#Itemno# - <cfif lcase(HcomID) neq "bestform_i">#getbody.desp#&nbsp;#getbody.despa#<cfelse><cfif itemno eq '..'>#tostring(getbody.comment)#<cfelse>#getbody.desp#&nbsp;#getbody.despa#</cfif></cfif></a>
							</cfif>						</td>
							<cfif lcase(HcomID) eq "sumiden_i" and (url.type eq "6" or url.type eq "4")>
                            <td></td>
                            <td></td>
                            </cfif>

							<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><td>&nbsp;</td></cfif>
              				<td>#getbody.exported#<br> <cfif lcase(HcomID) neq "bestform_i">#getbody.brem4#</cfif></td>
              				<td>
								<cfif getbody.brem1 neq "" or getbody.brem2 neq "">
                  					<cfif ttype2 eq 'RC'>
                    					Req 
                    				<cfelse>
                    					Del 
                  					</cfif>
                  					
									Date <cfif lcase(HcomID) eq "bestform_i">#dateformat(getbody.dodate,'DD/MM/YYYY')#<cfelseif lcase(HcomID) eq "sumiden_i">#getheader.rem5#<cfelse>#getbody.brem1#</cfif><br>
                  					<cfif lcase(HcomID) eq "bestform_i">Material :<cfelse>Cf Date</cfif> #getbody.brem2#
								</cfif>							</td>
                                <cfif lcase(HcomID) eq "bestform_i">
                                <td nowrap><div align="center">
				<cfquery name='getexpdate' datasource='#dts#'>
				select rc_expdate from obbatch where batchcode='#geticdata.batchcode#'
				</cfquery>
#geticdata.batchcode# <br>Expire Date: #dateformat(geticdata.expdate,'dd/mm/yyyy')#</div></td>
                                <td nowrap><div align="center">#geticdata.source#</div></td>
                                <td nowrap><div align="center">#getheader.pono#</div></td>
                                </cfif>
                                <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">						<td nowrap><div align="center">#getheader.pono#</div></td>
                                </cfif>
              				<td><div align="center"><cfif cnt eq 0>#orderqty#</cfif></div></td>
                            
							<cfif url.type neq "7" and url.type neq "8">
								<td><div align="center"><cfif cnt eq 0>#thiswriteoff#</cfif></div></td>
							</cfif>
              				<td>#dateformat(geticdata.wos_date,"dd/mm/yy")#</td>
              				<td>
							<a href="/../../../billformat/#dts#/transactionformat.cfm?tran=#geticdata.type#&nexttranno=#geticdata.refno#" target="_blank">#geticdata.refno#</a>						</td>
              				
                            
                            
							<cfif url.type eq '7' or url.type eq '8'>
                				<td nowrap><cfif geticdata.brem1 neq "" or geticdata.brem2 neq "">Req Date #geticdata.brem1#<br><cfif lcase(HcomID) eq "bestform_i">Material :<cfelse>Cf Date</cfif>  #geticdata.brem2#</cfif></td>
              				</cfif>
              				
							<td><div align="center">#rcqty#</div></td>
              				<td><div align="center">
								<cfif getrcqty.currentrow eq getrcqty.recordcount>
									<cfif url.type neq "7" and url.type neq "8">
										<cfset outstand = outstand - thiswriteoff>
									</cfif>
									#outstand#
								</cfif>
							</div></td>
                            <cfif type eq '6'>
                            <cfif isdefined('form.cbpriceamt')>
                            <cfif getrcqty.currentrow eq getrcqty.recordcount>
              				<td><div align="right">#numberformat(thisprice,",_.__")#</div></td>
              				<td><div align="right"><cfif lcase(HcomID) eq "bestform_i">#getheader.currcode#</cfif> #numberformat(outstand*thisprice,",_.__")#</div></td>
                            </cfif>
                            <cfelse>
                            </cfif>
                            <cfelse>
                            <cfif getrcqty.currentrow eq getrcqty.recordcount>
                            <td><div align="right">#numberformat(thisprice,",_.__")#</div></td>
                            
              				<td><div align="right"><cfif lcase(HcomID) eq "bestform_i">#getheader.currcode#</cfif> #numberformat(outstand*thisprice,",_.__")#</div></td>
                            </cfif>
                            </cfif>
            			</tr>
						<cfif cnt eq 0>
							<cfset ttorderqty = ttorderqty + orderqty>
						</cfif>
						<cfset ttrcqty = ttrcqty + rcqty>
                        <cfif getrcqty.currentrow eq getrcqty.recordcount>
                        <cfset ttamt = ttamt + outstand*thisprice>
                        </cfif>
            			<cfset cnt = cnt + 1>
						<!--- </cfif> ---><!--- Edited --->
          			</cfoutput> 
          		<cfelse>
					<cfif url.type neq "7" and url.type neq "8">
						<cfset rcqty = 0>
						<cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
					<cfelse>
						<cfset rcqty = 0>
						<cfset outstand = orderqty - rcqty>
					</cfif>	
						  	
          			<cfoutput> 
            		<tr> 
                    <cfif lcase(HcomID) eq "bestform_i">
                <td><div align="center">#sno#</div></td>
                <cfset sno=sno+1>
                </cfif>
						<td>&nbsp;</td>
                        
					  	<td nowrap><a href="inforecastreport2e1.cfm?itemno=#urlencodedformat(itemno)#&itembal=0&pf=&pt=&cf=&ct=&gpf=&gpt=&projfr=&projto=" target="_self">#Itemno# - <cfif lcase(HcomID) neq "bestform_i">#getbody.desp#&nbsp;#getbody.despa#<cfelse><cfif itemno eq '..'>#tostring(getbody.comment)#<cfelse>#getbody.desp#&nbsp;#getbody.despa#</cfif></cfif></a></td>
                        <cfif lcase(HcomID) eq "sumiden_i" and (url.type eq "6" or url.type eq "4")>
                            <td></td>
                            <td></td>
                        </cfif>
						<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><td>&nbsp;</td></cfif>
					  	<td>#getbody.exported#<br> <cfif lcase(HcomID) neq "bestform_i">#getbody.brem4#</cfif></td>
					  	<td nowrap>
							
						  		<cfif ttype2 eq 'RC'>
									<b>Request</b> 
								<cfelse>
									<b>Delivery</b> 
						  		</cfif>
						  		<b>Date :</b><cfif lcase(HcomID) eq "bestform_i">#dateformat(getbody.dodate,'DD/MM/YYYY')#<cfelseif lcase(HcomID) eq "sumiden_i">#getheader.rem5#<cfelse>#dateformat(getbody.deliverydate,"dd/mm/yyyy")#</cfif><br>
						  		<b><cfif lcase(HcomID) eq "bestform_i">Material :<cfelse>Cf Date</cfif> </b> #getbody.brem2#
												</td>
                            <cfif lcase(HcomID) eq "bestform_i">
                                <td nowrap><div align="center">
				<cfquery name='getexpdate' datasource='#dts#'>
				select rc_expdate from obbatch where batchcode='#batchcode#'
				</cfquery>
				#batchcode# <br> Expire Date : #dateformat(expdate,'dd/mm/yyyy')#</div></td>
                                <td nowrap><div align="center">#source#</div></td>
                                <td nowrap><div align="center">#getheader.pono#</div></td>
                                </cfif>
                             <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">						<td nowrap><div align="center">#getheader.pono#</div></td>
                                </cfif>
					  	<td><div align="center">#orderqty#</div></td>
					  	<cfif url.type neq "7" and  url.type neq "8">
							<td><div align="center">#thiswriteoff#</div></td>
						</cfif>
					  	<td></td>
					  	<td></td>
					  	<cfif url.type eq '7' or url.type eq '8'><td></td></cfif>
              			<td><div align="center">#rcqty#</div></td>
              			<td><div align="center">#outstand#</div></td>
                        <cfif type eq '6'>
                        <cfif isdefined('form.cbpriceamt')>
              			<td><div align="right">#getbody.price#</div></td>
                        <td><div align="right"></div></td>
              			<td><div align="right"><cfif lcase(HcomID) eq "bestform_i">#getheader.currcode#</cfif> #numberformat((outstand*getbody.price)-thisdisamt,",_.__")#</div></td>
                        <cfelse>
                        </cfif>
                        <cfelse>
                        <td><div align="right">#getbody.price#</div></td>
              			<td><div align="right"><cfif lcase(HcomID) eq "bestform_i">#getheader.currcode#</cfif> #numberformat(outstand*getbody.price,",_.__")#</div></td>
                        </cfif>
            		</tr>
          			</cfoutput>
		   			
					<cfset ttorderqty = ttorderqty + orderqty>
					<cfset ttrcqty = ttrcqty + rcqty>
                    <cfset ttdisamt = ttdisamt + thisdisamt>
                    <cfset ttamt = ttamt + ((outstand*getbody.price)-thisdisamt)>
        			<!--- <cfset ttoutstand = ttorderqty - ttrcqty> --->
                     
        		</cfif>
      		</cfloop>
      		
			<tr> 
        		<td colspan="100%"><hr></td>
      		</tr>
             <cfquery name="getotalgrand" datasource="#dts#">
                    select grand from artran where refno='#getbody.refno#'
                    </cfquery>
<cfset ttgrandamt = ttgrandamt + val(getotalgrand.grand)>
    	</cfloop>
    	
		<cfoutput> 
      	<tr bgcolor="##83B8ED"> 
			<td>&nbsp;</td>
			<td nowrap>&nbsp;</td>
			<td>&nbsp;</td>
            <cfif lcase(HcomID) eq "sumiden_i" and (url.type eq "6" or url.type eq "4")>
            <td></td>
            <td></td>
            </cfif>
			<cfif url.type eq "4" and (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")><td>&nbsp;</td></cfif>
            <cfif lcase(HcomID) eq "bestform_i">
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            </cfif>
			<td nowrap><div align="right">Total</div></td>
			<td><div align="center">#ttorderqty#</div></td>
			<cfif url.type neq "7" and url.type neq "8">
				<td><div align="center">#totwriteoff#</div></td>
				<cfset ttoutstand = ttorderqty - ttrcqty - totwriteoff>
			<cfelse>
				<cfset ttoutstand = ttorderqty - ttrcqty>
			</cfif>
			<td></td>
			<td></td>
			<cfif url.type eq '7' or url.type eq '8'>
			<td></td>
			</cfif>
			<td><div align="center">#ttrcqty#</div></td>
			<td><div align="center">#ttoutstand#</div></td>
            <cfif type eq '6'>
            <cfif isdefined('form.cbpriceamt')>
			<td>&nbsp;</td>
 <td><div align="center"><cfif hcomid eq 'net_i'>#numberformat(ttdisamt+getheader.discount,',_.__')#<cfelse>#numberformat(ttdisamt,',_.__')#</cfif></div></td>
 
			<td><div align="center"><cfif hcomid eq 'net_i'>#numberformat(ttgrandamt-getheader.discount,',_.__')#<cfelse><!---#numberformat(ttgrandamt,',_.__')#--->#numberformat(ttamt,',_.__')#</cfif></div></td>
            <cfelse>
            </cfif>
            <cfelse>
          <td>&nbsp;</td>
			<td><div align="center">#numberformat(ttamt,',_.__')#</div></td>
            </cfif>
      	</tr>
    	</cfoutput> 
 	</table>
	</cfif>
<cfelseif type eq "QUO">
	<table width="80%" border="0" class="data1" align="center" cellspacing="0" cellpadding="3">
    	<tr> 
      		<th>Type</th>
      		<th>Date</th>
      		<th>Ref No.</th>
      		<th>Customer</th>
            <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
            <th>PO/SO No.</th>
            </cfif>
      		<th>Qty Quot </th>
      		<th>Qty Sales </th>
      		<th>Qty Outstanding </th>
      		<th>Price</th>
    	</tr>
    	
		<cfloop query="getheader">
      		<cfoutput> 
        	<tr> 
          		<td>#type#</td>
          		<td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          		<td nowrap>#refno#</td>
          		<td colspan="3">#custno# - #name#</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
        	</tr>
      		</cfoutput> 
      		
			<cfquery name="getbody" datasource="#dts#">
      			select refno,qty,price,amt,itemno,trancode,desp,despa,pono from ictran where refno = '#refno#' and type = '#ttype#' 
      		</cfquery>
      		
			<cfoutput query="getbody">	
       		  <cfif getbody.qty neq "">
          			<cfset orderqty = getbody.qty>
          		<cfelse>
          			<cfset orderqty = 0>
       		  </cfif>
        		
				<cfquery name="getrcqty" datasource="#dts#">
        			select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
        			and frtype = '#ttype#' and itemno = '#itemno#' and frtrancode = '#trancode#' 
        			and (type = 'INV' or type = 'SO' or type = 'DO') 
        		</cfquery>
        		
			  <cfif getrcqty.qty1 neq "">
          			<cfset rcqty = getrcqty.qty1>
          		<cfelse>
          			<cfset rcqty = 0>
       		  </cfif>
				
        		<cfset outstand = orderqty - rcqty>
        		<cfset totaloutstand = totaloutstand + outstand>
        		<cfset totalrcqty = totalrcqty + rcqty>
        		<cfset totalorderqty = totalorderqty + orderqty>
                <cfset totalgrandamt = totalgrandamt + amt>
        		
				<tr> 
          			<td>&nbsp;</td>
          			<td>&nbsp;</td>
          			<td colspan="2">#Itemno# - #desp# #despa#</td>

                    <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
                    <td><div align="center">#getheader.pono#</div></td>
                    </cfif>
          			<td><div align="center">#orderqty#</div></td>
          			<td><div align="center">#rcqty#</div></td>
          			<td><div align="center">#outstand#</div></td>
          			<td><div align="right">#numberformat(amt,",_.__")#</div></td>
        		</tr>
      		</cfoutput> 
			<tr> 
        		<td colspan="8"><hr></td>
      		</tr>
    	</cfloop>
    	
		<cfoutput> 
      	<tr bgcolor="##83B8ED"> 
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
             <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
             <td>&nbsp;</td>
             </cfif>
       	 	<td colspan="2"><div align="right">Total</div></td>
        	<td><div align="center">#totalorderqty#</div></td>
       	 	<td><div align="center">#totalrcqty#</div></td>
       	 	<td><div align="center">#totaloutstand#</div></td>
        	<td><div align="right">#numberformat(totalgrandamt,",_.__")#</div></td>
      	</tr>
    	</cfoutput>
	</table>
    
<cfelseif url.type eq "3" and isdefined("form.checkbox")>

<cfif form.result eq 'EXCEL'>
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
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
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
		 	</Styles>
			
			<Worksheet ss:Name="Outstanding Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
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

		   
					<cfwddx action = "cfml2wddx" input = "Outstanding PO Report" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>

				
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Item No.</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Date</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Ref No.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Ref No 2.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Ordered</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Request Date</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Received</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Write Off</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Outstanding</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Price</Data></Cell>
				</Row>   
			<cfloop query="getheader">
        
        <cfset outstand = 0>
				<cfset totaloutstand = 0>
				<cfset totalrcqty = 0>
				<cfset totalorderqty = 0>
				<cfset totwriteoff = 0>
            
            	<cfoutput>
					<cfwddx action = "cfml2wddx" input = "#itemno#" output = "wddxText">

					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
				</cfoutput>

      		
			<cfquery name="getbody" datasource="#dts#">
      			select wos_date,refno,qty,price,amt,itemno,brem1,refno2,trancode,writeoff from ictran where itemno='#itemno#' and (shipped+writeoff) < qty  and type = '#ttype#' 
      			<cfif trim(itemfrom) neq "" and trim(itemto) neq "">
        			and itemno >= '#itemfrom#' and itemno <= '#itemto#'
      			</cfif>
      			<cfif deldatefrom neq "" and deldateto neq "">
                	<cfif lcase(hcomid) eq "dgalleria_i">
       				<cfelse>
        			and <!---cast(concat_ws('-',substring(brem1,1,2),substring(brem1,4,2),substring(brem1,7,2)) as date)--->deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
      				</cfif>
                    </cfif>
      			order by itemcount 
      		</cfquery>
      		
			<cfoutput query="getbody">	
       		  <cfif getbody.qty neq "">
          			<cfset orderqty = getbody.qty>
          		<cfelse>
          			<cfset orderqty = 0>
       		  </cfif>
        		
				<cfquery name="getrcqty" datasource="#dts#">
        			select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
        			and itemno = '#itemno#' and frtrancode = '#trancode#' and type = 'RC' and frtype = 'PO' 
        		</cfquery>
        		
			  <cfif getrcqty.qty1 neq "">
          			<cfset rcqty = getrcqty.qty1>
          		<cfelse>
          			<cfset rcqty = 0>
       		  </cfif>
		
        		<cfset rcqty = rcqty>
		
				<cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
				<cfset totaloutstand = totaloutstand + outstand>
				<cfset totalrcqty = totalrcqty + rcqty>
				<cfset totalorderqty = totalorderqty + orderqty>
				<cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
				
                <cfoutput>
					<cfwddx action = "cfml2wddx" input = "#dateformat(wos_date,'dd/mm/yy')#" output = "wddxText">
                    <cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText1">
                    <cfwddx action = "cfml2wddx" input = "#orderqty#" output = "wddxText2">
                    <cfwddx action = "cfml2wddx" input = "#brem1#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#rcqty#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#getbody.writeoff#" output = "wddxText5">
                    <cfwddx action = "cfml2wddx" input = "#outstand#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#amt#" output = "wddxText7">
                    <cfwddx action = "cfml2wddx" input = "#getheader.refno2#" output = "wddxText8">

					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText1#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#orderqty#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#rcqty#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#getbody.writeoff#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#outstand#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#amt#</Data></Cell>
					</Row>
				</cfoutput>
                
			</cfoutput>
			<Row ss:AutoFitHeight="0" ss:Height="12"/>
		<cfoutput>
        
        <Row ss:AutoFitHeight="0" ss:Height="12">
        			<Cell ss:StyleID="s38"/>
        			<Cell ss:StyleID="s38"/>
                    <Cell ss:StyleID="s38"/>
					<Cell ss:StyleID="s38"><Data ss:Type="String">GROUP TOTAL:</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totalorderqty#</Data></Cell>
                    <Cell ss:StyleID="s38"/>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totalrcqty#</Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#totwriteoff#</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totaloutstand#</Data></Cell>
                    
					<Cell ss:StyleID="s38"/>
					
		</Row>
        
		</cfoutput>
		</cfloop>

				<Row ss:AutoFitHeight="0" ss:Height="12"/>
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

<cfelse>

	<table width="80%" border="0" class="data1" align="center" cellspacing="0" cellpadding="3">
    	<tr> 
      		<th>Item No.</th>
      		<th>Date</th>
      		<th>Ref No.</th>
      		<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i"><th>Ref 2</th></cfif>
      		<th></th>
      		<th>Qty Ordered </th>
      		<th>Request Date</th>
      		<th>Qty Received</th>
			<th>Write Off</th>
      		<th>Qty Outstanding </th>
      		<th>Price</th>
    	</tr>
            
		<cfloop query="getheader">
        
        <cfset outstand = 0>
				<cfset totaloutstand = 0>
				<cfset totalrcqty = 0>
				<cfset totalorderqty = 0>
				<cfset totwriteoff = 0>
                <cfset totalamt=0>
      		<cfoutput> 
        	<tr> 
          		<td><b>#itemno#</b></td>
          		<td colspan="5"><cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
                #desp#
                </cfif></td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
				<td>&nbsp;</td>
        	</tr>
      		</cfoutput> 
      		
			<cfquery name="getbody" datasource="#dts#">
      			select wos_date,refno,qty,price,amt,itemno,brem1,trancode,writeoff from ictran where itemno='#itemno#' and (shipped+writeoff) < qty  and type = '#ttype#' 
      			<cfif trim(itemfrom) neq "" and trim(itemto) neq "">
        			and itemno >= '#itemfrom#' and itemno <= '#itemto#'
      			</cfif>
      			<cfif deldatefrom neq "" and deldateto neq "">
                	<cfif lcase(hcomid) eq "dgalleria_i">
       				<cfelse>
        			and <!---cast(concat_ws('-',substring(brem1,1,2),substring(brem1,4,2),substring(brem1,7,2)) as date)--->deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
      				</cfif>
                    </cfif>
      			order by itemcount 
      		</cfquery>
      		
			<cfoutput query="getbody">	
       		  <cfif getbody.qty neq "">
          			<cfset orderqty = getbody.qty>
          		<cfelse>
          			<cfset orderqty = 0>
       		  </cfif>
        		
				<cfquery name="getrcqty" datasource="#dts#">
        			select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
        			and itemno = '#itemno#' and frtrancode = '#trancode#' and type = 'RC' and frtype = 'PO' 
        		</cfquery>
        		
			  <cfif getrcqty.qty1 neq "">
          			<cfset rcqty = getrcqty.qty1>
          		<cfelse>
          			<cfset rcqty = 0>
       		  </cfif>
		
        		<cfset rcqty = rcqty>
		
				<cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
				<cfset totaloutstand = totaloutstand + outstand>
				<cfset totalrcqty = totalrcqty + rcqty>
				<cfset totalorderqty = totalorderqty + orderqty>
				<cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
                <cfset totalamt=totalamt+(val(price)*val(outstand))>
				
				<tr>
					<td></td>
				  	<td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
				  	<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
					  	<td colspan="3">#refno#</td>
					<cfelse>
						<td colspan="2">#refno#</td>
					</cfif>
				  	<td><div align="center">#orderqty#</div></td>
				  	<td><div align="center">#brem1#</div></td>
				  	<td><div align="center">#rcqty#</div></td>
				  	<td><div align="center">#val(getbody.writeoff)#</div></td>
				  	<td><div align="center">#outstand#</div></td>
				  	<td><div align="right">#numberformat(val(price)*val(outstand),",_.__")#</div></td>
				</tr>
			</cfoutput>
			<tr> 
				<td colspan="100%"><hr></td>
			</tr>
		<cfoutput>
		<tr bgcolor="##83B8ED"> 
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
				<td colspan="3"><div align="right">Total</div></td>
			<cfelse>
				<td colspan="2"><div align="right">Total</div></td>
			</cfif>
			<td><div align="center">#totalorderqty#</div></td>
			<td></td>
			<td><div align="center">#totalrcqty#</div></td>
			<td><div align="center">#totwriteoff#</div></td>
			<td><div align="center">#totaloutstand#</div></td>
			<td><div align="right">#numberformat(totalamt,",_.__")#</div></td>
		</tr>
		</cfoutput>
		</cfloop>
		

	</table>
</cfif>


<cfelseif url.type eq "3">

<cfif form.result eq 'EXCEL'>
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
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
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
		 	</Styles>
			
			<Worksheet ss:Name="Outstanding Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
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

		   
					<cfwddx action = "cfml2wddx" input = "Outstanding PO Report" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>

				
				</cfoutput>
        
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Type</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Date</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Ref No.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Ref No 2.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Supplier</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Ordered</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Request Date</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Reply Date</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Received</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Write Off</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Outstanding</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Price</Data></Cell>
				</Row>   
		<cfloop query="getheader">
      		<cfoutput> 
            <cfoutput>
					<cfwddx action = "cfml2wddx" input = "#type#" output = "wddxText">
                    <cfwddx action = "cfml2wddx" input = "#dateformat(wos_date,'DD/MM/YYYY')#" output = "wddxText1">
                    <cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText2">
                    <cfwddx action = "cfml2wddx" input = "#refno2#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#custno# - #name#" output = "wddxText4">

					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText1#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                         <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
					</Row>
				</cfoutput>
      		</cfoutput> 
      		
			<cfquery name="getbody" datasource="#dts#">
      			select refno,qty,desp,despa,price,amt,itemno,brem1,trancode,writeoff,requiredate,replydate from ictran where refno = '#refno#' and type = '#ttype#' 
      			<cfif trim(itemfrom) neq "" and trim(itemto) neq "">
        			and itemno >= '#itemfrom#' and itemno <= '#itemto#'
      			</cfif>
      			<cfif deldatefrom neq "" and deldateto neq "">
                	<cfif lcase(hcomid) eq "dgalleria_i">
       				<cfelse>
        			and <!---cast(concat_ws('-',substring(brem1,1,2),substring(brem1,4,2),substring(brem1,7,2)) as date)--->deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
      				</cfif>
                    </cfif>
      			order by itemcount 
      		</cfquery>
      		
			<cfoutput query="getbody">	
       		  <cfif getbody.qty neq "">
          			<cfset orderqty = getbody.qty>
          		<cfelse>
          			<cfset orderqty = 0>
       		  </cfif>
        		
				<cfquery name="getrcqty" datasource="#dts#">
        			select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
        			and itemno = '#itemno#' and frtrancode = '#trancode#' and type = 'RC' and frtype = 'PO' 
        		</cfquery>
        		
			  <cfif getrcqty.qty1 neq "">
          			<cfset rcqty = getrcqty.qty1>
          		<cfelse>
          			<cfset rcqty = 0>
       		  </cfif>
		
        		<cfset rcqty = rcqty>
		
				<cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
				<cfset totaloutstand = totaloutstand + outstand>
				<cfset totalrcqty = totalrcqty + rcqty>
				<cfset totalorderqty = totalorderqty + orderqty>
				<cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
				
					<cfwddx action = "cfml2wddx" input = "#Itemno#" output = "wddxText">
                    <cfwddx action = "cfml2wddx" input = "#orderqty#" output = "wddxText1">
                    <cfwddx action = "cfml2wddx" input = "#dateformat(requiredate,'dd/mm/yyyy')#" output = "wddxText2">
                    <cfwddx action = "cfml2wddx" input = "#dateformat(replydate,'dd/mm/yyyy')#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#rcqty#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#getbody.writeoff#" output = "wddxText5">
                    <cfwddx action = "cfml2wddx" input = "#outstand#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#val(price)*val(outstand)#" output = "wddxText7">

					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#orderqty#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#wddxText4#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#getbody.writeoff#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#outstand#</Data></Cell>
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(price)*val(outstand)#</Data></Cell>
					</Row>
                
			</cfoutput>
			<Row ss:AutoFitHeight="0" ss:Height="12"/>
		</cfloop>
        
		
		<cfoutput>
        
         <Row ss:AutoFitHeight="0" ss:Height="12">
        			<Cell ss:StyleID="s38"/>
        			<Cell ss:StyleID="s38"/>
                    <Cell ss:StyleID="s38"/>
                    <Cell ss:StyleID="s38"/>
					<Cell ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totalorderqty#</Data></Cell>
                    <Cell ss:StyleID="s38"/>
                    <Cell ss:StyleID="s38"/>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totalrcqty#</Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#totwriteoff#</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totaloutstand#</Data></Cell>
                    
					<Cell ss:StyleID="s38"/>
					
		</Row>
		</cfoutput>

				<Row ss:AutoFitHeight="0" ss:Height="12"/>
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

<cfelse>

	<table width="80%" border="0" class="data1" align="center" cellspacing="0" cellpadding="3">
    	<tr> 
      		<th>Type</th>
      		<th>Date</th>
      		<th>Ref No.</th>
      		<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i" or lcase(HcomID) eq "asaiki_i"><th>Ref 2</th></cfif>
      		<th>Supplier</th>
      		<th>Qty Ordered </th>
      		<th>Request Date</th>
            <th>Reply Date</th>
      		<th>Qty Received</th>
			<th>Write Off</th>
      		<th>Qty Outstanding </th>
      		<th>Price</th>
    	</tr>
    	
		<cfloop query="getheader">
      		<cfoutput> 
        	<tr> 
          		<td>#type#</td>
          		<td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          		<td nowrap>#refno#</td>
				<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i" or lcase(HcomID) eq "asaiki_i"><td>#refno2#</td></cfif>
          		<td colspan="3">#custno# - #name#</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
				<td>&nbsp;</td>
        	</tr>
      		</cfoutput> 
      		
			<cfquery name="getbody" datasource="#dts#">
      			select refno,qty,desp,despa,price,amt,itemno,brem1,trancode,writeoff,requiredate,replydate from ictran where refno = '#refno#' and type = '#ttype#' 
      			<cfif trim(itemfrom) neq "" and trim(itemto) neq "">
        			and itemno >= '#itemfrom#' and itemno <= '#itemto#'
      			</cfif>
      			<cfif deldatefrom neq "" and deldateto neq "">
                	<cfif lcase(hcomid) eq "dgalleria_i">
       				<cfelse>
        			and <!---cast(concat_ws('-',substring(brem1,1,2),substring(brem1,4,2),substring(brem1,7,2)) as date)--->deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
      				</cfif>
                    </cfif>
      			order by itemcount 
      		</cfquery>
      		
			<cfoutput query="getbody">	
       		  <cfif getbody.qty neq "">
          			<cfset orderqty = getbody.qty>
          		<cfelse>
          			<cfset orderqty = 0>
       		  </cfif>
        		
				<cfquery name="getrcqty" datasource="#dts#">
        			select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
        			and itemno = '#itemno#' and frtrancode = '#trancode#' and type = 'RC' and frtype = 'PO' 
        		</cfquery>
        		
			  <cfif getrcqty.qty1 neq "">
          			<cfset rcqty = getrcqty.qty1>
          		<cfelse>
          			<cfset rcqty = 0>
       		  </cfif>
		
        		<cfset rcqty = rcqty>
		
				<cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
				<cfset totaloutstand = totaloutstand + outstand>
				<cfset totalrcqty = totalrcqty + rcqty>
				<cfset totalorderqty = totalorderqty + orderqty>
				<cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
				<cfset totalamt = totalamt + (val(price)*val(outstand))>
				<tr>
					<td>&nbsp;</td>
				  	<td>&nbsp;</td>
				  	<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i" or lcase(HcomID) eq "asaiki_i">
					  	<td colspan="3">#Itemno#</td>
					<cfelse>
						<td colspan="2">#Itemno#<cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i"> - #desp#</cfif></td>
					</cfif>
				  	<td><div align="center">#orderqty#</div></td>
				  	<td><div align="center">#dateformat(requiredate,"dd/mm/yyyy")#</div></td>
                    <td><div align="center">#dateformat(replydate,"dd/mm/yyyy")#</div></td>
				  	<td><div align="center">#rcqty#</div></td>
				  	<td><div align="center">#val(getbody.writeoff)#</div></td>
				  	<td><div align="center">#outstand#</div></td>
				  	<td><div align="right">#numberformat(val(price)*val(outstand),",_.__")#</div></td>
				</tr>
			</cfoutput>
			<tr> 
				<td colspan="100%"><hr></td>
			</tr>
		</cfloop>
		
		<cfoutput>
		<tr bgcolor="##83B8ED"> 
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i" or lcase(HcomID) eq "asaiki_i">
				<td colspan="3"><div align="right">Total</div></td>
			<cfelse>
				<td colspan="2"><div align="right">Total</div></td>
			</cfif>
			<td><div align="center">#totalorderqty#</div></td>
			<td></td>
			<td><div align="center">#totalrcqty#</div></td>
			<td><div align="center">#totwriteoff#</div></td>
			<td><div align="center">#totaloutstand#</div></td>
            <td>&nbsp;</td>
			<td><div align="right">#numberformat(totalamt,",_.__")#</div></td>
		</tr>
		</cfoutput>
	</table>
	    
</cfif>
    
<cfelseif url.type eq "5">

	<cfif form.result eq 'HTML'>

        <table width="85%" border="0" class="data1" align="center" cellspacing="0" cellpadding="3">
            <tr> 
                <th>Type</th>
                <th>Date</th>
                <th nowrap>Ref No.</th>
                <th>PO No.</th>
                <th>Customer</th>
                <th>Qty Ordered </th>
                <th>Delivery Date</th>
                <th>Qty Delivered</th>
                <th>Write Off</th>
                <th>Qty Outstanding</th>	
                <th>Price</th>
                <th>Discount</th>
                <th>Amount</th>
            </tr>
            
            <cfloop query="getheader">
                <cfoutput> 
                    <tr> 
                        <td>#type#</td>
                        <td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
                        <td nowrap>#refno#</td>
                        <td nowrap>#pono#</td>
                        <td colspan="2">#custno# - #name# <cfif IsDefined('DELIVERYDATE')>- #deliverydate#</cfif></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </cfoutput> 
                
                <cfquery name="getbody" datasource="#dts#">
                    select refno,qty,desp,despa,price,price_bil,amt,itemno,brem1,brem2,brem4,exported,trancode,writeoff,deliverydate,disamt from 
                    ictran where refno = '#refno#' and type = '#ttype#' and (shipped+writeoff) < qty 
                    <cfif trim(itemfrom) neq "" and trim(itemto) neq "">
                        and itemno >= '#itemfrom#' and itemno <= '#itemto#'
                    </cfif>
                    <cfif deldatefrom neq "" and deldateto neq "">
                        and deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
                    </cfif>
                </cfquery>
                
                <cfloop query="getbody">
                  <cfif getbody.price neq "">
                        <cfset xprice = getbody.price>
                    <cfelse>
                        <cfset xprice = 0>
                  </cfif>
                    
                      <cfif getbody.price_bil neq "">
                        <cfset xprice_bil = getbody.price_bil>
                    <cfelse>
                        <cfset xprice_bil= 0>
                  </cfif>
                    
                  <cfif getbody.qty neq "">
                        <cfset orderqty = getbody.qty>
                    <cfelse>
                        <cfset orderqty = 0>
                  </cfif>
                    
                    <cfquery name="getrcqty" datasource="#dts#">
                        select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
                        and frtype = '#ttype#' and itemno = '#itemno#' and frtrancode = '#trancode#' 
                        and (type = 'INV' or type = 'DO') 
                    </cfquery>
                    
                  <cfif getrcqty.qty1 neq "">
                        <cfset rcqty = getrcqty.qty1>
                    <cfelse>
                        <cfset rcqty = 0>
                  </cfif>
                    <cfset rcqty = rcqty>
                    <cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
                    <cfset rightamt_bil= outstand * xprice_bil>
                    <cfset rightamt = (xprice* #outstand#)-disamt>
                    <cfset totaloutstand = totaloutstand + outstand>
                    <cfset totalrcqty = totalrcqty + rcqty>
                    <cfset totalorderqty = totalorderqty + orderqty>
                    <cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
                    
                    <cfoutput> 
                        <tr> 
                            <td>&nbsp;</td>
                            <td>#Itemno#</td>
                            <cfquery name="getaitemno" datasource="#dts#">
                                select aitemno 
                                from icitem 
                                where itemno='#getbody.itemno#'
                            </cfquery> 
                            <td></td>
                            <td nowrap>#brem1#</td>
                            <td></td>
                            <td><div align="center">#orderqty#</div></td>
                            <td nowrap><div align="center">#dateformat(deliverydate,"dd/mm/yy")#</div></td>
                            <td><div align="center">#rcqty#</div></td>
                            <td><div align="center">#val(getbody.writeoff)#</div></td>
                            <td><div align="center">#outstand#</div></td>
                            <td><div align="right">#xprice#</div></td>
                            <td><div align="right">#disamt#</div></td>
                            <td><div align="right">#numberformat(rightamt,",_.__")#</div></td>
                        </tr>
                    </cfoutput> 
                </cfloop>
     
                <cfoutput> 
                    <cfset ttoutstand = 0>
                    <cfset ttrcqty = 0>
                    <cfset ttorderqty = 0>
                    <cfset ttwriteoff = 0>
                    <cfset ttdisamt = 0>
                    <cfset ttrightamt = 0>
                    <cfset rightamt = 0>
                    <cfloop query="getbody">
                      <cfif getbody.qty neq "">
                            <cfset orderqty = getbody.qty>
                        <cfelse>
                            <cfset orderqty = 0>
                      </cfif>
                        
                      <cfif getbody.price neq "">
                            <cfset xprice = getbody.price>
                        <cfelse>
                            <cfset xprice = 0>
                      </cfif>
                        <cfquery name="gettax" datasource="#dts#">
                            select * from ictran where refno='#getbody.refno#'
                        </cfquery>
                        <cfquery name="getrcqty" datasource="#dts#">
                            select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
                            and frtype = '#ttype#' and itemno = '#itemno#' and frtrancode = '#trancode#' 
                            and (type = 'INV' or type = 'DO') 
                        </cfquery>
                        <cfquery name="getgrand" datasource="#dts#">
                            select grand,tax from artran where refno='#getbody.refno#'
                        </cfquery>
    
                      <cfif getrcqty.qty1 neq "">
                            <cfset rcqty = getrcqty.qty1>
                        <cfelse>
                            <cfset rcqty = 0>
                      </cfif>
                        
                        <cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
                        <cfset rightamt = (rightamt +(xprice* #outstand#))-disamt>
                        <cfset ttorderqty = ttorderqty + orderqty>
                        <cfset ttrcqty = ttrcqty + rcqty>
                        <cfset ttwriteoff = ttwriteoff + val(getbody.writeoff)>
                        <cfset ttoutstand = ttoutstand + outstand>
                        <cfset ttrightamt = ttrightamt + rightamt>
                        <cfset ttdisamt = ttdisamt + disamt>
                    </cfloop>
    
                    <tr bgcolor="##83B8ED"> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td colspan="2">&nbsp;</td>
                        <td></td>
                        <td><div align="center">#ttorderqty#</div></td>
                        <td></td>
                        <td><div align="center">#ttrcqty#</div></td>
                        <td><div align="center">#ttwriteoff#</div></td>
                        <td><div align="center">#ttoutstand#</div></td>
                        <td><div align="right"></div></td>
                        <td><div align="right">#ttdisamt#</div></td>
                        <td><div align="right">#numberformat(rightamt,",_.__")#</div></td>
                    </tr>
                    <tr> 
                        <td colspan="80%"><hr></td>
                    </tr>
                    
                    <cfset totalrightamt = (totalrightamt + rightamt)>
                    <cfset totaldisamt = totaldisamt + ttdisamt>
                    
                </cfoutput> 
            </cfloop>
            
            <cfoutput> 
            
            <tr bgcolor="##659CE0"> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td></td>
                <td colspan="2"><div align="right">Total</div></td>
                <td><div align="center">#totalorderqty#</div></td>
                <td></td>
                <td><div align="center">#totalrcqty#</div></td>
                <td><div align="center">#totwriteoff#</div></td>
                <td><div align="center">#totaloutstand#</div></td>
                <td></td>
                <td><div align="right">#totaldisamt#</div></td>
                <td><div align="right">#numberformat(totalrightamt,",_.__")#</div></td>
            </tr>
            </cfoutput> 
        </table>
        
    <cfelse>    
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
					<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
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
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
                <Style ss:ID="s40">
					<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Outstanding Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="34.5"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="120.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>

					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="14" ss:StyleID="s22"><Data ss:Type="String">Outstanding Sales Order Status</Data></Cell>
					</Row>

                    <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Type</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Date</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Ref No.</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">PO No.</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Customer</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Ordered</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Delivery Date</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Delivered</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Write Off</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Qty Outstanding</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Price</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Discount</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Amount</Data></Cell>
                    </Row>
                       
                    <cfloop query="getheader">
                        <cfoutput>
                                <cfwddx action = "cfml2wddx" input = "#type#" output = "wddxText">
                                <cfwddx action = "cfml2wddx" input = "#dateformat(wos_date,'DD/MM/YY')#" output = "wddxText1">
                                <cfwddx action = "cfml2wddx" input = "#refno#" output = "wddxText2">
                                <cfwddx action = "cfml2wddx" input = "#pono#" output = "wddxText3">
                                <cfwddx action = "cfml2wddx" input = "#custno# - #name#" output = "wddxText4">
            
                                <Row ss:AutoFitHeight="0">
                                    <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText1#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4# <cfif IsDefined('DELIVERYDATE')>- #deliverydate#</cfif></Data></Cell>
                                </Row>
                        </cfoutput> 
                        
                        <cfquery name="getbody" datasource="#dts#">
                            select refno,qty,desp,despa,price,price_bil,amt,itemno,brem1,brem2,brem4,exported,trancode,writeoff,deliverydate,disamt 
                            from ictran 
                            where refno = '#refno#' 
                            and type = '#ttype#' 
                            and (shipped+writeoff) < qty 
                            <cfif trim(itemfrom) neq "" and trim(itemto) neq "">
                                and itemno >= '#itemfrom#' and itemno <= '#itemto#'
                            </cfif>
                            <cfif deldatefrom neq "" and deldateto neq "">
                                and deliverydate between '#ndeldatefrom#' and '#ndeldateto#'
                            </cfif>
                        </cfquery>
      		
                        <cfloop query="getbody">
                            <cfif getbody.price neq "">
                                <cfset xprice = getbody.price>
                            <cfelse>
                                <cfset xprice = 0>
                            </cfif>
                                            
                            <cfif getbody.price_bil neq "">
                                <cfset xprice_bil = getbody.price_bil>
                            <cfelse>
                                <cfset xprice_bil= 0>
                            </cfif>
                                            
                            <cfif getbody.qty neq "">
                                <cfset orderqty = getbody.qty>
                            <cfelse>
                                <cfset orderqty = 0>
                            </cfif>
                                            
                            <cfquery name="getrcqty" datasource="#dts#">
                                select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
                                and frtype = '#ttype#' and itemno = '#itemno#' and frtrancode = '#trancode#' 
                                and (type = 'INV' or type = 'DO') 
                            </cfquery>
                            
                            <cfif getrcqty.qty1 neq "">
                                <cfset rcqty = getrcqty.qty1>
                            <cfelse>
                                <cfset rcqty = 0>
                            </cfif>
                            <cfset rcqty = rcqty>
                            <cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
                            <cfset rightamt_bil= outstand * xprice_bil>
                            <cfset rightamt = (xprice* #outstand#)-disamt>
                            <cfset totaloutstand = totaloutstand + outstand>
                            <cfset totalrcqty = totalrcqty + rcqty>
                            <cfset totalorderqty = totalorderqty + orderqty>
                            <cfset totwriteoff = totwriteoff + val(getbody.writeoff)>
                        
							<cfoutput>
                            	 <cfquery name="getaitemno" datasource="#dts#">
                                    select aitemno 
                                    from icitem 
                                    where itemno='#getbody.itemno#'
                                </cfquery> 
                
                                <Row ss:AutoFitHeight="0">
                                    <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String">#Itemno#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                                    <Cell ss:StyleID="s33"><Data ss:Type="String">#brem1#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#orderqty#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="String">#dateformat(deliverydate,"dd/mm/yy")#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#rcqty#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#val(getbody.writeoff)#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#outstand#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#xprice#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#disamt#</Data></Cell>
                                    <Cell ss:StyleID="s32"><Data ss:Type="Number">#numberformat(rightamt,",_.__")#</Data></Cell>
                                </Row>
                            </cfoutput>
                    	</cfloop>
                    
						<cfoutput> 
                            <cfset ttoutstand = 0>
                            <cfset ttrcqty = 0>
                            <cfset ttorderqty = 0>
                            <cfset ttwriteoff = 0>
                            <cfset ttdisamt = 0>
                            <cfset ttrightamt = 0>
                            <cfset rightamt = 0>
                            <cfloop query="getbody">
                              <cfif getbody.qty neq "">
                                    <cfset orderqty = getbody.qty>
                                <cfelse>
                                    <cfset orderqty = 0>
                              </cfif>
                                
                              <cfif getbody.price neq "">
                                    <cfset xprice = getbody.price>
                                <cfelse>
                                    <cfset xprice = 0>
                              </cfif>
                                <cfquery name="gettax" datasource="#dts#">
                                    select * from ictran where refno='#getbody.refno#'
                                </cfquery>
                                <cfquery name="getrcqty" datasource="#dts#">
                                    select sum(qty) as qty1 from iclink where frrefno = '#getbody.refno#' 
                                    and frtype = '#ttype#' and itemno = '#itemno#' and frtrancode = '#trancode#' 
                                    and (type = 'INV' or type = 'DO') 
                                </cfquery>
                                <cfquery name="getgrand" datasource="#dts#">
                                    select grand,tax from artran where refno='#getbody.refno#'
                                </cfquery>
            
                              <cfif getrcqty.qty1 neq "">
                                    <cfset rcqty = getrcqty.qty1>
                                <cfelse>
                                    <cfset rcqty = 0>
                              </cfif>
                                
                                <cfset outstand = orderqty - rcqty - val(getbody.writeoff)>
                                <cfset rightamt = (rightamt +(xprice* #outstand#))-disamt>
                                <cfset ttorderqty = ttorderqty + orderqty>
                                <cfset ttrcqty = ttrcqty + rcqty>
                                <cfset ttwriteoff = ttwriteoff + val(getbody.writeoff)>
                                <cfset ttoutstand = ttoutstand + outstand>
                                <cfset ttrightamt = ttrightamt + rightamt>
                                <cfset ttdisamt = ttdisamt + disamt>
                            </cfloop>
            
                            <Row ss:AutoFitHeight="0" ss:Height="12">
                                <Cell ss:StyleID="s38"/>
                                <Cell ss:StyleID="s38"/>
                                <Cell ss:StyleID="s38"/>
                                <Cell ss:StyleID="s38"/>
                                <Cell ss:StyleID="s38"><Data ss:Type="String">SUBTOTAL:</Data></Cell>
                                <Cell ss:StyleID="s40"><Data ss:Type="Number">#totalorderqty#</Data></Cell>
                                <Cell ss:StyleID="s38"/>
                                <Cell ss:StyleID="s40"><Data ss:Type="Number">#ttrcqty#</Data></Cell>
                                <Cell ss:StyleID="s40"><Data ss:Type="Number">#ttwriteoff#</Data></Cell>
                                <Cell ss:StyleID="s40"><Data ss:Type="Number">#ttoutstand#</Data></Cell>
                                <Cell ss:StyleID="s38"/>
                                <Cell ss:StyleID="s40"><Data ss:Type="Number">#ttdisamt#</Data></Cell>
                                <Cell ss:StyleID="s40"><Data ss:Type="Number">#numberformat(rightamt,",_.__")#</Data></Cell>
                            </Row>
                            
                            <cfset totalrightamt = (totalrightamt + rightamt)>
                            <cfset totaldisamt = totaldisamt + ttdisamt>
                        </cfoutput>
					</cfloop>
					<cfoutput>
                        <Row ss:AutoFitHeight="0" ss:Height="12">
                            <Cell ss:StyleID="s38"/>
                            <Cell ss:StyleID="s38"/>
                            <Cell ss:StyleID="s38"/>
                            <Cell ss:StyleID="s38"/>
                            <Cell ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
                            <Cell ss:StyleID="s40"><Data ss:Type="Number">#totalorderqty#</Data></Cell>
                            <Cell ss:StyleID="s38"/>
                            <Cell ss:StyleID="s40"><Data ss:Type="Number">#totalrcqty#</Data></Cell>
                            <Cell ss:StyleID="s40"><Data ss:Type="Number">#totwriteoff#</Data></Cell>
                            <Cell ss:StyleID="s40"><Data ss:Type="Number">#totaloutstand#</Data></Cell>
                            <Cell ss:StyleID="s38"/>
                            <Cell ss:StyleID="s40"><Data ss:Type="Number">#totaldisamt#</Data></Cell>
                            <Cell ss:StyleID="s40"><Data ss:Type="Number">#numberformat(totalrightamt,",_.__")#</Data></Cell>
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
</cfif>

</body>
</html>