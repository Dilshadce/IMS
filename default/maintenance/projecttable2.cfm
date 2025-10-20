<cfquery datasource="#dts#" name="getgeneral">
	Select lPROJECT as layer from gsetup
</cfquery>
<html>
<head>
<title><cfoutput>#getgeneral.layer#</cfoutput> Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
</head>

<script language="JavaScript">

function validate(){
  if(document.ProjectForm.source.value==''){
	alert("Your Project's No. cannot be blank.");
	document.ProjectForm.source.focus();
	return false;
  }

<!---   if(document.ProjectForm.PorJ.value==''){
	alert("You must choose P or J.");
	document.ProjectForm.PorJ.focus();
	return false;
  } --->
  return true;
}

function limitText(field,maxlimit){
	if (field.value.length > maxlimit) // if too long...trim it!
		field.value = field.value.substring(0, maxlimit);
		// otherwise, update 'characters left' counter
}
	
</script>


<cfif Hlinkams eq "Y">
      <cfquery name="getgldata" datasource="#replace(dts,'_i','_a','all')#">
        select accno,desp,desp2 
        from gldata 
        where accno not in (select custno from arcust order by custno) 
        and accno not in (select custno from apvend order by custno)
        order by accno;
       </cfquery>
</cfif>

<body>
<cfoutput>
	<cfif url.type eq "Edit">
		<cfquery datasource='#dts#' name="getitem">
			Select * FROM #target_project# where source='#url.source#' and porj = "P"
		</cfquery>
		
		<cfset source=getitem.source>
		<cfset project=getitem.project>
		<cfset porj=getitem.porj>
        <cfset creditsales = getitem.creditsales>
        <cfset cashsales = getitem.cashsales>
        <cfset salesreturn = getitem.salesreturn>
        <cfset purchase = getitem.purchase>
        <cfset purchasereturn = getitem.purchasereturn>
        <cfset completed=getitem.completed>
        <cfset remark1=getitem.remark1>
        <cfset remark2=getitem.remark2>
        <cfset remark3=getitem.remark3>
        <cfset remark4=getitem.remark4>
        <cfset remark5=getitem.remark5>
		
		<cfif lcase(HcomID) eq "pls_i">
			<cfset d4=getitem.DETAIL4>
			<cfset d5=getitem.DETAIL5>
			<cfset d6=getitem.DETAIL6>
			<cfset d7=getitem.DETAIL7>
			<cfset d8=getitem.DETAIL8>
			<cfset d9=getitem.DETAIL9>
			<cfset d10=getitem.DETAIL10>
			<cfset d11=getitem.DETAIL11>
			<cfset d12=getitem.DETAIL12>
			<cfset d13=getitem.DETAIL13>
		</cfif>
		
        <cfif lcase(HcomID) eq "taftc_i">
        	<cfset WSQ = getitem.wsq >
            <cfset cprice = getitem.cprice >
            <cfset cdispec = getitem.cdispec >
            <cfset camt = getitem.camt >
            <cfset deposit = getitem.bydeposit>
            <cfset grantacc = getitem.grantacc>
            <cfset urevenueacc = getitem.urevenueacc>
		</cfif>
        
		<cfif lcase(HcomID) eq 'weikeninv_i' or lcase(HcomID) eq 'weikenint_i' or lcase(HcomID) eq 'weikenbuilder_i' or lcase(HcomID) eq 'futurehome_i' or lcase(HcomID) eq 'weikenid_i' or lcase(HcomID) eq 'weikendecor_i'>
            <cfset wos_date = getitem.wos_date>
            <cfset description = getitem.description>
            <cfset project_status = getitem.project_status>
            <cfset project_type = getitem.project_type>
            <cfset start_date = getitem.start_date>
            <cfset end_date = getitem.end_date>
            <cfset handleby = getitem.handleby>
            <cfset delivery_date = getitem.delivery_date>
            <cfset cost_est = getitem.cost_est >
            <cfset cost_all = getitem.cost_all >
            <cfset cost_add = getitem.cost_add >
            <cfset budget = getitem.budget>
            <cfset achievement = getitem.achievement>
            <cfset com_id = getitem.com_id>
            <cfset com_name = getitem.com_name>
        </cfif>
        
		<cfset mode="Edit">
		<!--- <cfset title="Edit Item"> --->
		<cfset title="Edit "&getgeneral.layer>
		<cfset button="Edit">
	
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getitem">
			Select * FROM #target_project# where source='#url.source#' and porj = "P"
		</cfquery>
		
		<cfset source=getitem.source>
		<cfset project=getitem.project>
		<cfset porj=getitem.porj>
        <cfset creditsales = getitem.creditsales>
        <cfset cashsales = getitem.cashsales>
        <cfset salesreturn = getitem.salesreturn>
        <cfset purchase = getitem.purchase>
        <cfset purchasereturn = getitem.purchasereturn>
        <cfset completed=getitem.completed>
        <cfset remark1=getitem.remark1>
        <cfset remark2=getitem.remark2>
        <cfset remark3=getitem.remark3>
        <cfset remark4=getitem.remark4>
        <cfset remark5=getitem.remark5>
		
		<cfif lcase(HcomID) eq "pls_i">
			<cfset d4=getitem.DETAIL4>
			<cfset d5=getitem.DETAIL5>
			<cfset d6=getitem.DETAIL6>
			<cfset d7=getitem.DETAIL7>
			<cfset d8=getitem.DETAIL8>
			<cfset d9=getitem.DETAIL9>
			<cfset d10=getitem.DETAIL10>
			<cfset d11=getitem.DETAIL11>
			<cfset d12=getitem.DETAIL12>
			<cfset d13=getitem.DETAIL13>
		</cfif>
        
		<cfif lcase(HcomID) eq "taftc_i">
        	<cfset WSQ = getitem.wsq >
            <cfset cprice = getitem.cprice >
            <cfset cdispec = getitem.cdispec >
            <cfset camt = getitem.camt >
            <cfset deposit = getitem.bydeposit>
            <cfset grantacc = getitem.grantacc>
            <cfset urevenueacc = getitem.urevenueacc>
		</cfif>
        
        <cfif lcase(HcomID) eq 'weikeninv_i' or lcase(HcomID) eq 'weikenint_i' or lcase(HcomID) eq 'weikenbuilder_i' or lcase(HcomID) eq 'futurehome_i' or lcase(HcomID) eq 'weikenid_i' or lcase(HcomID) eq 'weikendecor_i'>
      		
            <cfset wos_date = getitem.wos_date>
            <cfset description = getitem.description>
            <cfset project_status = getitem.project_status>
            <cfset project_type = getitem.project_type>
            <cfset start_date = getitem.start_date>
            <cfset end_date = getitem.end_date>
            <cfset handleby = getitem.handleby>
            <cfset delivery_date = getitem.delivery_date>
            <cfset cost_est = getitem.cost_est >
            <cfset cost_all = getitem.cost_all >
            <cfset cost_add = getitem.cost_add >
            <cfset budget = getitem.budget>
            <cfset achievement = getitem.achievement>
            <cfset com_id = getitem.com_id>
            <cfset com_name = getitem.com_name>
        </cfif>
        
		<cfset mode="Delete">
		<!--- <cfset title="Delete Item"> --->
		<cfset title="Delete "&getgeneral.layer>
		<cfset button="Delete">
	
	<cfelseif url.type eq "Create">
		<cfset source="">
		<cfset project="">
		<cfset porj="">
        <cfset creditsales = "">
        <cfset cashsales = "">
        <cfset salesreturn = "">
        <cfset purchase = "">
        <cfset purchasereturn = "">
        <cfset completed="">
        <cfset remark1="">
        <cfset remark2="">
        <cfset remark3="">
        <cfset remark4="">
        <cfset remark5="">
		
		<cfif lcase(HcomID) eq "pls_i">
			<cfset d4="">
			<cfset d5="">
			<cfset d6="">
			<cfset d7="">
			<cfset d8="">
			<cfset d9="">
			<cfset d10="">
			<cfset d11="">
			<cfset d12="">
			<cfset d13="">
		</cfif>
        
		<cfif lcase(HcomID) eq "taftc_i">
        	<cfset WSQ = "" >
            <cfset cprice =  "0.00">
            <cfset cdispec =  "0">
            <cfset camt = "0.00">
            <cfset deposit = "">
            <cfset grantacc = "">
            <cfset urevenueacc = "">
		</cfif>
        
        <cfif lcase(HcomID) eq 'weikeninv_i' or lcase(HcomID) eq 'weikenint_i' or lcase(HcomID) eq 'weikenbuilder_i' or lcase(HcomID) eq 'futurehome_i' or lcase(HcomID) eq 'weikenid_i' or lcase(HcomID) eq 'weikendecor_i'>
		<cfset wos_date = dateformat(now(),'yyyy-mm-dd')>
        <cfset description = ''>
        <cfset project_status = ''>
        <cfset project_type = ''>
        <cfset start_date = ''>
        <cfset end_date = ''>
        <cfset handleby= ''>
        <cfset delivery_date = ''>
        <cfset cost_est = ''>
        <cfset cost_all = ''>
        <cfset cost_add = ''>
        <cfset budget = ''>
        <cfset achievement = ''>
        <cfset com_id = ''>
        <cfset com_name = ''>
        
        </cfif>
        
        
		<cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create "&getgeneral.layer>
		<cfset button="Create">
	</cfif>

  <h1>#title#</h1>
			
	<h4>
		<cfif getpin2.h1H10 eq 'T'><a href="Projecttable2.cfm?type=Create">Creating a #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H20 eq 'T'>|| <a href="Projecttable.cfm?">List all #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_Projecttable.cfm?type=project">Search For #getgeneral.layer#</a></cfif>||<a href="p_project.cfm">#getgeneral.layer# Listing report</a>||<a href="import_project.cfm">#getgeneral.layer# comparing report</a>
	</h4>
