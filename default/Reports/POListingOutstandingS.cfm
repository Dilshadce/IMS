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
  	select #prefix# as prefix, lastaccyear from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getartran">
  	Select * from artran where type = '#url.trancode#' and (void = '' or void is null) and order_cl = ''
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
<title>Outstanding Vendor Purchases Listing Summary By <cfoutput>#url.rgSort#</cfoutput></title>
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
    	<cfoutput>
	  		<h4><font color="##FF0000">Please add in email address for customer - #getheaderinfo.custno#.</font></h4>
    	</cfoutput>
		<cfabort>
  	<cfelse>
		<cflocation url="invoiceemail.cfm?nexttranno=#nexttranno#&tran=#tran#&custemail=#getemail.e_mail#&tranname=#tranname#&prefix=#getgeneral.prefix#">
  	</cfif>
</cfif>

<body>
<cfform name="form1" action="">
	<cfif getartran.refno eq "">
    	<cfoutput>
      		<h4><font color="##FF0000">No Report Generated.</font></h4>
    	</cfoutput>
    	<cfabort>
  	</cfif>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
      	<td colspan="10"><div align="center"><font size="4" face="Arial black"><strong>MSD
          	ENGINEERING PTE LTD</strong></font><br>
          	<font size="1" face="Times New Roman, Times, serif">23 HILLVIEW TERRACE</font><br>
          	<font size="1" face="Times New Roman, Times, serif">SINGAPORE 669234</font><br>
          	<font size="1" face="Times New Roman, Times, serif">TEL :(65) 6462 9119&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FAX
          	:(65) 6462 9118</font><br>
          	<font size="1" face="Times New Roman, Times, serif">ROC/GST NO.: 200504367W</font></div></td>
	</tr>
    <tr>
      	<td colspan="8"><font size="1" face="Times New Roman, Times, serif"><strong>Outstanding Vendor Purchases Listing Summary By <cfoutput>#url.rgsort#</cfoutput></strong></font></td>
      	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">Date: <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
    </tr>
    <tr>
      	<td colspan="10"><hr></td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
      	<td colspan="3" nowrap><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td colspan="3"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Foreign Currency</strong></font></div></td>
      	<td nowrap><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Exchg Rate</strong></font></div></td>
      	<td colspan="3"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>SGD Equialent</strong></font></div></td>
    </tr>
    <tr>
      	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>&nbsp;</strong></font></div></td>
      	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong><!---Item No.---></strong></font></div></td>
      	<!---<td width="5%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Qty Ordered</strong></font></div></td>
      	<td width="5%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>YTD Rec'd</strong></font></div></td>
      	<td width="5%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Current Qty Rec'd</strong></font></div></td>
      	<td width="5%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Balance</strong></font></div></td>--->
      	<td><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Currcy</strong></font></div></td>
      	<td nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total PO Value</strong></font></div></td>
      	<td nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Rec'd Value</strong></font></div></td>
      	<td nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Outstnd Value</strong></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"></font></div></td>
      	<td nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total PO Value</strong></font></div></td>
      	<td nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Rec'd</strong></font></div></td>
      	<td nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Outstnd Value</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="10"><hr></td>
    </tr>
    <cfset stLastNo = "">
    <cfset stLastPONO = "">
    <cfset stLastCurr = "">
    <!--- For Grand FC Total --->
    <cfset CurrArray2 = ArrayNew(2)>
    <cfset CurrArray2[1][1] = "Currency - ">
    <cfset CurrArray2[1][2] = "QtyOrder">
    <cfset CurrArray2[1][3] = "YTDReceived">
    <cfset CurrArray2[1][4] = "CurrentReceived">
    <cfset CurrArray2[1][5] = "Balance">
    <cfset CurrArray2[1][6] = "FC.PO">
    <cfset CurrArray2[1][7] = "FC.Total.Received">
    <cfset CurrArray2[1][8] = "FC.Outstanding">
    <cfset CurrArray2[1][9] = "SGD.PO">
    <cfset CurrArray2[1][10] = "SGD.Total.Received">
    <cfset CurrArray2[1][11] = "SGD.Outstanding">
    <!--- Put SGD first, and init --->
    <cfset CurrArray2[2][1] = "SGD">
    <cfset CurrArray2[2][2] = 0>
    <cfset CurrArray2[2][3] = 0>
    <cfset CurrArray2[2][4] = 0>
    <cfset CurrArray2[2][5] = 0>
    <cfset CurrArray2[2][6] = 0>
    <cfset CurrArray2[2][7] = 0>
    <cfset CurrArray2[2][8] = 0>
    <cfset CurrArray2[2][9] = 0>
    <cfset CurrArray2[2][10] = 0>
    <cfset CurrArray2[2][11] = 0>

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
        	<cfset CurrArray2[i][9] = 0>
        	<cfset CurrArray2[i][10] = 0>
        	<cfset CurrArray2[i][11] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray2[1][1] = CurrArray2[1][1] & ToString(#i# - 2)>
    <!---     <cfset SGDEquiTotal = 0> --->
    <cfset TotalOrder = 0>
    <cfset TotalYTD = 0>
    <cfset TotalCurrent = 0>
    <cfset TotalBalance = 0>
    <cfset T_FC_PO = 0>
    <cfset T_FC_Receive = 0>
    <cfset T_FC_Outstanding = 0>
    <cfset T_SGD_PO = 0>
    <cfset T_SGD_Receive = 0>
    <cfset T_SGD_Outstanding = 0>
    <!--- For Grand Total --->
    <cfset CurrArray1 = ArrayNew(2)>
    <cfset CurrArray1[1][1] = "Currency - ">
    <cfset CurrArray1[1][2] = "QtyOrder">
    <cfset CurrArray1[1][3] = "YTDReceived">
    <cfset CurrArray1[1][4] = "CurrentReceived">
    <cfset CurrArray1[1][5] = "Balance">
    <cfset CurrArray1[1][6] = "FC.PO">
    <cfset CurrArray1[1][7] = "FC.Total.Received">
    <cfset CurrArray1[1][8] = "FC.Outstanding">
    <cfset CurrArray1[1][9] = "SGD.PO">
    <cfset CurrArray1[1][10] = "SGD.Total.Received">
    <cfset CurrArray1[1][11] = "SGD.Outstanding">
    <cfset CurrArray1[2][1] = "SGD">
    <cfset CurrArray1[2][2] = 0>
    <cfset CurrArray1[2][3] = 0>
    <cfset CurrArray1[2][4] = 0>
    <cfset CurrArray1[2][5] = 0>
    <cfset CurrArray1[2][6] = 0>
    <cfset CurrArray1[2][7] = 0>
    <cfset CurrArray1[2][8] = 0>
    <cfset CurrArray1[2][9] = 0>
    <cfset CurrArray1[2][10] = 0>
    <cfset CurrArray1[2][11] = 0>

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
			<cfset CurrArray1[i][9] = 0>
			<cfset CurrArray1[i][10] = 0>
			<cfset CurrArray1[i][11] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray1[1][1] = CurrArray1[1][1] & ToString(#i# - 2)>
    <!--- For Sub Total --->
    <cfset CurrArray = ArrayNew(2)>
    <cfset CurrArray[1][1] = "Currency - ">
    <cfset CurrArray[1][2] = "QtyOrder">
    <cfset CurrArray[1][3] = "YTDReceived">
    <cfset CurrArray[1][4] = "CurrentReceived">
    <cfset CurrArray[1][5] = "Balance">
    <cfset CurrArray[1][6] = "FC.PO">
    <cfset CurrArray[1][7] = "FC.Total.Received">
    <cfset CurrArray[1][8] = "FC.Outstanding">
    <cfset CurrArray[1][9] = "SGD.PO">
    <cfset CurrArray[1][10] = "SGD.Total.Received">
    <cfset CurrArray[1][11] = "SGD.Outstanding">
    <cfset CurrArray[2][1] = "SGD">
    <cfset CurrArray[2][2] = 0>
    <cfset CurrArray[2][3] = 0>
    <cfset CurrArray[2][4] = 0>
    <cfset CurrArray[2][5] = 0>
    <cfset CurrArray[2][6] = 0>
    <cfset CurrArray[2][7] = 0>
    <cfset CurrArray[2][8] = 0>
    <cfset CurrArray[2][9] = 0>
    <cfset CurrArray[2][10] = 0>
    <cfset CurrArray[2][11] = 0>

	<cfquery name="getCurrCode" datasource="#dts#">
    	select CurrCode from Currencyrate order by currcode
    </cfquery>

	<cfset i = 3>

	<cfloop query="getCurrCode">
		<cfif getCurrCode.CurrCode neq "SGD">
			<cfset CurrArray[i][1] = getCurrCode.CurrCode>
			<cfset CurrArray[i][2] = 0>
			<cfset CurrArray[i][3] = 0>
			<cfset CurrArray[i][4] = 0>
			<cfset CurrArray[i][5] = 0>
			<cfset CurrArray[i][6] = 0>
			<cfset CurrArray[i][7] = 0>
			<cfset CurrArray[i][8] = 0>
			<cfset CurrArray[i][9] = 0>
			<cfset CurrArray[i][10] = 0>
			<cfset CurrArray[i][11] = 0>
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
		<cfquery name = "getrcqty" datasource = "#dts#">
        	select sum(qty) as qty_bil from iclink where type = 'RC' and frtype = 'PO' and frrefno = '#getartran.refno#'
        </cfquery>

		<cfset RC_Total_QTY = 0>
        <!---<cfloop query = "getrcqty"> --->
        <cfif getrcqty.qty_bil neq "">
          	<cfset RC_Total_QTY = <!--- #RC_Total_QTY# + --->getrcqty.qty_bil>
        </cfif>
        <!--- </cfloop> --->
        <cfquery name = "getPOQTY" datasource = "#dts#">
        	select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

		<cfset PO_Total_QTY = 0>
        <!--- <cfloop query = "getPOQTY"> --->
        <cfif getPOQTY.qty_bil neq "">
          	<cfset PO_Total_QTY = <!--- #PO_Total_QTY# + --->getPOQTY.qty_bil>
        </cfif>
        <!--- </cfloop> --->
        <cfset Balance = PO_Total_QTY - RC_Total_QTY>
        <!--- If Balance is not 0 then is Outstanding --->
        <cfif Balance neq 0>
          	<!--- Print the sub-total --->
          	<cfif stLastNo neq getartran.refno and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][6] neq 0>
                		<cfoutput>
						<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
                  			<td colspan="10"><hr></td>
                  			<td>&nbsp;</td>
                		</tr>
                		<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
                  			<td><div align="right"><strong>Total</strong></div></td>
                  			<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][2]#---></font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][3]#---></font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][4]#---></font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][5]#---></font></div></td>--->
                  			<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
                  			<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"></font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
                		</tr>
						</cfoutput>
                		<tr>
                  			<td colspan="10"><hr></td>
                		</tr>
						<!--- Clear the sub total --->
						<cfset CurrArray[i+1][2] = 0>
						<cfset CurrArray[i+1][3] = 0>
						<cfset CurrArray[i+1][4] = 0>
						<cfset CurrArray[i+1][5] = 0>
						<cfset CurrArray[i+1][6] = 0>
						<cfset CurrArray[i+1][7] = 0>
						<cfset CurrArray[i+1][8] = 0>
						<cfset CurrArray[i+1][9] = 0>
						<cfset CurrArray[i+1][10] = 0>
						<cfset CurrArray[i+1][11] = 0>
              		</cfif>
				</cfloop>
            	<tr>
              		<td colspan="10" valign="top" nowrap>&nbsp;</td>
            	</tr>
          	</cfif>
          	<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Code</strong></font></font></div></td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Name</strong></font></font></div></td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>PO Date</strong></font></font></div></td>
            	<td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>Our PO No</strong></font></font><font size="1"></font></font></div></td>
            	<td></td>
				<td></td>
            	<td colspan="3" nowrap><strong><font size="1" face="Times New Roman, Times, serif">Contract No</font></strong></td>
          	</tr>
		  	<cfoutput>
          	<tr>
		  		<td valign="top" nowrap>&nbsp;</td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
            	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
            	<td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></div></td>
            	<td></td>
				<td nowrap><div align="center"><font size="1" face="Times New Roman, Times, serif">#getartran.currrate#</font></div></td>
            	<td colspan="3" nowrap><font size="1" face="Times New Roman, Times, serif">#getartran.rem7#</font></td>
          	</tr>
		  	</cfoutput>
          	<!---<tr>
            <td valign="top" nowrap>&nbsp;</td>
            <td colspan="13"><hr></td>
            <td>&nbsp;</td>
          	</tr> --->
          	<cfset stLastNo = getartran.refno>
          	<!--- Print details --->

		  	<cfquery name="getictran" datasource="#dts#">
          		select * from ictran where refno ='#getartran.refno#' and type = 'PO' and qty <> '0' order by itemcount
          	</cfquery>

		  	<cfloop query = "getictran">
            	<cfquery name="getYTD" datasource="#dts#">
            		select sum(a.qty) as QTY_YTD, sum(b.amt_bil) as FC_amt1, sum(b.amt)as SGD_amt1 from iclink a, ictran b
					where a.frrefno = b.refno and a.frtype = b.type and b.refno = '#getictran.refno#' and b.type = 'PO'
					and a.type = 'RC' and a.itemno = b.itemno and b.itemno = '#getictran.itemno#' and a.frtrancode = '#getictran.trancode#'
            		<!--- select sum(qty_bil) as QTY_YTD, sum(amt_bil) as FC_amt1, sum(amt)
            		as SGD_amt1 from ictran where type = 'RC' and dono = '#stLastNo#'
            		and itemno = '#getictran.itemno#' and qty <> '0' --->
            	</cfquery>

				<cfif getYTD.QTY_YTD eq "">
              		<cfset getYTD.QTY_YTD = 0>
              		<cfset getYTD.FC_amt1 = 0>
              		<cfset getYTD.SGD_amt1 = 0>
            	</cfif>

				<cfquery name="getCurr_Receive" datasource="#dts#">
            		select qty as qty_bil from iclink where type = 'RC' and frtype = 'PO'
            		and itemno = '#getictran.itemno#' and frrefno = '#getictran.refno#'
            		and frtrancode = '#getictran.trancode#' order by wos_date
            	</cfquery>

				<cfset cnt = getCurr_Receive.recordcount>

				<cfif cnt neq 0>
              		<cfloop query = "getCurr_Receive" startrow="#cnt#">
                		<cfset Curr_Qty = getCurr_Receive.qty_bil>
              		</cfloop>
              	<cfelse>
              		<cfset Curr_Qty = 0>
            	</cfif>

				<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>

				<cfquery name="getCurrCode2" datasource="#dts#">
            		select currcode from supplier where customerno ='#getictran.custno#'
            	</cfquery>

				<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
            	<cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
            	<cfset maxArray = right(CurrArray2[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                		<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.qty_bil>
						<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getYTD.QTY_YTD>
						<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + Curr_Qty>
						<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + Bal>
						<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.amt_bil>
						<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + getYTD.FC_amt1>
						<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + FC_Outstanding>
						<cfset CurrArray[i+1][9] = CurrArray[i+1][9] + getictran.amt>
						<cfset CurrArray[i+1][10] = CurrArray[i+1][10] + getYTD.SGD_amt1>
						<cfset CurrArray[i+1][11] = CurrArray[i+1][11] + SGD_Outstanding>
              		</cfif>

              		<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
						<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.qty_bil>
						<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getYTD.QTY_YTD>
						<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + Curr_Qty>
						<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + Bal>
						<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.amt_bil>
						<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + getYTD.FC_amt1>
						<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + FC_Outstanding>
						<cfset CurrArray2[i+1][9] = CurrArray2[i+1][9] + getictran.amt>
						<cfset CurrArray2[i+1][10] = CurrArray2[i+1][10] + getYTD.SGD_amt1>
						<cfset CurrArray2[i+1][11] = CurrArray2[i+1][11] + SGD_Outstanding>
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
		<cfquery name = "getrcqty" datasource = "#dts#">
        	select sum(qty) as qty_bil from iclink where type = 'RC' and frtype =
        	'PO' and frrefno = '#getartran.refno#'
        </cfquery>

		<cfset RC_Total_QTY = 0>

		<cfif getrcqty.qty_bil neq "">
          	<cfset RC_Total_QTY = getrcqty.qty_bil>
        </cfif>

		<cfquery name = "getPOQTY" datasource = "#dts#">
        	select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

		<cfset PO_Total_QTY = 0>

        <cfif getPOQTY.qty_bil neq "">
			<cfset PO_Total_QTY = getPOQTY.qty_bil>
        </cfif>

		<cfset Balance = PO_Total_QTY - RC_Total_QTY>
        <!--- If Balance is not 0 then is Outstanding --->
        <cfif Balance neq 0>
			<!--- Print the sub-total --->
          	<cfif stLastPONo neq getartran.refno and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][6] neq 0>
                		<cfoutput>
						<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
                  			<td colspan="10">&nbsp;</td>
                  			<td>&nbsp;</td>
                		</tr>
                		<tr>
						  	<td valign="top" nowrap>&nbsp;</td>
						  	<td><div align="right"><strong>Total</strong></div></td>
						  	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][2]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][3]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][4]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][5]#---></font></div></td>--->
						  	<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
						  	<td><div align="right"></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
						</tr>
						</cfoutput>
                		<tr>
                  			<td colspan="10"><hr></td>
                		</tr>
                		<!--- Clear the sub total --->
						<cfset CurrArray[i+1][2] = 0>
						<cfset CurrArray[i+1][3] = 0>
						<cfset CurrArray[i+1][4] = 0>
						<cfset CurrArray[i+1][5] = 0>
						<cfset CurrArray[i+1][6] = 0>
						<cfset CurrArray[i+1][7] = 0>
						<cfset CurrArray[i+1][8] = 0>
						<cfset CurrArray[i+1][9] = 0>
						<cfset CurrArray[i+1][10] = 0>
						<cfset CurrArray[i+1][11] = 0>
              		</cfif>
				</cfloop>
			</cfif>

			<cfif stLastNO neq getartran.name>
            <!--- Print Grand Total --->
            <cfset maxArray = right(CurrArray1[1][1],1)>
            <cfset DisplayTotal = 0>

			<cfloop index = "i" from = "1" to = "#maxArray#">
				<cfif CurrArray1[i+1][6] neq 0>
                	<cfoutput>
					<tr>
                  		<td valign="top" nowrap>&nbsp;</td>
                  		<cfif DisplayTotal eq 0>
                    		<td><div align="right"><strong>Grand Total</strong></div></td>
                    		<cfset DisplayTotal = 1>
                    	<cfelse>
                    		<td>&nbsp;</td>
                  		</cfif>
                  		<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][2]#---></font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][3]#---></font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][4]#---></font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][5]#---></font></div></td>--->
					  	<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][6],',_.__')#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][7],',_.__')#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][8],',_.__')#</font></div></td>
					  	<td>&nbsp;</td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][9],',_.__')#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][10],',_.__')#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][11],',_.__')#</font></div></td>
					</tr>
					</cfoutput>
                	<!--- Clear the grand total --->
                	<cfset CurrArray1[i+1][2] = 0>
                	<cfset CurrArray1[i+1][3] = 0>
                	<cfset CurrArray1[i+1][4] = 0>
                	<cfset CurrArray1[i+1][5] = 0>
                	<cfset CurrArray1[i+1][6] = 0>
                	<cfset CurrArray1[i+1][7] = 0>
                	<cfset CurrArray1[i+1][8] = 0></tr>
              	</cfif>
              	<cfset i = i + 1>
            </cfloop>
            <tr>
              	<td colspan="10" valign="top" nowrap>&nbsp;</td>
            </tr>
		</cfif>
		<tr>
			<td valign="top" nowrap>&nbsp;</td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Code</strong></font></font></div></td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Name</strong></font></font></div></td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>PO Date</strong></font></font></div></td>
            <td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>Our PO No</strong></font></font><font size="1"></font></font></div></td>
            <td>&nbsp;</td>
			<td></td>
            <td nowrap><strong><font size="1" face="Times New Roman, Times, serif">Contract No</font></strong></td>
		</tr>
		<cfoutput>
		<tr>
			<td nowrap valign="top">&nbsp;</td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
            <td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
            <td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
			<td></td>
            <td nowrap><div align="center"><font size="1" face="Times New Roman, Times, serif">#getartran.currrate#</font></div></td>
            <td colspan="3"><font size="1" face="Times New Roman, Times, serif">#getartran.rem7#</font></td>
		</tr>
		</cfoutput>
        <!---<tr>
        <td valign="top" nowrap>&nbsp;</td>
        <td colspan="13"><hr></td>
        <td>&nbsp;</td>
        </tr> --->
        <cfset stLastNo = getartran.name>
		<cfset stLastPONo = getartran.refno>
		<!--- Print details --->

		<cfquery name="getictran" datasource="#dts#">
			select * from ictran where refno ='#getartran.refno#' and type = 'PO'
          	and qty <> '0' order by itemcount
		</cfquery>

		<cfloop query = "getictran">
			<cfquery name="getYTD" datasource="#dts#">
            	select sum(a.qty) as QTY_YTD, sum(b.amt_bil) as FC_amt1, sum(b.amt)as SGD_amt1 from iclink a, ictran b
				where a.frrefno = b.refno and a.frtype = b.type and b.refno = '#getictran.refno#' and b.type = 'PO'
				and a.type = 'RC' and a.itemno = b.itemno and b.itemno = '#getictran.itemno#' and a.frtrancode = '#getictran.trancode#'
            </cfquery>

			<cfif getYTD.QTY_YTD eq "">
				<cfset getYTD.QTY_YTD = 0>
              	<cfset getYTD.FC_amt1 = 0>
              	<cfset getYTD.SGD_amt1 = 0>
            </cfif>

			<cfquery name="getCurr_Receive" datasource="#dts#">
            	select qty as qty_bil from iclink where type = 'RC' and frtype = 'PO'
            	and itemno = '#getictran.itemno#' and frrefno = '#getictran.refno#'
            	and frtrancode = '#getictran.trancode#' order by wos_date
            </cfquery>

			<cfset cnt = getCurr_Receive.recordcount>

			<cfif cnt neq 0>
				<cfloop query = "getCurr_Receive" startrow="#cnt#">
                	<cfset Curr_Qty = getCurr_Receive.qty_bil>
              	</cfloop>
			<cfelse>
              	<cfset Curr_Qty = 0>
            </cfif>

			<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>

			<cfquery name="getCurrCode2" datasource="#dts#">
            	select currcode from supplier where customerno ='#getictran.custno#'
            </cfquery>

			<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
            <cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
            <cfset maxArray = right(CurrArray2[1][1],1)>

            <cfloop index = "i" from = "1" to = "#maxArray#">
				<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.qty_bil>
					<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getYTD.QTY_YTD>
					<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + Curr_Qty>
					<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + Bal>
					<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.amt_bil>
					<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + getYTD.FC_amt1>
					<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + FC_Outstanding>
					<cfset CurrArray[i+1][9] = CurrArray[i+1][9] + getictran.amt>
					<cfset CurrArray[i+1][10] = CurrArray[i+1][10] + getYTD.SGD_amt1>
					<cfset CurrArray[i+1][11] = CurrArray[i+1][11] + SGD_Outstanding>
              	</cfif>

              	<cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
                	<cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.qty_bil>
                	<cfset CurrArray1[i+1][3] = CurrArray1[i+1][3] + getYTD.QTY_YTD>
                	<cfset CurrArray1[i+1][4] = CurrArray1[i+1][4] + Curr_Qty>
                	<cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + Bal>
                	<cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.amt_bil>
                	<cfset CurrArray1[i+1][7] = CurrArray1[i+1][7] + getYTD.FC_amt1>
                	<cfset CurrArray1[i+1][8] = CurrArray1[i+1][8] + FC_Outstanding>
                	<cfset CurrArray1[i+1][9] = CurrArray1[i+1][9] + getictran.amt>
                	<cfset CurrArray1[i+1][10] = CurrArray1[i+1][10] + getYTD.SGD_amt1>
                	<cfset CurrArray1[i+1][11] = CurrArray1[i+1][11] + SGD_Outstanding>
              	</cfif>

              	<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
                	<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.qty_bil>
					<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getYTD.QTY_YTD>
					<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + Curr_Qty>
					<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + Bal>
					<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.amt_bil>
					<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + getYTD.FC_amt1>
					<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + FC_Outstanding>
					<cfset CurrArray2[i+1][9] = CurrArray2[i+1][9] + getictran.amt>
					<cfset CurrArray2[i+1][10] = CurrArray2[i+1][10] + getYTD.SGD_amt1>
					<cfset CurrArray2[i+1][11] = CurrArray2[i+1][11] + SGD_Outstanding>
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
		<cfquery name = "getrcqty" datasource = "#dts#">
        	select sum(qty) as qty_bil from iclink where type = 'RC' and frtype = 'PO' and frrefno = '#getartran.refno#'
        </cfquery>

		<cfset RC_Total_QTY = 0>

		<cfif getrcqty.qty_bil neq "">
			<cfset RC_Total_QTY = getrcqty.qty_bil>
        </cfif>

        <cfquery name = "getPOQTY" datasource = "#dts#">
        	select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

        <cfset PO_Total_QTY = 0>

		<cfif getPOQTY.qty_bil neq "">
			<cfset PO_Total_QTY = getPOQTY.qty_bil>
        </cfif>

        <cfset Balance = PO_Total_QTY - RC_Total_QTY>
        <!--- If Balance is not 0 then is Outstanding --->
        <cfif Balance neq 0>
          	<!--- Print the sub-total --->
          	<cfif stLastPONo neq getartran.refno and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][6] neq 0>
                		<cfoutput>
						<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
                  			<td colspan="13"><hr></td>
                  			<td>&nbsp;</td>
                		</tr>
                		<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
						  	<td><div align="right"><strong>Total</strong></div></td>
						  	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][2]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][3]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][4]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][5]#---></font></div></td>--->
							<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
						  	<td nowrap><div align="right"></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
						</tr>
						</cfoutput>
                		<tr>
                  			<td colspan="13"><hr></td>
                		</tr>
						<!--- Clear the sub total --->
						<cfset CurrArray[i+1][2] = 0>
						<cfset CurrArray[i+1][3] = 0>
						<cfset CurrArray[i+1][4] = 0>
						<cfset CurrArray[i+1][5] = 0>
						<cfset CurrArray[i+1][6] = 0>
						<cfset CurrArray[i+1][7] = 0>
						<cfset CurrArray[i+1][8] = 0>
						<cfset CurrArray[i+1][9] = 0>
						<cfset CurrArray[i+1][10] = 0>
						<cfset CurrArray[i+1][11] = 0>
              		</cfif>
				</cfloop>
			</cfif>

			<cfif stLastNO neq getartran.custno>
            <!--- Print Grand Total --->
            <cfset maxArray = right(CurrArray1[1][1],1)>
            <cfset DisplayTotal = 0>

            <cfloop index = "i" from = "1" to = "#maxArray#">
				<cfif CurrArray1[i+1][6] neq 0>
                	<cfoutput>
					<tr>
                  		<td valign="top" nowrap>&nbsp;</td>
                  		<cfif DisplayTotal eq 0>
                    		<td><div align="right"><strong>Grand Total</strong></div></td>
                    		<cfset DisplayTotal = 1>
                    	<cfelse>
                    		<td>&nbsp;</td>
                  		</cfif>
                  		<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][2]#---></font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][3]#---></font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][4]#---></font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][5]#---></font></div></td>--->
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][6],',_.__')#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][7],',_.__')#</font></div></td>
					 	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][8],',_.__')#</font></div></td>
					  	<td>&nbsp;</td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][9],',_.__')#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][10],',_.__')#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][11],',_.__')#</font></div></td>
                	</tr>
					</cfoutput>
                	<!--- Clear the grand total --->
					<cfset CurrArray1[i+1][2] = 0>
					<cfset CurrArray1[i+1][3] = 0>
					<cfset CurrArray1[i+1][4] = 0>
					<cfset CurrArray1[i+1][5] = 0>
					<cfset CurrArray1[i+1][6] = 0>
					<cfset CurrArray1[i+1][7] = 0>
					<cfset CurrArray1[i+1][8] = 0>
				</cfif>
              	<cfset i = i + 1>
			</cfloop>
            <tr>
              	<td colspan="13" valign="top" nowrap>&nbsp;</td>
            </tr>
		</cfif>
		<!--- Print Supplier info --->
		<tr>
			<td valign="top" nowrap>&nbsp;</td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Code</strong></font></font></div></td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Name</strong></font></font></div></td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>PO Date</strong></font></font></div></td>
            <td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>Our PO No</strong></font></font><font size="1"></font></font></div></td>
            <td>&nbsp;</td>
			<td></td>
            <td nowrap><strong><font size="1" face="Times New Roman, Times, serif">Contract No</font></strong></td>
		</tr>
		<cfoutput>
		<tr>
			<td valign="top" nowrap>&nbsp;</td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
            <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
            <td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
            <td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
			<td></td>
            <td nowrap><div align="center"><font size="1" face="Times New Roman, Times, serif">#currrate#</font></div></td>
            <td colspan="3"><font size="1" face="Times New Roman, Times, serif">#getartran.rem7#</font></td>
		</tr>
		</cfoutput>
        <!--- <tr>
        <td valign="top" nowrap>&nbsp;</td>
        <cfif stLastNo neq #getartran.custno# or stLastNo eq "">
        <td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
        <td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
        <cfelse>
        <td colspan="6">&nbsp;</td>
        </cfif>
        <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
        <td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
        <td colspan="3">&nbsp;</td>
        </tr> --->
        <!---<tr>
        <td valign="top" nowrap>&nbsp;</td>
        <td colspan="13"><hr></td>
        <td>&nbsp;</td>
        </tr>--->
		<cfset stLastNo = getartran.custno>
		<cfset stLastPONo = getartran.refno>
		<!--- Print details --->
		<cfquery name="getictran" datasource="#dts#">
			select * from ictran where refno ='#getartran.refno#' and type = 'PO'
          	and qty <> '0' order by itemcount
		</cfquery>

		<cfloop query = "getictran">
			<cfquery name="getYTD" datasource="#dts#">
           	 	select sum(a.qty) as QTY_YTD, sum(b.amt_bil) as FC_amt1, sum(b.amt)as SGD_amt1 from iclink a, ictran b
				where a.frrefno = b.refno and a.frtype = b.type and b.refno = '#getictran.refno#' and b.type = 'PO' and a.type = 'RC'
				and a.itemno = b.itemno and b.itemno = '#getictran.itemno#' and a.frtrancode = '#getictran.trancode#'
            </cfquery>

			<cfif getYTD.QTY_YTD eq "">
              	<cfset getYTD.QTY_YTD = 0>
              	<cfset getYTD.FC_amt1 = 0>
              	<cfset getYTD.SGD_amt1 = 0>
            </cfif>

			<cfquery name="getCurr_Receive" datasource="#dts#">
            	select qty as qty_bil from iclink where type = 'RC' and frtype = 'PO' and itemno = '#getictran.itemno#'
				and frrefno = '#getictran.refno#' and frtrancode = '#getictran.trancode#' order by wos_date
            </cfquery>

			<cfset cnt = getCurr_Receive.recordcount>

			<cfif cnt neq 0>
				<cfloop query = "getCurr_Receive" startrow="#cnt#">
                	<cfset Curr_Qty = getCurr_Receive.qty_bil>
              	</cfloop>
			<cfelse>
              	<cfset Curr_Qty = 0>
            </cfif>

			<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>

            <cfquery name="getCurrCode2" datasource="#dts#">
            	select currcode from supplier where customerno ='#getictran.custno#'
            </cfquery>

			<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
            <cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
            <cfset maxArray = right(CurrArray2[1][1],1)>

			<cfloop index = "i" from = "1" to = "#maxArray#">
				<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                	<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.qty_bil>
                	<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getYTD.QTY_YTD>
					<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + Curr_Qty>
					<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + Bal>
					<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.amt_bil>
					<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + getYTD.FC_amt1>
					<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + FC_Outstanding>
					<cfset CurrArray[i+1][9] = CurrArray[i+1][9] + getictran.amt>
					<cfset CurrArray[i+1][10] = CurrArray[i+1][10] + getYTD.SGD_amt1>
					<cfset CurrArray[i+1][11] = CurrArray[i+1][11] + SGD_Outstanding>
              	</cfif>

			  	<cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
                	<cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.qty_bil>
					<cfset CurrArray1[i+1][3] = CurrArray1[i+1][3] + getYTD.QTY_YTD>
					<cfset CurrArray1[i+1][4] = CurrArray1[i+1][4] + Curr_Qty>
					<cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + Bal>
					<cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.amt_bil>
					<cfset CurrArray1[i+1][7] = CurrArray1[i+1][7] + getYTD.FC_amt1>
					<cfset CurrArray1[i+1][8] = CurrArray1[i+1][8] + FC_Outstanding>
					<cfset CurrArray1[i+1][9] = CurrArray1[i+1][9] + getictran.amt>
					<cfset CurrArray1[i+1][10] = CurrArray1[i+1][10] + getYTD.SGD_amt1>
					<cfset CurrArray1[i+1][11] = CurrArray1[i+1][11] + SGD_Outstanding>
              	</cfif>

              	<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
					<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.qty_bil>
					<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getYTD.QTY_YTD>
					<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + Curr_Qty>
					<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + Bal>
					<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.amt_bil>
					<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + getYTD.FC_amt1>
					<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + FC_Outstanding>
					<cfset CurrArray2[i+1][9] = CurrArray2[i+1][9] + getictran.amt>
					<cfset CurrArray2[i+1][10] = CurrArray2[i+1][10] + getYTD.SGD_amt1>
					<cfset CurrArray2[i+1][11] = CurrArray2[i+1][11] + SGD_Outstanding>
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
		<cfquery name = "getrcqty" datasource = "#dts#">
        	select sum(qty) as qty_bil from iclink where type = 'RC' and frtype = 'PO' and frrefno = '#getartran.refno#'
        </cfquery>

		<cfset RC_Total_QTY = 0>

		<cfif getrcqty.qty_bil neq "">
          	<cfset RC_Total_QTY = getrcqty.qty_bil>
        </cfif>

        <cfquery name = "getPOQTY" datasource = "#dts#">
        	select sum(qty_bil) as qty_bil from ictran where type ='PO' and refno = '#getartran.refno#' and qty <> '0'
        </cfquery>

        <cfset PO_Total_QTY = 0>

		<cfif getPOQTY.qty_bil neq "">
          	<cfset PO_Total_QTY = getPOQTY.qty_bil>
        </cfif>

        <cfset Balance = PO_Total_QTY - RC_Total_QTY>
        <!--- If Balance is not 0 then is Outstanding --->
        <cfif Balance neq 0>
          	<!--- Print the sub-total --->
          	<cfif stLastPONo neq getartran.refno and stLastNo neq "">
            	<cfset maxArray = right(CurrArray[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][6] neq 0>
                		<cfoutput>
						<tr>
						  	<td valign="top" nowrap>&nbsp;</td>
						  	<td colspan="13"><hr></td>
						  	<td>&nbsp;</td>
						</tr>
                		<tr>
						  	<td valign="top" nowrap>&nbsp;</td>
						  	<td><div align="right"><strong>Total</strong></div></td>
						  	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][2]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][3]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][4]#---></font></div></td>
						 	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray[i+1][5]#---></font></div></td>--->
						  	<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
						  	<td></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
						</tr>
						</cfoutput>
                		<tr>
                  			<td colspan="13"><hr></td>
                		</tr>
						<!--- Clear the sub total --->
						<cfset CurrArray[i+1][2] = 0>
						<cfset CurrArray[i+1][3] = 0>
						<cfset CurrArray[i+1][4] = 0>
						<cfset CurrArray[i+1][5] = 0>
						<cfset CurrArray[i+1][6] = 0>
						<cfset CurrArray[i+1][7] = 0>
						<cfset CurrArray[i+1][8] = 0>
						<cfset CurrArray[i+1][9] = 0>
						<cfset CurrArray[i+1][10] = 0>
						<cfset CurrArray[i+1][11] = 0>
              		</cfif>
				</cfloop>
			</cfif>

			<cfif stLastNO neq year(getartran.wos_date) & month(getartran.wos_date)>
            	<!--- Print Grand Total --->
            	<cfset maxArray = right(CurrArray1[1][1],1)>
            	<cfset DisplayTotal = 0>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray1[i+1][6] neq 0>
                		<cfoutput>
						<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
                  			<cfif DisplayTotal eq 0>
                    			<td><div align="right"><strong>Grand Total</strong></div></td>
                    			<cfset DisplayTotal = 1>
                    		<cfelse>
                    			<td>&nbsp;</td>
                  			</cfif>
						  	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][2]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][3]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][4]#---></font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---#CurrArray1[i+1][5]#---></font></div></td>--->
						  	<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][6],',_.__')#</font></div></td>
						 	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][7],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][8],',_.__')#</font></div></td>
						  	<td>&nbsp;</td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][9],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][10],',_.__')#</font></div></td>
						  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][11],',_.__')#</font></div></td>
						</tr>
						</cfoutput>
                		<!--- Clear the grand total --->
                		<cfset CurrArray1[i+1][2] = 0>
						<cfset CurrArray1[i+1][3] = 0>
						<cfset CurrArray1[i+1][4] = 0>
						<cfset CurrArray1[i+1][5] = 0>
						<cfset CurrArray1[i+1][6] = 0>
						<cfset CurrArray1[i+1][7] = 0>
						<cfset CurrArray1[i+1][8] = 0>
              		</cfif>
              		<cfset i = i + 1>
            	</cfloop>
            	<tr>
              		<td colspan="13" valign="top" nowrap>&nbsp;</td>
            	</tr>
			</cfif>
          	<!--- Print Supplier info --->
          	<!---<cfif stLastNo neq year(#getartran.wos_date#) & month(#getartran.wos_date#) or stLastNo eq ""> --->
          	<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Code</strong></font></font></div></td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Supplier Name</strong></font></font></div></td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>PO Date</strong></font></font></div></td>
            	<td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="1"><strong>Our PO No</strong></font></font><font size="1"></font></font></div></td>
            	<td>&nbsp;</td>
				<td></td>
            	<td colspan="5"><strong><font size="1" face="Times New Roman, Times, serif">Contract No</font></strong></td>
          	</tr>
		  	<cfoutput>
          	<tr>
            	<td valign="top" nowrap>&nbsp;</td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
            	<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
            	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
           	 	<td nowrap><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
            	<td></td>
				<td nowrap><div align="center"><font size="1" face="Times New Roman, Times, serif">#getartran.currrate#</font></div></td>
            	<td colspan="3"><font size="1" face="Times New Roman, Times, serif">#getartran.rem7#</font></td>
          	</tr>
		  	</cfoutput>
          	<!---<tr>
            <td valign="top" nowrap>&nbsp;</td>
            <td colspan="13"><hr></td>
            <td>&nbsp;</td>
          	</tr> --->
          	<cfset stLastNo = year(getartran.wos_date) & month(getartran.wos_date)>
          	<cfset stLastPONo = getartran.refno>
          	<!--- Print details --->
          	<cfquery name="getictran" datasource="#dts#">
          		select * from ictran where refno ='#getartran.refno#' and type = 'PO' and qty <> '0' order by itemcount
          	</cfquery>

		  	<cfloop query = "getictran">
            	<cfquery name="getYTD" datasource="#dts#">
            		select sum(qty_bil) as QTY_YTD, sum(amt_bil) as FC_amt1, sum(amt)as SGD_amt1
					from ictran where type = 'RC' and dono = '#getictran.refno#' and itemno = '#getictran.itemno#' and qty <> '0'
            	</cfquery>

				<cfif getYTD.QTY_YTD eq "">
              		<cfset getYTD.QTY_YTD = 0>
              		<cfset getYTD.FC_amt1 = 0>
              		<cfset getYTD.SGD_amt1 = 0>
            	</cfif>

				<cfquery name="getCurr_Receive" datasource="#dts#">
            		select qty as qty_bil from iclink where type = 'RC' and frtype = 'PO' and itemno = '#getictran.itemno#'
					and frrefno = '#getictran.refno#' and frtrancode = '#getictran.trancode#' order by wos_date
            	</cfquery>

				<cfset cnt = getCurr_Receive.recordcount>

				<cfif cnt neq 0>
              		<cfloop query = "getCurr_Receive" startrow="#cnt#">
                		<cfset Curr_Qty = getCurr_Receive.qty_bil>
              		</cfloop>
              	<cfelse>
              		<cfset Curr_Qty = 0>
            	</cfif>

				<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>

				<cfquery name="getCurrCode2" datasource="#dts#">
            		select currcode from supplier where customerno ='#getictran.custno#'
            	</cfquery>

				<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
				<cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
				<cfset maxArray = right(CurrArray2[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
						<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.qty_bil>
						<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getYTD.QTY_YTD>
						<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + Curr_Qty>
						<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + Bal>
						<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.amt_bil>
						<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + getYTD.FC_amt1>
						<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + FC_Outstanding>
						<cfset CurrArray[i+1][9] = CurrArray[i+1][9] + getictran.amt>
						<cfset CurrArray[i+1][10] = CurrArray[i+1][10] + getYTD.SGD_amt1>
						<cfset CurrArray[i+1][11] = CurrArray[i+1][11] + SGD_Outstanding>
              		</cfif>

			  		<cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
						<cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.qty_bil>
						<cfset CurrArray1[i+1][3] = CurrArray1[i+1][3] + getYTD.QTY_YTD>
						<cfset CurrArray1[i+1][4] = CurrArray1[i+1][4] + Curr_Qty>
						<cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + Bal>
						<cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.amt_bil>
						<cfset CurrArray1[i+1][7] = CurrArray1[i+1][7] + getYTD.FC_amt1>
						<cfset CurrArray1[i+1][8] = CurrArray1[i+1][8] + FC_Outstanding>
						<cfset CurrArray1[i+1][9] = CurrArray1[i+1][9] + getictran.amt>
						<cfset CurrArray1[i+1][10] = CurrArray1[i+1][10] + getYTD.SGD_amt1>
						<cfset CurrArray1[i+1][11] = CurrArray1[i+1][11] + SGD_Outstanding>
              		</cfif>

              		<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
                		<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.qty_bil>
						<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + getYTD.QTY_YTD>
						<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + Curr_Qty>
						<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + Bal>
						<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.amt_bil>
						<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + getYTD.FC_amt1>
						<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + FC_Outstanding>
						<cfset CurrArray2[i+1][9] = CurrArray2[i+1][9] + getictran.amt>
						<cfset CurrArray2[i+1][10] = CurrArray2[i+1][10] + getYTD.SGD_amt1>
						<cfset CurrArray2[i+1][11] = CurrArray2[i+1][11] + SGD_Outstanding>
              		</cfif>
              		<cfset i = #i# + 1>
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
          	<td valign="top" nowrap>&nbsp;</td>
          	<td colspan="10"><hr></td>
          	<td>&nbsp;</td>
        </tr>
        <tr>
          	<td valign="top" nowrap>&nbsp;</td>
          	<td><div align="right"><strong>Total</strong></div></td>
          	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray[i+1][2]#</cfoutput>---></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray[i+1][3]#</cfoutput>---></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray[i+1][4]#</cfoutput>---></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray[i+1][5]#</cfoutput>---></font></div></td>--->
          	<td><div align="center"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][1]#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][6],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][7],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][8],',_.__')#</cfoutput></font></div></td>
          	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][9],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][10],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][11],',_.__')#</cfoutput></font></div></td>
        </tr>
        <tr>
          	<td colspan="10"><hr></td>
        </tr>
	</cfif>
