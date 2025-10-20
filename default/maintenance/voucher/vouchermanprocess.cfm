<cfif val(form.transferamount) neq 0>
<cfquery name="insertvaluefrom" datasource="#dts#">
INSERT INTO vouchertran (voucherno,usagevalue,wos_date,refno,type,created_by,created_on)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernumfrom#">,
"0",
"#dateformat(now(),'YYYY-MM-DD')#",
"Deduct Balance",
'Transfer',
'#huserid#',
now()
)
</cfquery>

<cfquery name="insertvalueto" datasource="#dts#">
INSERT INTO vouchertran (voucherno,usagevalue,wos_date,refno,type,created_by,created_on)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernumto#">,
"0",
"#dateformat(now(),'YYYY-MM-DD')#",
"Increase Balance",
'Transfer',
'#huserid#',
now()
)
</cfquery>

<cfquery name="getid" datasource="#dts#">
select max(id) as id from vouchertran
</cfquery> 

<cfquery name="insertvouchertrantemp" datasource="#dts#">
INSERT INTO vouchertrantemp (idfrom,vouchernofrom,usagevaluefrom,wos_date,refno,type,created_by,created_on,approved,idto,vouchernoto,usagevalueto)
VALUES
(
'#getid.id-1#',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernumfrom#">,
"#val(form.transferamount)#",
"#dateformat(now(),'YYYY-MM-DD')#",
"Adjustment",
'Adjustment',
'#huserid#',
now(),
'',
'#getid.id#',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernumto#">,
"#val(form.transferamount)*-1#"
)
</cfquery>

<cfquery name="checkfull" datasource="#dts#">
SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where a.voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernumfrom#">
</cfquery>

<!---- ----->
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

<cftry>
<cfmail from="noreply@mynetiquette.com" to="#email1#" 
			subject="Voucher transfer has been created"
		>
This message was sent by an automatic mailer built with cfmail:
= = = = = = = = = = = = = = = = = = = = = = = = = = =

Voucher from : #form.vouchernumfrom#
Voucher to   : #form.vouchernumto#
Transfer Amount : #form.transferamount#
Created By : #huserid#

</cfmail>
<cfcatch>
</cfcatch>
</cftry>
</cfoutput>

</cfif>
<!---  ----->

<cfif val(checkfull.value) lte 0>
<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "Y",updated_by ="#HuserId#",updated_on = now()  where voucherno = '#form.vouchernumfrom#'
</cfquery>
<cfelse>
<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "N",updated_by ="#HuserId#",updated_on = now()  where voucherno = '#form.vouchernumfrom#'
</cfquery>
</cfif>

<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "N",updated_by ="#HuserId#",updated_on = now()  where voucherno = '#form.vouchernumto#'
</cfquery>


<script type="text/javascript">
alert('Transfer has been submitted!');
window.location.href="vouchermaintenance.cfm";
</script>
<cfelse>
<script type="text/javascript">
alert('Transfer amount is not valid');
history.go(-1);
</script>
</cfif>