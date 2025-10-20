<html>
<head>
<title>Voucher Usage Report</title>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro, compro2, compro3, compro4, compro5, compro6, compro7,CTYCODE,comuen,gstno,wpitemtax,wpitemtax1 from gsetup 
</cfquery>

<cfquery name="getusage" datasource="#dts#">
SELECT * FROM voucher WHERE voucherno in (
SELECT voucherno FROM vouchertran
WHERE 1=1

<cfif form.custfrom neq "" and form.custto neq "">
and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
</cfif>
<cfif form.voucherto neq "" and form.voucherfrom neq "">
and voucherno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherto#">
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
and wos_date between "#dateformat(ndate,'YYYY-MM-DD')#" and "#dateformat(ndate1,'YYYY-MM-DD')#"
</cfif>

group by voucherno
) 




order by voucherno
</cfquery>
<cfoutput query="getgeneral">
      <table border="0" align="center" >
      <tr>
      <td colspan="4"><div align="right" ><cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i"><img src="Logo1.jpg" width="160" height="110" /><cfelseif lcase(hcomid) eq "mfss_i"  or lcase(hcomid) eq "mfssmy_i"><img src="logo.png" width="60" height="110" /><cfelse><img src="hcss-logo.jpg" width="160" height="110" /></cfif></div><div align="center"><font size="3" face="Arial black"><strong><cfif getgeneral.compro neq ''></cfif></strong></font></div></td>
      
      <td colspan="5" valign="top"><br/>
      <font size="3" face="Arial black">
      #trim(compro)#<br>
      </font>
	  <cfif getgeneral.compro2 neq ''>
      <font size="3" face="Times New Roman, Times, serif">
      #compro2#<br>
      </font> 
      </cfif>
	  <cfif getgeneral.compro3 neq ''>
      <font size="3" face="Times New Roman, Times, serif">
      #compro3#<br>
      </font>
      </cfif>
      <cfif getgeneral.compro4 neq ''><font size="3" face="Times New Roman, Times, serif">#compro4#</font> <br></cfif>
          <cfif getgeneral.compro5 neq ''><font size="3" face="Times New Roman, Times, serif">#compro5#</font> <br></cfif>
          <cfif getgeneral.compro6 neq ''><font size="3" face="Times New Roman, Times, serif">#compro6#</font> <br></cfif>
          <cfif getgeneral.compro7 neq ''><font size="3" face="Times New Roman, Times, serif">#compro7#</font></cfif> </td>
      </tr>
      </table>
	</cfoutput>
    
    <cfif form.custfrom eq form.custto>
<cfoutput>
<cfquery name="getcustdetail" datasource="#dts#">
select * from #target_arcust# where custno='#form.custfrom#'
</cfquery>
      <table border="0" width="80%" align="center">
      <tr>
      <td colspan="8" width="50" valign="top"><font size="2" face="Times New Roman, Times, serif">Bill To : </font>
      <td><font size="2" face="Times New Roman, Times, serif">#getcustdetail.name#</font><br />
      	  <cfif getcustdetail.name2 neq ''><font size="2" face="Times New Roman, Times, serif">#getcustdetail.name2#</font> <br></cfif>
          <cfif getcustdetail.add1 neq ''><font size="2" face="Times New Roman, Times, serif">#getcustdetail.add1#</font> <br></cfif>
          <cfif getcustdetail.add2 neq ''><font size="2" face="Times New Roman, Times, serif">#getcustdetail.add2#</font> <br></cfif>
          <cfif getcustdetail.add3 neq ''><font size="2" face="Times New Roman, Times, serif">#getcustdetail.add3#</font> <br></cfif>
          <cfif getcustdetail.add4 neq ''><font size="2" face="Times New Roman, Times, serif">#getcustdetail.add4#</font> <br></cfif>
          <cfif getcustdetail.phone neq ''><font size="2" face="Times New Roman, Times, serif">Tel : #getcustdetail.phone#</font> <br></cfif>
          <cfif getcustdetail.fax neq ''><font size="2" face="Times New Roman, Times, serif">Fax : #getcustdetail.fax#</font> </td>
      </tr></cfif>
      </table>
	</cfoutput>
    </cfif>

<cfoutput>
<table width="80%" align="center">
<tr>
<th colspan="100%">Voucher Usage Listing</th>
</tr>

