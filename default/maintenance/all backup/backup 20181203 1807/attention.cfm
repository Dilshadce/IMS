<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfoutput>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
									</script>


<html>
<head>
<title>Attention</title>

</head>

<body>



<cfif url.type eq 'edit'>
	<cfset mode="Edit">
	<cfset title="Edit Contact">
	<cfset button="Edit">			
	<cfquery datasource='#dts#' name="getcontact">
		Select * from attention where attentionno='#url.attentionno#'
	</cfquery>
    <cfset title2=getcontact.title2>
    <cfset salutation=getcontact.salutation>
    <cfset designation=getcontact.designation>
     <cfset commodity1=getcontact.commodity>
    <cfset category1=getcontact.category>
    <cfset business1=getcontact.business>
    <cfset attentionno = getcontact.attentionno>
	<cfset name=getcontact.name>
  <cfset customerno =getcontact.customerno>
  <cfset PHONE=getcontact.phone>
  <cfset FAX=getcontact.fax>
  <cfset PHONEA=getcontact.phonea>
  <cfset ASSISTANT=getcontact.assistant>
  <cfset ASST_PHONE=getcontact.asst_phone>
  <cfset DOB=getcontact.dob>
  <cfset DEPARTMENT=getcontact.department>
 <cfset DESCRIPTION=getcontact.description>
 <cfset B_ADD1=getcontact.B_add1>
 <cfset B_ADD2=getcontact.B_add2>
 <cfset B_ADD3=getcontact.B_add3>
 <cfset B_ADD4=getcontact.B_add4>
 <cfset B_CITY=getcontact.B_city>
 <cfset B_STATE=getcontact.B_state>
 <cfset B_POSTALCODE=getcontact.B_postalcode>
 <cfset B_COUNTRY=getcontact.B_country>
 <cfset O_ADD1=getcontact.O_add1>
 <cfset O_ADD2=getcontact.O_add2>
 <cfset O_ADD3=getcontact.O_add3>
 <cfset O_ADD4=getcontact.O_add4>
 <cfset O_CITY=getcontact.O_city>
 <cfset O_STATE=getcontact.O_state>
 <cfset O_POSTALCODE=getcontact.O_postalcode>
 <cfset O_COUNTRY=getcontact.O_country>
 <cfset C_PHONE=getcontact.C_phone>
 <cfset C_MOBILE=getcontact.C_mobile>
 <cfset C_EMAIL=getcontact.C_email>
<cfset contactgroup=getcontact.contactgroup>
<cfset industry1 = getcontact.industry>

<cfelseif url.type eq 'create'>

<cfset mode="Create">
	<cfset title="Create Contact">
	<cfset button="Create">			
    <cfset attentionno = "">
    <cfset designation="">
    <cfset commodity1=''>
    <cfset category1=''>
    <cfset business1=''>
    <cfset salutation=''>
<cfset name=''>
<cfset title2=''>
  <cfset customerno =''>
  <cfset PHONE=''>
  <cfset FAX=''>
  <cfset PHONEA=''>
  <cfset ASSISTANT=''>
  <cfset ASST_PHONE=''>
  <cfset DOB=''>
  <cfset DEPARTMENT=''>
 <cfset DESCRIPTION=''>
 <cfset B_ADD1=''>
 <cfset B_ADD2=''>
 <cfset B_ADD3=''>
 <cfset B_ADD4=''>
 <cfset B_CITY=''>
 <cfset B_STATE=''>
 <cfset B_POSTALCODE=''>
 <cfset B_COUNTRY=''>
 <cfset O_ADD1=''>
 <cfset O_ADD2=''>
 <cfset O_ADD3=''>
 <cfset O_ADD4=''>
 <cfset O_CITY=''>
 <cfset O_STATE=''>
 <cfset O_POSTALCODE=''>
 <cfset O_COUNTRY=''>
 <cfset C_PHONE=''>
 <cfset C_MOBILE=''>
 <cfset C_EMAIL=''>
 <cfset contactgroup=''>
 <cfset industry1 =''>
 
