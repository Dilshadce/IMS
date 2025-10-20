<html>
<head>
<title>Outstanding Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="totalorderqty" default="0">
<cfparam name="totalrcqty" default="0">
<cfparam name="totaloutstand" default="0">
<cfparam name="totalamt" default="0">
<cfparam name="totalrightamt" default="0">
<cfparam name="ttgross" default="0">
<cfparam name="row" default="0">
<body>

<cfif type eq 'DO'>
	<cfquery name="getheader" datasource="#dts#">
		select refno,type,custno,name,invgross,wos_date from artran where type = 'DO' and toinv = ''
		<cfif custfrom neq "" and custto neq "">and custno >= '#custfrom#' and custno <= '#custto#'</cfif>
		<cfif refnofrom neq "" and refnoto neq "">and refno >= '#refnofrom#' and refno <= '#refnoto#'</cfif>
		order by refno
	</cfquery>
	<h1 align="center">Outstanding DO</h1>
	<cfset ttype = 'DO'>
</cfif>

<cfif type eq 'QUO'>
	<cfquery name="getheader" datasource="#dts#">
		select refno,type,custno,name,invgross,wos_date from artran where type = 'QUO' and toinv = '' 
		<cfif custfrom neq "" and custto neq "">and custno >= '#custfrom#' and custno <= '#custto#'</cfif>
		<cfif refnofrom neq "" and refnoto neq "">and refno >= '#refnofrom#' and refno <= '#refnoto#'</cfif>
		order by refno
	</cfquery>
	<h1 align="center">Outstanding Quotation</h1>
	<cfset ttype = 'QUO'>
</cfif>

<cfif type eq '3'>
	<cfquery name="getheader" datasource="#dts#">
		select refno,type,custno,name,invgross,wos_date from artran where type = 'PO' and toinv = '' 
		<cfif custfrom neq "" and custto neq "">and custno >= '#custfrom#' and custno <= '#custto#'</cfif>
		<cfif refnofrom neq "" and refnoto neq "">and refno >= '#refnofrom#' and refno <= '#refnoto#'</cfif>
		order by refno
	</cfquery>
	<h1 align="center">Outstanding PO Status</h1>
	<cfset ttype = 'PO'>
</cfif>

<cfif type eq '4'>
	<cfquery name="getheader" datasource="#dts#">
		select a.refno,a.type,a.custno,a.name,a.invgross,a.wos_date,
		b.brem1,b.brem2 from artran a, ictran b where a.refno = b.refno and 
		a.type = b.type and a.type = 'PO' and a.toinv = '' 
		<cfif custfrom neq "" and custto neq "">and a.custno >= '#custfrom#' and a.custno <= '#custto#'</cfif>
		<cfif refnofrom neq "" and refnoto neq "">and a.refno >= '#refnofrom#' and a.refno <= '#refnoto#'</cfif>
		order by b.brem1
	</cfquery>
	<h1 align="center">Outstanding PO Details</h1>
	<cfset ttype = 'PO'>
	<cfset ttype2= 'RC'>
</cfif>

<cfif type eq '5'>
	<cfquery name="getheader" datasource="#dts#">
		select refno,type,custno,name,invgross,wos_date,exported from artran where type = 'SO' and toinv ='' 
		<cfif custfrom neq "" and custto neq "">and custno >= '#custfrom#' and custno <= '#custto#'</cfif>
		<cfif refnofrom neq "" and refnoto neq "">and refno >= '#refnofrom#' and refno <= '#refnoto#'</cfif>
		order by refno
	</cfquery>
	<h1 align="center">Outstanding SO Status</h1>
	<cfset ttype = 'SO'>
</cfif>

<cfif type eq '6'>
	<cfquery name="getheader" datasource="#dts#">
		select a.refno,a.type,a.custno,a.name,a.invgross,a.wos_date,
		b.brem1,b.brem2,b.exported from artran a, ictran b where a.refno = b.refno and a.type = b.type and
		a.type = 'SO' and a.toinv = '' 
		<cfif custfrom neq "" and custto neq "">and a.custno >= '#custfrom#' and a.custno <= '#custto#'</cfif>
		<cfif refnofrom neq "" and refnoto neq "">and a.refno >= '#refnofrom#' and a.refno <= '#refnoto#'</cfif>
		order by b.brem1
	</cfquery>
	<h1 align="center">Outstanding SO Details</h1>
	<cfset ttype = 'SO'>
	<cfset ttype2= 'INV'>
