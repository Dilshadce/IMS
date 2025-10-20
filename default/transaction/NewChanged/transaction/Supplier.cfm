<html>
<head>
	<title>Supplier Page</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<link rel="stylesheet" href="/stylesheet/style.css"/>
	<script type="text/javascript" src="/scripts/prototype.js"></script>
	<script type="text/javascript" src="/scripts/effects.js"></script>
	<script type="text/javascript" src="/scripts/controls.js"></script>
</head>

<cfquery datasource='#dts#' name="showall">
	select 
	* 
	from #target_currency#;
</cfquery>

<cfquery name="getterm" datasource="#dts#">
	select 
	* 
	from #target_icterm# 
	order by term;
</cfquery>

<cfquery name="getbusiness" datasource="#dts#">
	select 
	* 
	from business 
	order by business;
</cfquery>

<cfquery name="getarea" datasource="#dts#">
	select 
	* 
	from #target_icarea# 
	order by area;
</cfquery>

<cfquery name="getcodepatern" datasource="#dts#">
	select 
	creditorfr,
	creditorto,
    custSuppNo 
	from gsetup;
</cfquery>

<cfquery name="getrefno" datasource="#dts#">
	SELECT * FROM refnoset WHERE type = "SUPP"
</cfquery>

<cfif getrefno.refnoused eq 1 and url.type eq "create">
<cfif getrefno.lastusedno eq "">
<cfset oldlastusedno = 0>
<cfelse>
<cfset oldlastusedno = getrefno.lastusedno>
</cfif>
<cftry>
<cfinvoke component="cfc.refno" method="processNum" oldNum="#oldlastusedno#" returnvariable="newnextNum" />
<cfcatch type="any">
<cfset newnextNum = oldlastusedno>
<cfoutput>
<script type="text/javascript">
alert("Autogenerate supplier number fail, please check the last used no whether the entry is correct");
</script>
</cfoutput>
</cfcatch>
</cftry>
<cfif getcodepatern.custSuppno eq "1">
<cfset nextcustno = getrefno.refnocode&"/"&newnextNum>
<cfelse>
<cfset nextcustno = getrefno.refnocode&newnextNum>
</cfif>

</cfif>

