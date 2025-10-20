<cfif tran eq "ISS">
	<cfset tran = "ISS">
	<cfset tranname = "Issue">
	<cfset trancode = "issno">
	<cfset prefix = "isscode">
<cfelseif tran eq "TR">
	<cfset tran = "TR">
	<cfset tranname = "Transfer Note">
	<cfset trancode = "trno">
	<cfset prefix = "trcode">
<cfelseif tran eq "OAI">
	<cfset tran = "OAI">
	<cfset tranname = "Adjustment Increase">
	<cfset trancode = "oaino">
	<cfset prefix = "oaicode">
<cfelseif tran eq "OAR">
	<cfset tran = "OAR">
	<cfset tranname = "Adjustment Reduce">
	<cfset trancode = "oarno">
	<cfset prefix = "oarcode">
</cfif>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfquery datasource='#dts#' name="getHeaderInfo">
	select * from artran where refno ='#nexttranno#' and type = '#tran#'
</cfquery>

<cfquery name="getcurrency" datasource="#dts#">
	select currency from #target_currency# where currcode='#getHeaderInfo.currcode#'
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select a.#prefix# as prefix,a.compro,a.compro2,a.compro3,a.compro4,a.compro5,a.compro6,a.compro7,concat(',.',repeat('_',b.decl_uprice)) as decl_uprice
	from gsetup as a,gsetup2 as b
</cfquery>

<cfif tran eq 'TR'>
	<cfquery datasource="#dts#" name="getBodyInfo">
		select * from ictran where refno = '#nexttranno#' and type = 'TROU' order by itemcount
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getBodyInfo">
		select * from ictran where refno = '#nexttranno#' and type = '#tran#' order by itemcount
	</cfquery>
</cfif>

<body>
<cfform name="form1" action="">

  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <cfoutput query="getgeneral">
	<tr>
      <td colspan="4"> <div align="center"><font color="##000000" size="4" face="Times New Roman, Times, serif"><cfif compro neq "">#getgeneral.compro#</cfif></font><font color="##000000"><br>
          <font size="2" face="Times New Roman, Times, serif"><cfif compro2 neq "">#compro2#</cfif><br>
          <cfif compro3 neq "">#compro3#</cfif></font><br>
          <font size="2" face="Times New Roman, Times, serif"><cfif compro4 neq "">#compro4#</cfif><cfif compro5 neq ""><br>#compro5#</cfif><cfif compro6 neq ""><br>#compro6#</cfif><cfif compro7 neq ""><br>#compro7#</cfif></font></font> </div></td>
    </tr>
	</cfoutput>
    <tr>
      <td colspan="4"><font face="Times New Roman, Times, serif"><strong></strong></font></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
      <td width="70%"> <cfif tran eq 'TR'>
       <cfquery name="gettransferfrom" datasource="#dts#">
        select location from ictran where refno='#nexttranno#' and type='TROU'
        </cfquery>
        <cfquery name="gettransferto" datasource="#dts#">
        select location from ictran where refno='#nexttranno#' and type='TRIN'
        </cfquery>
          <font size="2" face="Times New Roman, Times, serif"><cfoutput>Location
            From #gettransferfrom.location# To #gettransferto.location#</cfoutput></font></cfif> </td>
      <td colspan="3"><font size="3" face="Times New Roman, Times, serif"><strong><cfoutput>#Ucase(tranname)#</cfoutput></strong></font></td>
    </tr>
    <tr>
      <td nowrap><font face="Times New Roman, Times, serif"><font size="2"></font></font><font face="Times New Roman, Times, serif">&nbsp;</font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">NO.</font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">:</font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#getgeneral.prefix##getheaderInfo.refno#</cfoutput></font></font></td>
    </tr>
    <tr>
      <td><font face="Times New Roman, Times, serif"><font size="2"><strong><cfif lcase(hcomid) eq "simplysiti_i" and tran eq "TR"><cfoutput><cfif getheaderinfo.custno neq ""> Authorised By : #getheaderinfo.custno#</cfif><cfif getheaderinfo.name neq ""><br>Reason for Transfer: #getheaderinfo.name#</cfif></cfoutput><cfelse><cfoutput>#getheaderinfo.custno# #getheaderinfo.name#</cfoutput></cfif></strong></font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">DATE</font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">:</font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2"><cfoutput>#dateformat(getHeaderInfo.wos_date,"dd/mm/yyyy")#</cfoutput></font></font></td>
    </tr>
  </table>

  <hr>
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td nowrap> <div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">NO.
          </font></strong></font></div></td>
		<td nowrap><div align="left"><font face="Times New Roman, Times, serif"><strong><font size="2">ITEM NO.</font></strong></font></div></td>	  
      <td nowrap><div align="left"><font face="Times New Roman, Times, serif"><strong><font size="2">DESCRIPTION</font></strong></font></div></td>
      <td nowrap><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">QTY</font></strong></font></div></td>
      <cfif getpin2.h1360 eq 'T'>
      <td nowrap>
