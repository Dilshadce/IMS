<cfset prefix = "pocode">
<cfparam name="ndatefrom" default="">
<cfparam name="ndateto" default="">
<cfparam name="totalamt" default="0">
<cfparam name="totaldisc" default="0">
<cfparam name="totaltax" default="0">
<cfparam name="totalgrand" default="0">
<cfparam name="totalfcamt" default="0">

<cfif isdefined("url.datefrom") and isdefined("url.dateto")>
	<cfset dd=dateformat(url.datefrom, "DD")>

	<cfif dd greater than '12'>
    	<cfset ndatefrom=dateformat(url.datefrom,"YYYYMMDD")>
  	<cfelse>
    	<cfset ndatefrom=dateformat(url.datefrom,"YYYYDDMM")>
  	</cfif>

	<cfset dd=dateformat(url.dateto, "DD")>

	<cfif dd greater than '12'>
    	<cfset ndateto=dateformat(url.dateto,"YYYYMMDD")>
  	<cfelse>
    	<cfset ndateto=dateformat(url.dateto,"YYYYDDMM")>
  	</cfif>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select #prefix# as prefix,lastaccyear from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getartran">
  	Select * from artran where type = '#url.trancode#' and (void = '' or void is null) <!---and order_cl = 'Y'--->
  	<cfif url.bf neq "" and url.bt neq "">
    and refno >= '#url.bf#' and refno <= '#url.bt#'
  	</cfif>
  	<cfif ndatefrom neq "" and ndateto neq "">
    and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
  	<cfelse>
  	and wos_date > #getgeneral.lastaccyear#
  	</cfif>
	<cfif url.agentfrom neq "" and url.agentto neq "">
    and agenno >= '#url.agentfrom#' and agenno <= '#url.agentto#'
  	</cfif>
	<cfif url.getfrom neq "" and url.getto neq "">
    and custno >= '#url.getfrom#' and custno <= '#url.getto#'
	</cfif>
	<cfif url.periodfrom neq "" and url.periodto neq "">
    and fperiod >= '#url.periodfrom#' and fperiod <= '#url.periodto#'
	</cfif>

	<cfswitch expression="#url.rgSort#">
    	<cfcase value="Purchase Order No">
	  	order by refno
		</cfcase>
		<cfcase value="Supplier Name">
	  	order by name, refno
		</cfcase>
		<cfcase value="Supplier Code">
	  	order by custno, refno
		</cfcase>
		<cfcase value="Month">
	  	order by year(wos_date), month(wos_date)
		</cfcase>
  	</cfswitch>
</cfquery>

<html>
<head>
<title>Completed Vendor Purchase Listing By <cfoutput>#url.rgsort#</cfoutput></title>
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

<cfif Email eq "Email">
	<cfquery name="getemail" datasource="#dts#">
		select e_mail from customer where customerno = '#getheaderinfo.custno#'
  	</cfquery>

  	<cfif getemail.e_mail eq "">
    	<cfoutput><h4><font color="##FF0000">Please add in email address for customer - #getheaderinfo.custno#.</font></h4></cfoutput>
		<cfabort>
  	<cfelse>
		<cflocation url="invoiceemail.cfm?nexttranno=#nexttranno#&tran=#tran#&custemail=#getemail.e_mail#&tranname=#tranname#&prefix=#getgeneral.prefix#">
  	</cfif>
</cfif>

<!--- Control The Decimal Point --->
<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ",_.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfset iDecl_Discount = getgsetup2.Decl_Discount>
<cfset stDecl_Discount = ",_.">

<cfloop index="LoopCount" from="1" to="#iDecl_Discount#">
  <cfset stDecl_Discount = stDecl_Discount & "_">
</cfloop>

<body>
<cfif getartran.refno eq "">
	<cfoutput><h4><font color="##FF0000">No Report Generated.</font></h4></cfoutput>
	<cfabort>
