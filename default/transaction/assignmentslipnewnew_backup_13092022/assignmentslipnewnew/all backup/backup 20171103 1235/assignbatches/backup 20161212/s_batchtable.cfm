<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>
<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>
<cfajaximport tags="cfform">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script type="text/javascript">
function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
function confirmdebatch(type,assgnno,batchno)
{
	if(confirm('Are You Sure You Want To Remove This Assignment From The Batches?'))
	{
		var ajaxurl = '/default/transaction/assignmentslipnewnew/assignbatches/batchesamendment.cfm?type='+type+'&refno='+escape(assgnno)+'&batchno='+batchno;
		 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxfield').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Found!'); },		
		onComplete: function(transport){
        }
      })	  
		
	}
}
</script>
</cfoutput>
</head>



<body>

	<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
	
	<!--- <cfif isdefined("URL.Type")> --->
		
<h1><cfoutput>Batches Selection Page</cfoutput></h1>
		
<cfoutput>
	<h4>
		<a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable2.cfm?type=Create">Creating a Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable.cfm?">List all Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/s_Assignmentsliptable.cfm?type=Assignmentslip">Search For Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/assignbatches/batchassignment.cfm">Assign Batch Control</a>
        || <a href="/default/transaction/assignmentslipnewnew/assignbatches/s_batchtable.cfm">List Batch Control</a>
        <!--- || <a href="/default/transaction/assignmentslipnewnew/printcheque.cfm">Print Claim Cheque</a>
        || <a href="/default/transaction/assignmentslipnewnew/printclaim.cfm">Print Claim Voucher</a>
        || <a href="/default/transaction/assignmentslipnewnew/generatecheqno.cfm">Record Claim Cheque No</a>
         || <a href="/default/transaction/assignmentslipnewnew/definecheqno.cfm">Predefined Cheque No</a> --->
	</h4>
</cfoutput>
		
		<cfoutput>
        <input type="hidden" name="batchno" id="batchno" value="">
		<form action="s_batchtable.cfm" method="post"></cfoutput>
			<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
            	<option value="batches">Batches</option>
				<option value="refno">Ref no</option>
                <option value="created_by">User</option>
			</select>
      Search for Batches : 
      <input type="text" name="searchStr" value=""> </h1>
			</cfoutput>
		</form>
		
		<cfif isdefined("url.process")>
				<cfoutput><h1>#form.status#</h1><hr></cfoutput>
		</cfif>
	
		<cfquery datasource='#dts#' name="type">
			Select * from assignbatches GROUP BY batches order by created_on desc limit 20
		</cfquery>
		
		<cfif isdefined("form.searchStr")>
			<cfquery datasource='#dts#' name="exactResult">
				Select * from assignbatches where #form.searchType# = '#form.searchStr#' GROUP BY batches order by batches
			</cfquery>
			
			<cfquery datasource='#dts#' name="similarResult">
				Select * from assignbatches where #form.searchType# LIKE '%#form.searchStr#%' GROUP BY batches order by batches
			</cfquery>
			
			<h2>Exact Result</h2>
			<cfif #exactResult.recordCount# neq 0>
			
    <table align="center" class="data" width="1000px">
      <tr> 
         <th><div align="left">Batch</div></th>
        <th><div align="left">User</div></th>
        <th><div align="left">Locked</div></th>
        <th><div align="left">GIRO Credit Date</div></th>
        <th><div align="right">GIRO Amount</div></th>
        <th><div align="right">Created On</div></th>
        <th><div align="center">Action</div></th>
      </tr>
      <cfoutput query="exactResult"> 
      <cfquery name="getdetail" datasource="#dts#">
     	SELECT empno,paydate,month(assignmentslipdate) as amonth,refno FROM assignmentslip WHERE batches = "#exactResult.batches#"
      </cfquery>
      
<cfif payrollmonth eq getdetail.amonth>
<cfset paytra1 = "paytra1">
<cfset paytran = "paytran">
<cfelse>
<cfset paytra1 = "pay1_12m_fig">
<cfset paytran = "pay2_12m_fig">
</cfif>
      
 <cfquery name="getassignment" datasource="#dts#">
SELECT sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamt, sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded FROM assignmentslip 
WHERE batches = "#exactResult.batches#"
GROUP BY batches
</cfquery>

<cfquery name="getpayroll" datasource="#replace(dts,'_i','_p')#">
SELECT sum(round(netpay+0.0000001,2)) as netpay FROM #evaluate('#getdetail.paydate#')#
WHERE EMPNO in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getdetail.empno)#" separator="," list="yes">)
<cfif payrollmonth neq getdetail.amonth>
and tmonth = "#getdetail.amonth#"
</cfif>
</cfquery>

<cfset nnetpay = numberformat(val(getpayroll.netpay),'.__') + numberformat(val(getassignment.totalamt),'.__') - numberformat(val(getassignment.totalded),'.__')>
        <tr> 
          <td>#exactResult.batches#</td>
          <td>#exactResult.created_by#</td>
          <td>#exactResult.locked#</td>
          <td>#dateformat(exactResult.paydate,'dd/mm/yyyy')#</td>
          <td align="right">#numberformat(nnetpay,'.__')#</td>
          <td align="right">#dateformat(exactResult.created_on,'DD/MM/YYYY')#</td>
		<td width="10%" nowrap> 
            <div align="center">
              <a style="cursor:pointer" onClick="document.getElementById('batchno').value='#exactResult.batches#';ColdFusion.Window.show('viewbatch');" ><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">View</a></div></td>
        </tr>
      </cfoutput> 
    </table>
			<cfelse>
				<h3>No Exact Records were found.</h3>
			</cfif>
			
			<h2>Similar Result</h2>
			<cfif #similarResult.recordCount# neq 0>
			
    <table align="center" class="data" width="1000px">
      <tr> 
        <th><div align="left">Batch</div></th>
        <th><div align="left">User</div></th>
        <th><div align="left">Locked</div></th>
        <th><div align="left">GIRO Credit Date</div></th>
         <th><div align="right">GIRO Amount</div></th>
        <th><div align="right">Created On</div></th>
        <th><div align="center">Action</div></th>
      </tr>
      <cfoutput query="similarResult"> 
           <cfquery name="getdetail" datasource="#dts#">
     	SELECT empno,paydate,month(assignmentslipdate) as amonth,refno FROM assignmentslip WHERE batches = "#similarResult.batches#"
      </cfquery>
      