<div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">U.
          PRICE</font></strong></font></div></td>
      <td nowrap><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">AMOUNT</font></strong></font></div></td>
      </cfif>
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
    <cfoutput query="getBodyInfo">
	<cfset xamt_bil = 0>
	<cfset xqty = 0>
      <!---  startrow="1" maxrows="20" --->
      <cfquery name="getserial" datasource="#dts#">
      select * from iserial where refno = '#nexttranno#' and type = '#getbodyinfo.type#'
      and itemno = '#getbodyinfo.itemno#'
      </cfquery>
      <cfset row = #row# +1>
      <tr>
        <td valign="top" nowrap><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#row#</font></font></div></td>
        <td><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.itemno#</font></font></td>
		<td><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.desp#<br/>#getBodyInfo.despa#</font></font></td>
        <td><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#getBodyInfo.qty#</font></font></div></td>
        <cfif getpin2.h1360 eq 'T'>
        <td><div align="center"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.price_bil,getgeneral.decl_uprice)#</font></font></div></td>
        <td><div align="right"><font face="Times New Roman, Times, serif"><font size="2">#numberformat(getBodyInfo.amt_bil,getgeneral.decl_uprice)#</font></font></div></td>
        </cfif>
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
      <cfif getserial.recordcount gt 0>
        <tr>
          <td valign="top">
            <div align="left"></div></td>
          <td nowrap><font face="Times New Roman, Times, serif"><font size="2">**S/No
            :<strong> </strong>#getserial.serialno#</font></font></td>
          <td><div align="center"></div></td>
          <td><div align="center"></div></td>
          <td><div align="right"></div></td>
          <!--- <cfif getbodyinfo.recordcount lte 19>
            <cfset cnt = #cnt# - 1>
          </cfif>  --->
        </tr>
      </cfif>

    <cfif tostring(comment) neq "">
       <!---   <cfif getbodyinfo.recordcount lte 19>
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
          <td></td>
          <td><font face="Times New Roman"><font size="2">#tostring(comment)#</font></font></td>

          <td></td>
          <td></td>
          <td></td>
        </tr>
      </cfif>
    </cfoutput>

    <!--- <cfif getbodyinfo.recordcount lte 19>
      <cfloop index="i" from="1" to="#cnt#">
        <tr>
          <td height="17">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </cfloop>
    </cfif> --->
  </table>
  <br>
  <hr>
  <cfset xdisp1 = 0>
  <cfset xdisp2 = 0>
  <cfset xdisp3 = 0>
  <cfset xtaxp1 = 0>

 <cfif getheaderinfo.taxp1 neq "">
 	<cfset xtaxp1 = #getheaderinfo.taxp1#>
 </cfif>

 <cfif getheaderinfo.disp1 neq "">
    <cfset xdisp1 = #getheaderinfo.disp1#>
	<!--- <cfset disamt = #totalamt# * (#xdisp1#/100)> --->
  </cfif>
  <cfif getheaderinfo.disp2 neq "">
 	<cfset xdisp2 = #getheaderinfo.disp2#>
 </cfif>
 <cfif getheaderinfo.disp3 neq "">
 	<cfset xdisp3 = #getheaderinfo.disp3#>
 </cfif>

 <cfif getheaderinfo.disc1_bil neq "">
 	<cfset disamt_bil = #getheaderinfo.disc1_bil# + #getheaderinfo.disc2_bil# + #getheaderinfo.disc3_bil#>
 <cfelse>
 	<cfset disamt_bil  = 0>
 </cfif>

  <cfset net_bil = #totalamt# - #disamt_bil#>
  <cfset taxamt_bil = #net_bil# * (#xtaxp1#/100)>

  <cfset gross_bil = #net_bil# + #taxamt_bil#>

  <table width="100%" border="0" cellpadding="4" cellspacing="0">

    <tr>
      <td> <br>
        <br>
        <br>
        <br>
        </td>

      <td width="32%">
      <cfif getpin2.h1360 eq 'T'>
	  <table width="100%" border="0" align="right" bordercolor="#000000" cellspacing="0" cellpadding="3">
          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">TOTAL</font></font></td>
            <td width="30%" nowrap>
              <div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(totalamt,'____.__')#</cfoutput></font></div></td>
          </tr>

          <tr>
            <td nowrap><font face="Times New Roman, Times, serif"><font size="2">DISCOUNT
              <cfif getheaderinfo.disp1 neq 0 and getheaderinfo.disp1 neq "">
			    <cfoutput>#numberformat(xdisp1,'____.__')# </cfoutput>
				<cfif xdisp2 neq 0>
				  <cfoutput> + #numberformat(xdisp2,'____.__')# </cfoutput>
				</cfif>
				<cfif xdisp3 neq 0>
				  <cfoutput> + #numberformat(xdisp3,'____.__')# </cfoutput>
				</cfif>
				(%)
			  </cfif></font></font></td>
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
            <td nowrap><font face="Times New Roman, Times, serif"><font size="2">TAX <cfif getHeaderInfo.TAXINCL eq "T">ALREADY INCLUDED</cfif>
              <cfif getheaderinfo.taxp1 neq 0 and getheaderinfo.taxp1 neq ""><cfoutput>(#numberformat(xtaxp1,'____._')#</cfoutput>%)</cfif></font></font></td>
            <td nowrap>
<div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(taxamt_bil,'.__')#</cfoutput></font></div></td>
          </tr>
          <tr>
            <td><font face="Times New Roman, Times, serif"><font size="2">GROSS&nbsp;
             <cfif getcurrency.currency neq "">
				 <cfoutput>#getcurrency.currency#</cfoutput>
			 <cfelse>
				 S$
			 </cfif></font></font></td>
            <td nowrap>
<div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(gross_bil,'____.__')#</cfoutput></font></div></td>
          </tr>
        </table></cfif></td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td width="65%"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq 'mphcranes_i'>Issued By<cfelse>Received
        By :</cfif></font></td>
      <td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq 'mphcranes_i'><cfelse>Issued By :</cfif></font></td>
    </tr>
    <tr>
      <td height="50">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>_____________________</td>
      <td>_____________________</td>
    </tr>
    <tr>
      <td><font face="Times New Roman, Times, serif"><font size="2">Authorised
        Signature</font></font></td>
      <td nowrap><font size="2" face="Times New Roman, Times, serif">
        <!--- <cfoutput>#getagent.desp# TEL: #getagent.hp#</cfoutput> --->
        Received By</font></td>
    </tr>

  </table>

  <!--- <cfif Submit neq "Submit"> --->
    <div align="right">
	  <cfif husergrpid eq "Muser">
      <a href="../home2.cfm" class="noprint"><u><font size="2" face="Arial, Helvetica, sans-serif">Home</font></u></a>
    </cfif>
    <font size="2" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
    <!--- <input type="submit" name="Email" value="Email" class="noprint">	 --->
      <!--- <input type="submit" name="Submit" value="Submit"> --->
    </div>
  <!--- </cfif> --->
</cfform>
</body>
</html>