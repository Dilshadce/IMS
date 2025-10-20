<html>
<head>
<title>Post to UBS System</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="typesubmit" default="">
<cfparam name="post" default="">
<cfparam name="posttype" default="">
<cfparam name="export" default="">

<cfquery datasource='#dts#' name="getaccno">
	select * from gsetup
</cfquery>
<cfquery name="getcust" datasource="#dts#">
	select custno, name from #target_arcust# order by custno
</cfquery>
<body>
	
	<h4> 
		<a href="posting.cfm">View Posting Main Menu</a> ||
  		<a href="postingacc.cfm?status=UNPOSTED">View Accounting Post Menu</a> || 
		<a href="postingstk.cfm?status=UNPOSTED">View Inventory Post Menu</a> 		
	</h4>
<h1 align="center">Inventory Post Menu</h1>
<h3 align="center"><a href="postingstk.cfm?status=Unposted">Unposted Transaction</a>&nbsp;|| 
  <a href="postingstk.cfm?status=Posted">Posted Transaction</a> || <cfoutput><a href="..\download\#dts#\glpost9.csv">Download Exported File</a></cfoutput></h3>
<h3>Status : <cfoutput>#status#</cfoutput></h3>
<cfform action="postingstk.cfm?status=#url.status#" method="post" name="form">
  <div align="center"> 
    <input type="radio" name="posttype" value="INV"<cfif posttype eq "INV">checked</cfif>>
    Invoice 
    <input type="radio" name="posttype" value="CN"<cfif posttype eq "CN">checked</cfif>>
    Credit Note 
    <input type="radio" name="posttype" value="DN"<cfif posttype eq "DN">checked</cfif>>
    Debit Note 
    <input type="radio" name="posttype" value="RC"<cfif posttype eq "RC">checked</cfif>>
    Purchase Receive 
    <input type="radio" name="posttype" value="CS"<cfif posttype eq "CS">checked</cfif>>
    Cash Sales 
    <input type="radio" name="posttype" value="PR"<cfif posttype eq "PR">checked</cfif>>
    Purchase Return &nbsp; </div>
  <p><strong>Sort by</strong> : 
    <cfif isdefined("form.sort") and form.sort neq "">
      <cfset xsort = "#form.sort#">
      <cfelse>
      <cfset xsort = "">
    </cfif>
    <select name="Sort">
      <option value="">-</option>
      <option value="trxdate"<cfif xsort eq "trxdate">selected</cfif>>Date</option>
      <option value="period"<cfif xsort eq "period">selected</cfif>>Period</option>
      <option value="trxbillno"<cfif xsort eq "trxbillno">selected</cfif>>Billno</option>
      <option value="custno"<cfif xsort eq "custno">selected</cfif>>Customer 
      No</option>
    </select>
    &nbsp; 
    <input type="submit" name="typesubmit" value="Sort">
  </p>
  <cfif isdefined("form.sort")>
    <cfif form.sort eq "trxdate">
      <cfif isdefined("form.datefrom") and isdefined ("form.dateto")>
        <cfset xdatefrom = "#form.datefrom#">
        <cfset xdateto = "#form.dateto#">
        <cfelse>
        <cfset xdatefrom = "">
        <cfset xdateto = "">
      </cfif>
      Date From 
      <cfinput type="text" name="datefrom" size="10" maxlength="10" value="#xdatefrom#" required="yes" validate="eurodate">
      Date To 
      <cfinput type="text" name="dateto" size="10" maxlength="10"  value="#xdateto#"required="yes" validate="eurodate">
      <input type="submit" name="submit" value="Go">
      <cfelseif form.sort eq "period">
      <cfif isdefined("form.period")>
        <cfset xperiod = "#form.period#">
        <cfelse>
        <cfset xperiod = "">
      </cfif>
      Period 
      <cfinput type="text" name="period" size="10" maxlength="2" value="#xperiod#" required="yes" validate="integer">
      <input type="submit" name="submit2" value="Go">
      <cfelseif form.sort eq "trxbillno">
      <cfif isdefined("form.billnofrom") and isdefined("form.billnoto")>
        <cfset xbillnofrom="#form.billnofrom#">
        <cfset xbillnoto="#form.billnoto#">
        <cfelse>
        <cfset xbillnofrom="">
        <cfset xbillnoto="">
      </cfif>
      <cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
        <cfset xcustnofrom="#form.custnofrom#">
        <cfset xcustnoto="#form.custnoto#">
        <cfelse>
        <cfset xcustnofrom="">
        <cfset xcustnoto="">
      </cfif>
      Bill No From 
      <cfinput type="text" name="billnofrom" size="10" maxlength="7"  value="#xbillnofrom#"required="yes" validate="integer">
      Bill No To 
      <cfinput type="text" name="billnoto" size="10" maxlength="7" value="#xbillnoto#" required="yes" validate="integer">
      <br>
      Customer No From 
      <select name="custnofrom">
        <option value="">Choose a customer</option>
        <cfoutput query="getcust"> 
          <option value="#custno#"<cfif custno eq #xcustnofrom#>selected</cfif>>#custno# 
          - #name#</option>
        </cfoutput> 
      </select>
      <br>
      Customer No To &nbsp;&nbsp; 
      <select name="custnoto">
        <option value="">Choose a customer</option>
        <cfoutput query="getcust"> 
          <option value="#custno#"<cfif custno eq #xcustnoto#>selected</cfif>>#custno# 
          - #name#</option>
        </cfoutput> 
      </select>
      <input type="submit" name="submit3" value="Go">
      <cfelseif form.sort eq "Custno">
      <cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
        <cfset xcustnofrom="#form.custnofrom#">
        <cfset xcustnoto="#form.custnoto#">
        <cfelse>
        <cfset xcustnofrom="">
        <cfset xcustnoto="">
      </cfif>
      Customer No From 
      <cfinput type="text" name="custnofrom" size="10" value="#xcustnofrom#" maxlength="8" required="yes">
      Customer No To 
      <cfinput type="text" name="custnoto" size="10" value="#xcustnoto#" maxlength="8" required="yes">
	  <input type="submit" name="submit4" value="Go">
    </cfif>
  </cfif>   
  <cfif status eq "unposted">
    <br><br>
	<div align="center">
    <input type="submit" name="post" value="Post">
    &nbsp; 
    <input type="submit" name="export" value="Export">
  </div>
  </cfif> 
