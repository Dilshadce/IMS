<html>
<head><title>Forecast Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
  .noprint { display: none; }
</style>
</head>
<noscript>
Javascript has been disabled or not supported in this browser.<br>
Please enable Javascript supported before continue.
</noscript>

<cfparam name="Email" default="">
<cfparam name="totalin" default="0">
<cfparam name="totalout" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro, compro2, compro3, compro4, compro5, compro6, compro7, lastaccyear from gsetup
</cfquery>

<cfparam name="i" default="1" type="numeric">
<cfparam name="balonhand" default="0">

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

<cfquery name="getitem" datasource="#dts#">
  	select itemno, desp, qtybf, price, price3, unit, category, sizeid, costcode, colorid, shelf, wos_group
	from icitem where itemno <>''
	<cfif productfrom neq "" and productto neq "">
	and itemno >= '#productfrom#' and itemno <= '#productto#'
  	</cfif>
  	<cfif catefrom neq "" and cateto neq "">
	and category >= '#catefrom#' and category <= '#cateto#'
  	</cfif>
  	<cfif sizeidfrom neq "" and sizeidto neq "">
	and sizeid >= '#sizeidfrom#' and sizeid <= '#sizeidto#'
  	</cfif>
  	<cfif costcodefrom neq "" and costcodeto neq "">
	and costcode >= '#costcodefrom#' and costcode <= '#costcodeto#'
  	</cfif>
  	<cfif coloridfrom neq "" and coloridto neq "">
	and colorid >= '#coloridfrom#' and colorid <= '#coloridto#'
  	</cfif>
  	<cfif shelffrom neq "" and shelfto neq "">
	and shelf >= '#shelffrom#' and shelf <= '#shelfto#'
  	</cfif>
  	<cfif groupfrom neq "" and groupto neq "">
	and wos_group >= '#groupfrom#' and wos_group <= '#groupto#'
  	</cfif>

	<cfswitch expression="#form.rgSort#">
    	<cfcase value="Valve Type">
	  	order by category, itemno
		</cfcase>
		<cfcase value="Size">
	  	order by sizeid, itemno
		</cfcase>
		<cfcase value="Rating">
	  	order by costcode, itemno
		</cfcase>
		<cfcase value="Material">
	  	order by colorid, itemno
		</cfcase>
 		<cfcase value="Manufacturer">
	  	order by shelf, itemno
		</cfcase>
		<cfcase value="Model">
	  	order by wos_group, itemno
		</cfcase>
	</cfswitch>
</cfquery>

<!--- Control The Decimal Point --->
<cfquery name="getgsetup2" datasource='#dts#'>
  	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ",_.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<body>
<cfif getitem.itemno eq "">
    <cfoutput><h4><font color="##FF0000">No Report Generated.</font></h4></cfoutput>
	<cfabort>
