<cfquery name="gettermandcondition" datasource="#dts#">
	select lcs from ictermandcondition
</cfquery>

<cfif lcase(hcomid) eq "amgworld_i">
<cfoutput>
<script type="text/javascript">
window.open("/billformat/amgworld_i/preprintedformat.cfm?tran=CS&nexttranno=#form.refno#&BillName=amgworld_iCBIL_INV&doption=0&counter=1","","_blank");

</script>
</cfoutput>
<cfquery name="getbill" datasource="#dts#">
SELECT *,grand_bil as realtotal FROM artran WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
</cfquery>

<cfform name="form1" id="form1" action="/default/transaction/POS/" metdod="post">
<cfoutput>
<br>
<br>
<div align="center">
<input type="hidden" name="counterchoose" id="counterchoose" value="#getbill.counter#">
<input type="button" style=" font-size:larger" name="sub_btn" id="sub_btn" value="Create New" onClick="form1.submit();">
</div>
<br/>
</cfoutput>
</cfform>

<cfabort>
</cfif>
<html>
<body onLoad="document.getElementById('sub_btn').focus()">
<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>




<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfquery name="getbill" datasource="#dts#">
SELECT *,grand_bil as realtotal FROM artran WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
</cfquery>
<cfquery name="getbilltran" datasource="#dts#">
SELECT * FROM ictran WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
</cfquery>
<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>

<cfquery name="getlocationaddress" datasource="#dts#">
	select * from iclocation where location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbilltran.location#">
</cfquery>

<cfif val(getbill.CS_PM_CASH) neq 0 and val(getbill.CS_PM_CHEQ) eq 0 and val(getbill.CS_PM_CRCD) eq 0 and val(getbill.CS_PM_CRC2) eq 0 and val(getbill.CS_PM_DBCD) eq 0 and val(getbill.CS_PM_VOUC) eq 0 and val(getbill.CS_PM_CASHCD) eq 0 and val(getbill.deposit) eq 0>
<cfif getbill.taxincl eq "T">
<cfset getbill.net_bil = numberformat((numberformat(val(getbill.net_bil)* 2,'._')/2),'.__')>
<cfelse>
<cfset getbill.grand_bil = numberformat((numberformat(val(getbill.grand_bil)* 2,'._')/2),'.__')>
</cfif>
</cfif>
<cfoutput>
<cfform name="form1" id="form1" action="/default/transaction/POS/" metdod="post">
<table width="320px" style="font-size:14px; border-width:thin; font-family: Arial, Helvetica, sans-serif;" cellpadding="0" cellspacing="2" >

