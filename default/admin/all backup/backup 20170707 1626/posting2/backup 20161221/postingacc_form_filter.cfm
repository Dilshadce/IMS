<cfoutput>
<script type="text/javascript">
function submitform()
{
document.form1.submit()
}

function validatedate()
{
var datefrom = document.getElementById('datefrom').value;
		var dateto = document.getElementById('dateto').value;
		if (datefrom != "" && dateto != "")
		{
		if(datefrom.substring(3,5) !=dateto.substring(3,5))
		{
		alert('Cannot post more than one month');
		ColdFusion.Window.hide('processing');
		return false;
		
		}
		}
		
		if (datefrom == "" && dateto == "")
		{
		alert('Please select Date');
		ColdFusion.Window.hide('processing');
		return false;
		
		}
		ColdFusion.Window.show('processing');
		return true;
		
}

</script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<cfif isdefined('url.ubs')>
<cfset status = url.status>
<cfset url.status = url.status&"&ubs=yes">
</cfif>
<cfform action="postingacc.cfm?status=#url.status#" method="post" name="form1" onsubmit="return validatedate();">

<cfquery name="getbillname" datasource="#dts#">
select * from gsetup
</cfquery>
<input type="hidden" name="fromto" id="fromto" value="" />
<input type="hidden" name="billtype" id="billtype" value="#posttype#" />
<cfoutput>
    <input type="radio" name="posttype" value="INV"<cfif posttype eq "INV">checked</cfif> onclick="document.getElementById('billtype').value='INV'">
    #getbillname.linv# 
    <input type="radio" name="posttype" value="CN"<cfif posttype eq "CN">checked</cfif> onclick="document.getElementById('billtype').value='CN'">
    #getbillname.lCN# 
    <input type="radio" name="posttype" value="DN"<cfif posttype eq "DN">checked</cfif> onclick="document.getElementById('billtype').value='DN'">
    #getbillname.lDN# 
    <input type="radio" name="posttype" value="RC"<cfif posttype eq "RC">checked</cfif> onclick="document.getElementById('billtype').value='RC'">
    #getbillname.lRC# 
    <input type="radio" name="posttype" value="CS"<cfif posttype eq "CS">checked</cfif> onclick="document.getElementById('billtype').value='CS'">
    #getbillname.lCS# 
    <input type="radio" name="posttype" value="PR"<cfif posttype eq "PR">checked</cfif> onclick="document.getElementById('billtype').value='PR'">
    #getbillname.lPR#
