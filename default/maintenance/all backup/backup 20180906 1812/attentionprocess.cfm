<cfif hcomid eq 'asaiki_i'>
<cfset newPhone = '#form.idd2##form.C_phone#'>
<cfset newMobile = '#form.idd##form.C_mobile#'>
<cfelse>
<cfset newPhone = form.C_phone>
<cfset newMobile = form.C_mobile>
</cfif>
<cfif form.mode eq 'create'>

<cfquery name="checkrecord" datasource="#dts#">
select * from attention where attentionno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionno)#">
</cfquery>

<cfif checkrecord.recordcount eq 0>
<cfquery name="insertcontact" datasource="#dts#">
insert into attention (attentionno,industry,
title2,commodity,category,business,
name,customerno,PHONE,FAX,PHONEA,ASSISTANT,ASST_PHONE,DOB,DEPARTMENT,DESCRIPTION,B_ADD1,B_ADD2,B_ADD3,
B_ADD4,B_CITY,B_STATE,B_POSTALCODE,B_COUNTRY,O_ADD1,O_ADD2,O_ADD3,O_ADD4,O_CITY,O_STATE,O_POSTALCODE,O_COUNTRY,C_PHONE,C_MOBILE,C_EMAIL,created_by,created_on,updated_by,updated_on,contactgroup,salutation,designation) values 

(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionno)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.industry#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commodity#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.business#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fax#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonea#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assistant#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asst_phone#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dob#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_city#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_state#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_postalcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_country#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_city#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_state#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_postalcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_country#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#newphone#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#newmobile#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.c_email#">,'#GetAuthUser()#',now(),'#GetAuthUser()#',now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactgroup#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salutation#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.designation#">)

</cfquery>

<cftry>
<cfset dts3=replace(dts,'_i','_c')>

<cfquery name="checkcrmsetup" datasource="#dts3#">
select linktoaims from generalsetup
</cfquery>

<cfif checkcrmsetup.linktoaims eq 'Y'>
<cfquery name="insertcontact" datasource="#dts3#">
insert into contact (id,<cfif dts3 eq 'vsolutionspteltd_c'>industry,</cfif>
<cfif hcomid eq 'asaiki_i'>title,commodity,category,business,</cfif>
contactname,ACCNO,PHONE,FAX,PHONEA,ASSISTANT,ASST_PHONE,DOB,DEPARTMENT,DESCRIPTION,B_ADD1,B_ADD2,B_ADD3,
B_ADD4,B_CITY,B_STATE,B_POSTALCODE,B_COUNTRY,O_ADD1,O_ADD2,O_ADD3,O_ADD4,O_CITY,O_STATE,O_POSTALCODE,O_COUNTRY,C_PHONE,C_MOBILE,C_EMAIL,created_by,created_on,updated_by,updated_on,contactgroup) values 

(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionno)#">,<cfif dts3 eq 'vsolutionspteltd_c'><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.industry#">,</cfif>
<cfif hcomid eq 'asaiki_i'>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commodity#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.business#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fax#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonea#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assistant#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asst_phone#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dob#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_city#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_state#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_postalcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_country#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_add4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_city#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_state#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_postalcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.o_country#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#newphone#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#newmobile#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.c_email#">,'#GetAuthUser()#',now(),'#GetAuthUser()#',now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactgroup#">)

</cfquery>
</cfif>

<cfcatch>
</cfcatch>
</cftry>


<cfset status="#form.attentionno# had been successfully created.">
<!--- <cfelse>
<cfset status="Duplicate Contact Name">
</cfif> --->
<cfelse>
<cfset status="Duplicate Attention #form.attentionno#">

</cfif>

