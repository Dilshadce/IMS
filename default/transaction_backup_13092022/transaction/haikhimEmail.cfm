<cfoutput>

<cfif checkPrinted.printstatus eq '' or lcase(huserid) eq "ultralung">
<cfset url.type=url.tran>
<cfset url.refno=url.nexttranno>

<cfquery name="getitemlist" datasource="#dts#">
	select itemno from ictran where type="RQ" and refno="#url.refno#"
</cfquery>

<cfset rqitemlist=valuelist(getitemlist.itemno)>

<cfquery name="checkhaikhim" datasource="#dts#">
		SELECT itemno,desp,qty-projectqty as exceedqty,created_on FROM(
		select a.itemno,a.desp,sum(a.qty) qty,ifnull(b.qty,0) as projectqty,c.created_on from ictran as a
        left join(select sum(qty+exceedqty) as qty,itemno from projectdetail where source="#checkPrinted.source#"
        group by itemno)as b on a.itemno=b.itemno
        left join (select created_on,refno from artran where type="RQ" and source="#checkPrinted.source#" and refno="#url.refno#")as c
        on a.refno=c.refno
        
        where type="RQ" and source="#checkPrinted.source#"
        and (void="" or void is null)
        group by itemno
        ) AS AA
        WHERE QTY > projectqty
        AND itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#rqitemlist#">)
</cfquery>

<cfif checkhaikhim.recordcount neq 0>

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

<cfif lcase(huserid) eq "ultralung">
<cfset email1="weelung@mynetiquette.com">
</cfif>


<cfif getgeneralmail.useremail neq ''>

<cfset unlockcode  = "a2"&url.type&url.refno&dateformat(checkhaikhim.created_on,'yyyymmdd')&timeformat(checkhaikhim.created_on,'HHMMSS')&dts>

<cfmail from="noreply@mynetiquette.com" to="#email1#" 
			subject="#url.type#-#url.refno#"
		>
#unlockcode#
Kindly Approve The Bill No #url.refno# For Project #checkPrinted.source# Which Exceed Preapproved Quantity :-
<cfloop query="checkhaikhim">
Item No    :#checkhaikhim.itemno# 
Description    :#checkhaikhim.desp# 
Exceed Qty :#checkhaikhim.exceedqty#
</cfloop>
To Approve Click click on link below.

http://crm.netiquette.asia/haikhimbillapprove.cfm?comid=#URLENCODEDFORMAT(dts)#&status=approve&billtype=#URLENCODEDFORMAT(url.type)#&refno=#URLENCODEDFORMAT(url.refno)#&code=#hash(unlockcode)#

To Reject Click click on link below.

http://crm.netiquette.asia/haikhimbillapprove.cfm?comid=#URLENCODEDFORMAT(dts)#&status=reject&billtype=#URLENCODEDFORMAT(url.type)#&refno=#URLENCODEDFORMAT(url.refno)#&code=#hash(unlockcode)#

</cfmail>


</cfif>

<script type="text/javascript">
alert("Qty Exceed Budget Email has been send For Admin Approval");
</script>


<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a2' where type='#url.type#'and refno='#url.refno#'
</cfquery>

<cfelse>


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

<cfif lcase(huserid) eq "ultralung">
<cfset email1="weelung@mynetiquette.com">
</cfif>

<cfquery name="gethaikhimbillitem" datasource="#dts#">
	select itemno,desp,qty from ictran where refno="#url.refno#" and type="RQ"
</cfquery>

<cfif getgeneralmail.useremail neq ''>

<cfmail from="noreply@mynetiquette.com" to="#email1#" 
			subject="#url.type#-#url.refno#">

Bill No #url.refno# For Project #checkPrinted.source# Has Been Created With Item :-
<cfloop query="gethaikhimbillitem">
Item No        :#gethaikhimbillitem.itemno# 
Description    :#gethaikhimbillitem.desp# 
Qty :#gethaikhimbillitem.qty#
</cfloop>

</cfmail>
</cfif>

<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a3' where type='#url.type#'and refno='#url.refno#'
</cfquery>

</cfif>

</cfif>

</cfoutput>