</cfform>
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
<cfset dd=dateformat(form.datefrom, "DD")>		
		<cfif dd greater than '12'>
			<cfset ndatefrom=dateformat('#form.datefrom#',"YYYY-MM-DD")>
		<cfelse>
			<cfset ndatefrom=dateformat('#form.datefrom#',"YYYY-DD-MM")>
		</cfif>
	<cfset dd=dateformat(form.dateto, "DD")>		
		<cfif dd greater than '12'>
			<cfset ndateto=dateformat('#form.dateto#',"YYYY-MM-DD")>
		<cfelse>
			<cfset ndateto=dateformat('#form.dateto#',"YYYY-DD-MM")>
		</cfif>
	<cfif isdefined ("form.posttype")>
	<cfif status eq "unposted">
		<cfquery datasource="#dts#" name="gettran">
			Select * from artran where wos_date >='#ndatefrom#' and wos_date <='#ndateto#' and posted = "" and type = '#form.posttype#' group by refno order by type,refno
		</cfquery>
	<cfelse>
		<cfquery datasource="#dts#" name="gettran">
			Select * from artran where wos_date >='#ndatefrom#' and wos_date <='#ndateto#' and posted = "P" and type = '#form.posttype#' group by refno order by type,refno
		</cfquery>
	</cfif>
	
	<cfelse>
	<h3>Please select at least one type of document to post.</h3>
	<cfabort>
	</cfif>
	
<cfelseif isdefined("form.period")>
	<cfif isdefined ("form.posttype")>
	<cfquery datasource="#dts#" name="gettran">
		Select * from artran where fperiod = '#form.period#' and posted = "" and type = '#form.posttype#' group by refno order by type,refno
	</cfquery>	
	
	<cfelse>
	<h3>Please select at least one type of document to post.</h1>
	<cfabort>
	</cfif>
<cfelseif isdefined("form.billnofrom") and isdefined("form.billnoto") and form.custnofrom neq "" and form.custnoto neq "">
	<cfif isdefined ("form.posttype")>
	<cfif status eq "unposted">
		<cfquery datasource="#dts#" name="gettran">
		Select * from artran where refno >= '#form.billnofrom#' and refno <= '#form.billnoto#' 
		and custno >= '#form.custnofrom#' and custno <= '#form.custnoto#'
		and posted = "" and type = '#form.posttype#' group by refno order by type,refno
		</cfquery>
	<cfelse>
		<cfquery datasource="#dts#" name="gettran">
		Select * from artran where refno >= '#form.billnofrom#' and refno <= '#form.billnoto#' 
		and custno >= '#form.custnofrom#' and custno <= '#form.custnoto#'
		and posted = "P" and type = '#form.posttype#' group by refno order by type,refno
		</cfquery>
	</cfif>
	
	
	<cfelse>
	<h3>Please select at least one type of document to post.</h1>
	<cfabort>
	</cfif>