</cfif>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td colspan="3"><div align="center"><font size="4" face="Arial black"><strong>MSD ENGINEERING PTE LTD</strong></font><br>
        	<font size="1" face="Times New Roman, Times, serif">23 HILLVIEW TERRACE</font><br>
			<font size="1" face="Times New Roman, Times, serif">SINGAPORE 669234</font><br>
        	<font size="1" face="Times New Roman, Times, serif">TEL :(65) 6462 9119&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FAX :(65) 6462 9118</font><br>
			<font size="1" face="Times New Roman, Times, serif">ROC/GST NO.: 200504367W</font></div>
      	</td>
	</tr>
	<tr>
      	<td><font size="1" face="Times New Roman, Times, serif"><strong>Completed Vendor Purchases Listing By <cfoutput>#url.rgsort#</cfoutput></strong></font></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Date : <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
	</tr>
	<tr>
      	<td colspan="15"><hr></td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td height="17" nowrap><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td colspan="2"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Foreign Currency</strong></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Exchg Rate</strong></font></div></td>
      	<td colspan="2"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>SGD Equialent</strong></font></div></td>
    </tr>
    <tr>
      	<td width="3%" nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>&nbsp;</strong></font></div></td>
      	<td width="8%" nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>PO No.</strong></font></div></td>
      	<td width="8%"><div align="left">&nbsp;</div></td>
      	<td width="4%"><div align="left">&nbsp;</div></td>
      	<td width="8%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>SO No.</strong></font></div></td>
      	<td width="8%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>GRN No</strong></font></div></td>
      	<td width="8%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Rec'd Date</strong></font></div></td>
      	<td width="4%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Qty Ordered </strong></font></div></td>
      	<td width="4%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Qty Rec </strong></font></div></td>
      	<td width="4%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Bal.</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Currcy</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>U.Price</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
      	<td width="4%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>U.Price</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="16"><hr></td>
    </tr>

    <cfset stLastNo = "">
    <cfset stLastPONO = "">
    <cfset stLastCurr = "">
    <!--- For Grand FC Total --->
    <!--- FOR REFERENCE --->
    <cfset CurrArray2 = ArrayNew(2)>
    <cfset CurrArray2[1][1] = "Currency - ">
    <cfset CurrArray2[1][2] = "FC.T.Price">
    <cfset CurrArray2[1][3] = "No.E.Rate">
    <cfset CurrArray2[1][4] = "E.Rate">
    <cfset CurrArray2[1][5] = "SGD.T.Price">
    <cfset CurrArray2[1][6] = "QtyOrder">
    <cfset CurrArray2[1][7] = "QtyReceive">
    <cfset CurrArray2[1][8] = "Balance">
    <!--- Put SGD first, and init --->
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
    <!--- Init the rest base on Currency table--->
    <cfloop query="getCurrCode">
		<cfif getCurrCode.CurrCode neq "SGD">
        	<cfset CurrArray2[i][1] = getCurrCode.CurrCode>
        	<cfset CurrArray2[i][2] = 0>
        	<cfset CurrArray2[i][3] = 0>
        	<cfset CurrArray2[i][4] = 0>
        	<cfset CurrArray2[i][5] = 0>
        	<cfset CurrArray2[i][6] = 0>
        	<cfset CurrArray2[i][7] = 0>
        	<cfset CurrArray2[i][8] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
	<cfset CurrArray2[1][1] = CurrArray2[1][1] & ToString(#i# - 2)>
    <cfset SGDEquiTotal = 0>
    <cfset TotalOrder = 0>
    <cfset TotalDelived = 0>
    <cfset TotalBalance = 0>
    <!--- For Grand Total --->
    <cfset CurrArray1 = ArrayNew(2)>
    <cfset CurrArray1[1][1] = "Currency - ">
    <cfset CurrArray1[1][2] = "FC.T.Price">
    <cfset CurrArray1[1][3] = "No.E.Rate">
    <cfset CurrArray1[1][4] = "E.Rate">
    <cfset CurrArray1[1][5] = "SGD.T.Price">
    <cfset CurrArray1[1][6] = "QtyOrder">
    <cfset CurrArray1[1][7] = "QtyReceive">
    <cfset CurrArray1[1][8] = "Balance">
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
        	<cfset CurrArray1[i][1] = getCurrCode.CurrCode>
        	<cfset CurrArray1[i][2] = 0>
        	<cfset CurrArray1[i][3] = 0>
        	<cfset CurrArray1[i][4] = 0>
        	<cfset CurrArray1[i][5] = 0>
        	<cfset CurrArray1[i][6] = 0>
        	<cfset CurrArray1[i][7] = 0>
        	<cfset CurrArray1[i][8] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray1[1][1] = CurrArray1[1][1] & ToString(#i# - 2)>
    <!--- For Sub Total --->
    <cfset CurrArray = ArrayNew(2)>
    <cfset CurrArray[1][1] = "Currency - ">
    <cfset CurrArray[1][2] = "FC.T.Price">
    <cfset CurrArray[1][3] = "No.E.Rate">
    <cfset CurrArray[1][4] = "E.Rate">
    <cfset CurrArray[1][5] = "SGD.T.Price">
    <cfset CurrArray[1][6] = "QtyOrder">
    <cfset CurrArray[1][7] = "QtyReceive">
    <cfset CurrArray[1][8] = "Balance">
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
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray[1][1] = CurrArray[1][1] & ToString(#i# - 2)>
    <!---
PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No
PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No
PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No
PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No
PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No	PO No
--->
<cfif rgSort eq "Purchase Order No">
	<cfset stLastNo = "">

	<cfloop query = "getartran">
		<cfquery name="checkiclink" datasource="#dts#">
			select type from iclink where frrefno = '#getartran.refno#' and frtype = 'PO'
		</cfquery>

		<cfquery name = "getRCQTY" datasource = "#dts#">
        	<!--- select sum(qty_bil) as T_QTY from ictran where type ='RC' and dono = '#getartran.refno#' and qty <> '0'  --->
			select sum(shipped) as T_QTY from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

		<cfif getRCQTY.T_QTY neq "">
			<cfset RC_Total_QTY = getRCQTY.T_QTY>
        <cfelse>
        	<cfset RC_Total_QTY = 0>
        </cfif>

		<cfquery name = "getPOQTY" datasource = "#dts#">
        	select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

		<cfif getPOQTY.qty_bil neq "">
        	<cfset PO_Total_QTY = getPOQTY.qty_bil>
        <cfelse>
        	<cfset PO_Total_QTY = 0>
        </cfif>

		<!--- <cfset PO_Total_QTY = 0>
		<cfloop query = "getPOQTY">
		<cfset PO_Total_QTY = #PO_Total_QTY# + #getPOQTY.qty_bil#>
		</cfloop> --->
        <cfset Balance = PO_Total_QTY - RC_Total_QTY>
		<!--- If Balance is 0 then is Completed --->
        <cfif Balance eq 0 or checkiclink.recordcount gt 0>
        	<!--- Print the sub-total --->
          	<cfif stLastNo neq getartran.refno and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][6] neq 0>
                		<cfoutput>
						<tr>
                  			<td colspan="16"><hr></td>
                		</tr>
                		<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][7]#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][8]#</font></div></td>
                  			<td>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  			<td>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                		</tr>
						</cfoutput>
							<!--- Clear the sub total --->
							<cfset CurrArray[i+1][2] = 0>
							<cfset CurrArray[i+1][3] = 0>
							<cfset CurrArray[i+1][4] = 0>
							<cfset CurrArray[i+1][5] = 0>
							<cfset CurrArray[i+1][6] = 0>
							<cfset CurrArray[i+1][7] = 0>
							<cfset CurrArray[i+1][8] = 0>
              			</cfif>
            		</cfloop>
            		<tr>
              			<td colspan="15" valign="top" nowrap>&nbsp;</td>
            		</tr>
			  	</cfif>

		  		<cfquery name="getCust" datasource="#dts#">
          			select phone, phonea, add1, add2, add3, add4 from supplier where customerno = '#getartran.custno#'
          		</cfquery>

				<cfoutput>
          		<tr>
            		<td colspan="2" valign="top" nowrap><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno#</strong></font></font></font></td>
            		<td colspan="9"> <font face="Times New Roman, Times, serif" size="1"><strong>#getartran.name# </strong> Tel: #getCust.phone# #getCust.phonea#</font> </td>
            		<td colspan="5">&nbsp;</td>
          		</tr>
          		<tr>
            		<td colspan="16" valign="top" nowrap> <font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></td>
          		</tr>
          		<tr>
            		<td nowrap valign="top">&nbsp;</td>
            		<td nowrap><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#<cfif getartran.order_cl eq 'Y'> <strong>(CLEAR)</strong></cfif></font></font></font></td>
            		<td nowrap><font face="Times New Roman, Times, serif" size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></td>
            		<cfquery name="getSOCode" datasource="#dts#">
              			select socode from gsetup
              		</cfquery>
					<td></td>
					<td nowrap><font face="Times New Roman, Times, serif" size="1">#getSOCode.socode##getartran.rem7#</font></td>
					<td colspan="12">&nbsp;</td>
          		</tr>
		  		</cfoutput>

		  		<cfset stLastNo = getartran.refno>
				<cfset rem7 = getartran.rem7>
          		<!--- Print details --->
          		<cfquery name="getictran" datasource="#dts#">
          			select a.* from ictran a, iclink b where a.refno ='#getartran.refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
					and a.itemno=b.itemno and a.type = 'PO' and b.frtype = 'PO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
          		</cfquery>

		  		<cfloop query = "getictran">
					<!---<cfquery name="checkictran" datasource="#dts#">
						select refno from ictran where type = 'rc' and refno = '##'
					</cfquery>--->
            		<cfoutput>
					<tr>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
              			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
              			<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>
						<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"></font></font></div></td>

			  			<cfquery name="getRCCode" datasource="#dts#">
              				select rccode from gsetup
              			</cfquery>

						<cfquery name="getReceive" datasource="#dts#">
			  				select * from iclink where type = 'RC' and frtype = 'PO' and frrefno = '#getictran.refno#' and itemno = '#getictran.itemno#' and frtrancode = '#getictran.trancode#'
              				<!--- select wos_date, qty_bil from ictran where type ='RC' and refno = '#getictran.toinv#' and itemno = '#getictran.itemno#' and qty <> '0' --->
						</cfquery>

              			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getRCCode.rccode##getreceive.refno# </cfloop></font></font></div></td>
              			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#dateformat(getreceive.wos_date,"dd/mm/yyyy")# </cfloop></font></font></div></td>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty#</font></font></div></td>
              			<!--- get the item qty received from the RC, and it was updated from PO --->
              			<cfset RCqty = 0>

			  			<cfif getReceive.recordcount eq 0>
                			<cfset RCqty = 0>
                		<cfelse>
                			<cfloop query = "getReceive">
                  				<cfset RCqty = RCqty + getReceive.qty>
                			</cfloop>
              			</cfif>

              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getreceive.qty#<cfif getreceive.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
              			<cfset Bal = 0>
              			<cfset Bal = getictran.qty_bil - RCqty>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
              				select currcode from supplier where customerno ='#getictran.custno#'
              			</cfquery>

			  			<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
			  			<cfset xprice= xprice_bil*getictran.currrate>

			  			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice,stDecl_UPrice)#</font></div></td>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt,',_.__')#</font></div></td>
            		</tr>
					</cfoutput>

					<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                			<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
                			<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + getictran.amt>
                			<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
                			<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + RCQTY>
                			<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
              			</cfif>
              			<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
                			<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
                			<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + getictran.amt>
                			<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
                			<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + RCQTY>
                			<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + Bal>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
          		</cfloop>
        </cfif>
	</cfloop>