<cfif form.voucherto neq "" and form.voucherfrom neq "">
<tr>
<td align="center" colspan="100%">Voucher From #form.voucherfrom# To #form.voucherto#</td>
</tr>
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
<tr>
<td align="center" colspan="100%">Date From #form.datefrom # To #form.dateto#</td>
</tr>
</cfif>
<tr>
<td align="center" colspan="100%">Report Date #form.reportdate#</td>
</tr>
<tr>
<td></td>
</tr>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<th align="left">Voucher No</th>
<th align="left">Date</th>
<th align="left">Transaction</th>
<th align="right">Value</th>
<th align="right">Balance</th>
</tr>
<tr>
<td colspan="100%"><hr/></td>
</tr>
<cfloop query="getusage">
<tr>
<td><b>#getusage.voucherno#</b></td>
<td><cfquery name="getvouchercreatedate" datasource="#dts#">select wos_date from ictran where voucherno='#getusage.voucherid#'</cfquery> <cfif getvouchercreatedate.recordcount neq 0>#dateformat(getvouchercreatedate.wos_date,"YYYY-MM-DD")#<cfelse>#dateformat(getusage.created_on,"YYYY-MM-DD")#</cfif></td>
<td>Created With <cfquery name="getvouchercreatebill" datasource="#dts#">select refno from ictran where voucherno='#getusage.voucherid#'</cfquery> <cfif getvouchercreatebill.recordcount neq 0>INV-#getvouchercreatebill.refno#<cfelse>Voucher Profile</cfif></td>
<td align="right">#numberformat(getusage.value,',.__')#</td>

<cfquery name="getoutqty" datasource="#dts#">
SELECT ifnull(sum(usagevalue),0)as outqty FROM vouchertran WHERE voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getusage.voucherno#">
and type in('DO','Transfer')
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
and wos_date < "#dateformat(ndate,'YYYY-MM-DD')#"
<cfelse>
and wos_date < "1980-12-31"
</cfif>
</cfquery>

<cfquery name="getinqty" datasource="#dts#">
SELECT ifnull(sum(usagevalue),0) as inqty FROM vouchertran WHERE voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getusage.voucherno#">
and type in('CN','Transfer')
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
and wos_date < "#dateformat(ndate,'YYYY-MM-DD')#"
<cfelse>
and wos_date < "1980-12-31"
</cfif>
</cfquery>


<td align="right">#numberformat(getusage.value-getoutqty.outqty+getinqty.inqty,',.__')#</td>
<cfset balance=getusage.value-getoutqty.outqty+getinqty.inqty>
</tr>
<cfquery name="getvouchertran" datasource="#dts#">
SELECT * FROM vouchertran WHERE voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getusage.voucherno#">
<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i"  or lcase(hcomid) eq "mfssmy_i">
and type in('DO','CN','Transfer')
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
and wos_date between "#dateformat(ndate,'YYYY-MM-DD')#" and "#dateformat(ndate1,'YYYY-MM-DD')#"
</cfif>

</cfif><!---
group by refno--->
order by wos_date
</cfquery>
<cfloop query="getvouchertran">
<tr>
<td></td>
<td>#dateformat(getvouchertran.wos_date,'YYYY-MM-DD')#</td>
<td>#getvouchertran.type#-#getvouchertran.refno#</td>
<cfif getvouchertran.type eq 'DO'>
<td align="right">#numberformat(val(getvouchertran.usagevalue) * -1,',.__')#</td>
<cfelse>
<td align="right">#numberformat(val(getvouchertran.usagevalue) * -1,',.__')#</td>
</cfif>
<cfif getvouchertran.type eq 'DO'>
<cfset balance = balance - val(getvouchertran.usagevalue)>
<cfelse>
<cfset balance = balance - val(getvouchertran.usagevalue)>
</cfif>
<td align="right">#numberformat(val(balance),',.__')#</td>
</tr>
</cfloop>
<tr>
<td colspan="100%"><hr /></td>
</tr>
</cfloop>
 <tr> 
      <td height="80">&nbsp;</td>
      <td></td>
    </tr>
    <tr> 
      <td height="2">_____________________</td>
      <td></td>
    </tr>
    <tr> 
      <td><font face="Times New Roman, Times, serif"><font size="2">Customer Chop & Signature</font></font></td>
      <td nowrap></td>
    </tr>
    <tr>
    <td colspan="100%" height="2" align="center"><strong>Thank You!</strong></td>
    </tr>
</table>
</cfoutput>
</html>