</cfoutput> 

<cfform name="ProjectForm" action="Projecttableprocess.cfm" method="post" onsubmit="return validate()">
  <cfoutput> 
    <input type="hidden" name="mode" value="#mode#">
  </cfoutput> 
  <h1 align="center"><cfoutput>#getgeneral.layer#</cfoutput> File Maintenance</h1>
  <table align="center" class="data" width="450">

    <cfoutput> 
    <cfif lcase(HcomID) eq 'weikeninv_i' or lcase(HcomID) eq 'weikenint_i' or lcase(HcomID) eq 'weikenbuilder_i' or lcase(HcomID) eq 'futurehome_i' or lcase(HcomID) eq 'weikenid_i' or lcase(HcomID) eq 'weikendecor_i'>
    <tr><td>Date</td>
    <td><cfinput type="text" name="wos_date" id="wos_date" required="yes" message="The date entered is not valid" validate="eurodate" validateat="onsubmit" value="#dateformat(wos_date,'YYYY-MM-DD')#" size="15">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('wos_date'));"></td>
    </tr>
    <cfquery name="getCust" datasource="#dts#">
      SELECT * FROM #target_arcust#
      </cfquery>
      <tr>
      <td>Company ID</td>
      <td>
      <select name="com_id" id="com_id" onChange="document.getElementById('com_name').value=this.options[this.selectedIndex].id;">
      <option value=""> -Please Select- </option>
      <cfloop query="getCust">
      <option id="#getcust.name#" value="#getcust.custno#" <cfif com_id eq getcust.custno>selected</cfif>>#getcust.custno# - #getcust.name#</option>
      </cfloop>
      </select>
      </td>
      </tr>
      
      <tr>
      <td>Company Name</td>
      <td>
      <cfinput type="text" name="com_name" id="com_name" required="yes" message="Enter Company Name" value="#com_name#" size="50">
      </td>
      </tr> 
    
     
    </cfif>
    
    
    
      <tr> 
        <td width="130"><cfif lcase(hcomid) neq 'taftc_i'>#getgeneral.layer#<cfelse>Course Code</cfif> :</td>
        <td colspan="4"> <cfif mode eq "Delete" or mode eq "Edit">
            <!--- <h2>#url.source#</h2> --->
            <input type="text" size="20" name="source" value="#url.source#" readonly>
            <cfelse>
            <input type="text" size="20" name="source" value="#source#" maxlength="<cfif lcase(hcomid) eq 'tmt_i' or lcase(hcomid) eq 'taff_i'>8<cfelseif lcase(hcomid) eq 'taftc_i'>15<cfelseif lcase(hcomid) eq 'pls_i'>10<cfelseif lcase(hcomid) eq 'topsteel_i'>30<cfelse>40</cfif>">
          </cfif> </td>
      </tr>
   
      <tr> 
        <td><cfif lcase(hcomid) neq 'taftc_i'>Description<cfelse>Course Title</cfif> :</td>
        <td colspan="4">
			<cfif lcase(HcomID) eq 'taff_i' or lcase(HcomID) eq 'taftc_i' or lcase(HcomID) eq 'spcivil_i'>
				<textarea name="project" id="project" cols="40" rows="3" onKeyDown="limitText(this.form.project,200);" onKeyUp="limitText(this.form.project,200);">#project#</textarea>
            <cfelseif lcase(hcomid) eq 'bestform_i' or lcase(hcomid) eq 'decor_i' or lcase(hcomid) eq 'aepl_i' or lcase(hcomid) eq 'aespl_i' or lcase(hcomid) eq 'aeisb_i'>
            <input type="text" size="40" name="project" value="#project#" maxlength="500">
			<cfelse>
				<input type="text" size="40" name="project" value="#project#" maxlength="#IIf((lcase(HcomID) eq 'tmt_i'),DE('80'),DE('40'))#">
			</cfif>		</td>
        <input type="hidden" name="porj" id="porj" value="P">
      </tr>
      <cfif lcase(HcomID) eq 'weikeninv_i' or lcase(HcomID) eq 'weikenint_i' or lcase(HcomID) eq 'weikenbuilder_i' or lcase(HcomID) eq 'futurehome_i' or lcase(HcomID) eq 'weikenid_i' or lcase(HcomID) eq 'weikendecor_i'>
      
      <tr><td>Project Description</td><td colspan="3"><cfinput type="text" name="description" id="description" value="#description#" size="50"/></td></tr>
      
      <tr><td>Project Status</td>
      <td>
      <cfinput type="text" name="project_status" id="project_status" value="#project_status#" />
      </td>
      </tr>
      
      <tr>
      <td>Project Type</td>
      <td>
      <cfinput type="text" name="project_type" id="project_type" value="#project_type#" />
      </td>
      </tr>
      
      
      <tr><td>Start Date</td>
      <td><cfinput type="text" name="start_date" id="start_date" required="yes" message="The date entered is not valid" validate="eurodate" validateat="onsubmit" value="#dateformat(start_date,'YYYY-MM-DD')#" size="15">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('start_date'));"></td>
      </tr>
      <tr><td>End Date</td>
      <td><cfinput type="text" name="end_date" id="end_date" required="yes" message="The date entered is not valid" validate="eurodate" validateat="onsubmit" value="#dateformat(end_date,'YYYY-MM-DD')#" size="15">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('end_date'));"></td>
      </tr>
      
      <tr><td>Handle By</td>
      <td>
      <cfinput type="text" name="handleby" id="handleby" value="#handleby#" />
      </td>
      </tr>
      
      <tr>
      <td>Project Cost Estimates</td>
      <td><cfinput type="text" name="cost_est" id="cost_est" value="#cost_est#" /></td>
      </tr>
      
      <tr>
      <td>Project Cost Allocated</td>
      <td><cfinput type="text" name="cost_all" id="cost_all" value="#cost_all#" /></td>
      </tr>
      
      <tr>
      <td>Additional Expenses</td>
      <td><cfinput type="text" name="cost_add" id="cost_add" value="#cost_add#" /></td>
      </tr>
      
      <tr>
      <td>Actual Budget</td>
      <td><cfinput type="text" name="budget" id="budget" value="#budget#" /></td>
      </tr>
      
      
      
      <tr>
      <td>Delivery Date</td>
      <td>
      <cfinput type="text" name="delivery_date" id="delivery_date" required="yes" message="The date entered is not valid" validate="eurodate" validateat="onsubmit" value="#dateformat(delivery_date,'YYYY-MM-DD')#" size="15">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('delivery_date'));">
      </td>
      </tr>
      
      <tr>
      <td>Achievements</td>
      <td>
      <cfinput type="text" name="achievement" id="achievement" value="#achievement#" />
      </td>
      </tr>
      
      
      
      
      </cfif>
      
      
      
      <tr>
      <td><cfif lcase(HcomID) eq 'ascend_i'>Misc Purchases<cfelseif lcase(HcomID) eq 'bsssb_i' or lcase(HcomID) eq 'puss_i' or lcase(HcomID) eq 'rvsb_i' or lcase(HcomID) eq 'hnm_i'>NO AKAUN<cfelse>Remark 1</cfif></td>
      <td><input type="text" size="40" name="remark1" value="#remark1#" maxlength="150"></td>
      
      </tr>
      
      <tr>
      <td><cfif lcase(HcomID) eq 'ascend_i'>Temp Staff (Total Sum)<cfelseif lcase(HcomID) eq 'bsssb_i' or lcase(HcomID) eq 'puss_i' or lcase(HcomID) eq 'rvsb_i' or lcase(HcomID) eq 'hnm_i'>NAMA BANK<cfelse>Remark 2</cfif></td>
      <td><input type="text" size="40" name="remark2" value="#remark2#" maxlength="150"></td>
      
      </tr>
      
      <tr>
      <td><cfif lcase(HcomID) eq 'ascend_i'>Food & Berverages<cfelseif lcase(HcomID) eq 'bsssb_i' or lcase(HcomID) eq 'puss_i' or lcase(HcomID) eq 'rvsb_i' or lcase(HcomID) eq 'hnm_i'>CAWANGAN<cfelse>Remark 3</cfif></td>
      <td><input type="text" size="40" name="remark3" value="#remark3#" maxlength="150"></td>
      
      </tr>
      
      <tr>
      <td><cfif lcase(HcomID) eq 'ascend_i'>Taxi<cfelse>Remark 4</cfif></td>
      <td><input type="text" size="40" name="remark4" value="#remark4#" maxlength="150"></td>
      
      </tr>
      
      <tr>
      <td><cfif lcase(HcomID) eq 'ascend_i'>Accomodation / Hotel<cfelse>Remark 5</cfif></td>
      <td><input type="text" size="40" name="remark5" value="#remark5#" maxlength="150"></td>
      
      </tr>
      
      
      
      <cfif lcase(HcomID) eq 'taftc_i'>
      <tr>
        <td>WSQ Competency Codes :</td>
        <td colspan="4"><textarea name="WSQ" id="WSQ" cols="40" rows="10">#wsq#</textarea></td>
      </tr>
      <tr>
      <td>Price</td>
      <td><cfinput type="text" name="cPrice" id="cPrice" value="#LSnumberformat(cprice,"_.__")#" validate="float" message="Please Enter Number Only for Price"/></td>
      </tr>
            <tr>
      <td>Discount</td>
      <td><input type="text" name="cdispec" id="cdispec" value="#cdispec#" /></td>
      </tr>
            <tr>
      <td>Amount</td>
      <td><cfinput type="text" name="camt" id="camt" value="#LSnumberformat(camt,"_.__")#" validate="float" message="Please Enter Number Only for Amount"/></td>
      </tr>
      
      <tr>
      <td>Deposit 50%</td>
      <cfif deposit eq 1>
      <td><input type="checkbox" name="cbdeposit" id="cbdeposit" checked></td>
      <cfelse>
      <td><input type="checkbox" name="cbdeposit" id="cbdeposit">
      </td>
      </cfif>
      </tr>
      <cfif Hlinkams eq "Y">
      <tr>
      <td>Unearn Revenue :</td>
      <td>
	  <select name="urevenueacc" id="urevenueacc">
      <option value="0000/000">0000/000</option>
	  <cfloop query="getgldata">
	  <option value="#getgldata.accno#" <cfif urevenueacc eq getgldata.accno>selected</cfif>>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
	  </cfloop>
      </select>
      </td>
      </tr>
      <cfelse>
      <tr>
      <td>Unearn Revenue :</td>
      <td>
      <input type="text" name="urevenueacc" id="urevenueacc" value="#urevenueacc#">
      </td>
      </tr>
      </cfif>
      <cfif Hlinkams eq "Y">
      <tr>
      <td>Grant Acc :</td>
      <td>
	  <select name="grantacc" id="grantacc">
      <option value="0000/000">0000/000</option>
	  <cfloop query="getgldata">
	  <option value="#getgldata.accno#" <cfif grantacc eq getgldata.accno>selected</cfif>>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
	  </cfloop>
      </select>
      </td>
      </tr>
      <cfelse>
      <tr>
      <td>Grant Acc :</td>
      <td>
      <input type="text" name="grantacc" id="grantacc" value="#grantacc#">
      </td>
      </tr>
      </cfif>
      </cfif>