</cfif>
<!---
Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name
Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name
Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name
Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name
Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name	Supplier Name
--->
<cfif rgSort eq "Supplier Name">
	<cfset stLastNo = "">

	<cfloop query = "getartran">
		<cfquery name="checkiclink" datasource="#dts#">
			select type from iclink where frrefno = '#getartran.refno#' and frtype = 'PO'
		</cfquery>

       	<cfquery name = "getRCQTY" datasource = "#dts#">
       		select sum(shipped) as T_QTY from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
       	</cfquery>

		<cfif getRCQTY.T_QTY neq "">
			<cfset RC_Total_QTY = getRCQTY.T_QTY>
		<cfelse>
        	<cfset RC_Total_QTY = 0>
        </cfif>

		<cfquery name = "getPOQTY" datasource = "#dts#">
        	select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

		<cfif getPOQTY.qty_bil neq "">
        	<cfset PO_Total_QTY = getPOQTY.qty_bil>
        <cfelse>
        	<cfset PO_Total_QTY = 0>
        </cfif>
		<!--- <cfquery name = "getPOQTY" datasource = "#dts#">
		select qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
		</cfquery>
		<cfset PO_Total_QTY = 0>
		<cfloop query = "getPOQTY">
		<cfset PO_Total_QTY = #PO_Total_QTY# + #getPOQTY.qty_bil#>
		</cfloop> --->
		<cfset Balance = PO_Total_QTY - RC_Total_QTY>
		<!--- If Balance is 0 then is Completed --->
		<cfif Balance eq 0 or checkiclink.recordcount gt 0>
          	<!--- Print the sub-total --->
          	<cfif stLastNo neq getartran.name and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][6] neq 0>
			  		<cfoutput>
                	<tr>
                  		<td colspan="16"><hr></td>
                	</tr>
                	<tr>
                  		<td colspan="5" valign="top" nowrap>&nbsp;</td>
                  		<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][7]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][8]#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                	</tr>
					</cfoutput>
                	<!--- Clear the sub total --->
                	<cfset CurrArray[i+1][2] = 0>
                	<cfset CurrArray[i+1][3] = 0>
                	<cfset CurrArray[i+1][4] = 0>
                	<cfset CurrArray[i+1][5] = 0>
                	<cfset CurrArray[i+1][6] = 0>
                	<cfset CurrArray[i+1][7] = 0>
                	<cfset CurrArray[i+1][8] = 0>
              		</cfif>
            	</cfloop>

				<cfif stLastNO neq getartran.name>
              		<!--- Print Grand Total --->
              		<cfset maxArray = right(CurrArray1[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
                		<cfif CurrArray1[i+1][6] neq 0>
                  		<cfoutput>
				  		<tr>
                    		<td colspan="16"><hr></td>
                  		</tr>
                  		<tr>
                    		<td colspan="5" valign="top" nowrap>&nbsp;</td>
                    		<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][6]#</font></div></td>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][7]#</font></div></td>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][8]#</font></div></td>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
                    		<td>&nbsp;</td>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][2],',_.__')#</font></div></td>
                    		<td>&nbsp;</td>
                    		<td>&nbsp;</td>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][5],',_.__')#</font></div></td>
                    		<!--- Clear the grand total --->
							<cfset CurrArray1[i+1][2] = 0>
							<cfset CurrArray1[i+1][3] = 0>
							<cfset CurrArray1[i+1][4] = 0>
							<cfset CurrArray1[i+1][5] = 0>
							<cfset CurrArray1[i+1][6] = 0>
							<cfset CurrArray1[i+1][7] = 0>
							<cfset CurrArray1[i+1][8] = 0>
                  		</tr>
				  		</cfoutput>
                	</cfif>
					<cfset i = i + 1>
              	</cfloop>
              	<tr>
                	<td colspan="16" valign="top" nowrap>&nbsp;</td>
              	</tr>
            	</cfif>
			</cfif>
          	<!--- Print Supplier info --->
          	<cfif stLastNo neq getartran.name>
				<cfquery name="getCust" datasource="#dts#">
            		select phone, phonea, add1, add2, add3, add4 from supplier where customerno = '#getartran.custno#'
            	</cfquery>

				<cfoutput>
				<tr>
              		<td colspan="2" valign="top" nowrap><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno#</strong></font></font></font></td>
              		<td colspan="9"><font face="Times New Roman, Times, serif" size="1"><strong>#getartran.name# </strong> Tel: #getCust.phone# #getCust.phonea#</font></td>
              		<td colspan="5">&nbsp;</td>
            	</tr>
            	<tr>
              		<td colspan="16"><font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></td>
            	</tr>
				</cfoutput>
          	</cfif>

		  	<cfoutput>
         	<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td colspan="2"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#<cfif getartran.order_cl eq 'Y'> <strong>(CLEAR)</strong></cfif></font></font></font></td>
            	<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
            	<td colspan="12">&nbsp;</td>
          	</tr>
		  	</cfoutput>

		  	<cfset stLastNo = getartran.name>
          	<cfset stLastPONO = getartran.refno>
			<cfset rem7 = getartran.rem7>
          	<!--- Print details --->

		  	<cfquery name="getictran" datasource="#dts#">
          		select a.* from ictran a, iclink b where a.refno ='#getartran.refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
				and a.itemno=b.itemno and a.type = 'PO' and b.frtype = 'PO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
          	</cfquery>

		  	<cfloop query = "getictran">
		  		<cfoutput>
				<tr>
					<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
              		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
              		<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>

					<cfquery name="getSOCode" datasource="#dts#">
              			select socode from gsetup
              		</cfquery>

					<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getSOCode.socode##rem7#</font></font></div></td>

					<cfquery name="getRCCode" datasource="#dts#">
              			select rccode from gsetup
              		</cfquery>

					<cfquery name="getReceive" datasource="#dts#">
						select * from iclink
						where type = 'RC' and frtype = 'PO' and frrefno = '#getictran.refno#'
						and itemno = '#getictran.itemno#' and frtrancode = '#getictran.trancode#'
              			<!--- select wos_date, qty_bil from ictran where type ='RC' and refno = '#getictran.toinv#' and itemno = '#getictran.itemno#' and qty <> '0' --->
              		</cfquery>

			  		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getRCCode.rccode##getreceive.refno# </cfloop></font></font></div></td>
              		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#dateformat(getreceive.wos_date,"dd/mm/yyyy")# </cfloop></font></font></div></td>
              		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>
              		<!--- get the item qty received from the RC, and it was updated from PO --->
              		<cfset RCqty = 0>

					<cfif getReceive.recordcount eq 0>
                		<cfset RCqty = 0>
                	<cfelse>
                		<cfloop query = "getReceive">
                  			<cfset RCqty = RCqty + getReceive.qty>
                		</cfloop>
              		</cfif>

			  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getreceive.qty#<cfif getreceive.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
              		<cfset Bal = 0>
					<cfset Bal = getictran.qty_bil - RCqty>
              		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

					<cfquery name="getCurrCode2" datasource="#dts#">
              			select currcode from supplier where customerno ='#getictran.custno#'
              		</cfquery>

			  		<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
			  		<cfset xprice= xprice_bil*getictran.currrate>

			  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice,stDecl_UPrice)#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt,',_.__')#</font></div></td>
            	</tr>
				</cfoutput>

				<cfset maxArray = right(CurrArray2[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
					<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
						<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
						<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + getictran.amt>
						<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
						<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + RCQTY>
						<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
					</cfif>

					<cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
						<cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.amt_bil>
						<cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + getictran.amt>
						<cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.qty_bil>
						<cfset CurrArray1[i+1][7] = CurrArray1[i+1][7] + RCQTY>
						<cfset CurrArray1[i+1][8] = CurrArray1[i+1][8] + Bal>
					</cfif>

					<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
						<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
						<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + getictran.amt>
						<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
						<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + RCQTY>
						<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + Bal>
					</cfif>
              		<cfset i = i + 1>
            	</cfloop>
			</cfloop>
		</cfif>
	</cfloop>
</cfif>
<!---
Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code
Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code
Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code
Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code
Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code	Supplier Code
--->
<cfif rgSort eq "Supplier Code">
	<cfset stLastNo = "">

	<cfloop query = "getartran">
		<cfquery name="checkiclink" datasource="#dts#">
			select type from iclink where frrefno = '#getartran.refno#' and frtype = 'PO'
		</cfquery>

       	<cfquery name = "getRCQTY" datasource = "#dts#">
       		select sum(shipped) as T_QTY from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
       	</cfquery>

		<cfif getRCQTY.T_QTY neq "">
       		<cfset RC_Total_QTY = getRCQTY.T_QTY>
       	<cfelse>
       		<cfset RC_Total_QTY = 0>
       	</cfif>

		<cfquery name = "getPOQTY" datasource = "#dts#">
       		select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
       	</cfquery>

		<cfif getPOQTY.qty_bil neq "">
        	<cfset PO_Total_QTY = getPOQTY.qty_bil>
        <cfelse>
        	<cfset PO_Total_QTY = 0>
        </cfif>

		<!--- <cfquery name = "getPOQTY" datasource = "#dts#">
		select qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
		</cfquery>
		<cfset PO_Total_QTY = 0>
		<cfloop query = "getPOQTY">
		<cfset PO_Total_QTY = #PO_Total_QTY# + #getPOQTY.qty_bil#>
		</cfloop> --->
        <cfset Balance = PO_Total_QTY - RC_Total_QTY>
        <!--- If Balance is 0 then is Completed --->
        <cfif Balance eq 0 or checkiclink.recordcount gt 0>
         	<!--- Print the sub-total --->
          	<cfif stLastNo neq getartran.custno and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][6] neq 0>
                	<cfoutput>
					<tr>
                  		<td colspan="16"><hr></td>
                	</tr>
                	<tr>
                  		<td colspan="5" valign="top" nowrap>&nbsp;</td>
                  		<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][7]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][8]#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                	</tr>
					</cfoutput>
                	<!--- Clear the sub total --->
                	<cfset CurrArray[i+1][2] = 0>
                	<cfset CurrArray[i+1][3] = 0>
                	<cfset CurrArray[i+1][4] = 0>
                	<cfset CurrArray[i+1][5] = 0>
                	<cfset CurrArray[i+1][6] = 0>
                	<cfset CurrArray[i+1][7] = 0>
                	<cfset CurrArray[i+1][8] = 0>
              		</cfif>
            	</cfloop>

				<cfif stLastNO neq getartran.custno>
              	<!--- Print Grand Total --->
              	<cfset maxArray = right(CurrArray1[1][1],1)>

			  	<cfloop index = "i" from = "1" to = "#maxArray#">
                	<cfif CurrArray1[i+1][6] neq 0>
                  	<cfoutput>
				  	<tr>
                    	<td colspan="16"><hr></td>
                  	</tr>
                  	<tr>
                    	<td colspan="5" valign="top" nowrap>&nbsp;</td>
                    	<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
                    	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][6]#</font></div></td>
                    	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][7]#</font></div></td>
                    	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][8]#</font></div></td>
                    	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
                    	<td>&nbsp;</td>
                    	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][2],',_.__')#</font></div></td>
                    	<td>&nbsp;</td>
                    	<td>&nbsp;</td>
                    	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][5],',_.__')#</font></div></td>
                    	<!--- Clear the grand total --->
                    	<cfset CurrArray1[i+1][2] = 0>
                    	<cfset CurrArray1[i+1][3] = 0>
                    	<cfset CurrArray1[i+1][4] = 0>
                    	<cfset CurrArray1[i+1][5] = 0>
                    	<cfset CurrArray1[i+1][6] = 0>
                    	<cfset CurrArray1[i+1][7] = 0>
                    	<cfset CurrArray1[i+1][8] = 0>
                  	</tr>
				  	</cfoutput>
                </cfif>
                <cfset i = i + 1>
			</cfloop>
			<tr>
				<td colspan="16" valign="top" nowrap>&nbsp;</td>
            </tr>
		</cfif>
	</cfif>
	<!--- Print Supplier info --->
	<cfif stLastNo neq getartran.custno>
		<cfquery name="getCust" datasource="#dts#">
            select phone, phonea, add1, add2, add3, add4 from supplier where customerno = '#getartran.custno#'
		</cfquery>

		<cfoutput>
		<tr>
			<td colspan="2" valign="top" nowrap><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno#</strong></font></font></font></td>
			<td colspan="9"><font face="Times New Roman, Times, serif" size="1"><strong>#getartran.name# </strong> Tel: #getCust.phone# #getCust.phonea#</font></td>
            <td colspan="5">&nbsp;</td>
		</tr>
        <tr>
            <td colspan="16" valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></td>
        </tr>
		</cfoutput>
	</cfif>

	<cfoutput>
	<tr>
		<td valign="top" nowrap>&nbsp;</td>
		<td colspan="1"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#<cfif getartran.order_cl eq 'Y'> <strong>(CLEAR)</strong></cfif></font></font></font></td>
        <td colspan="2"><font face="Times New Roman, Times, serif"><font size="1"><div align="left">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</div></font></font></td>
        <cfquery name="getSOCode" datasource="#dts#">
        	select socode from gsetup
        </cfquery>
		<td><font face="Times New Roman, Times, serif"><font size="1">#getSOCode.socode##rem7#</font></font></td>
		<td colspan="12">&nbsp;</td>
	</tr>
	</cfoutput>

	<cfset stLastNo = getartran.custno>
    <cfset stLastPONO = getartran.refno>
	<cfset rem7 = getartran.rem7>
	<!--- Print details --->
	<cfquery name="getictran" datasource="#dts#">
        select a.* from ictran a, iclink b where a.refno ='#getartran.refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
		and a.itemno=b.itemno and a.type = 'PO' and b.frtype = 'PO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
    </cfquery>

	<cfloop query = "getictran">
		<cfoutput>
		<tr>
			<td height="10"><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
            <td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
            <td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>

			<!--- <cfquery name="getSOCode" datasource="#dts#">
            	select socode from gsetup
            </cfquery> --->
            <td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><!--- #getSOCode.socode##rem7# ---></font></font></div></td>

			<cfquery name="getRCCode" datasource="#dts#">
            	select rccode from gsetup
            </cfquery>

			<cfquery name="getReceive" datasource="#dts#">
				select * from iclink
				where type = 'RC' and frtype = 'PO' and frrefno = '#getictran.refno#' and itemno = '#getictran.itemno#' and frtrancode = '#getictran.trancode#'
            	<!--- select wos_date, qty_bil from ictran where type ='RC' and refno
            	= '#getictran.toinv#' and itemno = '#getictran.itemno#' and qty <> '0' --->
            </cfquery>
            <td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getRCCode.rccode##getreceive.refno# </cfloop></font></font></div></td>
            <td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#dateformat(getreceive.wos_date,"dd/mm/yyyy")# </cfloop></font></font></div></td>
            <td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>
            <!--- get the item qty received from the RC, and it was updated from PO --->
            <cfset RCqty = 0>

			<cfif getReceive.recordcount eq 0>
				<cfset RCqty = 0>
			<cfelse>
                <cfloop query = "getReceive">
					<cfset RCqty = RCqty + getReceive.qty>
                </cfloop>
            </cfif>

			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getreceive.qty#<cfif getreceive.recordcount gt 1><br></cfif></cfloop></font></font></div></td>

			<cfset Bal = 0>
            <cfset Bal = getictran.qty_bil - RCqty>

			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

			<cfquery name="getCurrCode2" datasource="#dts#">
            	select currcode from supplier where customerno ='#getictran.custno#'
            </cfquery>

			<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
			<cfset xprice= xprice_bil*getictran.currrate>

			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice,stDecl_UPrice)#</font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt,',_.__')#</font></div></td>
		</tr>
		</cfoutput>

		<cfset maxArray = right(CurrArray2[1][1],1)>

		<cfloop index = "i" from = "1" to = "#maxArray#">
			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
				<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
                <cfset CurrArray[i+1][5] = CurrArray[i+1][5] + getictran.amt>
                <cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
                <cfset CurrArray[i+1][7] = CurrArray[i+1][7] + RCQTY>
                <cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
              </cfif>

			  <cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
                <cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.amt_bil>
                <cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + getictran.amt>
                <cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.qty_bil>
                <cfset CurrArray1[i+1][7] = CurrArray1[i+1][7] + RCQTY>
                <cfset CurrArray1[i+1][8] = CurrArray1[i+1][8] + Bal>
              </cfif>

              <cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
                <cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
                <cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + getictran.amt>
                <cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
                <cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + RCQTY>
                <cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + Bal>
              </cfif>
              <cfset i = i + 1>
		</cfloop>
	</cfloop>
	</cfif>