</cfif>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<cfoutput query="getgeneral">
		<tr>
        	<td colspan="3"><div align="center"><font size="4" face="Times New Roman, Times, serif"><strong><cfif getgeneral.compro neq ''>#compro#</cfif></strong></font> <br>
          	<font size="1" face="Times New Roman, Times, serif"><cfif getgeneral.compro2 neq ''>#compro2#<br></cfif></font>
          	<font size="1" face="Times New Roman, Times, serif"><cfif getgeneral.compro3 neq ''>#compro3#<br></cfif></font>
          	<font size="1" face="Times New Roman, Times, serif"><cfif getgeneral.compro4 neq ''>#compro4#<br></cfif></font>
          	<font size="1" face="Times New Roman, Times, serif"><cfif getgeneral.compro5 neq ''>#compro5#<br></cfif></font>
          	<font size="1" face="Times New Roman, Times, serif"><cfif getgeneral.compro6 neq ''>#compro6#<br></cfif></font>
          	<font size="1" face="Times New Roman, Times, serif"><cfif getgeneral.compro7 neq ''>#compro7#</cfif></font> </div>
        	</td>
	  	</tr>
    </cfoutput>
	<tr>
      	<td><font size="1" face="Times New Roman, Times, serif"><strong>Forecast Report By <cfoutput>#form.rgsort#</cfoutput></strong></font></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Date : <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
	</tr>

   	<tr>
      	<td colspan="15"><hr></td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
    <tr>
      	<td colspan="9" nowrap><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td colspan="3"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Foreign Currency</strong></font></div></td>
      	<td colspan="3"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>SGD Equivalent</strong></font></div></td>
    </tr>
    <tr>
      	<td width="3%" nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>&nbsp;</strong></font></div></td>
      	<td colspan="3" width="17%" nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Item No. / Item Descriptions</strong></font></div></td>
      	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>On-Hand</strong></font></div></td>
      	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Orded</strong></font></div></td>
      	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Resvd</strong></font></div></td>
      	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Bal.</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Currcy</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Unit Price</strong></font></div></td>
      	<td width="9%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Exchg Rate</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Unit Price</strong></font></div></td>
      	<td width="9%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Min Selling Price</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="15"><hr></td>
    </tr>
    <cfset stLastNo = "">
    <cfset iCount = 0>
    <!--- For Grand FC Total --->
    <cfset CurrArray2 = ArrayNew(2)>
    <cfset CurrArray2[1][1] = "Currency - ">
    <cfset CurrArray2[1][2] = "FC.T.Price">
    <cfset CurrArray2[1][3] = "SGD.T.Price">
    <!--- Put SGD first, and init --->
    <cfset CurrArray2[2][1] = "SGD">
    <cfset CurrArray2[2][2] = 0>
    <cfset CurrArray2[2][3] = 0>

	<cfquery name="getCurrCode" datasource="#dts#">
    	select CurrCode from Currencyrate order by currcode
    </cfquery>

	<cfset i = 3>
    <!--- Init the rest base on Currency table--->
    <cfloop query="getCurrCode">
      	<cfif getCurrCode.CurrCode neq "SGD">
        	<cfset CurrArray2[i][1] = getCurrCode.CurrCode>
        	<cfset CurrArray2[i][2] = 0>
        	<cfset CurrArray2[i][3] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray2[1][1] = CurrArray2[1][1] & ToString(#i# - 2)>
    <cfset SGDEquit = 0>
    <cfset GrandSGDEquit = 0>
    <!--- For Grand Total --->
    <cfset CurrArray1 = ArrayNew(2)>
    <cfset CurrArray1[1][1] = "Currency - ">
    <cfset CurrArray1[1][2] = "FC.T.Price">
    <cfset CurrArray1[1][3] = "SGD.T.Price">
    <cfset CurrArray1[2][1] = "SGD">
    <cfset CurrArray1[2][2] = 0>
    <cfset CurrArray1[2][3] = 0>

	<cfquery name="getCurrCode" datasource="#dts#">
    	select CurrCode from Currencyrate order by currcode
    </cfquery>

	<cfset i = 3>

    <cfloop query="getCurrCode">
      	<cfif getCurrCode.CurrCode neq "SGD">
        	<cfset CurrArray1[i][1] = getCurrCode.CurrCode>
        	<cfset CurrArray1[i][2] = 0>
        	<cfset CurrArray1[i][3] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray1[1][1] = CurrArray1[1][1] & ToString(#i# - 2)>
    <!--- For Sub Total --->
    <cfset CurrArray = ArrayNew(2)>
    <cfset CurrArray[1][1] = "Currency - ">
    <cfset CurrArray[1][2] = "FC.T.Price">
    <cfset CurrArray[1][3] = "SGD.T.Price">
    <cfset CurrArray[2][1] = "SGD">
    <cfset CurrArray[2][2] = 0>
    <cfset CurrArray[2][3] = 0>

	<cfquery name="getCurrCode" datasource="#dts#">
    	select CurrCode from Currencyrate order by currcode
    </cfquery>

	<cfset i = 3>

	<cfloop query="getCurrCode">
      	<cfif getCurrCode.CurrCode neq "SGD">
        	<cfset CurrArray[i][1] = getCurrCode.CurrCode>
        	<cfset CurrArray[i][2] = 0>
        	<cfset CurrArray[i][3] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray[1][1] = CurrArray[1][1] & ToString(#i# - 2)>
<!---
Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type
Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type
Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type
Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type
Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type	Valve Type
--->
<cfif rgSort eq "Valve Type">
	<cfset stLastNo = "">

	<cfloop query = "getitem">
		<cfif stLastNo neq category and stLastNo neq "">
			<tr>
            	<td colspan="15"><hr></td>
          	</tr>
          	<!--- Print the sub-total --->
          	<cfset maxArray = right(CurrArray[1][1],1)>
          	<cfset DisplayTotal = 0>

          	<cfloop index = "i" from = "1" to = "#maxArray#">
            	<cfif CurrArray[i+1][2] neq 0>
					<cfoutput>
              			<tr>
                			<td colspan="3" valign="top" nowrap>&nbsp;</td>
                		<cfif DisplayTotal eq 0>
                  			<td colspan="5"><div align="right"><strong>Sub Total</strong></div></td>
                  			<cfset DisplayTotal = 1>
                		<cfelse>
                  			<td colspan="5">&nbsp;</td>
                		</cfif>
                			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                			<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                			<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.__')#</font></div></td>
                			<td>&nbsp;</td>
              			</tr>
			  		</cfoutput>
              		<cfset SGDEquit = SGDEquit + CurrArray[i+1][3]>
              		<!--- Clear the sub total --->
              		<cfset CurrArray[i+1][2] = 0>
              		<cfset CurrArray[i+1][3] = 0>
            	</cfif>
            	<cfset i = i + 1>
          	</cfloop>
          	<!--- Print SGD Equivalent --->
          	<cfoutput>
		  		<tr>
            		<td colspan="3" valign="top" nowrap>&nbsp;</td>
            		<td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
					<td colspan="3">&nbsp;</td>
					<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(SGDEquit,',_.__')#</font></div></td>
					<td>&nbsp;</td>
            		<cfset SGDEquit = 0>
            		<cfset iCount = 0>
          		</tr>
          		<tr>
            		<td colspan="15" valign="top" nowrap>&nbsp;</td>
          		</tr>
		  	</cfoutput>
        </cfif>
		<cfoutput>
        <cfif stLastNO neq category or stLastNO eq "">
			<cfquery name="getcategorydesp" datasource="#dts#">
				select desp from iccate where cate = '#category#'
			</cfquery>
			<tr>
				<td valign="top" nowrap>&nbsp;</td>
				<td colspan="2"><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><strong>#form.rgsort#:</strong></font></font></div></td>
				<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>&nbsp;<!---#category#--->#getcategorydesp.desp#</strong></font></font></div></td>
				<td colspan="10">&nbsp;</td>
          	</tr>
        </cfif>
        <cfset stLastNo = category>
        <!--- Print details --->
        <tr>
		<cfset lastitembal = 0>

		<cfif periodfrom neq "" and periodto neq "" and periodfrom neq '01'>
			<cfset lastitembal = 0>
			<cfset lastinqty = 0>
			<cfset lastoutqty = 0>
			<cfset lastdoqty = 0>

			<cfquery name="getlastin" datasource="#dts#">
				select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
				and itemno = '#itemno#' and (void = '' or void is null)
				and fperiod  < '#form.periodfrom#'
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#'
				</cfif>
			</cfquery>

			<cfif getlastin.sumqty neq "">
				<cfset lastinqty = getlastin.sumqty>
			</cfif>

			<cfquery name="getlastout" datasource="#dts#">
				select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
				or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
				and fperiod < '#form.periodfrom#'
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#'
				</cfif>
			</cfquery>

			<cfif getlastout.sumqty neq "">
			  	<cfset lastoutqty = getlastout.sumqty>
			</cfif>

		  	<cfquery name="getlastdo" datasource="#dts#">
				select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
				and itemno = '#itemno#' and (void = '' or void is null)
				and fperiod < '#form.periodfrom#'
		  		<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#'
		  		</cfif>
		  	</cfquery>

			<cfif getlastdo.sumqty neq "">
			  	<cfset lastDOqty = getlastdo.sumqty>
			</cfif>

			<cfset lastitembal = lastinqty - lastoutqty - lastdoqty>
		</cfif>

		<cfset itembal = 0>
        <cfset inqty = 0>
        <cfset outqty = 0>
        <cfset doqty = 0>
        <cfset poqty = 0>
        <cfset soqty = 0>

        <cfquery name="getin" datasource="#dts#">
        	select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
		  	and itemno = '#itemno#' and (void = '' or void is null)
          	<cfif form.periodfrom neq "" and form.periodto neq "">
            and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          	</cfif>
          	<cfif form.datefrom neq "" and form.dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
		</cfquery>

		<cfif getin.sumqty neq "">
			<cfset inqty = getin.sumqty>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
          	select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
		  	or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
          	<cfif form.periodfrom neq "" and form.periodto neq "">
            and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          	</cfif>
          	<cfif form.datefrom neq "" and form.dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
        </cfquery>

        <cfif getout.sumqty neq "">
        	<cfset outqty = getout.sumqty>
        </cfif>

		<cfquery name="getdo" datasource="#dts#">
          	select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
          	and itemno = '#itemno#' and (void = '' or void is null)
          	<cfif form.periodfrom neq "" and form.periodto neq "">
            and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          	</cfif>
          	<cfif form.datefrom neq "" and form.dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
        </cfquery>

        <cfif getdo.sumqty neq "">
        	<cfset DOqty = getdo.sumqty>
        </cfif>

        <cfquery name="getpo" datasource="#dts#">
       		select sum(qty - shipped)as sumqty from ictran where type = "PO" and itemno =
          	'#itemno#' and (void = '' or void is null)
          	<cfif form.periodfrom neq "" and form.periodto neq "">
            and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          	</cfif>
          	<cfif form.datefrom neq "" and form.dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
        </cfquery>

        <cfif getpo.sumqty neq "">
        	<cfset poqty = getpo.sumqty>
        </cfif>

        <cfquery name="getso" datasource="#dts#">
        	select sum(qty - shipped)as sumqty from ictran where type = "SO" and itemno =
          	'#itemno#' and (void = '' or void is null)
          	<cfif form.periodfrom neq "" and form.periodto neq "">
            and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          	</cfif>
          	<cfif form.datefrom neq "" and form.dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
        </cfquery>

        <cfif getso.sumqty neq "">
        	<cfset soqty = getso.sumqty>
        </cfif>

        <cfif getitem.qtybf neq "">
            <cfset itembal = getitem.qtybf + lastitembal>
		<cfelse>
		    <cfset itembal = lastitembal>
        </cfif>

		<cfset balonhand = itembal + inqty - outqty - doqty>
        <cfset poohso = poqty + balonhand - soqty>
        <cfset iCount = iCount + 1>

		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#iCount#.&nbsp;</font></font></div></td>
        <td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.itemno#</font></font></div></td>
        <!--- <cfquery name="getSONO" datasource="#dts#">
        select refno, brem1, qty_bil from ictran where type ='SO' and itemno
        = '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
        <cfif periodfrom neq "" and periodto neq "">
          and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
        </cfif>
        <cfif datefrom neq "" and dateto neq "">
          and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		<cfelse>
		  and wos_date > #getgeneral.lastaccyear#
        </cfif>
        </cfquery> --->
        <cfquery name="getPONo" datasource="#dts#">
        	select refno, qty_bil, (price_bil-disamt_bil) as price_bil, (price - disamt)as price , amt_bil, amt, currrate, custno
          	from ictran where type ='PO' and itemno = '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          	<cfif periodfrom neq "" and periodto neq "">
            and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
         	</cfif>
          	<cfif datefrom neq "" and dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
		   	order by trdatetime desc
		</cfquery>
        <!--- <cfset iPOQTY = 0>
          <cfloop query="getPONO">
            <cfset iPOQTY = iPOQTY + getPONO.qty_bil>
          </cfloop>
          <cfset iSOQTY = 0>
          <cfloop query="getSONO">
            <cfset iSOQTY = iSOQTY + getSONO.qty_bil>
          </cfloop>  --->
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#balonhand#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=PO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #POqty#</a></font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=SO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #SOqty#</a></font></font></div></td>
          <!--- <cfset Bal = #balonhand# + #poqty# - #soqty#> --->
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#poohso#</font></font></div></td>

		<cfquery name="getCurrCode2" datasource="#dts#">
        	select currcode from supplier where customerno ='#getPONO.custno#'
        </cfquery>

		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
        <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price_bil,stDecl_UPrice)#</font></div></td>
        <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt_bil,',_.__')#</font></div></td>
        <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.currrate,'____.____')#</font></div></td>
        <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price,stDecl_UPrice)#</font></div></td>
        <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt,',_.__')#</font></div></td>
        <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getitem.price3,stDecl_UPrice)#</font></div></td>
	</tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.desp#</font></font></div></td>
    </tr>
	</cfoutput>

	<cfset maxArray = right(CurrArray2[1][1],1)>

	<cfloop index = "i" from = "1" to = "#maxArray#">
		<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
            <cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getPONO.amt_bil>
            <cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getPONO.amt>
		</cfif>

		<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
        	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getPONO.amt_bil>
            <cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getPONO.amt>
        </cfif>
        <cfset i = i + 1>
	</cfloop>
	</cfloop>
