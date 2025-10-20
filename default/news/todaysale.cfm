<cfsetting showdebugoutput="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="news.css" rel="stylesheet" type="text/css" />
<title>Untitled Document</title>
</head>

<body>
<table class="tcontent">
<cfquery name="gettodaysale" datasource="#dts#">
    select sum(grand) as grand,sum(invgross) as gross,sum(net) as net,sum(discount) as discount,sum(tax) as tax,sum(cs_pm_cash) as cash,sum(cs_pm_cheq) as cheq,sum(cs_pm_crcd) as crcd,sum(cs_pm_crc2) as crc2,sum(cs_pm_vouc) as vouc,sum(cs_pm_dbcd) as dbcd
    from artran where wos_date='#dateformat(now(),'yyyy-mm-dd')#' and type in ('inv','cs') and (void is null or void='')
    </cfquery>
<tr>
<td colspan="2" style="font-size:24px">
<strong>Sales Record</strong>
</td>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Gross Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.gross,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Discount Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.discount,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Net Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.net,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Tax Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.tax,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Grand Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.grand,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td colspan="2" style="font-size:24px">
<strong>Collection Record</strong>
</td>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Cash :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.cash,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Credit Card Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.crcd,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Debit Card Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.dbcd,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Cheque Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.cheq,',_.__')#</td>
</cfoutput>
</tr>
<tr>
<td class="tabletitle1" style="font-size:24px">Voucher Total :</td>
<cfoutput>
<td class="tabletitle1" style="font-size:24px">#numberformat(gettodaysale.vouc,',_.__')#</td>
</cfoutput>
</tr>

<!---
<cfoutput>
    <cfquery name="gettodaysale" datasource="#dts#">
    select refno, custno, created_on
    from artran
    order by created_on desc
    limit 10
    </cfquery>
    <cfloop query="gettodaysale">
    	<tr class="tablecontentrow1">
        <td class="tablecontent1" width="100px">#refno#</td>
        <td class="tablecontent1" width="200px">#custno#</td>
        <td class="tablecontent1" width="120px">#dateformat(created_on,"dd/mm/yyyy")#</td>
        </tr>
    </cfloop>
    
</cfoutput>
--->
</table>

</body>
</html>
