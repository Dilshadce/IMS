<cfif dts EQ "umwstaffshop_i">
    <head>
        <link href="/stylesheet/stylesheetumw.css" rel="stylesheet" type="text/css">
    </head>
</cfif>

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
SELECT * FROM artran WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
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
SELECT * FROM artran WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
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
<table width="230px"  style="font-size:11px; border-width:thin;" cellpadding="0" cellspacing="0" >
<cftry>

<cfif lcase(hcomid) eq "mika_i" OR lcase(hcomid) eq "boonkheong_i">
<cfelseif lcase(hcomid) eq "potmh_i">
<tr><td colspan="3" align="center"><img src="/billformat/#dts#/logo.jpg" width="100" height="100"></td></tr>
<cfelse>
<cfif fileexists('/billformat/#dts#/logo.jpg')>
<tr><td colspan="3" align="center"><img src="/billformat/#dts#/logo.jpg" width="200" height="100"></td></tr>
</cfif>
</cfif>
<cfcatch></cfcatch></cftry>
<cfif getlocationaddress.addr1 neq "">
<tr>
<cfif lcase(hcomid) eq "mika_i">
<td colspan="3" align="center"><a style="cursor:pointer; font-size:20px; font-family:Arial, Helvetica, sans-serif" onClick="window.print()"><strong>#getlocationaddress.desp#</strong></a></td>
<cfelse>
<td colspan="3" align="center"><a style="cursor:pointer; font-size:20px" onClick="window.print()"><strong><cfif lcase(hcomid) eq "qingqing_i">#getgsetup.compro#<cfelse>#getlocationaddress.desp#</cfif></strong></a></td>
</cfif>

<td width="10%" rowspan="100%">&nbsp;</td></tr>

<tr><td colspan="3" align="center">#getlocationaddress.addr1#</td></tr>
<tr><td colspan="3" align="center">#getlocationaddress.addr2#</td></tr>
<tr><td colspan="3" align="center">#getlocationaddress.addr3#</td></tr>
<tr><td colspan="3" align="center">#getlocationaddress.addr4#</td></tr>
<cfelse>
<tr>
<cfif lcase(hcomid) eq "mika_i">
<td colspan="3" align="center"><a style="cursor:pointer; font-size:20px; font-family:Arial, Helvetica, sans-serif" onClick="window.print()"><strong>#getgsetup.compro#</strong></a></td>
<cfelse>
<td colspan="3" align="center"><a style="cursor:pointer; font-size:20px" onClick="window.print()"><strong>#getgsetup.compro#</strong></a></td>
</cfif>
<td widtd="10%" rowspan="100%">&nbsp;</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro2#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro3#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro4#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro5#</td></tr>
</cfif>
<cfif getgsetup.bcurr eq "MYR">
<tr><td colspan="3" align="center">Company No :#getgsetup.comuen#</td></tr>
<tr><td colspan="3" align="center">GST Number  :#getgsetup.gstno#</td></tr>
</cfif>
<tr><td colspan="3" align="center"><cfif lcase(hcomid) eq "munwah_i">Simplified Tax Invoice<cfelseif lcase(getgsetup.bcurr) eq "MYR">Tax Invoice<cfelse>Receipt</cfif> No : #getbill.refno#</td></tr>
<tr><td colspan="3" align="center">Date : #dateformat(getbill.trdatetime,'YYYY-MM-DD')#</td></tr>
<tr><td colspan="3" align="center">Time : #timeformat(getbill.trdatetime,'HH:MM:SS')#</td></tr>
<cfif getbill.agenno neq ''>
<tr><td colspan="3" align="center">Agent : #getbill.agenno#</td></tr>
</cfif>
<cfif getbill.van neq '' and lcase(getgsetup.bcurr) eq "MYR">
<cfquery name="getmemberprofile" datasource="#dts#">
	select * from driver where driverno="#getbill.van#"
</cfquery>
<tr><td colspan="3" align="left">Customer: #getmemberprofile.name#</td></tr>
<tr><td colspan="3" align="left">#getmemberprofile.add1#</td></tr>
<tr><td colspan="3" align="left">#getmemberprofile.add2#</td></tr>
<tr><td colspan="3" align="left">#getmemberprofile.add3#</td></tr>
</cfif>

