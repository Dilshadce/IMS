<cfsetting showdebugoutput="yes">
<cfset name = "">
<cfset add1 = "">
<cfset add2 = "">
<cfset add3 = "">
<cfset add4 = "">
<cfset add5 = "">
<cfset dadd1 = "">
<cfset dadd2 = "">
<cfset dadd3 = "">
<cfset dadd4 = "">
<cfset dadd5 = "">
<cfset country = "">
<cfset postalcode = "">
<cfset D_postalcode = "">
<cfset phone = "">
<cfset dphone = "">
<cfset email = "">
<cfset website = "">
<cfset arrem1 = "">

<cfquery name="getgsetup" datasource="#dts#">
  select * from gsetup
</cfquery>
<cfset currcode1 = getgsetup.bcurr>

<cfquery name="showall" datasource="#dts#">
	select 
	* 
	from #target_currency#;
</cfquery>

<cfquery name="getterm" datasource="#dts#">
  select * from #target_icterm# order by term
</cfquery>

<cfquery name="getbusiness" datasource="#dts#">
  select * from business order by business
</cfquery>

<cfquery name="getagent" datasource="#dts#">
  select agent FROM #target_icagent#
</cfquery>

<cfquery name="getarea" datasource="#dts#">
  select * FROM #target_icarea#
</cfquery>

	<cfquery datasource="#dts#" name="getcurrcode">
		select 
		a.bcurr,
		b.currency,
		b.currency1 
		from gsetup as a,#target_currency# as b 
		where b.currcode = a.bcurr;
	</cfquery>
    
   <cfquery name="getrefno" datasource="#dts#">
	SELECT * FROM refnoset WHERE type = "cust"
</cfquery>

<cfif getrefno.refnoused eq 1>
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
alert("Autogenerate customer number fail, please check the last used no whether the entry is correct");
</script>
</cfoutput>
</cfcatch>
</cftry>

<cfif getgsetup.custSuppno eq "1">
<cfset nextcustno = getrefno.refnocode&"/"&newnextNum>
<cfelse>
<cfset nextcustno = getrefno.refnocode&newnextNum>
</cfif>
</cfif>

<cfform name="CreateCustomer" id="CreateCustomer" method="post" action="/default/maintenance/atccreateCustomerAjaxProcess.cfm"> 
<cfif isdefined('url.id') and hcomid eq "asiasoft_i">
<cfoutput>
<input type="hidden" name="leadid" id="leadid" value="#url.id#" />
</cfoutput>
</cfif>
<cfif isdefined('url.main')>
<cfoutput>
<input type="hidden" name="mainid" id="mainid" value="#url.main#" />
</cfoutput>
</cfif>
<table width="700px" style="font-size:-2">
<tr>
<th align="left">Customer No.</th>
<td>

<cfset inputvalue1=left(getgsetup.dfcustcode,4)>
<cfset inputvalue2 = "">
<cfif getrefno.refnoused eq 1>
<cfset inputvalue1 = "#getrefno.refnocode#">
<cfset inputvalue2 = "#newnextNum#">
<cfset nextcustno = "#getrefno.refnocode#"&"#newnextNum#">
</cfif>

<cfif getgsetup.custSuppno eq "1">
<cfoutput>
<cfinput type="text" size="4" name="s_prefix" id="s_prefix" maxlength="4"  value="#inputvalue1#" validateat="onblur" onvalidate="test_prefix"  onChange="javascript:this.value=this.value.toUpperCase();" message="-Please enter a value greater than or equal to #getgsetup.debtorfr# and less than or equal to #getgsetup.debtorto# in to Customer No prefix field" required="yes" tabindex="1"> 
/
<cfinput type="text" size="3" name="s_suffix" id="s_suffix" value="#inputvalue2#" maxlength="3" onChange="javascript:this.value=this.value.toUpperCase();" onvalidate="test_suffix" validateat="onblur" tabindex="2" required="yes" message="-Please enter at least 3 characters in the Customer No Suffixfield. and can not be 000" onKeyUp="ajaxFunction(document.getElementById('ajaxField'),'/default/maintenance/customerAjax.cfm?prefix='+document.getElementById('s_prefix').value+'&suffix='+document.getElementById('s_suffix').value);" onBlur="ajaxFunction(document.getElementById('ajaxField'),'/default/maintenance/customerAjax.cfm?prefix='+document.getElementById('s_prefix').value+'&suffix='+document.getElementById('s_suffix').value);checkcustno();" ><input type="hidden" name="nexcustno" id="nexcustno" value="#getgsetup.custSuppNo#" ></cfoutput>
<div id="ajaxField" name="ajaxField">
</div>