</cfif>

<cfif type eq '7'>
	<cfquery name="getheader" datasource="#dts#">
		select refno,type,custno,name,invgross,wos_date from artran where type = 'SO' and exported = '' 
		<cfif form.custfrom neq "" and form.custto neq "">and custno >='#form.custfrom#' and custno <='#form.custto#'</cfif>
		<cfif form.refnofrom neq "" and form.refnoto neq "">and refno >='#form.refnofrom#' and refno <='#form.refnoto#'</cfif> order by refno
	</cfquery>
	<h1 align="center">Outstanding SO to PO</h1>
	<cfset ttype = 'SO'>
	<cfset ttype2= 'PO'>
</cfif>

<cfif url.type eq 'DO'>

  <table width="90%" border="0" class="data" align="center" cellspacing="0" cellpadding="3">
    <tr> 
      <th>Type</th>
      <th>Date</th>
      <th>Ref No.</th>
      <th>Customer</th>
      <th>Gross</th>
      <th>Qty</th>
      <th>Price</th>
      <th>Amount</th>
    </tr>
    <cfloop query="getheader">
	<cfif invgross neq "">
		<cfset xgross = invgross>
	<cfelse>
		<cfset xgross = 0>
	</cfif>
	
      <cfoutput> 
        <tr> 
          <td>#type#</td>
          <td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          <td nowrap>#refno#</td>
          <td nowrap>#custno# - #name#</td>
          <td><div align="right">#numberformat(xgross,".__")#</div></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
		<cfset ttgross = ttgross + xgross>
      </cfoutput> 
      <cfquery name="getbody" datasource="#dts#">
      select qty,price,amt,itemno from ictran where refno = '#refno#' and type 
      = '#ttype#' 
      </cfquery>
      <cfoutput query="getbody"> 
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td colspan="3">#Itemno#</td>
          <td><div align="center">#qty#</div></td>
          <td><div align="right">#numberformat(price,".__")#</div></td>
          <td><div align="right">#numberformat(amt,".__")#</div></td>
        </tr>
        <cfset totalamt = totalamt + amt>
        <cfset totalorderqty = totalorderqty + qty>
      </cfoutput> 
      <tr> 
        <td colspan="8"><hr></td>
      </tr>
	  <cfset row = row + 1>
    </cfloop>
	<cfoutput>
    <tr bgcolor="##83B8ED"> 
      <td colspan="3">No of Records : #row#</td>
	  <td><div align="right">Total</div></td>
	  <td><div align="right">#numberformat(ttgross,".__")#</div></td>
      <td><div align="center">#totalorderqty#</div></td>
      <td><div align="right"></div></td>
      <td><div align="right">#numberformat(totalamt,".__")#</div></td>
    </tr></cfoutput>
  </table>
  
