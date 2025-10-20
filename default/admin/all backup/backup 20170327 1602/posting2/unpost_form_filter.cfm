<cfoutput>
<script type="text/javascript">
function submitform()
{
document.form1.submit()
}

function validatedate()
{
	if(document.getElementById('popupvalidate').value=='unpost')
	{
	var answer = confirm('Are You Sure Want to unpost bill?');

		if(answer)
		{
		ColdFusion.Window.show('processing');
		updatepercent();
		return true;
		}
		else
		{
			ColdFusion.Window.hide('processing');
		return false;
		}
	}
}


</script>
<cfform action="" method="post" name="form1" onsubmit="return validatedate();"> 
	
    <cfquery name="getgeneral" datasource="#dts#">
        SELECT linv,lcs,lcn,ldn,lpr,lrc
        FROM gsetup;
    </cfquery>
        
	<cfoutput> 
	<cfif isdefined('nowuuid')>
    <input type="hidden" name="isuuid" id="isuuid" value="#nowuuid#">
	</cfif>
	<input type="hidden" name="popupvalidate" id="popupvalidate" value="" />
    <input type="radio" name="posttype" value="INV"<cfif posttype eq "INV">checked</cfif>> #getgeneral.linv#
    <input type="radio" name="posttype" value="CN"<cfif posttype eq "CN">checked</cfif>> #getgeneral.lcn# 
    <input type="radio" name="posttype" value="DN"<cfif posttype eq "DN">checked</cfif>> #getgeneral.ldn# 
    <input type="radio" name="posttype" value="RC"<cfif posttype eq "RC">checked</cfif>> #getgeneral.lrc# 
    <input type="radio" name="posttype" value="CS"<cfif posttype eq "CS">checked</cfif>> #getgeneral.lcs# 
    <input type="radio" name="posttype" value="PR"<cfif posttype eq "PR">checked</cfif>> #getgeneral.lpr#
  	</cfoutput>
	<p><strong>Sort by</strong> : 
	
	<cfif isdefined("form.sort") and form.sort neq "">
		<cfset xsort = form.sort>
	<cfelse>
		<cfset xsort = "">
    </cfif>
	
    <select name="Sort" onchange="ajaxFunction(document.getElementById('ajaxField'),'postingacc_form_filter_Ajax.cfm?sort='+document.getElementById('sort').value);">
		<option value="-">-</option>
      	<option value="trxdate"<cfif xsort eq "trxdate">selected</cfif>>Date</option>
      	<option value="period"<cfif xsort eq "period">selected</cfif>>Period</option>
      	<option value="trxbillno"<cfif xsort eq "trxbillno">selected</cfif>>Billno</option>
      	<option value="custno"<cfif xsort eq "custno">selected</cfif>>Customer No</option>
    </select>
    &nbsp; 
    <input type="submit" name="typesubmit" value="Sort">
  	</p>
  	<div id="ajaxField" name="ajaxField">
	<cfif isdefined("form.sort")>
  		<cfif not isdefined("form.posttype")>
			<h3>Error: Please select one type of document to unpost.</h3>
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
			
			Date From 	<cfinput type="text" name="datefrom" size="10" maxlength="10" value="#xdatefrom#" required="no" mask="99/99/9999" validate="eurodate">
			Date To		<cfinput type="text" name="dateto" size="10" maxlength="10"  value="#xdateto#"required="no" mask="99/99/9999" validate="eurodate">
            
            <cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
			<cfset xcustnofrom  = form.custnofrom>
        	<cfset xcustnoto = form.custnoto>
      	<cfelse>
      	  	<cfset xcustnofrom = "">
        	<cfset xcustnoto = "">
      	</cfif>
      	
		Customer No From 
      	<cfinput type="text" name="custnofrom" size="10" value="#xcustnofrom#" maxlength="8">
      	Customer No To 
      	<cfinput type="text" name="custnoto" size="10" value="#xcustnoto#" maxlength="8">
            
			<input type="submit" name="submit" value="Go" onclick="ColdFusion.Window.show('processing');updatepercent();">
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
            
			<input type="submit" name="submit2" value="Go" onclick="ColdFusion.Window.show('processing');updatepercent();">
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
			
			Bill No From	<cfinput type="text" name="billnofrom" size="10" maxlength="20"  value="#xbillnofrom#">
			Bill No To		<cfinput type="text" name="billnoto" size="10" maxlength="20" value="#xbillnoto#" >
			
			<br>
			<cfif posttype eq "RC">
				<cfquery name="getcust" datasource="#dts#">
					select custno, name from #target_apvend# order by custno
				</cfquery>
			<cfelse>
				<cfquery name="getcust" datasource="#dts#">
					select custno, name from #target_arcust# order by custno
				</cfquery>
			</cfif>
			
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
		 			<option value="#custno#"<cfif custno eq #xcustnoto#>selected</cfif>>#custno# - #name#</option>
				</cfloop> 
			</select>
			<input type="submit" name="submit3" value="Go" onclick="ColdFusion.Window.show('processing');updatepercent();">
   		<cfelseif form.sort eq "Custno">
			<cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
				<cfset xcustnofrom = form.custnofrom>
        		<cfset xcustnoto = form.custnoto>
      		<cfelse>
        		<cfset xcustnofrom = "">
        		<cfset xcustnoto = "">
      		</cfif>
			
			Customer No From 	<cfinput type="text" name="custnofrom" size="10" value="#xcustnofrom#" maxlength="8">
      		Customer No To		<cfinput type="text" name="custnoto" size="10" value="#xcustnoto#" maxlength="8" >
			<input type="submit" name="submit4" value="Go" onclick="ColdFusion.Window.show('processing');updatepercent();">
    	</cfif>
  	</cfif>
    </div>
	<br><br><div align="center"><cfif isdefined('form.submit') or isdefined('form.submit2')  or isdefined('form.submit3')  or isdefined('form.submit4')  ><input type="submit" name="unpost" id="unpost" value="Unpost" onclick="document.getElementById('popupvalidate').value='unpost'"></cfif></div>
</cfform>
</cfoutput>