</cfoutput>
	<p><strong>Sort by</strong> : 
    <cfif isdefined("form.sort") and form.sort neq "">
      	<cfset xsort = form.sort>
	<cfelse>
      	<cfset xsort = "">
    </cfif>
    
	<select name="sort" id="sort" >
      	<option value="-">-</option>
      	<option value="trxdate"<cfif xsort eq "trxdate">selected</cfif>>Date</option>
      	<option value="period"<cfif xsort eq "period">selected</cfif>>Period</option>
      	<option value="trxbillno"<cfif xsort eq "trxbillno">selected</cfif>>Billno</option>
     	<option value="custno"<cfif xsort eq "custno">selected</cfif>>Customer No</option>
		<option value="trxbillno2"<cfif xsort eq "trxbillno2">selected</cfif>>Ref No 2</option>
        <option value="billpay"<cfif xsort eq "billpay">selected</cfif>>Bill Paid</option>
    </select>&nbsp;
	 
    <input type="submit" name="typesubmit" value="Sort">
  	</p>
  	<div id="ajaxField" name="ajaxField">
	<cfif isdefined("form.sort")>
  		<cfif not isdefined("form.posttype")>
			<h3>Error: Please select one type of document to post.</h3>
			<cfabort>
		</cfif>
    	
		<cfif form.sort eq "trxdate">
			<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset xdatefrom = form.datefrom>
				<cfset xdateto = form.dateto>
			<cfelse>
				<cfset xdatefrom = "">
				<cfset xdateto = "">
			</cfif>
			Date From 
			<cfinput type="text" name="datefrom" size="10" maxlength="10" value="#xdatefrom#" required="yes" validate="eurodate">
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">
            Date To 
			<cfinput type="text" name="dateto" size="10" maxlength="10"  value="#xdateto#"required="yes" validate="eurodate">
            <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">
			<cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
			<cfset xcustnofrom  = form.custnofrom>
        	<cfset xcustnoto = form.custnoto>
      	<cfelse>
      	  	<cfset xcustnofrom = "">
        	<cfset xcustnoto = "">
      	</cfif>
      	
		Customer No From 
      	<cfinput type="text" name="custnofrom" id="custnofrom" size="10" value="#xcustnofrom#" maxlength="8">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />
        
      	Customer No To 
      	<cfinput type="text" name="custnoto" id="custnoto" size="10" value="#xcustnoto#" maxlength="8">
        <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />
            
			<input type="submit" name="submit" value="Go" onclick="ColdFusion.Window.show('processing');">
    	<cfelseif form.sort eq "period">
			<cfif isdefined("form.period")>
				<cfset xperiod = form.period>
			<cfelse>
				<cfset xperiod = "">
			</cfif>
			Period 
            
            <cfquery name="getgeneral" datasource="#dts#">
			select * from gsetup
			</cfquery>
            
				<select name="period" id="period">
					<option value="">Choose a period</option>
					<option value="01" <cfif xperiod eq '01'>selected</cfif>>Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="02" <cfif xperiod eq '02'>selected</cfif>>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="03" <cfif xperiod eq '03'>selected</cfif>>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="04" <cfif xperiod eq '04'>selected</cfif>>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="05" <cfif xperiod eq '05'>selected</cfif>>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="06" <cfif xperiod eq '06'>selected</cfif>>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="07" <cfif xperiod eq '07'>selected</cfif>>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="08" <cfif xperiod eq '08'>selected</cfif>>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="09" <cfif xperiod eq '09'>selected</cfif>>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="10" <cfif xperiod eq '10'>selected</cfif>>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="11" <cfif xperiod eq '11'>selected</cfif>>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="12" <cfif xperiod eq '12'>selected</cfif>>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="13" <cfif xperiod eq '13'>selected</cfif>>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="14" <cfif xperiod eq '14'>selected</cfif>>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="15" <cfif xperiod eq '15'>selected</cfif>>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="16" <cfif xperiod eq '16'>selected</cfif>>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="17" <cfif xperiod eq '17'>selected</cfif>>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="18" <cfif xperiod eq '18'>selected</cfif>>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</select>
            
			<!---<cfinput type="text" name="period" size="10" maxlength="2" value="#xperiod#" required="yes" validate="integer"> (e.g. 01)--->
			<input type="submit" name="submit2" value="Go" onclick="ColdFusion.Window.show('processing');">
    	<cfelseif form.sort eq "trxbillno">
			<cfif isdefined("form.billnofrom") and isdefined("form.billnoto")>
			<cfset xbillnofrom = form.billnofrom>
			<cfset xbillnoto = form.billnoto>
		<cfelse>
			<cfset xbillnofrom = "">
			<cfset xbillnoto = "">
		</cfif>
      	
		<cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
        	<cfset xcustnofrom = form.custnofrom>
       		<cfset xcustnoto = form.custnoto>
        <cfelse>
        	<cfset xcustnofrom = "">
        	<cfset xcustnoto = "">
     	</cfif>
		
		Bill No From 
		<cfinput type="text" name="billnofrom" size="10" maxlength="20" required="yes"  value="#xbillnofrom#"><img src="/images/find.jpg" width="20" height="14.5" onMouseOver="this.style.cursor='hand'" onClick="document.getElementById('fromto').value='from';javascript:ColdFusion.Window.show('findRefno');" />
		Bill No To 
		<cfinput type="text" name="billnoto" size="10" maxlength="20" required="yes" value="#xbillnoto#"><img src="/images/find.jpg" width="20" height="14.5" onMouseOver="this.style.cursor='hand'" onClick="document.getElementById('fromto').value='to';javascript:ColdFusion.Window.show('findRefno');" />
		
		<cfif posttype eq "RC">
			<cfquery name="getcust" datasource="#dts#">
				select 
				custno,
				name 
				from #target_apvend# 
				order by custno;
			</cfquery>
		<cfelse>
			<cfquery name="getcust" datasource="#dts#">
				select 
				custno,
				name 
				from #target_arcust# 
				order by custno;
		 	</cfquery>
		</cfif>
		
		<br>
		Customer No From 
		<select name="custnofrom">
			<option value="">Choose a customer</option>
			<cfloop query="getcust"> 
		  		<option value="#custno#"<cfif custno eq xcustnofrom>selected</cfif>>#custno# - #name#</option>
			</cfloop> 
		</select>
		
		<br>
		Customer No To &nbsp;&nbsp; 
		<select name="custnoto">
			<option value="">Choose a customer</option>
			<cfloop query="getcust"> 
		 		<option value="#custno#"<cfif custno eq xcustnoto>selected</cfif>>#custno# - #name#</option>
			</cfloop> 
		</select>
		<input type="submit" name="submit3" value=" Go " onclick="ColdFusion.Window.show('processing');">

	<cfelseif form.sort eq "trxbillno2">
			<cfif isdefined("form.billno2from") and isdefined("form.billno2to")>
			<cfset xbillno2from = form.billno2from>
			<cfset xbillno2to = form.billno2to>
		<cfelse>
			<cfset xbillno2from = "">
			<cfset xbillno2to = "">
		</cfif>
      	
		
		Ref No 2 from
		<cfinput type="text" name="billno2from" size="10" maxlength="20" required="yes"  value="#xbillno2from#">
		Ref No 2 to
		<cfinput type="text" name="billno2to" size="10" maxlength="20" required="yes" value="#xbillno2to#">
		
		<input type="submit" name="submit5" value=" Go " onclick="ColdFusion.Window.show('processing');">

   	<cfelseif form.sort eq "Custno">
      	<cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
			<cfset xcustnofrom  = form.custnofrom>
        	<cfset xcustnoto = form.custnoto>
      	<cfelse>
      	  	<cfset xcustnofrom = "">
        	<cfset xcustnoto = "">
      	</cfif>
      	
		Customer No From 
      	<cfinput type="text" name="custnofrom" size="10" value="#xcustnofrom#" required="yes" maxlength="8">
      	Customer No To 
      	<cfinput type="text" name="custnoto" size="10" value="#xcustnoto#" required="yes" maxlength="8">
        <br />
        <cfif isdefined("form.period")>
				<cfset xperiod = form.period>
			<cfelse>
				<cfset xperiod = "">
			</cfif>
			Period 
			<cfinput type="text" name="period" size="10" maxlength="2" value="#xperiod#" validate="integer"> (e.g. 01)
	  	<input type="submit" name="submit4" value=" Go " onclick="ColdFusion.Window.show('processing');">
    
    <cfelseif form.sort eq "billpay">

		Bill Status
        <select name="billstatus" id="billstatus">
        <option value="fullypaid">Fully paid</option>
        <option value="unpaid">Not Full Paid</option>
        </select>

		<input type="submit" name="submit6" value=" Go " onclick="ColdFusion.Window.show('processing');">

    
    </cfif>
	</cfif>
	</div>
	<cfif status eq "unposted">
		<br><br>
		<div align="center">
        <cfif isdefined('form.post')>
		<cfif form.post eq "post">
        <input type="button" name="import" id="import" value="Import" onclick="window.location.href='/default/admin/posting2/import_to_ams.cfm'" />
		</cfif>
        </cfif>
		<input type="submit" name="post" value="Post" onclick="ColdFusion.Window.show('processing');">
        <input type="button" name="print" id="print" value="Print"  onClick="javascript:CallPrint('print_div');" />
		&nbsp; 
		<cfif Hlinkams neq "Y" or isdefined('url.ubs')>
			<input type="submit" name="export" value="Export">
		</cfif>
		</div>
	</cfif> 
</cfform>

<cfwindow center="true" width="520" height="400" name="findRefno" refreshOnShow="true"
        title="Find Refno" initshow="false"
        source="/default/admin/posting2/findRefno.cfm?type={billtype}&fromto={fromto}" />
        
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
title="Find Customer" initshow="false"
source="findCustomer.cfm?type=#target_arcust#&fromto={fromto}" />

</cfoutput>