<cfelseif url.type eq '4' or url.type eq '6' or url.type eq '7'>

  <table width="95%" border="0" class="data" align="center" cellspacing="0" cellpadding="3">
    <tr> 
      <th>Type</th>
      <th>Date</th>
      <th>Ref No.</th>
      <th nowrap> <cfif type eq 'PO'>
          Supplier 
          <cfelse>
          Customer </cfif></th>
      <th>Qty Ordered</th>
      <cfoutput> 
        <th>#ttype2# Date</th>
        <th>#ttype2# No</th>
      </cfoutput> 
      <cfif url.type eq '7'>
        <th><cfoutput>#ttype2#</cfoutput> Req Date/C.firm Date</th>
      </cfif>
      <th><cfif ttype2 eq 'RC' or ttype2 eq 'PO'>
          Qty Ordered 
          <cfelse>
          Qty Shipped</cfif></th>
      <th>Qty Outstanding</th>
    </tr>
    <cfloop query="getheader">
      <cfoutput> 
        <tr> 
          <td>#type#</td>
          <td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          <td nowrap>#refno#</td>
          <td colspan="3" nowrap>#custno# - #name#</td>
          <cfif url.type eq '7'>
            <td>&nbsp;</td>
          </cfif>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </cfoutput> 
      <cfquery name="getbody" datasource="#dts#">
      select refno,qty,price,amt,itemno,brem1,brem2,exported from ictran where refno = 
      '#refno#' and type = '#ttype#' and toinv = '' 
      </cfquery>
      <cfloop query="getbody">
        <cfset totalrcqty = 0>
        <cfif getbody.qty neq "">
          <cfset orderqty = #getbody.qty#>
          <cfelse>
          <cfset orderqty = 0>
        </cfif>
        <cfquery name="getrcqty" datasource="#dts#">
        select refno,qty,price,amt,itemno,wos_date,dodate,brem1,brem2 from ictran 
        where dono = '#getbody.refno#' and itemno = '#itemno#' and type = '#ttype2#' 
        </cfquery>
        <cfif getrcqty.recordcount gt 0>
          <cfset cnt = 0>
          <cfoutput query="getrcqty">	
            <cfif getrcqty.qty neq "">
              <cfset rcqty = #getrcqty.qty#>
            <cfelse>
              <cfset rcqty = 0>
            </cfif>
            <cfset totalrcqty = totalrcqty + rcqty>
            <cfset outstand = #orderqty# - #totalrcqty#>
            <tr> 
              <td>&nbsp;</td>
			  <td nowrap><cfif cnt eq 0>
                  #Itemno#</cfif></td>
              <td>#getbody.exported#</td>              
              <td><cfif getbody.brem1 neq "" or getbody.brem2 neq "">
                  <cfif ttype2 eq 'RC'>
                    Req 
                    <cfelse>
                    Del 
                  </cfif>
                  Date #getbody.brem1#<br>
                  Cf Date #getbody.brem2#</cfif></td>
              <td><div align="center"> 
                  <cfif cnt eq 0>
                    #orderqty# 
                  </cfif>
                </div></td>
              <td>#dateformat(getrcqty.wos_date,"dd/mm/yy")#</td>
              <td>#getrcqty.refno#</td>
              <cfif url.type eq '7'>
                <td nowrap><cfif getrcqty.brem1 neq "" or getrcqty.brem2 neq "">
                    Req Date #getrcqty.brem1#<br>
                    Cf Date #getrcqty.brem2#</cfif></td>
              </cfif>
              <td><div align="center">#rcqty#</div></td>
              <td><div align="center">#outstand#</div></td>
            </tr>
            <cfset cnt = cnt + 1>
          </cfoutput> 
          <cfelse>
          <cfoutput> 
            <tr> 
              <td>&nbsp;</td>
			  <td nowrap>#getbody.Itemno#</td>
              <td>#getbody.exported#</td>             
              <td nowrap><cfif getbody.brem1 neq "" or getbody.brem2 neq "">
                  <cfif ttype2 eq 'RC'>
                    Req 
                    <cfelse>
                    Del 
                  </cfif>
                  Date #getbody.brem1#<br>
                  Cf Date #getbody.brem2#</cfif></td>
              <td><div align="center">#orderqty#</div></td>
              <td></td>
              <td></td>
              <cfif url.type eq '7'>
                <td></td>
              </cfif>
              <td><div align="center">0</div></td>
              <td><div align="center">#orderqty#</div></td>
            </tr>
          </cfoutput> 
        </cfif>
      </cfloop>
      <tr> 
        <td colspan="10"><hr></td>
      </tr>
    </cfloop>
  </table>

