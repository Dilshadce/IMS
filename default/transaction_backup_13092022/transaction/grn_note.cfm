<cfif #tran# eq "rc">
	<cfset tran = "rc">
	<cfset tranname = "Purchase Receive">
	<cfset trancode = "rcno">
	<cfset prefix = "rccode">
</cfif>
<cfif #tran# eq "DO">
	<cfset tran = "DO">
	<cfset tranname = "Delivery Order">
	<cfset trancode = "dono">
	<cfset prefix = "docode">
</cfif>
<cfif #tran# eq "INV">
	<cfset tran = "INV">
	<cfset tranname = "Invoice">
	<cfset trancode = "invno">
	<cfset prefix = "invcode">
</cfif>
<cfif #tran# eq "CS">
	<cfset tran = "CS">
	<cfset tranname = "Cash Sales">
	<cfset trancode = "invno">
	<cfset prefix = "cscode">
</cfif>
<cfif #tran# eq "QUO">
	<cfset tran = "QUO">
	<cfset tranname = "Quotation">
	<cfset trancode = "quono">
	<cfset prefix = "quocode">
</cfif>
<cfif #tran# eq "PO">
	<cfset tran = "PO">
	<cfset tranname = "Purchase Order">
	<cfset trancode = "pono">
	<cfset prefix = "pocode">
</cfif>
<cfif #tran# eq "SO">
	<cfset tran = "SO">
	<cfset tranname = "Sales Order">
	<cfset trancode = "sono">
	<cfset prefix = "socode">
</cfif>
<cfif #tran# eq "CN">
	<cfset tran = "CN">
	<cfset tranname = "Credit Note">
	<cfset trancode = "cnno">
	<cfset prefix = "cncode">
</cfif>
<cfif #tran# eq "DN">
	<cfset tran = "DN">
	<cfset tranname = "Dedit Note">
	<cfset trancode = "dnno">
	<cfset prefix = "dncode">
</cfif>
<cfif #tran# eq "PR">
	<cfset tran = "PR">
	<cfset tranname = "Purchase Return">
	<cfset trancode = "prno">
	<cfset prefix = "prcode">
</cfif>

<!--- <cfparam name="pagecnt" default="1"> --->
<html>
<head>
<title></title>
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
<!--- <cfparam name="Submit" default=""> --->
<cfparam name="Email" default="">

<cfquery datasource='#dts#' name="getHeaderInfo">
	select * from artran where refno ='#nexttranno#' and type = '#tran#'
</cfquery>
<cfquery name="getgeneral" datasource="#dts#">
	select #prefix# as prefix, compro, compro2, compro3, compro4, compro5, compro6, compro7 from gsetup
</cfquery>

<cfif Email eq "Email">
		<cfquery name="getemail" datasource="#dts#">
			select e_mail from customer where customerno = '#getheaderinfo.custno#'
		</cfquery>
		<cfif getemail.e_mail eq "">
		<cfoutput>
			<h4><font color="##FF0000">Please add in email address for customer - #getheaderinfo.custno#.</font></h4></cfoutput>
			<cfabort>
		<cfelse>
			<cflocation url="grn_note_email.cfm?nexttranno=#nexttranno#&tran=#tran#&custemail=#getemail.e_mail#&tranname=#tranname#&prefix=#getgeneral.prefix#">
		</cfif>

</cfif>

<cfquery datasource="#dts#" name="getBodyInfo">
	select * from ictran where refno = '#nexttranno#' and type = '#tran#' order by itemcount
</cfquery>

<cfif tran eq 'PR' or tran eq 'PO' or tran eq 'RC'>
	<cfquery datasource='#dts#' name="getCurrCode">
   	 	select name,name2,add1,add2,add3,add4,attn,phone,fax,currcode from supplier where customerno = '#getheaderInfo.custno#'
	</cfquery>
<cfelse>
	<cfquery datasource='#dts#' name="getCurrCode">
   	 	select name,name2,add1,add2,add3,add4,attn,phone,fax,currcode from customer where customerno = '#getheaderInfo.custno#'
	</cfquery>
</cfif>
<cfif getHeaderInfo.rem0 eq "Profile">
  <cfif tran eq 'PR' or tran eq 'PO' or tran eq 'RC'>
	<cfquery datasource='#dts#' name="getBillToAdd">
   	  select name,name2,add1,add2,add3,add4,attn,phone,fax from supplier where customerno = '#getheaderInfo.custno#'
	</cfquery>
  <cfelse>
	<cfquery datasource='#dts#' name="getBillToAdd">
   	  select name,name2,add1,add2,add3,add4,attn,phone,fax from customer where customerno = '#getheaderInfo.custno#'
	</cfquery>
  </cfif>