<!---       <tr>
        <td>P or J</td>
        <td colspan="4"><select name="PorJ">
            <option value="">Choose P or J</option>
            <option value="P"<cfif porj eq "P">Selected</cfif>>P</option>
            <option value="J"<cfif porj eq "J">Selected</cfif>>J</option>
          </select>
        </td>
      </tr> --->
      <cfif Hlinkams eq "Y">
      <tr>
      <td>Credit Sales :</td>
      <td>
      
	  <select name="creditsales" id="creditsales">
      <option value="0000/000">0000/000</option>
	  <cfloop query="getgldata">
	  <option value="#getgldata.accno#" <cfif creditsales eq getgldata.accno>selected</cfif>>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
	  </cfloop>
      </select>
      </td>
      </tr>
        <tr>
      <td>Cash Sales :</td>
      <td>
      <select name="cashsales" id="cashsales">
      <option value="0000/000">0000/000</option>
	  <cfloop query="getgldata">
	  <option value="#getgldata.accno#" <cfif cashsales eq getgldata.accno>selected</cfif>>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
	  </cfloop>
      </select>
      </td>
      </tr>
        <tr>
      <td>Sales Return :</td>
      <td>
      <select name="salesreturn" id="salesreturn">
      <option value="0000/000">0000/000</option>
	  <cfloop query="getgldata">
	  <option value="#getgldata.accno#" <cfif salesreturn eq getgldata.accno>selected</cfif>>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
	  </cfloop>
      </select>
      </td>
      </tr>
      <tr>
      <td>Purchase :</td>
      <td>
      <select name="purchase" id="purchase">
      <option value="0000/000">0000/000</option>
	  <cfloop query="getgldata">
	  <option value="#getgldata.accno#" <cfif purchase eq getgldata.accno>selected</cfif>>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
	  </cfloop>
      </select></td>
      </tr>
        <tr>
      <td>Purchase Return :</td>
      <td>
      <select name="purchasereturn" id="purchasereturn">
      <option value="0000/000">0000/000</option>
	  <cfloop query="getgldata">
	  <option value="#getgldata.accno#" <cfif purchasereturn eq getgldata.accno>selected</cfif>>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
	  </cfloop>
      </select></td>
      </tr>
      <cfelse>
      <tr>
      <td>Credit Sales :</td>
      <td><input type="text" name="creditsales" id="creditsales" value="#creditsales#" /></td>
      </tr>
        <tr>
      <td>Cash Sales :</td>
      <td><input type="text" name="cashsales" id="cashsales" value="#cashsales#" /></td>
      </tr>
        <tr>
      <td>Sales Return :</td>
      <td><input type="text" name="salesreturn" id="salesreturn" value="#salesreturn#" /></td>
      </tr>
      <tr>
      <td>Purchase :</td>
      <td><input type="text" name="purchase" id="purchase" value="#purchase#" /></td>
      </tr>
        <tr>
      <td>Purchase Return :</td>
      <td><input type="text" name="purchasereturn" id="purchasereturn" value="#purchasereturn#" /></td>
      </tr>
      </cfif>
	  <cfif lcase(HcomID) eq "pls_i">
		<tr> 
			<td>Engine No :</td>
			<td colspan="4"><input type="text" size="40" name="d5" value="#d5#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Chassis No :</td>
			<td colspan="4"><input type="text" size="40" name="d6" value="#d6#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Make :</td>
			<td colspan="4"><input type="text" size="40" name="d7" value="#d7#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Model :</td>
			<td colspan="4"><input type="text" size="40" name="d8" value="#d8#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Y.O.M :</td>
			<td colspan="4"><input type="text" size="40" name="d9" value="#d9#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Propellant :</td>
			<td colspan="4"><input type="text" size="40" name="d10" value="#d10#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Color :</td>
			<td colspan="4"><input type="text" size="40" name="d11" value="#d11#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Location :</td>
			<td colspan="4"><input type="text" size="40" name="d12" value="#d12#" maxlength="80"></td>
		</tr>
	  </cfif>
      
      <tr>
      <td>Completed</td>
      <td><input type="checkbox" name="completed" id="completed" <cfif completed eq 'Y'>checked</cfif>></td>
      
    </cfoutput> 
    <tr> 
      <td height="23"></td>
      <td colspan="4" align="right"><cfoutput> 
          <input name="submit" type="submit" value="  #button#  ">
        </cfoutput></td>
    </tr>
  </table>
</cfform>
<cfif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "taftc_i">
<center><font color="#FF0000">* Description : <cfoutput>#getgeneral.layer#</cfoutput> Name @ Location @ Duration (dd - dd/mm/yyyy) @ time @ Speaker</font></center>
</cfif>
</body>
</html>