</cfif>
<!---
Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size
Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size
Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size
Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size
Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size
Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size	Size
--->
<cfif rgSort eq "Size">
	<cfset stLastNo = "">

	<cfloop query = "getitem">
		<cfif stLastNo neq sizeid and stLastNo neq "">
			<tr>
            	<td colspan="15"><hr></td>
          	</tr>
          	<!--- Print the sub-total --->
          	<cfset maxArray = right(CurrArray[1][1],1)>
          	<cfset DisplayTotal = 0>

			<cfloop index = "i" from = "1" to = "#maxArray#">
            	<cfif CurrArray[i+1][2] neq 0>
              		<cfoutput>
			  		<tr>
                		<td colspan="3" valign="top" nowrap>&nbsp;</td>
                		<cfif DisplayTotal eq 0>
                  			<td colspan="5"><div align="right"><strong>Sub Total</strong></div></td>
                  			<cfset DisplayTotal = 1>
                  		<cfelse>
                  			<td colspan="5">&nbsp;</td>
               	 		</cfif>
                			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
							<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
							<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.__')#</font></div></td>
							<td>&nbsp;</td>
              		</tr>
			  		</cfoutput>

					<cfset SGDEquit = SGDEquit + CurrArray[i+1][3]>
              		<!--- Clear the sub total --->
              		<cfset CurrArray[i+1][2] = 0>
              		<cfset CurrArray[i+1][3] = 0>
            	</cfif>
            	<cfset i = i + 1>
			</cfloop>
          	<!--- Print SGD Equivalent --->
         	<cfoutput>
		  	<tr>
            	<td colspan="3" valign="top" nowrap>&nbsp;</td>
            	<td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
            	<td colspan="3">&nbsp;</td>
            	<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(SGDEquit,',_.__')#</font></div></td>
            	<td>&nbsp;</td>
            	<cfset SGDEquit = 0>
            	<cfset iCount = 0>
          	</tr>
		  	</cfoutput>
          	<tr>
            	<td colspan="15" valign="top" nowrap>&nbsp;</td>
          	</tr>
		</cfif>

		<cfif stLastNO neq sizeid or stLastNO eq "">
			<cfquery name="getsizedesp" datasource="#dts#">
				select desp from icsizeid where sizeid = '#sizeid#'
			</cfquery>
			<cfoutput>
		  	<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td colspan="2"><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><strong>#form.rgsort#:</strong></font></font></div></td>
            	<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>&nbsp;<!---#sizeid#--->#getsizedesp.desp#</strong></font></font></div></td>
            	<td colspan="10">&nbsp;</td>
          	</tr>
		  	</cfoutput>
        </cfif>

		<cfset stLastNo = sizeid>
        <!--- Print details --->
		<cfoutput>
        <tr>
			<cfset lastitembal = 0>

			<cfif periodfrom neq "" and periodto neq "" and periodfrom neq '01'>
			 	<cfset lastitembal = 0>
			 	<cfset lastinqty = 0>
			 	<cfset lastoutqty = 0>
			 	<cfset lastdoqty = 0>

			 	<cfquery name="getlastin" datasource="#dts#">
				  	select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
				  	and itemno = '#itemno#' and (void = '' or void is null)
				  	and fperiod  < '#form.periodfrom#'
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
				  	</cfif>
				</cfquery>

				<cfif getlastin.sumqty neq "">
				  	<cfset lastinqty = getlastin.sumqty>
				</cfif>

				<cfquery name="getlastout" datasource="#dts#">
					select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
					or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
					</cfif>
				</cfquery>

				<cfif getlastout.sumqty neq "">
			  		<cfset lastoutqty = getlastout.sumqty>
				</cfif>

		  		<cfquery name="getlastdo" datasource="#dts#">
					select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
					and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
		  			<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
		 	 		</cfif>
		  		</cfquery>

				<cfif getlastdo.sumqty neq "">
			  		<cfset lastDOqty = getlastdo.sumqty>
				</cfif>
				<cfset lastitembal = lastinqty - lastoutqty - lastdoqty>
			</cfif>

          	<cfset itembal = 0>
          	<cfset inqty = 0>
          	<cfset outqty = 0>
          	<cfset doqty = 0>
          	<cfset poqty = 0>
          	<cfset soqty = 0>

          	<cfquery name="getin" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
		  		and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getin.sumqty neq "">
            	<cfset inqty = getin.sumqty>
            </cfif>

          	<cfquery name="getout" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
		  		or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getout.sumqty neq "">
            	<cfset outqty = getout.sumqty>
            </cfif>

          	<cfquery name="getdo" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
          		and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

          	<cfif getdo.sumqty neq "">
          		<cfset DOqty = getdo.sumqty>
          	</cfif>

          	<cfquery name="getpo" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "PO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getpo.sumqty neq "">
              	<cfset poqty = getpo.sumqty>
            </cfif>

          	<cfquery name="getso" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "SO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getso.sumqty neq "">
              	<cfset soqty = getso.sumqty>
            </cfif>

          	<cfif getitem.qtybf neq "">
            	<cfset itembal = getitem.qtybf + lastitembal>
		  	<cfelse>
		    	<cfset itembal = lastitembal>
          	</cfif>

		  	<cfset balonhand = itembal + inqty - outqty - doqty>
          	<cfset poohso = poqty + balonhand - soqty>
          	<cfset iCount = iCount + 1>

          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#iCount#.&nbsp;</font></font></div></td>
          	<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.itemno#</font></font></div></td>
		  	<!--- <cfquery name="getSONO" datasource="#dts#">
          	select refno, brem1, qty_bil from ictran where type ='SO' and itemno
          	= '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          	<cfif periodfrom neq "" and periodto neq "">
            and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          	</cfif>
          	<cfif datefrom neq "" and dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
          	</cfquery> --->

		  	<cfquery name="getPONO" datasource="#dts#">
          		select refno, qty_bil, (price_bil-disamt_bil) as price_bil, (price - disamt)as price , amt_bil, amt, currrate, custno
          		from ictran where type ='PO' and itemno = '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          		<cfif periodfrom neq "" and periodto neq "">
            	and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          		</cfif>
          		<cfif datefrom neq "" and dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
		   		order by trdatetime desc
          	</cfquery>
          	<!--- <cfset iPOQTY = 0>
          	<cfloop query="getPONO">
            <cfset iPOQTY = iPOQTY + getPONO.qty_bil>
          	</cfloop>
          	<cfset iSOQTY = 0>
          	<cfloop query="getSONO">
            <cfset iSOQTY = iSOQTY + getSONO.qty_bil>
          	</cfloop> --->
		  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#balonhand#</font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=PO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #POqty#</a></font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=SO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #SOqty#</a></font></font></div></td>
          	<!--- <cfset Bal = #balonhand# + #poqty# - #soqty#> --->
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#poohso#</font></font></div></td>

			<cfquery name="getCurrCode2" datasource="#dts#">
          		select currcode from supplier where customerno ='#getPONO.custno#'
          	</cfquery>

			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price_bil,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt_bil,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.currrate,'____.____')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getitem.price3,stDecl_UPrice)#</font></div></td>
        </tr>
        <tr>
          	<td>&nbsp;</td>
          	<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.desp#</font></font></div></td>
        </tr>
		</cfoutput>

        <cfset maxArray = right(CurrArray2[1][1],1)>

        <cfloop index = "i" from = "1" to = "#maxArray#">
          	<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getPONO.amt>
          	</cfif>
          	<!---<cfif CurrArray1[i+1][1] eq #getcurrcode2.currcode#>
            <cfset CurrArray1[i+1][2] = #CurrArray1[i+1][2]# + #getPONO.amt_bil#>
            <cfset CurrArray1[i+1][3] = #CurrArray1[i+1][3]# + #getPONO.amt#>
          	</cfif> --->
          	<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getPONO.amt>
          	</cfif>
          	<cfset i = i + 1>
        </cfloop>
	</cfloop>
