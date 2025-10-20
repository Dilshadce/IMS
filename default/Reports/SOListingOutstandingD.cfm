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
<cfset prefix = "socode">
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
    	<cfcase value="Contract No">
	  	order by refno
		</cfcase>
		<cfcase value="Client Name">
	  	order by name, refno
		</cfcase>
		<cfcase value="Client Code">
	  	order by custno, refno
		</cfcase>
		<cfcase value="Month">
	  	order by year(wos_date), month(wos_date)
		</cfcase>
  	</cfswitch>
</cfquery>

<html>
<head>
<title>Outstanding Sales Order Listing Detail by <cfoutput>#url.rgSort#</cfoutput></title>
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

<body>
<cfform name="form1" action="">
<cfif getartran.refno eq "">
   	<cfoutput><h4><font color="##FF0000">No Report Generated.</font></h4></cfoutput>
	<cfabort>
</cfif>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
      	<td colspan="15"><div align="center"><font size="4" face="Arial black"><strong>MSD ENGINEERING PTE LTD</strong></font><br>
        				<font size="1" face="Times New Roman, Times, serif">23 HILLVIEW TERRACE</font><br>
						<font size="1" face="Times New Roman, Times, serif">SINGAPORE 669234</font><br>
        				<font size="1" face="Times New Roman, Times, serif">TEL :(65) 6462 9119&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FAX :(65) 6462 9118</font><br>
						<font size="1" face="Times New Roman, Times, serif">ROC/GST NO.: 200504367W</font></div>
      	</td>
	</tr>
	<tr>
      	<td colspan="14"><font size="1" face="Times New Roman, Times, serif"><strong>Outstanding SO Listing Details By <cfoutput>#url.rgsort#</cfoutput></strong></font></td>
      	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">Date : <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
	</tr>
	<tr>
      	<td colspan="16"><hr></td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
      	<td nowrap><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td colspan="3"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Foreign Currency</strong></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Exchg Rate</strong></font></div></td>
      	<td colspan="3"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>SGD Equialent</strong></font></div></td>
      	<td>&nbsp;</td>
    </tr>
    <tr>
      	<td width="3%" nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>&nbsp;</strong></font></div></td>
      	<td width="11%" nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Item No.</strong></font></div></td>
      	<td width="5%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Qty Ordered</strong></font></div></td>
      	<td width="5%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>YTD Delivrd</strong></font></div></td>
      	<td width="5%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Current Qty Delivrd</strong></font></div></td>
      	<td width="5%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Balance</strong></font></div></td>
      	<td width="5%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Currcy</strong></font></div></td>
      	<td width="8%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Total SO Value</strong></font></div></td>
      	<td width="8%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Delivrd Value</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Outstnd Value</strong></font></div></td>
      	<td width="5%" nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total SO Value</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Delivrd</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Outstnd Value</strong></font></div></td>
      	<td width="8%"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Invoice No.</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="15"><hr></td>
    </tr>
    <cfset stLastNo = "">
    <cfset stLastSONO = "">
    <cfset stLastCurr = "">
    <!--- For Grand FC Total --->
    <cfset CurrArray2 = ArrayNew(2)>
    <cfset CurrArray2[1][1] = "Currency - ">
    <cfset CurrArray2[1][2] = "QtyOrder">
    <cfset CurrArray2[1][3] = "YTDDelived">
    <cfset CurrArray2[1][4] = "CurrentDelived">
    <cfset CurrArray2[1][5] = "Balance">
    <cfset CurrArray2[1][6] = "FC.SO">
    <cfset CurrArray2[1][7] = "FC.Total.Delived">
    <cfset CurrArray2[1][8] = "FC.Outstanding">
    <cfset CurrArray2[1][9] = "SGD.SO">
    <cfset CurrArray2[1][10] = "SGD.Total.Delived">
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
    <cfset T_FC_SO = 0>
    <cfset T_FC_Delivery = 0>
    <cfset T_FC_Outstanding = 0>
    <cfset T_SGD_SO = 0>
    <cfset T_SGD_Delivery = 0>
    <cfset T_SGD_Outstanding = 0>
    <!--- For Grand Total --->
    <cfset CurrArray1 = ArrayNew(2)>
    <cfset CurrArray1[1][1] = "Currency - ">
    <cfset CurrArray1[1][2] = "QtyOrder">
    <cfset CurrArray1[1][3] = "YTDDelived">
    <cfset CurrArray1[1][4] = "CurrentDelived">
    <cfset CurrArray1[1][5] = "Balance">
    <cfset CurrArray1[1][6] = "FC.SO">
    <cfset CurrArray1[1][7] = "FC.Total.Delived">
    <cfset CurrArray1[1][8] = "FC.Outstanding">
    <cfset CurrArray1[1][9] = "SGD.SO">
    <cfset CurrArray1[1][10] = "SGD.Total.Delived">
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
			<cfset i = #i# + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray1[1][1] = CurrArray1[1][1] & ToString(#i# - 2)>
    <!--- For Sub Total --->
    <cfset CurrArray = ArrayNew(2)>
    <cfset CurrArray[1][1] = "Currency - ">
    <cfset CurrArray[1][2] = "QtyOrder">
    <cfset CurrArray[1][3] = "YTDDelived">
    <cfset CurrArray[1][4] = "CurrentDelived">
    <cfset CurrArray[1][5] = "Balance">
    <cfset CurrArray[1][6] = "FC.SO">
    <cfset CurrArray[1][7] = "FC.Total.Delived">
    <cfset CurrArray[1][8] = "FC.Outstanding">
    <cfset CurrArray[1][9] = "SGD.SO">
    <cfset CurrArray[1][10] = "SGD.Total.Delived">
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
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
--->
    <cfif rgSort eq "Contract No">
      	<cfset stLastNo = "">

		<cfloop query = "getartran">
        	<cfquery name = "getDOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='DO' and sono = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset DO_Total_QTY = 0>

			<cfloop query = "getDOQTY">
          		<cfset DO_Total_QTY = DO_Total_QTY + getDOQTY.qty_bil>
        	</cfloop>

        	<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

        	<cfset Balance = SO_Total_QTY - DO_Total_QTY>
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
                  				<td colspan="14"><hr></td>
                  				<td>&nbsp;</td>
                			</tr>
                			<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td><div align="right"><strong>Sub Total</strong></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][2]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][3]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][4]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][5]#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
                			</tr>
							</cfoutput>
                			<tr>
                  				<td colspan="15"><hr></td>
                			</tr>
              			</cfif>
            		</cfloop>
            		<!--- Clear the sub total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
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
						<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="15" valign="top" nowrap>&nbsp;</td>
            		</tr>
          		</cfif>
          		<!---<cfif stLastNo eq ""> --->
          		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
            		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client Code</strong></font></font></div></td>
            		<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Company Name</strong></font></font></div></td>
            		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>SO Date</strong></font></font></div></td>
            		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client PO</strong></font></font></div></td>
            		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Contract No.</strong></font></font></div></td>
            		<td>&nbsp;</td>
          		</tr>
		  		<cfoutput>
          		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
            		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
            		<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
            		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
            		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem9#</font></font></td>
            		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
            		<td>&nbsp;</td>
          		</tr>
		  		</cfoutput>
          		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
            		<td colspan="14"><hr></td>
            		<td>&nbsp;</td>
          		</tr>
         	 	<cfset stLastNo = getartran.refno>
          		<!--- Print details --->

				<cfquery name="getictran" datasource="#dts#">
          			select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
          		</cfquery>

		  		<cfloop query = "getictran">
            		<cfoutput>
					<tr>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

					  	<cfquery name="getYTD" datasource="#dts#">
					  		select sum(a.qty) as QTY_YTD, sum(b.amt_bil) as FC_amt1, sum(b.amt)as
					  		SGD_amt1 from iclink a, ictran b where a.frrefno = b.refno and a.frtype
					  		= b.type and b.refno = '#getictran.refno#' and b.type = 'SO' and
					  		a.type = 'DO' and a.itemno = b.itemno and b.itemno = '#getictran.itemno#'
					  		and a.frtrancode = '#getictran.trancode#'
					  	</cfquery>

					  	<cfif getYTD.QTY_YTD eq "">
							<cfset getYTD.QTY_YTD = 0>
							<cfset getYTD.FC_amt1 = 0>
							<cfset getYTD.SGD_amt1 = 0>
					  	</cfif>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getYTD.QTY_YTD#</font></font></div></td>

						<cfquery name="getCurr_Delivery" datasource="#dts#">
              				select qty as qty_bil from iclink where type = 'DO' and frtype =
              				'SO' and itemno = '#getictran.itemno#' and frrefno = '#getictran.refno#'
              				and frtrancode = '#getictran.trancode#' order by wos_date
              			</cfquery>

						<cfset cnt = getCurr_Delivery.recordcount>

						<cfif cnt neq 0>
                			<cfloop query = "getCurr_Delivery" startrow="#cnt#">
                  				<cfset Curr_Qty = getCurr_Delivery.qty_bil>
                			</cfloop>
                		<cfelse>
                			<cfset Curr_Qty = 0>
              			</cfif>

						<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Curr_Qty#</font></font></div></td>
						<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
              				select currcode from customer where customerno ='#getictran.custno#'
              			</cfquery>

						<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt_bil,',_.__')#</font></font></div></td>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.FC_amt1,',_.__')#</font></font></div></td>
              			<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(FC_Outstanding,',_.__')#</font></font></div></td>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.currrate,'____.____')#</font></font></div></td>
             	 		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt,',_.__')#</font></font></div></td>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.SGD_amt1,',_.__')#</font></font></div></td>
              			<cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(SGD_Outstanding,',_.__')#</font></font></div></td>

						<cfquery name="getInvCode" datasource="#dts#">
              				select Invcode from gsetup
              			</cfquery>
			  			<!--- select refno, wos_date from ictran where type ='INV' and sono =
              			'#getartran.refno#' and itemno = '#getictran.itemno#' and qty <> '0' --->
              			<cfquery name="getdo" datasource="#dts#">
              				select refno,trancode,itemno from iclink where frrefno = '#getictran.refno#' and frtype = '#getictran.type#'
			 				and frtrancode = '#getictran.trancode#' and itemno = '#getictran.itemno#' and type = 'DO' group by refno
			  			</cfquery>

						<cfset invnum = ''>

						<cfif getdo.recordcount gt 0>
			  				<cfloop query="getdo">
			    				<cfquery name="getInvoice" datasource="#dts#">
              						select toinv from ictran where refno = '#getdo.refno#' and type = 'DO'
			  						and trancode = '#getdo.trancode#' and itemno = '#getdo.itemno#' and toinv <> '' and (void = '' or void is null)
              					</cfquery>

								<cfset invnum = invnum& " " &getInvCode.Invcode&getinvoice.toinv>
			  				</cfloop>
			  			</cfif>
              			<td><font size="1" face="Times New Roman, Times, serif">&nbsp;#invnum#</font></td>
            		</tr>
            		<tr>
              			<td valign="top" nowrap>&nbsp;</td>
              			<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp# #getictran.despa#</font></font></div></td>
              			<td>&nbsp;</td>
            		</tr>
					</cfoutput>

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
Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name
Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name
Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name
Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name
Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name	Client Name
--->
    <cfif rgSort eq "Client Name">
      	<cfset stLastNo = "">

	  	<cfloop query = "getartran">
        	<cfquery name = "getDOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='DO' and sono = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset DO_Total_QTY = 0>

			<cfloop query = "getDOQTY">
          		<cfset DO_Total_QTY = DO_Total_QTY + getDOQTY.qty_bil>
        	</cfloop>

        	<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

        	<cfset Balance = SO_Total_QTY - DO_Total_QTY>
        	<!--- If Balance is not 0 then is Outstanding --->
        	<cfif Balance neq 0>
          	<!--- Print the sub-total --->
          		<cfif stLastSONo neq getartran.refno and stLastNo neq "">
            		<cfset maxArray = right(CurrArray[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][6] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td colspan="14"><hr></td>
                  				<td>&nbsp;</td>
                			</tr>
                			<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td><div align="right"><strong>Sub Total</strong></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][2]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][3]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][4]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][5]#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
                			</tr>
							</cfoutput>
                			<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td colspan="14"><hr></td>
                  				<td>&nbsp;</td>
                			</tr>
              			</cfif>
            		</cfloop>
            		<!--- Clear the sub total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
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
				  		<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="15" valign="top" nowrap>&nbsp;</td>
            		</tr>
          		</cfif>

				<cfif stLastNo neq getartran.name>
            		<cfif stLastNo neq "">
              			<cfset DisplayTotal = 0>
              			<cfset maxArray = right(CurrArray[1][1],1)>

						<cfloop index = "i" from = "1" to = "#maxArray#">
                			<cfif CurrArray1[i+1][6] neq 0 or CurrArray1[i+1][1] eq "SGD">
                  				<cfoutput>
				  				<tr>
                    				<td valign="top" nowrap>&nbsp;</td>
                    				<cfif DisplayTotal eq 0 >
                      					<td><div align="right"><strong>Grand Total</strong></div></td>
                      					<cfset DisplayTotal = 1>
                      				<cfelse>
                      					<td>&nbsp;</td>
                    				</cfif>
                    				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][2]#</font></div></td>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][3]#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][4]#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][5]#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][6],',_.__')#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][7],',_.__')#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][8],',_.__')#</font></div></td>
								<td>&nbsp;</td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][9],',_.__')#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][10],',_.__')#</font></div></td>
								<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][11],',_.__')#</font></div></td>
								<td>&nbsp;</td>
                  			</tr>
				  			</cfoutput>
                		</cfif>
              		</cfloop>
              		<!--- Clear the sub total --->
              		<cfloop index = "i" from = "1" to = "#maxArray#">
						<cfset CurrArray1[i+1][2] = 0>
						<cfset CurrArray1[i+1][3] = 0>
						<cfset CurrArray1[i+1][4] = 0>
						<cfset CurrArray1[i+1][5] = 0>
						<cfset CurrArray1[i+1][6] = 0>
						<cfset CurrArray1[i+1][7] = 0>
						<cfset CurrArray1[i+1][8] = 0>
						<cfset CurrArray1[i+1][9] = 0>
						<cfset CurrArray1[i+1][10] = 0>
						<cfset CurrArray1[i+1][11] = 0>
						<cfset i = i + 1>
              		</cfloop>
              		<tr>
                		<td colspan="15"><hr></td>
              		</tr>
              		<tr>
                		<td colspan="15" valign="top" nowrap>&nbsp;</td>
              		</tr>
            	</cfif>
            	<tr>
              		<td valign="top" nowrap>&nbsp;</td>
              		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client Code</strong></font></font></div></td>
              		<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Company Name</strong></font></font></div></td>
              		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>SO Date</strong></font></font></div></td>
              		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client PO</strong></font></font></div></td>
              		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Contract No.</strong></font></font></div></td>
              		<td>&nbsp;</td>
            	</tr>
				<cfoutput>
            	<tr>
              		<td valign="top" nowrap>&nbsp;</td>
              		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
              		<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
              		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
              		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem9#</font></font></td>
              		<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
              		<td>&nbsp;</td>
            	</tr>
				</cfoutput>
            	<tr>
              		<td valign="top" nowrap>&nbsp;</td>
				  	<td colspan="14"><hr></td>
				  	<td>&nbsp;</td>
            	</tr>
          	</cfif>

			<cfset stLastNo = getartran.name>
          	<cfset stLastSONo = getartran.refno>
          	<!--- Print details --->
          	<cfquery name="getictran" datasource="#dts#">
          		select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
          	</cfquery>

			<cfloop query = "getictran">
            	<cfoutput>
				<tr>
            		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
				  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

				  	<cfquery name="getYTD" datasource="#dts#">
				  		select sum(a.qty) as QTY_YTD, sum(b.amt_bil) as FC_amt1, sum(b.amt)as
				 	 	SGD_amt1 from iclink a, ictran b where a.frrefno = b.refno and a.frtype
				  		= b.type and b.refno = '#getictran.refno#' and b.type = 'SO' and
				  		a.type = 'DO' and a.itemno = b.itemno and b.itemno = '#getictran.itemno#'
				  		and a.frtrancode = '#getictran.trancode#'
				  	</cfquery>

				  	<cfif getYTD.QTY_YTD eq "">
						<cfset getYTD.QTY_YTD = 0>
						<cfset getYTD.FC_amt1 = 0>
						<cfset getYTD.SGD_amt1 = 0>
				  	</cfif>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getYTD.QTY_YTD#</font></font></div></td>

				  	<cfquery name="getCurr_Delivery" datasource="#dts#">
				  		select qty as qty_bil from iclink where type = 'DO' and frtype =
				  		'SO' and itemno = '#getictran.itemno#' and frrefno = '#getictran.refno#'
				  		and frtrancode = '#getictran.trancode#' order by wos_date
				  	</cfquery>

				  	<cfset cnt = getCurr_Delivery.recordcount>

					<cfif cnt neq 0>
						<cfloop query = "getCurr_Delivery" startrow="#cnt#">
							<cfset Curr_Qty = getCurr_Delivery.qty_bil>
						</cfloop>
					<cfelse>
						<cfset Curr_Qty = 0>
				  	</cfif>
              		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Curr_Qty#</font></font></div></td>
				  	<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

					<cfquery name="getCurrCode2" datasource="#dts#">
				  		select currcode from customer where customerno ='#getictran.custno#'
				  	</cfquery>

				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt_bil,',_.__')#</font></font></div></td>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.FC_amt1,',_.__')#</font></font></div></td>
				  	<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(FC_Outstanding,',_.__')#</font></font></div></td>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.currrate,'____.____')#</font></font></div></td>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt,',_.__')#</font></font></div></td>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.SGD_amt1,',_.__')#</font></font></div></td>
				  	<cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
				  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(SGD_Outstanding,',_.__')#</font></font></div></td>

					<cfquery name="getInvCode" datasource="#dts#">
				  		select Invcode from gsetup
					</cfquery>

					<cfquery name="getdo" datasource="#dts#">
						select refno,trancode,itemno from iclink where frrefno = '#getictran.refno#' and frtype = '#getictran.type#'
						and frtrancode = '#getictran.trancode#' and itemno = '#getictran.itemno#' and type = 'DO' group by refno
					</cfquery>

					<cfset invnum = ''>

					<cfif getdo.recordcount gt 0>
				  		<cfloop query="getdo">
							<cfquery name="getInvoice" datasource="#dts#">
								select toinv from ictran where refno = '#getdo.refno#' and type = 'DO'
								and trancode = '#getdo.trancode#' and itemno = '#getdo.itemno#' and toinv <> '' and (void = '' or void is null)
							</cfquery>

							<cfset invnum = invnum& " " &getInvCode.Invcode&getinvoice.toinv>
						</cfloop>
					</cfif>
              		<td><font size="1" face="Times New Roman, Times, serif">&nbsp;#invnum#</font></td>
            	</tr>
            	<tr>
              		<td valign="top" nowrap>&nbsp;</td>
             		<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp# #getictran.despa#</font></font></div></td>
              		<td>&nbsp;</td>
            	</tr>
				</cfoutput>

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
Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code
Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code
Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code
Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code
Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code	Client Code
--->
    <cfif rgSort eq "Client Code">
      	<cfset stLastNo = "">

		<cfloop query = "getartran">
        	<cfquery name = "getDOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='DO' and sono = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset DO_Total_QTY = 0>

			<cfloop query = "getDOQTY">
          		<cfset DO_Total_QTY = DO_Total_QTY + getDOQTY.qty_bil>
        	</cfloop>

			<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

        	<cfset Balance = SO_Total_QTY - DO_Total_QTY>
        	<!--- If Balance is not 0 then is Outstanding --->
        	<cfif Balance neq 0>
          	<!--- Print the sub-total --->
          		<cfif stLastSONo neq getartran.refno and stLastNo neq "">
            		<cfset maxArray = right(CurrArray[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][6] neq 0>
                			<cfoutput>
							<tr>
							  	<td valign="top" nowrap>&nbsp;</td>
							  	<td colspan="14"><hr></td>
							  	<td>&nbsp;</td>
							</tr>
							<tr>
							  	<td valign="top" nowrap>&nbsp;</td>
							  	<td><div align="right"><strong>Sub Total</strong></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][2]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][3]#</font></div></td>
							 	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][4]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][5]#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
							</tr>
							</cfoutput>
							<tr>
							  	<td valign="top" nowrap>&nbsp;</td>
							  	<td colspan="14"><hr></td>
							  	<td>&nbsp;</td>
							</tr>
						 </cfif>
					</cfloop>
					<!--- Clear the sub total --->
					<cfloop index = "i" from = "1" to = "#maxArray#">
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
						<cfset i = i + 1>
					</cfloop>
            		<tr>
              			<td colspan="15" valign="top" nowrap>&nbsp;</td>
            		</tr>
          		</cfif>

				<cfif stLastNo neq getartran.custno>
            		<cfif stLastNo neq "">
             	 		<cfset DisplayTotal = 0>
              			<cfset maxArray = right(CurrArray[1][1],1)>

						<cfloop index = "i" from = "1" to = "#maxArray#">
                			<cfif CurrArray1[i+1][6] neq 0 or CurrArray1[i+1][1] eq "SGD">
                  				<cfoutput>
				  				<tr>
                    				<td valign="top" nowrap>&nbsp;</td>
                    				<cfif DisplayTotal eq 0 >
                      					<td><div align="right"><strong>Grand Total</strong></div></td>
                      					<cfset DisplayTotal = 1>
                      				<cfelse>
                      					<td>&nbsp;</td>
                    				</cfif>
                    				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][2]#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][3]#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][4]#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][5]#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][6],',_.__')#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][7],',_.__')#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][8],',_.__')#</font></div></td>
									<td>&nbsp;</td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][9],',_.__')#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][10],',_.__')#</font></div></td>
									<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][11],',_.__')#</font></div></td>
									<td>&nbsp;</td>
                  				</tr>
				  				</cfoutput>
                			</cfif>
              			</cfloop>
              			<!--- Clear the sub total --->
              			<cfloop index = "i" from = "1" to = "#maxArray#">
							<cfset CurrArray1[i+1][2] = 0>
							<cfset CurrArray1[i+1][3] = 0>
							<cfset CurrArray1[i+1][4] = 0>
							<cfset CurrArray1[i+1][5] = 0>
							<cfset CurrArray1[i+1][6] = 0>
							<cfset CurrArray1[i+1][7] = 0>
							<cfset CurrArray1[i+1][8] = 0>
							<cfset CurrArray1[i+1][9] = 0>
							<cfset CurrArray1[i+1][10] = 0>
							<cfset CurrArray1[i+1][11] = 0>
							<cfset i = i + 1>
              			</cfloop>
					  	<tr>
							<td colspan="15"><hr></td>
					  	</tr>
					  	<tr>
							<td colspan="15" valign="top" nowrap>&nbsp;</td>
					  	</tr>
					</cfif>
					<tr>
					  	<td valign="top" nowrap>&nbsp;</td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client Code</strong></font></font></div></td>
					  	<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Company Name</strong></font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>SO Date</strong></font></font></div></td>
					  	<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client PO</strong></font></font></div></td>
					  	<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Contract No.</strong></font></font></div></td>
					  	<td>&nbsp;</td>
					</tr>
					<cfoutput>
					<tr>
					  	<td valign="top" nowrap>&nbsp;</td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
					  	<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
					  	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
					  	<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem9#</font></font></td>
					 	<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
					  	<td>&nbsp;</td>
					</tr>
					</cfoutput>
					<tr>
					  	<td valign="top" nowrap>&nbsp;</td>
					  	<td colspan="14"><hr></td>
					  	<td>&nbsp;</td>
					</tr>
				 </cfif>

				 <cfset stLastNo = getartran.custno>
				 <cfset stLastSONo = getartran.refno>
				 <!--- Print details --->
				 <cfquery name="getictran" datasource="#dts#">
				 	select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
				 </cfquery>

				 <cfloop query = "getictran">
            		<cfoutput>
					<tr>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

					  	<cfquery name="getYTD" datasource="#dts#">
					  		select sum(a.qty) as QTY_YTD, sum(b.amt_bil) as FC_amt1, sum(b.amt)as
					 	 	SGD_amt1 from iclink a, ictran b where a.frrefno = b.refno and a.frtype
					  		= b.type and b.refno = '#getictran.refno#' and b.type = 'SO' and
					  		a.type = 'DO' and a.itemno = b.itemno and b.itemno = '#getictran.itemno#'
					  		and a.frtrancode = '#getictran.trancode#'
					  	</cfquery>

						<cfif getYTD.QTY_YTD eq "">
							<cfset getYTD.QTY_YTD = 0>
							<cfset getYTD.FC_amt1 = 0>
							<cfset getYTD.SGD_amt1 = 0>
					  	</cfif>

					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getYTD.QTY_YTD#</font></font></div></td>

						<cfquery name="getCurr_Delivery" datasource="#dts#">
					  		select qty as qty_bil from iclink where type = 'DO' and frtype =
					  		'SO' and itemno = '#getictran.itemno#' and frrefno = '#getictran.refno#'
					  		and frtrancode = '#getictran.trancode#' order by wos_date
					  	</cfquery>

					  	<cfset cnt = getCurr_Delivery.recordcount>

						<cfif cnt neq 0>
							<cfloop query = "getCurr_Delivery" startrow="#cnt#">
						  		<cfset Curr_Qty = getCurr_Delivery.qty_bil>
							</cfloop>
						<cfelse>
							<cfset Curr_Qty = 0>
					  	</cfif>

						<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Curr_Qty#</font></font></div></td>
					  	<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
					  		select currcode from customer where customerno ='#getictran.custno#'
					  	</cfquery>

					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt_bil,',_.__')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.FC_amt1,',_.__')#</font></font></div></td>
					  	<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(FC_Outstanding,',_.__')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.currrate,'____.____')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt,',_.__')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.SGD_amt1,',_.__')#</font></font></div></td>
					  	<cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(SGD_Outstanding,',_.__')#</font></font></div></td>

						<cfquery name="getInvCode" datasource="#dts#">
					  		select Invcode from gsetup
					  	</cfquery>

						<cfquery name="getdo" datasource="#dts#">
							select refno,trancode,itemno from iclink where frrefno = '#getictran.refno#' and frtype = '#getictran.type#'
							and frtrancode = '#getictran.trancode#' and itemno = '#getictran.itemno#' and type = 'DO' group by refno
					  	</cfquery>

					  	<cfset invnum = ''>

						<cfif getdo.recordcount gt 0>
					 		<cfloop query="getdo">
								<cfquery name="getInvoice" datasource="#dts#">
									select toinv from ictran where refno = '#getdo.refno#' and type = 'DO'
									and trancode = '#getdo.trancode#' and itemno = '#getdo.itemno#' and toinv <> '' and (void = '' or void is null)
								</cfquery>
								<cfset invnum = invnum& " " &getInvCode.Invcode&getinvoice.toinv>
					  		</cfloop>
					  	</cfif>
					  	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;#invnum#</font></td>
					</tr>
					<tr>
					  	<td valign="top" nowrap>&nbsp;</td>
					  	<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp# #getictran.despa#</font></font></div></td>
					  	<td>&nbsp;</td>
					</tr>
					</cfoutput>

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
        	<cfquery name = "getDOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='DO' and sono = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset DO_Total_QTY = 0>

			<cfloop query = "getDOQTY">
          		<cfset DO_Total_QTY = DO_Total_QTY + getDOQTY.qty_bil>
        	</cfloop>

			<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

			<cfset Balance = SO_Total_QTY - DO_Total_QTY>
        	<!--- If Balance is not 0 then is Outstanding --->
        	<cfif Balance neq 0>
          		<!--- Print the sub-total --->
          		<cfif stLastSONo neq getartran.refno and stLastNo neq "">
            		<cfset maxArray = right(CurrArray[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][6] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
							  	<td colspan="14"><hr></td>
							  	<td>&nbsp;</td>
							</tr>
							<tr>
							  	<td valign="top" nowrap>&nbsp;</td>
							  	<td><div align="right"><strong>Sub Total</strong></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][2]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][3]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][4]#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][5]#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][6],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][7],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][8],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][9],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][10],',_.__')#</font></div></td>
							  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][11],',_.__')#</font></div></td>
							  	<td>&nbsp;</td>
							</tr>
							<tr>
							  	<td colspan="15"><hr></td>
							</tr>
							</cfoutput>
              			</cfif>
            		</cfloop>
            		<!--- Clear the sub total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
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
              			<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="15" valign="top" nowrap>&nbsp;</td>
            		</tr>
          		</cfif>
          		<!---<cfif stLastNo eq ""> --->
          		<tr>
					<td valign="top" nowrap>&nbsp;</td>
					<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client Code</strong></font></font></div></td>
					<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>Company Name</strong></font></font></div></td>
					<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><strong>SO Date</strong></font></font></div></td>
					<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Client PO</strong></font></font></div></td>
					<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1"><strong>Contract No.</strong></font></font></div></td>
					<td>&nbsp;</td>
				</tr>
				<cfoutput>
				<tr>
					<td valign="top" nowrap>&nbsp;</td>
					<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></div></td>
					<td colspan="5"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></div></td>
					<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></div></td>
					<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem9#</font></font></td>
					<td colspan="3"><div align="center"><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
					<td>&nbsp;</td>
				</tr>
				</cfoutput>
				<tr>
					<td valign="top" nowrap>&nbsp;</td>
					<td colspan="14"><hr></td>
					<td>&nbsp;</td>
				</tr>
				<cfset stLastNo = year(getartran.wos_date) & month(getartran.wos_date)>
				<cfset stLastSONo = getartran.refno>
				<!--- Print details --->
				<cfquery name="getictran" datasource="#dts#">
					select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0'
				  	order by itemcount
				</cfquery>

				<cfloop query = "getictran">
					<cfoutput>
					<tr>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

						<cfquery name="getYTD" datasource="#dts#">
					  		select sum(a.qty) as QTY_YTD, sum(b.amt_bil) as FC_amt1, sum(b.amt)as
					  		SGD_amt1 from iclink a, ictran b where a.frrefno = b.refno and a.frtype
					 	 	= b.type and b.refno = '#getictran.refno#' and b.type = 'SO' and
					  		a.type = 'DO' and a.itemno = b.itemno and b.itemno = '#getictran.itemno#'
					  		and a.frtrancode = '#getictran.trancode#'
					  	</cfquery>

						<cfif getYTD.QTY_YTD eq "">
							<cfset getYTD.QTY_YTD = 0>
							<cfset getYTD.FC_amt1 = 0>
							<cfset getYTD.SGD_amt1 = 0>
					  	</cfif>

					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getYTD.QTY_YTD#</font></font></div></td>

						<cfquery name="getCurr_Delivery" datasource="#dts#">
					  		select qty as qty_bil from iclink where type = 'DO' and frtype =
					  		'SO' and itemno = '#getictran.itemno#' and frrefno = '#getictran.refno#'
					  		and frtrancode = '#getictran.trancode#' order by wos_date
					  	</cfquery>

					  	<cfset cnt = getCurr_Delivery.recordcount>

						<cfif cnt neq 0>
							<cfloop query = "getCurr_Delivery" startrow="#cnt#">
						  		<cfset Curr_Qty = getCurr_Delivery.qty_bil>
							</cfloop>
                		<cfelse>
                			<cfset Curr_Qty = 0>
              			</cfif>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Curr_Qty#</font></font></div></td>
					  	<cfset Bal = getictran.qty_bil - getYTD.QTY_YTD>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
					  		select currcode from customer where customerno ='#getictran.custno#'
					  	</cfquery>

						<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt_bil,',_.__')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.FC_amt1,',_.__')#</font></font></div></td>
					  	<cfset FC_OutStanding = getictran.amt_bil - getYTD.FC_amt1>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(FC_Outstanding,',_.__')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.currrate,'____.____')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getictran.amt,',_.__')#</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(getYTD.SGD_amt1,',_.__')#</font></font></div></td>
					  	<cfset SGD_OutStanding = getictran.amt - getYTD.SGD_amt1>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#numberformat(SGD_Outstanding,',_.__')#</font></font></div></td>

						<cfquery name="getInvCode" datasource="#dts#">
					 		select Invcode from gsetup
					  	</cfquery>

					  	<cfquery name="getdo" datasource="#dts#">
							select refno,trancode,itemno from iclink where frrefno = '#getictran.refno#' and frtype = '#getictran.type#'
							and frtrancode = '#getictran.trancode#' and itemno = '#getictran.itemno#' and type = 'DO' group by refno
					  	</cfquery>

					  	<cfset invnum = ''>

						<cfif getdo.recordcount gt 0>
					  		<cfloop query="getdo">
								<cfquery name="getInvoice" datasource="#dts#">
									select toinv from ictran where refno = '#getdo.refno#' and type = 'DO'
									and trancode = '#getdo.trancode#' and itemno = '#getdo.itemno#' and toinv <> '' and (void = '' or void is null)
								</cfquery>
								<cfset invnum = invnum& " " &getInvCode.Invcode&getinvoice.toinv>
					  		</cfloop>
					  	</cfif>
					  	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;#invnum#</font></td>
					</tr>
					<tr>
					  	<td valign="top" nowrap>&nbsp;</td>
					  	<td colspan="14"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp# #getictran.despa#</font></font></div></td>
					  	<td>&nbsp;</td>
					</tr>
					</cfoutput>

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
	<!--- Print last sub-total --->
	<cfset maxArray = right(CurrArray[1][1],1)>

	<cfloop index = "i" from = "1" to = "#maxArray#">
		<cfif CurrArray[i+1][6] neq 0>
			<tr>
				<td valign="top" nowrap>&nbsp;</td>
				<td colspan="14"><hr></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" nowrap>&nbsp;</td>
				<td><div align="right"><strong>Sub Total</strong></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][2]#</cfoutput></font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][3]#</cfoutput></font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][4]#</cfoutput></font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][5]#</cfoutput></font></div></td>
				<td>&nbsp;</td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][6],',_.__')#</cfoutput></font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][7],',_.__')#</cfoutput></font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][8],',_.__')#</cfoutput></font></div></td>
				<td>&nbsp;</td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][9],',_.__')#</cfoutput></font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][10],',_.__')#</cfoutput></font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][11],',_.__')#</cfoutput></font></div></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="15"><hr></td>
			</tr>
		</cfif>
	</cfloop>
    <!--- 	<!--- Clear the sub total --->
    <cfloop index = "i" from = "1" to = "#maxArray#">
      <cfset CurrArray[i+1][2] = 0>
      <cfset CurrArray[i+1][3] = 0>
      <cfset CurrArray[i+1][4] = 0>
      <cfset CurrArray[i+1][5] = 0>
      <cfset CurrArray[i+1][6] = 0>
      <cfset CurrArray[i+1][7] = 0>
      <cfset CurrArray[i+1][8] = 0>
      <cfset i = #i# + 1>
    </cfloop>
    --->
    <tr>
      	<td colspan="15" valign="top" nowrap>&nbsp;</td>
    </tr>
    <!---   </cfif> --->
    <cfif rgSort eq "Client Name" or rgSort eq "Client Code">
      	<!--- Print Grand Total--->
      	<cfset DisplayTotal = 0>
      	<cfset maxArray = right(CurrArray[1][1],1)>

		<cfloop index = "i" from = "1" to = "#maxArray#">
     		<cfif CurrArray1[i+1][6] neq 0 or CurrArray1[i+1][1] eq "SGD">
          		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
            		<cfif DisplayTotal eq 0 >
              			<td><div align="right"><strong>Grand Total</strong></div></td>
              			<cfset DisplayTotal = 1>
              		<cfelse>
              			<td>&nbsp;</td>
            		</cfif>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][2]#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][3]#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][4]#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][5]#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][1]#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][6],',_.__')#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][7],',_.__')#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][8],',_.__')#</cfoutput></font></div></td>
					<td>&nbsp;</td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][9],',_.__')#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][10],',_.__')#</cfoutput></font></div></td>
					<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][11],',_.__')#</cfoutput></font></div></td>
					<td>&nbsp;</td>
          		</tr>
        	</cfif>
		</cfloop>
      	<!--- Clear the sub total --->
      	<!--- 	  <cfloop index = "i" from = "1" to = "#maxArray#">
	    <cfset CurrArray1[i+1][2] = 0>
	    <cfset CurrArray1[i+1][3] = 0>
	    <cfset CurrArray1[i+1][4] = 0>
	    <cfset CurrArray1[i+1][5] = 0>
	    <cfset CurrArray1[i+1][6] = 0>
	    <cfset CurrArray1[i+1][7] = 0>
	    <cfset CurrArray1[i+1][8] = 0>
	    <cfset CurrArray1[i+1][9] = 0>
	    <cfset CurrArray1[i+1][10] = 0>
	    <cfset CurrArray1[i+1][11] = 0>
	    <cfset i = #i# + 1>
	  	</cfloop> --->
      	<tr>
        	<td colspan="15"><hr></td>
      	</tr>
    </cfif>
    <!--- Print Grand Total (FC)--->
    <tr>
      	<td valign="top" nowrap>&nbsp;</td>
      	<td><div align="right"><strong>Grand Total (FC)</strong></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][2]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][3]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][4]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][5]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][1]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][6],',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][7],',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][8],',_.__')#</cfoutput></font></div></td>
      	<td>&nbsp;</td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][9],',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][10],',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][11],',_.__')#</cfoutput></font></div></td>
      	<td>&nbsp;</td>
      	<!---<cfset SGDEquiTotal = #CurrArray2[2][5]#> --->
      	<cfset TotalOrder = CurrArray2[2][2]>
      	<cfset TotalYTD = CurrArray2[2][3]>
      	<cfset TotalCurrent = CurrArray2[2][4]>
      	<cfset TotalBalance = CurrArray2[2][5]>
      	<cfset T_FC_SO = CurrArray2[2][6]>
      	<cfset T_FC_Delivery = CurrArray2[2][7]>
      	<cfset T_FC_Outstanding = CurrArray2[2][8]>
      	<cfset T_SGD_SO = CurrArray2[2][9]>
      	<cfset T_SGD_Delivery = CurrArray2[2][10]>
      	<cfset T_SGD_Outstanding = CurrArray2[2][11]>
    </tr>
    <cfset maxArray = right(CurrArray2[1][1],1)>

	<cfloop index = "i" from = "2" to = "#maxArray#">
      	<cfif CurrArray2[i+1][2] neq 0>
        	<tr>
          		<td valign="top" nowrap>&nbsp;</td>
			  	<td>&nbsp;</td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][2]#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][3]#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][4]#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][5]#</cfoutput></font></div></td>
			 	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][1]#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][6],',_.__')#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][7],',_.__')#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][8],',_.__')#</cfoutput></font></div></td>
			  	<td>&nbsp;</td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][9],',_.__')#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][10],',_.__')#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][11],',_.__')#</cfoutput></font></div></td>
			  	<td>&nbsp;</td>
          		<!---<cfset SGDEquiTotal = #SGDEquiTotal# + #CurrArray2[i+1][5]#> --->
			  	<cfset TotalOrder = TotalOrder + CurrArray2[i+1][2]>
			  	<cfset TotalYTD = TotalYTD + CurrArray2[i+1][3]>
			  	<cfset TotalCurrent = TotalCurrent + CurrArray2[i+1][4]>
			  	<cfset TotalBalance = TotalBalance + CurrArray2[i+1][5]>
			 	<cfset T_FC_SO = T_FC_SO + CurrArray2[i+1][6]>
			  	<cfset T_FC_Delivery = T_FC_Delivery + CurrArray2[i+1][7]>
			  	<cfset T_FC_Outstanding = T_FC_Outstanding + CurrArray2[i+1][8]>
			  	<cfset T_SGD_SO = T_SGD_SO + CurrArray2[i+1][9]>
			  	<cfset T_SGD_Delivery = T_SGD_Delivery + CurrArray2[i+1][10]>
			  	<cfset T_SGD_Outstanding = T_SGD_Outstanding + CurrArray2[i+1][11]>
        	</tr>
      	</cfif>
      	<cfset i = i + 1>
	</cfloop>
    <tr>
      	<td colspan="15"><hr></td>
    </tr>
    <tr>
      	<td colspan="2" valign="top" nowrap><div align="right"><strong>SGD Equivalent Total</strong></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#TotalOrder#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#TotalYTD#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#TotalCurrent#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#TotalBalance#</cfoutput></font></div></td>
      	<td>&nbsp;</td>
      	<!---<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(SGDEquiTotal,',_.__')#</cfoutput></font></div></td> --->
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_FC_SO,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_FC_Delivery,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_FC_Outstanding,',_.__')#</cfoutput></font></div></td>
      	<td>&nbsp;</td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_SGD_SO,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_SGD_Delivery,',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(T_SGD_Outstanding,',_.__')#</cfoutput></font></div></td>
     	<td>&nbsp;</td>
    </tr>
</table>
<br>
<hr>
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