<cfif payrollmonth eq getdetail.amonth>
<cfset paytra1 = "paytra1">
<cfset paytran = "paytran">
<cfelse>
<cfset paytra1 = "pay1_12m_fig">
<cfset paytran = "pay2_12m_fig">
</cfif>
      
 <cfquery name="getassignment" datasource="#dts#">
SELECT sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamt, sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded FROM assignmentslip 
WHERE batches = "#similarResult.batches#"
GROUP BY batches
</cfquery>

<cfquery name="getpayroll" datasource="#replace(dts,'_i','_p')#">
SELECT sum(round(netpay+0.0000001,2)) as netpay FROM #evaluate('#getdetail.paydate#')#
WHERE EMPNO in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getdetail.empno)#" separator="," list="yes">)
<cfif payrollmonth neq getdetail.amonth>
and tmonth = "#getdetail.amonth#"
</cfif>
</cfquery>

<cfset nnetpay = numberformat(val(getpayroll.netpay),'.__') + numberformat(val(getassignment.totalamt),'.__') - numberformat(val(getassignment.totalded),'.__')>
        <tr> 
          <td>#similarResult.batches#</td>
          <td>#similarResult.created_by#</td>
          <td>#similarResult.locked#</td>
          <td>#dateformat(similarResult.paydate,'dd/mm/yyyy')#</td>
          <td align="right">#numberformat(nnetpay,'.__')#</td>
          <td align="right">#dateformat(similarResult.created_on,'DD/MM/YYYY')#</td>
		<td width="10%" nowrap> 
            <div align="center">
              <a style="cursor:pointer" onClick="document.getElementById('batchno').value='#similarResult.batches#';ColdFusion.Window.show('viewbatch');" ><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">View</a></div></td>
        </tr>
      </cfoutput> 
    </table>
			<cfelse>
				<h3>No Similar Records were found.</h3>
			</cfif>
		</cfif>
		
		<cfparam name="i" default="1" type="numeric">
		<hr>
		
		<fieldset>
		<legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
		font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;"> 
		<cfoutput>20 Newest Batches :</cfoutput></legend>
		<br>
		<cfif #type.recordCount# neq 0>
		
  <table align="center" class="data" width="800px">
    <tr> 
         <th><div align="left">Batch</div></th>
        <th><div align="left">User</div></th>
        <th><div align="left">Locked</div></th>
        <th><div align="left">GIRO Credit Date</div></th>
         <th><div align="right">GIRO Amount</div></th>
        <th><div align="right">Created On</div></th>
        <th><div align="center">Action</div></th>
      </tr>
      
      

    <cfoutput query="type" maxrows="20"> 
    
     <cfquery name="getdetail" datasource="#dts#">
     	SELECT empno,paydate,month(assignmentslipdate) as amonth,refno FROM assignmentslip WHERE batches = "#type.batches#"
      </cfquery>
     
<cfif payrollmonth eq getdetail.amonth>
<cfset paytra1 = "paytra1">
<cfset paytran = "paytran">
<cfelse>
<cfset paytra1 = "pay1_12m_fig">
<cfset paytran = "pay2_12m_fig">
</cfif>
      
 <cfquery name="getassignment" datasource="#dts#">
SELECT sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamt, sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded FROM assignmentslip 
WHERE batches = "#type.batches#"
GROUP BY batches
</cfquery>

<cfquery name="getpayroll" datasource="#replace(dts,'_i','_p')#">
SELECT sum(round(netpay+0.0000001,2)) as netpay FROM #evaluate('#getdetail.paydate#')#
WHERE EMPNO in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getdetail.empno)#" separator="," list="yes">)
<cfif payrollmonth neq getdetail.amonth>
and tmonth = "#getdetail.amonth#"
</cfif>
</cfquery>

<cfset nnetpay = numberformat(val(getpayroll.netpay),'.__') + numberformat(val(getassignment.totalamt),'.__') - numberformat(val(getassignment.totalded),'.__')>

      <tr> 
          <td>#type.batches#</td>
          <td>#type.created_by#</td>
          <td>#type.locked#</td>
          <td>#dateformat(type.paydate,'dd/mm/yyyy')#</td>
          <td align="right">#numberformat(nnetpay,'.__')#</td>
          <td align="right">#dateformat(type.created_on,'DD/MM/YYYY')#</td>
		<td width="10%" nowrap> 
            <div align="center">
              <a style="cursor:pointer" onClick="document.getElementById('batchno').value='#type.batches#';ColdFusion.Window.show('viewbatch');" ><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">View</a></div></td>
        </tr>
    </cfoutput> 
  </table>
		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
		<br>
		</fieldset>
<cfwindow center="true" width="700" height="500" name="viewbatch" refreshOnShow="true" title="View Batches" initshow="false" source="viewbatch.cfm?batchno={batchno}" />

</body>
</html>