</cfif>
<!---
Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating
Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating
Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating
Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating
Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating	Rating
--->
<cfif rgSort eq "Rating">
	<cfset stLastNo = "">

	<cfloop query = "getitem">
		<cfif stLastNo neq CostCode and stLastNo neq "">
			<tr>
            	<td colspan="15"><hr></td>
          	</tr>
          	<!--- Print the sub-total --->
          	<cfset maxArray = right(CurrArray[1][1],1)>
          	<cfset DisplayTotal = 0>

		  	<cfloop index = "i" from = "1" to = "#maxArray#">
            	<cfif CurrArray[i+1][2] neq 0>
			  		<cfoutput>
              		<tr>
                		<td colspan="3" valign="top" nowrap>&nbsp;</td>
                		<cfif DisplayTotal eq 0>
                  			<td colspan="5"><div align="right"><strong>Sub Total</strong></div></td>
                  			<cfset DisplayTotal = 1>
                  		<cfelse>
                  			<td colspan="5">&nbsp;</td>
                		</cfif>
                		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
               	 		<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.__')#</font></div></td>
                		<td>&nbsp;</td>
              		</tr>
			  		</cfoutput>

			  		<cfset SGDEquit = SGDEquit + CurrArray[i+1][3]>
              		<!--- Clear the sub total --->
              		<cfset CurrArray[i+1][2] = 0>
              		<cfset CurrArray[i+1][3] = 0>
            	</cfif>
            	<cfset i = i + 1>
          	</cfloop>
          	<!--- Print SGD Equivalent --->
          	<cfoutput>
		  	<tr>
            	<td colspan="3" valign="top" nowrap>&nbsp;</td>
            	<td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
            	<td colspan="3">&nbsp;</td>
            	<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(SGDEquit,',_.__')#</font></div></td>
            	<td>&nbsp;</td>
            	<cfset SGDEquit = 0>
            	<cfset iCount = 0>
          	</tr>
		  	</cfoutput>
          	<tr>
            	<td colspan="15" valign="top" nowrap>&nbsp;</td>
          	</tr>
        </cfif>

		<cfif stLastNO neq CostCode or stLastNO eq "">
			<cfquery name="getcostdesp" datasource="#dts#">
				select desp from iccostcode where costcode = '#CostCode#'
			</cfquery>
			<cfoutput>
			<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td colspan="2"><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><strong>#form.rgsort#:</strong></font></font></div></td>
            	<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>&nbsp;<!---#CostCode#--->#getcostdesp.desp#</strong></font></font></div></td>
            	<td colspan="10">&nbsp;</td>
          	</tr>
			</cfoutput>
        </cfif>

        <cfset stLastNo = CostCode>
        <!--- Print details --->
        <cfoutput>
		<tr>
			<cfset lastitembal = 0>

			<cfif periodfrom neq "" and periodto neq "" and periodfrom neq '01'>
				<cfset lastitembal = 0>
			 	<cfset lastinqty = 0>
			 	<cfset lastoutqty = 0>
			 	<cfset lastdoqty = 0>

			 	<cfquery name="getlastin" datasource="#dts#">
					select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
				  	and itemno = '#itemno#' and (void = '' or void is null)
				  	and fperiod  < '#form.periodfrom#'
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
				  	</cfif>
				</cfquery>

				<cfif getlastin.sumqty neq "">
				  	<cfset lastinqty = getlastin.sumqty>
				</cfif>

				<cfquery name="getlastout" datasource="#dts#">
					select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
					or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
					</cfif>
				</cfquery>

				<cfif getlastout.sumqty neq "">
			  		<cfset lastoutqty = getlastout.sumqty>
				</cfif>

		  		<cfquery name="getlastdo" datasource="#dts#">
					select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
					and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
				  	</cfif>
		  		</cfquery>

				<cfif getlastdo.sumqty neq "">
			  		<cfset lastDOqty = getlastdo.sumqty>
				</cfif>
				<cfset lastitembal = lastinqty - lastoutqty - lastdoqty>
			</cfif>

			<cfset itembal = 0>
          	<cfset inqty = 0>
          	<cfset outqty = 0>
          	<cfset doqty = 0>
          	<cfset poqty = 0>
          	<cfset soqty = 0>

          	<cfquery name="getin" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
			  	and itemno = '#itemno#' and (void = '' or void is null)
			  	<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			  	</cfif>
			  	<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			  	<cfelse>
				and wos_date > #getgeneral.lastaccyear#
			  	</cfif>
          	</cfquery>

            <cfif getin.sumqty neq "">
				<cfset inqty = getin.sumqty>
            </cfif>

          	<cfquery name="getout" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
		  		or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getout.sumqty neq "">
              	<cfset outqty = getout.sumqty>
            </cfif>

          	<cfquery name="getdo" datasource="#dts#">
         	 	select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
          		and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getdo.sumqty neq "">
              	<cfset DOqty = getdo.sumqty>
            </cfif>

          	<cfquery name="getpo" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "PO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getpo.sumqty neq "">
              	<cfset poqty = getpo.sumqty>
            </cfif>

          	<cfquery name="getso" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "SO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getso.sumqty neq "">
              	<cfset soqty = getso.sumqty>
            </cfif>

          	<cfif getitem.qtybf neq "">
            	<cfset itembal = getitem.qtybf + lastitembal>
		  	<cfelse>
		    	<cfset itembal = lastitembal>
          	</cfif>

		  	<cfset balonhand = itembal + inqty - outqty - doqty>
          	<cfset poohso = poqty + balonhand - soqty>
          	<cfset iCount = iCount + 1>

		  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#iCount#.&nbsp;</font></font></div></td>
          	<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.itemno#</font></font></div></td>
          	<!--- <cfquery name="getSONO" datasource="#dts#">
          	select refno, brem1, qty_bil from ictran where type ='SO' and itemno
          	= '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          	<cfif periodfrom neq "" and periodto neq "">
            and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          	</cfif>
          	<cfif datefrom neq "" and dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
          	</cfquery> --->
          	<cfquery name="getPONo" datasource="#dts#">
          		select refno, qty_bil, (price_bil-disamt_bil) as price_bil, (price - disamt)as price , amt_bil, amt, currrate, custno
          		from ictran where type ='PO' and itemno = '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          		<cfif periodfrom neq "" and periodto neq "">
            	and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          		</cfif>
          		<cfif datefrom neq "" and dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
		  		order by trdatetime desc
          	</cfquery>
          	<!--- <cfset iPOQTY = 0>
          	<cfloop query="getPONO">
            <cfset iPOQTY = iPOQTY + getPONO.qty_bil>
          	</cfloop>
          	<cfset iSOQTY = 0>
          	<cfloop query="getSONO">
            <cfset iSOQTY = iSOQTY + getSONO.qty_bil>
          	</cfloop> --->
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#balonhand#</font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=PO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #POqty#</a></font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=SO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #SOqty#</a></font></font></div></td>
          	<!--- <cfset Bal = #balonhand# + #poqty# - #soqty#> --->
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#poohso#</font></font></div></td>

			<cfquery name="getCurrCode2" datasource="#dts#">
          		select currcode from supplier where customerno ='#getPONO.custno#'
          	</cfquery>

			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price_bil,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt_bil,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.currrate,'____.____')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getitem.price3,stDecl_UPrice)#</font></div></td>
        </tr>
        <tr>
          	<td>&nbsp;</td>
          	<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.desp#</font></font></div></td>
        </tr>
		</cfoutput>

		<cfset maxArray = right(CurrArray2[1][1],1)>

		<cfloop index = "i" from = "1" to = "#maxArray#">
			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getPONO.amt>
          	</cfif>
          	<!---<cfif CurrArray1[i+1][1] eq #getcurrcode2.currcode#>
            <cfset CurrArray1[i+1][2] = #CurrArray1[i+1][2]# + #getPONO.amt_bil#>
            <cfset CurrArray1[i+1][3] = #CurrArray1[i+1][3]# + #getPONO.amt#>
          	</cfif> --->
          	<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getPONO.amt>
          	</cfif>
          	<cfset i = i + 1>
        </cfloop>
	</cfloop>
