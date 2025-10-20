<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>


<noscript>
Javascript has been disabled or not supported in this browser.<br>
Please enable Javascript supported before continue.
</noscript>

<!--- <script language="JavaScript">
function winclose()
{
	parent.close()
}
</script> --->

<cfquery datasource='#dts#' name="getHeaderInfo">
	select * from artran where refno ='#nexttranno#' and type = '#tran#'
</cfquery>

<cfquery datasource="#dts#" name="getBodyInfo">
	select * from ictran where refno = '#nexttranno#' and type = '#tran#'
</cfquery>
<cfif tran eq 'PR' or tran eq 'PO' or tran eq 'RC'>
	<cfquery datasource='#dts#' name="getCustAdd">
   	 	select name,name2,add1,add2,add3,attn,phone,fax,currcode from #target_apvend# where custno = '#getheaderInfo.custno#'
	</cfquery>
<cfelse>
	<cfquery datasource='#dts#' name="getCustAdd">
   	 	select name,name2,add1,add2,add3,attn,phone,fax,currcode from #target_arcust# where custno = '#getheaderInfo.custno#'
	</cfquery>
</cfif>

<cfquery name="getagent" datasource="#dts#">
      select * from #target_icagent# where agent = '#getheaderinfo.agenno#'
</cfquery>
<!--- #custemail# --->
<body>
<cfmail server="#Hserver#" to="#custemail#" cc="#Huseremail#" from="#Huseremail#" subject="#tranname# #prefix##numberformat(nexttranno,"00000000")#" type="html">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td colspan="3"><img src="http://www.nipponconcept.com.sg/jts/netlogo.jpg"></td>
    <td nowrap><font size="4" face="Arial black"><strong>Netiquette Software
      <font size="3" face="Arial, Helvetica, sans-serif">Pte Ltd</font></strong></font><br>
      <font size="2" face="Times New Roman, Times, serif">8, Trengganu Street, #03-00, Singapore 058460</font><br>
	  <font size="2" face="Times New Roman, Times, serif">Tel: +65 62231157   Fax: +65 6823 1076<br/>
	  http://www.netiquette.com.sg</font></td>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><font face="Times New Roman, Times, serif"><strong></strong></font></td>
    <td>&nbsp;</td>
    <td colspan="3">_____________________</td>
  </tr>
  <tr>
    <td colspan="4"><font face="Times New Roman, Times, serif"><strong><font size="2">#getCustAdd.name# #getCustAdd.name2#</font></strong></font></td>
    <td colspan="3" nowrap><font size="2" face="Times New Roman, Times, serif">RCB
      Registration No: 200411535M</font></td>
  </tr>
  <tr>
    <td colspan="4"><font face="Times New Roman, Times, serif"><font size="2">#getCustAdd.add1#</font></font>
      </td>
    <td colspan="3"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font></td>
  </tr>
  <tr>
    <td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getCustAdd.add2# #getCustAdd.add3#</font></td>
    <td colspan="3"><font size="3" face="Times New Roman, Times, serif"><strong>#Ucase(tranname)#</strong></font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><font face="Times New Roman, Times, serif">&nbsp;</font></td>
    <td><font face="Times New Roman, Times, serif">&nbsp;</font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2"></font></font></font></td>
  </tr>
  <tr>
    <td><font face="Times New Roman, Times, serif"><font size="2"><strong>ATTN</strong></font></font></td>
    <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
    <td colspan="2"><font face="Times New Roman, Times, serif"><font size="2"><strong>#getCustAdd.attn#</strong></font></font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">NO.</font></font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">:</font></font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">#prefix##numberformat(getheaderInfo.refno,"00000000")#</font></font></td>
  </tr>
  <tr>
    <td><font face="Times New Roman, Times, serif"><font size="2" face="Times New Roman, Times, serif">TEL</font><font size="2"></font></font></td>
    <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
    <td><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="2">#getCustAdd.phone#</font></font></font></font></td>
    <td>&nbsp;</td>
    <td><font face="Times New Roman, Times, serif"><font size="2">DATE</font></font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">:</font></font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">#dateformat(getHeaderInfo.wos_date,"dd/mm/yyyy")#</font></font></td>
  </tr>
  <tr>
    <td><font size="2" face="Times New Roman, Times, serif">FAX</font></td>
    <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">#getCustAdd.fax#</font></font></td>
    <td>&nbsp;</td>
    <td><font face="Times New Roman, Times, serif"><font size="2">TERM</font></font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">:</font></font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2"><cfif getHeaderInfo.term eq 0>COD
	  <cfelseif getHeaderInfo.term eq 7>7 Days<cfelseif getHeaderInfo.term eq 14>14 Days<cfelseif getHeaderInfo.term eq 21>
	  21 Days<cfelseif getHeaderInfo.term eq 30>30 Days
	  </cfif></font></font></td>
  </tr>
  <tr>
    <td nowrap><font face="Times New Roman, Times, serif"><font size="2">A/C NO</font></font></td>
    <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
    <td><font face="Times New Roman, Times, serif"><font size="2">#getHeaderInfo.custno#</font></font></td>
    <td>&nbsp;</td>
    <td><font size="2" face="Times New Roman, Times, serif">AGENT</font></td>
    <td><font face="Times New Roman, Times, serif">:</font></td>
    <td><font size="2" face="Times New Roman, Times, serif">#getagent.agent#</font></td>
  </tr>
