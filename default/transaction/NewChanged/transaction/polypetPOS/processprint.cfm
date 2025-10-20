<cftry>
<cfquery name="getdecimal" datasource="#dts#">
SELECT Decl_Uprice,Decl_Discount FROM gsetup2
</cfquery>

<cfquery name="recalculatediscountamtictran" datasource="#dts#">
Update ictran set 
disamt_bil = if(dispec1 = 0,disamt_bil,round(price_bil * qty_bil,#getdecimal.Decl_Uprice#)*(dispec1/100)) 
WHERE type = '#form.type#' and refno='#form.refno#' 
</cfquery>

<cfquery name="recalculateictran" datasource="#dts#">
Update ictran set amt_bil = round(price_bil * qty_bil,#getdecimal.Decl_Uprice#)-disamt_bil WHERE 
type = '#form.type#' and refno='#form.refno#' 
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictran SET amt = amt_bil * currrate,disamt = disamt_bil * currrate WHERE 
type = '#form.type#' and refno='#form.refno#' 
</cfquery>

<cfquery name="getsum" datasource="#dts#">
SELECT refno,type,sum(amt_bil) as sumamt FROM ictran WHERE type = '#form.type#' and refno='#form.refno#' group by refno
</cfquery>

<cfquery name="updatesum" datasource="#dts#">
Update artran SET gross_bil = "#val(getsum.sumamt)#" WHERE type = '#form.type#' and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsum.refno#">
</cfquery>


<cfquery name="updategrand" datasource="#dts#">
UPDATE artran SET net_bil = gross_bil - disc_bil WHERE 
type = '#form.type#' and refno='#form.refno#' 
</cfquery>

<cfquery name="updategrand2" datasource="#dts#">
Update artran SET 
grand_bil = if(taxincl = "T",net_bil,round(net_bil + (net_bil * taxp1/100),#getdecimal.Decl_Uprice#)),
tax1_bil = if(taxincl = "T",round(net_bil * taxp1/(100+taxp1),#getdecimal.Decl_Uprice#), round(net_bil * taxp1/100,#getdecimal.Decl_Uprice#)),
tax_bil = if(taxincl = "T",round(net_bil * taxp1/(100+taxp1),#getdecimal.Decl_Uprice#), round(net_bil * taxp1/100,#getdecimal.Decl_Uprice#)) 
WHERE 
type = '#form.type#' and refno='#form.refno#' 
</cfquery>

<cfquery name="updaterate" datasource="#dts#">
Update artran SET grand = grand_bil * currrate , net = net_bil * currrate, invgross = gross_bil * currrate, tax=tax_bil * currrate, tax1 = tax1_bil WHERE 
type = '#form.type#' and refno='#form.refno#' 
</cfquery>

<cfquery datasource='#dts#' name="getartran">
select * from artran where type = '#form.type#' and refno='#form.refno#' 
</cfquery>

<cfquery name='getgeneralinfo' datasource='#dts#'>
	select wpitemtax
	from gsetup
</cfquery>

<cfif getgeneralinfo.wpitemtax neq "Y" and val(getartran.invgross) neq 0>

    <cfif getartran.taxincl eq "T">

    <cfquery name="updatesum2" datasource="#dts#">
Update artran SET gross_bil = grand_bil-tax_bil+disc_bil-mc1_bil-mc2_bil-mc3_bil-mc4_bil-mc5_bil-mc6_bil-mc6_bil WHERE type = '#form.type#' and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsum.refno#">
    </cfquery>

    
<cfquery name="updaterate2" datasource="#dts#">
Update artran SET invgross = gross_bil * currrate WHERE 
type = '#form.type#' and refno='#form.refno#' 
</cfquery>

    <cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='#getartran.note#',
        TAXPEC1='#getartran.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getartran.net_bil)+val(getartran.disc_bil)#)*#val(getartran.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getartran.net)+val(getartran.discount)#)*#val(getartran.tax)#,5)
        type = '#form.type#' and refno='#form.refno#' 
    </cfquery>
    <cfelse>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='#getartran.note#',
        TAXPEC1='#getartran.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getartran.gross_bil)#)*#val(getartran.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getartran.invgross)#)*#val(getartran.tax)#,5)
        type = '#form.type#' and refno='#form.refno#' 
    </cfquery>
    </cfif>
</cfif>


<cfcatch type="any">
</cfcatch>
</cftry>

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
<cfif val(getbill.CS_PM_CASH) neq 0 and val(getbill.CS_PM_CHEQ) eq 0 and val(getbill.CS_PM_CRCD) eq 0 and val(getbill.CS_PM_CRC2) eq 0 and val(getbill.CS_PM_DBCD) eq 0 and val(getbill.CS_PM_VOUC) eq 0 and val(getbill.CS_PM_CASHCD) eq 0 and val(getbill.deposit) eq 0>
<cfif getbill.taxincl eq "T">
<cfset getbill.net_bil = numberformat((numberformat(val(getbill.net_bil)* 2,'._')/2),'.__')>
<cfelse>
<cfset getbill.grand_bil = numberformat((numberformat(val(getbill.grand_bil)* 2,'._')/2),'.__')>
</cfif>
</cfif>
<cfoutput>
<cfform name="form1" id="form1" action="/default/transaction/POS/" metdod="post">
<table width="230px" style="font-size:11px; border-width:thin;" cellpadding="0" cellspacing="0" >
<tr><td colspan="3" align="center"><a style="cursor:pointer; font-size:20px" onClick="window.print()"><strong>#getgsetup.compro#</strong></a></td><td widtd="10%" rowspan="100%">&nbsp;</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro2#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro3#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro4#</td></tr>
<tr><td colspan="3" align="center">#getgsetup.compro5#</td></tr>
<tr><td colspan="3" align="center">Receipt No : #getbill.refno#</td></tr>
<tr><td colspan="3" align="center">Date : #dateformat(getbill.trdatetime,'YYYY-MM-DD')#</td></tr>
<tr><td colspan="3" align="center">Time : #timeformat(getbill.trdatetime,'HH:MM:SS')#</td></tr>
<cfif getbill.van neq ''>
<tr><td colspan="3" align="center">Member No : #getbill.van#</td></tr>
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
<!---
<tr>
<td align="left" colspan="3" valign="bottom">#getbilltran.itemno#</td>
</tr>--->
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
<td align="left" colspan="2">#getbilltran.qty_bil# * <cfif priceunit neq 0>#numberformat(priceunit,'.__')#<cfelse>#numberformat(getbilltran.price_bil,'.__')#</cfif>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif getbilltran.dispec1 neq 0>(#getbilltran.dispec1#% off)</cfif></td>

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
<cfset showcurrcode = "S$">
<cfif getbill.currcode neq "">
<cfquery name="getcurrency" datasource="#dts#">
SELECT currency FROM currency WHERE currcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBill.currcode#">
</cfquery>
<cfset showcurrcode = getcurrency.currency>
</cfif>
SubTotal (#showcurrcode#)</td>
<td align="right"><cfif getbill.taxincl eq "T">#numberformat(val(getbill.net_bil)+val(getbill.disc_bil),'.__')#<cfelse>#numberformat(val(getbill.gross_bil),'.__')#</cfif></td>
</tr>
<tr>
<td colspan="2" align="right">
Further #numberformat(val(getbill.disp1),'.__')#%
</td>
<td align="right">
(#numberformat(val(getbill.disc_bil),'.__')#)
</td>
</tr>
<tr><td colspan="3"><hr/></td></tr>
<tr>
<td colspan="2" align="right">
<cfif getbill.taxincl eq "T">
Total Payable (#showcurrcode#)
<cfelse>
Before Tax Total (#showcurrcode#)
</cfif>
</td>

<td align="right">
<cfif getbill.taxincl eq "T"><b></cfif>#numberformat(val(getbill.net_bil),'.__')#<cfif getbill.taxincl eq "T"></b></cfif>
</td>
</tr>
<td colspan="2" align="right"><cfif getbill.taxincl eq "T">Include </cfif>GST (#numberformat(val(getbill.taxp1),'.__')#)</td>
<td align="right">#numberformat(getbill.tax_bil,'.__')#</td>
</tr>
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
<tr><td colspan="3" align="center"><strong>Terms & Conditions</strong></td></tr>
<tr><td colspan="3" align="center">-Goods(excluding non-exchangeable items) can only be exchanged within 7 days with original receipt.</td></tr>
<tr><td colspan="3" align="center">-Goods exchanged must be in original or re-saleable condition.</td></tr>
<tr><td colspan="3" align="center">-Non exchangeable items include, but are not limited to, animal apparel, muzzles, e-collars, etc.</td></tr>
<tr><td colspan="3" align="center">-Refunds will not be accepted.</td></tr>
<tr><td colspan="3" align="center">-In case of disputes, Polypet management reserves the right of the final decision.</td></tr>
<tr><td colspan="3" align="center">-Other terms & conditions apply.</td></tr>

</tr>
<td colspan="3" align="center">
<input type="hidden" name="counterchoose" id="counterchoose" value="#getbill.counter#">
<input type="submit" name="sub_btn" id="sub_btn" value="**Thank You**" style="background:none; 
                        border:0; 
                        margin:0; 
                        padding:0;
                        font-size:10px; 
"><br/>
<input type="submit" name="sub_btn" id="sub_btn" value="Have a nice day" style="background:none; 
                        border:0; 
                        margin:0; 
                        padding:0; 
                        font-size:10px; 
">
</td>
</tr>
</table></cfform>
<script type="text/javascript">
window.print();
</script>


</cfoutput>
</body>
</html>