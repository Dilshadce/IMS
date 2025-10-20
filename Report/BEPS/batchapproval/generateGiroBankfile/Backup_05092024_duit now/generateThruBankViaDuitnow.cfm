<!---<cfif form.giropaydate neq "">
	<cfquery datasource="#dts#">
		UPDATE assignmentslip set giropaydate = '#form.giropaydate#' WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
	</cfquery>
</cfif>--->
<cfif isdefined('form.batch') eq false>
	<cfoutput>
	<script type="text/javascript">
		alert('Please Choose At Least One Batch!');
        window.close();
        </script>
	</cfoutput>
	<cfabort>
</cfif>

<cfset dts_p = replace(dts,'_i','_p')>
<cfset hcomid = replace(dts,'_p','')>
<cfset DTS_MAIN = "payroll_main">

<cfif form.batch neq ''>
    
<cfquery name="gs_qry" datasource="payroll_main">
SELECT mmonth, myear FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>
    
<cfquery name="getempnolist" datasource="#replace(dts,'_p','_i')#">
SELECT empno,branch FROM assignmentslip WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
</cfquery>
    
<cfquery name="updategenerated" datasource="#dts#">
UPDATE argiro
SET generated_on=now(),
    generated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">
WHERE batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">) 
AND appstatus='Approved'
</cfquery>
</cfif>

<!---Updated by Nieo, 20171103 1102, to update accuracy of bankfile--->
<!---<cfquery name="getbatches" datasource="#dts#">
select uuid from argiro
where batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
and trim(appstatus) = "Approved"
</cfquery>--->

<cfquery name="getpay_qry" datasource="#dts#">
select 
    a.batchno,a.giropaydate,sum(a.netpay) as netpay,b.name,b.bankcode,
    b.bankaccno,b.nric,b.nricn,b.passport,b.national,b.add1,b.add2,a.empno 
from icgiro as a
inner join #dts_p#.pmast as b 
on a.empno=b.empno
inner join argiro as ar
on a.batchno=ar.batchno and a.uuid=ar.uuid
where a.batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
    <cfif form.exclude neq ''>
    and a.empno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(form.exclude,' ','')#" list="yes" separator=",">)
    </cfif>
and trim(appstatus) = "Approved"    
and a.generated_on = '0000-00-00 00:00:00'
group by a.empno
having netpay>0
</cfquery>
<!---Updated by Nieo, 20171103 1102, to update accuracy of bankfile--->
    
<cfquery name="getentity" datasource="#dts#">
select debitbankaccno from invaddress
where shortcode="#getempnolist.branch#"
GROUP BY shortcode
</cfquery>

<cfset filenewdir = "#Hrootpath#\Download\#replace(dts,'_i','')#\">
			<cfif DirectoryExists(filenewdir) eq false>
            <cfdirectory action = "create" directory = "#filenewdir#" >
            </cfif>
            <cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">
            <cfset filedir = filenewdir&"file"&huserid&"_"&timenow&".txt">
                
            <cfinclude template="MY/duitnow.cfm">
            



<!---<cfabort>--->

<!---<cfset filename="DATAFILE">


		<cfset yourFileName="#filedir#">
		<cfset yourFileName2="#filename#.txt">

		 <cfcontent type="application/x-unknown">

		<cfset thisPath = ExpandPath("#yourFileName#")>
		<cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
		<cfheader name="Content-Description" value="This is a tab-delimited file.">
		<cfcontent type="Multipart/Report" file="#yourFileName#">
		<cflocation url="#yourFileName#">--->