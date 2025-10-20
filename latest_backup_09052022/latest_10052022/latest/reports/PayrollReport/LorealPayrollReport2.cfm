<!---Loreal Report Version 2.0--->
<cfoutput>
    
<cfset dts_p = replace(dts,'_i','_p')>
    
<cfquery name="getComp_qry" datasource="#dts#">
	SELECT * FROM gsetup
</cfquery>
    
<cfquery name="getmmonth" datasource="#dts#">
    SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
    
<!---Prepare temp excel file to write data--->
<cfset currentDirectory = "#Hrootpath#\Excel_Report\">
    
<cfset timenow = "#DateTimeFormat(now(), 'yyyymmddhhnnss')#">
    
<cfif DirectoryExists(currentDirectory) eq false>
    <cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<!---Prepare temp excel file to write data--->
    
<!---Excel Format--->
<cfset s67 = StructNew()>
<cfset s67.dataformat="_(* ##,####0.00_);_(* (##,####0.00);_(* \-??_);_(@_)">
    
<cfset s69 = StructNew()>
<cfset s69.dataformat="_(* ##,####0.0000_);_(* (##,####0.0000);_(* \-??_);_(@_)">

<cfset s23 = StructNew()>                                   
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.textwrap="true">
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_center">
<cfset s23.bottomborder="medium">
<cfset s23.topborder="medium">
<cfset s23.leftborder="medium">
<cfset s23.rightborder="medium">

<cfset s24 = StructNew()>                                   
<cfset s24.font="Arial">
<cfset s24.fontsize="11">
<cfset s24.bold="true">
<cfset s24.alignment="left">
<cfset s24.verticalalignment="vertical_bottom">

<cfset s25 = StructNew()>                                   
<cfset s25.font="Arial">
<cfset s25.fontsize="11">
<cfset s25.bold="true">
<cfset s25.alignment="right">
<cfset s25.verticalalignment="vertical_bottom">

<cfset s26 = StructNew()>                                   
<cfset s26.font="Arial">
<cfset s26.fontsize="11">
<cfset s26.bold="true">
<cfset s26.alignment="right">
<cfset s26.verticalalignment="vertical_bottom">
<cfset s26.bottomborder="thin">

<cfset s27 = StructNew()>                                   
<cfset s27.font="Arial">
<cfset s27.fontsize="11">
<cfset s27.bold="true">
<cfset s27.alignment="left">
<cfset s27.verticalalignment="vertical_bottom">
<cfset s27.bottomborder="thin">

<cfset s28 = StructNew()>
<cfset s28.bottomborder="thin">
<cfset s28.topborder="thin">
<cfset s28.leftborder="thin">
<cfset s28.rightborder="thin">

<cfset s30 = StructNew()>                  
<cfset s30.bottomborder="double">
<cfset s30.bold="true">
    
<cfset s31 = StructNew()>                                   
<cfset s31.font="Arial">
<cfset s31.fontsize="11">
<cfset s31.bold="true">
<cfset s31.textwrap="true">    
<cfset s31.alignment="center">
<cfset s31.verticalalignment="vertical_center">
<cfset s31.leftborder="medium">
<cfset s31.rightborder="medium">
    
<cfset s32 = StructNew()>                                   
<cfset s32.font="Arial">
<cfset s32.fontsize="11">
<cfset s32.bold="true">
<cfset s32.textwrap="true">    
<cfset s32.alignment="center">
<cfset s32.verticalalignment="vertical_center">
<cfset s32.bottomborder="medium">
    
<cfset s33 = StructNew()>                                   
<cfset s33.font="Arial">
<cfset s33.fontsize="11">
<cfset s33.textwrap="true">    
<cfset s33.alignment="center">
<cfset s33.verticalalignment="vertical_center">
<cfset s33.rightborder="medium">
    
<cfset s34 = StructNew()>                                   
<cfset s34.font="Arial">
<cfset s34.fontsize="11">
<cfset s34.bold="true">
<cfset s34.textwrap="true">    
<cfset s34.alignment="center">
<cfset s34.verticalalignment="vertical_center">
<cfset s34.topborder="medium">
<cfset s34.bottomborder="medium">
    
<cfset s35 = StructNew()>                                   
<cfset s35.dataformat="0.0">
    
<cfset s36 = StructNew()>                                   
<cfset s36.font="Arial">
<cfset s36.fontsize="11">
<cfset s36.bold="true">
<cfset s36.textwrap="true">    
<cfset s36.alignment="center">
<cfset s36.verticalalignment="vertical_center">
<cfset s36.topborder="medium">
<cfset s36.leftborder="medium">
<cfset s36.rightborder="medium">
    
<cfset sTextwrap = StructNew()>                                   
<cfset sTextwrap.textwrap="true">
    
<cfset s68 = StructNew()>
<cfset s68.dataformat = "d-mmm-yy">
<!---Excel Format--->

<!---Column Width--->
<cfset columnname = 49>
<cfset columnnumbers = 14>
<cfset columnsection = 17>
<!---Column Width--->
    
<!---Prepare period wording--->
<cfset thisperiod = ucase(left(monthAsString(form.period),3))>
    
<cfset lastperiod = form.period-1>
<cfset lastyear = getmmonth.myear>    

<cfif form.period eq 1>
    <cfset lastperiod = 12>
    <cfset lastyear = getmmonth.myear-1>
</cfif>
        
<cfset lastperiodnum = lastperiod>
        
<cfset lastperiod = ucase(left(monthAsString(lastperiod),3))>
<!---Prepare period wording--->
    
