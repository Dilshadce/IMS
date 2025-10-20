<cfif isdefined('url.id')>
<cfsetting showdebugoutput="no">
<cfquery name="updaterow" datasource="#dts#">
UPDATE argiro SET 
appstatus = "Approved",
approved_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
approved_on = now()
WHERE id = "#url.id#"
</cfquery>

<cfquery name="getbatchno" datasource="#dts#">
SELECT batchno,submited_by FROM argiro WHERE id = "#url.id#"
</cfquery>

<cfquery name="getassignment" datasource="#dts#">
SELECT empno,paydate,invoiceno,refno FROM assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
</cfquery>

<cfloop query="getassignment">
<cfquery name="lockartran" datasource="#dts#">
UPDATE artran SET posted = 'P' 
WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.invoiceno#">
</cfquery>
<cfquery name="lockassign" datasource="#dts#">
UPDATE assignmentslip SET posted = 'P' 
WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.refno#">
</cfquery>
    
<!---Added by Nieo 20170828, for payout after approval--->
<cfset dts_p = replace(dts,'_i','_p')>
<cfquery name="checkemp" datasource="#dts_p#">
SELECT empno FROM payout_tm
WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
</cfquery>
    
<cfif checkemp.recordcount eq 0>
    
    <cfquery name="insertintopayout" datasource="#dts_p#">
    INSERT INTO payout_tm SELECT * FROM pay_tm
    WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
    </cfquery>
    
<cfelse>
    <cfquery name="checkempprevious" datasource="#dts_p#">
    SELECT empno FROM previous_payout_tm
    WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
    </cfquery>
    
        <cfif checkempprevious.recordcount eq 0>
            <cfquery name="insertintorejected_payout" datasource="#dts_p#">
            INSERT INTO previous_payout_tm SELECT * FROM pay_tm
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
        <cfelse>
            <cfquery name="deletepayoutrecord" datasource="#dts_p#">
            DELETE FROM previous_payout_tm
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
            <cfquery name="insertintorejected_payout" datasource="#dts_p#">
            INSERT INTO previous_payout_tm SELECT * FROM pay_tm
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
        </cfif>
            
    <cfquery name="deletepayoutrecord" datasource="#dts_p#">
    DELETE FROM payout_tm
    WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
    </cfquery>
    <cfquery name="insertintopayout" datasource="#dts_p#">
    INSERT INTO payout_tm SELECT * FROM pay_tm
    WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
    </cfquery>
    
</cfif>
<!---Added by Nieo 20170828, for payout after approval--->
    
</cfloop>
                
<!---Added by Nieo 20171002 0924, Entity Statutory Amount Separation--->
<cfquery name="gqry" datasource="payroll_main">
SELECT mmonth,myear from gsetup where comp_id = '#replace(HcomID,'_i','')#'
</cfquery>                

<cfquery name="getassignmententity" datasource="#dts#">
    SELECT empno
    FROM assignmentslip 
    WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#"> 
    GROUP BY empno
</cfquery>
             
<cfloop query="getassignmententity">
    <cfquery name="checkentity" datasource="#dts#">
        SELECT branch FROM assignmentslip 
        WHERE empno = "#getassignmententity.empno#"
        AND batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#"> 
        GROUP BY branch
    </cfquery>

    <cfset epfwwb=0>
    <cfset epfccb=0>
    <cfset socsowwb=0>
    <cfset socsoccb=0>

    <cfloop query="checkentity">
        <cfquery name="getpayweek" datasource="#dts#">
            SELECT emppaymenttype FROM assignmentslip 
            WHERE payrollperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gqry.mmonth#"> 
            AND empno = "#getassignmententity.empno#"
            AND branch="#checkentity.branch#"
            AND batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#"> 
        </cfquery>

        <cfloop query="getpayweek">
            <cfquery name="getpayweekdetails" datasource="#dts_p#">
                SELECT epfww,epfcc,socsoww,socsocc FROM #getpayweek.emppaymenttype# 
                WHERE empno = "#getassignmententity.empno#"
            </cfquery>

            <cfset epfwwb+=val(getpayweekdetails.epfww)>
            <cfset epfccb+=val(getpayweekdetails.epfcc)>
            <cfset socsowwb+=val(getpayweekdetails.socsoww)>
            <cfset socsoccb+=val(getpayweekdetails.socsocc)>
        </cfloop>
                
        <cfquery name="checkpayout_stat" datasource="#dts_p#">
            SELECT empno FROM payout_stat
            WHERE empno="#getassignmententity.empno#"
            AND entity=<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkentity.branch#">
        </cfquery>
            
        <cfif checkpayout_stat.recordcount eq 0>
            <cfquery name="insertpayout_stat" datasource="#dts_p#">
                INSERT INTO payout_stat
                (
                empno,
                epfww,
                epfcc,
                socsoww,
                socsocc,
                entity
                )
                values
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmententity.empno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#epfwwb#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#epfccb#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#socsowwb#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#socsoccb#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkentity.branch#">    
                )
            </cfquery>
        <cfelse>
            <cfquery name="updatepayout_stat" datasource="#dts_p#">
                UPDATE payout_stat 
                SET
                epfww=<cfqueryparam cfsqltype="cf_sql_varchar" value="#epfwwb#">,
                epfcc=<cfqueryparam cfsqltype="cf_sql_varchar" value="#epfccb#">,
                socsoww=<cfqueryparam cfsqltype="cf_sql_varchar" value="#socsowwb#">,
                socsocc=<cfqueryparam cfsqltype="cf_sql_varchar" value="#socsoccb#">
                WHERE empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmententity.empno#">
                AND entity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkentity.branch#"> 
            </cfquery>
        </cfif>
    </cfloop>
</cfloop>
<!---Added by Nieo 20171002 0924, Entity Statutory Amount Separation--->

 <cfquery name="getemail" datasource="main">
    SELECT userEmail FROM users WHERE 
    userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.submited_by#">
    and userbranch = "#dts#"
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
SELECT compro,mailserver,mailport,mailuser,mailpassword,dfemail FROM gsetup
</cfquery>

<cfset bccmail = "noreply@mynetiquette.com">
<cfif trim(getgsetup.dfemail) neq "">
<cfset bccmail = trim(getgsetup.dfemail)>
</cfif>

<cfif trim(getemail.useremail) neq "">
<cfif isvalid('email',trim(getemail.userEmail))>
<!--- <cfmail from="#getgsetup.mailuser#" to="#trim(getemail.useremail)#" server="#getgsetup.mailserver#" username="#getgsetup.mailuser#" password="#getgsetup.mailpassword#" port="#getgsetup.mailport#" bcc="#bccmail#" type="html" subject="Batch #getbatchno.batchno# has been approved">
Dear #getbatchno.submited_by#<br>
<br>
The batch report #getbatchno.batchno# has been approved.<br>
<br>
Please proceed to make payment.<br>
<br><br>
Regards,<br>
<br>
#getgsetup.compro#
</cfmail> --->
</cfif> 
</cfif>
           

<cfoutput>
Approved
</cfoutput>
</cfif>