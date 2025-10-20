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
	select #prefix# as prefix,lastaccyear from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getartran">
	Select * from artran where type = '#url.trancode#' and (void = '' or void is null)
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
		order by name
		</cfcase>
		<cfcase value="Client Code">
		order by custno
		</cfcase>
		<cfcase value="Month">
		order by year(wos_date), month(wos_date)
		</cfcase>
	</cfswitch>
</cfquery>

<html>
<head>
<title>SO Listing Detail By <cfoutput>#url.rgSort#</cfoutput></title>
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
		<h4><font color="##FF0000">Please add in email address for customer - #getheaderinfo.custno#.</font></h4></cfoutput>
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
<strong><font size="1" face="Arial, Helvetica, sans-serif">
<cfif getartran.refno eq "">
	<cfoutput><font color="##FF0000">No Report Generated.</font></cfoutput>
	<cfabort>
</cfif>
</font>
</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="3"><div align="center"><font size="4" face="Arial black"><strong>MSD ENGINEERING PTE LTD</strong></font><br>
						<font size="1" face="Times New Roman, Times, serif">23 HILLVIEW TERRACE</font><br>
						<font size="1" face="Times New Roman, Times, serif">SINGAPORE 669234</font><br>
          				<font size="1" face="Times New Roman, Times, serif">TEL :(65) 6462 9119&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FAX :(65) 6462 9118</font><br>
						<font size="1" face="Times New Roman, Times, serif">ROC/GST NO.: 200504367W</font>
						</div>
		</td>
	</tr>
	<tr>
		<td><font size="1" face="Times New Roman, Times, serif"><strong>SO Listing Details By <cfoutput>#url.rgsort#</cfoutput></strong></font></td>
		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Date	: <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
	</tr>
    <tr>
    	<td colspan="13"><hr></td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      	<td nowrap colspan="8"></td>
      	<td nowrap colspan="2"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Foreign Currency</strong></font></div></td>
      	<td nowrap><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>Exchg Rate</strong></font></div></td>
      	<td nowrap colspan="2"><div align="center"><font size="1" face="Times New Roman, Times, serif"><strong>SGD Equialent</strong></font></div></td>
    </tr>
    <tr>
      	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Client Code</strong></font></div></td>
      	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Company Name</strong></font></div></td>
      	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>SO Date</strong></font></div></td>
      	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Client's PO No.</strong></font></div></td>
      	<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif"><strong>Contract No.</strong></font></div></td>
      	<td nowrap><font size="1" face="Times New Roman, Times, serif"><strong>Our PO No.</strong></font></td>
      	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Qty</strong></font></div></td>
      	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Currency</strong></font></div></td>
      	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>U.Price</strong></font></div></td>
      	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
      	<td nowrap></td>
      	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>U.Price</strong></font></div></td>
      	<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif"><strong>Total Price</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="13"><hr></td>
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
    <cfset CurrArray2[1][6] = "Qty">
    <cfset CurrArray2[2][1] = "SGD">
    <cfset CurrArray2[2][2] = 0>
    <cfset CurrArray2[2][3] = 0>
    <cfset CurrArray2[2][4] = 0>
    <cfset CurrArray2[2][5] = 0>
    <cfset CurrArray2[2][6] = 0>

	<cfquery name="getCurrCode" datasource="#dts#">
    	select CurrCode from Currencyrate order by currcode
    </cfquery>

	<cfset i = 3>

	<cfloop query="getCurrCode">
      	<cfif getCurrCode.CurrCode neq "SGD">
        	<cfset CurrArray2[i][1] = getCurrCode.CurrCode>
        	<cfset CurrArray2[i][2] = 0>
        	<cfset CurrArray2[i][3] = 0>
        	<cfset CurrArray2[i][4] = 0>
        	<cfset CurrArray2[i][5] = 0>
        	<cfset CurrArray2[i][6] = 0>
        	<cfset i = i + 1>
      	</cfif>
    </cfloop>
    <!--- Track the Max Curr Code --->
    <cfset CurrArray2[1][1] = CurrArray2[1][1] & ToString(#i# - 2)>
    <cfset SGDEquiTotal = 0>
    <!--- For Grand Total --->
    <cfset CurrArray1 = ArrayNew(2)>
    <cfset CurrArray1[1][1] = "Currency - ">
    <cfset CurrArray1[1][2] = "FC.T.Price">
    <cfset CurrArray1[1][3] = "No.E.Rate">
    <cfset CurrArray1[1][4] = "E.Rate">
    <cfset CurrArray1[1][5] = "SGD.T.Price">
    <cfset CurrArray1[1][6] = "Qty">
    <cfset CurrArray1[2][1] = "SGD">
    <cfset CurrArray1[2][2] = 0>
    <cfset CurrArray1[2][3] = 0>
    <cfset CurrArray1[2][4] = 0>
    <cfset CurrArray1[2][5] = 0>
    <cfset CurrArray1[2][6] = 0>

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
    <cfset CurrArray[1][6] = "Qty">
    <cfset CurrArray[2][1] = "SGD">
    <cfset CurrArray[2][2] = 0>
    <cfset CurrArray[2][3] = 0>
    <cfset CurrArray[2][4] = 0>
    <cfset CurrArray[2][5] = 0>
    <cfset CurrArray[2][6] = 0>

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
        	<cfset i = #i# + 1>
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
        	<cfif stLastNo eq "">
			  	<cfoutput>
          		<tr>
            		<td nowrap valign="top"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
            		<td nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
            		<td nowrap><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
            		<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
            		<td nowrap><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
					<!--- <cfquery name="getPOCode" datasource="#dts#">
					select pocode from gsetup
					</cfquery>
					<cfquery name="getPONO" datasource="#dts#">
					select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
					= 'PO' and qty <> '0'
					</cfquery> --->
					<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          		</tr>
		  		</cfoutput>
        	</cfif>

			<cfif stLastNo neq getartran.refno and stLastNo neq "">
          		<tr>
            		<td colspan="13"><hr></td>
          		</tr>
          		<cfset maxArray = right(CurrArray[1][1],1)>
          		<cfset stDisplay = 0>

				<cfloop index = "i" from = "1" to = "#maxArray#">
            		<cfif CurrArray[i+1][2] neq 0>
              			<cfoutput>
			  			<tr>
                			<td valign="top" nowrap>&nbsp;</td>
                			<td>&nbsp;</td>
                			<td>&nbsp;</td>
                			<td>&nbsp;</td>
                			<cfif stDisplay eq 0>
                  				<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                  				<cfset stDisplay = 1>
                  			<cfelse>
                  				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                			</cfif>
                			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                			<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
							<!---<cfif CurrArray[i+1][3] neq 0>
							  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</font></div></td>
							  <cfelse>
							  <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.____')#</font></div></td>
							</cfif>--->
							<td></td>
                			<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                			<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                			<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                			<td>&nbsp;</td>
              			</tr>
			  			</cfoutput>
            		</cfif>
            		<cfset i = i + 1>
          		</cfloop>
          		<!--- 				Clear the sub total --->

				<cfloop index = "i" from = "1" to = "#maxArray#">
            		<cfset CurrArray[i+1][2] = 0>
            		<cfset CurrArray[i+1][3] = 0>
					<cfset CurrArray[i+1][4] = 0>
					<cfset CurrArray[i+1][5] = 0>
					<cfset CurrArray[i+1][6] = 0>
					<cfset i = i + 1>
          		</cfloop>
          		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
          		</tr>
		  		<cfoutput>
          		<tr>
            		<td nowrap valign="top"><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
            		<td nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
            		<td nowrap><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
            		<td nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
            		<td nowrap><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
					<!--- <cfquery name="getPOCode" datasource="#dts#">
					select pocode from gsetup
					</cfquery>
					<cfquery name="getPONO" datasource="#dts#">
					select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
					= 'PO' and qty <> '0'
					</cfquery> --->
					<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          		</tr>
		  		</cfoutput>
        	</cfif>

			<cfset stLastNo = getartran.refno>

			<cfquery name="getictran" datasource="#dts#">
        		select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
        	</cfquery>

			<cfloop query = "getictran">
				<cfoutput>
          		<tr>
            		<td nowrap><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;&nbsp;</font></font></div></td>
            		<td nowrap colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
            		<td nowrap colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>
            		<td nowrap><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

					<cfquery name="getCurrCode2" datasource="#dts#">
            			select currcode from customer where customerno ='#getictran.custno#'
            		</cfquery>

					<td nowrap><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getcurrcode2.currcode#</font></font></div></td>
            		<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
            		<cfset stLastCurr = getcurrcode2.currcode>
					<cfset xpricebil = getictran.price_bil>
					<cfset xdiscount = getictran.disamt_bil/getictran.qty_bil>
					<cfset adprice = xpricebil - xdiscount>
            		<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(adprice, stDecl_UPrice)#</font></div></td>
            		<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>

					<cfquery name="getCurrRate" datasource="#dts#">
            			Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#' and qty <> '0'
            		</cfquery>

					<td nowrap><div align="center"><font size="1" face="Times New Roman, Times, serif">#numberformat(getCurrRate.currrate,'____.____')#</font></div></td>
            		<cfset temp_p = getCurrRate.currrate * adprice>
					<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p, stDecl_UPrice)#</font></div></td>
					<cfset temp_a = getCurrRate.currrate * getictran.amt_bil>
					<td nowrap><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
					<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
							<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + 1>
							<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getCurrRate.currrate>
							<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + temp_a>
							<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
              			</cfif>

						<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
							<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
							<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate>
							<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
							<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
						</cfif>
             	 		<cfset i = i + 1>
            		</cfloop>
          		</tr>
		  		</cfoutput>
        	</cfloop>
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
        	<cfif stLastNo eq "">
				<cfoutput>
          		<tr>
            		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
					<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
					<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
					<!--- <cfquery name="getPOCode" datasource="#dts#">
					select pocode from gsetup
					</cfquery>
					<cfquery name="getPONO" datasource="#dts#">
					select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
					= 'PO' and qty <> '0'
					</cfquery> --->
					<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          		</tr>
		  		</cfoutput>
          	<cfelse>
		  		<cfif stLastNo neq getartran.name and stLastNo neq "">
            		<tr>
              			<td colspan="4">&nbsp;</td>
              			<td colspan="9"><hr></td>
           	 		</tr>
            		<cfset maxArray = right(CurrArray[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  				</cfif>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="13"><hr></td>
            		</tr>
            		<cfset maxArray = right(CurrArray1[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray1[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  				</cfif>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray1[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][4]/CurrArray1[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
            		<!--- Clear the grand total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfset CurrArray1[i+1][2] = 0>
              			<cfset CurrArray1[i+1][3] = 0>
              			<cfset CurrArray1[i+1][4] = 0>
              			<cfset CurrArray1[i+1][5] = 0>
              			<cfset CurrArray1[i+1][6] = 0>
             	 		<cfset i = i + 1>
            		</cfloop>
            		<!--- Clear the sub total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfset CurrArray[i+1][2] = 0>
              			<cfset CurrArray[i+1][3] = 0>
              			<cfset CurrArray[i+1][4] = 0>
              			<cfset CurrArray[i+1][5] = 0>
              			<cfset CurrArray[i+1][6] = 0>
              			<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td valign="top" nowrap>&nbsp;</td>
              			<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
            		</tr>
					<cfoutput>
            		<tr>
              			<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
					  	<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
					  	<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
					  	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
					  	<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
					  	<!--- <cfquery name="getPOCode" datasource="#dts#">
					  	select pocode from gsetup
					  	</cfquery>
					 	<cfquery name="getPONO" datasource="#dts#">
						select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
						= 'PO' and qty <> '0'
						</cfquery> --->
						<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          			</tr>
		  			</cfoutput>
            	<cfelse>
            		<tr>
              			<td colspan="4">&nbsp;</td>
              		<td colspan="9"><hr></td>
            		</tr>
            		<cfset maxArray = right(CurrArray[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  				</cfif>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
            		<!--- Clear the sub total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfset CurrArray[i+1][2] = 0>
              			<cfset CurrArray[i+1][3] = 0>
						<cfset CurrArray[i+1][4] = 0>
						<cfset CurrArray[i+1][5] = 0>
						<cfset CurrArray[i+1][6] = 0>
						<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td valign="top" nowrap>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
            		</tr>
					<cfoutput>
            		<tr>
              			<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1"></font></font></td>
              			<td><font face="Times New Roman, Times, serif"><font size="1"></font></font></td>
              			<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
              			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
              			<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
              			<!--- <cfquery name="getPOCode" datasource="#dts#">
              			select pocode from gsetup
              			</cfquery>
              			<cfquery name="getPONO" datasource="#dts#">
            			select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
            			= 'PO' and qty <> '0'
            			</cfquery> --->
            			<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          			</tr>
		  			</cfoutput>
          		</cfif>
        	</cfif>

			<cfset stLastNo = getartran.name>
        	<cfset stLastSONo = getartran.refno>

			<cfquery name="getictran" datasource="#dts#">
        		select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
       		 </cfquery>

			<cfloop query = "getictran">
          		<cfoutput>
		  		<tr>
            		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;&nbsp;</font></font></div></td>
            		<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
            		<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>
            		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

					<cfquery name="getCurrCode2" datasource="#dts#">
            			select currcode from customer where customerno ='#getictran.custno#'
           	 		</cfquery>

					<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getcurrcode2.currcode#</font></font></div></td>
            		<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
            		<cfset stLastCurr = getcurrcode2.currcode>
					<cfset xpricebil = getictran.price_bil>
					<cfset xdiscount = getictran.disamt_bil/getictran.qty_bil>
					<cfset adprice = xpricebil - xdiscount>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(adprice, stDecl_UPrice)#</font></div></td>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>

					<cfquery name="getCurrRate" datasource="#dts#">
            			Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#' and qty <> '0'
            		</cfquery>

					<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getCurrRate.currrate,'____.____')#</font></div></td>
            		<cfset temp_p = getCurrRate.currrate * adprice>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p, stDecl_UPrice)#</font></div></td>
            		<cfset temp_a = getCurrRate.currrate * getictran.amt_bil>
           	 		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
            		<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                			<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
                			<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + 1>
                			<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getCurrRate.currrate>
                			<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + temp_a>
                			<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
              			</cfif>

              			<cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.amt_bil>
							<cfset CurrArray1[i+1][3] = CurrArray1[i+1][3] + 1>
							<cfset CurrArray1[i+1][4] = CurrArray1[i+1][4] + getCurrRate.currrate>
							<cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + temp_a>
							<cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.qty_bil>
              			</cfif>

			  			<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
							<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
							<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate>
							<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
							<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
          		</tr>
		  		</cfoutput>
        	</cfloop>
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
        	<cfif stLastNo eq "">
          		<cfoutput>
		  		<tr>
            		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
            		<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
            		<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
            		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
            		<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
            		<!--- <cfquery name="getPOCode" datasource="#dts#">
					select pocode from gsetup
					</cfquery>
					<cfquery name="getPONO" datasource="#dts#">
					select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
					= 'PO' and qty <> '0'
					</cfquery> --->
					<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          		</tr>
		  		</cfoutput>
          	<cfelse>
          		<cfif stLastNo neq getartran.custno and stLastNo neq "">
            		<tr>
              			<td colspan="4">&nbsp;</td>
              			<td colspan="9"><hr></td>
            		</tr>
            		<cfset maxArray = right(CurrArray[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  				</cfif>
                 	 			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="13"><hr></td>
            		</tr>
            		<cfset maxArray = right(CurrArray1[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray1[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  				</cfif>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray1[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][4]/CurrArray1[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
            		<!--- Clear the grand total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfset CurrArray1[i+1][2] = 0>
              			<cfset CurrArray1[i+1][3] = 0>
              			<cfset CurrArray1[i+1][4] = 0>
              			<cfset CurrArray1[i+1][5] = 0>
              			<cfset CurrArray1[i+1][6] = 0>
             	 		<cfset i = i + 1>
            		</cfloop>
            		<!--- Clear the sub total --->
           	 		<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfset CurrArray[i+1][2] = 0>
              			<cfset CurrArray[i+1][3] = 0>
					  	<cfset CurrArray[i+1][4] = 0>
					  	<cfset CurrArray[i+1][5] = 0>
					  	<cfset CurrArray[i+1][6] = 0>
					  	<cfset i = i + 1>
            		</cfloop>
            		<tr>
						<td valign="top" nowrap>&nbsp;</td>
					  	<td>&nbsp;</td>
					 	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					 	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
            		</tr>
					<cfoutput>
            		<tr>
            			<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
              			<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
					  	<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
					 	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
					  	<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
              			<!--- <cfquery name="getPOCode" datasource="#dts#">
              			select pocode from gsetup
              			</cfquery>
              			<cfquery name="getPONO" datasource="#dts#">
            			select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
            			= 'PO' and qty <> '0'
            			</cfquery> --->
            			<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          			</tr>
		  			</cfoutput>
            	<cfelse>
            		<tr>
              			<td colspan="4">&nbsp;</td>
              			<td colspan="9"><hr></td>
            		</tr>
            		<cfset maxArray = right(CurrArray[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  				</cfif>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
            		<!--- Clear the sub total --->
            		<cfloop index = "i" from = "1" to = "#maxArray#">
					  	<cfset CurrArray[i+1][2] = 0>
					  	<cfset CurrArray[i+1][3] = 0>
					  	<cfset CurrArray[i+1][4] = 0>
					  	<cfset CurrArray[i+1][5] = 0>
					  	<cfset CurrArray[i+1][6] = 0>
					  	<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td valign="top" nowrap>&nbsp;</td>
              			<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
					  	<td>&nbsp;</td>
            		</tr>
					<cfoutput>
            		<tr>
              			<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1"></font></font></td>
              			<td><font face="Times New Roman, Times, serif"><font size="1"></font></font></td>
              			<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
              			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
              			<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
              			<!--- <cfquery name="getPOCode" datasource="#dts#">
              			select pocode from gsetup
              			</cfquery>
              			<cfquery name="getPONO" datasource="#dts#">
            			select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
            			= 'PO' and qty <> '0'
            			</cfquery> --->
            			<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          			</tr>
		  			</cfoutput>
          		</cfif>
        	</cfif>

			<cfset stLastNo = getartran.custno>
        	<cfset stLastSONo = getartran.refno>

			<cfquery name="getictran" datasource="#dts#">
        		select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
        	</cfquery>

			<cfloop query = "getictran">
		  		<cfoutput>
          		<tr>
            		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;&nbsp;</font></font></div></td>
            		<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
            		<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>
            		<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

					<cfquery name="getCurrCode2" datasource="#dts#">
            			select currcode from customer where customerno ='#getictran.custno#'
            		</cfquery>

					<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getcurrcode2.currcode#</font></font></div></td>
            		<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
            		<cfset stLastCurr = getcurrcode2.currcode>
					<cfset xpricebil = getictran.price_bil>
					<cfset xdiscount = getictran.disamt_bil/getictran.qty_bil>
					<cfset adprice = xpricebil - xdiscount>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(adprice, stDecl_UPrice)#</font></div></td>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>

					<cfquery name="getCurrRate" datasource="#dts#">
            			Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#' and qty <> '0'
            		</cfquery>

					<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getCurrRate.currrate,'____.____')#</font></div></td>
            		<cfset temp_p = getCurrRate.currrate * adprice>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p, stDecl_UPrice)#</font></div></td>
           	 		<cfset temp_a = getCurrRate.currrate * getictran.amt_bil>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
            		<cfset maxArray = right(CurrArray2[1][1],1)>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][1] eq getcurrcode2.currcode>
                			<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getictran.amt_bil>
                			<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + 1>
                			<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getCurrRate.currrate>
                			<cfset CurrArray[i+1][5] = CurrArray[i+1][5] + temp_a>
                			<cfset CurrArray[i+1][6] = CurrArray[i+1][6] + getictran.qty_bil>
              			</cfif>

						<cfif CurrArray1[i+1][1] eq getcurrcode2.currcode>
                			<cfset CurrArray1[i+1][2] = CurrArray1[i+1][2] + getictran.amt_bil>
							<cfset CurrArray1[i+1][3] = CurrArray1[i+1][3] + 1>
							<cfset CurrArray1[i+1][4] = CurrArray1[i+1][4] + getCurrRate.currrate>
							<cfset CurrArray1[i+1][5] = CurrArray1[i+1][5] + temp_a>
							<cfset CurrArray1[i+1][6] = CurrArray1[i+1][6] + getictran.qty_bil>
              			</cfif>

			  			<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
							<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
							<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
							<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate>
							<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
							<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
          		</tr>
		  		</cfoutput>
        	</cfloop>
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
        	<cfif stLastNo eq "">
				<cfoutput>
          		<tr>
            		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
            		<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
           	 		<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
            		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
            		<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
					<!--- <cfquery name="getPOCode" datasource="#dts#">
					select pocode from gsetup
					</cfquery>
					<cfquery name="getPONO" datasource="#dts#">
					select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
					= 'PO' and qty <> '0'
					</cfquery> --->
					<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          		</tr>
		  		</cfoutput>
          	<cfelse>
          		<cfif stLastNo neq year(getartran.wos_date) & month(getartran.wos_date) and stLastNo neq "">
            		<tr>
              			<td colspan="13"><hr></td>
            		</tr>
            		<cfset maxArray = right(CurrArray[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                 	 			</cfif>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
              			<cfset i = i + 1>
            		</cfloop>
            		<tr>
              			<td colspan="13"><hr></td>
            		</tr>
            		<cfset maxArray = right(CurrArray1[1][1],1)>
            		<cfset stDisplay = 0>

					<cfloop index = "i" from = "1" to = "#maxArray#">
              			<cfif CurrArray1[i+1][2] neq 0>
                			<cfoutput>
							<tr>
                  				<td valign="top" nowrap>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<td>&nbsp;</td>
                  				<cfif stDisplay eq 0>
                    				<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
                    				<cfset stDisplay = 1>
                    			<cfelse>
                    				<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  				</cfif>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][6]#</font></div></td>
                  				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray1[i+1][1]#</font></div></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][2],',_.__')#</font></div></td>
                  				<!---<cfif CurrArray1[i+1][3] neq 0>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][4]/CurrArray1[i+1][3],',_.____')#</font></div></td>
                    			<cfelse>
                    			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][3],',_.____')#</font></div></td>
                  				</cfif>--->
				  				<td></td>
                  				<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray1[i+1][5],',_.__')#</font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  				<td>&nbsp;</td>
                			</tr>
							</cfoutput>
              			</cfif>
             		 <cfset i = i + 1>
            	</cfloop>
            	<!--- Clear the grand total --->
            	<cfloop index = "i" from = "1" to = "#maxArray#">
            		<cfset CurrArray1[i+1][2] = 0>
              		<cfset CurrArray1[i+1][3] = 0>
              		<cfset CurrArray1[i+1][4] = 0>
              		<cfset CurrArray1[i+1][5] = 0>
              		<cfset CurrArray1[i+1][6] = 0>
              		<cfset i = i + 1>
            	</cfloop>
            	<!--- Clear the sub total --->
            	<cfloop index = "i" from = "1" to = "#maxArray#">
				  	<cfset CurrArray[i+1][2] = 0>
				  	<cfset CurrArray[i+1][3] = 0>
				  	<cfset CurrArray[i+1][4] = 0>
				  	<cfset CurrArray[i+1][5] = 0>
				  	<cfset CurrArray[i+1][6] = 0>
				  	<cfset i = i + 1>
            	</cfloop>
            	<tr>
              		<td valign="top" nowrap>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
            	</tr>
				<cfoutput>
            	<tr>
              		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
              		<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
              		<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
              		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
              		<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
              		<!--- <cfquery name="getPOCode" datasource="#dts#">
              		select pocode from gsetup
              		</cfquery>
              		<cfquery name="getPONO" datasource="#dts#">
            		select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
            		= 'PO' and qty <> '0'
            		</cfquery> --->
            		<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          		</tr>
		  		</cfoutput>
            <cfelse>
            	<tr>
              		<td colspan="13"><hr></td>
            	</tr>
            	<cfset maxArray = right(CurrArray[1][1],1)>
            	<cfset stDisplay = 0>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][2] neq 0>
                		<cfoutput>
						<tr>
                  			<td valign="top" nowrap>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<td>&nbsp;</td>
                  			<cfif stDisplay eq 0>
                    			<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
                    			<cfset stDisplay = 1>
                    		<cfelse>
                    			<td colspan="2"><div align="right"><strong>&nbsp;</strong></div></td>
                  			</cfif>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][6]#</font></div></td>
                  			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#CurrArray[i+1][1]#</font></div></td>
                  			<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][2],',_.__')#</font></div></td>
                  			<!---<cfif CurrArray[i+1][3] neq 0>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</font></div></td>
                    		<cfelse>
                    		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][3],',_.____')#</font></div></td>
                  			</cfif>--->
				  			<td></td>
                  			<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(CurrArray[i+1][5],',_.__')#</font></div></td>
                  			<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  			<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
                  			<td>&nbsp;</td>
                		</tr>
						</cfoutput>
              		</cfif>
              		<cfset i = i + 1>
            	</cfloop>
            	<!--- Clear the sub total --->
            	<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfset CurrArray[i+1][2] = 0>
              		<cfset CurrArray[i+1][3] = 0>
              		<cfset CurrArray[i+1][4] = 0>
              		<cfset CurrArray[i+1][5] = 0>
              		<cfset CurrArray[i+1][6] = 0>
              		<cfset i = i + 1>
            	</cfloop>
            	<tr>
              		<td valign="top" nowrap>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
              		<td>&nbsp;</td>
            	</tr>
				<cfoutput>
            	<tr>
              		<td valign="top" nowrap><font face="Times New Roman, Times, serif"><font size="1">#getartran.custno#</font></font></td>
              		<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.name#</font></font></td>
              		<td><font face="Times New Roman, Times, serif"><font size="1">#dateformat(getartran.wos_date,"dd/mm/yyyy")#</font></font></td>
              		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getartran.rem9#</font></div></td>
              		<td><font face="Times New Roman, Times, serif"><font size="1">#getgeneral.prefix##getartran.refno#</font></font></td>
              		<!--- <cfquery name="getPOCode" datasource="#dts#">
              		select pocode from gsetup
              		</cfquery>
              		<cfquery name="getPONO" datasource="#dts#">
            		select distinct(refno) as refno from ictran where sono ='#getartran.refno#' and type
            		= 'PO' and qty <> '0'
            		</cfquery> --->
            		<!---<td><font face="Times New Roman, Times, serif"><font size="1">#getartran.rem8#</font></font></td>--->
          		</tr>
		  		</cfoutput>
          	</cfif>
        </cfif>

		<cfset stLastNo = year(getartran.wos_date) & month(getartran.wos_date)>
        <cfset stLastSONo = getartran.refno>

		<cfquery name="getictran" datasource="#dts#">
        	select * from ictran where refno ='#getartran.refno#' and type = 'SO' and qty <> '0' order by itemcount
        </cfquery>

        <cfloop query = "getictran">
          	<cfoutput>
		  	<tr>
            	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemcount#.&nbsp;&nbsp;</font></font></div></td>
            	<td colspan="2"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.itemno#</font></font></div></td>
            	<td colspan="3"><div align="left"><font face="Times New Roman, Times, serif"><font size="1">#getictran.desp#</font></font></div></td>
            	<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getictran.qty_bil#</font></font></div></td>

				<cfquery name="getCurrCode2" datasource="#dts#">
            		select currcode from customer where customerno ='#getictran.custno#'
            	</cfquery>

				<td><div align="right"><font face="Times New Roman, Times, serif"><font size="1">#getcurrcode2.currcode#</font></font></div></td>
            	<!---<cfset LCurrCode = #getcurrcode2.currcode#> --->
            	<cfset stLastCurr = getcurrcode2.currcode>
				<cfset xpricebil = getictran.price_bil>
				<cfset xdiscount = getictran.disamt_bil/getictran.qty_bil>
				<cfset adprice = xpricebil - xdiscount>

				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(adprice, stDecl_UPrice)#</font></div></td>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getictran.amt_bil,',_.__')#</font></div></td>

				<cfquery name="getCurrRate" datasource="#dts#">
            		Select currrate from ictran where type = 'SO' and refno = '#getictran.refno#' and qty <> '0'
            	</cfquery>

				<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#numberformat(getCurrRate.currrate,'____.____')#</font></div></td>
            	<cfset temp_p = getCurrRate.currrate * adprice>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_p, stDecl_UPrice)#</font></div></td>
            	<cfset temp_a = getCurrRate.currrate * getictran.amt_bil>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(temp_a,',_.__')#</font></div></td>
            	<cfset maxArray = right(CurrArray2[1][1],1)>

				<cfloop index = "i" from = "1" to = "#maxArray#">
              		<cfif CurrArray[i+1][1] eq #getcurrcode2.currcode#>
						<cfset CurrArray[i+1][2] = #CurrArray[i+1][2]# + #getictran.amt_bil#>
						<cfset CurrArray[i+1][3] = #CurrArray[i+1][3]# + 1>
						<cfset CurrArray[i+1][4] = #CurrArray[i+1][4]# + #getCurrRate.currrate#>
						<cfset CurrArray[i+1][5] = #CurrArray[i+1][5]# + #temp_a#>
						<cfset CurrArray[i+1][6] = #CurrArray[i+1][6]# + #getictran.qty_bil#>
             	 	</cfif>

			  		<cfif CurrArray1[i+1][1] eq #getcurrcode2.currcode#>
						<cfset CurrArray1[i+1][2] = #CurrArray1[i+1][2]# + #getictran.amt_bil#>
						<cfset CurrArray1[i+1][3] = #CurrArray1[i+1][3]# + 1>
						<cfset CurrArray1[i+1][4] = #CurrArray1[i+1][4]# + #getCurrRate.currrate#>
						<cfset CurrArray1[i+1][5] = #CurrArray1[i+1][5]# + #temp_a#>
						<cfset CurrArray1[i+1][6] = #CurrArray1[i+1][6]# + #getictran.qty_bil#>
              		</cfif>

			  		<cfif CurrArray2[i+1][1] eq getcurrcode2.currcode>
                		<cfset CurrArray2[i+1][2] = CurrArray2[i+1][2] + getictran.amt_bil>
                		<cfset CurrArray2[i+1][3] = CurrArray2[i+1][3] + 1>
                		<cfset CurrArray2[i+1][4] = CurrArray2[i+1][4] + getCurrRate.currrate>
                		<cfset CurrArray2[i+1][5] = CurrArray2[i+1][5] + temp_a>
                		<cfset CurrArray2[i+1][6] = CurrArray2[i+1][6] + getictran.qty_bil>
              		</cfif>
              		<cfset i = i + 1>
            	</cfloop>
          		</tr>
		  		</cfoutput>
        	</cfloop>
		</cfloop>
	</cfif>
    <!--- Last sub Total --->
    <cfif rgSort eq "Client Name" or rgSort eq "Client Code">
		<tr>
        	<td colspan="4">&nbsp;</td>
        	<td colspan="9"><hr></td>
      	</tr>
	<cfelse>
      	<tr>
        	<td colspan="13"><hr></td>
      	</tr>
    </cfif>

	<cfset maxArray = right(CurrArray[1][1],1)>

	<cfloop index = "i" from = "1" to = "#maxArray#">
      	<cfif CurrArray[i+1][1] eq stLastCurr>
        	<tr>
          		<td valign="top" nowrap>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td colspan="2"><div align="right"><strong>Sub Total</strong></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][6]#</cfoutput></font></div></td>
          		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray[i+1][1]#</cfoutput></font></div></td>
          		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][2],',_.__')#</cfoutput></font></div></td>
          		<!---<cfif CurrArray[i+1][3] neq 0>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][4]/CurrArray[i+1][3],',_.____')#</cfoutput></font></div></td>
            	<cfelse>
            	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][3],',_.____')#</cfoutput></font></div></td>
          		</cfif>--->
		  		<td></td>
          		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray[i+1][5],',_.__')#</cfoutput></font></div></td>
          		<!---<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          		<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          		<td>&nbsp;</td> --->
        	</tr>
      	</cfif>
      	<cfset i = i + 1>
	</cfloop>
    <tr>
      	<td colspan="13"><hr></td>
    </tr>
    <cfif rgSort eq "Client Name" or rgSort eq "Client Code">
      	<!--- Print Grand Total --->
      	<cfset maxArray = right(CurrArray1[1][1],1)>
      	<cfset DisplayTotal = 0>

	  	<cfloop index = "i" from = "1" to = "#maxArray#">
        	<cfif CurrArray1[i+1][2] neq 0 or CurrArray1[i+1][1] eq "SGD">
          		<tr>
            		<td valign="top" nowrap>&nbsp;</td>
            		<td>&nbsp;</td>
            		<td>&nbsp;</td>
            		<td>&nbsp;</td>
            		<cfif DisplayTotal eq 0>
              			<td colspan="2"><div align="right"><strong>Grand Total</strong></div></td>
              			<cfset DisplayTotal = 1>
              		<cfelse>
              			<td>&nbsp;</td>
              			<td>&nbsp;</td>
            		</cfif>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][6]#</cfoutput></font></div></td>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray1[i+1][1]#</cfoutput></font></div></td>
            		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][2],',_.__')#</cfoutput></font></div></td>
            		<!---<cfif CurrArray1[i+1][3] neq 0>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][4]/CurrArray1[i+1][3],',_.____')#</cfoutput></font></div></td>
              		<cfelse>
              		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][3],',_.____')#</cfoutput></font></div></td>
            		</cfif>--->
					<td></td>
            		<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray1[i+1][5],',_.__')#</cfoutput></font></div></td>
            		<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
            		<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
            		<td>&nbsp;</td>
         	 	</tr>
        	</cfif>
        	<cfset i = i + 1>
      	</cfloop>
      	<tr>
        	<td colspan="13"><hr></td>
      	</tr>
    </cfif>
    <!--- Print Grand Total (FC) --->
    <cfset maxArray = right(CurrArray2[1][1],1)>
    <cfset DisplayTotal = 0>

    <cfloop index = "i" from = "1" to = "#maxArray#">
      	<cfif CurrArray2[i+1][2] neq 0 or CurrArray2[i+1][1] eq "SGD">
        	<tr>
          		<td valign="top" nowrap>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
          		<td>&nbsp;</td>
          		<cfif DisplayTotal eq 0>
            		<td colspan="2"><div align="right"><strong>Grand Total (FC)</strong></div></td>
            		<cfset DisplayTotal = 1>
            	<cfelse>
            		<td>&nbsp;</td>
            		<td>&nbsp;</td>
          		</cfif>
          			<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][6]#</cfoutput></font></div></td>
          			<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#CurrArray2[i+1][1]#</cfoutput></font></div></td>
          			<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][2],',_.__')#</cfoutput></font></div></td>
          			<!---<cfif CurrArray2[i+1][3] neq 0>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][4]/CurrArray2[i+1][3],',_.____')#</cfoutput></font></div></td>
            		<cfelse>
            		<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][3],',_.____')#</cfoutput></font></div></td>
          			</cfif>--->
		  			<td></td>
          			<td colspan="2"><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfoutput>#numberformat(CurrArray2[i+1][5],',_.__')#</cfoutput></font></div></td>
          			<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          			<td><div align="right"><font size="1"><font face="Times New Roman, Times, serif"></font></font></div></td>
          			<td>&nbsp;</td>
          			<cfset SGDEquiTotal = SGDEquiTotal + CurrArray2[i+1][5]>
        	</tr>
      	</cfif>
      	<cfset i = i + 1>
    </cfloop>
    <tr>
      	<td colspan="13"><hr></td>
    </tr>
    <tr>
      	<td valign="top" nowrap>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="3"><div align="right"><strong>SGD Equivalent Total</strong></div></td>
      	<td>&nbsp;</td>
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
</body>
</html>