<cfelseif url.type eq 'delete'>
	<cfset mode="Delete">
	<cfset title="Delete Contact">
	<cfset button="Delete">			
	<cfquery datasource='#dts#' name="getcontact">
		Select * from attention where attentionno='#url.attentionno#'
	</cfquery>
    <cfset title2=getcontact.title2>
    <cfset designation=getcontact.designation>
    <cfset salutation=getcontact.salutation>
     <cfset commodity1=getcontact.commodity>
    <cfset category1=getcontact.category>
    <cfset business1=getcontact.business>
  <cfset attentionno = getcontact.attentionno>
  <cfset name=getcontact.name>
  <cfset customerno =getcontact.customerno>
  <cfset PHONE=getcontact.phone>
  <cfset FAX=getcontact.fax>
  <cfset PHONEA=getcontact.phonea>
  <cfset ASSISTANT=getcontact.assistant>
  <cfset ASST_PHONE=getcontact.asst_phone>
  <cfset DOB=getcontact.dob>
  <cfset DEPARTMENT=getcontact.department>
 <cfset DESCRIPTION=getcontact.description>
 <cfset B_ADD1=getcontact.B_add1>
 <cfset B_ADD2=getcontact.B_add2>
 <cfset B_ADD3=getcontact.B_add3>
 <cfset B_ADD4=getcontact.B_add4>
 <cfset B_CITY=getcontact.B_city>
 <cfset B_STATE=getcontact.B_state>
 <cfset B_POSTALCODE=getcontact.B_postalcode>
 <cfset B_COUNTRY=getcontact.B_country>
 <cfset O_ADD1=getcontact.O_add1>
 <cfset O_ADD2=getcontact.O_add2>
 <cfset O_ADD3=getcontact.O_add3>
 <cfset O_ADD4=getcontact.O_add4>
 <cfset O_CITY=getcontact.O_city>
 <cfset O_STATE=getcontact.O_state>
 <cfset O_POSTALCODE=getcontact.O_postalcode>
 <cfset O_COUNTRY=getcontact.O_country>
 <cfset C_PHONE=getcontact.C_phone>
 <cfset C_MOBILE=getcontact.C_mobile>
 <cfset C_EMAIL=getcontact.C_email>
 <cfset contactgroup=getcontact.contactgroup>
 <cfset industry1 = getcontact.industry>

</cfif>



<cfoutput>
	<h1>Attention</h1>
</cfoutput>

<cfquery name="getaccno" datasource="#dts#">
select custno,name from #target_arcust# ORDER BY name
</cfquery>

<cfform name="form1" action="attentionprocess.cfm" method="post">
	<cfoutput><input type="hidden" name="mode" value="#mode#"></cfoutput>
  	<h1 align="center"><cfoutput>#ucase(type)# Attention</cfoutput></h1>
  	
  	<table align="center" class="data" width="900">
    <tr>
    <th>Attention No</th><td>
    <cfif mode eq "Delete" or mode eq "Edit">
	          		<h2>#url.AttentionNo#</h2>
	          		<input type="hidden" name="AttentionNo" value="#AttentionNo#">  
	<cfelse>
	          		<input type="text" size="40" name="AttentionNo"  id="AttentionNo" value="#AttentionNo#" >
	</cfif> </td>
    </tr>
    <tr>
<th>Attention Name</th>
<td>
<select name="salutation" id="salutation">
            <cfif isdefined('getsalutation.recordcount')>
            <cfloop list="#getsalutation.salu#" index="i">
            <option value="#i#" <cfif salutation eq i>selected</cfif>>#i#</option>
            </cfloop>
            <cfelse>
            <option value="">-None-</option>
            <option value="Mr" <cfif salutation eq 'Mr'>selected</cfif>>Mr.</option>
            <option value="Mrs" <cfif salutation eq 'Mrs'>selected</cfif>>Mrs.</option>
            <option value="Ms" <cfif salutation eq 'Ms'>selected</cfif>>Ms.</option>
            <option value="Dr" <cfif salutation eq 'Dr'>selected</cfif>>Dr.</option>
            <option value="Prof" <cfif salutation eq 'Prof'>selected</cfif>>Prof.</option>
            </cfif>
            </select>
<cfinput type="text" name="name" id="name" required="yes" value="#name#" size="40" maxlength="100"  /><!---<cfif url.type eq 'edit' or url.type eq 'delete'>readonly</cfif>---> </td>
<th>Title</th>
<td>
<input type="text" name="title2" id="title2" value="#title2#">
</td>
</td>
</tr>
	<tr>
        <th width="100px">Account No</th>
<td colspan="3"><select name="customerno" id="customerno" onChange="ajaxFunction(document.getElementById('ajaxField1'),'accountinfoAjax.cfm?custno='+document.getElementById('customerno').value);">
<option value="">Please Choose a Customer No</option>
<cfloop query="getaccno">
<option value="#custno#" <cfif customerno eq custno>SELECTED</cfif> >#name# - #custno#</option>
</cfloop>
</select> <input type="button" size="10" <cfif dts eq 'asaiki_i'>value="Search"<cfelse>value="Ajax Search"</cfif> onClick="ColdFusion.Window.show('findCustomer');" /></td>

