<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>
<cfsetting showdebugoutput="no">

<noscript>
Javascript has been disabled or not supported in this browser.<br>
Please enable Javascript supported before continue.
</noscript>
<!--- <cfparam name="Submit" default=""> --->
<cfparam name="Email" default="">

<cfquery datasource='#dts#' name="getgsetup">
	select * from gsetup
</cfquery>

<cfquery datasource='#dts#' name="getHeaderInfo">
	select * from service_tran where serviceid ='#url.serviceid#'
</cfquery>

<cfquery datasource='#dts#' name="getcustdetail">
	select * from artran where refno ='#getHeaderInfo.refno#'
</cfquery>

<cfquery datasource='#dts#' name="getCustInfo">
	select * from #target_arcust# where custno ='#getcustdetail.custno#'
</cfquery>

<body>
<cfform name="form1" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
    <cfoutput>
    <tr>
			<td nowrap><font size="4" face="Arial black"><strong>#getgsetup.compro# 
		        <font size="3" face="Arial, Helvetica, sans-serif"></font></strong></font><br> 
		        <font size="2" face="Times New Roman, Times, serif">#getgsetup.compro2#</font><br>
				<font size="2" face="Times New Roman, Times, serif">#getgsetup.compro3#</font><br>
		        <font size="2" face="Times New Roman, Times, serif">#getgsetup.compro4#<br/>#getgsetup.compro5#</font>
		  	</td>	
      	<td colspan="3" valign="bottom">&nbsp;</td>
    </tr>
    </cfoutput>
    <tr>
      <td colspan="3"><font face="Times New Roman, Times, serif"><strong></strong></font></td>
      <td>&nbsp;</td>
      <td colspan="3"><cfif lcase(HcomID) eq "net_i">_____________________</cfif></td>
    </tr>
    <cfoutput>
      <tr>
        <td colspan="4"><font face="Times New Roman, Times, serif"><strong><font size="2">#getHeaderInfo.refno#</font></strong></font></td>
      </tr>
      <tr>
        <td colspan="4"><font face="Times New Roman, Times, serif"><strong><font size="2">#getcustinfo.name#</font></strong></font></td>
      </tr>
      <tr>
        <td colspan="4" rowspan="2"><font face="Times New Roman, Times, serif"><font size="2">#getcustinfo.add1# <br>
          #getcustinfo.add2#<br>
          #getcustinfo.add3#<br>
          #getcustinfo.add4# </font></font><font size="2" face="Times New Roman, Times, serif">&nbsp;
          </font></td>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3"><font size="3" face="Times New Roman, Times, serif"><strong>Service
          Order Sheet</strong></font></td>
      </tr>
    </cfoutput>
    <tr>
      <td colspan="4">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td></font></td>
    </tr><cfoutput>
    <tr>
      <td><font face="Times New Roman, Times, serif"><font size="2"><strong>ATTN</strong></font></font></td>
      <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
      <td colspan="2"><font face="Times New Roman, Times, serif"><font size="2"><strong>#getcustinfo.attn# </strong></font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">SERVICE ID
        </font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">:</font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">#getheaderinfo.serviceid#</font></font></td>
    </tr>
    <tr>
      <td><font face="Times New Roman, Times, serif"><font size="2" face="Times New Roman, Times, serif">TEL</font><font size="2"></font></font></td>
      <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
      <td colspan="2"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font size="2">
        #getcustinfo.phone# </font></font></font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">DATE</font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">:</font></font></td>
      <td><font face="Times New Roman, Times, serif"><font size="2">#dateformat(getheaderinfo.servicedate, "DD/MM/YYYY")# - #getheaderinfo.apptime#</font></font></td>
    </tr>
    <tr>
      <td><font size="2" face="Times New Roman, Times, serif">FAX</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
      <td colspan="2"><font face="Times New Roman, Times, serif"><font size="2">#getcustinfo.fax# </font></font></td>
      <td>TYPE</td>
      <td><font face="Times New Roman, Times, serif">:&nbsp;</font></td>
      <td><font face="Times New Roman, Times, serif">
	  	</font></td>
    </tr>
    <tr>
      <td nowrap><font face="Times New Roman, Times, serif"><font size="2">A/C
        NO</font></font></td>
      <td><font size="2" face="Times New Roman, Times, serif">:</font></td>
      <td colspan="2"><font face="Times New Roman, Times, serif"><font size="2">#getcustinfo.custno# </font></font></td>
      <td><font size="2" face="Times New Roman, Times, serif">CSO</font></td>
      <td><font face="Times New Roman, Times, serif">:</font></td>
      <td><font size="2" face="Times New Roman, Times, serif">#getheaderinfo.csoid#</font></td>
    </tr>
  </table></cfoutput>
  <hr>
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td nowrap>&nbsp;</td>
      <td><div align="center"><font face="Times New Roman, Times, serif"><strong><font size="2">JOB
          DESCRIPTION</font></strong></font></div></td>
      <td>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <cfoutput>
      <tr>
        <td nowrap><font face="Times New Roman, Times, serif"><strong>Nature of
          Service:</strong></font></td>
        <td><font face="Times New Roman, Times, serif"><strong>
          #getheaderinfo.servicetype#
          </strong></font></td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td nowrap><font face="Times New Roman, Times, serif"><strong>Instruction:</strong></font></td>
        <cfset xinstruction = tostring(#getheaderinfo.instruction#)>
        <td rowspan="3"><font face="Times New Roman, Times, serif"><strong>#xinstruction#</strong></font></td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="5" nowrap><hr></td>
      </tr>
	  <cfset xcomments = tostring(#getheaderinfo.comments#)>
      <tr>
        <td nowrap><font face="Times New Roman, Times, serif"><strong>Comments:</strong></font></td>
        <td rowspan="3"><font face="Times New Roman, Times, serif"><strong>#xcomments#</strong></font></td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td nowrap><font face="Times New Roman, Times, serif">&nbsp;</font></td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td nowrap>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="20%" nowrap> <div align="center"><font face="Times New Roman, Times, serif"></font></div></td>
        <td width="50%"><div align="left"><font face="Times New Roman, Times, serif"></font></div></td>
        <td width="10%"><div align="center"><font face="Times New Roman, Times, serif"><strong></strong></font></div></td>
        <td width="10%" nowrap> <div align="center"><font face="Times New Roman, Times, serif"><strong></strong></font></div></td>
        <td width="10%"><div align="center"><font face="Times New Roman, Times, serif"><strong></strong></font></div></td>
      </tr>
    </cfoutput>
    
  </table>
  Status :
  <input type="checkbox" name="checkbox" value="checkbox">
  Solved/Completed &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="checkbox" name="checkbox2" value="checkbox">
  Pending<br>
  <hr>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td width="65%"><font size="2" face="Times New Roman, Times, serif">Verify
        By :</font></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td height="52">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>_________________________</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><font face="Times New Roman, Times, serif"><font size="2">Company's
        Stamp, Name &amp; Signature</font></font></td>
      <td nowrap>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <!--- <cfif Submit neq "Submit"> --->
  <div align="right">
    <cfif husergrpid eq "Muser">
      <a href="../home2.cfm" class="noprint"><u><font size="2" face="Arial, Helvetica, sans-serif">Home</font></u></a>
    </cfif>
    <font size="2" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font>
    <input type="submit" name="Email" value="Email" class="noprint">

  </div>

</cfform>
</body>
</html>