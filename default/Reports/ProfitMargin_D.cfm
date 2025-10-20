<!--- <cfif #tran# eq "SO">
	<cfset tran = "SO">
	<cfset tranname = "Sales Order">
	<cfset trancode = "sono">
	<cfset prefix = "socode">
</cfif> --->
<!--- 	<cfset nexttranno = "8000030">
	<cfset tran = "SO">
	<cfset tranname = "Sales Order">
	<cfset trancode = "sono">
 --->
<!---  	<cfset prefix = "socode"> --->

<cfparam name="ndatefrom" default="">
<cfparam name="ndateto" default="">

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd=#dateformat(form.datefrom, "DD")#>
	<cfif dd greater than '12'>
		<cfset ndatefrom=#dateformat(form.datefrom,"YYYYMMDD")#>
	<cfelse>
		<cfset ndatefrom=#dateformat(form.datefrom,"YYYYDDMM")#>
	</cfif>

	<cfset dd=#dateformat(form.dateto, "DD")#>
	<cfif dd greater than '12'>
		<cfset ndateto=#dateformat(form.dateto,"YYYYMMDD")#>
	<cfelse>
		<cfset ndateto=#dateformat(form.dateto,"YYYYDDMM")#>
	</cfif>
</cfif>

<cfquery name="getHeader" datasource="#dts#">
    <cfswitch expression="#form.rgSort#">
	  <cfcase value="Item No">
	    select itemno from icitem where itemno <> ''
	  </cfcase>
  </cfswitch>

  <cfif form.getfrom neq "" and form.getto neq "">
    and itemno >='#form.getfrom#' and itemno <='#form.getto#'
  </cfif>

  group by itemno

  <cfswitch expression="#form.rgSort#">
	<cfcase value="Contract No">
	  group by custno, refno, itemno
	</cfcase>
	<cfcase value="Invoice No">
	  order by refno
	</cfcase>
	<cfcase value="Item No">
	  order by itemno
	</cfcase>
  </cfswitch>

</cfquery>

<html>
<head>
<title>Profit Margin By <cfoutput>#form.rgSort#</cfoutput></title>
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

<cfquery name="getgeneral" datasource="#dts#">
  select compro, compro2, compro3, compro4, compro5, compro6, compro7, cost, lastaccyear from gsetup
</cfquery>

<!--- <cfif Email eq "Email">
	<cfquery name="getemail" datasource="#dts#">
		select e_mail from customer where customerno = '#getHeaderinfo.custno#'
	</cfquery>
	<cfif getemail.e_mail eq "">
	<cfoutput>
		<h4><font color="##FF0000">Please add in email address for customer - #getHeaderinfo.custno#.</font></h4></cfoutput>
		<cfabort>
	<cfelse>
		<cflocation url="invoiceemail.cfm?nexttranno=#nexttranno#&tran=#tran#&custemail=#getemail.e_mail#&tranname=#tranname#&prefix=#getgeneral.prefix#">
	</cfif>
</cfif> --->
<cfset monthnow = month(now())>