</tr>
<tr>
  <th>PHONE</th>
  <td>
  <cfif hcomid eq 'asaiki_i'><input type="text" name="idd2" id="idd2" readonly size="1" value="#left(C_phone,2)#" />-<input type="text" name="C_phone" id="C_phone" value="#mid(C_phone,3,10)#" size="30" maxlength="30"/>
  <cfelse>
  <input type="text" name="C_phone" id="C_phone" value="#C_phone#" size="30" maxlength="30"/>
  </cfif>
 <cfif hcomid eq 'asaiki_i'>
 &nbsp; 
 <cfset dts3=replace(dts,'_i','_c','all')>
 <cfquery name="getIDD" datasource="#dts3#">
 SELECT * FROM idd
 </cfquery>
 <select name="iddC" id="iddC" onChange="document.getElementById('idd2').value=this.value;document.getElementById('idd').value=this.value">
 <option value="">SELECT Country IDD</option>
 <cfloop query="getIDD">
 <option value="#getidd.idd#">#getidd.idd# - #getidd.country#</option>
 </cfloop>
 </select>
 </cfif>
    </td> 
 <th>Mobile</th>
  <td>
<cfif hcomid eq 'asaiki_i'><input type="text" name="idd" id="idd" readonly size="1" value="#left(C_phone,2)#" />-<input type="text" name="C_mobile" id="C_Mobile" value="#mid(C_mobile,3,10)#" size="20" maxlength="50" /> 
<cfelse>
<input type="text" name="C_mobile" id="C_Mobile" value="#C_mobile#" size="20" maxlength="50" />
</cfif> 
</td> 
</tr>

<tr>
  
<th>Email</th>
<td>
<input type="text" name="C_email" id="C_email" value="#C_email#" maxlength="100" size="40" />  </td>
<th>Contact Group</th>
<td><input type="text" name="contactgroup" id="contactgroup" value="contactgroup"></td>
</tr>

<tr>
<th>
Customer Category</th>
<td>
<input type="text" name="Category" id="Category" value="#category1#">
   
</td>
<th>
Commodity
</th>
<td>
<input type="text" name="commodity" id="commodity" value="#commodity1#">
  
</td>
</tr>
<tr>
<th>
Business Unit
</th>
<td>
<cfquery name="getbusiness" datasource="#dts#">
select * from business
</cfquery>
<cfselect name="business" id="business">
<option value="">Please Choose a Business Unit</option>
<cfloop query="getbusiness">
<option value="#getbusiness.business#" <cfif business1 eq getbusiness.business>selected</cfif>>#getbusiness.business# - #getbusiness.desp#</option>
</cfloop>
</cfselect>
</td>
</tr>

</table>

<div name="ajaxField1" id="ajaxField1">
<table align="center" class="data" width="900">
<th colspan="4" align="center"><div align="center">Mailing Information</div></th>
</tr>
<tr>
<th rowspan="4">Mailing Street</th>

<td>
<input type="text" name="b_add1" id="b_add1" value="#b_add1#" size="40" maxlength="100" />
</td>

<th rowspan="4">Other Street</th>
<td><input type="text" name="O_add1" id="O_add1" value="#O_add1#" size="40" maxlength="100" /></td>
</tr>
<tr>
<td><input type="text" name="b_add2" id="b_add2" value="#b_add2#" size="40" maxlength="100"/></td>
<td><input type="text" name="O_add2" id="O_add2" value="#O_add2#" size="40" maxlength="100" /></td>
</tr>
<tr>
<td><input type="text" name="b_add3" id="b_add3" value="#b_add3#" size="40" maxlength="100" /></td>
<td><input type="text" name="O_add3" id="O_add3" value="#O_add3#" size="40" maxlength="100" /></td>
</tr>
<tr>
<td><input type="text" name="b_add4" id="b_add4" value="#b_add4#" size="40" maxlength="100" /></td>
<td><input type="text" name="O_add4" id="O_add4" value="#O_add4#" size="40" maxlength="100" /></td>
</tr>
<tr>
  <th>Mailing City</th>
  <td><input type="text" name="b_city" id="b_city" value="#b_city#" size="40" maxlength="100" /></td>
  <th>Other City</th>
 <td><input type="text" name="O_city" id="O_city" value="#O_city#" size="40" maxlength="100" /></td>
