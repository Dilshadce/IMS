<cfoutput>
<cfquery name="getbillstatus" datasource="#dts#">
select printstatus,created_by,grand,custno,name,created_on from artran where type='#url.type#' and refno='#url.refno#'
</cfquery>
<cfif getbillstatus.printstatus eq ''>
<cfif isdefined('url.type')>
<cfset trantype=''>
<cfif url.type eq 'INV'>
<cfset trantype='Invoice'>
<cfelseif url.type eq 'CS'>   
<cfset trantype='Cash Sales'>
<cfelseif url.type eq 'PO'>   
<cfset trantype='Purchase Order'>
<cfelseif url.type eq 'PR'>   
<cfset trantype='Purchase Return'>
<cfelseif url.type eq 'RC'>   
<cfset trantype='Purchase Receive'>
<cfelseif url.type eq 'DO'>   
<cfset trantype='Delivery Order'>
<cfelseif url.type eq 'Quo'>   
<cfset trantype='Quotation'>
<cfelseif url.type eq 'CN'>   
<cfset trantype='Credit Note'>
<cfelseif url.type eq 'DN'>   
<cfset trantype='Debit Note'>
<cfelseif url.type eq 'SO'>   
<cfset trantype='Sales Order'>
<cfelseif url.type eq 'SAM'>   
<cfset trantype='Sample'>
</cfif>
</cfif>
<!---
    <cfset copy1=GetDirectoryFromPath(GetTemplatePath()) &"..\..\..\billformat\general\printpass_preprintedformat.cfm">
    <cfset paste1=GetDirectoryFromPath(GetTemplatePath()) &"..\..\..\billformat\"&dts&"\">
<cffile action = "copy" source = "#copy1#" 
    destination = "#paste1#">--->

<cfquery name="getTypeBill" datasource="#dts#">
SELECT file_name from customized_format where type='#url.type#'
</cfquery>

<cfset url.tran = "#url.type#">
<cfset url.nexttranno = "#url.refno#">
<cfif getTypeBill.file_name eq "">
<h4>Does not have QUO format kindly check with admin</h4>
<cfabort>
<cfelse>
<cfset BillName = "#getTypeBill.file_name#">
</cfif>
<cfset url.pdf ="true">
<cfset doption = "0">
<cfinclude template="/billformat/#dts#/printpass_preprintedformat.cfm">

<cfquery name="getgeneralmail" datasource="main">
select useremail from users where userDept = "#dts#" and userGrpId="admin" and useremail <> ""
</cfquery>
<cfset email1=''>
<cfloop query="getgeneralmail">
<cfset email1=email1&getgeneralmail.useremail>
<cfif getgeneralmail.recordcount neq getgeneralmail.currentrow>
<cfset email1=email1&",">
</cfif>
</cfloop>

<cfif getgeneralmail.useremail neq ''>

<cfoutput>
<cfset unlockcode  = "a1"&url.type&url.refno&dateformat(getbillstatus.created_on,'yyyymmdd')&timeformat(getbillstatus.created_on,'HHMMSS')&dts>
<!--- <cftry> --->
<cfmail from="noreply@mynetiquette.com" to="#email1#" 
			subject="#url.type#-#url.refno#"
		> <cfmailparam file = "#HRootPath#\billformat\#dts#\#url.refno#.pdf" >
This message was sent by an automatic mailer built with cfmail:
= = = = = = = = = = = = = = = = = = = = = = = = = = =

Kindly Approve The Below Bill For Printing.
QUO No : #url.refno#
Supplier Name:#getbillstatus.name#
Total Amount:#getbillstatus.grand#

To Approve Click click on link below.

http://crm.netiquette.com.sg/billapprovenet.cfm?comid=#URLENCODEDFORMAT(dts)#&billtype=#URLENCODEDFORMAT(url.type)#&refno=#URLENCODEDFORMAT(url.refno)#&code=#hash(unlockcode)#

In case Above Link Does Not work Click Below Link

http://crm.mynetiquette.com/billapprovenet.cfm?comid=#URLENCODEDFORMAT(dts)#&billtype=#URLENCODEDFORMAT(url.type)#&refno=#URLENCODEDFORMAT(url.refno)#&code=#hash(unlockcode)#

</cfmail>
<!--- <cfcatch>
</cfcatch>
</cftry> --->
</cfoutput>

</cfif>

<h4>Email has been send For Admin Approval</h4>
<input type="submit" name="submit_btn" value="Close" onclick="ColdFusion.Window.hide('printpass');javascript:location.reload(true);"  />

<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a1' where type='#url.type#'and refno='#url.refno#'
</cfquery>

<cfelse> 
<div align="center">
<cfform name="form" action="/default/transaction/printpass/printPassnetProcess.cfm?type=#url.type#&refno=#url.refno#" method="post">
<cfset task = "">
<cfset task = "Printing">
<h4>Please Key in Password for #task#</h4>
<cfinput type="password" name="passwordString" required="yes" validateat="onsubmit" message="Password is Required"><br/><br />
<input type="submit" name="btn_sub" value="Submit">
<input type="submit" name="btn_sub" value="Reject" onclick="document.form.action='/default/transaction/printpass/printPassnetProcess.cfm?type=#url.type#&refno=#url.refno#&reject=1'">
<input type="button" name="submit_btn" value="Close" onclick="javascript:window.location='/default/transaction/transaction.cfm?tran=quo';"  />
 </cfform>
</div>
</cfif>
</cfoutput>