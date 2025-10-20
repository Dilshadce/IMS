<cfif form.empno EQ "" OR form.batch EQ "">
	INVALID
	<cfexit>
</cfif>
<cfif form.giropaydate neq "">
	<cfquery datasource="#dts#">
		UPDATE assignmentslip set giropaydate = '#form.giropaydate#'
		 WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
		 AND empno = #form.empno#
	</cfquery>
</cfif>
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
    SELECT empno,branch FROM assignmentslip 
    WHERE batches = '#form.batch#'
    AND empno = "#form.empno#"
    </cfquery>
</cfif>
    
<cfquery name="getbatches" datasource="#dts#">
SELECT uuid FROM argiro
WHERE batchno = '#form.batch#'
AND trim(appstatus) = "Approved"
</cfquery>
    
<!---Added by Nieo 20171005 1059--->
<cfquery name="updategenerated" datasource="#dts#">
UPDATE icgiro
SET generated_on=now(),
    generated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">
WHERE batchno= '#form.batch#'
AND empno = "#form.empno#"
AND uuid in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatches.uuid)#" list="yes" separator=",">)
</cfquery>
<!---Added by Nieo 20171005 1059--->
    
<cfquery name="getpay_qry" datasource="#dts#">
SELECT a.batchno,a.giropaydate,sum(a.netpay) as netpay,b.name,b.bankcode,b.bankaccno,b.nric,b.nricn,b.passport,b.national,b.add1,b.add2,a.empno 
FROM icgiro as a
INNER JOIN #dts_p#.pmast as b on a.empno=b.empno
WHERE uuid in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatches.uuid)#" list="yes" separator=",">)
AND batchno = '#form.batch#'
AND a.empno = "#form.empno#"
</cfquery>
    
<cfquery name="getentity" datasource="#dts#">
SELECT debitbankaccno FROM invaddress
WHERE shortcode="#getempnolist.branch#"
GROUP BY shortcode
</cfquery>
    
<cfset filenewdir = "#Hrootpath#\download\#dts#\">
			<cfif DirectoryExists(filenewdir) eq false>
            <cfdirectory action = "create" directory = "#filenewdir#" >
            </cfif>
            <cfset filedir = filenewdir&"file"&huserid&".txt">
                
            <cfinclude template="MY/maybank.cfm">
