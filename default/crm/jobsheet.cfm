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

<cfquery datasource='#dts#' name="getHeaderInfo">
	select * from service_tran where serviceid ='#url.serviceid#'
</cfquery>
<cfquery datasource='#dts#' name="getCustInfo">
	select * from #target_arcust# where custno ='#getHeaderInfo.custno#'
</cfquery>

<cfif Email eq "Email">
		<cfquery name="getemail" datasource="#dts#">
			select e_mail from #target_arcust# where custno = '#getheaderinfo.custno#'
		</cfquery>
		<cfif getemail.e_mail eq "">
		<cfoutput>
			<h4><font color="##FF0000">Please add in email address for customer - #getheaderinfo.custno#.</font></h4></cfoutput>
			<cfabort>
		<cfelse>
			<cflocation url="">
		</cfif>

</cfif>

<body>
<cfform name="form1" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      	<td colspan="3" align='right'><input name="imageField" type="image" src="../../billformat/net_i/netlogo.jpg" height='80' width='300'></td>
      	<cfif lcase(HcomID) eq "net_i">
			<td nowrap><font size="4" face="Arial black"><strong>Netiquette Software 
		        <font size="3" face="Arial, Helvetica, sans-serif">Pte Ltd</font></strong></font><br> 
		        <font size="2" face="Times New Roman, Times, serif">745 Lorong 5 Toa Payoh, #03-04, Singapore 319455</font><br>
		        <font size="2" face="Times New Roman, Times, serif">Tel: +65 6223 1157&nbsp;&nbsp;&nbsp;Fax: +65 68231076<br/>http://www.netiquette.com.sg</font>
		  	</td>
		<cfelseif lcase(HcomID) eq "netm_i">
			<td nowrap><font size="4" face="Arial black"><strong>NETIQUETTE TECHNOLOGIES 
		        <font size="3" face="Arial, Helvetica, sans-serif">(M) SDN BHD</font></strong></font><br> 
		        <font size="2" face="Times New Roman, Times, serif">1006, Level 10, Block B2, Leisure Commerce Square,</font><br>
				<font size="2" face="Times New Roman, Times, serif">Jln PJS 8/9, 46150 P.J, Selangor, Malaysia.</font><br>
		        <font size="2" face="Times New Roman, Times, serif">Tel: +603 78778955&nbsp;&nbsp;&nbsp;Fax: +603 78778954<br/>http://www.mynetiquette.com</font>
		  	</td>	
		</cfif>
      	<td colspan="3" valign="bottom">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3"><font face="Times New Roman, Times, serif"><strong></strong></font></td>
      <td>&nbsp;</td>
      <td colspan="3"><cfif lcase(HcomID) eq "net_i">_____________________</cfif></td>
    </tr>
    <cfoutput>
      <tr>
        <td colspan="4"><font face="Times New Roman, Times, serif"><strong><font size="2">#getcustinfo.name#</font></strong></font></td>
        <td colspan="3" nowrap><font size="2" face="Times New Roman, Times, serif"><cfif lcase(HcomID) eq "net_i">Co. Reg. No. : 200706402C<!--- 200411535M ---></cfif></font></td>
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
	  	<cfif #getheaderinfo.s_status# eq 1>
			New
		<cfelseif #getheaderinfo.s_status# eq 2>
			Follow Up
		<cfelseif #getheaderinfo.s_status# eq 3>
			Solved
		<cfelseif #getheaderinfo.s_status# eq 4>
			Unsolved
		<cfelse>
			Cancelled
		</cfif></font></td>
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
          <cfif #getheaderinfo.servicetype# eq "tacc1">
            Training - Accounting 1st Lesson
            <cfelseif #getheaderinfo.servicetype# eq "tacc2">
            Training - Accounting 2nd Lesson
            <cfelseif #getheaderinfo.servicetype# eq "tstk1">
            Training - Stock Control 1st Lesson
            <cfelseif #getheaderinfo.servicetype# eq "tstk2">
            Training - Stock Control 2nd Lesson
            <cfelseif #getheaderinfo.servicetype# eq "onsite">
            Onsite Support
            <cfelseif #getheaderinfo.servicetype# eq "install">
            Installation
            <cfelse>
            Others
          </cfif>
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
    <tr>
      <td colspan="7">Collect Payment :
        <cfif #getheaderinfo.collect# eq 1>
          Yes
          <cfelse>
          No </cfif> </td>
    </tr>
  </table>
  Status :
  <input type="checkbox" name="checkbox" value="checkbox">
  Solved/Completed &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="checkbox" name="checkbox2" value="checkbox">
  Pending<br>
  <hr>
  <table width="100%" border="0" cellpadding="4" cellspacing="0">
    <tr>
      <td> <p>Important Note:</p>
        <p><br>
          <font face="Times New Roman" size="2">Please note that work has been
          done to your satisfaction and according to your specification before
          our CSO (Customer Service Officer) leaves. As any discrepency thereafter
          would not be held liable by Netiquette Software Pte Ltd. Upon accepting
          this, any futher admendment(s) or additional(s) request or onsite visit
          shall be chargable.</font><br>
          <br>
          <br>
          <br>
        </p></td>
      <td width="32%">&nbsp;</td>
    </tr>
  </table>
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
  <p>This report is generated by CRM. Developed by Netiquette Software Pte Ltd </p>
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