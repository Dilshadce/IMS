<cfif url.type eq "PO">
  <cfset prefix = "pocode">
</cfif>
<cfif url.type eq "SO">
  <cfset prefix = "socode">
</cfif>

<html>
<head>
<title>Forecast Report</title>
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
	select #prefix# as prefix, compro, compro2, compro3, compro4, compro5, compro6, compro7, lastaccyear from gsetup
</cfquery>

<!--- <cfif Email eq "Email">
  <cfquery name="getemail" datasource="#dts#">
	select e_mail from customer where customerno = '#getheaderinfo.custno#'
  </cfquery>
  <cfif getemail.e_mail eq "">
    <cfoutput>
	  <h4><font color="##FF0000">Please add in email address for customer - #getheaderinfo.custno#.</font></h4>
    </cfoutput>
	<cfabort>
  <cfelse>
	<cflocation url="invoiceemail.cfm?nexttranno=#nexttranno#&tran=#tran#&custemail=#getemail.e_mail#&tranname=#tranname#&prefix=#getgeneral.prefix#">
  </cfif>
</cfif> --->

<cfparam name="i" default="1" type="numeric">

<!--- <cfif isdefined("datefrom") and isdefined("form.dateto")>
  <cfset dd=#dateformat(datefrom, "DD")#>
  <cfif dd greater than '12'>
	<cfset ndatefrom=#dateformat(datefrom,"YYYYMMDD")#>
  <cfelse>
	<cfset ndatefrom=#dateformat(datefrom,"YYYYDDMM")#>
  </cfif>

  <cfset dd=#dateformat(form.dateto, "DD")#>
  <cfif dd greater than '12'>
	<cfset ndateto=#dateformat(form.dateto,"YYYYMMDD")#>
  <cfelse>
	<cfset ndateto=#dateformat(form.dateto,"YYYYDDMM")#>
  </cfif>
</cfif> --->

<!--- <cfquery name="getitem" datasource="#dts#">
  select a.itemno, a.desp, a.qtybf,a.price, a.unit, b.itemno as itemno_b from icitem a, ictran b where
  type = '#form.type#' and a.itemno=b.itemno

  <cfif productfrom neq "" and productto neq "">
	and a.itemno >= '#productfrom#' and a.itemno <= '#productto#'
  </cfif>
  <cfif catefrom neq "" and cateto neq "">
	and a.category >= '#catefrom#' and a.category <= '#cateto#'
  </cfif>
  <cfif sizeidfrom neq "" and sizeidto neq "">
	and a.sizeid >= '#sizeidfrom#' and a.sizeid <= '#sizeidto#'
  </cfif>
  <cfif costcodefrom neq "" and costcodeto neq "">
	and a.costcode >= '#costcodefrom#' and a.costcode <= '#costcodeto#'
  </cfif>
  <cfif coloridfrom neq "" and coloridto neq "">
	and a.colorid >= '#coloridfrom#' and a.colorid <= '#coloridto#'
  </cfif>
  <cfif shelffrom neq "" and shelfto neq "">
	and a.shelf >= '#shelffrom#' and a.shelf <= '#shelfto#'
  </cfif>
  <cfif groupfrom neq "" and groupto neq "">
	and a.wos_group >= '#groupfrom#' and a.wos_group <= '#groupto#'
  </cfif>
  <cfif periodfrom neq "" and periodto neq "">
	and b.fperiod >= '#periodfrom#' and b.fperiod <= '#periodto#'
  </cfif>
  <cfif datefrom neq "" and dateto neq "">
	and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
  </cfif>

  group by a.itemno

  <cfswitch expression="#form.rgSort#">
    <cfcase value="Valve Type">
	  order by a.category, a.itemno
	</cfcase>
	<cfcase value="Size">
	  order by a.sizeid, a.itemno
	</cfcase>
	<cfcase value="Rating">
	  order by a.costcode, a.itemno
	</cfcase>
	<cfcase value="Material">
	  order by a.colorid, a.itemno
	</cfcase>
 	<cfcase value="Manufacturer">
	  order by a.shelf, a.itemno
	</cfcase>
	<cfcase value="Model">
	  order by a.wos_group, a.itemno
	</cfcase>
  </cfswitch>
</cfquery> --->

<!--- <cfif datefrom neq "" and dateto neq "">
  <cfset dd=#dateformat(datefrom, "DD")#>
  <cfif dd greater than '12'>
	<cfset ndatefrom=#dateformat(datefrom,"YYYYMMDD")#>
  <cfelse>
	<cfset ndatefrom=#dateformat(datefrom,"YYYYDDMM")#>
  </cfif>

  <cfset dd=#dateformat(dateto, "DD")#>
  <cfif dd greater than '12'>
	<cfset ndateto=#dateformat(dateto,"YYYYMMDD")#>
  <cfelse>
	<cfset ndateto=#dateformat(dateto,"YYYYDDMM")#>
  </cfif>
</cfif> --->

