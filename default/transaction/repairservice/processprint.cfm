<script type="text/javascript">
var ws = new ActiveXObject("WScript.Shell");
ws.Run('cmd.exe /c RUNDLL32 PRINTUI.DLL,PrintUIEntry /y /n "Fax"','0');
</script>

<script type='text/javascript' src='/ajax/core/jquery.jqprint-0.3.js'></script>



<html>
<body onLoad="document.getElementById('sub_btn').focus()">

<cfquery name="getbill" datasource="#dts#">
SELECT * FROM repairtran WHERE repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
</cfquery>

<cfquery name="getcustinfo" datasource="#dts#">
SELECT * FROM #target_arcust# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbill.custno#">
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>


<cfoutput>
<cfform name="form1" id="form1" action="/default/transaction/POS/" method="post">
<table width="230px" style="font-size:12px; border-width:thin;" cellpadding="0" cellspacing="0" >
<tr><td colspan="3" align="center"><strong>Repair Receipt</strong></td><td widtd="10%" rowspan="100%">&nbsp;</td></tr>
<tr><td colspan="3" align="center">&nbsp;</td><td widtd="10%" rowspan="100%">&nbsp;</td></tr>
<tr><td colspan="3" align="center"><a style="cursor:pointer; font-size:20px" onClick="window.print()"><strong>#getgsetup.compro#</strong></a></td><td widtd="10%" rowspan="100%">&nbsp;</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro2#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro3#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro4#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro5#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro6#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro7#</td></tr>
<tr><td colspan="3" align="center">Http://www.gamemartz.com</td></tr>
<tr><td colspan="3" align="center">Reg No : #getgsetup.comuen# GST Reg. #getgsetup.gstno#</td></tr>
<tr>
<td colspan="3">&nbsp;</td>
</tr>
<tr><td colspan="3" align="left">#getgsetup.compro7#</td></tr>
<tr>
<td colspan="3"></td>
</tr>
<tr><td colspan="3"></td></tr>
<tr>
<td colspan="3" style="font-size:5px">&nbsp;</td>
</tr>
<tr>
<td align="left" colspan="3" valign="bottom">#getcustinfo.name#</td>
</tr>
<cfif getcustinfo.add1 neq ''>
<tr>
<td align="left" colspan="3" valign="bottom">#getcustinfo.add1#</td>
</tr>
</cfif>
<cfif getcustinfo.add2 neq ''>
<tr>
<td align="left" colspan="3" valign="bottom">#getcustinfo.add2#</td>
</tr>
</cfif>
<cfif getcustinfo.add3 neq ''>
<tr>
<td align="left" colspan="3" valign="bottom">#getcustinfo.add3#</td>
</tr>
</cfif>
<cfif getcustinfo.add4 neq ''>
<tr>
<td align="left" colspan="3" valign="bottom">#getcustinfo.add4#</td>
</tr>
</cfif>
<cfif getcustinfo.phone neq ''>
<tr>
<td align="left" colspan="3" valign="bottom">#getcustinfo.phone#</td>
</tr>
</cfif>

<tr>
<td align="left" valign="bottom">Date Handed In</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.wos_date#</td>
</tr>

<tr>
<td align="left" valign="bottom">Receipt Number</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.repairno#</td>
</tr>

<tr>
<td align="left" valign="bottom">Purchase Date</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.rem6#</td>
</tr>

<tr>
<td align="left" valign="bottom">Slip Number</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.repairno#</td>
</tr>

<tr>
<td align="left" valign="bottom">Description</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.desp#</td>
</tr>

<tr>
<td align="left" valign="bottom">Manufacturer</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.rem8#</td>
</tr>

<tr>
<td align="left" valign="bottom">Serial No</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.rem7#</td>
</tr>

<tr>
<td align="left" valign="bottom">Purchase Price</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom"></td>
</tr>

<tr>
<td align="left" valign="bottom">Date Promised</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#dateformat(getbill.completedate,'DD/MM/YYYY')#</td>
</tr>
<tr>
<td align="left" valign="bottom">Description of fault</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.rem9#</td>
</tr>
<tr>
<td align="left" valign="bottom">Item Condition</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.rem10#</td>
</tr>

<tr>
<td align="left" valign="bottom">Component Missing</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.rem11#</td>
</tr>

<tr>
<td align="left" valign="bottom">Received By</td>
<td align="left" valign="bottom">:</td>
<td align="left" valign="bottom">#getbill.rem5#</td>
</tr>

</table></cfform>





<script type="text/javascript">

this.print(false);

</script>


</cfoutput>
</body>
</html>
<!---

<cfheader name="Content-Disposition" value="inline; filename=test.txt">
<cfcontent type="application/msword" file="c:\railo\test.txt" deletefile="yes"> --->