<cfif form.jobpostype eq "3,5">
<!---Perm--->
    
    <cfquery name="checkoldjoexist" datasource="#dts#">
        SELECT replace(replace(group_concat( distinct a.placementno),a.placementno,""),",","") old_jo 
        FROM assignmentslip a
        LEFT JOIN #replace(dts,'_i','_p')#.pmast p
        ON a.empno=p.empno
        LEFT JOIN placement pl
        ON a.placementno=pl.placementno
        WHERE payrollperiod=#form.period#
        AND a.custname like "%l'oreal%"
        AND pl.jobpostype in (#form.jobpostype#)
        AND a.empno !='0'
        AND a.empno != '100123480'<!---Advanced Billing account--->
        <!---AND selftotal--->
        AND month(a.completedate) = #form.period#
        GROUP BY a.empno
        HAVING old_jo != ''  
    </cfquery>

    <cfset reimburselist  = "6,30,1002,119,1001,120,121,122,123,1000">
    <cfset grosslist  = "19,78,6,3,124,112,111,110,129,128,79,14">
        
    <cfif checkoldjoexist.recordcount neq 0>

    <cfquery name="getpayrolldata" datasource="#dts#" cachedwithin="#createtimespan(0,0,0,30)#">
    SELECT a2.empno, replace(replace(group_concat( distinct a2.placementno),a2.placementno,""),",","") old_jo, a2.placementno current_jo,a2.empname,
        case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
        workordid,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dcomm,'1900-01-01')+2 dcomm,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dresign,'1900-01-01')+2 dresign,
    sum(
        coalesce(a.custsalary,0)
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a.allowance#a#= 11 then coalesce(a.awer#a#,0) else 0 end,0)
        </cfloop>
    ) as BasicRate,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 79 and coalesce(a.fixawer#a#,0)>0 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 79 and coalesce(a.awer#a#,0)>0  then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as GALLOW,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 79 and coalesce(a.fixawer#a#,0)<0 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 79 and coalesce(a.awer#a#,0)<0  then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as GALLOWAdj,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 9 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 9 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as Bonus,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 118 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 118 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as ExceptionalBonus,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 128 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 128 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as ExcellenceAward,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 129 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 129 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as LongService,    
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 110 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 110 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>

    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 111 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 111 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>

    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 112 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 112 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>

    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 124 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 124 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
        
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 7 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 7 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>  
    )+bp.BackPayIncen as Incentive,    
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 3 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 3 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as CarMaintenance,<!---Fixed Allowance as Car Maintenance in Loreal--->
    sum(0
    <cfloop index="i" list="#reimburselist#">
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
        </cfloop>
    </cfloop>
    )+bp.Reimbursement as Reimbursement,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 78 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 78 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as Shoe,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 14 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 14 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as AnnualLeaveinLieu,
    sum(coalesce(a.custothour2,0)) custothour2,
    sum(coalesce(a.custot2,0)) custot2,
    sum(coalesce(a.custothour3,0)) custothour3,
    sum(coalesce(a.custot3,0)) custot3,
    sum(coalesce(a.custothour4,0)) custothour4,
    sum(coalesce(a.custot4,0)) custot4,
    sum(0
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 12 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    )+bp.otadjust otadjust,
    sum(coalesce(a.custottotal,0)) custottotal, <!---Column W or X--->    
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 19 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 19 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="10">
        + coalesce(a.lvltotaler#a#,0)
    </cfloop>
    )+bp.UnpaidLeave as UnpaidLeave,
    sum(coalesce(bp.BackPayWage,0)) as BackPayWage,<!---Back Pay Wage--->  
    sum(coalesce(bp.BackPayGA,0)) as BackPayGA,<!---Back Pay GA--->  
    sum(0
    + coalesce(a.custsalary,0)
    + coalesce(a.custottotal,0)
    + coalesce(bp.BackPayWage,0)  
    + coalesce(bp.BackPayGA,0)
    <cfloop index="i" list="#grosslist#">
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
        </cfloop>
    </cfloop>
    <cfloop  index="a" from="1" to="10">
        + coalesce(a.lvltotaler#a#,0)
    </cfloop>
    ) as  GrossWage,<!---Total Gross Wage--->
    sum(coalesce(pay.custcpf,0)) as ER_EPF,  
    sum(coalesce(pay.custsdf,0)) as ER_SOCSO,  
    sum(coalesce(pay.custeis,0)) as ER_EIS,  
    sum(coalesce(a.adminfee,0))+bp.AdminFee as AdminFee, 
    sum(coalesce(a.custtotalgross,0)+ coalesce(bp.custtotalgross,0)) as TotalBilling, <!---Total Billing--->
    <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
        sum(( CAST((0
        <cfloop index="i" list="#reimburselist#">
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
            </cfloop>
        </cfloop>
            + coalesce(a.adminfee,0)
            +bp.AdminFee
        ) AS DECIMAL(15,5)))*a2.taxper/100) as TotalGST,<!---6% GST--->
        (sum(coalesce(a.custtotalgross,0)+ coalesce(bp.custtotalgross,0))+(sum(( CAST((0
        <cfloop index="i" list="#reimburselist#">
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
            </cfloop>
        </cfloop>
            + coalesce(a.adminfee,0)
            +bp.AdminFee
        ) AS DECIMAL(15,5)))*a2.taxper/100))) as TotalBillingWGST,<!---Total Billing with GST--->
    <cfelse>
        ((CAST(coalesce(a.custtotalgross,0) AS DECIMAL(15,5))+ CAST(coalesce(bp.custtotalgross,0) AS DECIMAL(15,5)))*a2.taxper/100) as TotalGST,<!---6% GST--->
        (sum(coalesce(a.custtotalgross,0)+ coalesce(bp.custtotalgross,0) )+((CAST(coalesce(a.custtotalgross,0) AS DECIMAL(15,5))+ CAST(coalesce(bp.custtotalgross,0) AS DECIMAL(15,5)))*a.taxper/100)) as TotalBillingWGST,<!---Total Billing with GST--->    
    </cfif>
    concat(
        case when 
        sum(coalesce(a.lvleedayhr1,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr1,0)) as char(45))," day(s) in #thisperiod#") else "" end,<!---current month NPL--->
        case when sum(coalesce(a.lvleedayhr1,0))>0 then ", " else "" end,<!---comma--->
        case when sum(coalesce(a.lvleedayhr2,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr2,0)) as char(45))," day(s) in #lastperiod#") else "" end,<!---previous month NPL--->
        case when sum(coalesce(a.lvleedayhr1,0))>0 or sum(coalesce(a.lvleedayhr2,0))>0 then ", " else "" end,<!---comma--->
        a.lorealremarks,
        bp.lorealremarks
        )  as Remark,
    a2.taxper

    FROM (
        SELECT * FROM assignmentslip
        WHERE payrollperiod=#form.period#
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND (month(completedate) = #form.period# or month(completedate) != #form.period# and include='T')
    ) a2
    
    LEFT JOIN (
        SELECT * FROM assignmentslip
        WHERE payrollperiod=#form.period#
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND month(completedate) = #form.period#
    ) a
    ON a2.refno=a.refno
        
    LEFT JOIN #dts_p#.pmast p
    ON a2.empno=p.empno
    LEFT JOIN placement pl
    ON a2.placementno=pl.placementno
        
    LEFT JOIN (
        SELECT 
        empno,
        sum(coalesce(BackPayWage,0)) as BackPayWage,
        sum(coalesce(BackPayGA,0)) as BackPayGA,
        sum(coalesce(BackPayIncen,0)) as BackPayIncen,
        sum(coalesce(UnpaidLeave,0)) as UnpaidLeave,
        sum(coalesce(AdminFee,0)) as AdminFee,
        sum(coalesce(Reimbursement,0)) as Reimbursement,
        sum(coalesce(otadjust,0)) as otadjust,
        bbp.lorealremarks as lorealremarks,
        sum(coalesce(custtotalgross,0)) as custtotalgross
        FROM (
            SELECT aa.empno,
            sum(coalesce(aa.custsalary,0)) as BackPayWage,
            sum(0
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 79 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 79 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            ) as BackPayGA,
            sum(0
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 110 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 110 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 111 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 111 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 112 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 112 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 124 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 124 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 7 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 7 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            ) as BackPayIncen,
            sum(0
            <cfloop index="i" list="#reimburselist#">
                <cfloop  index="a" from="1" to="6">
                    + coalesce(case when aa.fixawcode#a#= #i# then coalesce(aa.fixawer#a#,0) else 0 end,0)
                </cfloop>
                <cfloop  index="a" from="1" to="18">
                    + coalesce(case when aa.allowance#a#= #i# then coalesce(aa.awer#a#,0) else 0 end,0)
                </cfloop>
            </cfloop>
            ) as Reimbursement,
            sum(0
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 12 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            )+sum(coalesce(aa.custottotal,0)) otadjust,
            sum(0
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 19 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 19 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="10">
                + coalesce(aa.lvltotaler#a#,0)
            </cfloop>
            ) as UnpaidLeave,
            sum(coalesce(aa.adminfee,0)) as AdminFee,
            aa.lorealremarks,
            sum(coalesce(aa.custtotalgross,0)) as custtotalgross
            FROM assignmentslip aa
            LEFT JOIN placement pla
            ON aa.placementno=pla.placementno
            WHERE payrollperiod=#form.period# 
            AND (aa.custname like "%l'oreal%" or aa.custname like "%loreal%")
            AND pla.jobpostype in (#form.jobpostype#)
            AND aa.empno !='0'
            AND aa.empno != '100123480'<!---Advanced Billing account--->
            <!---AND aa.selftotal--->
            AND month(aa.completedate) != #form.period#
            GROUP BY aa.empno

            UNION ALL

            SELECT empno,
            0 as BackPayWage,
            0 as BackPayGA,
            0 as BackPayIncen,
            0 as UnpaidLeave,
            0 as AdminFee,
            0 as Reimbursement,
            0 as otadjust,
            '' as lorealremarks,
            0 as custtotalgross
            FROM assignmentslip
            WHERE payrollperiod=#form.period# 
            AND (custname like "%l'oreal%" or custname like "%loreal%")
            GROUP BY empno
            ) bbp
            GROUP BY empno
        ) bp
    ON a2.empno=bp.empno  
    <!---<cfif form.period eq getmmonth.mmonth>
    LEFT JOIN (SELECT empno,grosspay,epfcc,socsocc,eiscc FROM #dts_p#.pay_tm) pay
    <cfelse>
    LEFT JOIN (SELECT empno,grosspay,epfcc,socsocc,eiscc FROM #dts_p#.pay_12m WHERE tmonth=#form.period#) pay
    </cfif>--->
    LEFT JOIN (
        SELECT assign.empno,sum(custcpf) custcpf,sum(custsdf) custsdf,sum(custeis) custeis 
        FROM assignmentslip assign
        LEFT JOIN placement pll
        ON assign.placementno=pll.placementno
        WHERE payrollperiod=#form.period# 
        AND pll.jobpostype in (#form.jobpostype#)
        GROUP BY assign.empno
        ) pay
    ON a2.empno=pay.empno

    WHERE pl.jobpostype in (#form.jobpostype#)
    AND a2.empno !='0'
    AND a2.empno != '100123480'<!---Advanced Billing account--->
    <!---AND selftotal--->    

    GROUP BY a2.empno
    ORDER BY p.workordid,a2.empno
    </cfquery>

    <cfelse>

    <cfquery name="getpayrolldata" datasource="#dts#" cachedwithin="#createtimespan(0,0,0,30)#">
    SELECT a2.empno, a2.placementno current_jo,a2.empname,
        case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
        workordid,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dcomm,'1900-01-01')+2 dcomm,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dresign,'1900-01-01')+2 dresign,
    sum(
        coalesce(a.custsalary,0)
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a.allowance#a#= 11 then coalesce(a.awer#a#,0) else 0 end,0)
        </cfloop>
    ) as BasicRate,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 79 and coalesce(a.fixawer#a#,0)>0 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 79 and coalesce(a.awer#a#,0)>0  then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as GALLOW,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 79 and coalesce(a.fixawer#a#,0)<0 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 79 and coalesce(a.awer#a#,0)<0  then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as GALLOWAdj,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 9 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 9 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as Bonus,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 118 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 118 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as ExceptionalBonus,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 128 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 128 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as ExcellenceAward,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 129 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 129 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as LongService,    
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 110 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 110 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>

    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 111 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 111 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>

    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 112 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 112 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>

    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 124 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 124 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
        
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 7 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 7 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>  
    )+bp.BackPayIncen as Incentive,    
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 3 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 3 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as CarMaintenance,<!---Fixed Allowance as Car Maintenance in Loreal--->
    sum(0
    <cfloop index="i" list="#reimburselist#">
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
        </cfloop>
    </cfloop>
    )+bp.Reimbursement as Reimbursement,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 78 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 78 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as Shoe,
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 14 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 14 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    ) as AnnualLeaveinLieu,
    sum(coalesce(a.custothour2,0)) custothour2,
    sum(coalesce(a.custot2,0)) custot2,
    sum(coalesce(a.custothour3,0)) custothour3,
    sum(coalesce(a.custot3,0)) custot3,
    sum(coalesce(a.custothour4,0)) custothour4,
    sum(coalesce(a.custot4,0)) custot4,
    sum(0
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 12 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    )+bp.otadjust otadjust,
    sum(coalesce(a.custottotal,0)) custottotal, <!---Column W or X--->    
    sum(0
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= 19 then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 19 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="10">
        + coalesce(a.lvltotaler#a#,0)
    </cfloop>
    )+bp.UnpaidLeave as UnpaidLeave,
    sum(coalesce(bp.BackPayWage,0)) as BackPayWage,<!---Back Pay Wage--->  
    sum(coalesce(bp.BackPayGA,0)) as BackPayGA,<!---Back Pay GA--->  
    sum(0
    + coalesce(a.custsalary,0)
    + coalesce(a.custottotal,0)
    + coalesce(bp.BackPayWage,0)  
    + coalesce(bp.BackPayGA,0)
    <cfloop index="i" list="#grosslist#">
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
        </cfloop>
    </cfloop>
    <cfloop  index="a" from="1" to="10">
        + coalesce(a.lvltotaler#a#,0)
    </cfloop>
    ) as  GrossWage,<!---Total Gross Wage--->
    sum(coalesce(pay.custcpf,0)) as ER_EPF,  
    sum(coalesce(pay.custsdf,0)) as ER_SOCSO,  
    sum(coalesce(pay.custeis,0)) as ER_EIS,  
    sum(coalesce(a.adminfee,0))+bp.AdminFee as AdminFee, 
    sum(coalesce(a.custtotalgross,0)+ coalesce(bp.custtotalgross,0)) as TotalBilling, <!---Total Billing--->
    <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
        sum(( CAST((0
        <cfloop index="i" list="#reimburselist#">
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
            </cfloop>
        </cfloop>
            + coalesce(a.adminfee,0)
            +bp.AdminFee
        ) AS DECIMAL(15,5)))*a2.taxper/100) as TotalGST,<!---6% GST--->
        (sum(coalesce(a.custtotalgross,0)+ coalesce(bp.custtotalgross,0))+(sum(( CAST((0
        <cfloop index="i" list="#reimburselist#">
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
            </cfloop>
        </cfloop>
            + coalesce(a.adminfee,0)
            +bp.AdminFee
        ) AS DECIMAL(15,5)))*a2.taxper/100))) as TotalBillingWGST,<!---Total Billing with GST--->
    <cfelse>
        ((CAST(coalesce(a.custtotalgross,0) AS DECIMAL(15,5))+ CAST(coalesce(bp.custtotalgross,0) AS DECIMAL(15,5)))*a2.taxper/100) as TotalGST,<!---6% GST--->
        (sum(coalesce(a.custtotalgross,0)+ coalesce(bp.custtotalgross,0) )+((CAST(coalesce(a.custtotalgross,0) AS DECIMAL(15,5))+ CAST(coalesce(bp.custtotalgross,0) AS DECIMAL(15,5)))*a.taxper/100)) as TotalBillingWGST,<!---Total Billing with GST--->    
    </cfif>
    concat(
        case when 
        sum(coalesce(a.lvleedayhr1,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr1,0)) as char(45))," day(s) in #thisperiod#") else "" end,<!---current month NPL--->
        case when sum(coalesce(a.lvleedayhr1,0))>0 then ", " else "" end,<!---comma--->
        case when sum(coalesce(a.lvleedayhr2,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr2,0)) as char(45))," day(s) in #lastperiod#") else "" end,<!---previous month NPL--->
        case when sum(coalesce(a.lvleedayhr1,0))>0 or sum(coalesce(a.lvleedayhr2,0))>0 then ", " else "" end,<!---comma--->
        a.lorealremarks,
        bp.lorealremarks
        )  as Remark,
    a2.taxper,
    a2.invoiceno

    FROM (
        SELECT * FROM assignmentslip
        WHERE payrollperiod=#form.period#
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND (month(completedate) = #form.period# or month(completedate) != #form.period# and include='T')
    ) a2
    
    LEFT JOIN (
        SELECT * FROM assignmentslip
        WHERE payrollperiod=#form.period#
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND month(completedate) = #form.period#
    ) a
    ON a2.refno=a.refno
        
    LEFT JOIN #dts_p#.pmast p
    ON a2.empno=p.empno
    LEFT JOIN placement pl
    ON a2.placementno=pl.placementno
        
    LEFT JOIN (
        SELECT 
        empno,
        sum(coalesce(BackPayWage,0)) as BackPayWage,
        sum(coalesce(BackPayGA,0)) as BackPayGA,
        sum(coalesce(BackPayIncen,0)) as BackPayIncen,
        sum(coalesce(UnpaidLeave,0)) as UnpaidLeave,
        sum(coalesce(AdminFee,0)) as AdminFee,
        sum(coalesce(Reimbursement,0)) as Reimbursement,
        sum(coalesce(otadjust,0)) as otadjust,
        bbp.lorealremarks as lorealremarks,
        sum(coalesce(custtotalgross,0)) as custtotalgross
        FROM (
            SELECT aa.empno,
            sum(coalesce(aa.custsalary,0)) as BackPayWage,
            sum(0
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 79 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 79 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            ) as BackPayGA,
            sum(0
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 110 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 110 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 111 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 111 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 112 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 112 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 124 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 124 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>

            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 7 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 7 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            ) as BackPayIncen,
            sum(0
            <cfloop index="i" list="#reimburselist#">
                <cfloop  index="a" from="1" to="6">
                    + coalesce(case when aa.fixawcode#a#= #i# then coalesce(aa.fixawer#a#,0) else 0 end,0)
                </cfloop>
                <cfloop  index="a" from="1" to="18">
                    + coalesce(case when aa.allowance#a#= #i# then coalesce(aa.awer#a#,0) else 0 end,0)
                </cfloop>
            </cfloop>
            ) as Reimbursement,
            sum(0
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 12 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            )+sum(coalesce(aa.custottotal,0)) otadjust,
            sum(0
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when aa.fixawcode#a#= 19 then coalesce(aa.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when aa.allowance#a#= 19 then coalesce(aa.awer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="10">
                + coalesce(aa.lvltotaler#a#,0)
            </cfloop>
            ) as UnpaidLeave,
            sum(coalesce(aa.adminfee,0)) as AdminFee,
            aa.lorealremarks,
            sum(coalesce(aa.custtotalgross,0)) as custtotalgross
            FROM assignmentslip aa
            LEFT JOIN placement pla
            ON aa.placementno=pla.placementno
            WHERE payrollperiod=#form.period# 
            AND (aa.custname like "%l'oreal%" or aa.custname like "%loreal%")
            AND pla.jobpostype in (#form.jobpostype#)
            AND aa.empno !='0'
            AND aa.empno != '100123480'<!---Advanced Billing account--->
            <!---AND aa.selftotal--->
            AND month(aa.completedate) != #form.period#
            GROUP BY aa.empno

            UNION ALL

            SELECT empno,
            0 as BackPayWage,
            0 as BackPayGA,
            0 as BackPayIncen,
            0 as UnpaidLeave,
            0 as AdminFee,
            0 as Reimbursement,
            0 as otadjust,
            '' as lorealremarks,
            0 as custtotalgross
            FROM assignmentslip
            WHERE payrollperiod=#form.period# 
            AND (custname like "%l'oreal%" or custname like "%loreal%")
            GROUP BY empno
            ) bbp
            GROUP BY empno
        ) bp
    ON a2.empno=bp.empno  
    <!---<cfif form.period eq getmmonth.mmonth>
    LEFT JOIN (SELECT empno,grosspay,epfcc,socsocc,eiscc FROM #dts_p#.pay_tm) pay
    <cfelse>
    LEFT JOIN (SELECT empno,grosspay,epfcc,socsocc,eiscc FROM #dts_p#.pay_12m WHERE tmonth=#form.period#) pay
    </cfif>--->
    LEFT JOIN (
        SELECT assign.empno,sum(custcpf) custcpf,sum(custsdf) custsdf,sum(custeis) custeis 
        FROM assignmentslip assign
        LEFT JOIN placement pll
        ON assign.placementno=pll.placementno
        WHERE payrollperiod=#form.period# 
        AND pll.jobpostype in (#form.jobpostype#)
        GROUP BY assign.empno
        ) pay
    ON a2.empno=pay.empno

    WHERE pl.jobpostype in (#form.jobpostype#)
    AND a2.empno !='0'
    AND a2.empno != '100123480'<!---Advanced Billing account--->
    <!---AND selftotal--->    

    GROUP BY a2.empno
    ORDER BY p.workordid,a2.empno
    </cfquery>

    </cfif>

    <!---Add 1st sheets--->
    <cfset overall = SpreadSheetNew(true)>   
        
    <!---Added to handle the additional column from version 1--->
    <cfset addnewcolumn = 1>
    <!---Added to handle the additional column for version 1--->

    <cfif checkoldjoexist.recordcount neq 0>  
        
        <!---Added to handle the additional column for JO Renew--->
        <cfset addcolumn = 1>
        <!---Added to handle the additional column for JO Renew--->

        <cfset SpreadSheetAddRow(overall, ",,,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,,Report ID: Monthly Payroll Report,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,,Report Title: Monthly Payroll Report,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,,For Year #getmmonth.myear#,,,,,,,,,,,,,,,,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,,,,,,,,,,,,,,,#lastperiod#,#lastyear#")>

    <cfelse>
    
        <cfset addcolumn = 0>

        <cfset SpreadSheetAddRow(overall, ",,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,Report ID: Monthly Payroll Report,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,Report Title: Monthly Payroll Report,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,For Year #getmmonth.myear#,,,,,,,,,,,,,,,,,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,,,,,,,,,,,,,,,#lastperiod#,#lastyear#")>

    </cfif>

    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

    <cfif checkoldjoexist.recordcount neq 0>
        <cfset header = "Employee ID,Old Job Order No,Current Job Order No,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Wage,GALLOW,GALLOW Adjustment,Incentive,Car Maintenance,Disbursement,Shoe, Annual Leave in Lieu, Std 1.50 HR,Std 1.50 HR Amount,Std 2.00 HR,Std 2.00 HR Amount,Std 3.00 HR,Std 3.00 HR Amount,OT Amount,Unpaid Leave,Back Pay Wage,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,EIS,Admin Fee,Total Billing">
    <cfelse>
        <cfset header = "Employee ID,Job Order No,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Wage,GALLOW,GALLOW Adjustment,Incentive,Car Maintenance,Disbursement,Shoe,Annual Leave in Lieu,Std 1.50 HR,Std 1.50 HR Amount,Std 2.00 HR,Std 2.00 HR Amount,Std 3.00 HR,Std 3.00 HR Amount,OT Amount,Unpaid Leave,Back Pay Wage,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,EIS,Admin Fee,Total Billing">
    </cfif>
        
    <cfquery name="checkColumnToShow" dbtype="query">
        SELECT sum(ExcellenceAward) ExcellenceAward, sum(LongService) LongService, sum(ExceptionalBonus) ExceptionalBonus, sum(Bonus) Bonus
        FROM getpayrolldata
    </cfquery>
        
    <!---For OT Adjustment--->
    <cfset newotadjustcol = 0>
    <cfset newotadjustcolgross = 0>
        
    <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
        <cfset addnewcolumn += 1>
        <cfset newotadjustcol = -1>
        <cfset newotadjustcolgross += 1>
        <cfset header = replacenocase(header,',OT Amount',',OT Adjustment,OT Amount')>
    </cfif>
    <!---For OT Adjustment--->
        
    <cfif checkColumnToShow.ExceptionalBonus neq 0>
        <cfset addnewcolumn += 1>
        <cfset header = replacenocase(header,'GALLOW Adjustment,','GALLOW Adjustment,Exceptional Bonus,')>
    </cfif>
        
    <cfif checkColumnToShow.Bonus neq 0>
        <cfset addnewcolumn += 1>
        <cfset header = replacenocase(header,'GALLOW Adjustment,','GALLOW Adjustment,Bonus,')>
    </cfif>
        
    <cfif checkColumnToShow.LongService neq 0>
        <cfset addnewcolumn += 1>
        <cfset header = replacenocase(header,'GALLOW Adjustment,','GALLOW Adjustment,Long Service Award,')>
    </cfif>
        
    <cfif checkColumnToShow.ExcellenceAward neq 0>
        <cfset addnewcolumn += 1>
        <cfset header = replacenocase(header,'GALLOW Adjustment,','GALLOW Adjustment,Excellence Award,')>
    </cfif>
        
    <cfif getmmonth.myear lte 2018 and form.period lte 11>
        <cfset header = replacenocase(header,'Disbursement','Reimbursement')>
    </cfif>
        
    <cfif form.period gte 6 and getmmonth.myear eq 2018 and form.period lte 8>
        <cfset header = header&",0% GST,Total Billing with GST,Remarks">   
    <cfelseif (form.period gte 9 and getmmonth.myear gte 2018) or getmmonth.myear gte 2018>
        <cfset header = header&",6% Service Tax,Total Billing with SST,Remarks">
    <cfelse>
        <cfset header = header&",6% GST,Total Billing with GST,Remark">  
    </cfif>
        
    <cfset SpreadSheetAddRow(overall, header)>
        
    <cfquery name="getpayrolldataoutput" dbtype="query">
        SELECT empno, 
        <cfif checkoldjoexist.recordcount neq 0>
        old_jo,
        </cfif>
        current_jo, 
        empname, nricn, workordid, dcomm, dresign, 
        BasicRate,
        GALLOW, GALLOWAdj,
        <cfif checkColumnToShow.Bonus neq 0>
            Bonus,
        </cfif>
        <cfif checkColumnToShow.ExceptionalBonus neq 0>
            ExceptionalBonus,
        </cfif>        
        <cfif checkColumnToShow.ExcellenceAward neq 0>
            ExcellenceAward,
        </cfif>
        <cfif checkColumnToShow.LongService neq 0>
            LongService,
        </cfif>
        Incentive, CarMaintenance, Reimbursement, Shoe, AnnualLeaveinLieu, custothour2, custot2, custothour3, custot3, custothour4, custot4, 
        <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
        otadjust, 
        </cfif>
        custottotal, UnpaidLeave, BackPayWage, BackPayGA, GrossWage, ER_EPF, ER_SOCSO, ER_EIS, AdminFee, TotalBilling, TotalGST, TotalBillingWGST, Remark
        FROM getpayrolldata
    </cfquery>

    <cfset SpreadSheetAddRows(overall, getpayrolldataoutput)>

    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>   
        
    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>    


    <cfif checkoldjoexist.recordcount neq 0>  

        <cfset SpreadSheetAddRow(overall, ",,,Total Employee Count")>

    <cfelse>

        <cfset SpreadSheetAddRow(overall, ",,Total Employee Count")>

    </cfif>
        
    <!---Set Column Position--->
    <cfset ot15amtColumnPos = 16+addcolumn+addnewcolumn+newotadjustcol>
    <cfset ot2amtColumnPos = 18+addcolumn+addnewcolumn+newotadjustcol>
    <cfset ot3amtColumnPos = 20+addcolumn+addnewcolumn+newotadjustcol>
        
        <!---New OT Adjust Column Position--->
        <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
            <cfset otAdjamtColumnPos = 21+addcolumn+addnewcolumn+newotadjustcol>
        </cfif>
        <!---New OT Adjust Column Position--->
        
    <cfset otTotalamtColumnPos = 21+addcolumn+addnewcolumn>
    <cfset grossStartColumnPos = 8+addcolumn>
    <cfset grossFromColumnPos1 = 9+addcolumn>
    <cfset grossToColumnPos1 = 14+addcolumn+addnewcolumn+newotadjustcol>
    <cfset grossFromColumnPos2 = 22+addcolumn+newotadjustcolgross>
    <cfset grossToColumnPos2 = 24+addcolumn+addnewcolumn>
    <cfset grossTotalColumnPos = 25+addcolumn+addnewcolumn>
    <cfset TotalFromColumnPos = 26+addcolumn+addnewcolumn>
    <cfset TotalToColumnPos = 29+addcolumn+addnewcolumn>
    <cfset TotalamtColumnPos = 30+addcolumn+addnewcolumn>
    <cfset TaxableSSTamtColumnPos = 29+addcolumn+addnewcolumn>
    <cfset TaxableGSTamtColumnPos = 30+addcolumn+addnewcolumn>
    <cfset TaxAmtColumnPos = 31+addcolumn+addnewcolumn>
    <cfset TotalwTaxAmtColumnPos = 32+addcolumn+addnewcolumn>
        
    <cfset SumColPosFrom = 8+addcolumn>
    <cfset SumColPosTo = 32+addcolumn+addnewcolumn>
    <cfset NumberformatColPos = 32+addcolumn+addnewcolumn>
    <cfset BorderFormatColPos = 33+addcolumn+addnewcolumn>
    <!---Set Column Position--->
        
    <cfloop query="getpayrolldata">
        <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(ot15amtColumnPos)##7+getpayrolldata.currentrow#+#numbertoletter(ot2amtColumnPos)##7+getpayrolldata.currentrow#+#numbertoletter(ot3amtColumnPos)##7+getpayrolldata.currentrow#", 7+getpayrolldata.currentrow,otTotalamtColumnPos)>
            
        <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(ot15amtColumnPos)##7+getpayrolldata.currentrow#+#numbertoletter(ot2amtColumnPos)##7+getpayrolldata.currentrow#+#numbertoletter(ot3amtColumnPos)##7+getpayrolldata.currentrow#+#numbertoletter(otAdjamtColumnPos)##7+getpayrolldata.currentrow#", 7+getpayrolldata.currentrow,otTotalamtColumnPos)>
        </cfif>
            
        <cfset grossitems = "#numbertoletter(grossStartColumnPos)##7+getpayrolldata.currentrow#">
        
        <cfloop index='aa' from="#grossFromColumnPos1#" to="#grossToColumnPos1#">
            <cfset grossitems = grossitems&"+#numbertoletter(aa)##7+getpayrolldata.currentrow#">
        </cfloop>
            
        <cfloop index='aa' from="#grossFromColumnPos2#" to="#grossToColumnPos2#">
            <cfset grossitems = grossitems&"+#numbertoletter(aa)##7+getpayrolldata.currentrow#">
        </cfloop>
            
        <cfset spreadsheetSetCellFormula(overall, "#grossitems#", 7+getpayrolldata.currentrow,grossTotalColumnPos)>
            
        <cfset totalitems = "ROUND((#numbertoletter(grossTotalColumnPos)##7+getpayrolldata.currentrow#">
            
        <cfloop index='i' from="#TotalFromColumnPos#" to="#TotalToColumnPos#">
            <cfset totalitems = totalitems&"+#numbertoletter(i)##7+getpayrolldata.currentrow#">
        </cfloop>
            
        <cfset totalitems = totalitems&"),2)">
            
        <cfset spreadsheetSetCellFormula(overall, "#totalitems#", 7+getpayrolldata.currentrow,TotalamtColumnPos)>
         
        <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 12)>
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(TaxableSSTamtColumnPos)##7+getpayrolldata.currentrow#*#getpayrolldata.taxper/100#", 7+getpayrolldata.currentrow, TaxAmtColumnPos)>
        <cfelseif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
            <cfset spreadsheetSetCellFormula(overall, "(#numbertoletter(TaxableSSTamtColumnPos)##7+getpayrolldata.currentrow#+#numbertoletter(12+addcolumn+addnewcolumn)##7+getpayrolldata.currentrow#)*#getpayrolldata.taxper/100#", 7+getpayrolldata.currentrow, TaxAmtColumnPos)>
        <cfelse>
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(TaxableGSTamtColumnPos)##7+getpayrolldata.currentrow#*#getpayrolldata.taxper/100#", 7+getpayrolldata.currentrow, TaxAmtColumnPos)>
        </cfif>
            
        <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(TotalamtColumnPos)##7+getpayrolldata.currentrow#+#numbertoletter(TaxAmtColumnPos)##7+getpayrolldata.currentrow#", 7+getpayrolldata.currentrow, TotalwTaxAmtColumnPos)>
        
    </cfloop>
            
    <cfloop index="ii" from="#SumColPosFrom#" to="#SumColPosTo#">
        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(ii)#8:#numbertoletter(ii)##7+getpayrolldata.recordcount#)", 7+getpayrolldata.recordcount+1,ii)>
    </cfloop>
        
    <cfset spreadsheetSetCellFormula(overall, "COUNTA(A8:A#7+getpayrolldata.recordcount#)", 7+getpayrolldata.recordcount+4, 3+addcolumn)>

    <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
    <cfset SpreadSheetFormatCellRange(overall, s67, 8, 8, getpayrolldata.recordcount+8, NumberformatColPos)>
        
    <cfset SpreadSheetFormatCellRange(overall, s28, 8, 1, getpayrolldata.recordcount+8, BorderFormatColPos)>
    <cfset SpreadSheetFormatCellRange(overall, s23, 7, 1, 7, BorderFormatColPos)><!---header--->
    <cfset SpreadSheetFormatCellRange(overall, s30, getpayrolldata.recordcount+8, 1, getpayrolldata.recordcount+8, BorderFormatColPos)>

    <cfloop index="i" from="1" to="#BorderFormatColPos#">
          <cfset spreadsheetSetColumnWidth(overall, i, columnnumbers) >
    </cfloop>

    <cfif checkoldjoexist.recordcount neq 0>  
        
        <cfset spreadsheetSetColumnWidth(overall, 4, columnname) >
        <cfset spreadsheetSetColumnWidth(overall, 6, columnsection) >

    <cfelse>
        
        <cfset spreadsheetSetColumnWidth(overall, 3, columnname) >
        <cfset spreadsheetSetColumnWidth(overall, 5, columnsection) >

    </cfif>

    <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
    <cfset spreadsheetSetRowHeight(overall, 7, BorderFormatColPos)>
    <cfset SpreadSheetFormatCellRange(overall, s26, 4, 29, 5, 29)>
    <cfset SpreadSheetFormatCellRange(overall, s27, 4, 30, 5, 30)>
        
    <cfset SpreadSheetFormatCellRange(overall, s68, 8, 6+addcolumn, getpayrolldata.recordcount+8, 7+addcolumn)> 


    <cfspreadsheet action="write" sheetname="Payment Detail" filename="#HRootPath#\Excel_Report\Payroll_Report_#timenow#.xlsx" name="overall" overwrite="true">


    <!---Add 1st sheets--->

    <!---Add 2nd sheets--->

    <cfquery name="checkregion" dbtype="query"> 
        SELECT workordid 
        FROM getpayrolldata
        WHERE workordid != ''
        GROUP BY workordid     
    </cfquery>

    <cfif checkregion.recordcount gt 1>

    <cfloop query="checkregion">

    <cfquery name="getpayrolldata1" dbtype="query">
    SELECT *
    FROM getpayrolldata
    WHERE workordid='#checkregion.workordid#'
    </cfquery>

    <cfif getpayrolldata1.recordcount neq 0>

        <cfset tempvar = SpreadSheetNew(true)>

        <cfif checkoldjoexist.recordcount neq 0>  

            <cfset SpreadSheetAddRow(tempvar, ",,,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,")>

            <cfset SpreadSheetAddRow(tempvar, ",,,Report ID: Monthly Payroll Report,,,,,,,,,,,")>

            <cfset SpreadSheetAddRow(tempvar, ",,,Report Title: Monthly Payroll Report,,,,,,,,,,,,")>

            <cfset SpreadSheetAddRow(tempvar, ",,,For Year #getmmonth.myear#,,,,,,,,,,,,,,,,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>

            <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,,,,,,,,,,,,,,,#lastperiod#,#lastyear#")>

        <cfelse>

            <cfset SpreadSheetAddRow(tempvar, ",,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,")>

            <cfset SpreadSheetAddRow(tempvar, ",,Report ID: Monthly Payroll Report,,,,,,,,,,,")>

            <cfset SpreadSheetAddRow(tempvar, ",,Report Title: Monthly Payroll Report,,,,,,,,,,,,")>

            <cfset SpreadSheetAddRow(tempvar, ",,For Year #getmmonth.myear#,,,,,,,,,,,,,,,,,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>

            <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,,,,,,,,,,,,,,,#lastperiod#,#lastyear#")>

        </cfif>

        <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(tempvar, header)>
            
        <cfquery name="getpayrolldata1output" dbtype="query">
        SELECT empno, 
            <cfif checkoldjoexist.recordcount neq 0>
            old_jo,
            </cfif>
            current_jo, 
            empname, nricn, workordid, dcomm, dresign, BasicRate, GALLOW, GALLOWAdj,
            <cfif checkColumnToShow.Bonus neq 0>
                Bonus,
            </cfif>
            <cfif checkColumnToShow.ExceptionalBonus neq 0>
                ExceptionalBonus,
            </cfif>  
            <cfif checkColumnToShow.ExcellenceAward neq 0>
                ExcellenceAward,
            </cfif>
            <cfif checkColumnToShow.LongService neq 0>
                LongService,
            </cfif>
            Incentive, CarMaintenance, Reimbursement, Shoe, AnnualLeaveinLieu, custothour2, custot2, custothour3, custot3, custothour4, custot4, 
            <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
            otadjust, 
            </cfif>
            custottotal, UnpaidLeave, BackPayWage, BackPayGA, GrossWage, ER_EPF, ER_SOCSO, ER_EIS, AdminFee, TotalBilling, TotalGST, TotalBillingWGST, Remark
        FROM getpayrolldata
        WHERE workordid='#checkregion.workordid#'
        </cfquery>

        <cfset SpreadSheetAddRows(tempvar, getpayrolldata1output)>

        <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>
            
        <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>

        <cfif checkoldjoexist.recordcount neq 0>  

            <cfset SpreadSheetAddRow(tempvar, ",,,Total Employee Count")>

        <cfelse>

            <cfset SpreadSheetAddRow(tempvar, ",,Total Employee Count")>

        </cfif>
            
        <cfloop query="getpayrolldata1">
            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(ot15amtColumnPos)##7+getpayrolldata1.currentrow#+#numbertoletter(ot2amtColumnPos)##7+getpayrolldata1.currentrow#+#numbertoletter(ot3amtColumnPos)##7+getpayrolldata1.currentrow#", 7+getpayrolldata1.currentrow,otTotalamtColumnPos)>
                
            <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(ot15amtColumnPos)##7+getpayrolldata1.currentrow#+#numbertoletter(ot2amtColumnPos)##7+getpayrolldata1.currentrow#+#numbertoletter(ot3amtColumnPos)##7+getpayrolldata1.currentrow#+#numbertoletter(otAdjamtColumnPos)##7+getpayrolldata1.currentrow#", 7+getpayrolldata1.currentrow,otTotalamtColumnPos)>
            </cfif>

            <cfset grossitems = "#numbertoletter(grossStartColumnPos)##7+getpayrolldata1.currentrow#">

            <cfloop index='aa' from="#grossFromColumnPos1#" to="#grossToColumnPos1#">
                <cfset grossitems = grossitems&"+#numbertoletter(aa)##7+getpayrolldata1.currentrow#">
            </cfloop>

            <cfloop index='aa' from="#grossFromColumnPos2#" to="#grossToColumnPos2#">
                <cfset grossitems = grossitems&"+#numbertoletter(aa)##7+getpayrolldata1.currentrow#">
            </cfloop>

            <cfset spreadsheetSetCellFormula(tempvar, "#grossitems#", 7+getpayrolldata1.currentrow,grossTotalColumnPos)>

            <cfset totalitems = "ROUND((#numbertoletter(grossTotalColumnPos)##7+getpayrolldata1.currentrow#">

            <cfloop index='i' from="#TotalFromColumnPos#" to="#TotalToColumnPos#">
                <cfset totalitems = totalitems&"+#numbertoletter(i)##7+getpayrolldata1.currentrow#">
            </cfloop>

            <cfset totalitems = totalitems&"),2)">

            <cfset spreadsheetSetCellFormula(tempvar, "#totalitems#", 7+getpayrolldata1.currentrow,TotalamtColumnPos)>

            <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 12)>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(TaxableSSTamtColumnPos)##7+getpayrolldata1.currentrow#*#getpayrolldata1.taxper/100#", 7+getpayrolldata1.currentrow, TaxAmtColumnPos)>
            <cfelseif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
                <cfset spreadsheetSetCellFormula(tempvar, "(#numbertoletter(TaxableSSTamtColumnPos)##7+getpayrolldata1.currentrow#+#numbertoletter(12+addcolumn+addnewcolumn)##7+getpayrolldata1.currentrow#)*#getpayrolldata1.taxper/100#", 7+getpayrolldata1.currentrow, TaxAmtColumnPos)>             
            <cfelse>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(TaxableGSTamtColumnPos)##7+getpayrolldata1.currentrow#*#getpayrolldata1.taxper/100#", 7+getpayrolldata1.currentrow, TaxAmtColumnPos)>
            </cfif>

            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(TotalamtColumnPos)##7+getpayrolldata1.currentrow#+#numbertoletter(TaxAmtColumnPos)##7+getpayrolldata1.currentrow#", 7+getpayrolldata1.currentrow, TotalwTaxAmtColumnPos)>

        </cfloop>

        <cfloop index="ii" from="#SumColPosFrom#" to="#SumColPosTo#">
            <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(ii)#8:#numbertoletter(ii)##7+getpayrolldata1.recordcount#)", 7+getpayrolldata1.recordcount+1,ii)>
        </cfloop>

        <cfset spreadsheetSetCellFormula(tempvar, "COUNTA(A8:A#7+getpayrolldata1.recordcount#)", 7+getpayrolldata1.recordcount+4, 3+addcolumn)>

        <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
        <cfset SpreadSheetFormatCellRange(tempvar, s67, 8, 8, getpayrolldata1.recordcount+8, NumberformatColPos)>
            
        <cfset SpreadSheetFormatCellRange(tempvar, s28, 8, 1, getpayrolldata1.recordcount+8, BorderFormatColPos)>
        <cfset SpreadSheetFormatCellRange(tempvar, s23, 7, 1, 7, BorderFormatColPos)><!---header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s30, getpayrolldata1.recordcount+8, 1, getpayrolldata1.recordcount+8, BorderFormatColPos)>

        <cfloop index="i" from="1" to="#BorderFormatColPos#">
              <cfset spreadsheetSetColumnWidth(tempvar, i, columnnumbers) >
        </cfloop>

        <cfif checkoldjoexist.recordcount neq 0>    

            <cfset spreadsheetSetColumnWidth(tempvar, 4, columnname) >
            <cfset spreadsheetSetColumnWidth(tempvar, 6, columnsection) >

        <cfelse>

            <cfset spreadsheetSetColumnWidth(tempvar, 3, columnname) >
            <cfset spreadsheetSetColumnWidth(tempvar, 5, columnsection) >

        </cfif>

        <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
        <cfset spreadsheetSetRowHeight(tempvar, 7, BorderFormatColPos)>
        <cfset SpreadSheetFormatCellRange(tempvar, s26, 4, 29, 5, 29)>
        <cfset SpreadSheetFormatCellRange(tempvar, s27, 4, 30, 5, 30)>
            
        <cfset SpreadSheetFormatCellRange(tempvar, s68, 8, 6+addcolumn, getpayrolldata1.recordcount+8, 7+addcolumn)> 

        <cfspreadsheet action="update" sheetname="#checkregion.workordid#" filename="#HRootPath#\Excel_Report\Payroll_Report_#timenow#.xlsx" name="tempvar" >

    </cfif>

    </cfloop>

    </cfif>   
    <!---Add 2nd sheets--->
            
    <cfset filename = "Payroll_Report #thisperiod# #getmmonth.myear#_#timenow#">
   
<!---End Perm--->
<cfelse>
<!---Temp--->  
    <cfquery name="getvariabledata" datasource="#dts#">
    SELECT *,coalesce(backa.backpay,0) as BackPaySalary, (coalesce(xGrossWage,0) + coalesce(backa.backpay,0)) as GrossWage
    FROM 
    (
        SELECT 
        case when count(aa.placementno) > 1 then group_concat(distinct aa.placementno) else aa.placementno end current_jo,
        aa.empno as empno,
        p3.name as empname,
        case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
        p3.jtitle,
        UPPER(concat(
            case when outlet1.outletname is not null then outlet1.outletname else "" end," ",
            case when outlet1.location is not null then outlet1.location else "" end,
            case when outlet2.outletname is not null then " & " else "" end,
            case when outlet2.outletname is not null then outlet2.outletname else "" end," ",
            case when outlet2.location is not null then outlet2.location else "" end,
            case when outlet3.outletname is not null then " & " else "" end,
            case when outlet3.outletname is not null then outlet3.outletname else "" end," ",
            case when outlet3.location is not null then outlet3.location else "" end
        )) worklocation,
        ppl.supervisor,
        p3.workordid<!---Section/Region--->,
        <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(ppl.startdate,'1900-01-01')+2 dcomm,
        <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(ppl.completedate,'1900-01-01')+2 dresign,
        a3.lorealremarks daysworked,
        sum(case when not (coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200 or coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160) then coalesce(a3.custsalary,0) else 0 end) as BasicRate,

        sum(case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200 then coalesce(a3.custsalaryday,0) else 0 end) totalnormalday,<!---Total Normal Working Days--->
        (case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200 then coalesce(a3.custusualpay,0) else 0 end) normalrate,<!---Working on Normal day --->
        sum(
            case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 then coalesce(a3.custsalary,0) else 0 end + case when not (coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = 165 or coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 or coalesce(a3.custusualpay,0) = 1000)  then coalesce(a3.custsalary,0) else 0 end
        ) totalnormal,<!---Total Normal --->

        sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalaryday,0) else 0 end) total_concourse_day,<!---Total Concourse Days--->
        (case when sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalaryday,0) else 0 end) != 0 then 165 else 0 end) working_concourse,<!---Working on Concourse day --->
        sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalary,0) else 0 end) total_concourse,<!---Total Concourse --->    

        sum(case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custsalaryday,0) else 0 end) total_day_ph,
        (case when sum(case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custsalaryday,0) else 0 end) != 0 then 160 else 0 end) working_ph,
        sum(case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custsalary,0) else 0 end) total_ph,
        sum(coalesce(a3.custsalary,0))<!---PH---> as BasicWage,
        sum(coalesce(a3.lvltotaler1,0)+coalesce(a3.lvltotaler2,0)+coalesce(a4.lvltotaler1,0)+coalesce(a4.lvltotaler2,0)) as UPL,
        sum(0
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a3.fixawcode#a#= 120 then coalesce(a3.fixawer#a#,0) else 0 end,0)
            + coalesce(case when a4.fixawcode#a#= 120 then coalesce(a4.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a3.allowance#a#= 120 then coalesce(a3.awer#a#,0) else 0 end,0)
            + coalesce(case when a4.allowance#a#= 120 then coalesce(a4.awer#a#,0) else 0 end,0)
        </cfloop>
        ) as TotalReimbursement,
        0 as TotalSalesFigure<!---Sales Figure--->,
        sum(0    
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a3.fixawcode#a#= 7 or a3.fixawcode#a#= 110 then coalesce(a3.fixawer#a#,0) else 0 end,0)
            + coalesce(case when a4.fixawcode#a#= 7 or a4.fixawcode#a#= 110 then coalesce(a4.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a3.allowance#a#= 7 or a3.allowance#a#= 110 then coalesce(a3.awer#a#,0) else 0 end,0)
            + coalesce(case when a4.allowance#a#= 7 or a4.allowance#a#= 110 then coalesce(a4.awer#a#,0) else 0 end,0)
        </cfloop>
        ) as Incentive,
        sum(0
        +coalesce(a3.custsalary,0)
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a3.fixawcode#a#= 120 then coalesce(a3.fixawer#a#,0) else 0 end,0)
            + coalesce(case when a4.fixawcode#a#= 120 then coalesce(a4.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a3.allowance#a#= 120 then coalesce(a3.awer#a#,0) else 0 end,0)
            + coalesce(case when a4.allowance#a#= 120 then coalesce(a4.awer#a#,0) else 0 end,0)
        </cfloop>

        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a3.fixawcode#a#= 7 or a3.fixawcode#a#= 110 then coalesce(a3.fixawer#a#,0) else 0 end,0)
            + coalesce(case when a4.fixawcode#a#= 7 or a4.fixawcode#a#= 110 then coalesce(a4.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a3.allowance#a#= 7 or a3.allowance#a#= 110 then coalesce(a3.awer#a#,0) else 0 end,0)
            + coalesce(case when a4.allowance#a#= 7 or a4.allowance#a#= 110 then coalesce(a4.awer#a#,0) else 0 end,0)
        </cfloop>
        ) as xGrossWage,
        <!---OT--->    
        sum(coalesce(a3.custothour2,0)+coalesce(a4.custothour2,0)) custothour2,
        sum(coalesce(a3.custot2,0)+coalesce(a4.custot2,0)) custot2,
        sum(coalesce(a3.custothour3,0)+coalesce(a4.custothour3,0)) custothour3,
        sum(coalesce(a3.custot3,0)+coalesce(a4.custot3,0)) custot3,
        sum(coalesce(a3.custothour4,0)+coalesce(a4.custothour4,0)) custothour4,
        sum(coalesce(a3.custot4,0)+coalesce(a4.custot4,0)) custot4,        sum(coalesce(a3.custothour2,0)+coalesce(a3.custothour3,0)+coalesce(a3.custothour4,0)+coalesce(a4.custothour2,0)+coalesce(a4.custothour3,0)+coalesce(a4.custothour4,0)) custothours, 
        sum(coalesce(a3.custottotal,0)+coalesce(a4.custottotal,0)) custottotal, 
        <!---OT--->    
        sum(coalesce(a3.custcpf,0) + coalesce(a4.custcpf,0)) custcpf,
        sum(coalesce(a3.custsdf,0) + coalesce(a4.custsdf,0)) custsdf,
        sum(coalesce(a3.custeis,0) + coalesce(a4.custeis,0)) custeis,
        sum(0
        +coalesce(a3.custsalary,0)
        + coalesce(a3.custottotal,0)
        +coalesce(a4.custsalary,0)
        + coalesce(a4.custottotal,0)
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a3.fixawcode#a#= 120 then coalesce(a3.fixawer#a#,0) else 0 end,0)
            + coalesce(case when a4.fixawcode#a#= 120 then coalesce(a4.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a3.allowance#a#= 120 then coalesce(a3.awer#a#,0) else 0 end,0)
            + coalesce(case when a4.allowance#a#= 120 then coalesce(a4.awer#a#,0) else 0 end,0)
        </cfloop>

        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a3.fixawcode#a#= 7 then coalesce(a3.fixawer#a#,0) else 0 end,0)
            + coalesce(case when a4.fixawcode#a#= 7 then coalesce(a4.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a3.allowance#a#= 7 then coalesce(a3.awer#a#,0) else 0 end,0)
            + coalesce(case when a4.allowance#a#= 7 then coalesce(a4.awer#a#,0) else 0 end,0)
        </cfloop>
            + coalesce(a3.custcpf,0)
            + coalesce(a3.custsdf,0)
            + coalesce(a3.custeis,0)
            + coalesce(a4.custcpf,0)
            + coalesce(a4.custsdf,0)
            + coalesce(a4.custeis,0)
        ) subtotal,
        sum(coalesce(a3.adminfee,0)+coalesce(a4.adminfee,0)) adminfee,
        sum(coalesce(a3.custtotalgross,0)+coalesce(a4.custtotalgross,0)) as custtotalgross,
        <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
            sum(
                (0
                <cfloop  index="a" from="1" to="6">
                    + coalesce(case when a3.fixawcode#a#= 120 then coalesce(a3.fixawer#a#,0) else 0 end,0)
                </cfloop>
                <cfloop  index="a" from="1" to="18">
                    + coalesce(case when a3.allowance#a#= 120 then coalesce(a3.awer#a#,0) else 0 end,0)
                </cfloop>
                    + coalesce(a3.adminfee,0)
                )*(coalesce(a3.taxper,0)/100)
                + (0
                <cfloop  index="a" from="1" to="6">
                    + coalesce(case when a4.fixawcode#a#= 120 then coalesce(a4.fixawer#a#,0) else 0 end,0)
                </cfloop>
                <cfloop  index="a" from="1" to="18">
                    + coalesce(case when a4.allowance#a#= 120 then coalesce(a4.awer#a#,0) else 0 end,0)
                </cfloop>
                    + coalesce(a4.adminfee,0)
                )*(coalesce(a4.taxper,0)/100)
            ) GST,
            sum((0
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when a3.fixawcode#a#= 120 then coalesce(a3.fixawer#a#,0) else 0 end,0)
                + coalesce(case when a4.fixawcode#a#= 120 then coalesce(a4.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when a3.allowance#a#= 120 then coalesce(a3.awer#a#,0) else 0 end,0)
                + coalesce(case when a4.allowance#a#= 120 then coalesce(a4.awer#a#,0) else 0 end,0)
            </cfloop>
                + coalesce(a3.adminfee,0)
                + coalesce(a4.adminfee,0)
            )*(a3.taxper/100) + coalesce(a3.custtotalgross,0)) TotalBill,
        <cfelse>
            sum(coalesce(a3.custtotalgross,0)*(a3.taxper/100)) GST,
            sum(coalesce(a3.custtotalgross,0)*(a3.taxper/100) + coalesce(a3.custtotalgross,0)) TotalBill,
        </cfif>
        "" as Remarks,
        aa.taxper,
        sum(0
        <cfloop  index="a" from="1" to="6">
            + coalesce(case when a3.fixawcode#a#= 120 and (year(aa.completedate) > 2018 or (year(aa.completedate) >= 2018 and month(aa.completedate)>=9)) then coalesce(a3.fixawer#a#,0) else 0 end,0)
            + coalesce(case when a4.fixawcode#a#= 120 and (year(aa.completedate) > 2018 or (year(aa.completedate) >= 2018 and month(aa.completedate)>=9)) then coalesce(a4.fixawer#a#,0) else 0 end,0)
        </cfloop>
        <cfloop  index="a" from="1" to="18">
            + coalesce(case when a3.allowance#a#= 120 and (year(aa.completedate) > 2018 or (year(aa.completedate) >= 2018 and month(aa.completedate)>=9)) then coalesce(a3.awer#a#,0) else 0 end,0)
            + coalesce(case when a4.allowance#a#= 120 and (year(aa.completedate) > 2018 or (year(aa.completedate) >= 2018 and month(aa.completedate)>=9)) then coalesce(a4.awer#a#,0) else 0 end,0)
        </cfloop>
            
            + case when (year(aa.completedate) > 2018 or (year(aa.completedate) >= 2018 and month(aa.completedate)>=9)) then coalesce(a3.adminfee,0) else 0 end
            + case when (year(aa.completedate) > 2018 or (year(aa.completedate) >= 2018 and month(aa.completedate)>=9)) then  coalesce(a4.adminfee,0) else 0 end
        ) taxableamt,
        ppl.jobpostype
        
        FROM assignmentslip aa
        LEFT JOIN #dts_p#.pmast p3
        ON aa.empno=p3.empno
        LEFT JOIN assignmentslip a3
        ON case when month(aa.completedate)<>"#form.period#" and p3.jtitle="Maternity Replacement" then 0 else aa.refno=a3.refno end   
        LEFT JOIN assignmentslip a4
        ON case when month(aa.completedate)<>"#form.period#" and p3.jtitle="Maternity Replacement" then aa.refno=a4.refno else 0 end
        LEFT JOIN placement ppl
        ON aa.placementno=ppl.placementno
        <!---Store Name--->
        left join 
        (
        SELECT * FROM #dts_p#.outletlocation
        WHERE outletno=1) outlet1
        on aa.empno=outlet1.empno
        left join 
        (
        SELECT * FROM #dts_p#.outletlocation
        WHERE outletno=2) outlet2
        on aa.empno=outlet2.empno
        left join 
        (
        SELECT * FROM #dts_p#.outletlocation
        WHERE outletno=3) outlet3
        on aa.empno=outlet3.empno
        <!---Store Name--->
            
        WHERE aa.payrollperiod=#form.period#
        AND (aa.custname like "%l'oreal%"  or aa.custname like "%loreal%")
        AND ppl.jobpostype in (#form.jobpostype#)
        AND aa.empno !='0'
        AND aa.empno != '100123480'<!---Advanced Billing account--->
        <!---AND aa.selftotal--->
        GROUP BY aa.empno
    ) a
        
    LEFT JOIN (
        SELECT aa.empno,sum(custsalary) backpay FROM assignmentslip aa
        LEFT JOIN #dts_p#.pmast pp
        ON aa.empno=pp.empno
        WHERE payrollperiod=#form.period#
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND aa.empno !='0'
        AND aa.empno != '100123480'<!---Advanced Billing account--->
        <!---AND selftotal--->
        AND month(completedate) <> #form.period# AND jtitle="Maternity Replacement"
        GROUP BY aa.empno
    ) backa
    ON a.empno=backa.empno
            
    GROUP BY a.empno
    ORDER BY workordid,a.empno
    </cfquery>

    <!---Add 1st sheets--->
    <cfset overall = SpreadSheetNew(true)>
        
    <cfset addcolumn = 0>
        
    <cfset removecolumn = 0>
        
    <cfif (getmmonth.myear eq 2019 and form.period gte 3) or getmmonth.myear gt 2019>
        <cfset removecolumn = -3>
    </cfif>
        
    <cfquery name="checknpl" dbtype="query">
        SELECT sum(UPL) UPL
        FROM getvariabledata
    </cfquery>

    <cfif checknpl.upl neq 0>
        <cfset addcolumn = 1>  
    </cfif>

    <cfset SpreadSheetAddRow(overall, ",L'OREAL MALAYSIA SDN BHD")>    

    <cfset SpreadSheetAddRow(overall, ",CONSUMER PRODUCT DIVISION")>

    <cfset SpreadSheetAddRow(overall, ",BEAUTY ADVISOR  MONTHLY  SALES  REPORT  CHECK  LIST")>

    <cfset SpreadSheetAddRow(overall, ",AREA  COORDINATOR")>

    <cfset SpreadSheetAddRow(overall, ",REMARKS")>  

    <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
    <cfset spreadsheetAddColumn(overall, "#thisperiod#", 1, 25, false)>
    <cfset spreadsheetAddColumn(overall, "#getmmonth.myear#", 1, 26, false)>
    <cfset spreadsheetAddColumn(overall, "#lastperiod#", 2, 25, false)>
    <cfset spreadsheetAddColumn(overall, "#lastyear#", 2, 26, false)>

    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
        
    
    <!---Header--->
    <cfset header1 = "">
    
    <cfloop index="i" from="1" to="#31+addcolumn+removecolumn#">
        <cfset header1 = header1&",">  
    </cfloop>
        
    <cfset header1 = header1&"O/T (HOURS/RATE)">  
    
    <cfset SpreadSheetAddRow(overall, header1)>
        
    <cfif checknpl.upl neq 0>
        <cfset header2 = "Job Order No,Employee ID,Employee Name,NRIC No,Position,Store Name,Requested by,Region,Start Date,End Date,Days Worked,Basic Wage,Total Normal Working Days,Working on Normal day, Total Normal(RM),Total Concourse Day,Working on Concourse,Total RM (Concourse),Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH),Back Pay Salary,UPL,Disbursement (Stationery),Total Sales Figure,Incentive,Total Gross Wage,Normal (Hour),Normal (RM),OFF/PH (Hour),OFF/PH (RM),PH Excess (Hour),PH Excess (RM),Total OT (Hour),Total OT (RM),Cur ER Man EPF,Cur ER SOCSO,EIS,Sub Total,Admin Fee,Total Billing">
    <cfelse>
        <cfset header2 = "Job Order No,Employee ID,Employee Name,NRIC No,Position,Store Name,Requested by,Region,Start Date,End Date,Days Worked,Basic Wage,Total Normal Working Days,Working on Normal day, Total Normal(RM),Total Concourse Day,Working on Concourse,Total RM (Concourse),Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH),Back Pay Salary,Disbursement (Stationery),Total Sales Figure,Incentive,Total Gross Wage,Normal (Hour),Normal (RM),OFF/PH (Hour),OFF/PH (RM),PH Excess (Hour),PH Excess (RM),Total OT (Hour),Total OT (RM),Cur ER Man EPF,Cur ER SOCSO,EIS,Sub Total,Admin Fee,Total Billing">
    </cfif>
        
    <cfif (getmmonth.myear eq 2019 and form.period gte 3) or getmmonth.myear gt 2019>
        <cfset header2 = replace(header2,',Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH)',',Basic Wage (Normal+Concourse)')>
    </cfif>

    <cfif form.period gte 6 and getmmonth.myear eq 2018 and form.period lte 8>
        <cfset header2 = header2&",0% GST,Total Billing with GST,Remarks">   
    <cfelseif (form.period gte 9 and getmmonth.myear gte 2018) or getmmonth.myear gte 2018>
        <cfset header2 = header2&",6% Service Tax,Total Billing with SST,Remarks">
    <cfelse>
        <cfset header2 = header2&",6% GST,Total Billing with GST,Remark">  
    </cfif>

    <cfset SpreadSheetAddRow(overall, header2)>

    <cfset header3 = "">    
    
    <cfloop index="i" from="1" to="#27+addcolumn+removecolumn#">
        <cfset header3 = header3&",">  
    </cfloop>
        
    <cfset header3 = header3&"1.5,1.5,2.0,2.0,3.0,3.0,1.5+2.0+3.0,1.5+2.0+3.0">  
    
    <cfset SpreadSheetAddRow(overall, header3)>
     <!---Header--->
       
    <cfquery name="getvariabledataoutput" dbtype="query">
        SELECT current_jo, empno, empname, nricn, jtitle, worklocation, supervisor, workordid, dcomm, dresign, daysworked, BasicRate, 
        totalnormalday, normalrate, totalnormal, total_concourse_day, working_concourse, total_concourse, 
        <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
            total_day_ph, working_ph, total_ph, 
        </cfif>  
        BasicWage,BackPaySalary,
        <cfif checknpl.upl neq 0>
            UPL,
        </cfif> 
        TotalReimbursement, TotalSalesFigure, Incentive, GrossWage, custothour2, custot2, custothour3, custot3, custothour4, custot4, custothours, custottotal, custcpf, custsdf, custeis, subtotal, adminfee, custtotalgross, GST, TotalBill, Remarks
        FROM getvariabledata
    </cfquery>

    <cfset SpreadSheetAddRows(overall, getvariabledataoutput)>

    <cfset tnormalday = 0>
    <cfset tnormal = 0>
    <cfset tconcourseday = 0>
    <cfset tworkconcourse = 0>
    <cfset tconcourse = 0>
    <cfset tphday = 0>
    <cfset tworkingph = 0>
    <cfset tph = 0>
    <cfset tbasicwage = 0>
    <cfset tbackpay = 0>
    <cfset tupl = 0>
    <cfset treimburse = 0>
    <cfset tincentive = 0>
    <cfset tgross = 0>
    <cfset t15h = 0>
    <cfset t15amt = 0>
    <cfset t20h = 0>
    <cfset t20amt = 0>
    <cfset t30h = 0>
    <cfset t30amt = 0>
    <cfset toth = 0>
    <cfset totamt = 0>
    <cfset tepf = 0>
    <cfset tsocso = 0>
    <cfset teis = 0>
    <cfset tsubtotal = 0>
    <cfset tadminfee = 0>
    <cfset ttotalbill = 0>
    <cfset tgst = 0>
    <cfset ttotalbillgst = 0>

    <cfloop query="getvariabledata">
        <cfset tnormalday = val(tnormalday) + val(getvariabledata.totalnormalday)>    
        <cfset tnormal = val(tnormal) + val(getvariabledata.totalnormal)>
        <cfset tconcourseday = val(tconcourseday) + val(getvariabledata.total_concourse_day)>
        <cfset tworkconcourse = val(tworkconcourse) + val(getvariabledata.working_concourse)>
        <cfset tconcourse = val(tconcourse) + val(getvariabledata.total_concourse)>
        <cfset tphday = val(tphday) + val(getvariabledata.total_day_ph)>
        <cfset tworkingph = val(tworkingph) + val(getvariabledata.working_ph)>
        <cfset tph = val(tph) + val(getvariabledata.total_ph)>
        <cfset tbasicwage = val(tbasicwage) + val(getvariabledata.basicwage)>
        <cfset tbackpay = val(tbackpay) + val(getvariabledata.BackPaySalary)>
        <cfif checknpl.upl neq 0>
            <cfset tupl = val(tupl) + val(getvariabledata.upl)>
        </cfif>
        <cfset treimburse = val(treimburse) + val(getvariabledata.TotalReimbursement)>
        <cfset tincentive = val(tincentive) + val(getvariabledata.Incentive)>
        <cfset tgross = val(tgross) + val(getvariabledata.GrossWage)>
        <cfset t15h = val(t15h) + val(getvariabledata.custothour2)>
        <cfset t15amt = val(t15amt) + val(getvariabledata.custot2)>
        <cfset t20h = val(t20h) + val(getvariabledata.custothour3)>
        <cfset t20amt = val(t20amt) + val(getvariabledata.custot3)>
        <cfset t30h = val(t30h) + val(getvariabledata.custothour4)>
        <cfset t30amt = val(t30amt) + val(getvariabledata.custot4)>
        <cfset toth = val(toth) + val(getvariabledata.custothours)>
        <cfset totamt = val(totamt) + val(getvariabledata.custottotal)>
        <cfset tepf = val(tepf) + val(getvariabledata.custcpf)>
        <cfset tsocso = val(tsocso) + val(getvariabledata.custsdf)>
        <cfset teis = val(teis) + val(getvariabledata.custeis)>
        <cfset tsubtotal = val(tsubtotal) + val(getvariabledata.subtotal)>
        <cfset tadminfee = val(tadminfee) + val(getvariabledata.adminfee)>
        <cfset ttotalbill = val(ttotalbill) + val(getvariabledata.custtotalgross)>
        <cfset tgst = val(tgst) + val(getvariabledata.gst)>
        <cfset ttotalbillgst = val(ttotalbillgst) + val(getvariabledata.TotalBill)>
    </cfloop>

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

    <cfset totalline = "">

    <cfloop index="a" from="1" to="12">
        <cfset totalline = totalline&",">
    </cfloop>

    <!---<cfset SpreadSheetAddRow(overall, "#totalline##tnormalday#,,#tnormal#,#tconcourseday#,,#tconcourse#,#tphday#,,#tph#,#tbasicwage#,#tbackpay#,#treimburse#,,#tincentive#,#tgross#,#t15h#,#t15amt#,#t20h#,#t20amt#,#t30h#,#t30amt#,#toth#,#totamt#,#tepf#,#tsocso#,#teis#,#tsubtotal#,#tadminfee#,#ttotalbill#,#tgst#,#ttotalbillgst#")>--->

    <cfset SpreadSheetAddRow(overall, ",Total:")>   
        
    <cfloop query="getvariabledata">
        <cfset spreadsheetSetCellFormula(overall, "M#10+getvariabledata.currentrow#*N#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,15)>
        
        <cfset spreadsheetSetCellFormula(overall, "P#10+getvariabledata.currentrow#*Q#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,18)>

        <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
            <cfset spreadsheetSetCellFormula(overall, "S#10+getvariabledata.currentrow#*T#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,21)>
            
            <cfset spreadsheetSetCellFormula(overall, "L#10+getvariabledata.currentrow#+O#10+getvariabledata.currentrow#+U#10+getvariabledata.currentrow#+R#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,22)>
        <cfelse>                
            <cfset spreadsheetSetCellFormula(overall, "L#10+getvariabledata.currentrow#+O#10+getvariabledata.currentrow#+R#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,22+removecolumn)>
        </cfif>
            
        <!---<cfif checknpl.upl neq 0>
            <cfset spreadsheetSetCellFormula(overall, "V#10+getvariabledata.currentrow#+X#10+getvariabledata.currentrow#+W#10+getvariabledata.currentrow#+Y#10+getvariabledata.currentrow#+AA#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,28)>

            <cfset spreadsheetSetCellFormula(overall, "AC#10+getvariabledata.currentrow#+AE#10+getvariabledata.currentrow#+AG#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,35)>

            <cfset spreadsheetSetCellFormula(overall, "AD#10+getvariabledata.currentrow#+AF#10+getvariabledata.currentrow#+AH#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,36)>

            <cfset spreadsheetSetCellFormula(overall, "AB#10+getvariabledata.currentrow#+AJ#10+getvariabledata.currentrow#+AK#10+getvariabledata.currentrow#+AL#10+getvariabledata.currentrow#+AM#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,40)>

            <cfif getvariabledata.jobpostype eq 1 and (getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 10))>
                <cfset spreadsheetSetCellFormula(overall, "ROUND((U#10+getvariabledata.currentrow#+W#10+getvariabledata.currentrow#+AA#10+getvariabledata.currentrow#+AB#10+getvariabledata.currentrow#+AJ#10+getvariabledata.currentrow#+AK#10+getvariabledata.currentrow#+AL#10+getvariabledata.currentrow#+AM#10+getvariabledata.currentrow#)*0.05,2)", 10+getvariabledata.currentrow,41)>
            <cfelse>
                <cfset spreadsheetSetCellFormula(overall, "ROUND((U#10+getvariabledata.currentrow#+W#10+getvariabledata.currentrow#+AA#10+getvariabledata.currentrow#+AB#10+getvariabledata.currentrow#+AJ#10+getvariabledata.currentrow#+AK#10+getvariabledata.currentrow#+AL#10+getvariabledata.currentrow#+AM#10+getvariabledata.currentrow#)*0.05,2)", 10+getvariabledata.currentrow,41)>
            </cfif>

            <cfset spreadsheetSetCellFormula(overall, "AN#10+getvariabledata.currentrow#+AO#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,42)>

            <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
                <cfset spreadsheetSetCellFormula(overall, "#val(getvariabledata.taxableamt)#*0.06", 10+getvariabledata.currentrow,43)>
            <cfelse>
                <cfset spreadsheetSetCellFormula(overall, "AP#10+getvariabledata.currentrow#*#val(getvariabledata.taxper)/100#", 10+getvariabledata.currentrow,43)>
            </cfif>

            <cfset spreadsheetSetCellFormula(overall, "AP#10+getvariabledata.currentrow#+AQ#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,44)>
                
            <cfloop index="aa" from="12" to="44">
                <cfif aa neq 14 and aa neq 17 and aa neq 20>
                    <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata.recordcount#)", 10+getvariabledata.recordcount+3,aa)>
                </cfif>
            </cfloop>
            
        <cfelse>--->
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(22+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(24+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,27+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(28+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(30+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(32+addcolumn+removecolumn)##10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,34+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(29+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(31+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(33+addcolumn+removecolumn)##10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,35+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(27+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(35+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,39+addcolumn+removecolumn)>

            <cfif getvariabledata.jobpostype eq 1 and (getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 10))>
                
                <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata.currentrow#+#numbertoletter(21+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata.currentrow#)*0.05,2)">
                <cfelse>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata.currentrow#)*0.05,2)">
                </cfif>
                
                <cfset spreadsheetSetCellFormula(overall, adminfeeformula, 10+getvariabledata.currentrow,40+addcolumn+removecolumn)>
            <cfelse>
                <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata.currentrow#+#numbertoletter(21+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(35+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata.currentrow#)*0.05,2)">
                <cfelse>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(35+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata.currentrow#)*0.05,2)">
                </cfif>
                
                <cfset spreadsheetSetCellFormula(overall, adminfeeformula, 10+getvariabledata.currentrow,40+addcolumn+removecolumn)>
            </cfif>            

            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(39+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(40+addcolumn+removecolumn)##10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,41+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(41+addcolumn+removecolumn)##10+getvariabledata.currentrow#*#val(getvariabledata.taxper)/100#", 10+getvariabledata.currentrow,42+addcolumn+removecolumn)>
                
            <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
                <cfset spreadsheetSetCellFormula(overall, "#val(getvariabledata.taxableamt)#*0.06", 10+getvariabledata.currentrow,42+addcolumn+removecolumn)>
            <cfelse>
                <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(41+addcolumn+removecolumn)##10+getvariabledata.currentrow#*#val(getvariabledata.taxper)/100#", 10+getvariabledata.currentrow,42+addcolumn+removecolumn)>
            </cfif>

            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(41+addcolumn+removecolumn)##10+getvariabledata.currentrow#+#numbertoletter(42+addcolumn+removecolumn)##10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,43+addcolumn+removecolumn)>
                
            <cfloop index="aa" from="12" to="#43+removecolumn#">
                <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                    <cfif aa neq 14 and aa neq 17 and aa neq 20>
                        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata.recordcount#)", 10+getvariabledata.recordcount+3,aa)>
                    </cfif>
                <cfelse>
                    <cfif aa neq 14 and aa neq 17>
                        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata.recordcount#)", 10+getvariabledata.recordcount+3,aa)>
                    </cfif>
                </cfif>
            </cfloop>
        <!---</cfif>--->
                
        

    </cfloop>

    <cfset spreadsheetSetCellFormula(overall, "COUNTA(A11:A#10+getvariabledata.recordcount#)", 10+getvariabledata.recordcount+3, 3)>

    <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->    

    <cfset SpreadSheetFormatCellRange(overall, s67, 11, 12, getvariabledata.recordcount+11, 41+addcolumn+removecolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s69, 11, 42+addcolumn, getvariabledata.recordcount+11, 43+addcolumn+removecolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s67, getvariabledata.recordcount+13, 12, getvariabledata.recordcount+13, 43+addcolumn+removecolumn)>

    <cfset SpreadSheetFormatCellRange(overall, s28, 11, 1, getvariabledata.recordcount+10, 44+addcolumn+removecolumn)>
        
    <cfset SpreadSheetFormatCellRange(overall, sTextwrap, 11, 6, getvariabledata.recordcount+10, 6)>

    <!---Header--->
    <cfset SpreadSheetFormatCellRange(overall, s36, 8, 1, 8, 27+addcolumn+removecolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s36, 8, 36+addcolumn+removecolumn, 8, 44+addcolumn+removecolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s34, 8, 28+addcolumn+removecolumn, 8, 35+addcolumn+removecolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s36, 9, 28+addcolumn+removecolumn, 9, 35+addcolumn+removecolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s36, 10, 28+addcolumn+removecolumn, 10, 35+addcolumn+removecolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s31, 9, 1, 10, 44+addcolumn+removecolumn)>
    <!---Header--->

    <cfloop index="i" from="1" to="#43+removecolumn#">
        <cfset spreadsheetSetColumnWidth(overall, i, columnnumbers) >
    </cfloop>

    <cfset spreadsheetSetColumnWidth(overall, 3, columnname) >
        
    <cfset spreadsheetSetColumnWidth(overall, 31+removecolumn, 16) >

    <cfset spreadsheetSetColumnWidth(overall, 32+removecolumn, 20) >

    <cfset SpreadSheetFormatCellRange(overall, s32, 1, 25, 2, 26)>

    <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->  
    <cfset spreadsheetSetRowHeight(overall, 9, 41)>
    
    <cfset spreadsheetSetRowHeight(overall, 8, 28)>
        
    <cfset SpreadSheetFormatCellRange(overall, s68, 9, 9, getvariabledata.recordcount+10, 10)> 

    <cfspreadsheet action="write" sheetname="Payroll Detail report" filename="#HRootPath#\Excel_Report\Payroll_Report_#timenow#.xlsx" name="overall" overwrite="true">


    <!---Add 1st sheets--->

    <!---Add 2nd sheets--->

    <cfquery name="checkregion" dbtype="query">
        SELECT workordid 
        FROM getvariabledata
        WHERE workordid != '' and workordid is not null
        GROUP BY workordid     
    </cfquery>

    <cfif checkregion.recordcount gt 1>

    <cfloop query="checkregion">

    <cfquery name="getvariabledata1" dbtype="query">
    SELECT *
    FROM getvariabledata
    WHERE workordid='#checkregion.workordid#'
    </cfquery>
        
    <cfset addcolumn = 0>
        
    <cfquery name="checkupl1" dbtype="query">
    SELECT sum(UPL) UPL
    FROM getvariabledata
    WHERE workordid='#checkregion.workordid#'
    </cfquery>

    <cfif checkupl1.upl neq 0>
        <cfset addcolumn = 1>  
    </cfif>

    <cfif getvariabledata1.recordcount neq 0>

        <cfset tempvar = SpreadSheetNew(true)>

        <cfset SpreadSheetAddRow(tempvar, ",L'OREAL MALAYSIA SDN BHD")>    

        <cfset SpreadSheetAddRow(tempvar, ",CONSUMER PRODUCT DIVISION")>

        <cfset SpreadSheetAddRow(tempvar, ",BEAUTY ADVISOR  MONTHLY  SALES  REPORT  CHECK  LIST")>

        <cfset SpreadSheetAddRow(tempvar, ",AREA  COORDINATOR")>

        <cfset SpreadSheetAddRow(tempvar, ",REMARKS")>   

        <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
        <cfset spreadsheetAddColumn(tempvar, "#thisperiod#", 1, 25, false)>
        <cfset spreadsheetAddColumn(tempvar, "#getmmonth.myear#", 1, 26, false)>
        <cfset spreadsheetAddColumn(tempvar, "#lastperiod#", 2, 25, false)>
        <cfset spreadsheetAddColumn(tempvar, "#lastyear#", 2, 26, false)>

        <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>
        <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>

        <!---Header--->
        <cfset header1 = "">    
    
        <cfloop index="i" from="1" to="#31+removecolumn#">
            <cfset header1 = header1&",">  
        </cfloop>

        <cfset header1 = header1&"O/T (HOURS/RATE)">  

        <cfset SpreadSheetAddRow(tempvar, header1)>
            
        <!---<cfif checkupl1.upl neq 0>
            <cfset header2 = "Job Order No,Employee ID,Employee Name,NRIC No,Position,Store Name,Requested by,Region,Start Date,End Date,Days Worked,Basic Wage,Total Normal Working Days,Working on Normal day, Total Normal(RM),Total Concourse Day,Working on Concourse,Total RM (Concourse),Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH),Back Pay Salary,UPL,Disbursement (Stationery),Total Sales Figure,Incentive,Total Gross Wage,Normal (Hour),Normal (RM),OFF/PH (Hour),OFF/PH (RM),PH Excess (Hour),PH Excess (RM),Total OT (Hour),Total OT (RM),Cur ER Man EPF,Cur ER SOCSO,EIS,Sub Total,Admin Fee,Total Billing">
        <cfelse>
            <cfset header2 = "Job Order No,Employee ID,Employee Name,NRIC No,Position,Store Name,Requested by,Region,Start Date,End Date,Days Worked,Basic Wage,Total Normal Working Days,Working on Normal day, Total Normal(RM),Total Concourse Day,Working on Concourse,Total RM (Concourse),Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH),Back Pay Salary,Disbursement (Stationery),Total Sales Figure,Incentive,Total Gross Wage,Normal (Hour),Normal (RM),OFF/PH (Hour),OFF/PH (RM),PH Excess (Hour),PH Excess (RM),Total OT (Hour),Total OT (RM),Cur ER Man EPF,Cur ER SOCSO,EIS,Sub Total,Admin Fee,Total Billing">
        </cfif>
            
        <cfif getmmonth.myear gte 2019>
            <cfif form.period gte 3>
                <cfset header2 = replace(header2,',Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH)',',Basic Wage (Normal+Concourse)')>
                <cfset addcolumn = -3> 
            </cfif>
        </cfif>

        <cfif form.period gte 6 and getmmonth.myear eq 2018 and form.period lte 8>
            <cfset header2 = header2&",0% GST,Total Billing with GST,Remarks">   
        <cfelseif (form.period gte 9 and getmmonth.myear gte 2018) or getmmonth.myear gte 2018>
            <cfset header2 = header2&",6% Service Tax,Total Billing with SST,Remarks">
        <cfelse>
            <cfset header2 = header2&",6% GST,Total Billing with GST,Remark">  
        </cfif>--->

        <cfset SpreadSheetAddRow(tempvar, header2)>

        <cfset header3 = "">    
    
        <cfloop index="i" from="1" to="#27+addcolumn+removecolumn#">
            <cfset header3 = header3&",">  
        </cfloop>

        <cfset header3 = header3&"1.5,1.5,2.0,2.0,3.0,3.0,1.5+2.0+3.0,1.5+2.0+3.0">  

        <cfset SpreadSheetAddRow(tempvar, header3)>
            
        <cfquery name="getvariabledata1output" dbtype="query">
        SELECT current_jo, empno, empname, nricn, jtitle, worklocation, supervisor, workordid, dcomm, dresign, daysworked, BasicRate, 
            totalnormalday, normalrate, totalnormal, total_concourse_day, working_concourse, total_concourse, 
            <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                total_day_ph, working_ph, total_ph,
            </cfif>
            BasicWage,BackPaySalary,
            <cfif checkupl1.upl neq 0>
                UPL,
            </cfif> 
            TotalReimbursement, TotalSalesFigure, Incentive, GrossWage, custothour2, custot2, custothour3, custot3, custothour4, custot4, custothours, custottotal, custcpf, custsdf, custeis, subtotal, adminfee, custtotalgross, GST, TotalBill, Remarks
        FROM getvariabledata
        WHERE workordid='#checkregion.workordid#'
        </cfquery>

        <cfset SpreadSheetAddRows(tempvar, getvariabledata1output)>

        <cfset tnormalday = 0>
        <cfset tnormal = 0>
        <cfset tconcourseday = 0>
        <cfset tworkconcourse = 0>
        <cfset tconcourse = 0>
        <cfset tphday = 0>
        <cfset tworkingph = 0>
        <cfset tph = 0>
        <cfset tbasicwage = 0>
        <cfset tbackpay = 0>
        <cfset treimburse = 0>
        <cfset tincentive = 0>
        <cfset tgross = 0>
        <cfset t15h = 0>
        <cfset t15amt = 0>
        <cfset t20h = 0>
        <cfset t20amt = 0>
        <cfset t30h = 0>
        <cfset t30amt = 0>
        <cfset toth = 0>
        <cfset totamt = 0>
        <cfset tepf = 0>
        <cfset tsocso = 0>
        <cfset teis = 0>
        <cfset tsubtotal = 0>
        <cfset tadminfee = 0>
        <cfset ttotalbill = 0>
        <cfset tgst = 0>
        <cfset ttotalbillgst = 0>

        <cfloop query="getvariabledata1">
            <cfset tnormalday = val(tnormalday) + val(getvariabledata1.totalnormalday)>    
            <cfset tnormal = val(tnormal) + val(getvariabledata1.totalnormal)>
            <cfset tconcourseday = val(tconcourseday) + val(getvariabledata1.total_concourse_day)>
            <cfset tworkconcourse = val(tworkconcourse) + val(getvariabledata1.working_concourse)>
            <cfset tconcourse = val(tconcourse) + val(getvariabledata1.total_concourse)>
            <cfset tphday = val(tphday) + val(getvariabledata1.total_day_ph)>
            <cfset tworkingph = val(tworkingph) + val(getvariabledata1.working_ph)>
            <cfset tph = val(tph) + val(getvariabledata1.total_ph)>
            <cfset tbasicwage = val(tbasicwage) + val(getvariabledata1.basicwage)>
            <cfset tbackpay = val(tbackpay) + val(getvariabledata.BackPaySalary)>
            <cfset treimburse = val(treimburse) + val(getvariabledata1.TotalReimbursement)>
            <cfset tincentive = val(tincentive) + val(getvariabledata1.Incentive)>
            <cfset tgross = val(tgross) + val(getvariabledata1.GrossWage)>
            <cfset t15h = val(t15h) + val(getvariabledata1.custothour2)>
            <cfset t15amt = val(t15amt) + val(getvariabledata1.custot2)>
            <cfset t20h = val(t20h) + val(getvariabledata1.custothour3)>
            <cfset t20amt = val(t20amt) + val(getvariabledata1.custot3)>
            <cfset t30h = val(t30h) + val(getvariabledata1.custothour4)>
            <cfset t30amt = val(t30amt) + val(getvariabledata1.custot4)>
            <cfset toth = val(toth) + val(getvariabledata1.custothours)>
            <cfset totamt = val(totamt) + val(getvariabledata1.custottotal)>
            <cfset tepf = val(tepf) + val(getvariabledata1.custcpf)>
            <cfset tsocso = val(tsocso) + val(getvariabledata1.custsdf)>
            <cfset teis = val(teis) + val(getvariabledata1.custeis)>
            <cfset tsubtotal = val(tsubtotal) + val(getvariabledata1.subtotal)>
            <cfset tadminfee = val(tadminfee) + val(getvariabledata1.adminfee)>
            <cfset ttotalbill = val(ttotalbill) + val(getvariabledata1.custtotalgross)>
            <cfset tgst = val(tgst) + val(getvariabledata1.gst)>
            <cfset ttotalbillgst = val(ttotalbillgst) + val(getvariabledata1.TotalBill)>
        </cfloop>

            <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>
            <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>

        <cfset totalline = "">

        <cfloop index="a" from="1" to="12">
            <cfset totalline = totalline&",">
        </cfloop>

        <!---<cfset SpreadSheetAddRow(tempvar, "#totalline##tnormalday#,,#tnormal#,#tconcourseday#,,#tconcourse#,#tphday#,,#tph#,#tbasicwage#,#tbackpay#,#treimburse#,,#tincentive#,#tgross#,#t15h#,#t15amt#,#t20h#,#t20amt#,#t30h#,#t30amt#,#toth#,#totamt#,#tepf#,#tsocso#,#teis#,#tsubtotal#,#tadminfee#,#ttotalbill#,#tgst#,#ttotalbillgst#")>--->

        <cfset SpreadSheetAddRow(tempvar, ",Total:")>  
            
        <cfloop query="getvariabledata1">
            <cfset spreadsheetSetCellFormula(tempvar, "M#10+getvariabledata1.currentrow#*N#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,15)>
            
            <cfset spreadsheetSetCellFormula(tempvar, "P#10+getvariabledata1.currentrow#*Q#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,18)>

            <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                <cfset spreadsheetSetCellFormula(tempvar, "S#10+getvariabledata1.currentrow#*T#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,21)>
                    
                <cfset spreadsheetSetCellFormula(tempvar, "L#10+getvariabledata1.currentrow#+O#10+getvariabledata1.currentrow#+U#10+getvariabledata1.currentrow#+R#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,22)>
                    
            <cfelse>
                
                <cfset spreadsheetSetCellFormula(tempvar, "L#10+getvariabledata1.currentrow#+O#10+getvariabledata1.currentrow#+R#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,22)>
            </cfif>
            
            

            <!---<cfif checkupl1.upl neq 0>
                <cfset spreadsheetSetCellFormula(tempvar, "V#10+getvariabledata1.currentrow#+X#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#+Y#10+getvariabledata1.currentrow#+AA#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,28)>

                <cfset spreadsheetSetCellFormula(tempvar, "AC#10+getvariabledata1.currentrow#+AE#10+getvariabledata1.currentrow#+AG#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,35)>

                <cfset spreadsheetSetCellFormula(tempvar, "AD#10+getvariabledata1.currentrow#+AF#10+getvariabledata1.currentrow#+AH#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,36)>

                <cfset spreadsheetSetCellFormula(tempvar, "AB#10+getvariabledata1.currentrow#+AJ#10+getvariabledata1.currentrow#+AK#10+getvariabledata1.currentrow#+AL#10+getvariabledata1.currentrow#+AM#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,40)>

                <cfif getvariabledata1.jobpostype eq 1 and (getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 10))>
                    <cfset spreadsheetSetCellFormula(tempvar, "ROUND((U#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#+AA#10+getvariabledata1.currentrow#+AB#10+getvariabledata1.currentrow#+AK#10+getvariabledata1.currentrow#+AL#10+getvariabledata1.currentrow#+AM#10+getvariabledata1.currentrow#)*0.05,2)", 10+getvariabledata1.currentrow,41)>
                <cfelse>
                    <cfset spreadsheetSetCellFormula(tempvar, "ROUND((U#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#+AA#10+getvariabledata1.currentrow#+AB#10+getvariabledata1.currentrow#+AJ#10+getvariabledata1.currentrow#+AK#10+getvariabledata1.currentrow#+AL#10+getvariabledata1.currentrow#+AM#10+getvariabledata1.currentrow#)*0.05,2)", 10+getvariabledata1.currentrow,41)>
                </cfif>

                <cfset spreadsheetSetCellFormula(tempvar, "AN#10+getvariabledata1.currentrow#+AO#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,42)>

                <cfset spreadsheetSetCellFormula(tempvar, "AP#10+getvariabledata1.currentrow#*#val(getvariabledata1.taxper)/100#", 10+getvariabledata1.currentrow,43)>

                <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
                    <cfset spreadsheetSetCellFormula(tempvar, "#val(getvariabledata1.taxableamt)#*0.06", 10+getvariabledata1.currentrow,43)>
                <cfelse>
                    <cfset spreadsheetSetCellFormula(tempvar, "AP#10+getvariabledata1.currentrow#*#val(getvariabledata1.taxper)/100#", 10+getvariabledata1.currentrow,43)>
                </cfif>
                
                <cfset spreadsheetSetCellFormula(tempvar, "AP#10+getvariabledata1.currentrow#+AQ#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,44)>

                <cfloop index="aa" from="12" to="44">
                    <cfif aa neq 14 and aa neq 17 and aa neq 20>
                        <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3,aa)>
                    </cfif>
                </cfloop>

            <cfelse>
                <cfset spreadsheetSetCellFormula(tempvar, "V#10+getvariabledata1.currentrow#+X#10+getvariabledata1.currentrow#+Z#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,27)>

                <cfset spreadsheetSetCellFormula(tempvar, "AB#10+getvariabledata1.currentrow#+AD#10+getvariabledata1.currentrow#+AF#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,34)>

                <cfset spreadsheetSetCellFormula(tempvar, "AC#10+getvariabledata1.currentrow#+AE#10+getvariabledata1.currentrow#+AG#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,35)>

                <cfset spreadsheetSetCellFormula(tempvar, "AA#10+getvariabledata1.currentrow#+AI#10+getvariabledata1.currentrow#+AJ#10+getvariabledata1.currentrow#+AK#10+getvariabledata1.currentrow#+AL#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,39)>

                <cfif getvariabledata1.jobpostype eq 1 and (getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 10))>
                    <cfset spreadsheetSetCellFormula(tempvar, "ROUND((L#10+getvariabledata1.currentrow#+U#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#+AJ#10+getvariabledata1.currentrow#+AK#10+getvariabledata1.currentrow#+AL#10+getvariabledata1.currentrow#+Z#10+getvariabledata1.currentrow#)*0.05,2)", 10+getvariabledata1.currentrow,40)>
                <cfelse>
                    <cfset spreadsheetSetCellFormula(tempvar, "ROUND((L#10+getvariabledata1.currentrow#+U#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#+AI#10+getvariabledata1.currentrow#+AJ#10+getvariabledata1.currentrow#+AK#10+getvariabledata1.currentrow#+AL#10+getvariabledata1.currentrow#+Z#10+getvariabledata1.currentrow#)*0.05,2)", 10+getvariabledata1.currentrow,40)>
                </cfif>

                <cfset spreadsheetSetCellFormula(tempvar, "AM#10+getvariabledata1.currentrow#+AN#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,41)>

                <cfset spreadsheetSetCellFormula(tempvar, "AN#10+getvariabledata1.currentrow#*#val(getvariabledata1.taxper)/100#", 10+getvariabledata1.currentrow,42)>
                    
                <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
                    <cfset spreadsheetSetCellFormula(tempvar, "#val(getvariabledata1.taxableamt)#*0.06", 10+getvariabledata1.currentrow,42)>
                <cfelse>
                    <cfset spreadsheetSetCellFormula(tempvar, "AN#10+getvariabledata1.currentrow#*#val(getvariabledata1.taxper)/100#", 10+getvariabledata1.currentrow,42)>
                </cfif>

                <cfset spreadsheetSetCellFormula(tempvar, "AO#10+getvariabledata1.currentrow#+AP#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,43)>

                <cfloop index="aa" from="12" to="43">
                    <cfif aa neq 14 and aa neq 17 and aa neq 20>
                        <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3,aa)>
                    </cfif>
                </cfloop>
            </cfif>--->
                
            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(22+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(24+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,27+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(28+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(30+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(32+addcolumn+removecolumn)##10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,34+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(29+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(31+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(33+addcolumn+removecolumn)##10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,35+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(27+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(35+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,39+addcolumn+removecolumn)>

            <cfif getvariabledata1.jobpostype eq 1 and (getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 10))>
                
                <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata1.currentrow#+#numbertoletter(21+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata1.currentrow#)*0.05,2)">
                <cfelse>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata1.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata1.currentrow#)*0.05,2)">
                </cfif>
                
                <cfset spreadsheetSetCellFormula(tempvar, adminfeeformula, 10+getvariabledata1.currentrow,40+addcolumn+removecolumn)>
            <cfelse>
                <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata1.currentrow#+#numbertoletter(21+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(35+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata1.currentrow#)*0.05,2)">
                <cfelse>
                    <cfset adminfeeformula = "ROUND((#numbertoletter(12)##10+getvariabledata1.currentrow#+#numbertoletter(23+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(35+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(36+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(37+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(38+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(26+addcolumn+removecolumn)##10+getvariabledata1.currentrow#)*0.05,2)">
                </cfif>
                
                <cfset spreadsheetSetCellFormula(tempvar, adminfeeformula, 10+getvariabledata1.currentrow,40+addcolumn+removecolumn)>
            </cfif>            

            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(39+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(40+addcolumn+removecolumn)##10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,41+addcolumn+removecolumn)>

            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(41+addcolumn+removecolumn)##10+getvariabledata1.currentrow#*#val(getvariabledata1.taxper)/100#", 10+getvariabledata1.currentrow,42+addcolumn+removecolumn)>
                
            <cfif getmmonth.myear gt 2018 or (getmmonth.myear eq 2018 and form.period gte 9)>
                <cfset spreadsheetSetCellFormula(tempvar, "#val(getvariabledata1.taxableamt)#*0.06", 10+getvariabledata1.currentrow,42+addcolumn+removecolumn)>
            <cfelse>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(41+addcolumn+removecolumn)##10+getvariabledata1.currentrow#*#val(getvariabledata1.taxper)/100#", 10+getvariabledata1.currentrow,42+addcolumn+removecolumn)>
            </cfif>

            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(41+addcolumn+removecolumn)##10+getvariabledata1.currentrow#+#numbertoletter(42+addcolumn+removecolumn)##10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,43+addcolumn+removecolumn)>
                
            <cfloop index="aa" from="12" to="#43+removecolumn#">
                <cfif (getmmonth.myear eq 2019 and form.period lt 3) or getmmonth.myear lt 2019>
                    <cfif aa neq 14 and aa neq 17 and aa neq 20>
                        <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3,aa)>
                    </cfif>
                <cfelse>
                    <cfif aa neq 14 and aa neq 17>
                        <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3,aa)>
                    </cfif>
                </cfif>
            </cfloop>



        </cfloop>

        <cfset spreadsheetSetCellFormula(tempvar, "COUNTA(A11:A#10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3, 3)>


        <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->    

        <cfset SpreadSheetFormatCellRange(tempvar, s67, 11, 12, getvariabledata1.recordcount+11, 41+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s69, 11, 42+addcolumn, getvariabledata1.recordcount+11, 43+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s67, getvariabledata1.recordcount+13, 12, getvariabledata1.recordcount+13, 41+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s69, getvariabledata1.recordcount+13, 42+addcolumn+removecolumn, getvariabledata1.recordcount+13, 43+addcolumn+removecolumn)>

        <cfset SpreadSheetFormatCellRange(tempvar, s28, 11, 1, getvariabledata1.recordcount+10, 44+addcolumn+removecolumn)>
            
        <cfset SpreadSheetFormatCellRange(tempvar, sTextwrap, 11, 6, getvariabledata1.recordcount+10, 6)>

        <!---Header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s36, 8, 1, 8, 27+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s36, 8, 36+addcolumn+removecolumn, 8, 44+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s34, 8, 28+addcolumn+removecolumn, 8, 35+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s36, 9, 28+addcolumn+removecolumn, 9, 35+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s36, 10, 28+addcolumn+removecolumn, 10, 35+addcolumn+removecolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s31, 9, 1, 10, 44+addcolumn+removecolumn)>
        <!---Header--->

        <cfset SpreadSheetFormatCellRange(tempvar, s32, 1, 25, 2, 26)>

        <cfloop index="i" from="1" to="#44+addcolumn+removecolumn#">
            <cfset spreadsheetSetColumnWidth(tempvar, i, columnnumbers) >
        </cfloop>

        <cfset spreadsheetSetColumnWidth(tempvar, 3, columnname) >
            
        <cfset spreadsheetSetColumnWidth(tempvar, 31, 16) >

        <cfset spreadsheetSetColumnWidth(tempvar, 32+removecolumn, 20) >

        <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
        <cfset spreadsheetSetRowHeight(tempvar, 9, 41)>
            
        <cfset spreadsheetSetRowHeight(tempvar, 8, 28)>
            
        <cfset SpreadSheetFormatCellRange(tempvar, s68, 9, 9, getvariabledata1.recordcount+10, 10)> 

        <cfspreadsheet action="update" sheetname="#checkregion.workordid#" filename="#HRootPath#\Excel_Report\Payroll_Report_#timenow#.xlsx" name="tempvar">
            
    </cfif>

    </cfloop>

    </cfif>  
    <!---Add 2nd sheets--->
            
    <cfset filename = "Payroll_Report for Temp #thisperiod# #getmmonth.myear#_#timenow#">
            
<!---End Temp--->  
</cfif>
            
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
<cfif fileExists("#HRootPath#\Excel_Report\Payroll_Report_#timenow#.xlsx") eq false>
    
    <script>
        alert("No File Generated due to no data for the selected month.");
        window.close();
    </script>
    <cfabort>
        
</cfif>
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#HRootPath#\Excel_Report\Payroll_Report_#timenow#.xlsx">
    
</cfoutput>
    
<cffunction name="numberToLetter">
	<cfargument name="number" default="1" required="Yes" type="numeric" />
	
	<cfscript>
		
		letterRangeStart = 96;
		
		if ( arguments.number LTE 26 )
		{
			return chr( arguments.number + letterRangeStart );
		}
		else
		{
			firstLetter = chr( letterRangeStart + ceiling( arguments.number / 26 ) - 1 );
			if ( arguments.number MOD 26 NEQ 0 )
				secondLetter = chr( letterRangeStart + ( arguments.number MOD 26 ) );
			else
				secondLetter = chr( letterRangeStart + ( 26 ) );
			
			return firstLetter & secondLetter;
		}
	</cfscript>
	
</cffunction>