</cfif>
<!---
Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material
Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material
Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material
Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material
Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material
Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material	Material
--->
<cfif rgSort eq "Material">
	<cfset stLastNo = "">

	<cfloop query = "getitem">
		<cfif stLastNo neq ColorID and stLastNo neq "">
			<tr>
            	<td colspan="15"><hr></td>
          	</tr>
          	<!---Print the sub-total --->
          	<cfset maxArray = right(CurrArray[1][1],1)>
          	<cfset DisplayTotal = 0>

			<cfloop index = "i" from = "1" to = "#maxArray#">
            	<cfif CurrArray[i+1][2] neq 0>
             		<cfoutput>
			  		<tr>
                		<td colspan="3" valign="top" nowrap>&nbsp;</td>
                		<cfif DisplayTotal eq 0>
                  			<td colspan="5"><div align="right"><strong>Sub Total</strong></div></td>
                  			<cfset DisplayTotal = 1>
                  		<cfelse>
                  			<td colspan="5">&nbsp;</td>
                		</cfif>
                		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                		<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.__')#</font></div></td>
                		<td>&nbsp;</td>
              		</tr>
			  		</cfoutput>

					<cfset SGDEquit = SGDEquit + CurrArray[i+1][3]>
              		<!--- Clear the sub total --->
              		<cfset CurrArray[i+1][2] = 0>
              		<cfset CurrArray[i+1][3] = 0>
            	</cfif>
            <cfset i = i + 1>
		</cfloop>
		<!--- Print SGD Equivalent --->
		<cfoutput>
		<tr>
			<td colspan="3" valign="top" nowrap>&nbsp;</td>
            <td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
            <td colspan="3">&nbsp;</td>
            <td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(SGDEquit,',_.__')#</font></div></td>
            <td>&nbsp;</td>
            <cfset SGDEquit = 0>
            <cfset iCount = 0>
		</tr>
        <tr>
            <td colspan="15" valign="top" nowrap>&nbsp;</td>
        </tr>
		</cfoutput>
	</cfif>

	<cfoutput>
        <cfif stLastNO neq ColorID or stLastNO eq "">
			<cfquery name="getcolordesp" datasource="#dts#">
				select desp from iccolorid where colorid = '#ColorID#'
			</cfquery>
			<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td colspan="2"><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><strong>#form.rgsort#:</strong></font></font></div></td>
            	<td colspan="2" nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>&nbsp;<!---#ColorID#--->#getcolordesp.desp#</strong></font></font></div></td>
            	<td colspan="10">&nbsp;</td>
          	</tr>
        </cfif>

		<cfset stLastNo = ColorID>
        <!--- Print details --->
        <tr>
			<cfset lastitembal = 0>

			<cfif periodfrom neq "" and periodto neq "" and periodfrom neq '01'>
				<cfset lastitembal = 0>
			 	<cfset lastinqty = 0>
			 	<cfset lastoutqty = 0>
			 	<cfset lastdoqty = 0>

			 	<cfquery name="getlastin" datasource="#dts#">
					select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
				  	and itemno = '#itemno#' and (void = '' or void is null)
				  	and fperiod  < '#form.periodfrom#'
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
				  	</cfif>
				</cfquery>

				<cfif getlastin.sumqty neq "">
				  	<cfset lastinqty = getlastin.sumqty>
				</cfif>

				<cfquery name="getlastout" datasource="#dts#">
					select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
					or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
					</cfif>
				</cfquery>

				<cfif getlastout.sumqty neq "">
			  		<cfset lastoutqty = getlastout.sumqty>
				</cfif>

		  		<cfquery name="getlastdo" datasource="#dts#">
					select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
					and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
		  			<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
		  			</cfif>
		  		</cfquery>

				<cfif getlastdo.sumqty neq "">
			  		<cfset lastDOqty = getlastdo.sumqty>
				</cfif>

				<cfset lastitembal = lastinqty - lastoutqty - lastdoqty>
			</cfif>

			<cfset itembal = 0>
          	<cfset inqty = 0>
          	<cfset outqty = 0>
          	<cfset doqty = 0>
          	<cfset poqty = 0>
          	<cfset soqty = 0>

          	<cfquery name="getin" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
		  		and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
           	 	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getin.sumqty neq "">
              	<cfset inqty = getin.sumqty>
            </cfif>

			<cfquery name="getout" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
		  		or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getout.sumqty neq "">
              	<cfset outqty = getout.sumqty>
            </cfif>

			<cfquery name="getdo" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
          		and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getdo.sumqty neq "">
              	<cfset DOqty = getdo.sumqty>
            </cfif>

          	<cfquery name="getpo" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "PO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getpo.sumqty neq "">
              	<cfset poqty = getpo.sumqty>
            </cfif>

          	<cfquery name="getso" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "SO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getso.sumqty neq "">
              	<cfset soqty = getso.sumqty>
            </cfif>

          	<cfif getitem.qtybf neq "">
            	<cfset itembal = getitem.qtybf + lastitembal>
		  	<cfelse>
		    	<cfset itembal = lastitembal>
          	</cfif>

			<cfset balonhand = itembal + inqty - outqty - doqty>
          	<cfset poohso = poqty + balonhand - soqty>
          	<cfset iCount = iCount + 1>

			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#iCount#.&nbsp;</font></font></div></td>
          	<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.itemno#</font></font></div></td>
          	<!--- <cfquery name="getSONO" datasource="#dts#">
          	select refno, brem1, qty_bil from ictran where type ='SO' and itemno
          	= '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          	<cfif periodfrom neq "" and periodto neq "">
            and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          	</cfif>
          	<cfif datefrom neq "" and dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
          	</cfquery> --->

		  	<cfquery name="getPONo" datasource="#dts#">
          		select refno, qty_bil, (price_bil-disamt_bil) as price_bil, (price - disamt)as price , amt_bil, amt, currrate, custno
          		from ictran where type ='PO' and itemno = '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          		<cfif periodfrom neq "" and periodto neq "">
            	and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          		</cfif>
          		<cfif datefrom neq "" and dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
		  		order by trdatetime desc
          	</cfquery>
          	<!--- <cfset iPOQTY = 0>
          	<cfloop query="getPONO">
            <cfset iPOQTY = iPOQTY + getPONO.qty_bil>
          	</cfloop>
          	<cfset iSOQTY = 0>
          	<cfloop query="getSONO">
            <cfset iSOQTY = iSOQTY + getSONO.qty_bil>
          	</cfloop> --->
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#balonhand#</font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=PO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #POqty#</a></font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=SO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #SOqty#</a></font></font></div></td>
          	<!--- <cfset Bal = #balonhand# + #poqty# - #soqty#> --->
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#poohso#</font></font></div></td>

			<cfquery name="getCurrCode2" datasource="#dts#">
          		select currcode from supplier where customerno ='#getPONO.custno#'
          	</cfquery>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price_bil,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt_bil,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.currrate,'____.____')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getitem.price3,stDecl_UPrice)#</font></div></td>
        </tr>
        <tr>
          	<td>&nbsp;</td>
          	<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.desp#</font></font></div></td>
        </tr>
		</cfoutput>

		<cfset maxArray = right(CurrArray2[1][1],1)>

		<cfloop index = "i" from = "1" to = "#maxArray#">
			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getPONO.amt>
          	</cfif>
          	<!---<cfif CurrArray1[i+1][1] eq #getcurrcode2.currcode#>
            <cfset CurrArray1[i+1][2] = #CurrArray1[i+1][2]# + #getPONO.amt_bil#>
            <cfset CurrArray1[i+1][3] = #CurrArray1[i+1][3]# + #getPONO.amt#>
          	</cfif> --->
          	<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getPONO.amt>
          	</cfif>
          	<cfset i = i + 1>
        </cfloop>
	</cfloop>
