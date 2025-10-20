<html>
<head>
<title>Stock Card Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
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
<cfparam name="totalPO" default="0">
<cfparam name="totalSO" default="0">
<cfparam name="totalAll" default="0">

<!--- <cfif Email eq "Email">
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
</cfif> --->
<cfparam name="i" default="1" type="numeric">
<!--- <cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">  --->
<cfparam name="balonhand" default="0">
<!--- <cfparam name="POqty" default="0">
<cfparam name="SOqty" default="0"> --->
<cfparam name="TotalAll" default="0">

<cfif isdefined("df") and isdefined("form.dateto")>
	<cfset dd=dateformat(df, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(df,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(df,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(form.dateto, "DD")>
	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select a.itemno, a.desp, a.qtybf,a.price, a.unit from icitem a, ictran b where
	(type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS' or type = 'PR' or type = 'RC'
	or type = 'DO' or type = 'ISS' or type = 'TRIN' or type = 'TROU' or type = 'OAI' or type = 'OAR')
	and a.itemno=b.itemno and (b.void = '' or b.void is null)
	<cfif pf neq "" and pt neq "">
	and a.itemno >= '#pf#' and a.itemno <= '#pt#'
	</cfif>
	<cfif cf neq "" and ct neq "">
	and a.category >= '#cf#' and a.category <= '#ct#'
	</cfif>
	<cfif sif neq "" and sit neq "">
	and a.sizeid >= '#sif#' and a.sizeid <= '#sit#'
	</cfif>
	<cfif ccf neq "" and cct neq "">
	and a.costcode >= '#ccf#' and a.costcode <= '#cct#'
	</cfif>
	<cfif cif neq "" and cit neq "">
	and a.colorid >= '#cif#' and a.colorid <= '#cit#'
	</cfif>
	<cfif sff neq "" and sft neq "">
	and a.shelf >= '#sff#' and a.shelf <= '#sft#'
	</cfif>
	<cfif gpf neq "" and gpt neq "">
	and a.wos_group >= '#gpf#' and a.wos_group <= '#gpt#'
	</cfif>
	<cfif pef neq "" and pet neq "">
	and b.fperiod >= '#pef#' and b.fperiod <= '#pet#'
	</cfif>
	<cfif df neq "" and dt neq "">
	and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
	<cfelse>
	and b.wos_date > #getgeneral.lastaccyear#
	</cfif>
	group by b.itemno order by b.itemno
</cfquery>

<cfif df neq "" and dt neq "">
	<cfset dd=dateformat(df, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(df,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(df,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(dt, "DD")>
	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(dt,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(dt,"YYYYDDMM")>
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
<cfif getitem.recordcount eq 0>
	<cfoutput><h4><font color="##FF0000">No Report Generated.</font></h4></cfoutput>
	<cfabort>
</cfif>
<!--- 	<cfif getartran.refno eq "">
		<cfoutput><h4><font color="##FF0000">No Report Generated.</font></h4></cfoutput>
		<cfabort>
	</cfif> --->
	<table width="100%" border="0" cellspacing="1" cellpadding="0">
		<tr>
			<td colspan="2"><div align="center">
          	<p><font size="4" face="Times New Roman, Times, serif"><strong>MSD ENGINEERING PTE LTD</strong></font><br>
            <font size="4" face="Times New Roman, Times, serif"><strong>STOCK CARD</strong></font> </p></div>
			</td>
		</tr>
		<tr>
	    	<td width="72%">
				<font size="1" face="Times New Roman, Times, serif"><cfoutput>
					<cfif df neq "">
						#df# - #dt#
					</cfif>
				</cfoutput></font></td>
			<td width="28%"><div align="right"><font size="1" face="Times New Roman, Times, serif">Date
				: <cfoutput>#dateformat(now(),'DD-MM-YYYY')#</cfoutput></font></div></td>
		</tr>
<!---     	<tr>
      		<td colspan="13"><hr></td>
    	</tr> --->
	</table>


  <table width="100%" border="0" cellspacing="1" cellpadding="0">
    <cfloop query="getitem">
      	<cfset lastitembal = 0>
      	<cfset itembal = 0>
      	<cfset inqty = 0>
      	<cfset outqty = 0>
      	<cfset doqty = 0>
      	<cfset totalso = 0>
      	<cfset totalpo = 0>
	  	<cfset poqty = 0>
	  	<cfset soqty = 0>

	  	<cfif pef neq "" and pet neq "" and pef neq "01">
        	<cfset lastinqty = 0>
        	<cfset lastoutqty = 0>
        	<cfset lastdoqty = 0>

			<cfquery name="getlastin" datasource="#dts#">
        		select sum(qty)as sumqty from ictran where itemno = '#itemno#' and (type
        		= 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') and (void = '' or void is null)
        		and fperiod < '#form.periodfrom#'
        		<cfif form.datefrom neq "" and form.dateto neq "">
          		and wos_date < '#ndatefrom#'
        		</cfif>
        	</cfquery>

			<cfif getlastin.sumqty neq "">
          		<cfset lastinqty = getlastin.sumqty>
        	</cfif>

			<cfquery name="getlastout" datasource="#dts#">
        		select sum(qty)as sumqty from ictran where itemno = '#itemno#' and (type
        		= 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or
        		type = 'OAR' or type = 'TROU') and (void = '' or void is null) and fperiod < '#form.periodfrom#'
        		<cfif form.datefrom neq "" and form.dateto neq "">
          		and wos_date < '#ndatefrom#'
        		</cfif>
        	</cfquery>

			<cfif getlastout.sumqty neq "">
          		<cfset lastoutqty = getlastout.sumqty>
        	</cfif>

        	<cfquery name="getlastdo" datasource="#dts#">
        		select sum(qty)as sumqty from ictran where type = 'DO' and itemno = '#itemno#'
        		and toinv = '' and (void = '' or void is null) and fperiod < '#form.periodfrom#'
        		<cfif form.datefrom neq "" and form.dateto neq "">
        		and wos_date < '#ndatefrom#'
        		</cfif>
        	</cfquery>

			<cfif getlastdo.sumqty neq "">
          		<cfset lastDOqty = getlastdo.sumqty>
        	</cfif>

			<cfset lastitembal = lastinqty - lastoutqty - lastdoqty>
      	</cfif>

	  	<cfif getitem.qtybf neq "">
        	<cfset itembal = getitem.qtybf + lastitembal>
        <cfelse>
        	<cfset itembal = lastitembal>
     	</cfif>

	  	<cfoutput>
      	<tr>
        	<td colspan="2" nowrap><strong>#i#. #itemno#</strong></td>
        	<td colspan="10"><strong>#desp#</strong></td>
      	</tr>
	  	</cfoutput>
      	<tr>
        	<td colspan="12"><hr></td>
      	</tr>
      	<tr>
        	<td width="8%" nowrap><div align="left"><font size="1" face="Times New Roman, Times, serif">Date</font></div></td>
        	<td width="10%"><div align="left"><font size="1" face="Times New Roman, Times, serif">Ref.</font></div></td>
        	<td width="18%"><div align="left"><font size="1" face="Times New Roman, Times, serif">Description</font></div></td>
        	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif">In</font></div></td>
        	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif">Out</font></div></td>
        	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif">Balance</font></div></td>
        	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif">PO</font></div></td>
        	<td width="6%"><div align="right"><font size="1" face="Times New Roman, Times, serif">SO</font></div></td>
        	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif">Total</font></div></td>
        	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif">Cost P.</font></div></td>
        	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif">Sell P.</font></div></td>
        	<td width="8%"><div align="right"><font size="1" face="Times New Roman, Times, serif">Amount</font></div></td>
     	 </tr>
      <tr>
        	<td colspan="12"><hr></td>
      </tr>
      <cfset totalAll = itembal>
      <cfoutput>
	  <tr>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Balance B/F</font></div></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#itembal#</font></div></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#totalAll#</font></div></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
      </tr>
	  </cfoutput>

		<cfquery name="getpo" datasource="#dts#">
			select sum(qty-shipped)as qty from ictran where
			itemno = '#itemno#' and (void = '' or void is null) and type = 'PO'
		</cfquery>

		<cfif getpo.qty neq "">
			<cfset poqty = getpo.qty>
		</cfif>

		<cfquery name="getso" datasource="#dts#">
			select sum(qty-shipped)as qty from ictran where
			itemno = '#itemno#' and (void = '' or void is null) and type = 'SO'
		</cfquery>

		<cfif getso.qty neq "">
			<cfset soqty = getso.qty>
		</cfif>

		<cfoutput>
        <tr>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
         	 <td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#poqty#</font></div></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#soqty#</font></div></td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
        </tr>
		</cfoutput>

		<cfquery name="getictran" datasource="#dts#">
		  	select a.itemno, a.desp, a.qtybf, b.refno, b.itemno, b.type, b.dono, b.wos_date,
		  	b.name, b.qty, b.toinv, b.price, b.amt from icitem a, ictran b where a.itemno=b.itemno
		  	and a.itemno = '#getitem.itemno#' and (type = 'INV' or type = 'CN' or type
		  	= 'DN' or type = 'CS' or type = 'PR' or type = 'RC' or type = 'DO' or type
		  	= 'ISS' or type = 'OAI' or type = 'OAR' or type = 'TRIN' or type = 'TROU')
		  	and (b.void = '' or b.void is null)
		  	<cfif pef neq "" and pet neq "">
			and b.fperiod >= '#pef#' and b.fperiod <= '#pet#'
		  	</cfif>
		  	<cfif df neq "" and dt neq "">
			and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
		  	</cfif>
		  	order by b.wos_date, b.trdatetime
      </cfquery>

		<cfloop query="getictran">
		<cfoutput>
        <tr>
          	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
          	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#type# #refno#</font></div></td>
          	<td><font size="1" face="Times New Roman, Times, serif">#name#</font></td>
          	<td>
            <cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN">
              	<cfset itembal = itembal + qty>
              	<cfset totalin = totalin + qty>
              	<cfset TotalAll = TotalAll + qty>
              	<div align="right"><font size="1" face="Times New Roman, Times, serif">#qty#</font></div>
            </cfif> </td>
          	<td>
			<cfif type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU">
            	<cfif type eq "DO" and toinv neq "">
                <div align="right"><font size="1" face="Times New Roman, Times, serif">INV #toinv#</font></div>
                <cfelse>
                	<cfset itembal = itembal - qty>
                	<cfset totalout = totalout + qty>
               	 	<cfset TotalAll = TotalAll - qty>
                	<div align="right"><font size="1" face="Times New Roman, Times, serif">#qty#</font></div>
              	</cfif>
            </cfif> </td>
          	<td>
		  		<cfif type eq "DO" and toinv neq "">
              	<cfelse>
              	<div align="right"><font size="1" face="Times New Roman, Times, serif">#itembal#</font></div>
            	</cfif>
			</td>
          	<td> <!--- <cfif type eq "PO">
              <cfset totalAll = #totalAll# + #qty#>
              <cfset totalPO = #totalPO# + #qty#>
              <div align="right"><font size="1" face="Times New Roman, Times, serif">#qty#</font></div>
            </cfif>  ---></td>
          	<td> <!--- <cfif type eq "SO">
              <cfset totalAll = #totalAll# - #qty#>
              <cfset totalSO = #totalSO# + #qty#>
              <div align="right"><font size="1" face="Times New Roman, Times, serif">#qty#</font></div>
            </cfif>  ---></td>
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif"><!--- #totalAll# ---></font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfif type eq "RC" or type eq "CN" or type eq "PO" or type eq "OAI" or type eq "TRIN">#numberformat(price,stDecl_UPrice)#</cfif></font></div></td>
            <!--- <td></td> --->
            <!--- <cfelse>
            <td></td> --->
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif"><cfif type neq "RC" and type neq "CN" and type neq "PO" and type neq "OAI" and type neq "TRIN">#numberformat(price,stDecl_UPrice)#</cfif></font></div></td>
          	<!--- </cfif> --->
          	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(amt,",_.__")#</font></div></td>
        	</tr>
			</cfoutput>
      	</cfloop>
      	<tr>
        	<td colspan="12"><hr></td>
      	</tr>

		<cfset totalAll = itembal + poqty - soqty>

		<cfoutput>
	  	<tr>
        	<td></td>
       	 	<td></td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Total:</font></div></td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#totalin#</font></div></td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#totalout#</font></div></td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#itembal#</font></div></td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#totalPO#</font></div></td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#totalSO#</font></div></td>
        	<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#totalAll#</font></div></td>
        	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
        	<td></td>
        	<td></td>
      	</tr>
	  	</cfoutput>
      	<tr>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
      	</tr>
      	<cfset i = incrementvalue(#i#)>
      	<cfset itembal = 0>
      	<cfset totalin = 0>
      	<cfset totalout = 0>
	</cfloop>
</table>
<br>
<hr>
<div align="right">
<cfif husergrpid eq "Muser">
	<a href="../home2.cfm" class="noprint"><u><font size="1" face="Arial, Helvetica, sans-serif">Home</font></u></a>
</cfif>
<font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
<!---<input type="submit" name="Email" value="Email" class="noprint"> --->
</div>
</cfform>
</body>
</html>