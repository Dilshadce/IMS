<cfif form.empno EQ "" OR form.batch EQ "">
	INVALID
	<cfexit>
</cfif>
<!---<cfif form.giropaydate neq "">
	<cfquery datasource="#dts#">
		UPDATE assignmentslip set giropaydate = '#form.giropaydate#'
		 WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
		 AND empno = #form.empno#
	</cfquery>
        
    <cfquery datasource="#dts#">
    UPDATE icgiro ic, argiro ar 
        set ic.giropaydate = '#form.giropaydate#'
     WHERE ic.batchno = ar.batchno and ic.uuid=ar.uuid
    and ic.batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
     AND ic.empno = #form.empno#
    and ar.appstatus="Approved"
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
    SELECT empno,branch FROM assignmentslip 
    WHERE batches = '#form.batch#'
    AND empno = "#form.empno#"
    </cfquery>
</cfif>
    
<!---Updated by Nieo 20171103 1122--->
<!---<cfquery name="getbatches" datasource="#dts#">
SELECT uuid FROM argiro
WHERE batchno = '#form.batch#'
AND trim(appstatus) = "Approved"
</cfquery>--->
    
<!---Added by Nieo 20171005 1059--->
<cfquery name="checkgenerated" datasource="#dts#">
SELECT * FROM icgiro ic 
    LEFT JOIN argiro ar
    ON ic.batchno=ar.batchno AND ic.uuid=ar.uuid
WHERE ic.batchno= '#form.batch#'
AND ic.empno = "#form.empno#"
AND ar.appstatus="Approved"
AND ic.generated_on <> '0000-00-00 00:00:00'
</cfquery>
<!---Added by Nieo 20171005 1059--->

<!---Added by Nieo 20171005 1059--->
<cfquery name="updategenerated" datasource="#dts#">
UPDATE icgiro ic,argiro ar
SET ic.generated_on=now(),
    ic.generated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">
WHERE ic.batchno= '#form.batch#'
AND ic.empno = "#form.empno#"
AND ic.batchno=ar.batchno
AND ic.uuid=ar.uuid
AND ar.appstatus="Approved"
</cfquery>
<!---Added by Nieo 20171005 1059--->
    
<cfquery name="getpay_qry" datasource="#dts#">
SELECT a.batchno,a.giropaydate,sum(a.netpay) as netpay,b.name,b.bankcode,b.bankaccno,b.nric,b.nricn,b.passport,b.national,b.add1,b.add2,a.empno 
FROM icgiro as a
INNER JOIN #dts_p#.pmast as b 
on a.empno=b.empno
inner join argiro as ar
on a.batchno=ar.batchno and a.uuid=ar.uuid
WHERE trim(appstatus) = "Approved"
AND a.batchno = '#form.batch#'
AND a.empno = "#form.empno#"
</cfquery>
    
<cfset getpay_qry.giropaydate = form.giropaydate>
<!---Updated by Nieo 20171103 1122--->
    
<cfquery name="getentity" datasource="#dts#">
SELECT debitbankaccno FROM invaddress
WHERE shortcode="#getempnolist.branch#"
GROUP BY shortcode
</cfquery>
    
<cfset filenewdir = "#Hrootpath#\download\#dts#\">
			<cfif DirectoryExists(filenewdir) eq false>
            <cfdirectory action = "create" directory = "#filenewdir#" >
            </cfif>
            <cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">
            <cfset filedir = filenewdir&"file"&huserid&"_"&timenow&".txt">
                
            <cfinclude template="MY/maybank.cfm">