</cfif>
<!---
Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer
Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer
Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer
Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer
Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer
Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer	Manufacturer
--->
<cfif rgSort eq "Manufacturer">
	<cfset stLastNo = "">

	<cfloop query = "getitem">
		<cfif stLastNo neq wos_group and stLastNo neq "">
			<tr>
            	<td colspan="15"><hr></td>
          	</tr>
          	<!--- Print the sub-total --->
          	<cfset maxArray = right(CurrArray[1][1],1)>
          	<cfset DisplayTotal = 0>

		  	<cfloop index = "i" from = "1" to = "#maxArray#">
            	<cfif CurrArray[i+1][2] neq 0>
              		<cfoutput>
			  		<tr>
                		<td colspan="3" valign="top" nowrap>&nbsp;</td>
                		<cfif DisplayTotal eq 0>
                  			<td colspan="5"><div align="right"><strong>Sub Total</strong></div></td>
                  			<cfset DisplayTotal = 1>
                  		<cfelse>
                  			<td colspan="5">&nbsp;</td>
                		</cfif>
                		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                		<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.__')#</font></div></td>
                		<td>&nbsp;</td>
              		</tr>
			  		</cfoutput>

              		<cfset SGDEquit = SGDEquit + CurrArray[i+1][3]>
              		<!--- Clear the sub total --->
              		<cfset CurrArray[i+1][2] = 0>
              		<cfset CurrArray[i+1][3] = 0>
            	</cfif>
            	<cfset i = i + 1>
			</cfloop>
          	<!--- Print SGD Equivalent --->
          	<cfoutput>
		  	<tr>
            	<td colspan="3" valign="top" nowrap>&nbsp;</td>
            	<td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
            	<td colspan="3">&nbsp;</td>
            	<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(SGDEquit,',_.__')#</font></div></td>
            	<td>&nbsp;</td>
            	<cfset SGDEquit = 0>
            	<cfset iCount = 0>
          	</tr>
          	<tr>
            	<td colspan="15" valign="top" nowrap>&nbsp;</td>
          	</tr>
		  	</cfoutput>
        </cfif>

		<cfoutput>
        	<cfif stLastNO neq wos_group or stLastNO eq "">
				<cfquery name="getgroupdesp" datasource="#dts#">
					select desp from icgroup where wos_group = '#wos_group#'
				</cfquery>
		  		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
            		<td colspan="2"><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><strong>#form.rgsort#:</strong></font></font></div></td>
            		<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>&nbsp;<!---#wos_group#--->#getgroupdesp.desp#</strong></font></font></div></td>
            		<td colspan="10">&nbsp;</td>
         	 	</tr>
        	</cfif>

			<cfset stLastNo = wos_group>
        	<!--- Print details --->
        	<tr>
          		<cfset lastitembal = 0>

		  		<cfif periodfrom neq "" and periodto neq "" and periodfrom neq '01'>
			 		<cfset lastitembal = 0>
			 		<cfset lastinqty = 0>
			 		<cfset lastoutqty = 0>
			 		<cfset lastdoqty = 0>

			 		<cfquery name="getlastin" datasource="#dts#">
				  		select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
				  		and itemno = '#itemno#' and (void = '' or void is null)
				  		and fperiod  < '#form.periodfrom#'
				  		<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#'
				  		</cfif>
					</cfquery>

					<cfif getlastin.sumqty neq "">
				  		<cfset lastinqty = getlastin.sumqty>
					</cfif>

					<cfquery name="getlastout" datasource="#dts#">
						select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
						or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
						and fperiod < '#form.periodfrom#'
						<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#'
						</cfif>
					</cfquery>

					<cfif getlastout.sumqty neq "">
			  			<cfset lastoutqty = getlastout.sumqty>
					</cfif>

		  			<cfquery name="getlastdo" datasource="#dts#">
						select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
						and itemno = '#itemno#' and (void = '' or void is null)
						and fperiod < '#form.periodfrom#'
					  	<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date < '#ndatefrom#'
					  	</cfif>
		  			</cfquery>

					<cfif getlastdo.sumqty neq "">
			  			<cfset lastDOqty = getlastdo.sumqty>
					</cfif>

					<cfset lastitembal = lastinqty - lastoutqty - lastdoqty>
				</cfif>

				<cfset itembal = 0>
			  	<cfset inqty = 0>
			  	<cfset outqty = 0>
			  	<cfset doqty = 0>
			  	<cfset poqty = 0>
			  	<cfset soqty = 0>

          		<cfquery name="getin" datasource="#dts#">
          			select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
		  			and itemno = '#itemno#' and (void = '' or void is null)
          			<cfif form.periodfrom neq "" and form.periodto neq "">
            		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          			</cfif>
          			<cfif form.datefrom neq "" and form.dateto neq "">
            		and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  			<cfelse>
		    		and wos_date > #getgeneral.lastaccyear#
          			</cfif>
          		</cfquery>

            	<cfif getin.sumqty neq "">
              		<cfset inqty = getin.sumqty>
            	</cfif>

          		<cfquery name="getout" datasource="#dts#">
          			select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
		  			or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
          			<cfif form.periodfrom neq "" and form.periodto neq "">
            		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				  	</cfif>
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				 	 <cfelse>
					and wos_date > #getgeneral.lastaccyear#
				  	</cfif>
          		</cfquery>

            	<cfif getout.sumqty neq "">
              		<cfset outqty = getout.sumqty>
            	</cfif>

          		<cfquery name="getdo" datasource="#dts#">
          			select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
				  	and itemno = '#itemno#' and (void = '' or void is null)
				  	<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				  	</cfif>
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				  	<cfelse>
					and wos_date > #getgeneral.lastaccyear#
				  	</cfif>
          		</cfquery>

            	<cfif getdo.sumqty neq "">
              		<cfset DOqty = getdo.sumqty>
            	</cfif>

          		<cfquery name="getpo" datasource="#dts#">
					select sum(qty - shipped)as sumqty from ictran where type = "PO" and itemno =
				  	'#itemno#' and (void = '' or void is null)
				  	<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				 	</cfif>
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				 	<cfelse>
					and wos_date > #getgeneral.lastaccyear#
				  	</cfif>
          		</cfquery>

            	<cfif getpo.sumqty neq "">
              		<cfset poqty = getpo.sumqty>
            	</cfif>

          		<cfquery name="getso" datasource="#dts#">
          			select sum(qty - shipped)as sumqty from ictran where type = "SO" and itemno =
          			'#itemno#' and (void = '' or void is null)
          			<cfif form.periodfrom neq "" and form.periodto neq "">
            		and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          			</cfif>
          			<cfif form.datefrom neq "" and form.dateto neq "">
            		and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  			<cfelse>
		    		and wos_date > #getgeneral.lastaccyear#
          			</cfif>
          		</cfquery>

            	<cfif getso.sumqty neq "">
              		<cfset soqty = getso.sumqty>
            	</cfif>

          		<cfif getitem.qtybf neq "">
            		<cfset itembal = getitem.qtybf + lastitembal>
		  		<cfelse>
		    		<cfset itembal = lastitembal>
          		</cfif>

		  		<cfset balonhand = itembal + inqty - outqty - doqty>
          		<cfset poohso = poqty + balonhand - soqty>
          		<cfset iCount = iCount + 1>

		  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#iCount#.&nbsp;</font></font></div></td>
          		<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.itemno#</font></font></div></td>
          		<!--- <cfquery name="getSONO" datasource="#dts#">
          		select refno, brem1, qty_bil from ictran where type ='SO' and itemno
          		= '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          		<cfif periodfrom neq "" and periodto neq "">
            	and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          		</cfif>
          		<cfif datefrom neq "" and dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          		</cfquery> --->

				<cfquery name="getPONo" datasource="#dts#">
          			select refno, qty_bil, (price_bil-disamt_bil) as price_bil, (price - disamt)as price , amt_bil, amt, currrate, custno
				  	from ictran where type ='PO' and itemno = '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
				  	<cfif periodfrom neq "" and periodto neq "">
					and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
				  	</cfif>
				  	<cfif datefrom neq "" and dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
				  	</cfif>
				  	order by trdatetime desc
          		</cfquery>
			  	<!--- <cfset iPOQTY = 0>
			  	<cfloop query="getPONO">
				<cfset iPOQTY = iPOQTY + getPONO.qty_bil>
			  	</cfloop>
			  	<cfset iSOQTY = 0>
			  	<cfloop query="getSONO">
				<cfset iSOQTY = iSOQTY + getSONO.qty_bil>
			  	</cfloop> --->
          		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#balonhand#</font></font></div></td>
          		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    	<a href="Forecast_POSO.cfm?type=PO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    	#POqty#</a></font></font></div></td>
          		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    	<a href="Forecast_POSO.cfm?type=SO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    	#SOqty#</a></font></font></div></td>
          		<!--- <cfset Bal = #balonhand# + #poqty# - #soqty#> --->
          		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#poohso#</font></font></div></td>

		  		<cfquery name="getCurrCode2" datasource="#dts#">
          			select currcode from supplier where customerno ='#getPONO.custno#'
          		</cfquery>

		  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price_bil,stDecl_UPrice)#</font></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt_bil,',_.__')#</font></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.currrate,'____.____')#</font></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price,stDecl_UPrice)#</font></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt,',_.__')#</font></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getitem.price3,stDecl_UPrice)#</font></div></td>
        	</tr>
        	<tr>
          		<td>&nbsp;</td>
          		<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.desp#</font></font></div></td>
        	</tr>
		</cfoutput>

		<cfset maxArray = right(CurrArray2[1][1],1)>

		<cfloop index = "i" from = "1" to = "#maxArray#">
			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getPONO.amt>
          	</cfif>
          	<!---<cfif CurrArray1[i+1][1] eq #getcurrcode2.currcode#>
            <cfset CurrArray1[i+1][2] = #CurrArray1[i+1][2]# + #getPONO.amt_bil#>
            <cfset CurrArray1[i+1][3] = #CurrArray1[i+1][3]# + #getPONO.amt#>
          	</cfif> --->
          	<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getPONO.amt>
          	</cfif>
          	<cfset i = #i# + 1>
    	</cfloop>
	</cfloop>