</table>

  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td width="10%" nowrap> <div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">ITEM
          </font></strong></font></div></td>
      <td width="60%"><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">DESCRIPTION</font></strong></font></div></td>
      <td width="10%"><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">QTY</font></strong></font></div></td>
      <td width="10%"><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">U.
          PRICE</font></strong></font></div></td>
      <!--- <td width="10%"><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">DIS.</font></strong></font></div></td>
      <td width="10%"><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">TAX</font></strong></font></div></td> --->
      <td width="10%"><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">AMOUNT</font></strong></font></div></td>
    </tr>
    <tr>
      <td colspan="7"><hr></td>
    </tr>
    <!--- <cfset cnt = 19> --->
    <cfset totalamt = 0>
    <cfset totalqty = 0>
    <cfset disamt_bil = 0>
    <!--- <cfset taxtotal =0> --->
    <cfset row = 0>
    <cfloop query="getBodyInfo">
      <!---  startrow="1" maxrows="20" --->
      <cfquery name="getserial" datasource="#dts#">
      select * from iserial where refno = '#nexttranno#' and type = '#getbodyinfo.type#'
      and itemno = '#getbodyinfo.itemno#' and trancode = '#getbodyinfo.itemcount#'
      </cfquery>
      <cfset row = #row# +1>
      <tr>
        <td valign="top" nowrap>
          <div align="center"><font face="Times New Roman, Times, serif"><font size="2">#row#
            <!--- #getBodyInfo.itemno# --->
            </font></font></div></td>
        <td><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.desp# #getBodyInfo.despa#</font></font></td>
        <td><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.qty#</font></font></div></td>
        <td><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.price,".__")#</font></font></div></td>
        <!---  <td><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.disamt,".__")#</font></font></div></td>
        <td><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.taxamt,".__")#</font></font></div></td> --->
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.amt,".__")#</font></font></div></td>
        <!--- <cfif getbodyinfo.recordcount lte 19>
          <cfset cnt = #cnt# - 1>
        </cfif> --->
        <cfset totalamt = #totalamt# + #getBodyInfo.amt_bil#>
        <cfset totalqty = #totalqty# + #getBodyInfo.qty#>
        <!--- <cfset discamt = discamt + #getBodyInfo.disamt#> --->
        <!--- <cfset net = #totalamt# - ( #totalamt# * (#discamt#/100))> --->
        <!---  <cfif getBodyInfo.taxamt neq "0">
            <cfset showtax = #getBodyInfo.taxamt#>
            <cfset taxamount = #getBodyInfo.amt# * (#getBodyInfo.taxamt#/100)>
            <cfset taxtotal = #taxtotal# + #taxamount#>
          </cfif> --->
      </tr>
      <cfif getserial.recordcount gt 0>
	  	<cfset myarray = ArrayNew(1)>
		  <cfloop query="getserial">
			<cfsilent>
			#ArrayAppend(myarray, "#serialno#")# <br>
			</cfsilent>
		  </cfloop>
		  <cfset mylist1= Arraytolist(myArray, ', ')>
        <tr>
          <td valign="top">
            <div align="left"></div></td>
          <td><font face="Times New Roman, Times, serif"><font size="2">**S/No
            : #mylist1#</font></font></td>
          <td><div align="center"></div></td>
          <td><div align="center"></div></td>
          <!---  <td><div align="center"></div></td>
          <td><div align="center"></div></td> --->
          <td><div align="right"></div></td>
          <!--- <cfif getbodyinfo.recordcount lte 19>
            <cfset cnt = #cnt# - 1>
          </cfif> --->
        </tr>
      </cfif>
      <cfif tostring(comment) neq "">
        <!--- <cfif getbodyinfo.recordcount lte 19>
          <cfset cnt = #cnt# - 1>
          <cfset lencomment = len(tostring(#comment#))>
          <cfif lencomment gt 272>
            <cfset cnt = #cnt# - 5>
            <cfelseif lencomment gt 204>
            <cfset cnt = #cnt# - 4>
            <cfelseif lencomment gt 136>
            <cfset cnt = #cnt# - 3>
            <cfelseif lencomment gt 68>
            <cfset cnt = #cnt# - 2>
            <cfelseif lencomment lte 68>
            <cfset cnt = #cnt# - 1>
          </cfif>
        </cfif> --->
        <tr>
          <td valign="top"> <div align="left"></div></td>
          <td><font face="Times New Roman, Times, serif"><font size="2">#tostring(comment)#</font></font> <div align="center"></div>
            <div align="center"></div></td>
          <td><div align="center"></div></td>
          <td><div align="center"></div></td>
          <!--- <td><div align="right"></div></td>
          <td><div align="center"></div></td> --->
          <td><div align="right"></div></td>
        </tr>
      </cfif>
    </cfloop>
    <!--- <cfif getbodyinfo.recordcount lte 19>
      <cfloop index="i" from="1" to="#cnt#">
        <tr>
          <td height="17">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <!--- <td>&nbsp;</td>
        <td>&nbsp;</td> --->
          <td>&nbsp;</td>
        </tr>
      </cfloop>
    </cfif> --->
  </table>
  <br>
<hr>
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


<table width="100%" border="0" cellspacing="0" cellpadding="3">

    <tr>
      <td>
        <!--- TOTAL QTY :&nbsp; #totalqty# --->
        <br>
        <font face="Times New Roman, Times, serif" size="2">Cheques should be crossed and
        made payable to <strong>Netiquette Software Pte Ltd</strong></font>
        <br>
        <br>
        <br>
        <br>
        </td>
      <td width="32%">
	  <table width="100%" border="0" align="right" bordercolor="##000000" cellspacing="0">
          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">TOTAL</font></font></td>
            <td width="30%"> <div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalamt,'____.__')#</font></div></td>
          </tr>

          <tr>

          <td nowrap><font face="Times New Roman, Times, serif"><font size="2">DISCOUNT
            <cfif getheaderinfo.disp1 neq 0 and getheaderinfo.disp1 neq "">#numberformat(getheaderinfo.disp1,'____._')#(%)</cfif></font></font></td>
            <td><font size="2">
              <div align="right"><font face="Times New Roman, Times, serif">#numberformat(disamt_bil,'.__')#</font></div>
              </font></td>
          </tr>
          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">NET</font></font></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(net_bil,'____.__')#</font></div></td>
          </tr>
          <tr>
            <td nowrap><font face="Times New Roman, Times, serif"><font size="2">TAX
              <cfif getheaderinfo.taxp1 neq 0 and getheaderinfo.taxp1 neq "">#numberformat(getheaderinfo.taxp1,'____._')#(%)</cfif></font></font></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(taxamt_bil,'.__')#</font></div></td>
          </tr>
           <!--- <cfset currperiod = "CurrP"&"#getheaderinfo.fperiod#">
		  <cfquery name="getcurrcode" datasource="#dts#">
		  	select currcode from currencyrate where #currperiod# = '#getheaderinfo.currrate#'
		  </cfquery> --->

          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">GROSS &nbsp;
              #getcustadd.currcode#</font></font></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(gross_bil,'____.__')#</font></div></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr>
      <td width="65%"><font size="2" face="Times New Roman, Times, serif">Received
        By :</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">Issued By :</font></td>
    </tr>
    <tr>
      <td height="45">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>_____________________</td>
      <td>_____________________</td>
    </tr>
    <tr>
      <td><font face="Times New Roman, Times, serif"><font size="2">Company's
        Stamp &amp; Signature</font></font></td>
      <td nowrap><font size="2" face="Times New Roman, Times, serif">#getagent.desp# TEL: #getagent.hp#</font></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>

</cfmail>

<center>
  <h3><font face="Arial, Helvetica, sans-serif">Succeed&nbsp;!</font></h3>
  <font face="Arial, Helvetica, sans-serif" size="2">You have emailed the mail to other
  party successfully. </font>
  <!--- <form name="test" method="post">

    <input name="submit" type="button" value="close" onClick="winclose()">

  </form> --->
</center>
</body>
</html>