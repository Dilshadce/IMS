<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset dd = dateformat(form.datefrom, 'DD')>
		<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
		<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
		</cfif>

						<cfset dd = dateformat(form.dateto, 'DD')>
		<cfif dd greater than '12'>
		<cfset ndateto= dateformat(form.dateto,"YYYYMMDD")>
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

<cfquery name="getdrivername" datasource="#dts#">
	SELECT * FROM driver
</cfquery>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getdeliveredorder" datasource="#dts#">
select * from (
select * from packlist where
(delivery_on <> "0000-00-00" or delivery_on is not null)
 <cfif form.datefrom neq "" and form.dateto neq "">
 and delivery_on between '#dateformat(createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2)),'YYYY-MM-DD')#' and '#dateformat(createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2)),'YYYY-MM-DD')#'
  </cfif>
    <cfif form.groupfrom neq "" and form.groupto neq "">
	and packid between '#form.groupfrom#' and  '#form.groupto#'
  </cfif>
    <cfif form.groupfrom2 neq "" and form.groupto2 neq "">
	and driver between '#form.groupfrom2#' and '#form.groupto2#'
  </cfif>
) as a
left join
(select * from packlistbill) as b
on a.packid=b.packid
order by delivery_on
</cfquery>  
<cfswitch expression="HTML">
	<cfcase value="HTML">
		<html>
		<head>
		<title>Driver Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		
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
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> Delivery Report</strong></font></div></td>
			</tr>
            <cfif form.groupfrom neq "" and form.groupto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Pack No #form.groupfrom# - #form.groupto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif"> Delivery Date #form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
				<cfif form.groupfrom2 neq "" and form.groupto2 neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Driver No #form.groupfrom2# - #form.groupto2#</font></div></td>
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

  <cfif #getdeliveredorder.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getDeliveryAdd.recordcount# mod 20 neq 0>
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
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer Name</cfoutput></font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Address</cfoutput></font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Telephone</cfoutput></font></strong></td>
                        
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Bill No </font></strong></td>


        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Bill Date</font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Driver No</font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Delivery On</font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Delivered</font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Delivered On</font></strong></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
          
  <cfoutput query="getdeliveredorder">
  
  <cfquery name="getname" dbtype="query">
  SELECT name FROM getdrivername WHERE driverno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeliveredorder.driver#">
  </cfquery>
  <cfset drivername = getname.name>
  
  <cfquery name="getDeliveryAdd" datasource="#dts#">
  select a.type,a.custno,a.refno,a.wos_date,a.van,a.rem1,a.comm0,a.comm1,a.comm2,a.comm3,rem12,b.custno,b.add1,b.add2,b.add3,b.add4,b.phone,b.name,b.name2,b.postalcode,b.country,c.custno,c.add1 as addd1,c.add2 as addd2,c.add3 as addd3,c.add4 as addd4,c.phone as phone1 from artran as a 
  
  left join <cfif Hlinkams eq "Y">#replacenocase(dts,"_i","_a","all")#.</cfif>arcust as b on a.custno=b.custno
  left join address as c on a.custno=c.custno
  where a.type = "#getdeliveredorder.reftype#"
  and a.refno = "#getdeliveredorder.billrefno#"
  </cfquery>
  <cfif isdefined("form.cbdeliver")>
  <cfif getDeliveryAdd.rem1 eq "">
        <tr>
          <td height="32"><div align="left">#i#</div></td>
          <td>#getDeliveryAdd.name#<br/> #getDeliveryAdd.name2#</td>
          <td>#getDeliveryAdd.comm0#<br/>#getDeliveryAdd.comm1#<br/>#getDeliveryAdd.comm2# #getDeliveryAdd.comm3#</td>
         <td>#getDeliveryAdd.rem12#</td>
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#getDeliveryAdd.dateformat(wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="9%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#</td>
<td align="center" width="3%"><cfif getdeliveredorder.delivered_on neq "">Y<cfelse>N</cfif></td>
<td align="center" width="9%"><cfif getdeliveredorder.delivered_on neq "">#dateformat(getdeliveredorder.delivered_on,"YYYY-MM-DD")#</cfif></td>
        </tr>
      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
        <cfelseif getDeliveryAdd.rem1 eq "Profile">
          <tr>
          <td><div align="left">#i#</div></td>
          <td>#getDeliveryAdd.name#</td>
          <td>#getDeliveryAdd.add1#<br/>#getDeliveryAdd.add2#<br/>#getDeliveryAdd.add3# #getDeliveryAdd.add4#</td>
         <td>#getDeliveryAdd.phone#</td>
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#dateformat(getDeliveryAdd.wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="9%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#</td>
<td align="center" width="3%"><cfif getdeliveredorder.delivered_on neq "">Y<cfelse>N</cfif></td>
<td align="center" width="9%"><cfif getdeliveredorder.delivered_on neq "">#dateformat(getdeliveredorder.delivered_on,"YYYY-MM-DD")#</cfif></td>
        </tr>      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
                <cfelse>
                          <tr>
          <td><div align="left">#i#</div></td>
          <td>#getDeliveryAdd.name#</td>
          <td>#getDeliveryAdd.addd1#<br/>#getDeliveryAdd.addd2#<br/>#getDeliveryAdd.addd3# #getDeliveryAdd.addd4#</td>
         <td>#getDeliveryAdd.phone1#</td>
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#dateformat(getDeliveryAdd.wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="9%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#</td>
<td align="center" width="3%"><cfif getdeliveredorder.delivered_on neq "">Y<cfelse>N</cfif></td>
<td align="center" width="9%"><cfif getdeliveredorder.delivered_on neq "">#dateformat(getdeliveredorder.delivered_on,"YYYY-MM-DD")#</cfif></td>
        </tr>      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
                
        </cfif>

                <cfelse>     
        <tr>
          <td height="32"><div align="left">#i#</div></td>
          <td>#getDeliveryAdd.name#<br/> #getDeliveryAdd.name2#</td>
          <td>#getDeliveryAdd.add1#<br/>#getDeliveryAdd.add2#<br/>#getDeliveryAdd.add3# #getDeliveryAdd.add4#</td>
         <td>#getDeliveryAdd.phone#</td>
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#dateformat(getDeliveryAdd.wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="9%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#</td>
<td align="center" width="3%"><cfif getdeliveredorder.delivered_on neq "">Y<cfelse>N</cfif></td>
<td align="center" width="9%"><cfif getdeliveredorder.delivered_on neq "">#dateformat(getdeliveredorder.delivered_on,"YYYY-MM-DD")#</cfif></td>
        </tr>
      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
      </cfif> 
	  </cfoutput>
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
<cfquery name="getDo" datasource="#dts#">
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

      <cfoutput query="getDo" startrow="1">

			<Row ss:Height="12">
				<cfif getVehicles.carno eq "">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Carno</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">No - Carno</Data></Cell>
				<cfelse>
					<cfwddx action = "cfml2wddx" input = "#getVehicles.carno#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getVehicles.custcode#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getDo.name)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getDo.add1)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getDo.tel)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getDo.refno)#</Data></Cell>
				<Cell ss:StyleID="s30"><Data ss:Type="Number">#val(getDo.wos_date)#</Data></Cell>
                
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