<cfelseif isdefined("form.billnofrom") and isdefined("form.billnoto")>
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				Select * from artran where refno >= '#form.billnofrom#' and refno <= '#form.billnoto#' 
				and posted = "" and type = '#form.posttype#' group by refno order by type,refno
			</cfquery>
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				Select * from artran where refno >= '#form.billnofrom#' and refno <= '#form.billnoto#' 
				and posted = "P" and type = '#form.posttype#' group by refno order by type,refno
			</cfquery>
		</cfif>
	
	<cfelse>
	<h3>Please select at least one type of document to post.</h1>
	<cfabort>
	</cfif>	
	
	
<cfelseif isdefined("form.custnofrom") and isdefined("form.custnoto")>
	<cfif isdefined ("form.posttype")>
	<cfif status eq "unposted">
		<cfquery datasource="#dts#" name="gettran">
		Select * from artran where custno >= '#form.custnofrom#' and custno <= '#form.custnoto#' 
		and posted = "" and type = '#form.posttype#' group by refno order by type,refno
		</cfquery>	
	<cfelse>
		<cfquery datasource="#dts#" name="gettran">
		Select * from artran where custno >= '#form.custnofrom#' and custno <= '#form.custnoto#' 
		and posted = "P" and type = '#form.posttype#' group by refno order by type,refno
		</cfquery>	
	</cfif>
	
	<cfelse>
	<h3>Please select at least one type of document to post.</h1>
	<cfabort>
	</cfif>
<cfelse>
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				Select * from artran where posted = "" and type = '#form.posttype#' group by refno order by type,refno
			</cfquery>
		
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				Select * from artran where posted = "P" and type = '#form.posttype#' group by refno order by type,refno
			</cfquery>		
		</cfif>
		
	<cfelse>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
			Select * from artran where posted = "" and type <> 'DO' and type <> 'PO'and type <> 'SO'
			and type <> 'QUO' group by refno order by type,refno
			</cfquery>
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
			Select * from artran where posted = "P" and type <> 'DO' and type <> 'PO'and type <> 'SO'
			and type <> 'QUO' group by refno order by type,refno
			</cfquery>
		</cfif>
	</cfif>
</cfif>


<!--- <cfif typesubmit eq "Sort"> --->
<!--- <cfif #status# eq "POSTED">
	<cfif isdefined ("form.posttype")>
		<cfquery datasource="#dts#" name="gettran">
			Select * from artran where posted = "P" and type = '#form.posttype#' group by refno order by type,refno
		</cfquery>
	<cfelse>
		<cfquery datasource="#dts#" name="gettran">
			Select * from artran where posted = "P" group by refno order by type,refno
		</cfquery>
	</cfif>	
</cfif> --->

<cfif export eq "export">
	<cfquery datasource='#dts#' name="checkexist">
		select * from glpost9
	</cfquery>
	<cfif checkexist.recordcount eq 0>
		<h1>No Posted Record!</h1>
		<cfabort>
	</cfif>
	
	<cffile action = "delete" file = "C:\\CFusionMX\\wwwroot\\wos\\download\\glpost9.csv">
	
	<cfquery name="outfile" datasource="#dts#">		
		select * into outfile 'C:\\CfusionMX\\wwwroot\\wos\\download\\glpost9.csv' fields terminated by ',' enclosed by '"' lines terminated by '\r\n' from glpost9 		
	</cfquery>
	<cfquery datasource='#dts#' name="deletepreviouspost">
		delete from glpost9
	</cfquery>
	<h1>You have exported the transaction successfully.</h1>	
	
</cfif>

<table class="data" width="100%">
<tr>
	<th>Reference No</th>
	<th>Date</th>
	<th>Total</th>
	<th>GST Type</th>
	<th>GST</th>
	<th>Period</th>
	<th>Account</th>
	<th>Column</th>
	<th>Customer</th>
</tr>