<cfelseif form.mode eq 'edit'>
<cfquery name="insertvehicles" datasource="#dts#">
Update attention set
title2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title2#">,
commodity=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commodity#">,
category=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#">,
business=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.business#">,
name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
customerno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerno#">,
PHONE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
FAX =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fax#">,
PHONEA =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonea#">,
ASSISTANT =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assistant#">,
ASST_PHONE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asst_phone#">,
DOB =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dob#">,
DEPARTMENT =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,
DESCRIPTION =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,
B_ADD1 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add1#">,
B_ADD2 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add2#">,
B_ADD3 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add3#">,
B_ADD4 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add4#">,
B_CITY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_city#">,
B_STATE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_state#">,
B_POSTALCODE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_postalcode#">,
B_COUNTRY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_country#">,
O_ADD1 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add1#">,
O_ADD2 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add2#">,
O_ADD3 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add3#">,
O_ADD4 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add4#">,
O_CITY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_city#">,
O_STATE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_state#">,
O_POSTALCODE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_postalcode#">,
O_COUNTRY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_country#">,
C_PHONE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#newphone#">,
C_MOBILE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#newMobile#">,
C_EMAIL =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.C_email#">,
industry =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.industry#">,
updated_by='#huserid#',
updated_on=now(),
contactgroup = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactgroup#">,
salutation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salutation#">,
designation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.designation#">

where attentionno='#form.attentionno#'
</cfquery>

<!--- --->
<cftry>
<cfset dts3=replace(dts,'_i','_c')>

<cfquery name="checkcrmsetup" datasource="#dts3#">
select linktoaims from generalsetup
</cfquery>

<cfif checkcrmsetup.linktoaims eq 'Y'>

<cfquery name="insertvehicles" datasource="#dts3#">
Update contact set
<cfif hcomid eq 'asaiki_i'>
title2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title2#">,
commodity=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commodity#">,
category=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#">,
business=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.business#">,
</cfif> 
contactname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
ACCNO =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerno#">,
PHONE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
FAX =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fax#">,
PHONEA =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonea#">,
ASSISTANT =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assistant#">,
ASST_PHONE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asst_phone#">,
DOB =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dob#">,
DEPARTMENT =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,
DESCRIPTION =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,
B_ADD1 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add1#">,
B_ADD2 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add2#">,
B_ADD3 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add3#">,
B_ADD4 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_add4#">,
B_CITY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_city#">,
B_STATE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_state#">,
B_POSTALCODE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_postalcode#">,
B_COUNTRY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.B_country#">,
O_ADD1 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add1#">,
O_ADD2 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add2#">,
O_ADD3 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add3#">,
O_ADD4 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_add4#">,
O_CITY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_city#">,
O_STATE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_state#">,
O_POSTALCODE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_postalcode#">,
O_COUNTRY =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.O_country#">,
C_PHONE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#newphone#">,
C_MOBILE =<cfqueryparam cfsqltype="cf_sql_varchar" value="#newMobile#">,
C_EMAIL =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.C_email#">,
<cfif dts3 eq 'vsolutionspteltd_c'>
industry =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.industry#">,
</cfif>
updated_by='#GetAuthUser()#',
updated_on=now(),
contactgroup = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactgroup#">

where id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionno)#">
</cfquery>
</cfif>
<cfcatch>
</cfcatch>
</cftry>



<cfset status="#form.attentionno# had been successfully edited.">
<cfelseif form.mode eq 'delete'>
<cfquery name="checkexist" datasource="#dts#">
select * from attention where attentionno='#form.attentionno#'
</cfquery>
<cfif checkexist.recordcount gt 0>
<cfquery name="checkexist" datasource="#dts#">
delete from attention where attentionno='#form.attentionno#'
</cfquery>

<!--- --->
<cftry>
<cfset dts3=replace(dts,'_i','_c')>
<cfquery name="checkcrmsetup" datasource="#dts3#">
select linktoaims from generalsetup
</cfquery>

<cfif checkcrmsetup.linktoaims eq 'Y'>
<cfquery name="checkexist" datasource="#dts3#">
delete from contact where id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionno)#">
</cfquery>
</cfif>
<cfcatch>
</cfcatch>
</cftry>

<cfset status="#form.attentionno# had been successfully deleted.">
<cfelse>
<cfset status="Attention Does Not Exist">	
</cfif>
</cfif>
			
<cfoutput>
<form name="done" id="done" action="sattention.cfm?process=done" method="post">
	<input name="status" value="<cfoutput>#status#</cfoutput>" type="hidden">
</form>
<script>
	done.submit();
</script>
</cfoutput>