</cfif>
<!---
Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model
Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model
Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model
Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model
Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model
Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model	Model
--->
<cfif rgSort eq "Model">
	<cfset stLastNo = "">

	<cfloop query = "getitem">
		<cfif stLastNo neq shelf and stLastNo neq "">
			<tr>
            	<td colspan="15"><hr></td>
          	</tr>
          	<!--- Print the sub-total --->
          	<cfset maxArray = right(CurrArray[1][1],1)>
          	<cfset DisplayTotal = 0>

			<cfloop index = "i" from = "1" to = "#maxArray#">
            	<cfif CurrArray[i+1][2] neq 0>
              		<cfoutput>
			  		<tr>
                		<td colspan="3" valign="top" nowrap>&nbsp;</td>
                		<cfif DisplayTotal eq 0>
                  			<td colspan="5"><div align="right"><strong>Sub Total</strong></div></td>
                  			<cfset DisplayTotal = 1>
                  		<cfelse>
                  			<td colspan="5">&nbsp;</td>
                		</cfif>
                		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                		<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.__')#</font></div></td>
                		<td>&nbsp;</td>
              		</tr>
			  		</cfoutput>

					<cfset SGDEquit = SGDEquit + CurrArray[i+1][3]>
              		<!--- Clear the sub total --->
              		<cfset CurrArray[i+1][2] = 0>
              		<cfset CurrArray[i+1][3] = 0>
            	</cfif>
            	<cfset i = i + 1>
			</cfloop>
          	<!--- Print SGD Equivalent --->
          	<cfoutput>
		  	<tr>
            	<td colspan="3" valign="top" nowrap>&nbsp;</td>
            	<td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
            	<td colspan="3">&nbsp;</td>
            	<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(SGDEquit,',_.__')#</font></div></td>
            	<td>&nbsp;</td>
            	<cfset SGDEquit = 0>
            	<cfset iCount = 0>
          	</tr>
          	<tr>
            	<td colspan="15" valign="top" nowrap>&nbsp;</td>
          	</tr>
		  	</cfoutput>
        </cfif>

		<cfoutput>
        	<cfif stLastNO neq shelf or stLastNO eq "">
				<cfquery name="getshelfdesp" datasource="#dts#">
					select desp from icshelf where shelf = '#shelf#'
				</cfquery>
          		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
            		<td colspan="2"><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><strong>#form.rgsort#:</strong></font></font></div></td>
            		<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>&nbsp;<!---#wos_group#--->#getshelfdesp.desp#</strong></font></font></div></td>
            		<td colspan="10">&nbsp;</td>
          		</tr>
        	</cfif>

			<cfset stLastNo = shelf>
        	<!--- Print details --->
        	<tr>
          	<cfset lastitembal = 0>

		  	<cfif periodfrom neq "" and periodto neq "" and periodfrom neq '01'>
				<cfset lastitembal = 0>
			 	<cfset lastinqty = 0>
			 	<cfset lastoutqty = 0>
			 	<cfset lastdoqty = 0>

				<cfquery name="getlastin" datasource="#dts#">
				  	select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
				  	and itemno = '#itemno#' and (void = '' or void is null)
				  	and fperiod  < '#form.periodfrom#'
				  	<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
				  	</cfif>
				</cfquery>

				<cfif getlastin.sumqty neq "">
				  	<cfset lastinqty = getlastin.sumqty>
				</cfif>

				<cfquery name="getlastout" datasource="#dts#">
					select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
					or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
					</cfif>
				</cfquery>

				<cfif getlastout.sumqty neq "">
					<cfset lastoutqty = getlastout.sumqty>
				</cfif>

		  		<cfquery name="getlastdo" datasource="#dts#">
					select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
					and itemno = '#itemno#' and (void = '' or void is null)
					and fperiod < '#form.periodfrom#'
		  			<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#'
		  			</cfif>
		  		</cfquery>

				<cfif getlastdo.sumqty neq "">
			  		<cfset lastDOqty = getlastdo.sumqty>
				</cfif>
				<cfset lastitembal = lastinqty - lastoutqty - lastdoqty>
			</cfif>

		  	<cfset itembal = 0>
          	<cfset inqty = 0>
          	<cfset outqty = 0>
          	<cfset doqty = 0>
          	<cfset poqty = 0>
          	<cfset soqty = 0>

          	<cfquery name="getin" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type ="RC" or type = "CN" or type = "OAI" or type = "TRIN")
		  		and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getin.sumqty neq "">
              	<cfset inqty = getin.sumqty>
            </cfif>

          	<cfquery name="getout" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where (type = "PR" or type = "INV" or type = "DN" or type = "CS"
		  		or type = "OAR" or type = "ISS" or type = "TROU") and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getout.sumqty neq "">
              	<cfset outqty = getout.sumqty>
            </cfif>

          	<cfquery name="getdo" datasource="#dts#">
          		select sum(qty)as sumqty from ictran where type = "DO" and toinv = ""
          		and itemno = '#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getdo.sumqty neq "">
              	<cfset DOqty = getdo.sumqty>
            </cfif>

          	<cfquery name="getpo" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "PO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getpo.sumqty neq "">
              	<cfset poqty = getpo.sumqty>
            </cfif>

          	<cfquery name="getso" datasource="#dts#">
          		select sum(qty - shipped)as sumqty from ictran where type = "SO" and itemno =
          		'#itemno#' and (void = '' or void is null)
          		<cfif form.periodfrom neq "" and form.periodto neq "">
            	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
          		</cfif>
          		<cfif form.datefrom neq "" and form.dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  		<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
          	</cfquery>

            <cfif getso.sumqty neq "">
              	<cfset soqty = getso.sumqty>
            </cfif>

          	<cfif getitem.qtybf neq "">
            	<cfset itembal = getitem.qtybf + lastitembal>
		  	<cfelse>
		    	<cfset itembal = lastitembal>
          	</cfif>

		  	<cfset balonhand = itembal + inqty - outqty - doqty>
          	<cfset poohso = poqty + balonhand - soqty>
          	<cfset iCount = iCount + 1>

			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#iCount#.&nbsp;</font></font></div></td>
          	<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.itemno#</font></font></div></td>
          	<!--- <cfquery name="getSONO" datasource="#dts#">
          	select refno, brem1, qty_bil from ictran where type ='SO' and itemno
          	= '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          	<cfif periodfrom neq "" and periodto neq "">
            and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          	</cfif>
          	<cfif datefrom neq "" and dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
		  	<cfelse>
		    and wos_date > #getgeneral.lastaccyear#
          	</cfif>
          	</cfquery> --->
          	<cfquery name="getPONo" datasource="#dts#">
          		select refno, qty_bil, (price_bil-disamt_bil) as price_bil, (price - disamt)as price , amt_bil, amt, currrate, custno
          		from ictran where type ='PO' and itemno = '#getitem.itemno#' and shipped < qty and (void = '' or void is null)
          		<cfif periodfrom neq "" and periodto neq "">
            	and fperiod >= '#periodfrom#' and fperiod <= '#periodto#'
          		</cfif>
          		<cfif datefrom neq "" and dateto neq "">
            	and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
		    	and wos_date > #getgeneral.lastaccyear#
          		</cfif>
		  		order by trdatetime desc
          	</cfquery>
          	<!--- <cfset iPOQTY = 0>
          	<cfloop query="getPONO">
            <cfset iPOQTY = iPOQTY + getPONO.qty_bil>
          	</cfloop>
          	<cfset iSOQTY = 0>
          	<cfloop query="getSONO">
            <cfset iSOQTY = iSOQTY + getSONO.qty_bil>
          	</cfloop> --->
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#balonhand#</font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=PO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #POqty#</a></font></font></div></td>
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">
		    <a href="Forecast_POSO.cfm?type=SO&itemno=#getitem.itemno#&pef=#periodfrom#&pet=#periodto#&df=#ndatefrom#&dt=#ndateto#">
		    #SOqty#</a></font></font></div></td>
          	<!--- <cfset Bal = #balonhand# + #poqty# - #soqty#> --->
          	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#poohso#</font></font></div></td>

			<cfquery name="getCurrCode2" datasource="#dts#">
          		select currcode from supplier where customerno ='#getPONO.custno#'
          	</cfquery>

		  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price_bil,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt_bil,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.currrate,'____.____')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.price,stDecl_UPrice)#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getPONO.amt,',_.__')#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getitem.price3,stDecl_UPrice)#</font></div></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getitem.desp#</font></font></div></td>
        </tr>
		</cfoutput>

		<cfset maxArray = right(CurrArray2[1][1],1)>

		<cfloop index = "i" from = "1" to = "#maxArray#">
			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getPONO.amt>
          	</cfif>
          	<!---<cfif CurrArray1[i+1][1] eq #getcurrcode2.currcode#>
            <cfset CurrArray1[i+1][2] = #CurrArray1[i+1][2]# + #getPONO.amt_bil#>
            <cfset CurrArray1[i+1][3] = #CurrArray1[i+1][3]# + #getPONO.amt#>
          	</cfif> --->
          	<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
            	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getPONO.amt_bil>
            	<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getPONO.amt>
          	</cfif>
          	<cfset i = i + 1>
        </cfloop>
	</cfloop>