</cfloop>

<cfif rgSort eq "Supplier Name" or rgSort eq "Supplier Code" or rgSort eq "Month">
<!--- Print Grand Total--->
	<cfset DisplayTotal = 0>
	<cfset maxArray = right(CurrArray[1][1],1)>

	<cfloop index = "i" from = "1" to = "#maxArray#">
		<cfif CurrArray1[i+1][6] neq 0>
		<!---or CurrArray1[i+1][1] eq "SGD">--->
		<tr>
			<td valign="top" nowrap>&nbsp;</td>
            <cfif DisplayTotal eq 0 >
              	<td><div align="right"><strong>Grand Total</strong></div></td>
              	<cfset DisplayTotal = 1>
			<cfelse>
              	<td>&nbsp;</td>
            </cfif>
            <!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray1[i+1][2]#</cfoutput>---></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray1[i+1][3]#</cfoutput>---></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray1[i+1][4]#</cfoutput>---></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray1[i+1][5]#</cfoutput>---></font></div></td>--->
            <td><div align="center"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][1]#</cfoutput></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][6],',_.__')#</cfoutput></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][7],',_.__')#</cfoutput></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][8],',_.__')#</cfoutput></font></div></td>
            <td>&nbsp;</td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][9],',_.__')#</cfoutput></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][10],',_.__')#</cfoutput></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][11],',_.__')#</cfoutput></font></div></td>
		</tr>
		</cfif>
	</cfloop>
	<tr>
		<td colspan="10"><hr></td>
	</tr>