</cfloop>
</cfif>
<!---
Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month
Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month
Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month
Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month
Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month	Month
--->
<cfif rgSort eq "Month">
	<cfset stLastNo = "">

	<cfloop query = "getartran">
		<cfquery name="checkiclink" datasource="#dts#">
			select type from iclink where frrefno = '#getartran.refno#' and frtype = 'PO'
		</cfquery>

		<cfquery name = "getRCQTY" datasource = "#dts#">
        	select sum(shipped) as T_QTY from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

		<cfif getRCQTY.T_QTY neq "">
			<cfset RC_Total_QTY = getRCQTY.T_QTY>
		<cfelse>
          	<cfset RC_Total_QTY = 0>
        </cfif>

		<cfquery name = "getPOQTY" datasource = "#dts#">
        	select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

		<cfif getPOQTY.qty_bil neq "">
          	<cfset PO_Total_QTY = getPOQTY.qty_bil>
        <cfelse>
          	<cfset PO_Total_QTY = 0>
        </cfif>

		<cfset Balance = PO_Total_QTY - RC_Total_QTY>
        <!--- If Balance is 0 then is Completed --->
        <cfif Balance eq 0 or checkiclink.recordcount gt 0>
			<!--- Print the sub-total --->
          	<cfif stLastPONo neq getartran.refno and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][6] neq 0>
                	<cfoutput>
					<tr>
                  		<td colspan="16"><hr></td>
                	</tr>
                	<tr>
						<td colspan="5" valign="top" nowrap>&nbsp;</td>
                  		<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][7]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][8]#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                	</tr>
					</cfoutput>
                	<!--- Clear the sub total --->
                	<cfset CurrArray[i+1][2] = 0>
                	<cfset CurrArray[i+1][3] = 0>
                	<cfset CurrArray[i+1][4] = 0>
                	<cfset CurrArray[i+1][5] = 0>
                	<cfset CurrArray[i+1][6] = 0>
                	<cfset CurrArray[i+1][7] = 0>
                	<cfset CurrArray[i+1][8] = 0>
              		</cfif>
            	</cfloop>
            	<tr>
              		<td colspan="16"><hr></td>
            	</tr>
          	</cfif>

		  	<cfif stLastNO neq year(getartran.wos_date) & month(getartran.wos_date)>
            	<!--- Print Grand Total --->
            	<cfset maxArray = right(CurrArray1[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray1[i+1][6] neq 0>
                	<cfoutput>
					<tr>
                  		<td colspan="5" valign="top" nowrap>&nbsp;</td>
                  		<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][6]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][7]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][8]#</font></div></td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][2],',_.__')#</font></div></td>
                  		<td>&nbsp;</td>
                  		<td>&nbsp;</td>
                  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][5],',_.__')#</font></div></td>
                  		<!--- Clear the grand total --->
                  		<cfset CurrArray1[i+1][2] = 0>
                  		<cfset CurrArray1[i+1][3] = 0>
                  		<cfset CurrArray1[i+1][4] = 0>
                  		<cfset CurrArray1[i+1][5] = 0>
                  		<cfset CurrArray1[i+1][6] = 0>
                  		<cfset CurrArray1[i+1][7] = 0>
                  		<cfset CurrArray1[i+1][8] = 0>
                	</tr>
					</cfoutput>
              		</cfif>
              		<cfset i = i + 1>
            	</cfloop>
            	<tr>
              		<td colspan="16" valign="top" nowrap>&nbsp;</td>
            	</tr>
          	</cfif>
          	<!--- Print Supplier info --->
          	<cfquery name="getCust" datasource="#dts#">
          		select phone, phonea, add1, add2, add3, add4 from supplier where customerno = '#getartran.custno#'
          	</cfquery>

			<cfoutput>
          	<tr>
            	<td colspan="2" valign="top" nowrap><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno#</strong></font></font></font></td>
            	<td colspan="9"><font face="Times New Roman, Times, serif" size="1"><strong>#getartran.name# </strong> Tel: #getCust.phone# #getCust.phonea#</font></td>
            	<td colspan="5">&nbsp;</td>
          	</tr>
          	<tr>
            	<td colspan="16" valign="top" nowrap> <font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></td>
          	</tr>
          	<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td colspan="1"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#<cfif getartran.order_cl eq 'Y'> <strong>(CLEAR)</strong></cfif></font></font></font></td>
            	<td colspan="2"><font face="Times New Roman, Times, serif"><font size="1"><div align="center">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></div></td>
            	<cfquery name="getSOCode" datasource="#dts#">
              		select socode from gsetup
              	</cfquery>
				<td><font face="Times New Roman, Times, serif"><font size="1">#getSOCode.socode##rem7#</font></font></td>
				<td colspan="12">&nbsp;</td>
          	</tr>
		  	</cfoutput>

		  	<cfset stLastNo = year(getartran.wos_date) & month(getartran.wos_date)>
          	<cfset stLastPONO = getartran.refno>
			<cfset rem7 = getartran.rem7>
          	<!--- Print details --->
          	<cfquery name="getictran" datasource="#dts#">
          		select a.* from ictran a, iclink b where a.refno ='#getartran.refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
				and a.itemno=b.itemno and a.type = 'PO' and b.frtype = 'PO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
          	</cfquery>

		  	<cfloop query = "getictran">
            	<cfoutput>
				<tr>
              		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
              		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
              		<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>

					<!--- <cfquery name="getSOCode" datasource="#dts#">
              			select socode from gsetup
              		</cfquery> --->

					<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><!--- #getSOCode.socode##rem7# ---></font></font></div></td>

					<cfquery name="getRCCode" datasource="#dts#">
              			select rccode from gsetup
              		</cfquery>

					<cfquery name="getReceive" datasource="#dts#">
						select * from iclink where type = 'RC' and frtype = 'PO' and frrefno = '#getictran.refno#'
						and itemno = '#getictran.itemno#' and frtrancode = '#getictran.trancode#'
              			<!--- select wos_date, qty_bil from ictran where type ='RC' and refno = '#getictran.toinv#' and itemno = '#getictran.itemno#' and qty <> '0' --->
              		</cfquery>

			  		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getRCCode.rccode##getreceive.refno# </cfloop></font></font></div></td>
              		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#dateformat(getreceive.wos_date,"dd/mm/yyyy")# </cfloop></font></font></div></td>
              		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>
              		<!--- get the item qty received from the RC, and it was updated from PO --->
              		<cfset RCqty = 0>

					<cfif getReceive.recordcount eq 0>
                		<cfset RCqty = 0>
                	<cfelse>
                		<cfloop query = "getReceive">
                  			<cfset RCqty = RCqty + getReceive.qty>
                		</cfloop>
              		</cfif>

			  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getreceive">#getreceive.qty#<cfif getreceive.recordcount gt 1><br></cfif></cfloop></font></font></div></td>

			  		<cfset Bal = 0>
              		<cfset Bal = getictran.qty_bil - RCqty>

			  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

			  		<cfquery name="getCurrCode2" datasource="#dts#">
              			select currcode from supplier where customerno ='#getictran.custno#'
              		</cfquery>

			  		<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
			  		<cfset xprice= xprice_bil*getictran.currrate>

			  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice,stDecl_UPrice)#</font></div></td>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt,',_.__')#</font></div></td>
            	</tr>
				</cfoutput>

				<cfset maxArray = right(CurrArray2[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                		<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
                		<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + getictran.amt>
                		<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
                		<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + RCQTY>
                		<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
              		</cfif>

			  		<cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
                		<cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.amt_bil>
                		<cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + getictran.amt>
                		<cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.qty_bil>
                		<cfset CurrArray1[i+1][7] = CurrArray1[i+1][7] + RCQTY>
                		<cfset CurrArray1[i+1][8] = CurrArray1[i+1][8] + Bal>
              		</cfif>

			  		<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
                		<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
                		<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + getictran.amt>
                		<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
                		<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + RCQTY>
                		<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + Bal>
              		</cfif>
              		<cfset i = i + 1>
            	</cfloop>
          	</cfloop>
        </cfif>
	</cfloop>
</cfif>

<!--- Print last sub-total --->
<cfset maxArray = right(CurrArray[1][1],1)>

<cfloop index = "i" from = "1" to = "#maxArray#">
	<cfif CurrArray[i+1][6] neq 0>
		<tr>
          	<td colspan="16"><hr></td>
        </tr>
        <tr>
          	<td valign="top" nowrap>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][6]#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][7]#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][8]#</cfoutput></font></div></td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][2],',_.__')#</cfoutput></font></div></td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][5],',_.__')#</cfoutput></font></div></td>
        </tr>
	</cfif>
</cfloop>
<tr>
	<td colspan="16"><hr></td>
</tr>

<cfif rgSort eq "Supplier Name" or rgSort eq "Supplier Code" or rgSort eq "Month">
	<!--- Print last Grand total --->
	<cfset maxArray = right(CurrArray1[1][1],1)>

	<cfloop index = "i" from = "1" to = "#maxArray#">
		<cfif CurrArray1[i+1][6] neq 0>
			<tr>
            	<td colspan="5" valign="top" nowrap>&nbsp;</td>
            	<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][6]#</cfoutput></font></div></td>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][7]#</cfoutput></font></div></td>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][8]#</cfoutput></font></div></td>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][1]#</cfoutput></font></div></td>
            	<td>&nbsp;</td>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][2],',_.__')#</cfoutput></font></div></td>
            	<td>&nbsp;</td>
            	<td>&nbsp;</td>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][5],',_.__')#</cfoutput></font></div></td>
          	</tr>
        </cfif>
	</cfloop>
	<tr>
		<td colspan="16"><hr></td>
	</tr>
