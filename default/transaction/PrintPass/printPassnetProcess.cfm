<cfquery name="getgsetup" datasource="#dts#">
select printapproveamt from gsetup;
</cfquery>

<cfquery name="getTypeBill" datasource="#dts#">
SELECT file_name from customized_format where type='#url.type#'
</cfquery>

<cfquery name="getbillstatus" datasource="#dts#">
select printstatus,created_by,grand,custno,name,CREATED_ON from artran where type='#url.type#' and refno='#url.refno#'
</cfquery>
<cfquery name="checkpassword" datasource="main">
SELECT userID from users Where 
userid='#huserid#' 
and userDept = "#dts#" 
and userPwd = "#hash(form.passwordString)#"
<cfif getbillstatus.printstatus eq "a1">
and (userGrpId = 'guser' or userGrpId = 'admin' or userGrpId = 'super')
<cfelseif getbillstatus.printstatus eq "a2">
and (userGrpId = 'admin' or userGrpId = 'super')
</cfif>

</cfquery>
<cfif checkpassword.recordcount neq 0>

<cfif isdefined('url.reject')>
       <cfquery name="getartran" datasource="#dts#">
        select * from artran where type='#url.type#' and refno='#url.refno#'
        </cfquery>
        <cfset thisdate=CreateDate(year(getartran.wos_date),month(getartran.wos_date),day(getartran.wos_date))>
        <cfset thistrdatetime=CreateDateTime(year(getartran.trdatetime),month(getartran.trdatetime),day(getartran.trdatetime),hour(getartran.trdatetime),minute(getartran.trdatetime),second(getartran.trdatetime))>
        <cfquery datasource="#dts#" name="insert">
		insert into artranat 
		(TYPE,REFNO,CUSTNO,FPERIOD,WOS_DATE,DESP,DESPA,
		<cfswitch expression="#url.type#">
			<cfcase value="RC,CN,OAI" delimiters=",">
				CREDITAMT
			</cfcase>
			<cfdefaultcase>
				DEBITAMT
			</cfdefaultcase>
		</cfswitch>,
		TRDATETIME,USERID,REMARK,CREATED_BY,UPDATED_BY,CREATED_ON,UPDATED_ON)
		values
		('#url.type#','#url.refno#','#getartran.custno#','#getartran.fperiod#',#thisdate#,'#getartran.desp#','#getartran.despa#',
		<cfswitch expression="#type#">
			<cfcase value="RC,CN,OAI" delimiters=",">
				'#getartran.CREDITAMT#'
			</cfcase>
			<cfdefaultcase>
			'#getartran.DEBITAMT#'
			</cfdefaultcase>
		</cfswitch>,
		<cfif getartran.trdatetime neq "" and getartran.trdatetime neq "0000-00-00 00:00:00">#thistrdatetime#<cfelse>'0000-00-00 00:00:00'</cfif>,
		'#getartran.userid#','Voided','#getartran.created_by#','#Huserid#',
		<cfif getartran.created_on neq "">#createdatetime(year(getartran.created_on),month(getartran.created_on),day(getartran.created_on),hour(getartran.created_on),minute(getartran.created_on),second(getartran.created_on))#<cfelse>'0000-00-00 00:00:00'</cfif>,
		#now()#)
	</cfquery>
        
        <cfquery name="updatevoid" datasource="#dts#">
        update artran set void='Y' where type='#url.type#' and refno='#url.refno#'
        </cfquery> 
        
        <cfquery name="updatevoid1" datasource="#dts#">
        update ictran set void='Y' where type='#url.type#' and refno='#url.refno#'
        </cfquery>
        <cfoutput>
        <h4>#url.type# #url.refno# has been successfully rejected</h4>
		</cfoutput>
<cfelse>


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

<cfif getbillstatus.printstatus eq ''>
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

<cfif email1 neq ''>

<cfoutput>
<cfset unlockcode  = "a1"&url.type&url.refno&dateformat(getbillstatus.created_on,'yyyymmdd')&timeformat(getbillstatus.created_on,'HHMMSS')&dts>
<cftry>
<cfmail from="noreply@mynetiquette.com" to="#email1#" 
			subject="#url.type#-#url.refno#"
		> <cfmailparam file = "#HRootPath#\billformat\#dts#\#url.refno#.pdf" >
This message was sent by an automatic mailer built with cfmail:
= = = = = = = = = = = = = = = = = = = = = = = = = = =

Kindly Approve The Below Bill For Printing.
PO No : #url.refno#
Supplier Name:#getbillstatus.name#
Total Amount:#getbillstatus.grand#

To Approve Click click on link below.

http://crm.netiquette.com.sg/billapprovenet.cfm?comid=#URLENCODEDFORMAT(dts)#&billtype=#URLENCODEDFORMAT(url.type)#&refno=#URLENCODEDFORMAT(url.refno)#&code=#hash(unlockcode)#


In Case Above Link Does Not Work Click On Link Below

http://crm.mynetiquette.com/billapprovenet.cfm?comid=#URLENCODEDFORMAT(dts)#&billtype=#URLENCODEDFORMAT(url.type)#&refno=#URLENCODEDFORMAT(url.refno)#&code=#hash(unlockcode)#

</cfmail>
<cfcatch>
</cfcatch>
</cftry>
</cfoutput>

</cfif>


<h4>Email has been send For General Approval</h4>
<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a1' where type='#url.type#'and refno='#url.refno#'
</cfquery>

<!---general user approval ---->
<cfelseif getbillstatus.printstatus eq 'a1'>

<cfquery name="checkadmin" datasource="main">
SELECT userGrpId from users Where userid='#huserid#' and userDept = "#dts#"
</cfquery>

<cfif checkadmin.userGrpId eq 'guser' or checkadmin.userGrpId eq 'admin' or checkadmin.userGrpId eq 'super'>
<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a3' where type='#url.type#'and refno='#url.refno#'
</cfquery>
<h4>Transaction Printing has been allowed</h4>
</cfif>

<cfelseif getbillstatus.printstatus eq 'a2'>

<cfquery name="checkadmin" datasource="main">
SELECT userGrpId from users Where userid='#huserid#' and userDept = "#dts#"
</cfquery>

<cfif checkadmin.userGrpId eq 'guser' or checkadmin.userGrpId eq 'admin' or checkadmin.userGrpId eq 'super'>
<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a3' where type='#url.type#'and refno='#url.refno#'
</cfquery>
<h4>Transaction Printing has been allowed</h4>
</cfif>

<cfelse>

</cfif>
</cfif>

<input type="submit" name="submit_btn" value="Close" onclick="ColdFusion.Window.hide('printpass');javascript:location.reload(true);"  />

<cfelse>
<h4>Wrong Password</h4>
<cfform action="/default/transaction/printpass/printpass.cfm?type=#url.type#&refno=#url.refno#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>