<cfelse>
<cfoutput>
<input type="text" size="15" name="custno" value="<cfif getrefno.refnoused eq 1>#nextcustno#</cfif>" maxlength="8"><input type="hidden" name="nexcustno" id="nexcustno" value="#getgsetup.custSuppNo#" >
</cfoutput>
</cfif>
<cfoutput><input type="hidden" name="custsuppdropdown" value="#getGsetup.suppcustdropdown#" /></cfoutput>
<!--- <cfoutput>
<br />
<b><u>Last 5 Record</u></b>
<cfquery name="getlast5" datasource="#dts#">
select custno from #target_arcust# order by created_on desc limit 5
</cfquery>
<cfloop query="getlast5">
<br />#getlast5.custno#
</cfloop>
</cfoutput> --->
</td>
</tr>
<tr>
<cfoutput>
<tr>
<th align="left">Created Date</th>
              <td><cfinput type="text" name="date" id="date" size="30" value="#dateformat(now(),'dd/mm/yyyy')# #timeformat(now(),'hh:mm:ss tt')#" ></td>
</tr>
</cfoutput>
<th align="left">Name / Company Name </th>
<td width="400px"><cfinput type="text" name="name" id="name" size="50" tabindex="3" maxlength="40" value="#name#"></td>

</tr>
<tr>
<th></th>
<td><cfinput type="text" name="name2" id="name2" size="50"  tabindex="4" maxlength="40"></td>
</tr>
</table>
            <table width="100%">
            <tr><th colspan="2"><div align="center">Order</div></th><th colspan="2"><div align="center">Receipient</div></th></tr>
            <tr>
            <td></td><td></td><th>Receipient Name*</th><td><cfinput type="text" name="arrem4" id="arrem4" size="50" tabindex="6" maxlength="35" value="" required="yes" message="Please Key in Receipient Name"></td>
            </tr>
            <tr>
            <th >Address 1</th>
            <td width="400px"><cfinput type="text" name="add1" id="add1" size="50" onBlur="JavaScript: document.getElementById('Dadd1').value=document.getElementById('add1').value" tabindex="5" maxlength="35" value="#add1#"></td>
            <th>Address 1</th>
            <td width="400px"><cfinput type="text" name="Dadd1" id="Dadd1" size="50" tabindex="5" maxlength="35" value="#Dadd1#"></td>
            </tr>
            <tr>
            <th>Address 2</th>
            <td><cfinput type="text" name="add2" id="add2" size="50" onBlur="JavaScript: document.getElementById('Dadd2').value=document.getElementById('add2').value" tabindex="6" maxlength="35" value="#add2#"></td>
           <th>Address 2</th>
            <td><cfinput type="text" name="Dadd2" id="add2" size="50" tabindex="6" maxlength="35" value="#Dadd2#"></td>
            </tr>
               <tr>
            <th>Address 3:</th>
            <td><cfinput type="text" name="add3" id="add3" size="50" onBlur="JavaScript: document.getElementById('Dadd3').value=document.getElementById('add3').value" tabindex="7" maxlength="35" value="#add3#"></td>
             <th>Address 3:</th>
            <td><cfinput type="text" name="Dadd3" id="Dadd3" size="50" onBlur="JavaScript: document.getElementById('Dadd3').value=document.getElementById('add3').value" tabindex="7" maxlength="35" value="#Dadd3#"></td>
            </tr>
               <tr>
            <th nowrap="nowrap">Address 4:</th>
            <td><cfinput type="text" name="add4" id="add4" size="50" onBlur="JavaScript: document.getElementById('Dadd4').value=document.getElementById('add4').value" tabindex="8" maxlength="35" value="#add4#"></td>
           <th nowrap="nowrap">Address 4:</th>
            <td><cfinput type="text" name="Dadd4" id="Dadd4" size="50" tabindex="8" maxlength="35" value="#Dadd4#"></td>
            </tr>
            
              <tr>
            <th>Address 5:</th>
            <td><cfinput type="text" name="add5" id="add5" size="50" onBlur="JavaScript: document.getElementById('dadd5').value=document.getElementById('add5').value" tabindex="8" maxlength="35" value="#add5#"></td>
           <th>Address 5:</th>
            <td><cfinput type="text" name="dadd5" id="dadd5" size="50" tabindex="8" maxlength="35" value="#dadd5#"></td>
            </tr>
            
            <tr>
            <th>Postal Code*</th>
            <td><cfinput type="text" name="postalcode" id="postalcode" size="30" value="#postalcode#" onBlur="JavaScript: document.getElementById('D_postalcode').value=document.getElementById('postalcode').value" required="yes" message="Please Key in Postal Code"></td>
			<th>Delivery Postal Code*</th>
            <td><cfinput type="text" name="D_postalcode" id="D_postalcode" size="30" value="#D_postalcode#" required="yes" message="Please Key in Receipient Postal Code"></td>
            
            </tr>
            <tr>
              <th>Tel*</th>
              <td><cfinput type="text" name="phone" id="phone" size="20" required="yes" onBlur="JavaScript: document.getElementById('dphone').value=document.getElementById('phone').value" message="Please Key in Tel" /></td>
              <th>Tel*</th>
              <td><cfinput type="text" name="dphone" id="dphone" size="20" required="yes" message="Please Key in Receipient Tel" /></td>
            </tr>
            <tr>
              <th>Hp*</th>
              <td><cfinput type="text" name="phonea" id="phonea" size="20" required="yes" onBlur="JavaScript: document.getElementById('contact').value=document.getElementById('phonea').value" message="Please Key in HP" /></td>
              <th>Hp*</th>
              <td><cfinput type="text" name="contact" id="contact" size="20" required="yes" message="Please Key in Receipient Hp"/></td>
            </tr>
            <tr>
            <th>Attention</th>
            <td><select name="arrem3" id="arrem3" onchange="selectlist(this.value,'arrem2')">
    			<option value="Mr">Mr</option>
    			<option value="Mrs">Mrs</option>
    			<option value="Ms">Ms</option>
    			</select>
    <cfinput type="text" name="attn" id="attn" size="50" onBlur="JavaScript: document.getElementById('Dattn').value=document.getElementById('attn').value" tabindex="9" maxlength="35" ></td>
    		<th>Delivery Attention</th>
              <td><cfinput type="text" name="dattn" id="dattn" size="20" /></td>
            
            </tr>
            <tr>
            <td colspan="5"><hr /></td>
            </tr>
            
            
            <tr>
            <th align="left">Email Address</th>
            <td><cfinput type="text" name="e_mail" id="e_mail" size="50" value="#email#" ></td>

           
            </tr>
            
            
            
            
            <tr>
              <th align="left">Fax/Telex</th>
              <td><cfinput type="text" name="Fax" id="Fax" size="20" /></td>
              
            </tr>
            
            <tr>
              <th align="left">Member ID</th>
      <td colspan="2"><cfinput type="text" name="arrem1" id="arrem1" size="50" ></td>
             
            </tr>
            <tr>
              
      		<th align="left">Gender</th>
      <td colspan="2"><select name="arrem2" id="arrem2">
      <option value="male">Male</option>
      <option value="female">Female</option>
      <option value="corporate">Corporate</option>
      </select>
      <input type="hidden" name="agent" id="agent" value="" />
      </td>
           
            </tr>
            </table>


<cfinput name="SubmitButton" id="SubmitButton" type="submit" value="Submit"/>
</cfform>	