</cfif>
<!--- Print Grand Total (FC) --->
<cfset maxArray = right(CurrArray2[1][1],1)>
<cfset DisplayTotal = 0>

<cfloop index = "i" from = "1" to = "#maxArray#">
	<cfif CurrArray2[i+1][2] neq 0 or CurrArray2[i+1][1] eq "SGD">
		<tr>
			<td colspan="5" valign="top" nowrap>&nbsp;</td>
          	<cfif DisplayTotal eq 0>
            	<td colspan="2"><div align="right"><strong>Grand Total (FC)</strong></div></td>
            	<cfset DisplayTotal = 1>
            <cfelse>
            	<td colspan="2">&nbsp;</td>
          	</cfif>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][6]#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][7]#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][8]#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][1]#</cfoutput></font></div></td>
          	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][2],',_.__')#</cfoutput></font></div></td>
          	<td>&nbsp;</td>
          	<!---<cfif CurrArray2[i+1][3] neq 0>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][4]/CurrArray2[i+1][3],'____.____')#</cfoutput></font></div></td>
          	<cfelse>
		    <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][3],'____.____')#</cfoutput></font></div></td>
		  	</cfif> --->
          	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][5],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          	<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          	<td>&nbsp;</td>
          	<cfset SGDEquiTotal = SGDEquiTotal + CurrArray2[i+1][5]>
          	<cfset TotalOrder = TotalOrder + CurrArray2[i+1][6]>
          	<cfset TotalDelived = TotalDelived + CurrArray2[i+1][7]>
          	<cfset TotalBalance = TotalBalance + CurrArray2[i+1][8]>
        </tr>
	</cfif>
	<cfset i = i + 1>
</cfloop>
<tr>
	<td colspan="16"><hr></td>
</tr>

<tr>
	<td valign="top" nowrap>&nbsp;</td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2"><div align="right"><strong>SGD Equivalent Total</strong></div></td>
    <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#TotalOrder#</cfoutput></font></div></td>
    <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#TotalDelived#</cfoutput></font></div></td>
    <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#TotalBalance#</cfoutput></font></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(SGDEquiTotal,',_.__')#</cfoutput></font></div></td>
</tr>
</table>
<br><hr>
<div align="right">
<cfif husergrpid eq "Muser">
	<a href="../home2.cfm" class="noprint"><u><font size="1" face="Arial, Helvetica, sans-serif">Home</font></u></a>
</cfif>
<font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
<!--- <input type="submit" name="Email" value="Email" class="noprint"> --->
</div>
</body>
</html>