<body>
<cfform name="form1" action="">
  <cfif getHeader.recordcount eq 0>
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
      <td><font size="2" face="Times New Roman, Times, serif"><strong>Profit Margin
          By <cfoutput>#form.rgSort#</cfoutput></strong></font></td>
	  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Date
		  : <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
	</tr>

	<tr>
      <td colspan="13"><hr></td>
    </tr>
  </table>

  <table width="100%" border="0" cellspacing="1" cellpadding="0">
    <tr>
      <td nowrap>&nbsp;</td>
      <td colspan="3"><div align="center"><font size="2" face="Times New Roman, Times, serif"><strong>SGD
          Equialent</strong></font></div></td>
      <td colspan="1" nowrap>&nbsp;</td>
    </tr>
    <tr>
      <td width="8%" nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Date</strong></font></div></td>
      <td width="7%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Sales
          Amt</strong></font></div></td>
      <td width="7%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Sales
          Cost</strong></font></div></td>
      <td width="7%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Gross
          Profit</strong></font></div></td>
      <td width="5%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Margin
          (%)</strong></font></div></td>
      <!---       <td width="8%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Inv No.</strong></font></div></td> --->
    </tr>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <cfset stLastNo = "">
    <!---     <cfset stLastSONO = "">
    <cfset stLastCurr = ""> --->
    <!--- For Gross FC Total --->
    <cfset CurrArray2 = ArrayNew(2)>
    <cfset CurrArray2[1][1] = "Currency - ">
    <cfset CurrArray2[1][2] = "F.S.Amt">
    <cfset CurrArray2[1][3] = "F.S.Cost">
    <cfset CurrArray2[1][4] = "F.GrossProfit">
    <cfset CurrArray2[1][5] = "SGD.S.Amt">
    <cfset CurrArray2[1][6] = "SGD.S.Cost">
    <cfset CurrArray2[1][7] = "SGD.GrossProfit">
    <cfset CurrArray2[1][8] = "SGD.Margin">
    <cfset CurrArray2[2][1] = "SGD">
    <cfset CurrArray2[2][2] = 0>
    <cfset CurrArray2[2][3] = 0>
    <cfset CurrArray2[2][4] = 0>
    <cfset CurrArray2[2][5] = 0>
    <cfset CurrArray2[2][6] = 0>
    <cfset CurrArray2[2][7] = 0>
    <cfset CurrArray2[2][8] = 0>
    <cfquery name="getCurrCode" datasource="#dts#">
    select CurrCode from Currencyrate order by currcode
    </cfquery>
    <cfset i = 3>
    <cfloop query="getCurrCode">
      <cfif getCurrCode.CurrCode neq "SGD">
        <cfset CurrArray2[i][1] = #getCurrCode.CurrCode#>
        <cfset CurrArray2[i][2] = 0>
        <cfset CurrArray2[i][3] = 0>
        <cfset CurrArray2[i][4] = 0>
        <cfset CurrArray2[i][5] = 0>
        <cfset CurrArray2[i][6] = 0>
        <cfset CurrArray2[i][7] = 0>
        <cfset CurrArray2[i][8] = 0>
        <cfset i = #i# + 1>
      </cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray2[1][1] = CurrArray2[1][1] & ToString(#i# - 2)>
    <cfset SGDEquiTotal = 0>
    <!--- For Gross Total --->
    <cfset CurrArray1 = ArrayNew(2)>
    <cfset CurrArray1[1][1] = "Currency - ">
    <cfset CurrArray1[1][2] = "F.S.Amt">
    <cfset CurrArray1[1][3] = "F.S.Cost">
    <cfset CurrArray1[1][4] = "F.GrossProfit">
    <cfset CurrArray1[1][5] = "SGD.S.Amt">
    <cfset CurrArray1[1][6] = "SGD.S.Cost">
    <cfset CurrArray1[1][7] = "SGD.GrossProfit">
    <cfset CurrArray1[1][8] = "SGD.Margin">
    <cfset CurrArray1[2][1] = "SGD">
    <cfset CurrArray1[2][2] = 0>
    <cfset CurrArray1[2][3] = 0>
    <cfset CurrArray1[2][4] = 0>
    <cfset CurrArray1[2][5] = 0>
    <cfset CurrArray1[2][6] = 0>
    <cfset CurrArray1[2][7] = 0>
    <cfset CurrArray1[2][8] = 0>
    <cfquery name="getCurrCode" datasource="#dts#">
    select CurrCode from Currencyrate order by currcode
    </cfquery>
    <cfset i = 3>
    <cfloop query="getCurrCode">
      <cfif getCurrCode.CurrCode neq "SGD">
        <cfset CurrArray1[i][1] = #getCurrCode.CurrCode#>
        <cfset CurrArray1[i][2] = 0>
        <cfset CurrArray1[i][3] = 0>
        <cfset CurrArray1[i][4] = 0>
        <cfset CurrArray1[i][5] = 0>
        <cfset CurrArray1[i][6] = 0>
        <cfset CurrArray1[i][7] = 0>
        <cfset CurrArray1[i][8] = 0>
        <cfset i = #i# + 1>
      </cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray1[1][1] = CurrArray1[1][1] & ToString(#i# - 2)>
    <!--- For Sub Total --->
    <cfset CurrArray = ArrayNew(2)>
    <cfset CurrArray[1][1] = "Currency - ">
    <cfset CurrArray[1][2] = "F.S.Amt">
    <cfset CurrArray[1][3] = "F.S.Cost">
    <cfset CurrArray[1][4] = "F.GrossProfit">
    <cfset CurrArray[1][5] = "SGD.S.Amt">
    <cfset CurrArray[1][6] = "SGD.S.Cost">
    <cfset CurrArray[1][7] = "SGD.GrossProfit">
    <cfset CurrArray[1][8] = "SGD.Margin">
    <cfset CurrArray[2][1] = "SGD">
    <cfset CurrArray[2][2] = 0>
    <cfset CurrArray[2][3] = 0>
    <cfset CurrArray[2][4] = 0>
    <cfset CurrArray[2][5] = 0>
    <cfset CurrArray[2][6] = 0>
    <cfset CurrArray[2][7] = 0>
    <cfset CurrArray[2][8] = 0>
    <cfquery name="getCurrCode" datasource="#dts#">
    select CurrCode from Currencyrate order by currcode
    </cfquery>

    <cfset i = 3>
    <cfloop query="getCurrCode">
      <cfif getCurrCode.CurrCode neq "SGD">
        <cfset CurrArray[i][1] = #getCurrCode.CurrCode#>
        <cfset CurrArray[i][2] = 0>
        <cfset CurrArray[i][3] = 0>
        <cfset CurrArray[i][4] = 0>
        <cfset CurrArray[i][5] = 0>
        <cfset CurrArray[i][6] = 0>
        <cfset CurrArray[i][7] = 0>
        <cfset CurrArray[i][8] = 0>
        <cfset i = #i# + 1>
      </cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray[1][1] = CurrArray[1][1] & ToString(#i# - 2)>
    <!---
Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No
Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No
Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No
Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No
Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No	Item No
--->
    <cfif rgSort eq "Item No">
      <cfset stLastNo = "">
	  <cfset T_Sales = 0>
	  <cfset T_Cost = 0>
	  <cfset T_Profit = 0>

      <cfloop query = "getHeader">
	  <cfoutput>
        <tr>
          <cfset invamt = 0>
          <cfset csamt = 0>
          <cfset dnamt = 0>
          <cfset cnamt = 0>
          <cfset itembal = 0>
          <cfset xprice = 0.00>
          <cfset F_invamt = 0>
          <cfset F_csamt = 0>
          <cfset F_dnamt = 0>
          <cfset F_cnamt = 0>
          <cfquery name="getinv" datasource="#dts#">
          select sum(amt)as sumamt from ictran where type = 'INV' and itemno
          = '#getHeader.itemno#' and desp <> ''
          <cfif ndatefrom neq "" and ndateto neq "">
            and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
		  <cfelse>
		  	and wos_date > #getgeneral.lastaccyear#
          </cfif>
          </cfquery>

          <cfquery name="getcn" datasource="#dts#">
          select sum(amt)as sumamt from ictran where type = 'CN' and itemno
          = '#getHeader.itemno#' and desp <> ''
          <cfif ndatefrom neq "" and ndateto neq "">
            and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
		  	and wos_date > #getgeneral.lastaccyear#
          </cfif>
          </cfquery>
          <cfquery name="getdn" datasource="#dts#">
          select sum(amt)as sumamt from ictran where type = 'DN' and itemno
          = '#getHeader.itemno#' and desp <> ''
          <cfif ndatefrom neq "" and ndateto neq "">
            and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
		  	and wos_date > #getgeneral.lastaccyear#
          </cfif>
          </cfquery>
          <cfquery name="getcs" datasource="#dts#">
          select sum(amt)as sumamt from ictran where type = 'CS' and itemno
          = '#getHeader.itemno#' and desp <> ''
          <cfif ndatefrom neq "" and ndateto neq "">
            and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
		  	and wos_date > #getgeneral.lastaccyear#
          </cfif>
          </cfquery>

            <cfif getinv.sumamt neq "">
              <cfset invamt = #getinv.sumamt#>
            </cfif>

            <cfif getcn.sumamt neq "">
              <cfset cnamt = #getcn.sumamt#>
            </cfif>

            <cfif getdn.sumamt neq "">
              <cfset dnamt = #getdn.sumamt#>
            </cfif>

            <cfif getcs.sumamt neq "">
              <cfset csamt = #getcs.sumamt#>
            </cfif>

          <cfset totalamt = #invamt# + #dnamt# + #csamt#>
          <cfset netamt = #totalamt# - #cnamt#>
          <cfif getgeneral.cost eq 'month'>
            <cfif monthnow eq '1'>
              <cfset lastmonth = '12'>
              <cfelse>
              <cfset lastmonth = monthnow - 1>
            </cfif>
            <cfquery datasource="#dts#" name="lastprice">
            select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno
            = '#itemno#' and month(wos_date) = '#lastmonth#' and type = 'RC' and desp <> ''
            </cfquery>

            <cfif lastprice.sumamt neq "">
              <cfset lastpriceamt = lastprice.sumamt>
              <cfelse>
              <cfset lastpriceamt = 0>
            </cfif>
            <cfif lastprice.qty neq "">
              <cfset lastpriceqty = lastprice.qty>
              <cfelse>
              <cfset lastpriceqty = 0>
            </cfif>
            <cfquery datasource="#dts#" name="lastprprice">
            select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno
            = '#itemno#' and month(wos_date) = '#lastmonth#' and type = 'PR' and desp <> ''
            </cfquery>
            <cfif lastprprice.sumamt neq "">
              <cfset lastprpriceamt = lastprprice.sumamt>
              <cfelse>
              <cfset lastprpriceamt = 0>
            </cfif>
            <cfif lastprprice.qty neq "">
              <cfset lastprpriceqty = lastprprice.qty>
              <cfelse>
              <cfset lastprpriceqty = 0>
            </cfif>
            <cfquery datasource="#dts#" name="pricenow">
            select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno
            = '#itemno#' and month(wos_date) = '#monthnow#' and type = 'RC' and desp <> ''
            </cfquery>
            <cfif pricenow.sumamt neq "">
              <cfset pricenowamt = pricenow.sumamt>
              <cfelse>
              <cfset pricenowamt = 0>
            </cfif>
            <cfif pricenow.qty neq "">
              <cfset pricenowqty = pricenow.qty>
              <cfelse>
              <cfset pricenowqty = 0>
            </cfif>
            <cfquery datasource="#dts#" name="prpricenow">
            select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno
            = '#itemno#' and month(wos_date) = '#monthnow#' and type = 'PR' and desp <> ''
            </cfquery>

            <cfif prpricenow.sumamt neq "">
              <cfset prpricenowamt = prpricenow.sumamt>
              <cfelse>
              <cfset prpricenowamt = 0>
            </cfif>
            <cfif prpricenow.qty neq "">
              <cfset prpricenowqty = prpricenow.qty>
              <cfelse>
              <cfset prpricenowqty = 0>
            </cfif>
            <cfset up =  lastpriceamt - lastprpriceamt + pricenowamt - prpricenowamt>
            <cfset down = itembal + lastpriceqty - lastprpriceqty + pricenowqty - prpricenowqty>
            <cfif down neq 0>
              <cfset xprice = up/ down>
              <cfset xprice = numberformat(xprice,".__")>
            </cfif>
            <cfelseif getgeneral.cost eq 'moving'>
            	<cfquery datasource="#dts#" name="getprice">
            		select sum(amt)as sumamt, sum(qty) as qty from ictran where itemno = '#itemno#' and type = 'RC' and desp <> ''
            	</cfquery>

            	<cfif getprice.sumamt neq "">
              		<cfset getpriceamt = getprice.sumamt>
              	<cfelse>
              	<cfset getpriceamt = 0>
            	</cfif>
				<cfif getprice.qty neq "">
				  <cfset getpriceqty = getprice.qty>
				  <cfelse>
				  <cfset getpriceqty = 0>
				</cfif>
				<cfquery datasource="#dts#" name="prprice">
				select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno
				= '#itemno#' and type = 'PR' and desp <> ''
				</cfquery>

				<cfif prprice.sumamt neq "">
				  <cfset prpriceamt = prprice.sumamt>
				<cfelse>
				  <cfset prpriceamt = 0>
				</cfif>
				<cfif prprice.qty neq "">
				  <cfset prpriceqty = prprice.qty>
				<cfelse>
				  <cfset prpriceqty = 0>
				</cfif>
				<cfset up = getpriceamt - prpriceamt>
				<cfset down = itembal + getpriceqty - prpriceqty>
				<cfif down neq 0>
				  <cfset xprice = up / down>
				  <cfset xprice = numberformat(xprice,".__")>
				</cfif>
		   <cfelse>
				<cfquery datasource="#dts#" name="getprice">
				select price from icitem where itemno = '#itemno#'
				</cfquery>

				<cfif getprice.price neq "">
				  <cfset xprice = #getprice.price#>
				  <cfset xprice = numberformat(xprice,".__")>
				</cfif>
          </cfif>

		  <cfif netamt neq 0>
            <td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="2">#getHeader.itemno#</font></font></td>
            <cfset GrossProfit = netamt - xprice>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(netamt,',_.__')#</font></div></td>
            <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(xprice,',_.__')#</font></font></div></td>
            <cfset GrossProfit = netamt - xprice>
            <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(GrossProfit,',_.__')#</font></font></div></td>
		    <cfset Margin = (GrossProfit / netamt) * 100>
            <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(Margin,'___.__')#</font></font></div></td>

      	    <cfset T_Sales = T_Sales + #netamt#>
	        <cfset T_Cost = T_Cost + #xprice#>
            <cfset T_Profit = T_Profit + #GrossProfit#>
		  </cfif>
        </tr>
		</cfoutput>
      </cfloop>
    </cfif>
    <tr>
      <td colspan="5"><hr></td>
    </tr>
    <!--- Print Gross Total (FC) --->
    <tr>
      <td valign="top" nowrap>Total</td>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_Sales,',_.__')#</cfoutput></font></div></td>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_Cost,',_.__')#</cfoutput></font></div></td>
          <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_Profit,',_.__')#</cfoutput></font></div></td>
  		  <cfif T_Sales neq 0>
  		    <cfset T_Margin = (T_Profit / T_Sales) * 100>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_Margin,',_.__')#</cfoutput></font></div></td>
		  </cfif>
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