<cfquery name="getItem" datasource="#dts#">
  	select a.refno, a.itemno, a.desp, a.wos_date, a.qty_bil, (a.price_bil-a.disamt_bil) as price_bil, (a.price-a.disamt)as price,
	a.amt_bil, a.amt, a.currrate, a.custno,<cfif url.type eq 'PO'>b.rem7 as rem7<cfelse>b.rem8 as rem7</cfif>
  	from ictran a, artran b where a.type ='#url.type#' and a.itemno = '#url.itemno#' and (a.void = '' or a.void is null) and a.refno=b.refno
  	<cfif url.pef neq "" and url.pet neq "">
    and a.fperiod >= '#url.pef#' and a.fperiod <= '#pet#'
  	</cfif>
  	<cfif url.df neq "" and url.dt neq "">
    and a.wos_date >= '#url.df#' and a.wos_date <= '#url.dt#'
 	<cfelse>
  	and a.wos_date > #getgeneral.lastaccyear#
  	</cfif>
  	order by a.refno, a.itemno
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
<cfform name="form1" action="">
  	<cfif getitem.itemno eq "">
    	<cfoutput><h4><font color="##FF0000">No Report Generated.</font></h4></cfoutput>
		<cfabort>
  	</cfif>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<cfoutput query="getgeneral">
	<tr>
		<td colspan="3"><div align="center"><font size="4" face="Times New Roman, Times, serif"><strong><cfif getgeneral.compro neq ''>#compro#</cfif></strong></font> <br>
          <font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro2 neq ''>#compro2#<br></cfif></font>
          <font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro3 neq ''>#compro3#<br></cfif></font>
          <font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro4 neq ''>#compro4#<br></cfif></font>
          <font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro5 neq ''>#compro5#<br></cfif></font>
          <font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro6 neq ''>#compro6#<br></cfif></font>
          <font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro7 neq ''>#compro7#</cfif></font> </div>
        </td>
	</tr>
    </cfoutput>

	<tr>
      	<td><font size="2" face="Times New Roman, Times, serif"><strong>Forecast Report (<cfoutput>#url.type#</cfoutput>)</strong></font></td>
      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Date : <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
	</tr>

   	<tr>
      	<td colspan="9"><hr></td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
      	<td colspan="4" nowrap><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td colspan="3"><div align="center"><font size="2" face="Times New Roman, Times, serif"><strong>Foreign Currency</strong></font></div></td>
      	<td colspan="2"><div align="center"><font size="2" face="Times New Roman, Times, serif"><strong>SGD Equialent</strong></font></div></td>
    </tr>
    <tr>
      	<td width="3%" nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>&nbsp;</strong></font></div></td>
      	<td width="15%" nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Item No. / Item Descriptions</strong></font></div></td>
      	<td width="4%"><div align="right"><p><font size="2" face="Times New Roman, Times, serif"><strong>Qty</strong></font></p></div></td>
      	<td width="5%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Currcy</strong></font></div></td>
      	<td width="6%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Unit Price</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
      	<td width="5%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Exchg Rate</strong></font></div></td>
      	<td width="6%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Unit Price</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="9"><hr></td>
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
Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body
Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body
Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body
Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body
Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body
Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body
--->
    <cfset stLastNo = "">

    <cfloop query = "getitem">
      	<cfif stLastNo neq refno and stLastNo neq "">
        <tr>
          	<td colspan="9"><hr></td>
        </tr>

	    <!--- Print the sub-total --->
        <cfset maxArray = right(CurrArray[1][1],1)>
        <cfset DisplayTotal = 0>

		<cfloop index = "i" from = "1" to = "#maxArray#">
          	<cfif CurrArray[i+1][2] neq 0>
            	<tr>
              		<td valign="top" nowrap>&nbsp;</td>
              		<cfif DisplayTotal eq 0>
                		<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                		<cfset DisplayTotal = 1>
              		<cfelse>
                		<td colspan="2">&nbsp;</td>
              		</cfif>
				<cfoutput>
              		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
              		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
              		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.__')#</font></div></td>
            	</tr>
				</cfoutput>
	        	<!--- Clear the sub total --->
            	<cfset CurrArray[i+1][2] = 0>
            	<cfset CurrArray[i+1][3] = 0>
          	</cfif>
          	<cfset i = i + 1>
        </cfloop>

        <tr>
          	<td colspan="9" valign="top" nowrap>&nbsp;</td>
        </tr>
      	</cfif>

      	<cfif stLastNO neq refno or stLastNO eq "">
	  		<cfoutput>
			<tr>
          		<td>&nbsp;</td>
          		<td><font face="Times New Roman, Times, serif"><font size="2"><strong>#getgeneral.prefix##getitem.refno#</strong></font></font></td>
          		<td><font face="Times New Roman, Times, serif"><font size="2"><strong>#dateformat(getItem.wos_date,"dd/mm/yy")#</strong></font></font></td>
          		<cfquery name="getSOCode" datasource="#dts#">
              		<cfif url.type eq 'SO'>
						select socode from gsetup
					<cfelse>
						select pocode as socode from gsetup
					</cfif>
              	</cfquery>
				<td><font face="Times New Roman, Times, serif"><font size="2"><strong>#getSOCode.socode##getitem.rem7#</strong></font></font></td>
				<td colspan="4"></td>
        	</tr>
			</cfoutput>
			<cfset iCount = 0>
      	</cfif>

      	<cfset stLastNo = refno>
      	<!--- Print details --->
	  	<cfoutput>
      	<tr>
        	<cfset iCount = iCount + 1>
        	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#iCount#.&nbsp;</font></font></div></td>
        	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="2">#getitem.itemno#</font></font></div></td>
			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#getitem.qty_bil#</font></font></div></td>

        	<cfquery name="getCurrCode2" datasource="#dts#">
		  		<cfif url.type eq "PO">
		    		select currcode from supplier where customerno ='#getItem.custno#'
		  		<cfelse>
		    		select currcode from customer where customerno ='#getItem.custno#'
		  		</cfif>
        	</cfquery>

			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getCurrCode2.currcode#</font></div></td>
        	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getItem.price_bil,'____' & stDecl_UPrice)#</font></div></td>
        	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getItem.amt_bil,'____.__')#</font></div></td>
        	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getItem.currrate,'____.____')#</font></div></td>
       	 	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getItem.price,'____' & stDecl_UPrice)#</font></div></td>
        	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getItem.amt,',_.__')#</font></div></td>
     	</tr>

		<tr>
        	<td>&nbsp;</td>
        	<td colspan="8"><div align="left"><font face="Times New Roman, Times, serif"><font size="2">#getitem.desp#</font></font></div></td>
      	</tr>
	  	</cfoutput>

	  	<cfset maxArray = right(CurrArray2[1][1],1)>

	  	<cfloop index = "i" from = "1" to = "#maxArray#">

		<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
          	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getItem.amt_bil>
          	<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getItem.amt>
        </cfif>

        <cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
          	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getItem.amt_bil>
          	<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getItem.amt>
        </cfif>

		<cfset i = i + 1>
		</cfloop>
	</cfloop>

    <tr>
      	<td colspan="9"><hr></td>
    </tr>
    <!--- Print last sub-total --->
    <cfset maxArray = #right(CurrArray[1][1],1)#>
    <cfset DisplayTotal = 0>
    <cfloop index = "i" from = "1" to = "#maxArray#">
      <cfif CurrArray[i+1][2] neq 0>
        <tr>
          <td valign="top" nowrap>&nbsp;</td>
          <cfif DisplayTotal eq 0>
            <td colspan="2"><div align="right"><strong>Sub
                Total</strong></div></td>
            <cfset DisplayTotal = 1>
            <cfelse>
            <td colspan="2">&nbsp;</td>
          </cfif>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][1]#</cfoutput></font></div></td>
          <td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][2],',_.__')#</cfoutput></font></div></td>
          <td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][3],',_.__')#</cfoutput></font></div></td>
        </tr>
      </cfif>
    </cfloop>

    <tr>
      	<td colspan="9"><hr></td>
    </tr>

    <!--- Print Grand Total (FC) --->
    <cfset maxArray = right(CurrArray2[1][1],1)>
    <cfset DisplayTotal = 0>

    <cfloop index = "i" from = "1" to = "#maxArray#">
      	<cfif CurrArray2[i+1][2] neq 0 or CurrArray2[i+1][1] eq "SGD">
        	<tr>
          		<td valign="top" nowrap>&nbsp;</td>
          		<cfif DisplayTotal eq 0>
            		<td colspan="2"><div align="right"><strong>Grand Total (FC)</strong></div></td>
            		<cfset DisplayTotal = 1>
            	<cfelse>
            		<td colspan="2">&nbsp;</td>
          		</cfif>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][1]#</cfoutput></font></div></td>
          		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][2],',_.__')#</cfoutput></font></div></td>
          		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][3],',_.__')#</cfoutput></font></div></td>
        	</tr>
        	<cfset SGDEquit = SGDEquit + CurrArray2[i+1][3]>
      	</cfif>
      	<cfset i = i + 1>
    </cfloop>
    <tr>
      	<td colspan="9"><hr></td>
    </tr>
    <tr>
      	<td valign="top" nowrap>&nbsp;</td>
      	<td colspan="2"><div align="right"><strong>SGD Equivalent</strong></div></td>
      	<td colspan="3">&nbsp;</td>
      	<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(SGDEquit,',.__')#</cfoutput></font></div></td>
    </tr>
</table>
<br>
<hr>
<div align="right">
<cfif husergrpid eq "Muser">
   	<a href="../home2.cfm" class="noprint"><u><font size="2" face="Arial, Helvetica, sans-serif">Home</font></u></a>
</cfif>
<font size="2" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
<!--- <input type="submit" name="Email" value="Email" class="noprint"> --->
</div>
</cfform>
</body>
</html>