</cfif>
<!--- Print Grand Total (FC)--->
<cfset maxArray = right(CurrArray2[1][1],1)>
<cfset DisplayTotal = 0>

<cfloop index = "i" from = "1" to = "#maxArray#">
	<cfif CurrArray2[i+1][2] neq 0 or CurrArray2[i+1][1] eq "SGD">
		<tr>
          	<td valign="top" nowrap>&nbsp;</td>
          	<cfif DisplayTotal eq 0>
            	<td><div align="right"><strong>Grand Total (FC)</strong></div></td>
            	<cfset DisplayTotal = 1>
            <cfelse>
            	<td>&nbsp;</td>
          	</cfif>
          	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray2[i+1][2]#</cfoutput>---></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray2[i+1][3]#</cfoutput>---></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray2[i+1][4]#</cfoutput>---></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#CurrArray2[i+1][5]#</cfoutput>---></font></div></td>--->
          	<td><div align="center"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][1]#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][6],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][7],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][8],',_.__')#</cfoutput></font></div></td>
          	<td>&nbsp;</td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][9],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][10],',_.__')#</cfoutput></font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][11],',_.__')#</cfoutput></font></div></td>
          	<!---<cfset SGDEquiTotal = #SGDEquiTotal# + #CurrArray2[i+1][5]#>--->
          	<cfset TotalOrder = TotalOrder + CurrArray2[i+1][2]>
          	<cfset TotalYTD = TotalYTD + CurrArray2[i+1][3]>
          	<cfset TotalCurrent = TotalCurrent + CurrArray2[i+1][4]>
          	<cfset TotalBalance = TotalBalance + CurrArray2[i+1][5]>
          	<cfset T_FC_PO = T_FC_PO + CurrArray2[i+1][6]>
          	<cfset T_FC_Receive = T_FC_Receive + CurrArray2[i+1][7]>
          	<cfset T_FC_Outstanding = T_FC_Outstanding + CurrArray2[i+1][8]>
         	<cfset T_SGD_PO = T_SGD_PO + CurrArray2[i+1][9]>
         	<cfset T_SGD_Receive = T_SGD_Receive + CurrArray2[i+1][10]>
          	<cfset T_SGD_Outstanding = T_SGD_Outstanding + CurrArray2[i+1][11]>
        </tr>
	</cfif>
	<cfset i = i + 1>
</cfloop>
    <tr>
      	<td colspan="10"><hr></td>
    </tr>
    <tr>
      	<td colspan="2" valign="top" nowrap><div align="right"><strong>SGD Equivalent Total</strong></div></td>
      	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#TotalOrder#</cfoutput>---></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#TotalYTD#</cfoutput>---></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#TotalCurrent#</cfoutput>---></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!---<cfoutput>#TotalBalance#</cfoutput>---></font></div></td>--->
      	<td>&nbsp;</td>
      	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(SGDEquiTotal,'____.__')#</cfoutput></font></div></td> --->
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_FC_PO,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_FC_Receive,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_FC_Outstanding,',_.__')#</cfoutput></font></div></td>
      	<td>&nbsp;</td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_SGD_PO,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_SGD_Receive,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_SGD_Outstanding,',_.__')#</cfoutput></font></div></td>
    </tr>
</table>
<hr><br><hr>
<div align="right">
<cfif husergrpid eq "Muser">
	<a href="../home2.cfm" class="noprint"><u><font size="1" face="Arial, Helvetica, sans-serif">Home</font></u></a>
</cfif>
<font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
<!--- <input type="submit" name="Email" value="Email" class="noprint"> --->
</div>
</cfform>
</body>
</html>