<cfelseif url.type eq 'QUO'>
  <table width="80%" border="0" class="data" align="center" cellspacing="0" cellpadding="3">
    <tr> 
      <th>Type</th>
      <th>Date</th>
      <th>Ref No.</th>
      <th>Customer</th>
      <th>Qty Quot </th>
      <th>Qty Sales </th>
      <th>Qty Outstanding </th>
      <th>Price</th>
    </tr>
    <cfloop query="getheader">
      <cfoutput> 
        <tr> 
          <td>#type#</td>
          <td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          <td nowrap>#refno#</td>
          <td colspan="3">#custno# - #name#</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </cfoutput> 
      <cfquery name="getbody" datasource="#dts#">
      select refno,qty,price,amt,itemno from ictran where refno = '#refno#' and 
      type = '#ttype#' 
      </cfquery>
      <cfoutput query="getbody">	
        <cfif getbody.qty neq "">
          <cfset orderqty = #getbody.qty#>
          <cfelse>
          <cfset orderqty = 0>
        </cfif>
        <cfquery name="getrcqty" datasource="#dts#">
        select sum(qty) as qty1 from ictran where dono = '#getbody.refno#' and 
        itemno = '#itemno#' and type = 'INV' 
        </cfquery>
        <cfif getrcqty.qty1 neq "">
          <cfset rcqty = #getrcqty.qty1#>
          <cfelse>
          <cfset rcqty = 0>
        </cfif>
        <cfset outstand = #orderqty# - #rcqty#>
        <cfset totaloutstand = totaloutstand + outstand>
        <cfset totalrcqty = totalrcqty + rcqty>
        <cfset totalorderqty = totalorderqty + orderqty>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td colspan="2">#Itemno#</td>
          <td><div align="center">#orderqty#</div></td>
          <td><div align="center">#rcqty#</div></td>
          <td><div align="center">#outstand#</div></td>
          <td><div align="right">#numberformat(amt,".__")#</div></td>
        </tr>
      </cfoutput> 
      <tr> 
        <td colspan="8"><hr></td>
      </tr>
    </cfloop>
    <cfoutput> 
      <tr bgcolor="##83B8ED"> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="2"><div align="right">Total</div></td>
        <td><div align="center">#totalorderqty#</div></td>
        <td><div align="center">#totalrcqty#</div></td>
        <td><div align="center">#totaloutstand#</div></td>
        <td><div align="right">&nbsp;</div></td>
      </tr>
    </cfoutput> 
  </table>
<cfelseif url.type eq '3'>
	
  <table width="80%" border="0" class="data" align="center" cellspacing="0" cellpadding="3">
    <tr> 
      <th>Type</th>
      <th>Date</th>
      <th>Ref No.</th>
      <th>Supplier</th>
      <th>Qty Ordered </th>
      <th>Request Date</th>
      <th>Qty Received</th>
      <th>Qty Outstanding </th>
      <th>Price</th>
    </tr>
    <cfloop query="getheader">
      <cfoutput> 
        <tr> 
          <td>#type#</td>
          <td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          <td nowrap>#refno#</td>
          <td colspan="3">#custno# - #name#</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </cfoutput> 
      <cfquery name="getbody" datasource="#dts#">
      select refno,qty,price,amt,itemno,brem1 from ictran where refno = '#refno#' 
      and type = '#ttype#' 
      </cfquery>
      <cfoutput query="getbody">	
        <cfif getbody.qty neq "">
          <cfset orderqty = #getbody.qty#>
          <cfelse>
          <cfset orderqty = 0>
        </cfif>
        <cfquery name="getrcqty" datasource="#dts#">
        select sum(qty) as qty1 from ictran where sono = '#getbody.refno#' and 
        itemno = '#itemno#' and type = 'RC' 
        </cfquery>
        <cfif getrcqty.qty1 neq "">
          <cfset rcqty = #getrcqty.qty1#>
          <cfelse>
          <cfset rcqty = 0>
        </cfif>
        <cfset outstand = #orderqty# - #rcqty#>
        <cfset totaloutstand = totaloutstand + outstand>
        <cfset totalrcqty = totalrcqty + rcqty>
        <cfset totalorderqty = totalorderqty + orderqty>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td colspan="2">#Itemno#</td>
          <td><div align="center">#orderqty#</div></td>
          <td><div align="center">#brem1#</div></td>
          <td><div align="center">#rcqty#</div></td>
          <td><div align="center">#outstand#</div></td>
          <td><div align="right">#numberformat(amt,".__")#</div></td>
        </tr>
      </cfoutput> 
      <tr> 
        <td colspan="9"><hr></td>
      </tr>
    </cfloop>
    <cfoutput> 
      <tr bgcolor="##83B8ED"> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="2"><div align="right">Total</div></td>
        <td><div align="center">#totalorderqty#</div></td>
        <td></td>
        <td><div align="center">#totalrcqty#</div></td>
        <td><div align="center">#totaloutstand#</div></td>
        <td><div align="right">&nbsp;</div></td>
      </tr>
    </cfoutput> 
  </table>

