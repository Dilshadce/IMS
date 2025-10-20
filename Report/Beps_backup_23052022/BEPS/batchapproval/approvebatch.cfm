<cfif isdefined('url.id')>
<cfsetting showdebugoutput="yes">


<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset db=replace(dts,'_i','_p','all')> <!---dts_p--->
 
<!---Added by Nieo 20171027--->
<cfquery name="gqry" datasource="payroll_main">
SELECT mmonth,myear from gsetup where comp_id = '#HcomID#'
</cfquery>
<!---Added by Nieo 20171027--->
    
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
    
<cfquery name="lockassign" datasource="#dts#">
UPDATE assignmentslip SET posted = 'P' 
WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
</cfquery>

<cfloop query="getassignment">
    <!---Commented by Nieo 20171027, to improve approval speed, moved to bottom of this code--->
    <!---<cfquery name="lockartran" datasource="#dts#">
    UPDATE artran SET posted = 'P' 
    WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.invoiceno#">
    </cfquery>--->
    <!---Commented by Nieo 20171027, to improve approval speed, moved to bottom of this code--->
    
    <!---Moved by Nieo 20180608 1530, to improve payslip data accuracy for special occasion--->
    <!---Added by Nieo 20171027, to improve payslip data accuracy for special occasion--->
    <cfinclude template="sumpayout_tm.cfm">
    <!---Added by Nieo 20171027, to improve payslip data accuracy for special occasion--->
    <!---Moved by Nieo 20180608 1530, to improve payslip data accuracy for special occasion--->
        
    <!---Added by Nieo 20170828, for payout after approval--->
    <cfquery name="checkemp" datasource="#db#">
    SELECT empno FROM payout_tm
    WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
    </cfquery>

    <cfif checkemp.recordcount eq 0>
        
        <cfquery name="insertintopaytra1out" datasource="#db#">
        INSERT INTO paytra1_out SELECT * FROM paytra1
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>
            
        <cfquery name="insertintopaytranout" datasource="#db#">
        INSERT INTO paytran_out SELECT * FROM paytran
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>

        <cfquery name="insertintopayout" datasource="#db#">
        INSERT INTO payout_tm SELECT * FROM pay_tm
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>

    <cfelse>
        <cfquery name="checkempprevious" datasource="#db#">
        SELECT empno FROM previous_payout_tm
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>

        <cfif checkempprevious.recordcount eq 0>
            <cfquery name="insertintorejected_paytra1out" datasource="#db#">
            INSERT INTO prev_paytra1_out SELECT * FROM paytra1_out
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>

            <cfquery name="insertintorejected_paytranout" datasource="#db#">
            INSERT INTO prev_paytran_out SELECT * FROM paytran_out
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
            
            <cfquery name="insertintorejected_payout" datasource="#db#">
            INSERT INTO previous_payout_tm SELECT * FROM payout_tm
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
        <cfelse>
            <cfquery name="deletepayoutrecord" datasource="#db#">
            DELETE FROM prev_paytra1_out
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
                
            <cfquery name="deletepayoutrecord" datasource="#db#">
            DELETE FROM prev_paytran_out
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
                
            <cfquery name="deletepayoutrecord" datasource="#db#">
            DELETE FROM previous_payout_tm
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
                
            <cfquery name="insertintorejected_paytra1out" datasource="#db#">
            INSERT INTO prev_paytra1_out SELECT * FROM paytra1_out
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>

            <cfquery name="insertintorejected_paytranout" datasource="#db#">
            INSERT INTO prev_paytran_out SELECT * FROM paytran_out
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>

            <cfquery name="insertintorejected_payout" datasource="#db#">
            INSERT INTO previous_payout_tm SELECT * FROM payout_tm
            WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
            </cfquery>
        </cfif>
                
        <cfquery name="deletepayoutrecord" datasource="#db#">
        DELETE FROM paytra1_out
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>
            
        <cfquery name="deletepayoutrecord" datasource="#db#">
        DELETE FROM paytran_out
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>

        <cfquery name="deletepayoutrecord" datasource="#db#">
        DELETE FROM payout_tm
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>
            
        <cfquery name="insertintopaytra1out" datasource="#db#">
        INSERT INTO paytra1_out SELECT * FROM paytra1
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>
            
        <cfquery name="insertintopaytranout" datasource="#db#">
        INSERT INTO paytran_out SELECT * FROM paytran
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>
            
        <cfquery name="insertintopayout" datasource="#db#">
        INSERT INTO payout_tm SELECT * FROM pay_tm
        WHERE empno= <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
        </cfquery>

    </cfif>
        
    <!---Added by Nieo 20170828, for payout after approval--->
    