<tr>
<td colspan="3"></td>
</tr>
<tr>
<td colspan="3"></td>
</tr>
<tr><td colspan="3"></td></tr>
<cfloop query="getbilltran">
<cfset priceunit = 0>
<cfif getbilltran.brem4 neq "">
<cfif right(getbilltran.brem4,1) eq "%">
    <cfset totpercent = val(getbilltran.brem4)>
        <cfif totpercent lte 100 and totpercent gt 0>
        <cfset priceunit = numberformat(val(getbilltran.price_bil) * ((100-totpercent)/100),stDecl_UPrice)>
        </cfif>
    <cfelse>
    <cfset totdis = val(getbilltran.brem4)>
        <cfif totdis lte val(getbilltran.price_bil)>
        <cfset priceunit =numberformat(val(getbilltran.price_bil) - val(totdis),stDecl_UPrice)>
        </cfif>
    </cfif>
</cfif>
<tr>
<td colspan="3" style="font-size:5px">&nbsp;</td>
</tr>
<tr>
<td align="left" colspan="2" valign="bottom">#getbilltran.itemno#</td>
<td align="right" valign="bottom">
<cfif lcase(getgsetup.bcurr) eq "MYR" and getgsetup.wpitemtax eq 1>#getbilltran.note_a#<cfelseif lcase(hcomid) eq "mengshop_i">#getbill.note#</cfif>
</td>
</tr>
<tr>
<td align="left" colspan="3"  width="220px">#getbilltran.desp#<cfif getbilltran.brem1 eq "Delivery">-Delivery</cfif></td>
</tr>
<tr>
<cfquery name="getaitemno" datasource="#dts#">
select aitemno from icitem where itemno='#getbilltran.itemno#'
</cfquery>
<td align="left" colspan="3"  width="220px"> #getaitemno.aitemno#</td>
</tr>
<!--- <cfif priceunit neq 0>
<tr>
<td align="left">(#numberformat(getbilltran.price_bil,'.__')#)</td>
</tr>
</cfif> --->
<tr valign="top">
<td align="left" colspan="2">#getbilltran.qty_bil# * <cfif priceunit neq 0>#numberformat(priceunit,'.__')#<cfelse>#numberformat(getbilltran.price_bil,'.__')#</cfif>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif getbilltran.dispec1 neq 0>#getbilltran.dispec1#% off</cfif></td>

<td align="right">#numberformat(getbilltran.amt_bil,'.__')#</td>
</tr>
</cfloop>

<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">
<cfquery name="getotalqty" datasource="#dts#">
SELECT sum(qty_bil) as totalqty FROM ictran where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
</cfquery>
Total Quantity :  #getotalqty.totalqty#</td>
<td align="right"></td>
</tr>
<tr>
<td colspan="2" align="right">
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
SubTotal (#showcurrcode#)</td>
<td align="right"><cfif getbill.taxincl eq "T">#numberformat(val(getbill.gross_bil)+val(getbill.tax_bil),'.__')#<cfelse>#numberformat(val(getbill.gross_bil),'.__')#</cfif></td>
</tr>
<tr>
<td colspan="2" align="right">
Discount #numberformat(val(getbill.disp1),'.__')#%
</td>
<td align="right">
(#numberformat(val(getbill.disc_bil),'.__')#)
</td>
</tr>
<tr><td colspan="3"><hr/></td></tr>
<cfif lcase(hcomid) neq "mikaaaa_i">
<tr>
<td colspan="2" align="right">
<cfif getbill.taxincl eq "T">
Total Payable (#showcurrcode#)
<cfelse>
Before Tax Total (#showcurrcode#)
</cfif>
</td>

<td align="right">
<cfif getbill.taxincl eq "T"><b></cfif>#numberformat(val(getbill.grand_bil)-val(getbill.tax_bil)-val(getbill.roundadj),'.__')#<cfif getbill.taxincl eq "T"></b></cfif>
</td>
</tr>
<td colspan="2" align="right"><cfif getbill.taxincl eq "T">Include </cfif>GST <cfif getgsetup.wpitemtax neq 1>(#numberformat(val(getbill.taxp1),'.__')#%)</cfif></td>
<td align="right">#numberformat(getbill.tax_bil,'.__')#</td>
</tr>
</cfif>
<cfif getbill.taxincl neq "T">
<tr>
<th colspan="2" align="right">Total Payable (#showcurrcode#)</th>
<th align="right">#numberformat(getbill.grand_bil,'.__')#</th>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CASH) neq 0>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">Cash  (#showcurrcode#)</td>
<td align="right">#numberformat(val(getbill.CS_PM_CASH)+val(getbill.rem11),'.__')#</td>
</tr>
<cfif (lcase(hcomid) eq "amgworld_i" or lcase(hcomid) eq "netilung_i") and val(getbill.CS_PM_tt) neq 0>
<tr>
<td colspan="2" align="right">Trade In</td>
<td align="right">#numberformat(val(getbill.CS_PM_TT),'.__')#</td>
</tr>
</cfif>
<tr>
<td colspan="2" align="right">Changes Due (#showcurrcode#)</td>
<td align="right">#numberformat(val(getbill.rem11),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CHEQ) neq 0>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">Cheque-#getbill.checkno#</td>
<td align="right">#numberformat(val(getbill.CS_PM_CHEQ),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CRCD) neq 0>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">Credit Card-#getbill.rem10#</td>
<td align="right">#numberformat(val(getbill.CS_PM_CRCD),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_CRC2) neq 0>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">Credit Card-#getbill.rem8#</td>
<td align="right">#numberformat(val(getbill.CS_PM_CRC2),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_DBCD) neq 0>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">NETS</td>
<td align="right">#numberformat(val(getbill.CS_PM_DBCD),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_VOUC) neq 0>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">Voucher</td>
<td align="right">#numberformat(val(getbill.CS_PM_VOUC),'.__')#</td>
</tr>
</cfif>
<cfif val(getbill.CS_PM_cashcd) neq 0>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">Cash Card</td>
<td align="right">#numberformat(val(getbill.CS_PM_cashcd),'.__')#</td>
</tr>
</cfif>

<cfif lcase(getgsetup.bcurr) eq "MYR" and getgsetup.wpitemtax eq 1>
<cfquery name="getperitemtax" datasource="#dts#">
	SELECT sum(amt) as amt,sum(taxamt) as taxamt,note_a,taxpec1 from ictran WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.type#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> group by note_a
</cfquery>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td>GST Summary</td>
<td>Amount(RM)</td>
<td>Tax(RM)</td>
</tr>
<cfloop query="getperitemtax">
<tr>
<td>#getperitemtax.note_a# = #getperitemtax.taxpec1#%</td>
<td>
	<cfif getbill.taxincl eq "T">		
    	#numberformat(getperitemtax.amt-getperitemtax.taxamt,',.__')#
	<cfelse>
    	#numberformat(getperitemtax.amt, ',.__')#
    </cfif>
</td>
<td>#numberformat(getperitemtax.taxamt,',.__')#</td>
</tr>
</cfloop>
<tr><td colspan="3"><hr/></td></tr>
</cfif>

<tr><td colspan="3"></td></tr>
<tr>
<td align="Left">Cashiers</td>
<td  colspan="2"  align="right">#getbill.userid#</td>
</tr>
<tr>
<td>Remarks</td>
</tr>
<tr>
<td colspan="3">
#getbill.rem9#
</td>
<cfif lcase(hcomid) neq "mika_i" OR lcase(hcomid) neq "boonkheong_i">
<tr><td colspan="3" align="center"><strong>Terms & Conditions</strong></td></tr>

<cfset info=tostring(gettermandcondition.lcs)>



<cfset recordcnt = ListLen(info,chr(13)&chr(10))>
<cfloop from="1" to="#recordcnt#" index="i">
<cfset str = ListGetAt(info,i,chr(13)&chr(10))>
<tr><td colspan="3" align="center">#str#</td></tr>
<cfset i=i+1>

</cfloop>

</cfif>
</tr>
<td colspan="3" align="center">
<input type="hidden" name="counterchoose" id="counterchoose" value="#getbill.counter#">
<input type="button" name="sub_btn" id="sub_btn" value="**Thank You**" style="background:none; 
                        border:0; 
                        margin:0; 
                        padding:0;
                        font-size:10px; 
" onClick="form1.submit();"><br/>
<input type="button" name="sub_btn" id="sub_btn" value="Have a nice day" style="background:none; 
                        border:0; 
                        margin:0; 
                        padding:0; 
                        font-size:10px; 
" onClick="form1.submit();">
</td>
</tr>
<cfif lcase(hcomid) eq "mika_i">
<tr><td colspan="3" align="center">Show us LOVE @ fb.com/mikagiftshop</td></tr>
</cfif>
</table></cfform>





<script type="text/javascript">
window.print();
</script>


</cfoutput>
</body>
</html>