</tr>
<tr>
  <th>Mailing State/Province</th>
   <td><input type="text" name="b_state" id="b_state" value="#b_state#" size="40" maxlength="100" /></td>
  <th>Other State/Province</th>
   <td><input type="text" name="O_state" id="O_state" value="#O_state#" size="40" maxlength="100" /></td>
</tr>
<tr>
  <th>Mailing Zip/Postal Code</th>
  <td><input type="text" name="B_postalcode" id="B_postalcode" value="#B_postalcode#" size="40" maxlength="50" /></td>
  <th>Other Zip/Postal Code</th>
  <td><input type="text" name="O_postalcode" id="O_postalcode" value="#O_postalcode#" size="40" maxlength="50" /></td>
</tr>
<tr>

<th>Mailing Country</th>
<cfif dts neq 'vsolutionspteltd_i'>
<td ><input type="text" name="B_country" id="B_country" value="#B_country#" size="40" maxlength="100" /></td>
<cfelse>
<td>
<cfset dts3=replace(dts,'_i','_c','all')>
<cfquery name="getCountry" datasource="#dts3#">
select * from country
</cfquery>

<cfselect name="B_country" id="B_country">
<option value="">Please Choose a Country</option>
<cfloop query="getCountry">
<option value="#id#" <cfif B_country eq getCountry.id>selected</cfif>>#id# - #name#</option>
</cfloop>
</cfselect>
</td>
</cfif>

<th>Other Country</th>
<cfif dts neq 'vsolutionspteltd_i'>
<td><input type="text" name="O_country" id="O_country" value="#O_country#" size="40" maxlength="100" /></td>
<cfelse>
<cfset dts3=replace(dts,'_i','_c','all')>
<td>
<cfquery name="OgetCountry" datasource="#dts3#">
select * from country
</cfquery>

<cfselect name="O_country" id="O_country">
<option value="">Please Choose a Country</option>
<cfloop query="OgetCountry">
<option value="#id#" <cfif O_country eq OgetCountry.id>selected</cfif>>#id# - #name#</option>
</cfloop>
</cfselect>
</td>
</cfif>
</tr>
</table>

</div>
<table align="center" class="data" width="900">
<tr>
<th colspan="4" align="center"><div align="center">Other Information</div></th>
</tr>
<tr>
<th>Home Phone</th>
<td><input type="text" name="phone" id="phone" value="#phone#" size="40" maxlength="50"></td>

<th>Fax</th>
<td><input type="text" name="fax" id="fax" value="#fax#" size="40" maxlength="50"></td>
</tr><tr>
<th>Other Phone</th>
<td><input type="text" name="phonea" id="phonea" value="#phonea#" size="40" maxlength="50"></td>

<th>DOB</th>
<td><input type="text" name="dob" id="dob" value="#dob#" size="40" maxlength="50"></td>
</tr>
<tr>
<th>Assistant</th>
<td><input type="text" name="assistant" id="assistant" value="#assistant#" size="40" maxlength="100"></td>

<th>Assistant Phone</th>
<td><input type="text" name="asst_phone" id="asst_phone" value="#asst_phone#" size="40" maxlength="50"></td>
</tr>

<tr>
<th>Department</th>
<td><input type="text" name="department" id="department" value="#department#" size="40" maxlength="100"></td>

<th>Industry</th>
<td>
<cfquery name="getbusiness" datasource="#dts#">
select * from business
</cfquery>

<cfselect name="industry" id="industry">
<option value="">Please Choose a Industry</option>
<cfloop query="getbusiness">
<option value="#business#" <cfif industry1 eq getbusiness.business>selected</cfif>>#business# - #desp#</option>
</cfloop>
</cfselect>
</td> 
</tr>
<tr> 
      		<th>Designation :</th>
      		<td><input type="text" size="40" name="designation"  value="#designation#" maxlength="50"></td>
</tr>

<tr>
<th colspan="4" align="center"><div align="center">Description Information</div></th>
</tr>
<tr>
<th>Description</th>
<td colspan="3"><textarea id="description" name="description" rows="3" cols="80" maxlength="200">#description#</textarea></td>
</tr>
<tr>
        	<td colspan="4" align="center"><input name="submit" type="submit" value="  #button#  "></td>
      	</tr>
  	</table>
</cfform>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type=#target_arcust#&fromto=omerno" />			
</body>
</html>
</cfoutput>