</cfloop>
                
<!---Added by Nieo 20171002 0924, Entity Statutory Amount Separation--->            
     
<!---Updated by Nieo 20171113 1705, Bug fixes--->          
<cfquery name="getassignmententity" datasource="#dts#">
    SELECT empno
    FROM assignmentslip 
    WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#"> 
    GROUP BY empno
</cfquery>
    
<cfquery name="getbatches" datasource="#dts#">
    SELECT batches
    FROM assignmentslip 
    WHERE payrollperiod=#gqry.mmonth#
    AND created_on > #createdate(gqry.myear,1,7)#
</cfquery> 
    
<cfquery name="getapprovedAssign" datasource="#dts#">
    select ic.batchno from icgiro ic 
    left join argiro ar 
    on ic.uuid=ar.uuid and ic.batchno=ar.batchno
    where ic.batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getbatches.batches)#" list="true">)
    and appstatus="Approved"
    group by ic.batchno
</cfquery>
             
<cfloop query="getassignmententity">
    
    <cfquery name="checkentity" datasource="#dts#">
        SELECT branch FROM assignmentslip 
        WHERE empno = "#getassignmententity.empno#"
        AND batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getapprovedAssign.batchno)#" list="true">)
        GROUP BY branch
    </cfquery>
    
        
    <cftry>
        <cfquery name="checkcolumn" datasource="#db#">
            SELECT epf_pay_a FROM payout_stat LIMIT 1
        </cfquery>
            <cfcatch type="any">
                <cfquery name="addcolumn" datasource="#db#">
                    ALTER TABLE payout_stat
                    ADD epf_pay_a decimal(13,2) DEFAULT 0.00
                </cfquery>

            </cfcatch>
    </cftry>

    <cfloop query="checkentity">
        <cfset epf_pay_ab=0>
        <cfset epfwwb=0>
        <cfset epfccb=0>
        <cfset socsowwb=0>
        <cfset socsoccb=0>
        <cfset eiswwb=0>
        <cfset eisccb=0>
        
        <cfquery name="getpayweek" datasource="#dts#">
            SELECT emppaymenttype FROM assignmentslip 
            WHERE payrollperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gqry.mmonth#"> 
            AND created_on > #createdate(gqry.myear,1,7)#
            AND empno = "#getassignmententity.empno#"
            AND branch="#checkentity.branch#"
            AND batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getapprovedAssign.batchno)#" list="true">)
        </cfquery>

        <!---Updated by Nieo 20171113 1705, Bug fixes--->  
            
        <cfloop query="getpayweek">
            <cftry>
                <cfquery name="getpayweekdetails" datasource="#db#">
                    SELECT epf_pay_a,epfww,epfcc,socsoww,socsocc,eisww,eiscc FROM #getpayweek.emppaymenttype# 
                    WHERE empno = "#getassignmententity.empno#"
                </cfquery>
                <cfcatch type="any">
                    <cfquery name="addcolumn" datasource="#db#">
                        ALTER TABLE payout_stat
                        ADD epf_pay_a decimal(13,2) DEEFAULT 0.00
                    </cfquery>
                    
                    <cfquery name="getpayweekdetails" datasource="#db#">
                        SELECT epf_pay_a,epfww,epfcc,socsoww,socsocc,eisww,eiscc FROM #getpayweek.emppaymenttype# 
                        WHERE empno = "#getassignmententity.empno#"
                    </cfquery>
                </cfcatch>
            </cftry>

            <cfset epf_pay_ab+=val(getpayweekdetails.epf_pay_a)>
            <cfset epfwwb+=val(getpayweekdetails.epfww)>
            <cfset epfccb+=val(getpayweekdetails.epfcc)>
            <cfset socsowwb+=val(getpayweekdetails.socsoww)>
            <cfset socsoccb+=val(getpayweekdetails.socsocc)>
            <cfset eiswwb+=val(getpayweekdetails.eisww)>
            <cfset eisccb+=val(getpayweekdetails.eiscc)>
        </cfloop>
            
        
              
            <!---Added by Nieo 20171121 1123 to fix EPF wage with cents issue--->	
            <cfif epf_pay_ab lte 10>
                <cfset epf_pay_ab = 0>
            <cfelseif epf_pay_ab gt 10 and epf_pay_ab lte 5000>
                <cfset epf_pay_ab = (ROUND((CEILING(epf_pay_ab/10))/2))*20>
            <cfelseif epf_pay_ab gt 5000>
                <cfset epf_pay_ab = (CEILING(epf_pay_ab/100))*100>
            </cfif>
            <!---Added by Nieo 20171121 1123 to fix EPF wage with cents issue--->

            <cfquery name="checkpayout_stat" datasource="#db#">
                SELECT empno FROM payout_stat
                WHERE empno="#getassignmententity.empno#"
                AND entity=<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkentity.branch#">
            </cfquery>


            <cfif checkpayout_stat.recordcount eq 0>
                <cfquery name="insertpayout_stat" datasource="#db#">
                    INSERT INTO payout_stat
                    (
                    empno,
                    epf_pay_a,
                    epfww,
                    epfcc,
                    socsoww,
                    socsocc,
                    eisww,
                    eiscc,
                    entity
                    )
                    values
                    (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmententity.empno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#epf_pay_ab#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#epfwwb#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#epfccb#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#socsowwb#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#socsoccb#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#eiswwb#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#eisccb#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkentity.branch#">    
                    )
                </cfquery>
            <cfelse>

                <cfquery name="updatepayout_stat" datasource="#db#">
                    UPDATE payout_stat 
                    SET
                    epf_pay_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#epf_pay_ab#">,
                    epfww=<cfqueryparam cfsqltype="cf_sql_varchar" value="#epfwwb#">,
                    epfcc=<cfqueryparam cfsqltype="cf_sql_varchar" value="#epfccb#">,
                    socsoww=<cfqueryparam cfsqltype="cf_sql_varchar" value="#socsowwb#">,
                    socsocc=<cfqueryparam cfsqltype="cf_sql_varchar" value="#socsoccb#">,
                    eisww=<cfqueryparam cfsqltype="cf_sql_varchar" value="#eiswwb#">,
                    eiscc=<cfqueryparam cfsqltype="cf_sql_varchar" value="#eisccb#">
                    WHERE empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmententity.empno#">
                    AND entity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkentity.branch#"> 
                </cfquery>

            </cfif>
    </cfloop>
</cfloop>
<!---Added by Nieo 20171002 0924, Entity Statutory Amount Separation--->
 
<!---Added by Nieo 20171027, to improve approval speed--->
<cfquery name="lockartran" datasource="#dts#">
    UPDATE artran a, (
     select invoiceno from assignmentslip 
     where batches=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#"> 
     <!---Added by Nieo 20181217, to improve approval process--->
     and invoiceno not in (
         select invoiceno from assignmentslip 
         where invoiceno in (
             select invoiceno from assignmentslip where batches=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#"> and invoiceno != '' group by invoiceno
         ) and posted='' 
         group by invoiceno
     )
     <!---Added by Nieo 20181217, to improve approval process--->
     group by invoiceno) b
    SET a.posted = 'P' 	 
    WHERE a.refno=b.invoiceno
</cfquery>
<!---Added by Nieo 20171027, to improve approval speed--->

</cfif>