<script language="JavaScript">
	function displayrate()
	{
		if(document.SupplierForm.currcode.value!=''){
			<cfoutput query ="showall">
			if(document.SupplierForm.currcode.value=='#showall.currcode#')
			{
				document.SupplierForm.currency.value='#showall.currency#';
				document.SupplierForm.currency1.value='#showall.currency1#';
			}		
			</cfoutput>	
		}else{
			document.SupplierForm.currency.value='';
			document.SupplierForm.currency1.value='';
		}
	}
	function check_float()
	{
		if(!isNaN(document.getElementById('invLimit').value))
		{
			return true;
		}
		else
		{
			alert("Invoice Limit Must Be A Numeric !");
			document.getElementById('invLimit').focus();
			return false;
		}
	}
	
	function check_compulsoryfield(){
		if(document.SupplierForm.Name.value == ''){
			alert("Company Name cannot be blank !");
			document.getElementById('Name').focus();
			return false;
		}
		else if(document.SupplierForm.Add1.value == ''){
			alert("Address cannot be blank !");
			document.getElementById('Add1').focus();
			return false;
		}
		else if(document.SupplierForm.Attn.value == ''){
			alert("Attention cannot be blank !");
			document.getElementById('Attn').focus();
			return false;
		}
		else if(document.SupplierForm.phone.value == ''){
			alert("Phone cannot be blank !");
			document.getElementById('phone').focus();
			return false;
		}
		else if(document.SupplierForm.Fax.value == ''){
			alert("Fax cannot be blank !");
			document.getElementById('Fax').focus();
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function check_field(){
		if(document.SupplierForm.ngst_cust.checked == false){
			if(document.SupplierForm.gstno.value == ''){
				alert("GST No. cannot be blank !");
				document.getElementById('gstno').focus();
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}
	
	function checkSimilar(){
		checkboxObj=document.getElementById("check");
		checkboxObj.checked =false;
	}
</script>

<script language="javascript" type="text/javascript" src="../../scripts/check_supplier_code.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<body>
	<cfset mode=Isdefined("url.type")>
	
	<cfif url.type eq "Edit">
		<cfquery datasource='#dts#' name="getPersonnel">
			select 
			* 
			from #target_apvend# 
			where custno='#url.custno#';
		</cfquery>
				
		<cfif getPersonnel.recordcount gt 0>
			<cfset custno = getPersonnel.custno>
			<cfset name = getPersonnel.name>
			<cfset name2 = getPersonnel.name2>
			<cfset add1 = getPersonnel.add1>
			<cfset add2 = getPersonnel.add2>
			<cfset add3 = getPersonnel.add3>
			<cfset add4 = getPersonnel.add4>
			<cfset attn = getPersonnel.attn>
			<cfset daddr1 = getPersonnel.daddr1>
			<cfset daddr2 = getPersonnel.daddr2>
			<cfset daddr3 = getPersonnel.daddr3>
			<cfset daddr4 = getPersonnel.daddr4>
			<cfset dattn = getPersonnel.dattn>
			<cfset contact = getPersonnel.contact>
			<cfset phone = getPersonnel.phone>
			<cfset phonea = getPersonnel.phonea>
			<cfset fax = getPersonnel.fax>
			<cfset dphone = getPersonnel.dphone>
			<cfset dfax = getPersonnel.dfax>
			<cfset email = getPersonnel.e_mail>
			<cfset website = getPersonnel.web_site>
			<cfset comuen = getPersonnel.comuen>
			<cfset gstno = getPersonnel.gstno>
			<cfset ngst_cust = getPersonnel.ngst_cust>
			<cfset country = getPersonnel.country>
			<cfset postalcode = getPersonnel.postalcode>
			<cfset d_country = getPersonnel.d_country>
			<cfset d_postalcode = getPersonnel.d_postalcode>
			<cfset agent = getPersonnel.agent>
			<cfset xterm = getPersonnel.term>
			<cfset xbusiness = getPersonnel.business>
			<cfset xarea = getPersonnel.area>
			<cfset crlimit = getPersonnel.crlimit>
			<cfset currcode1 = getPersonnel.currcode>
			<cfset currency = getPersonnel.currency>
			<cfset currency1 = getPersonnel.currency1>
			<cfset currency2 = getPersonnel.currency2>
			<cfset status = getPersonnel.status>
			<cfset date = dateformat(getPersonnel.date,'DD-MM-YYYY')>
			<cfset invLimit = getPersonnel.invLimit>
			<cfset dispec_cat = getPersonnel.dispec_cat>
			<cfset dispec1 = getPersonnel.dispec1>
			<cfset dispec2 = getPersonnel.dispec2>
			<cfset dispec3 = getPersonnel.dispec3>
            <cfset enduserdata = getPersonnel.END_USER>
			<cfset autopay=getPersonnel.autopay>	<!--- ADD ON 26-11-2009 --->
			<cfset groupto=getPersonnel.groupto>	<!--- ADD ON 26-11-2009 --->	
			<cfset arrem1=getPersonnel.arrem1>
			<cfset arrem2=getPersonnel.arrem2>
			<cfset arrem3=getPersonnel.arrem3>
			<cfset arrem4=getPersonnel.arrem4>				
			<cfset mode = "Edit">
			<cfset title = "Edit Supplier">
			<cfset button = "Edit">
		<cfelse>
			<cfset status = "Sorry, the Supplier, #url.custno# was ALREADY removed from the system. Process unsuccessful.">
			
			<form name="done" action="vpersonnel.cfm?type=Supplier&process=done" method="post">
				<input name="status" value="#status#" type="hidden">
			</form>
			
			<script>
				done.submit();
			</script>
		</cfif>
	<cfelseif url.type eq "Create">
		<cfquery datasource='#dts#' name="getcurrcode">
			select 
			a.bcurr,
			b.currency,
			b.currency1 
			from gsetup as a,#target_currency# as b 
			where b.currcode=a.bcurr;
		</cfquery>
		
		<cfif getcurrcode.recordcount neq 0>
			<cfset sgcurrency = getcurrcode.currency>
			<cfset sgcurrency1 = getcurrcode.currency1>
		<cfelse>
			<h3>Please maintain your currency table first. (Default Currency Code is "<cfoutput>#getcurrcode.bcurr#</cfoutput>")</h3>					
			<cfabort>
		</cfif>
		
		<cfset custno = "">
		<cfset name = "">
		<cfset name2 = "">
		<cfset add1 = "">
		<cfset add2 = "">
		<cfset add3 = "">
		<cfset add4 = "">
		<cfset attn = "">
		<cfset daddr1 = "">
		<cfset daddr2 = "">
		<cfset daddr3 = "">
		<cfset daddr4 = "">
		<cfset dattn = "">
		<cfset contact = "">
		<cfset phone = "">
		<cfset phonea = "">
		<cfset fax = "">
		<cfset dphone = "">
		<cfset dfax = "">
		<cfset email = "">
		<cfset website = "">
		<cfset comuen = "">
		<cfset gstno ="">
		<cfset ngst_cust = "T">
		<cfset country ="">
		<cfset postalcode ="">
		<cfset d_country = "">
		<cfset d_postalcode = "">
		<cfset agent = "">
		<cfset xterm = "">
		<cfset xbusiness = "">
		<cfset xarea = "">
		<cfset crlimit = "">
		<cfset currcode1 = getcurrcode.bcurr>
		<cfset currency = sgcurrency>
		<cfset currency1 = sgcurrency1>
		<cfset currency2 = "">
		<cfset status = "">
		<cfset date = dateformat(now(),'DD-MM-YYYY')>
		<cfset invLimit = "0.00">
		<cfset dispec_cat = "">
		<cfset dispec1 = "0.00">
		<cfset dispec2 = "0.00">
		<cfset dispec3 = "0.00">
        <cfset enduserdata = "">
		<cfset autopay="O">								<!--- ADD ON 26-11-2009 --->
		<cfset groupto=getcodepatern.creditorfr&"/000">	<!--- ADD ON 26-11-2009 --->	
		<cfset arrem1="">
		<cfset arrem2="">
		<cfset arrem3="">
		<cfset arrem4="">
		<cfset mode = "Create">
		<cfset title = "Create Supplier">
		<cfset button = "Create">
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getPersonnel">
			select 
			* 
			from #target_apvend# 
			where custno='#url.custno#';
		</cfquery>
				
		<cfif getPersonnel.recordcount gt 0>
			<cfoutput query="getPersonnel">
				<cfset trpNo = getPersonnel.custno>
				<cfset name = getPersonnel.name>
				<cfset name2 = getPersonnel.name2>
				<cfset add1 = getPersonnel.add1>
				<cfset add2 = getPersonnel.add2>
				<cfset add3 = getPersonnel.add3>
				<cfset add4 = getPersonnel.add4>
				<cfset attn = getPersonnel.attn>
				<cfset daddr1 = getPersonnel.daddr1>
				<cfset daddr2 = getPersonnel.daddr2>
				<cfset daddr3 = getPersonnel.daddr3>
				<cfset daddr4 = getPersonnel.daddr4>
				<cfset dattn = getPersonnel.dattn>
				<cfset contact = getPersonnel.contact>
				<cfset phone = getPersonnel.phone>
				<cfset phonea = getPersonnel.phonea>
				<cfset fax = getPersonnel.fax>
				<cfset dphone = getPersonnel.dphone>
				<cfset dfax = getPersonnel.dfax>
				<cfset email = getPersonnel.e_mail>
				<cfset website = getPersonnel.web_site>
				<cfset comuen = getPersonnel.comuen>
				<cfset gstno = getPersonnel.gstno>
				<cfset ngst_cust = getPersonnel.ngst_cust>
				<cfset country = getPersonnel.country>
				<cfset postalcode = getPersonnel.postalcode>
				<cfset d_country = getPersonnel.d_country>
				<cfset d_postalcode = getPersonnel.d_postalcode>
				<cfset agent = getPersonnel.agent>
				<cfset xterm = getPersonnel.term>
				<cfset xbusiness = getPersonnel.business>
				<cfset xarea = getPersonnel.area>
				<cfset crlimit = getPersonnel.crlimit>
				<cfset currcode1 = getPersonnel.currcode>
				<cfset currency = getPersonnel.currency>
				<cfset currency1 = getPersonnel.currency1>
				<cfset currency2 = getPersonnel.currency2>
				<cfset status = getPersonnel.status>
				<cfset date = dateformat(getPersonnel.date,'DD-MM-YYYY')>
				<cfset invLimit = getPersonnel.invLimit>
				<cfset dispec_cat = getPersonnel.dispec_cat>
				<cfset dispec1 = getPersonnel.dispec1>
				<cfset dispec2 = getPersonnel.dispec2>
				<cfset dispec3 = getPersonnel.dispec3>
				<cfset autopay=getPersonnel.autopay>	<!--- ADD ON 26-11-2009 --->
				<cfset groupto=getPersonnel.groupto>	<!--- ADD ON 26-11-2009 --->	
				<cfset arrem1=getPersonnel.arrem1>
				<cfset arrem2=getPersonnel.arrem2>
				<cfset arrem3=getPersonnel.arrem3>
				<cfset arrem4=getPersonnel.arrem4>	
				<cfset mode = "Delete">
				<cfset title = "Delete Supplier">
				<cfset button = "Delete">
			</cfoutput>
		<cfelse>
			<cfset status = "Sorry, the Supplier, #url.custno# was ALREADY removed from the system. Process unsuccessful. Please refresh your webpage.">
			
			<form name="done" action="vpersonnel.cfm?type=Supplier&process=done" method="post" >
				<input name="status" value="#status#" type="hidden">
			</form>
			
			<script>
				done.submit();
			</script>
		</cfif>
	</cfif>
	
	<cfoutput>
	<h1>#title#</h1>
	</cfoutput>
	
	<cfoutput>
	<form name="SupplierForm" action="SupplierProcess.cfm" method="post" 
	<cfif url.type eq "Create">
		<cfif lcase(HcomID) eq "mhsl_i" or lcase(HcomID) eq "mpt_i" or lcase(HcomID) eq "mhca_i">
			onSubmit="javascript:if(validate('#getcodepatern.creditorfr#','#getcodepatern.creditorto#','#getcodepatern.custSuppNo#')&&check_float()&&check_compulsoryfield()&&check_field()){return true;}else{return false;}"
		<cfelseif lcase(hcomid) eq "nikbra_i">
			onSubmit="javascript:if(check_float()&&check_field()){return true;}else{return false;}"
		<cfelse>
			onSubmit="javascript:if(validate('#getcodepatern.creditorfr#','#getcodepatern.creditorto#','#getcodepatern.custSuppNo#')&&check_float()&&check_field()){return true;}else{return false;}"
		</cfif>	
	<cfelseif url.type eq "Edit">
		onSubmit="javascript:if(check_float()&&check_field()){return true;}else{return false;}"
	</cfif>
	> 
		<input type="hidden" name="mode" value="#mode#">
		<input type="hidden" name="target_table" value="apvend">
		
		<table align="center" class="data" width="660px">
			<tr> 
      			<th><p>Supplier No :</p></th>
				<td>
					<cfif mode eq "Delete" or mode eq "Edit">
						<input type="text" size="15" name="custno" value="#custno#" readonly>
					<cfelse>
						<input type="text" size="40" name="custno" value="<cfif getrefno.refnoused eq 1>#nextcustno#</cfif>" maxlength="8"><input type="hidden" name="nexcustno" id="nexcustno" value="#getcodepatern.custSuppNo#" >
						<div id="hint" class="autocomplete"></div>
		                <script type="text/javascript">
							var url = "/ajax/functions/getRecord.cfm?custtype=supplier";
								
							new Ajax.Autocompleter("custno","hint",url,{afterUpdateElement : getSelectedId});
								
							function getSelectedId(text, li) {
								$('custno').value=li.id;
							}
						</script>
					</cfif>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type=checkbox value='O' name="autopay" <cfif autopay eq "O">checked</cfif>>Open Item Supplier
				</td>
			</tr>
			<tr>								
      			<th>Company Name :</th>
				<td>
					<input type="text" size="40" name="Name" value="#Name#" maxlength="40">
					<cfif mode eq "Create">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="check" value="Y" onClick="checkSimilar();ajaxFunction(document.getElementById('ajaxField1'),'/default/maintenance/ajaxAction.cfm?dfunction=checkSimilarSupplier&name='+document.getElementById('Name').value);">Check Similar
					<div id="ajaxField1" name="ajaxField1">
					</div>
				</cfif>
				</td>			
			</tr>
			<tr>
				<td></td>
				<td><input type="text" size="40" name="Name2" value="#Name2#" maxlength="40"></td>
			</tr>
			<tr>
			   	<th>Company UEN :</th>
			    <td><input type="text" size="40" name="comuen" value="#comuen#" maxlength="50"></td>
			</tr>
		  	<tr>
		    	<th>Gst No. :</th>
		    	<td><input type="text" size="40" name="gstno" value="#gstno#" maxlength="50"></td>
		  	</tr>
			<tr>
			   	<th>Non GST Supplier :</th>
			    <td><input type="checkbox" name="ngst_cust" value="#ngst_cust#" <cfif ngst_cust eq "T">checked</cfif>></td>
			</tr>
			<tr>
			   	<th>Group To :</th>
			    <td><input name="groupto" type="text" maxlength="12" value="#groupto#" size="15"></td>
			</tr>
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
				<th>Address :</th>
				<td><input type="text" size="40" name="Add1" value="#Add1#" maxlength="35"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" size="40" name="Add2"  value="#Add2#" maxlength="35"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" size="40" name="Add3"  value="#Add3#" maxlength="35"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" size="40" name="Add4"  value="#Add4#" maxlength="35"></td>
			</tr>
		  	<tr>
		    	<th>Country :</th>
		    	<td><input type="text" size="40" name="country" value="#country#" maxlength="50"></td>
		  	</tr>
		  	<tr>
		    	<th>Postal Code :</th>
		    	<td><input type="text" size="40" name="postalcode" value="#postalcode#" maxlength="50"></td>
		  	</tr>
			<tr>
				<th>Attention :</th>
				<td><input type="text" size="40" name="Attn"  value="#attn#" maxlength="35"></td>
			</tr>
			<tr>
				<th>Phone :</th>
				<td><input type="text" size="40" name="phone" value="#phone#" maxlength="25"></td>
			</tr>
			<tr>
				<th>Phone 2 :</th>
				<td><input type="text" size="40" name="phonea" value="#phonea#" maxlength="25"></td>
			</tr>
			<tr>
				<th>Fax :</th>
				<td><input type="text" size="40" name="Fax" value="#Fax#" maxlength="25"></td>
			</tr>
			<tr>
				<th>Delivery Address :</th>
				<td><input type="text" size="40" name="DAddr1" value="#DAddr1#" maxlength="35"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" size="40" name="DAddr2"  value="#DAddr2#" maxlength="35"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" size="40" name="DAddr3"  value="#DAddr3#" maxlength="35"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" size="40" name="DAddr4"  value="#DAddr4#" maxlength="35"></td>
			</tr>
		  	<tr>
		    	<th>Delivery Country :</th>
		    	<td><input type="text" size="40" name="d_country" value="#d_country#" maxlength="50"></td>
		  	</tr>
		  	<tr>
		    	<th>Delivery Postal Code :</th>
		    	<td><input type="text" size="40" name="d_postalcode" value="#d_postalcode#" maxlength="50"></td>
		  	</tr>
			<tr>
				<th>Delivery Attention :</th>
				<td><input type="text" size="40" name="DAttn"  value="#dattn#" maxlength="35"></td>
			</tr>
		  	<tr>
		    	<th>Delivery Phone :</th>
		    	<td><input type="text" size="40" name="dphone" value="#dphone#" maxlength="25"></td>
		  	</tr>
		  	<tr>
		    	<th>Delivery Fax :</th>
		    	<td><input type="text" size="40" name="dfax" value="#dfax#" maxlength="25"></td>
		  	</tr>
			<tr>
				<th>Contact :</th>
				<td><input type="text" size="40" name="contact"  value="#contact#" maxlength="15"></td>
			</tr>
			<!--- <tr>
				<td>Phone :</td>
				<td><input type="text" size="40" name="phone" value="#phone#" maxlength="25"></td>
			</tr>
			<tr>
				<td>Phone 2 :</td>
				<td><input type="text" size="40" name="phonea" value="#phonea#" maxlength="25"></td>
			</tr>
			<tr>
				<td>Fax :</td>
				<td><input type="text" size="40" name="Fax" value="#Fax#" maxlength="25"></td>
			</tr> --->
			<tr>
				<th>Email :</th>
				<td><input type="text" size="60" name="e_mail" value="#email#" maxlength="90"></td>
			</tr>
			<tr>
				<th>Web Site :</th>
				<td><input type="text" size="40" name="web_site" value="#website#" maxlength="50"></td>
			</tr>
			<tr><td colspan="100%"><hr></td></tr>
            <cfquery name="getEndUser" datasource="#dts#">
    select * from driver order by driverno
    </cfquery>
    <tr>
    <th>End User :</th>
    <td>
    <select name="enduser" id="enduser">
    <option value="">Choose an end user</option>
    <cfloop query="getEndUser">
    <option value="#getEndUser.DRIVERNO#" <cfif enduserdata eq getEndUser.DRIVERNO>selected </cfif> >#getEndUser.DRIVERNO# - #getEndUser.Name#</option>
	</cfloop>
    </select><!--- &nbsp;<cfif getpin2.h1C10 eq 'T'><br /><a href="driver.cfm?type=Create" target="_blank">Create New End User</a></cfif> --->
    </td>
    </tr>
			<tr>
				<th>Agent :</th>
				<td><input type="text" size="40" name="agent" value="#agent#" maxlength="12"></td>
			</tr>
			</cfoutput>
			<tr>
				<th>Terms :</th>
				<td><select name="term" id="term">
						<option value="">Choose a Terms</option>
						<cfoutput query="getterm">
							<option value="#getterm.term#"<cfif xterm eq getterm.term>Selected</cfif>>#getterm.term#</option>
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr>
				<th>Area :</th>
				<td><select name="area" id="area">
						<option value="">Choose a Area</option>
						<cfoutput query="getarea">
							<option value="#getarea.area#"<cfif xarea eq getarea.area>Selected</cfif>>#getarea.area# - #getarea.desp#</option>
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr>
				<th>Business :</th>
				<td><select name="business" id="business">
						<option value="">Choose a Business</option>
						<cfoutput query="getbusiness">
							<option value="#getbusiness.business#"<cfif xbusiness eq getbusiness.business>Selected</cfif>>#getbusiness.business# - #getbusiness.desp#</option>
						</cfoutput>
					</select>
				</td>
			</tr>
			<cfoutput>
			<tr>
				<th>Credit Limit :</th>
				<td><input type="text" size="40" name="crlimit" value="#crlimit#" maxlength="19"></td>
			</tr>
			</cfoutput>
			<tr>
				<th>Currency Code : <cfoutput>#currcode1#</cfoutput></th>
				<td><select name="currcode" id="currcode" onChange="javascript:displayrate()">
						<!--- REMARK ON 300508, ALL THE CURRENCY WILL RETRIEVE FROM DATABASE --->
						<!---option value="SGD">SGD - S$</option--->
						<option value="">Choose a Currency</option>	
						<cfoutput query="showall"> 
							<option value="#showall.CurrCode#" 
							<cfif showall.currcode eq '#currcode1#'>selected</cfif>>
							#showall.currcode# - #showall.Currency# 
							</option>
						</cfoutput> 
					</select>
				</td>
			</tr>
			<cfoutput>
			<tr>
				<th>Currency:</th>
				<td><input type="text" size="40" name="currency" value="#currency#" maxlength="10"></td>
			</tr>
			<tr>
				<th>Currency Dollar :</th>
				<td><input type="text" size="40" name="currency1" value="#currency1#" maxlength="17"></td>
			</tr>
			<tr>
				<th>Currency Dollar 2 :</th>
				<td><input type="text" size="40" name="currency2" value="#currency2#" maxlength="17"></td>
			</tr>
			<tr>
				<th>Status :</th>
				<td><input type="checkbox" name="status" value="B" <cfif status eq "B">checked</cfif>></td>
			</tr>
			<tr>
				<th>Date :</th>
				<td><input type="text" size="40" name="date" value="#date#" readonly></td>
			</tr>
			<tr>
				<th>Invoice Limit :</th>
				<td><input type="text" size="40" name="invLimit" value="#invLimit#" maxlength="19"></td>
			</tr>
			<tr>
				<th>Discount Percentage Category :</th>
				<td><input type="text" size="40" name="dispec_cat" value="#dispec_cat#" maxlength="1"></td>
			</tr>
			<tr>
				<th>Discount Percentage Level 1 :</th>
				<td><input type="text" size="40" name="dispec1" value="#dispec1#" maxlength="5"></td>
			</tr>
			<tr>
				<th>Discount Percentage Level 2 :</th>
				<td><input type="text" size="40" name="dispec2" value="#dispec2#" maxlength="5"></td>
			</tr>
			<tr>
				<th>Discount Percentage Level 3 :</th>
				<td><input type="text" size="40" name="dispec3" value="#dispec3#" maxlength="5"></td>
			</tr>
			<tr>
				<th>Remark 1 :</th>
				<td><input type="text" size="40" name="arrem1" id="arrem1" value="#arrem1#" maxlength="35"></td>
			</tr>
			<tr>
				<th>Remark 2 :</th>
				<td><input type="text" size="40" name="arrem2" id="arrem2" value="#arrem2#" maxlength="35"></td>
			</tr>
			<tr>
				<th>Remark 3 :</th>
				<td><input type="text" size="40" name="arrem3" id="arrem3" value="#arrem3#" maxlength="35"></td>
			</tr>
			<tr>
				<th>Remark 4 :</th>
				<td><input type="text" size="40" name="arrem4" id="arrem4" value="#arrem4#" maxlength="35"></td>
			</tr>
			<tr>
				<td></td>
				<td align="right"><input type="submit" value="  #button#  "></td>
			</tr>				
			</cfoutput>
		</table>
	</form>
			
</body>
</html>