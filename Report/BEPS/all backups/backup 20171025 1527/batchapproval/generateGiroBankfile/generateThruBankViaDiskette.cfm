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

<cfquery name="getbatches" datasource="#dts#">
select uuid from argiro
where batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
and trim(appstatus) = "Approved"
</cfquery>

<cfquery name="getpay_qry" datasource="#dts#">
select a.batchno,a.giropaydate,sum(a.netpay) as netpay,b.name,b.bankcode,b.bankaccno,b.nric,b.nricn,b.passport,b.national,b.add1,b.add2,a.empno 
from icgiro as a
inner join #dts_p#.pmast as b on a.empno=b.empno
where uuid in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatches.uuid#" list="yes" separator=",">)
and batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
group by a.empno
having netpay>0
</cfquery>
    
<cfquery name="getentity" datasource="#dts#">
select debitbankaccno from invaddress
where shortcode="#getempnolist.branch#"
GROUP BY shortcode
</cfquery>

<cfset filenewdir = "#Hrootpath#\download\#dts#\">
			<cfif DirectoryExists(filenewdir) eq false>
            <cfdirectory action = "create" directory = "#filenewdir#" >
            </cfif>
            <cfset filedir = filenewdir&"file"&huserid&".txt">
                
            <cfinclude template="MY/maybank.cfm">
            



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