</cfif>
<tr>
	<td colspan="15"><hr></td>
</tr>
<!--- Print last sub-total --->
<cfset maxArray = right(CurrArray[1][1],1)>
<cfset DisplayTotal = 0>

<cfloop index = "i" from = "1" to = "#maxArray#">
	<cfif CurrArray[i+1][2] neq 0>
		<tr>
          	<td colspan="3" valign="top" nowrap>&nbsp;</td>
          	<cfif DisplayTotal eq 0>
            	<td colspan="5"><div align="right"><strong>Sub Total</strong></div></td>
            	<cfset DisplayTotal = 1>
            <cfelse>
            	<td colspan="5">&nbsp;</td>
          	</cfif>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][1]#</cfoutput></font></div></td>
          	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][2],',_.__')#</cfoutput></font></div></td>
          	<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][3],',_.__')#</cfoutput></font></div></td>
          	<td>&nbsp;</td>
        </tr>
        <cfset SGDEquit = SGDEquit + CurrArray[i+1][3]>
	</cfif>
</cfloop>
<!--- Print SGD Equivalent --->
<tr>
	<td colspan="3" valign="top" nowrap>&nbsp;</td>
    <td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
    <td colspan="3">&nbsp;</td>
    <td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(SGDEquit,',_.__')#</cfoutput></font></div></td>
    <td>&nbsp;</td>
</tr>
<tr>
	<td colspan="15"><hr></td>
</tr>

<!--- Print Grand Total (FC) --->
<cfset maxArray = right(CurrArray2[1][1],1)>
<cfset DisplayTotal = 0>

<cfloop index = "i" from = "1" to = "#maxArray#">
	<cfif CurrArray2[i+1][2] neq 0 or CurrArray2[i+1][1] eq "SGD">
		<tr>
          	<td  colspan="3" valign="top" nowrap>&nbsp;</td>
          	<cfif DisplayTotal eq 0>
            	<td colspan="5"><div align="right"><strong>Grand Total (FC)</strong></div></td>
            	<cfset DisplayTotal = 1>
            <cfelse>
            	<td colspan="5">&nbsp;</td>
          	</cfif>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][1]#</cfoutput></font></div></td>
          	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][2],',_.__')#</cfoutput></font></div></td>
          	<td>&nbsp;</td>
          	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][3],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          	<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          	<td>&nbsp;</td>
        </tr>
        <cfset GrandSGDEquit = GrandSGDEquit + CurrArray2[i+1][3]>
	</cfif>
	<cfset i = i + 1>
</cfloop>
	<tr>
		<td colspan="15"><hr></td>
	</tr>
	<tr>
    	<td colspan="3" valign="top" nowrap>&nbsp;</td>
    	<td colspan="5"><div align="right"><strong>SGD Equivalent</strong></div></td>
    	<td colspan="3">&nbsp;</td>
    	<td colspan="3"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(GrandSGDEquit,',_.__')#</cfoutput></font></div></td>
    	<td>&nbsp;</td>
	</tr>
</table>
<br><hr>
<div align="right">
<cfif husergrpid eq "Muser">
	<a href="../home2.cfm" class="noprint"><u><font size="1" face="Arial, Helvetica, sans-serif">Home</font></u></a>
</cfif>
<font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
<!---<input type="submit" name="Email" value="Email" class="noprint">--->
</div>
</body>
</html>