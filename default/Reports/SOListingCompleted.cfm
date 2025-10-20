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
<title>Completed Sales Order Listing By <cfoutput>#url.rgSort#</cfoutput></title>
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

<body>
<cfform name="form1" action="">
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
      	<td><font size="1" face="Times New Roman, Times, serif"><strong>Completed SO Listing By <cfoutput>#url.rgsort#</cfoutput></strong></font></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Date : <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
	</tr>
	<tr>
      	<td colspan="15"><hr></td>
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
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
     	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td><font size="1" face="Times New Roman, Times, serif">&nbsp;</font></td>
      	<td colspan="2"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Foreign Currency</strong></font></div></td>
      	<td nowrap> <div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Exchg Rate</strong></font></div></td>
      	<td colspan="2"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>SGD Equialent</strong></font></div></td>
    </tr>
    <tr>
      	<td width="3%" nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>&nbsp;</strong></font></div></td>
      	<td width="8%" nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>SO No.</strong></font></div></td>
      	<td width="8%"><div align="left">&nbsp;</div></td>
      	<td width="4%"><div align="left">&nbsp;</div></td>
      	<td width="8%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>PO No.</strong></font></div></td>
      	<td width="8%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Invoice No</strong></font></div></td>
      	<td width="8%"><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Invoice Date</strong></font></div></td>
      	<td width="4%"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Qty Ordered </strong></font></div></td>
      	<td width="4%"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Qty Dlivrd</strong></font></div></td>
      	<td width="4%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Bal.</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Currency</strong></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>U.Price</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
      	<td width="4%"><div align="right"><font size="1" face="Times New Roman, Times, serif"></font></div></td>
      	<td width="7%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>U.Price</strong></font></div></td>
      	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="16"><hr></td>
    </tr>
    <cfset stLastNo = "">
    <cfset stLastSONO = "">
    <cfset stLastCurr = "">
    <!--- For Grand FC Total --->
    <cfset CurrArray2 = ArrayNew(2)>
    <cfset CurrArray2[1][1] = "Currency - ">
    <cfset CurrArray2[1][2] = "FC.T.Price">
    <cfset CurrArray2[1][3] = "No.E.Rate">
    <cfset CurrArray2[1][4] = "E.Rate">
    <cfset CurrArray2[1][5] = "SGD.T.Price">
    <cfset CurrArray2[1][6] = "QtyOrder">
    <cfset CurrArray2[1][7] = "QtyDeliver">
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
    <!---     <cfset CurrArray1 = ArrayNew(2)>
    <cfset CurrArray1[1][1] = "Currency - ">
    <cfset CurrArray1[1][2] = "FC.T.Price">
    <cfset CurrArray1[1][3] = "No.E.Rate">
    <cfset CurrArray1[1][4] = "E.Rate">
    <cfset CurrArray1[1][5] = "SGD.T.Price">
    <cfset CurrArray1[1][6] = "QtyOrder">
    <cfset CurrArray1[1][7] = "QtyDeliver">
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
    --->
    <!--- For Sub Total --->
    <cfset CurrArray = ArrayNew(2)>
    <cfset CurrArray[1][1] = "Currency - ">
    <cfset CurrArray[1][2] = "FC.T.Price">
    <cfset CurrArray[1][3] = "No.E.Rate">
    <cfset CurrArray[1][4] = "E.Rate">
    <cfset CurrArray[1][5] = "SGD.T.Price">
    <cfset CurrArray[1][6] = "QtyOrder">
    <cfset CurrArray[1][7] = "QtyDeliver">
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
			<cfset CurrArray[i][1] = getCurrCode.CurrCode>
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
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No	Contract No
--->
    <cfif rgSort eq "Contract No">
      	<cfset stLastNo = "">

		<cfloop query = "getartran">
			<cfset refno = getartran.refno>

			<cfquery name="checkiclink" datasource="#dts#">
				select type from iclink where frrefno = '#refno#' and frtype = 'SO'
			</cfquery>

			<cfquery name = "getDOQTY" datasource = "#dts#">
        		select sum(shipped) as T_QTY from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfif getDOQTY.T_QTY neq "">
          		<cfset DO_Total_QTY = getDOQTY.T_QTY>
          	<cfelse>
          		<cfset DO_Total_QTY = 0>
        	</cfif>
        	<!---<cfset DO_Total_QTY = 0>
			<cfloop query = "getDOQTY">
		  	<cfset DO_Total_QTY = #DO_Total_QTY# + #getDOQTY.qty_bil#>
			</cfloop> --->
        	<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

			<cfset Balance = SO_Total_QTY - DO_Total_QTY>
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
					  	<cfset i = i + 1>
					</cfloop>
					<tr>
					  	<td colspan="15" valign="top" nowrap>&nbsp;</td>
					</tr>
				 </cfif>
				 <!---<cfif stLastNo eq ""> --->
				 <cfquery name="getCust" datasource="#dts#">
				  	select phone, phonea, add1, add2, add3, add4 from customer where customerno = '#getartran.custno#'
				 </cfquery>

				 <cfoutput>
				 	<tr>
				  		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td colspan="14"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno# #getartran.name#</strong> TEL: #getcust.phone# #getcust.phonea#</font></font></td>
					</tr>
				  	<tr>
						<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td colspan="15"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></div></td>
				  	</tr>
				  	<tr>
						<td valign="top" nowrap>&nbsp;</td>
						<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#</font></font></font></td>
						<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
						<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<cfquery name="getPOCode" datasource="#dts#">
					  		select pocode from gsetup
					  	</cfquery>
						<td><font face="Times New Roman, Times, serif"><font size="1">#getpocode.pocode##getartran.rem8#</font></font></td>
						<td><font face="Times New Roman, Times, serif"><font size="1"><cfif getartran.order_cl eq 'Y'><strong>(CLEAR)</strong></cfif></font></font></td>
						<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
				  	</tr>
		  			</cfoutput>
          			<cfset stLastNo = getartran.refno>
          			<!--- Print details --->
				  	<!---<cfquery name="getictran" datasource="#dts#">
				  		select * from ictran where refno ='#refno#' and type = 'SO' and qty <> '0' order by itemcount
				  	</cfquery>--->

					<cfquery name="getictran" datasource="#dts#">
          				select a.* from ictran a, iclink b where a.refno ='#refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
						and a.itemno=b.itemno and a.type = 'SO' and b.frtype = 'SO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
          			</cfquery>

					<cfloop query = "getictran">
						<cfoutput>
						<tr>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
					  	<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>

						<!--- <cfquery name="getPOCode" datasource="#dts#">
					  		select pocode from gsetup
					  	</cfquery> --->

					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"></font></font></div></td>

					  	<cfquery name="getInvCode" datasource="#dts#">
					  		select Invcode from gsetup
					  	</cfquery>

					  	<cfquery name="getInvoice" datasource="#dts#">
					  		select distinct(refno)as refno, toinv,dodate,qty from ictran where sono = '#refno#' and itemno='#getictran.itemno#' and type = 'DO' order by toinv
					  		<!--- select refno, wos_date from ictran where type ='INV' and sono =
					  		'#getartran.refno#' and itemno = '#getictran.itemno#' and qty <> '0' --->
					  	</cfquery>

						<!---<cfset invdate = ''>

						<cfloop query="getinvoice">
							<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#getinvoice.toinv#' and type = 'INV'
							</cfquery>

							<cfif getinvdate.recordcount gt 0>
								<cfset invdate = invdate & "<br>" &#dateformat(getinvdate.wos_date,"dd/mm/yy")#>
							</cfif>
					  	</cfloop>--->

						<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice">#getInvCode.Invcode##getInvoice.toinv#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">
						<cfloop query="getInvoice">
							<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#getinvoice.toinv#' and type = 'INV'
							</cfquery>
							#dateformat(getinvdate.wos_date,"dd/mm/yyyy")#<cfif getinvdate.recordcount gt 1><br></cfif>
						</cfloop>
						</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>
					  	<!--- get the item qty delived from the DO, and it was updated from SO --->
					  	<!--- <cfquery name="getDOQTY2" datasource="#dts#">
					  	select qty_bil from ictran where type ='DO' and itemno = '#getictran.itemno#'
					  	and sono = '#stLastNo#' and qty <> '0'
					  	</cfquery>
					  	<cfset DOqty = 0>
					  	<cfif getDOQTY2.recordcount eq 0>
						<cfset DOqty = 0>
						<cfelse>
						<cfloop query = "getDOQTY2">
						<cfset DOqty = #DOqty# + #getDOQTY2.qty_bil#>
						</cfloop>
					  	</cfif> --->
					  	<cfset doqty = getictran.shipped>
						<cfset invqty = 0>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice"><cfset invqty = invqty + getInvoice.qty>#getInvoice.qty#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
					  	<cfset Bal = 0>
					  	<cfset Bal = getictran.qty_bil - invqty<!---DOqty--->>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
					  		select currcode from customer where customerno ='#getictran.custno#'
					  	</cfquery>

					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
					  	<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
					  	<!---<cfset stLastCurr = #getcurrcode2.currcode#> --->
					  	<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
					  	<!---<cfquery name="getCurrRate" datasource="#dts#">
						Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#'
						</cfquery> --->
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
					  	<!---<cfset temp_p = #getCurrRate.currrate# * #getictran.price_bil#> --->
					  	<cfset temp_p = getictran.currrate * xprice_bil>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p,stDecl_UPrice)#</font></div></td>
					  	<cfset temp_a = getictran.currrate * getictran.amt_bil>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
					</tr>
					</cfoutput>

					<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                			<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
                			<!---<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + 1>
                			<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getCurrRate.currrate> --->
                			<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + temp_a>
                			<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
                			<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + invqty<!---DOQTY--->>
                			<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
              			</cfif>

			  			<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
							<!---<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
							<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate> --->
							<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
							<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
							<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + invqty<!---DOQTY--->>
							<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + Bal>
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
			<cfquery name="checkiclink" datasource="#dts#">
				select type from iclink where frrefno = '#refno#' and frtype = 'SO'
			</cfquery>

        	<cfquery name = "getDOQTY" datasource = "#dts#">
        		select sum(shipped) as T_QTY from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfif getDOQTY.T_QTY neq "">
          		<cfset DO_Total_QTY = getDOQTY.T_QTY>
          	<cfelse>
          		<cfset DO_Total_QTY = 0>
        	</cfif>

        	<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

        	<cfset Balance = SO_Total_QTY - DO_Total_QTY>
        	<!--- If Balance is 0 then is Completed --->
        	<cfif Balance eq 0 or checkiclink.recordcount gt 0>
          		<!--- Print the sub-total --->
          		<cfif stLastSONO neq getartran.refno and stLastNo neq "">
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
						<cfset i = i + 1>
					</cfloop>
					<tr>
						<td colspan="15" valign="top" nowrap>&nbsp;</td>
					</tr>
				</cfif>
				<!---         <cfif stLastNo eq ""> --->
				<!--- Print Customer info --->
				<cfif stLastNo neq getartran.name>
					<cfquery name="getCust" datasource="#dts#">
						select phone, phonea, add1, add2, add3, add4 from customer where customerno = '#getartran.custno#'
					</cfquery>

					<cfoutput>
					<tr>
						<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td colspan="15"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno# #getartran.name#</strong> TEL: #getcust.phone# #getcust.phonea#</font></font></td>
					</tr>
					<tr>
						<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
						<td colspan="15"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></div></td>
					</tr>
					</cfoutput>
				</cfif>

				<cfoutput>
				<tr>
					<td valign="top" nowrap>&nbsp;</td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#</font></font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</cfoutput>

				<cfset stLastNo = getartran.name>
				<cfset stLastSONO = getartran.refno>
				<!--- Print details --->
				<!---<cfquery name="getictran" datasource="#dts#">
					select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
				</cfquery>--->

				<cfquery name="getictran" datasource="#dts#">
          			select a.* from ictran a, iclink b where a.refno ='#refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
					and a.itemno=b.itemno and a.type = 'SO' and b.frtype = 'SO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
          		</cfquery>

				<cfloop query = "getictran">
            		<cfoutput>
					<tr>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
              			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
              			<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>

						<cfquery name="getPOCode" datasource="#dts#">
              				select pocode from gsetup
              			</cfquery>

						<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"></font></font></div></td>

						<cfquery name="getInvCode" datasource="#dts#">
              				select Invcode from gsetup
              			</cfquery>

              			<cfquery name="getInvoice" datasource="#dts#">
               				select distinct(refno)as refno, toinv,dodate,qty from ictran where sono = '#refno#' and itemno='#getictran.itemno#' and type = 'DO' order by toinv
              			</cfquery>

			  			<!---<cfset invdate = ''>

			  			<cfloop query="getinvoice">
			  				<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#toinv#' and type = 'INV'
							</cfquery>

							<cfif getinvdate.recordcount gt 0>
								<cfset invdate = invdate & " " &#dateformat(getinvdate.wos_date,"dd/mm/yy")#>
							</cfif>
			  			</cfloop>--->

			  			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice">#getInvCode.Invcode##getInvoice.toinv#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
              			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">
						<cfloop query="getInvoice">
							<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#getinvoice.toinv#' and type = 'INV'
							</cfquery>
							#dateformat(getinvdate.wos_date,"dd/mm/yyyy")#<cfif getinvdate.recordcount gt 1><br></cfif>
						</cfloop>
						</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>
					  	<!--- get the item qty delived from the DO, and it was updated from SO --->
					  	<!--- <cfquery name="getDOQTY2" datasource="#dts#">
					  	select qty_bil from ictran where type ='DO' and itemno = '#getictran.itemno#'
					  	and sono = '#stLastSONO#' and qty <> '0'
					  	</cfquery>
					  	<cfset DOqty = 0>
					  	<cfif getDOQTY2.recordcount eq 0>
						<cfset DOqty = 0>
						<cfelse>
						<cfloop query = "getDOQTY2">
						<cfset DOqty = #DOqty# + #getDOQTY2.qty_bil#>
						</cfloop>
					 	</cfif> --->
					  	<cfset doqty = getictran.shipped>
						<cfset invqty = 0>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice"><cfset invqty = invqty + getInvoice.qty>#getInvoice.qty#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
					  	<cfset Bal = 0>
              			<cfset Bal = getictran.qty_bil - invqty<!---DOqty--->>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
              				select currcode from customer where customerno ='#getictran.custno#'
              			</cfquery>

			  			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
              			<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
              			<!---<cfset stLastCurr = #getcurrcode2.currcode#> --->
			  			<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
             	 		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
              			<!---<cfquery name="getCurrRate" datasource="#dts#">
            			Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#'
            			</cfquery> --->
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
              			<!---<cfset temp_p = #getCurrRate.currrate# * #getictran.price_bil#> --->
              			<cfset temp_p = getictran.currrate * xprice_bil>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p,stDecl_UPrice)#</font></div></td>
              			<cfset temp_a = getictran.currrate * getictran.amt_bil>
              			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
            		</tr>
					</cfoutput>

					<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
							<!---<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + 1>
							<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getCurrRate.currrate> --->
							<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + temp_a>
							<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
							<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + invqty<!---DOQTY--->>
							<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
						</cfif>

						<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
							<!---<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
							<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate#> --->
							<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
							<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
							<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + invqty<!---DOQTY--->>
							<cfset CurrArray2[i+1][8] = CurrArray2[i+1][8] + Bal>
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
			<cfquery name="checkiclink" datasource="#dts#">
				select type from iclink where frrefno = '#refno#' and frtype = 'SO'
			</cfquery>

        	<cfquery name = "getDOQTY" datasource = "#dts#">
        		select sum(shipped) as T_QTY from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfif getDOQTY.T_QTY neq "">
          		<cfset DO_Total_QTY = getDOQTY.T_QTY>
          	<cfelse>
          		<cfset DO_Total_QTY = 0>
        	</cfif>

			<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

        	<cfset Balance = SO_Total_QTY - DO_Total_QTY>
        	<!--- If Balance is 0 then is Completed --->
        	<cfif Balance eq 0 or checkiclink.recordcount gt 0>
          		<!--- Print the sub-total --->
          		<cfif stLastSONO neq getartran.refno and stLastNo neq "">
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
					  	<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="15" valign="top" nowrap>&nbsp;</td>
            		</tr>
          		</cfif>
          		<!---<cfif stLastNo eq ""> --->
          		<!---Print Customer info --->
          		<cfif stLastNo neq getartran.custno>
            		<cfquery name="getCust" datasource="#dts#">
            			select phone, phonea, add1, add2, add3, add4 from customer where customerno = '#getartran.custno#'
            		</cfquery>

					<cfoutput>
					<tr>
					  	<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					  	<td colspan="15"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno# #getartran.name#</strong> TEL: #getcust.phone# #getcust.phonea#</font></font></td>
					</tr>
					<tr>
					  	<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					  	<td colspan="15"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></div></td>
					</tr>
					</cfoutput>
          		</cfif>

				<cfoutput>
          		<tr>
					<td valign="top" nowrap>&nbsp;</td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#</font></font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				</cfoutput>

				<cfset stLastNo = getartran.custno>
          		<cfset stLastSONO = getartran.refno>
          		<!--- Print details --->
          		<!---<cfquery name="getictran" datasource="#dts#">
          			select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
          		</cfquery>--->

				<cfquery name="getictran" datasource="#dts#">
          			select a.* from ictran a, iclink b where a.refno ='#refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
					and a.itemno=b.itemno and a.type = 'SO' and b.frtype = 'SO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
          		</cfquery>

				<cfloop query = "getictran">
            		<cfoutput>
					<tr>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
					  	<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>

					  	<cfquery name="getPOCode" datasource="#dts#">
					  		select pocode from gsetup
					  	</cfquery>

						<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"></font></font></div></td>

					  	<cfquery name="getInvCode" datasource="#dts#">
					  		select Invcode from gsetup
					  	</cfquery>

					  	<cfquery name="getInvoice" datasource="#dts#">
					  		select distinct(refno)as refno, toinv,dodate,qty from ictran where sono = '#refno#' and itemno='#getictran.itemno#' and type = 'DO' order by toinv
					  	</cfquery>

					  	<!---<cfset invdate = ''>

						<cfloop query="getinvoice">
							<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#toinv#' and type = 'INV'
							</cfquery>

							<cfif getinvdate.recordcount gt 0>
								<cfset invdate = invdate & " " &#dateformat(getinvdate.wos_date,"dd/mm/yy")#>
							</cfif>
					  	</cfloop>--->
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice">#getInvCode.Invcode##getInvoice.toinv#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
              			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">
						<cfloop query="getInvoice">
							<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#getinvoice.toinv#' and type = 'INV'
							</cfquery>
							#dateformat(getinvdate.wos_date,"dd/mm/yyyy")#<cfif getinvdate.recordcount gt 1><br></cfif>
						</cfloop>
						</font></font></div></td>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>
					  	<!--- get the item qty delived from the DO, and it was updated from SO --->
					  	<!--- <cfquery name="getDOQTY2" datasource="#dts#">
					  	select qty_bil from ictran where type ='DO' and itemno = '#getictran.itemno#'
					  	and sono = '#stLastSONO#' and qty <> '0'
					  	</cfquery>
					  	<cfset DOqty = 0>
					  	<cfif getDOQTY2.recordcount eq 0>
						<cfset DOqty = 0>
						<cfelse>
						<cfloop query = "getDOQTY2">
						<cfset DOqty = #DOqty# + #getDOQTY2.qty_bil#>
						</cfloop>
					  	</cfif> --->
					  	<cfset doqty = getictran.shipped>
						<cfset invqty = 0>
              			<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice"><cfset invqty = invqty + getInvoice.qty>#getInvoice.qty#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
					  	<cfset Bal = 0>
					  	<cfset Bal = getictran.qty_bil - invqty<!---DOqty--->>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
					  		select currcode from customer where customerno ='#getictran.custno#'
					  	</cfquery>

					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
					  	<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
					  	<!---<cfset stLastCurr = #getcurrcode2.currcode#> --->
					 	<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
					  	<!---<cfquery name="getCurrRate" datasource="#dts#">
						Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#'
						</cfquery> --->
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
					  	<!---<cfset temp_p = #getCurrRate.currrate# * #getictran.price_bil#> --->
					  	<cfset temp_p = getictran.currrate * xprice_bil>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p,stDecl_UPrice)#</font></div></td>
					  	<cfset temp_a = getictran.currrate * getictran.amt_bil>
					  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
					</tr>
					</cfoutput>

					<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
							<!---<cfset CurrArray[i+1][3] = #CurrArray[i+1][3] + 1>
							<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getCurrRate.currrate> --->
							<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + temp_a>
							<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
							<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + invqty<!---DOQTY--->>
							<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
						</cfif>

						<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
							<!---<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
							<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate> --->
							<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
							<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
							<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + invqty<!---DOQTY--->>
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
				select type from iclink where frrefno = '#refno#' and frtype = 'SO'
			</cfquery>

        	<cfquery name = "getDOQTY" datasource = "#dts#">
        		select sum(shipped) as T_QTY from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfif getDOQTY.T_QTY neq "">
          		<cfset DO_Total_QTY = getDOQTY.T_QTY>
          	<cfelse>
          		<cfset DO_Total_QTY = 0>
        	</cfif>

			<cfquery name = "getSOQTY" datasource = "#dts#">
        		select qty_bil from ictran where type ='SO' and refno = '#getartran.refno#' and qty <> '0'
        	</cfquery>

			<cfset SO_Total_QTY = 0>

			<cfloop query = "getSOQTY">
          		<cfset SO_Total_QTY = SO_Total_QTY + getSOQTY.qty_bil>
        	</cfloop>

			<cfset Balance = SO_Total_QTY - DO_Total_QTY>
        	<!--- If Balance is 0 then is Completed --->
        	<cfif Balance eq 0 or checkiclink.recordcount gt 0>
          		<!--- Print the sub-total --->
          		<cfif stLastSONO neq getartran.refno and stLastNo neq "">
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
						<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="15" valign="top" nowrap>&nbsp;</td>
            		</tr>
          		</cfif>
          		<!---<cfif stLastNo eq ""> --->
          		<cfquery name="getCust" datasource="#dts#">
          			select phone, phonea, add1, add2, add3, add4 from customer where customerno = '#getartran.custno#'
          		</cfquery>

				<cfoutput>
          		<tr>
            		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
            		<td colspan="15"><font face="Times New Roman, Times, serif"><font size="1"><strong>#getartran.custno# #getartran.name#</strong> TEL: #getcust.phone# #getcust.phonea#</font></font></td>
          		</tr>
          		<tr>
            		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
            		<td colspan="15"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getcust.add1# #getcust.add2# #getcust.add3# #getcust.add4#</font></font></div></td>
          		</tr>
			  	<tr>
					<td valign="top" nowrap>&nbsp;</td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix#</font><font face="Times New Roman, Times, serif"><font size="1">#getartran.refno#</font></font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">&nbsp;</font></font></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
			  	</tr>
			  	</cfoutput>

			  	<cfset stLastNo = year(getartran.wos_date) & month(getartran.wos_date)>
			  	<cfset stLastSONo = getartran.refno>
			  	<!--- Print details --->
			  	<!---<cfquery name="getictran" datasource="#dts#">
			  		select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
			  	</cfquery>--->
				<cfquery name="getictran" datasource="#dts#">
          			select a.* from ictran a, iclink b where a.refno ='#refno#' and a.refno=b.frrefno and b.frtrancode=a.trancode
					and a.itemno=b.itemno and a.type = 'SO' and b.frtype = 'SO'  and a.qty <> '0' group by a.itemcount order by a.itemcount
          		</cfquery>

			  	<cfloop query = "getictran">
			  		<cfoutput>
					<tr>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;</font></font></div></td>
					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
					  	<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>

					  	<cfquery name="getPOCode" datasource="#dts#">
					  		select pocode from gsetup
					  	</cfquery>

					  	<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"></font></font></div></td>

						<cfquery name="getInvCode" datasource="#dts#">
					  		select Invcode from gsetup
					 	</cfquery>

					  	<cfquery name="getInvoice" datasource="#dts#">
					  		select distinct(refno)as refno, toinv,dodate,qty from ictran where sono = '#refno#' and itemno='#getictran.itemno#' and type = 'DO' order by toinv
					  	</cfquery>

						<!---<cfset invdate = ''>

						<cfloop query="getinvoice">
							<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#toinv#' and type = 'INV'
							</cfquery>

							<cfif getinvdate.recordcount gt 0>
								<cfset invdate = invdate & " " &#dateformat(getinvdate.wos_date,"dd/mm/yy")#>
							</cfif>
					  	</cfloop>--->
				  		<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice">#getInvCode.Invcode##getInvoice.toinv#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
              			<td><div align="left"><font face="Times New Roman, Times, serif"><font size="1">
						<cfloop query="getInvoice">
							<cfquery name="getinvdate" datasource="#dts#">
								select wos_date from artran where refno = '#getinvoice.toinv#' and type = 'INV'
							</cfquery>
							#dateformat(getinvdate.wos_date,"dd/mm/yyyy")#<cfif getinvdate.recordcount gt 1><br></cfif>
						</cfloop>
						</font></font></div></td>
				  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>
				  		<!--- get the item qty delived from the DO, and it was updated from SO --->
				  		<!--- <cfquery name="getDOQTY2" datasource="#dts#">
					  	select qty_bil from ictran where type ='DO' and itemno = '#getictran.itemno#'
					  	and sono = '#stLastSONO#' and qty <> '0'
					 	</cfquery>
					  	<cfset DOqty = 0>
					  	<cfif getDOQTY2.recordcount eq 0>
						<cfset DOqty = 0>
						<cfelse>
						<cfloop query = "getDOQTY2">
						<cfset DOqty = #DOqty# + #getDOQTY2.qty_bil#>
						</cfloop>
					  	</cfif> --->
					  	<cfset doqty = getictran.shipped>
						<cfset invqty = 0>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1"><cfloop query="getInvoice"><cfset invqty = invqty + getInvoice.qty>#getInvoice.qty#<cfif getInvoice.recordcount gt 1><br></cfif></cfloop></font></font></div></td>
					  	<cfset Bal = 0>
					 	<cfset Bal = getictran.qty_bil - invqty<!---DOqty--->>
					  	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#Bal#</font></font></div></td>

						<cfquery name="getCurrCode2" datasource="#dts#">
					  		select currcode from customer where customerno ='#getictran.custno#'
					  	</cfquery>

				  		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getCurrCode2.currcode#</font></font></div></td>
				  		<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
				  		<!---<cfset stLastCurr = #getcurrcode2.currcode#> --->
				  		<cfset xprice_bil= getictran.price_bil-(getictran.disamt_bil/getictran.qty_bil)>
				  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(xprice_bil,stDecl_UPrice)#</font></div></td>
				  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>
				  		<!---<cfquery name="getCurrRate" datasource="#dts#">
						Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#'
						</cfquery> --->
				  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.currrate,'____.____')#</font></div></td>
				  		<!---<cfset temp_p = #getCurrRate.currrate# * #getictran.price_bil#> --->
				  		<cfset temp_p = getictran.currrate * xprice_bil>
				  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p,stDecl_UPrice)#</font></div></td>
				  		<cfset temp_a = getictran.currrate * getictran.amt_bil>
				  		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
					</tr>
					</cfoutput>

					<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                			<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
							<!---<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + 1>
							<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getCurrRate.currrate> --->
							<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + temp_a>
							<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
							<cfset CurrArray[i+1][7] = CurrArray[i+1][7] + invqty<!---DOQTY--->>
							<cfset CurrArray[i+1][8] = CurrArray[i+1][8] + Bal>
						</cfif>

						<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
							<!---<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
							<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate> --->
							<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
							<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
							<cfset CurrArray2[i+1][7] = CurrArray2[i+1][7] + invqty<!---DOQTY--->>
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
    </cfloop>--->
    <tr>
      	<td colspan="16" valign="top" nowrap>&nbsp;</td>
    </tr>
    <!---</cfif>--->
    <!---Print Grand Total--->
    <tr>
      	<td valign="top" nowrap>&nbsp;</td>
     	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][6]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][7]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][8]#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[2][1]#</cfoutput></font></div></td>
      	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][2],',_.__')#</cfoutput></font></div></td>
      	<td>&nbsp;</td>
      	<!---<cfif CurrArray2[2][3] neq 0>
      	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][4]/CurrArray2[2][3],',_.____')#</cfoutput></font></div></td>
	  	<cfelse>
		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][3],',_.____')#</cfoutput></font></div></td>
      	</cfif> --->
      	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[2][5],',_.__')#</cfoutput></font></div></td>
      	<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
      	<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
     	<td>&nbsp;</td>
     	<cfset SGDEquiTotal = CurrArray2[2][5]>
      	<cfset TotalOrder = CurrArray2[2][6]>
      	<cfset TotalDelived = CurrArray2[2][7]>
      	<cfset TotalBalance = CurrArray2[2][8]>
    </tr>
    <cfset maxArray = right(CurrArray2[1][1],1)>

	<cfloop index = "i" from = "2" to = "#maxArray#">
      	<cfif CurrArray2[i+1][2] neq 0>
        	<tr>
          		<td valign="top" nowrap>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
			  	<td>&nbsp;</td>
			  	<td>&nbsp;</td>
			  	<td>&nbsp;</td>
			 	<td>&nbsp;</td>
			 	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][6]#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][7]#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][8]#</cfoutput></font></div></td>
			  	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][1]#</cfoutput></font></div></td>
			  	<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][2],',_.__')#</cfoutput></font></div></td>
			  	<td>&nbsp;</td>
			  	<!---<cfif CurrArray2[i+1][3] neq 0>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][4]/CurrArray2[i+1][3],',_.____')#</cfoutput></font></div></td>
			  	<cfelse>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][3],',_.____')#</cfoutput></font></div></td>
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