<cfelse>
  <cfquery datasource='#dts#' name="getBillToAdd">
    select name,name2,add1,add2,add3,add4, attn, phone, fax from address where code = '#getheaderInfo.rem0#'
  </cfquery>
</cfif>
<!--- <cfquery name="getagent" datasource="#dts#">
      select * from icagent where agent = '#getheaderinfo.agenno#'
</cfquery> --->

<!--- Control The Decimal Point --->
<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = #getgsetup2.Decl_Uprice#>
<cfset stDecl_UPrice = ".">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = #stDecl_UPrice# & "_">
</cfloop>

<cfset iDecl_Discount = #getgsetup2.Decl_Discount#>
<cfset stDecl_Discount = ".">
<cfloop index="LoopCount" from="1" to="#iDecl_Discount#">
  <cfset stDecl_Discount = #stDecl_Discount# & "_">
</cfloop>

<body>
<cfform name="form1" action="">
<!--- 	<cftable query = "getHeaderInfo"
   startRow = "1" colSpacing = "3" HTMLTable>
	<cfcol header = "<b>ID</b>"
      align = "Left"
      width = 2
      text  = "Emp_ID">
	</cftable> --->


  <table width="100%" border="0" cellspacing="0" cellpadding="4">
  <cfoutput query="getgeneral">
    <tr>
		<td colspan="5"><div align="center"><font size="4" face="Times New Roman, Times, serif"><strong><cfif getgeneral.compro neq ''>#compro# <br></cfif></strong></font>
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
	      <td colspan="5"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
    	</tr>

		<tr>
			<td width="55%"><font face="Times New Roman, Times, serif"><strong><font size="2"><cfoutput>#getBillToAdd.name# #getBillToAdd.name2#</cfoutput></font></strong></font></td>
			<td width="2%"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td colspan="3" nowrap><font size="2" face="Times New Roman, Times, serif"><strong>RECEIVE</strong></font></td>
    	</tr>

		<tr>
      		<td><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#getBillToAdd.add1#</cfoutput></font></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td colspan="3"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
    	</tr>

		<tr>
    	  	<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getBillToAdd.add2# </cfoutput></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
		    <td width="8%"><font size="2" face="Times New Roman, Times, serif">NO.</font></td>
      		<td width="1%"><font size="2" face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="2">&nbsp;</font></td>
      		<td width="34%"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getgeneral.prefix##getheaderInfo.refno#</cfoutput></font></td>
    	</tr>

		<tr>
      		<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getBillToAdd.add3#</cfoutput></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">PO NO.</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>

			<cfset aPONO = "">
			<cfif #getHeaderInfo.pono# neq "">
				<cfset i = 1>
				<cfset str = "">
				<cfset laststr = "">
 				<cfset maxlen = len(#getHeaderInfo.pono#)>

  				<cfloop index = "i" from = "1" to = "#maxlen#">
					<cfif mid(#getHeaderInfo.pono#,i,1) neq ",">
						<cfset str = #str# & mid(#getHeaderInfo.pono#,i,1) >
					<cfelse>
						<cfquery name="getPONO" datasource="#dts#">
							select * from artran where refno ='#str#' and type = 'PO'
						</cfquery>

						<cfif #getPONO.refno# eq #str#>
							<cfif #laststr# neq #str#>
								<cfif aPONO eq "">
									<cfset aPONO = #str#>
								<cfelse>
									<cfset aPONO = #aPONO# & "," & #str#>
								</cfif>
							</cfif>
							<cfset laststr = #str#>
						</cfif>
						<cfset str = "">
					</cfif>
				</cfloop>
				<td><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#aPONO#</cfoutput></font></font></td>
			</cfif>
    	</tr>

		<tr>
      		<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getBillToAdd.add4#</cfoutput></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>

      <td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#dateformat(getHeaderInfo.wos_date,"dd/mm/yyyy")#</cfoutput></font></font></td>
    	</tr>

		<tr>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">SO NO.</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>

<!--- 			<cfset str = "">
			<cfset laststr = "">

			<cfquery name="getSONO" datasource="#dts#">
				select SONO from ictran where refno ='#tran#' and type = 'RC'
			</cfquery>

			<cfloop query="getSONO">
				<cfset str = #getSONO.SONO#>
					<cfif #laststr# neq #str#>
						<cfif aSONO eq "">
							<cfset aSONO = #str#>
						<cfelse>
							<cfset aSONO = #aSONO# & "," & #str#>
						</cfif>
					</cfif>
					<cfset laststr = #str#>
			</cfloop> --->
<!--- 			<cfloop index = "i" from = "1" to = "#maxlen#">
				<cfif mid(#getHeaderInfo.pono#,i,1) neq ",">
					<cfset str = #str# & mid(#getHeaderInfo.pono#,i,1) >
					<cfelse>
						<cfquery name="getPONO" datasource="#dts#">
							select * from artran where refno ='#str#' and type = 'PO'
						</cfquery>

						<cfif #getPONO.refno# eq #str#>
							<cfif #laststr# neq #str#>
								<cfif aPONO eq "">
									<cfset aPONO = #str#>
								<cfelse>
									<cfset aPONO = #aPONO# & "," & #str#>
								</cfif>
							</cfif>
							<cfset laststr = #str#>
						</cfif>
						<cfset str = "">
					</cfif>
				</cfloop> --->

			<cfset aSONO = "">
			<cfset str = "">
<!--- 			<cfset maxlen = len(#aPONO#)> --->
			<cfloop index = "i" from = "1" to = "#len(aPONO)#">
				<cfif mid(#aPONO#,i,1) eq ",">
					<cfquery name="getSONO" datasource="#dts#">
						select SONO from ictran where refno ='#str#' and type = 'PO'
					</cfquery>
<!--- 					<cfloop cfquery = "getSONO">

					</cfloop> --->

					<cfif getSONO.SONO neq "" and aSONO neq "SONO">
						<cfif aSONO eq "">
							<cfset aSONO = #getSONO.SONO#>
						<cfelse>
							<cfset aSONO = #aSONO# & "," & #getSONO.SONO#>
						</cfif>
					</cfif>
					<cfset str = "">
				<cfelse>
					<cfset str = #str# & mid(#aPONO#,i,1)>
				</cfif>
			</cfloop>

			<cfquery name="getSONO" datasource="#dts#">
				select SONO from ictran where refno ='#str#' and type = 'PO'
			</cfquery>

			<cfif getSONO.SONO neq "">
				<cfif aSONO eq "">
					<cfset aSONO = #getSONO.SONO#>
				<cfelse>
					<cfset aSONO = #aSONO# & "," & #getSONO.SONO#>
				</cfif>
			</cfif>

      		<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#aSONO#</cfoutput></font></font></td>
    	</tr>

		<tr>
      		<td><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#getBillToAdd.attn#</cfoutput></strong></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font face="Times New Roman, Times, serif"><font size="2">TERM</font></font></td>
      		<td><font face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getHeaderInfo.term#</cfoutput></font>
			</td>
    	</tr>

		<tr>
      		<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getBillToAdd.phone#</cfoutput></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
    	</tr>

    	<tr>
      		<td><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#getBillToAdd.fax#</cfoutput></font></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
    	</tr>

		<tr>
      		<td nowrap><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#getHeaderInfo.custno#</cfoutput></font></font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>

      <td><font size="2" face="Times New Roman, Times, serif">PAGE</font></td>
      		<td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>

			<cfif isdefined("form.skeypage")>
			  <td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#form.skeypage#</cfoutput></font></td>
			</cfif>
    	</tr>

	    <tr>
      		<td colspan="12"><hr></td>
    	</tr>
  </table>

  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td>&nbsp;</td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td colspan="3" nowrap> <div align="center"><font size="2" face="Times New Roman, Times, serif"><strong>FOREIGN
          CURRENCY</strong></font></div></td>
      <td colspan="2"><div align="center"><strong><font size="2" face="Times New Roman, Times, serif">SGD
          EQUIALENT</font></strong></div></td>
    </tr>
    <tr>
      <td width="4%" nowrap><div align="left"></div></td>
      <td width="10%" nowrap> <div align="left"><strong><font size="2" face="Times New Roman, Times, serif">ITEM
          NO. </font></strong></div></td>
      <td width="15%"><div align="left"><strong><font size="2" face="Times New Roman, Times, serif">ITEM
          DESCRIPTION</font></strong></div></td>
      <td width="8%"><div align="right"><strong><font size="2" face="Times New Roman, Times, serif">QTY</font></strong></div></td>
      <td width="8%"><div align="center"><strong><font face="Times New Roman, Times, serif"><font size="2"></font></font></strong></div></td>
      <td width="10%" nowrap> <div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>UNIT
          PRICE</strong></font></div></td>
      <td width="10%"> <div align="right"><strong><font size="2" face="Times New Roman, Times, serif">TOTAL
          PRICE</font></strong></div></td>
      <td width="9%"> <div align="right"><strong><font size="2" face="Times New Roman, Times, serif">EXCH
          RATE</font></strong></div></td>
      <td width="13%"><div align="right"><strong><font size="2" face="Times New Roman, Times, serif">UNIT
          PRICE</font></strong></div></td>
      <td width="13%"><div align="right"><strong><font size="2" face="Times New Roman, Times, serif">TOTAL
          PRICE </font></strong></div></td>
    </tr>
    <tr>
      <td colspan="12"><hr align="left"></td>
    </tr>
    <tr>
      <td valign="top" nowrap>&nbsp;</td>
      <td valign="top" nowrap>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#getCurrCode.currcode#</cfoutput></font></font></div></td>
      <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#getCurrCode.currcode#</cfoutput></font></font></div></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <!--- <cfset cnt = 19> --->
    <cfset totalamt = 0>
    <cfset totalqty = 0>
    <cfset disamt_bil = 0>
    <!--- <cfset taxtotal =0> --->
    <cfset row = 0>
    <cfoutput query="getBodyInfo">
      <cfset xamt_bil = 0>
      <cfset xqty = 0>
      <!---  startrow="1" maxrows="20" --->
      <cfquery name="getserial" datasource="#dts#">
      select * from iserial where refno = '#nexttranno#' and type = '#getbodyinfo.type#'
      and itemno = '#getbodyinfo.itemno#' and trancode = '#getbodyinfo.itemcount#'
      </cfquery>
      <cfquery name="getUOM" datasource='#dts#'>
      select unit from icitem where itemno ='#getBodyInfo.itemno#'
      </cfquery>
      <cfset row = #row# +1>
      <tr>
        <td valign="top" nowrap><div align="left"><font face="Times New Roman, Times, serif"><font size="2">#row#</font></font></div></td>
        <td valign="top" nowrap>
          <div align="left"><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.itemno#</font></font></div></td>
        <td><div align="left"><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.desp# #getBodyInfo.despa#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.qty#</font></font></div></td>
        <td><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#getUOM.unit#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.price_bil,stDecl_UPrice)#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.amt_bil,".__")#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.currrate,".__")#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.price_bil * getBodyInfo.currrate,stDecl_UPrice)#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.amt_bil * getBodyInfo.currrate,".__")#</font></font></div></td>
        <!--- <cfif getbodyinfo.recordcount lte 19>
          <cfset cnt = #cnt# - 1>
        </cfif> --->
        <cfif getbodyinfo.amt_bil neq "">
          <cfset xamt_bil = #getBodyInfo.amt_bil#>
        </cfif>
        <cfif getBodyInfo.qty neq "">
          <cfset xqty = #getBodyInfo.qty#>
        </cfif>
        <cfset totalamt = #totalamt# + #xamt_bil#>
        <cfset totalqty = #totalqty# + #xqty#>
      </tr>
    </cfoutput>
    <tr>
      <td colspan="12"><hr></td>
    </tr>
    <!--- 222 		  </table> --->
    <cfset xdisp1 = 0>
    <cfset xtaxp1 = 0>
    <cfif getheaderinfo.taxp1 neq "">
      <cfset xtaxp1 = #getheaderinfo.taxp1#>
    </cfif>
    <cfif getheaderinfo.disp1 neq "">
      <cfset xdisp1 = #getheaderinfo.disp1#>
      <!--- <cfset disamt = #totalamt# * (#xdisp1#/100)> --->
    </cfif>
    <cfif getheaderinfo.disc1_bil neq "">
      <cfset disamt_bil = #getheaderinfo.disc1_bil#>
      <cfelse>
      <cfset disamt_bil  = 0>
    </cfif>
    <cfset net_bil = #totalamt# - #disamt_bil#>
    <cfset taxamt_bil = #net_bil# * (#xtaxp1#/100)>
    <cfset gross_bil = #net_bil# + #taxamt_bil#>
    <!---   <table width="100%" border="0" cellpadding="4" cellspacing="0"> 222 --->
    <tr>
      <td height="17">&nbsp;</td>
      <td height="17">&nbsp;</td>
      <!---           <td>
           <td width="12%"><font size="2" face="Times New Roman, Times, serif">&nbsp;<cfoutput>#numberformat(totalqty,'____.__')#</cfoutput></font></td>
          <td width="9%">&nbsp;</td> --->
      <td width="15%"><div align="right"><font size="2" face="Times New Roman, Times, serif">Total
          Quantity</font></div></td>
      <td width="8%"><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;<cfoutput>#numberformat(totalqty,'____')#</cfoutput></font></div></td>
      <td width="8%">&nbsp;</td>
      <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
      <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;<cfoutput>#numberformat(totalamt,'____.__')#</cfoutput></font></div></td>
      <td></td>
      <td></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(totalamt * getBodyInfo.currrate,'____.__')#</cfoutput></font></div></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">DISCOUNT</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font><font size="2"><font face="Times New Roman, Times, serif"><cfoutput>#numberformat(disamt_bil,stDecl_Discount)#</cfoutput></font></font></div></td>
      <td></td>
      <td></td>
      <td><div align="right"><font size="2"><font face="Times New Roman, Times, serif"><cfoutput>#numberformat(disamt_bil * getBodyInfo.currrate,'.__')#</cfoutput></font></font></div></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">NET</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;<cfoutput>#numberformat(net_bil,'____.__')#</cfoutput></font></div></td>
      <td></td>
      <td></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(net_bil * getBodyInfo.currrate,'____.__')#</cfoutput></font></div></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TAX</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;<cfoutput>#numberformat(taxamt_bil,'.__')#</cfoutput></font></div></td>
      <td></td>
      <td></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(taxamt_bil * getBodyInfo.currrate,'.__')#</cfoutput></font></div></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">GRAND</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">&nbsp;<cfoutput>#numberformat(gross_bil,'____.__')#</cfoutput></font></div></td>
      <td></td>
      <td></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(gross_bil * getBodyInfo.currrate,'____.__')#</cfoutput></font></div></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>&nbsp;</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <!--- 111    <tr>
      <td>

        <br>
        <font face="Times New Roman" size="2">Cheques should be crossed and
        made payable to <strong>UBS Business Solutions Pte Ltd</strong></font>
        <br>
        <br>
        <br>
        <br>
        </td>

      <td width="32%">
	  <table width="100%" border="0" align="right" bordercolor="#000000" cellspacing="0" cellpadding="3">
          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">TOTAL</font></font></td>
            <td width="30%" nowrap>
              <div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(totalamt,'____.__')#</cfoutput></font></div></td>
          </tr>

          <tr>
            <td nowrap><font face="Times New Roman, Times, serif"><font size="2">DISCOUNT
              <cfif getheaderinfo.disp1 neq 0 and getheaderinfo.disp1 neq ""><cfoutput>#numberformat(xdisp1,'____._')#</cfoutput>(%) </cfif></font></font></td>
            <td nowrap><font size="2">
              <div align="right"><font face="Times New Roman, Times, serif"><cfoutput>#numberformat(disamt_bil,'.__')#</cfoutput></font></div>
              </font></td>
          </tr>
          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">NET</font></font></td>
            <td nowrap>
<div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(net_bil,'____.__')#</cfoutput></font></div></td>
          </tr>
          <tr>
            <td nowrap><font face="Times New Roman, Times, serif"><font size="2">TAX
              <cfif getheaderinfo.taxp1 neq 0 and getheaderinfo.taxp1 neq ""><cfoutput>#numberformat(xtaxp1,'____._')#</cfoutput>(%)</cfif></font></font></td>
            <td nowrap>
<div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(taxamt_bil,'.__')#</cfoutput></font></div></td>
          </tr>
          <cfset currperiod = "CurrP"&"#getheaderinfo.fperiod#">
		  <cfquery name="getcurrcode" datasource="#dts#">
		  	select currcode from currencyrate where #currperiod# = '#getheaderinfo.currrate#'
		  </cfquery>
          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">GROSS&nbsp;
              <cfoutput>#getcurrcode.currcode#</cfoutput> </font></font></td>
            <td nowrap>
<div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(gross_bil,'____.__')#</cfoutput></font></div></td>
          </tr> 111 --->
  </table>
  </td>
    </tr>
  </table>

  <!--- <cfif Submit neq "Submit"> --->
    <div align="right">
	  <cfif husergrpid eq "Muser">
      <a href="../home2.cfm" class="noprint"><u><font size="2" face="Arial, Helvetica, sans-serif">Home</font></u></a>
    </cfif>
    <font size="2" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
<!---     <input type="submit" name="Email" value="Email" class="noprint">	   --->
      <!--- <input type="submit" name="Submit" value="Submit"> --->
    </div>
  <!--- </cfif> --->
</cfform>
</body>
</html>