<cfelseif url.type eq '5'>

	
  <table width="85%" border="0" class="data" align="center" cellspacing="0" cellpadding="3">
    <tr> 
      <th>Type</th>
      <th>Date</th>
      <th nowrap>Ref No.</th>
      <th>PO No.</th>
      <th>Customer</th>
      <th>Qty Ordered </th>
      <th>Delivery Date</th>
      <th>Qty Delivered</th>
      <th>Qty Outstanding</th>
      <th>Price</th>
      <th>Amount</th>
    </tr>
    <cfloop query="getheader">
      <cfoutput> 
        <tr> 
          <td>#type#</td>
          <td><div align="center">#dateformat(wos_date,"dd/mm/yy")#</div></td>
          <td nowrap>#refno#</td>
          <td nowrap>&nbsp;</td>
          <td colspan="4">#custno# - #name#</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </cfoutput> 
      <cfquery name="getbody" datasource="#dts#">
      select refno,qty,price,amt,itemno,brem1,brem2,exported from ictran where refno = 
      '#refno#' and type = '#ttype#' and toinv = '' 
      </cfquery>
      <cfoutput query="getbody"> 
        <cfset ttoutstand = 0>
        <cfset ttrcqty = 0>
        <cfset ttorderqty = 0>
        <cfset ttrightamt = 0>
        <cfif getbody.price neq "">
          <cfset xprice = getbody.price>
          <cfelse>
          <cfset xprice = 0>
        </cfif>
        <cfif getbody.qty neq "">
          <cfset orderqty = #getbody.qty#>
          <cfelse>
          <cfset orderqty = 0>
        </cfif>
        <cfquery name="getrcqty" datasource="#dts#">
        select sum(qty) as qty1 from ictran where dono = '#getbody.refno#' and 
        itemno = '#itemno#' and type = 'INV' 
        </cfquery>
        <cfif getrcqty.qty1 neq "">
          <cfset rcqty = #getrcqty.qty1#>
          <cfelse>
          <cfset rcqty = 0>
        </cfif>
        <cfset outstand = #orderqty# - #rcqty#>
        <cfset rightamt = #outstand# * #xprice#>
        <cfset ttoutstand = ttoutstand + outstand>
        <cfset ttrcqty = ttrcqty + rcqty>
        <cfset ttorderqty = ttorderqty + orderqty>
        <cfset ttrightamt = ttrightamt + rightamt>
        <cfset totaloutstand = totaloutstand + outstand>
        <cfset totalrcqty = totalrcqty + rcqty>
        <cfset totalorderqty = totalorderqty + orderqty>
        <cfset totalrightamt = totalrightamt + rightamt>
        <tr> 
          <td>&nbsp;</td>
          <td colspan="2">#Itemno#</td>
          <td>#exported#</td>
          <td></td>
        
          <td><div align="center">#orderqty#</div></td>
          <td nowrap><div align="center">#brem1#</div></td>
          <td><div align="center">#rcqty#</div></td>
          <td><div align="center">#outstand#</div></td>
          <td><div align="right">#numberformat(xprice,".__")#</div></td>
          <td><div align="right">#numberformat(rightamt,".__")#</div></td>
        </tr>
      </cfoutput> <cfoutput> 
        <!--- <tr><td colspan="9"><hr></td></tr> --->
        <tr bgcolor="##83B8ED"> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td colspan="2">&nbsp;</td>
          <td></td>
          <td><div align="center">#ttorderqty#</div></td>
          <td></td>
          <td><div align="center">#ttrcqty#</div></td>
          <td><div align="center">#ttoutstand#</div></td>
          <td>&nbsp;</td>
          <td><div align="right">#numberformat(ttrightamt,".__")#</div></td>
        </tr>
        <tr> 
          <td colspan="11"><hr></td>
        </tr>
      </cfoutput> 
    </cfloop>
    <cfoutput> 
      <tr bgcolor="##659CE0"> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td></td>
        <td colspan="2"><div align="right">Total</div></td>
        <td><div align="center">#totalorderqty#</div></td>
        <td></td>
        <td><div align="center">#totalrcqty#</div></td>
        <td><div align="center">#totaloutstand#</div></td>
        <td>&nbsp;</td>
        <td><div align="right">#numberformat(totalrightamt,".__")#</div></td>
      </tr>
    </cfoutput> 
  </table><a href="../../../Jrun4/servers/cfusion/cfusion-ear/cfusion-war/IMS/dropdownmenu -new">dropdownmenu -new</a>

</cfif>



</body>
</html>