<cfset cnt = #gettran.recordcount#>
<cfif gettran.recordcount gt 0>
	<cfloop query="gettran" startrow="1" endrow="#cnt#">
	<cfoutput>
		<cfquery name="getictran" datasource="#dts#">
			select sum(amt) as amtt,type,refno,fperiod,custno,wos_date,currrate from ictran where refno = '#gettran.refno#' and type = '#gettran.type#' group by refno
		</cfquery>
		<cfloop query="getictran">
		<tr>
			<td>#getictran.refno#</td>
			<td>#dateformat(getictran.wos_date,"dd/mm/yyyy")#</td>
			<td>#getictran.amtt#</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>#getictran.fperiod#</td>
			<td>#getictran.custno#</td>
			<cfif #getictran.type# eq 'RC'>
				<cfset acctype = "Cr">
				<cfquery datasource="#dts#" name="getcustname">
					Select name from #target_apvend# where custno = "#getictran.custno#"
				</cfquery>				
			<cfelse>				
				<cfset acctype = "D">
				<cfquery datasource="#dts#" name="getcustname">
					Select name from #target_arcust# where custno = "#getictran.custno#"
				</cfquery>
			</cfif>				
			<td>#acctype#</td>
			
			<td>#getcustname.name#</td>						
		</tr>
		<cfif post eq "post">
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9(accno,fperiod,date,reference,desp,debitamt,exc_rate)			
				values('#custno#','#fperiod#','#dateformat(wos_date,"dd/mm/yy")#','#refno#',
				'#getcustname.name#','#amtt#','#currrate#')
			</cfquery>
		</cfif>		
		</cfloop>
		<cfquery name="getdetails" datasource="#dts#">
			select * from ictran where refno = '#gettran.refno#' and type = '#gettran.type#'
		</cfquery>
		
		<cfloop query="getdetails">
			<cfif getdetails.type eq 'INV'>
				<cfset accno = "#getaccno.creditsales#">
			<cfelseif getdetails.type eq 'DN'>
				<cfset accno = "#getaccno.creditsales#">
			<cfelseif getdetails.type eq 'CN'>
				<cfset accno = "#getaccno.salesreturn#">
			<cfelseif getdetails.type eq 'PR'>
				<cfset accno = "#getaccno.purchasereturn#">
			<cfelseif getdetails.type eq 'RC'>
				<cfset accno = "#getaccno.purchasereceive#">
			<cfelseif getdetails.type eq 'CS'>
				<cfset accno = "#getaccno.cashsales#">		
			</cfif>
			<cfif getdetails.taxamt neq 0>
				<cfset gsttype = 'STAX'>
			<cfelse>
				<cfset gsttype = 'ZR'>
			</cfif>
		
			<cfquery name="inserttemp" datasource="#dts#">
				insert into temptrx (trxbillno, accno, itemno, trxbtype,trxdate,period, currrate,custno, 
				amount, gst, gstamt2,gsttype)
				values('#refno#','#accno#','#itemno#','#type#',#wos_date#,'#fperiod#','#currrate#',
				'#custno#','#amt#','#taxpec1#','#taxamt#','#gsttype#')
			</cfquery>		
		</cfloop>
		<cfquery name="gettemp" datasource="#dts#">
			select trxbillno,accno, itemno, trxbtype,trxdate, period,currrate,custno,
			sum(amount)as amtt, gst, gsttype from temptrx group by accno, gsttype order by gsttype desc
		</cfquery>
		
		<cfloop query="gettemp">
		
		<cfoutput>
		<tr>
			<td>#gettemp.trxbillno#</td>
			<td>#dateformat(gettemp.trxdate,"dd/mm/yyyy")#</td>
			<td>#gettemp.amtt#</td>		
			<td>#gettemp.gsttype#</td>
			<td>&nbsp;</td>
			<td>#gettemp.period#</td>
			<td>#gettemp.accno#</td>
			<cfif gettemp.trxbtype eq 'RC'>
				<cfset acctype = "D">
				<cfquery datasource="#dts#" name="getcustname">
				Select name from #target_apvend# where custno = "#gettemp.custno#"
			</cfquery>				
			<cfelse>
				<cfset acctype = "Cr">
				<cfquery datasource="#dts#" name="getcustname">
				Select name from #target_arcust# where custno = "#gettemp.custno#"
			</cfquery>				
			</cfif>				
			<td>#acctype#</td>
			
			<td>#getcustname.name#</td>
		</tr>		
		</cfoutput>
		<cfif post eq "post">
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost9(accno,fperiod,date,reference,desp,creditamt,fcamt,
				exc_rate,rem4)			
				values('#accno#','#period#','#dateformat(trxdate,"dd/mm/yy")#','#trxbillno#','#itemno#',
				'#amtt#','-#amtt#','#currrate#','#gsttype#')
			</cfquery>
		</cfif>
		</cfloop>
		<cfquery name="getgst" datasource="#dts#">
			select sum(gstamt2)as gstt, trxbillno, accno, itemno,custno,trxbtype,trxdate,period,currrate,gst,gsttype from temptrx 
			where gsttype = 'STAX' and trxbtype = 'RC' group by gsttype
		</cfquery>	
	
	<cfif getgst.recordcount gt 0>	<!--- insert only when have gst amount --->
	<cfoutput>
	<tr>
		<td>#getgst.trxbillno#</td>
		<td>#dateformat(getgst.trxdate,"dd/mm/yyyy")#</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>		
		<td>#getgst.gstt#</td>
		<td>#getgst.period#</td>	
		<cfif getgst.trxbtype eq 'RC'>
			<cfset acctype = "D">
			<cfset xaccno = #getaccno.gstpurchase#>
			<cfquery datasource="#dts#" name="getcustname">
				Select name from #target_apvend# where custno = "#getgst.custno#"
			</cfquery>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset xaccno = #getaccno.gstsales#>
			<cfquery datasource="#dts#" name="getcustname">
				Select name from #target_arcust# where custno = "#getgst.custno#"
			</cfquery>
		</cfif>
		<td>#xaccno#</td>				
		<td>#acctype#</td>
		
		<td>#getcustname.name#</td>
	</tr>	
	</cfoutput>
		<cfif post eq "post">
		<cfif getgst.gstt eq "" or getgst.gstt eq 0>
			<cfset minusgstt = "">
		<cfelse>
			<cfset minusgstt = "-#gstt#">
		</cfif>
		<cfquery name="insertpost3" datasource="#dts#">
			insert into glpost9(accno,fperiod,date,reference,desp,creditamt,fcamt,
			exc_rate,rem4)			
			values('#xaccno#','#getgst.period#','#dateformat(getgst.trxdate,"dd/mm/yy")#',
			'#getgst.trxbillno#','#getgst.itemno#','#getgst.gstt#','#minusgstt#',
			'#getgst.currrate#','#getgst.gsttype#')
		</cfquery>		
	</cfif>
	</cfif>
	<cfquery name="getgst2" datasource="#dts#">
		select sum(gstamt2)as gstt, trxbillno, accno, itemno,custno,trxbtype,trxdate,period,currrate, gst,gsttype from temptrx 
		where gsttype = 'STAX' and trxbtype <> 'RC' group by gsttype
	</cfquery>
	
	<cfif getgst2.recordcount gt 0>	<!--- insert only when have gst amount --->
	<cfoutput>	
	<tr>
		<td>#getgst2.trxbillno#</td>
		<td>#dateformat(getgst2.trxdate,"dd/mm/yyyy")#</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>		
		<td>#getgst2.gstt#</td>
		<td>#getgst2.period#</td>	
				
		<cfif getgst2.trxbtype eq 'RC'>
			<cfset acctype = "D">
			<cfset xaccno = #getaccno.gstpurchase#>
			<cfquery datasource="#dts#" name="getcustname">
				Select name from #target_apvend# where custno = "#getgst2.custno#"
			</cfquery>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset xaccno = #getaccno.gstsales#>
			<cfquery datasource="#dts#" name="getcustname">
				Select name from #target_arcust# where custno = "#getgst2.custno#"
			</cfquery>
		</cfif>
		<td>#xaccno#</td>				
		<td>#acctype#</td>
		
		<td>#getcustname.name#</td>
	</tr>
	</cfoutput>
		<cfif post eq "post">
		<cfif getgst2.gstt eq "" or getgst2.gstt eq 0>
			<cfset minusgstt = "">
		<cfelse>
			<cfset minusgstt = "-#gstt#">
		</cfif>
		<cfquery name="insertpost4" datasource="#dts#">
			insert into glpost9(accno,fperiod,date,reference,desp,creditamt,fcamt,
			exc_rate,rem4)			
			values('#xaccno#','#getgst2.period#','#dateformat(getgst2.trxdate,"dd/mm/yy")#','#getgst2.trxbillno#',
			'#getgst2.itemno#','#getgst2.gstt#','#minusgstt#',
			'#getgst2.currrate#','#getgst2.gsttype#')
		</cfquery>		
		</cfif>
		
	</cfif>	
	<cfquery name="deltemp" datasource="#dts#">
		delete from temptrx
	</cfquery>
	</cfoutput>	
	</cfloop>
<!--- </cfif> --->
</table>
Total of Transactions: <cfoutput>#gettran.recordcount#</cfoutput>
</cfif>
<cfif post eq "post">
<cfquery name="getbill" dbtype="query">
	select distinct refno from gettran
</cfquery>
<cfoutput>#getbill.recordcount#</cfoutput>
<cfloop query="getbill">
	<cfquery name="updatetrxbill" datasource="#localdb#">
	update artran set posted = 'P' where refno = '#getbill.refno#'
	</cfquery>  
</cfloop>

<h1>You have done the posting successfully.</h1>
</cfif>

</body>
</html>