<tr><td colspan="5" align="center"><a style="cursor:pointer; font-size:20px" onClick="window.print()"><strong>#getgsetup.compro#</strong></a></td><td widtd="10%" rowspan="100%">&nbsp;</td></tr>
<tr><td colspan="5" align="center"><font style="font-size:10px"><strong>(#getgsetup.comuen#)</strong></font></a></td><td widtd="10%" rowspan="100%">&nbsp;</td></tr>



<tr><td colspan="5" align="center"><strong>#getgsetup.compro2#</strong></td></tr>
<tr><td colspan="5" align="center"><strong>#getgsetup.compro3#</strong></td></tr>
<tr><td colspan="5" align="center"><br></td></tr>
<tr><td colspan="5" align="center" nowrap><strong>#ucase(getgsetup.compro4)#</strong></td></tr>
<tr><td colspan="5" align="center" nowrap><strong>#ucase(getgsetup.compro5)#</strong></td></tr>
<cfif getgsetup.bcurr eq "MYR">
<tr><td colspan="5" align="center"><strong>GST NUMBER  :#getgsetup.gstno#</strong></td></tr>
</cfif>

<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr><td colspan="5" align="left">CUSTOMER NAME: #ucase(getbill.NAME)#</td></tr>
<tr><td colspan="5"><br></td></tr>

<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr><td colspan="5" align="left"><cfif getbill.cs_pm_cash neq 0>CASH <cfelseif getbill.cs_pm_cheq neq 0>CHEQUE #ucase(getbill.checkno)#</cfif></td></tr>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<td colspan="5">TAX INVOICE ##&nbsp;:#getbill.refno#</td>
</tr>
<tr>
<td colspan="5">DATE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: #dateformat(getbill.trdatetime,'dd/mm/yyyy')#</td>
</tr>
<tr>
<td colspan="5" nowrap>CASHIER  &nbsp;&nbsp;&nbsp;: #huserid# &nbsp;&nbsp;</td>

</tr>
<tr>
<td colspan="5" nowrap>TIME   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;: #timeformat(getbill.trdatetime,'HH:MM:SS')#</td>

</tr>


<tr>
<td colspan="5"></td>
</tr>
<tr>
<td colspan="5"></td>
</tr>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>

<tr style="font-weight:bold">
<td width="40%">ITEM</td>
<td align="center">QTY</td>
<td align="center"valign="bottom">U/P</td>
<td align="right"valign="bottom"><div align="right">DISC%</div></td>
<td align="right"valign="bottom">AMT</td>
</tr>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<cfloop query="getbilltran">
<cfset priceunit = 0>
<tr>
<td align="left" valign="bottom">#ucase(getbilltran.desp)#</td>
<td align="center" valign="bottom">#getbilltran.qty#</td>
<td align="right" valign="bottom">#numberformat(getbilltran.price_bil,'.__')#</td>
<td align="right" valign="bottom">#numberformat(getbilltran.dispec1,'.__')#</td>
<td align="right"valign="bottom">#numberformat(getbilltran.amt_bil,'.__')#
</td>
<td align="left" valign="bottom">
<cfif lcase(getgsetup.bcurr) eq "MYR" and getgsetup.wpitemtax eq 1>#getbilltran.note_a#</cfif>
</td>
</tr>
</cfloop>

<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<td colspan="4" align="left">
<cfquery name="getotalqty" datasource="#dts#">
SELECT sum(qty_bil) as totalqty FROM ictran where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
</cfquery>
TOTAL QTY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #getotalqty.totalqty#</td>
<td align="right"></td>

</tr>
<tr>
<tr><td><br></td></tr>
<td colspan="3" align="right">
<cfif getgsetup.bcurr eq "SGD">
<cfset showcurrcode = "S$">
<cfelse>
<cfset showcurrcode = "RM">
</cfif>
<cfif getbill.currcode neq "">
<cfquery name="getcurrency" datasource="#dts#">
SELECT currency FROM currency WHERE currcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBill.currcode#">
</cfquery>
<cfset showcurrcode = getcurrency.currency>
</cfif>
SUBTOTAL ( #showcurrcode# )&nbsp;&nbsp;:</td>
<td colspan="1">&nbsp;</td>
<td align="right"><cfif getbill.taxincl eq "T">#numberformat(val(getbill.gross_bil)+val(getbill.tax_bil),'.__')#<cfelse>#numberformat(val(getbill.gross_bil),'.__')#</cfif></td>
</tr>
<tr>
<td colspan="3" align="right">
DISCOUNT #numberformat(val(getbill.disp1),'.__')#%&nbsp;&nbsp;:
</td>
<td colspan="1">&nbsp;</td>
<td align="right">
(#numberformat(val(getbill.disc_bil),'.__')#)
</td>
</tr>
<cfif lcase(hcomid) neq "mikaaaa_i">
<tr>
<td colspan="3" align="right"><cfif getbill.taxincl eq "T">Include </cfif>GST&nbsp;&nbsp;:</td>
<td colspan="1">&nbsp;</td>
<td align="right">#numberformat(getbill.tax_bil,'.__')#</td>
</tr>
<tr>
<td colspan="3" align="right">
<cfif getbill.taxincl eq "T">
Total Payable (#showcurrcode#)
<cfelse>
ROUNDING&nbsp;&nbsp;:
</cfif>
</td>
<td colspan="1">&nbsp;</td>
<td align="right">
<cfif getbill.taxincl eq "T"><b></cfif>#numberformat(val(getbill.grand_bil)-val(getbill.realtotal),'.__')#<cfif getbill.taxincl eq "T"></b></cfif>
</td>
</tr>
</cfif>
<cfif getbill.taxincl neq "T">
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<th colspan="3" align="left" style="font-size:18px;"><strong>TOTAL(#showcurrcode#)</strong></th>
<td colspan="1">&nbsp;</td>
<th align="right" style="font-size:18px;"><strong>#numberformat(getbill.grand_bil,'.__')#</strong></th>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CASH) neq 0>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr><td><br></td></tr>
<tr>
<th colspan="3" align="left" style="font-size:18px;"><strong>CASH</strong></th>
<td colspan="1">&nbsp;</td>
<th align="right" style="font-size:18px;"><strong>#numberformat(val(getbill.CS_PM_CASH)+val(getbill.rem11),'.__')#</strong></th>
</tr>
<tr><td><br></td></tr>
<tr>
<th colspan="3" align="left" style="font-size:18px;"><strong>CHANGE</strong></th>
<td colspan="1">&nbsp;</td>
<th align="right" style="font-size:18px;"><strong>#numberformat(val(getbill.rem11),'.__')#</strong></th>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CHEQ) neq 0>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<th colspan="3" align="left">Cheque-#getbill.checkno#</th>
<td colspan="1">&nbsp;</td>
<th align="right">#numberformat(val(getbill.CS_PM_CHEQ),'.__')#</th>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CRCD) neq 0>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<td colspan="3" align="right">Credit Card-#getbill.rem10#</td>
<td colspan="1">&nbsp;</td>
<td align="right">#numberformat(val(getbill.CS_PM_CRCD),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CRC2) neq 0>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<td colspan="3" align="right">Credit Card-#getbill.rem8#</td>
<td colspan="1">&nbsp;</td>
<td align="right">#numberformat(val(getbill.CS_PM_CRC2),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_DBCD) neq 0>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<td colspan="2" align="right">NETS</td>
<td colspan="2">&nbsp;</td>
<td align="right">#numberformat(val(getbill.CS_PM_DBCD),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_VOUC) neq 0>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<td colspan="2" align="right">Voucher</td>
<td colspan="2">&nbsp;</td>
<td align="right">#numberformat(val(getbill.CS_PM_VOUC),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_cashcd) neq 0>
<tr><td colspan="5"><hr style="height: 2px; background-color:##000"></td></tr>
<tr>
<td colspan="2" align="right">Cash Card</td>
<td colspan="2">&nbsp;</td>
<td align="right">#numberformat(val(getbill.CS_PM_cashcd),'.__')#</td>
</tr>
</cfif>
<tr><td colspan="5"><br></td></tr>
<tr><td colspan="5"><br></td></tr>
<tr><td colspan="5"><br></td></tr>

</table>
<table width="280px" style="font-size:14px; border-width:thin; font-family: Arial, Helvetica, sans-serif;" cellpadding="0" cellspacing="2" >
<tr><td colspan="5" align="center">GOODS SOLD ARE NOT RETURNABLE/EXCHANGEABLE.<BR>
RECEIVED IN GOOD ORDER & CONDITION
</td></tr>
</tr>
<td colspan="5" align="center">
<input type="hidden" name="counterchoose" id="counterchoose" value="#getbill.counter#">
<input type="button" name="sub_btn" id="sub_btn" value="**THANK YOU**" style="background:none; 
                        border:0; 
                        margin:0; 
                        padding:0;
                        font-size:14px; 
" onClick="form1.submit();">
</td>
</tr>
</table></cfform>





<script type="text/javascript">
window.print();
</script>


</cfoutput>
</body>
</html>