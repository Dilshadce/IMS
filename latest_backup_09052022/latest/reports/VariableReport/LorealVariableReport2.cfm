<!---Loreal Report Version 2.0--->
<cfoutput>
    
<cfset dts_p = replace(dts,'_i','_p')>
    
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
    
<cfset s23 = StructNew()>                                   
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.textwrap="true">    
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_center">
<cfset s23.topborder="medium">
<cfset s23.leftborder="medium">
<cfset s23.rightborder="medium">
<cfset s23.dataformat="0.0">
    
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
    
<cfset s29 = StructNew()>                                   
<cfset s29.font="Arial">
<cfset s29.fontsize="11">
<cfset s29.bold="true">
<cfset s29.textwrap="true">    
<cfset s29.alignment="center">
<cfset s29.verticalalignment="vertical_center">
<cfset s29.topborder="medium">
    
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
<cfset s36.dataformat="0.0">
    
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
        
<cfset lastperiod = ucase(left(monthAsString(lastperiod),3))>
<!---Prepare period wording--->
    
<cfset reimburseitem = "6,30,1002,119,1001,120,121,122,123,1000">
    
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
    <!---AND custtotalgross--->
    AND month(a.completedate) = #form.period#
    GROUP BY a.empno
    HAVING old_jo != ''  
</cfquery>
    
<cfif checkoldjoexist.recordcount neq 0>
      
<cfquery name="getvariabledata" datasource="#dts#">
SELECT a.empno,replace(replace(group_concat( distinct a.placementno),a.placementno,""),",","") old_jo, a.placementno current_jo,p.name,
    case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
    workordid,
<!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dcomm,'1900-01-01')+2 dcomm,
<!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dresign,'1900-01-01')+2 dresign,
sum(
    coalesce(custsalary,0)
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= 11 then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
                                        
) as BasicRate,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 110 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 110 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as SalesIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 111 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 111 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as ExtraIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 112 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 112 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as BackPayIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 124 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 124 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as ProductIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 7 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 7 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as Commission,
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
) as TotalIncentive,
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
    + coalesce(case when a.fixawcode#a#= 9 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 9 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 118 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 118 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as TotalBonus,

sum(0
<cfloop index="aa" list="#reimburseitem#">
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= #aa# then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= #aa# then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
</cfloop>
) as TotalReimbursement,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 78 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 78 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as Shoe,
sum(coalesce(custothour2,0)) selfothour2,
sum(coalesce(custot2,0)) selfot2,
sum(coalesce(custothour3,0)) selfothour3,
sum(coalesce(custot3,0)) selfot3,
sum(coalesce(custothour4,0)) selfothour4,
sum(coalesce(custot4,0)) selfot4,
sum(0
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 12 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) otadjust,
(sum(coalesce(custothour2,0))+sum(coalesce(custothour3,0))+sum(coalesce(custothour4,0))) as selfothourtotal,
sum(coalesce(custottotal,0)) selfottotal,
concat(
    case when 
    sum(coalesce(a.lvleedayhr1,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr1,0)) as char(45))," day(s) in #thisperiod#") else "" end,<!---current month NPL--->
    case when sum(coalesce(a.lvleedayhr1,0))>0 then ", " else "" end,<!---comma--->
    case when sum(coalesce(a.lvleedayhr2,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr2,0)) as char(45))," day(s) in #lastperiod#") else "" end,<!---previous month NPL--->
    case when sum(coalesce(a.lvleedayhr1,0))>0 or sum(coalesce(a.lvleedayhr2,0))>0 then ", " else "" end,<!---comma--->
    a.lorealremarks
    ) 
as Remark
 
FROM assignmentslip a
LEFT JOIN #replace(dts,'_i','_p')#.pmast p
ON a.empno=p.empno
LEFT JOIN placement pl
ON a.placementno=pl.placementno
    
WHERE payrollperiod=#form.period#
AND (a.custname like "%l'oreal%"  or a.custname like "%loreal%")
AND pl.jobpostype in (#form.jobpostype#)
AND a.empno !='0'
AND a.empno != '100123480'<!---Advanced Billing account--->
<!---AND custtotalgross--->
AND (month(a.completedate) = #form.period# or month(a.completedate) != #form.period# and include='T')
    
GROUP BY a.empno
ORDER BY p.workordid,a.empno
</cfquery>
   
<cfelse>
    
<cfquery name="getvariabledata" datasource="#dts#">
SELECT a2.empno, a2.placementno current_jo,p.name,
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
bp.BackPayWage as BackPaySalary,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 110 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 110 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as SalesIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 111 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 111 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as ExtraIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 112 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 112 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
)+bp.BackPayIncen as BackPayIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 124 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 124 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as ProductIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 7 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 7 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as Commission,
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
) as TotalIncentive,
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
    + coalesce(case when a.fixawcode#a#= 9 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 9 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 118 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 118 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as TotalBonus,

sum(0
<cfloop index="aa" list="#reimburseitem#">
    <cfloop  index="a" from="1" to="6">
        + coalesce(case when a.fixawcode#a#= #aa# then coalesce(a.fixawer#a#,0) else 0 end,0)
    </cfloop>
    <cfloop  index="a" from="1" to="18">
        + coalesce(case when a.allowance#a#= #aa# then coalesce(a.awer#a#,0) else 0 end,0)
    </cfloop>
</cfloop>
)+bp.Reimbursement as TotalReimbursement,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when a.fixawcode#a#= 78 then coalesce(a.fixawer#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 78 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
) as Shoe,
sum(coalesce(a.custothour2,0)) selfothour2,
sum(coalesce(a.custot2,0)) selfot2,
sum(coalesce(a.custothour3,0)) selfothour3,
sum(coalesce(a.custot3,0)) selfot3,
sum(coalesce(a.custothour4,0)) selfothour4,
sum(coalesce(a.custot4,0)) selfot4,
sum(0
<cfloop  index="a" from="1" to="18">
    + coalesce(case when a.allowance#a#= 12 then coalesce(a.awer#a#,0) else 0 end,0)
</cfloop>
)+bp.otadjust otadjust,
(sum(coalesce(a.custothour2,0))+sum(coalesce(a.custothour3,0))+sum(coalesce(a.custothour4,0))) as selfothourtotal,
sum(coalesce(a.custottotal,0)) selfottotal,
concat(
    case when 
    sum(coalesce(a.lvleedayhr1,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr1,0)) as char(45))," day(s) in #thisperiod#") else "" end,<!---current month NPL--->
    case when sum(coalesce(a.lvleedayhr1,0))>0 then ", " else "" end,<!---comma--->
    case when sum(coalesce(a.lvleedayhr2,0))>0 then concat("UPL on ",CAST(sum(coalesce(a.lvleedayhr2,0)) as char(45))," day(s) in #lastperiod#") else "" end,<!---previous month NPL--->
    case when sum(coalesce(a.lvleedayhr1,0))>0 or sum(coalesce(a.lvleedayhr2,0))>0 then ", " else "" end,<!---comma--->
    a.lorealremarks
    ) 
as Remark
 
FROM 
(
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
    
LEFT JOIN #replace(dts,'_i','_p')#.pmast p
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
        <cfloop index="i" list="#reimburseitem#">
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
    
WHERE pl.jobpostype in (#form.jobpostype#)
AND a2.empno !='0'
AND a2.empno != '100123480'<!---Advanced Billing account--->
    
GROUP BY a2.empno
ORDER BY p.workordid,a2.empno
</cfquery>
    
</cfif>
    
<!---Add 1st sheets--->
<cfset overall = SpreadSheetNew(true)>
    
<cfset addcolumn = 1>
    
<cfset addotcolumn = 0>

<cfif form.period eq 1 or form.period eq 7>
    <cfset addcolumn = 2>
</cfif>
    
<cfif checkoldjoexist.recordcount neq 0>
    
    <cfset SpreadSheetAddRow(overall, ",,,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>    

    <cfset SpreadSheetAddRow(overall, ",,,Report ID: Variable Report,,,,,,,,,,#lastperiod#,#lastyear#")>
    
<cfelse>
    
    <cfset SpreadSheetAddRow(overall, ",,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>

    <cfset SpreadSheetAddRow(overall, ",,Report ID: Variable Report,,,,,,,,,,,#lastperiod#,#lastyear#")>    
    
</cfif>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfif checkoldjoexist.recordcount neq 0>
    <cfset headerline1 = ",,,,,,,,,,,,,,,,1.5,1.5,2.0,2.0,3.0,3.0,1.5+2.0+3.0,1.5+2.0+3.0,">
    <cfset headerline2 = "Employee ID,Old Job Order No,Current Job Order No,Employee Name,NRIC No,Section,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Sales Incentive (TIER 1 + TIER 2),Extra Incentive,Back Pay Incentive,Product incentive,Commission,Total Incentive,Total Disbursement,Normal (Hour),Total (RM),OFF/PH (Hour),Total (RM),O/T (Hours/Rate),Total (RM),Total Number of OT (Hour),Total Number of OT (RM),Remark">
<cfelse>
    <cfset headerline1 = ",,,,,,,,,,,,,,,1.5,1.5,2.0,2.0,3.0,3.0,1.5+2.0+3.0,1.5+2.0+3.0,">
    <cfset headerline2 = "Employee ID,Job Order No,Employee Name,NRIC No,Section,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Sales Incentive (TIER 1 + TIER 2),Extra Incentive,Back Pay Incentive,Product incentive,Commission,Total Incentive,Total Disbursement,Normal (Hour),Total (RM),OFF/PH (Hour),Total (RM),O/T (Hours/Rate),Total (RM),Total Number of OT (Hour),Total Number of OT (RM),Remark">
</cfif>
        
<cfquery name="checkColumnToShow" dbtype="query">
    SELECT 
    sum(Bonus) Bonus,
    sum(ExceptionalBonus) ExceptionalBonus,
    sum(ExcellenceAward) ExcellenceAward,
    sum(LongService) LongService
    FROM getvariabledata
</cfquery>
        
<!---OT Adjustment--->
    <cfset addnewcolumn = 0>
<cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
    <cfset addotcolumn += 1>
    <cfset headerline1 = replace(headerline1,'3.0,3.0,','3.0,3.0,,')>
    <cfset headerline2 = replacenocase(headerline2,',Total Number of OT (Hour)',',OT Adjustment,Total Number of OT (Hour)')>
        
    <cfset addnewcolumn += 1>
    <cfset addcolumn += 1>
    <cfset headerline1 = replace(headerline1,',,',',,,')>
    <cfset headerline2 = replacenocase(headerline2,'Basic Rate #getmmonth.myear#,','Basic Rate #getmmonth.myear#,Back pay salary,')>
</cfif>
<!---OT Adjustment--->
        
<cfif form.period eq 1 or form.period eq 7>
    <cfset headerline1 = replace(headerline1,',1.5',',,1.5')>
    <cfset headerline2 = replacenocase(headerline2,'Total Disbursement,','Total Disbursement,Shoe Allowance,')>
</cfif>
        
<cfif checkColumnToShow.bonus neq 0 or checkColumnToShow.ExceptionalBonus neq 0>
    <cfset addcolumn += 1>
    <cfset headerline1 = replace(headerline1,',,',',,,')>
    <cfset headerline2 = replacenocase(headerline2,'Total Incentive,','Total Incentive,Total Bonus,')>
</cfif>
        
<cfif checkColumnToShow.ExceptionalBonus neq 0>
    <cfset addcolumn += 1>
    <cfset headerline1 = replace(headerline1,',,',',,,')>
    <cfset headerline2 = replacenocase(headerline2,'Total Incentive,','Total Incentive,Exceptional Bonus,')>
</cfif>
        
<cfif checkColumnToShow.bonus neq 0>
    <cfset addcolumn += 1>
    <cfset headerline1 = replace(headerline1,',,',',,,')>
    <cfset headerline2 = replacenocase(headerline2,'Total Incentive,','Total Incentive,Bonus,')>
</cfif>
        
<cfif checkColumnToShow.LongService neq 0>
    <cfset addcolumn += 1>
    <cfset headerline1 = replace(headerline1,',,',',,,')>
    <cfset headerline2 = replacenocase(headerline2,'Total Incentive,','Total Incentive,Long Service Award,')>
</cfif>

<cfif checkColumnToShow.ExcellenceAward neq 0>
    <cfset addcolumn += 1>
    <cfset headerline1 = replace(headerline1,',,',',,,')>
    <cfset headerline2 = replacenocase(headerline2,'Total Incentive,','Total Incentive,Excellence Award,')>
</cfif>
        
<cfif form.period lte 11 and getmmonth.myear eq 2018>
    <cfset headerline2 = replacenocase(headerline2,'Total Disbursement,','Total Reimbursement,')>
</cfif>
        
<cfset SpreadSheetAddRow(overall, headerline1)>
    
<cfset SpreadSheetAddRow(overall, headerline2)>
    
<cfquery name="getvariabledataoutput" dbtype="query">
    SELECT empno, 
    <cfif checkoldjoexist.recordcount neq 0>
        old_jo,
    </cfif>
    current_jo,name,nricn,
    workordid, dcomm, dresign,
    BasicRate,
    <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
        BackPaySalary,
    </cfif>
    SalesIncentive,
    ExtraIncentive,
    BackPayIncentive,
    ProductIncentive,
    Commission,
    TotalIncentive,
    <cfif checkColumnToShow.Bonus neq 0>
        Bonus,
    </cfif>
    <cfif checkColumnToShow.ExceptionalBonus neq 0>
        ExceptionalBonus,
    </cfif>  
    <cfif checkColumnToShow.bonus neq 0 or checkColumnToShow.ExceptionalBonus neq 0>
    TotalBonus,
    </cfif>  
    <cfif checkColumnToShow.ExcellenceAward neq 0>
        ExcellenceAward,
    </cfif>
    <cfif checkColumnToShow.LongService neq 0>
        LongService,
    </cfif>
    TotalReimbursement,
    <cfif form.period eq 1 or form.period eq 7>
    Shoe,
    </cfif>
    selfothour2,
    selfot2,
    selfothour3,
    selfot3,
    selfothour4,
    selfot4,
    <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
        otadjust,
    </cfif>
    selfothourtotal,
    selfottotal,
    Remark
    FROM getvariabledata
</cfquery>
    
<cfset SpreadSheetAddRows(overall, getvariabledataoutput)>
      
<cfif checkoldjoexist.recordcount neq 0>
    <cfset totalline1 = ",,,,,,,,">
<cfelse>
    <cfset totalline1 = ",,,,,,,">
</cfif>
    
<cfset totalline2 = "">
        
<cfset SpreadSheetAddRow(overall, totalline1&totalline2)>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfif checkoldjoexist.recordcount neq 0>
    
    <cfset SpreadSheetAddRow(overall, ",,,Total Employee Count")>

<cfelse>

    <cfset SpreadSheetAddRow(overall, ",,Total Employee Count")>    

</cfif>
    
<cfif checkoldjoexist.recordcount neq 0>
    <!---spreadsheetSetCellFormula(spreadsheetObj, formula, row, column)--->
    <cfloop query="getvariabledata">
        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(10+addnewcolumn)##5+getvariabledata.currentrow#:#numbertoletter(14+addnewcolumn)##5+getvariabledata.currentrow#)", 5+getvariabledata.currentrow, 15+addnewcolumn)>
        <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(16+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(18+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(20+addcolumn)##5+getvariabledata.currentrow#", 5+getvariabledata.currentrow, 22+addcolumn+addotcolumn)>
        <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(17+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(19+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(21+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(22+addcolumn)##5+getvariabledata.currentrow#", 5+getvariabledata.currentrow, 23+addcolumn+addotcolumn)>
        <cfelse>
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(17+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(19+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(21+addcolumn)##5+getvariabledata.currentrow#", 5+getvariabledata.currentrow, 23+addcolumn+addotcolumn)>
        </cfif>
    </cfloop>
            
    <cfloop index="aa" from="9" to="#23+addcolumn+addotcolumn#">
        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(aa)##6#:#numbertoletter(aa)##5+getvariabledata.recordcount#)", 5+getvariabledata.recordcount+1, aa)>  
    </cfloop>
        
    <cfset spreadsheetSetCellFormula(overall, "COUNTA(A6:A#5+getvariabledata.recordcount#)", 5+getvariabledata.recordcount+3, 5)>
<cfelse>
    <!---spreadsheetSetCellFormula(spreadsheetObj, formula, row, column)--->
    <cfloop query="getvariabledata">
        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(9+addnewcolumn)##5+getvariabledata.currentrow#:#numbertoletter(13+addnewcolumn)##5+getvariabledata.currentrow#)", 5+getvariabledata.currentrow, 14+addnewcolumn)>
        <!---<cfif form.period eq 12>
            <cfset spreadsheetSetCellFormula(overall, "SUM(O#5+getvariabledata.currentrow#:P#5+getvariabledata.currentrow#)", 5+getvariabledata.currentrow, 17)>
        </cfif>--->
        <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(15+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(17+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(19+addcolumn)##5+getvariabledata.currentrow#", 5+getvariabledata.currentrow, 21+addcolumn+addotcolumn)>
        <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(16+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(18+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(20+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(21+addcolumn)##5+getvariabledata.currentrow#", 5+getvariabledata.currentrow, 22+addcolumn+addotcolumn)>
        <cfelse>
            <cfset spreadsheetSetCellFormula(overall, "#numbertoletter(16+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(18+addcolumn)##5+getvariabledata.currentrow#+#numbertoletter(20+addcolumn)##5+getvariabledata.currentrow#", 5+getvariabledata.currentrow, 22+addcolumn+addotcolumn)>
        </cfif>
    </cfloop>
            
    <cfloop index="aa" from="8" to="#22+addcolumn+addotcolumn#">
        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(aa)##6#:#numbertoletter(aa)##5+getvariabledata.recordcount#)", 5+getvariabledata.recordcount+1, aa)>  
    </cfloop>
        
    <cfset spreadsheetSetCellFormula(overall, "COUNTA(A6:A#5+getvariabledata.recordcount#)", 5+getvariabledata.recordcount+3, 4)>
</cfif>
   
<!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->    
    
<cfif checkoldjoexist.recordcount neq 0>    
    
    <cfset SpreadSheetFormatCellRange(overall, s67, 6, 9, getvariabledata.recordcount+6, 23+addcolumn+addotcolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s28, 6, 1, getvariabledata.recordcount+6, 24+addcolumn+addotcolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s31, 5, 1, 5, 24+addcolumn+addotcolumn)><!---header--->
    <cfset SpreadSheetFormatCellRange(overall, s23, 4, 1, 4, 24+addcolumn+addotcolumn)><!---header--->
    <cfset SpreadSheetFormatCellRange(overall, s29, 5, 16+addcolumn, 5, 23+addcolumn+addotcolumn)><!---header--->
    <cfset SpreadSheetFormatCellRange(overall, s24, 1, 1, 2, 15+addcolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s30, getvariabledata.recordcount+6, 1, getvariabledata.recordcount+6, 24+addcolumn+addotcolumn)>
        
    <cfloop index="i" from="1" to="#24+addcolumn+addotcolumn#">
          <cfset spreadsheetSetColumnWidth(overall, i, columnnumbers) >
    </cfloop>
    <cfset spreadsheetSetColumnWidth(overall, 4, columnname) >
    <cfset spreadsheetSetColumnWidth(overall, 6, columnsection) >

<cfelse>
    
    <cfset SpreadSheetFormatCellRange(overall, s67, 6, 8, getvariabledata.recordcount+6, 22+addcolumn+addotcolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s28, 6, 1, getvariabledata.recordcount+6, 23+addcolumn+addotcolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s31, 5, 1, 5, 23+addcolumn+addotcolumn)><!---header--->
    <cfset SpreadSheetFormatCellRange(overall, s23, 4, 1, 4, 23+addcolumn+addotcolumn)><!---header--->
    <cfset SpreadSheetFormatCellRange(overall, s29, 5, 15+addcolumn, 5, 22+addcolumn+addotcolumn)><!---header--->
    <cfset SpreadSheetFormatCellRange(overall, s24, 1, 1, 2, 15+addcolumn)>
    <cfset SpreadSheetFormatCellRange(overall, s30, getvariabledata.recordcount+6, 1, getvariabledata.recordcount+6, 23+addcolumn+addotcolumn)>
        
    <cfloop index="i" from="1" to="#23+addcolumn+addotcolumn#">
          <cfset spreadsheetSetColumnWidth(overall, i, columnnumbers) >
    </cfloop>
    <cfset spreadsheetSetColumnWidth(overall, 3, columnname) >
    <cfset spreadsheetSetColumnWidth(overall, 5, columnsection) >
        
</cfif>

<!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
<cfset spreadsheetSetRowHeight(overall, 4, 19)>
<cfset spreadsheetSetRowHeight(overall, 5, 58)>
<cfset SpreadSheetFormatCellRange(overall, s26, 1, 14, 2, 14)>
<cfset SpreadSheetFormatCellRange(overall, s27, 1, 15, 2, 15)>
    
<cfset SpreadSheetFormatCellRange(overall, s68, 6, 6, getvariabledata.recordcount+6, 7)> 
    
<!---anchor: startRow,startColumn,endRow,endColumn--->
<cfset SpreadsheetAddImage(overall,"#hrootpath#/latest/reports/Variablereport/signature.PNG","#getvariabledata.recordcount+8#,14,#getvariabledata.recordcount+16#,21")>
    
<cfset VariableReportInfo=StructNew()>
<cfset VariableReportInfo.title="#timenow#">
<cfset VariableReportInfo.COMMENTS="#timenow#">
<cfset VariableReportInfo.subject="#timenow#">
<cfset SpreadSheetAddInfo(overall,VariableReportInfo)>
    
<cfspreadsheet action="write" sheetname="Variable report - MP4U" filename="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx" name="overall" overwrite="true">
    
    
<!---Add 1st sheets--->
    
<!---Add 2nd sheets--->
    
<cfquery name="checkregion" dbtype="query"> 
    SELECT workordid 
    FROM getvariabledata
    WHERE workordid != ''
    GROUP BY workordid     
</cfquery>
    
<cfif checkregion.recordcount gt 1>
    
<cfloop query="checkregion">

<cfquery name="getvariabledata1" dbtype="query">
SELECT * 
FROM getvariabledata
WHERE workordid='#checkregion.workordid#'
</cfquery>

<cfif getvariabledata1.recordcount neq 0>

    <cfset tempvar = SpreadSheetNew(true)>

    <cfif checkoldjoexist.recordcount neq 0>
    
        <cfset SpreadSheetAddRow(tempvar, ",,,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>

        <cfset SpreadSheetAddRow(tempvar, ",,,Report ID: Variable Report,,,,,,,,,,#lastperiod#,#lastyear#")>

    <cfelse>

        <cfset SpreadSheetAddRow(tempvar, ",,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,#thisperiod#,#getmmonth.myear#")>

        <cfset SpreadSheetAddRow(tempvar, ",,Report ID: Variable Report,,,,,,,,,,,#lastperiod#,#lastyear#")>    

    </cfif>

    <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>

    <cfset SpreadSheetAddRow(tempvar, headerline1)>

    <cfset SpreadSheetAddRow(tempvar, headerline2)>
        
    <cfquery name="getvariabledata1output" dbtype="query">
        SELECT empno, 
        <cfif checkoldjoexist.recordcount neq 0>
            old_jo,
        </cfif>
        current_jo,name,nricn,
        workordid, dcomm, dresign,
        BasicRate,
        <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
            BackPaySalary,
        </cfif>
        SalesIncentive,
        ExtraIncentive,
        BackPayIncentive,
        ProductIncentive,
        Commission,
        TotalIncentive,
        <cfif checkColumnToShow.Bonus neq 0>
            Bonus,
        </cfif>
        <cfif checkColumnToShow.ExceptionalBonus neq 0>
            ExceptionalBonus,
        </cfif>  
        <cfif checkColumnToShow.bonus neq 0 or checkColumnToShow.ExceptionalBonus neq 0>
        TotalBonus,
        </cfif>  
        <cfif checkColumnToShow.ExcellenceAward neq 0>
            ExcellenceAward,
        </cfif>
        <cfif checkColumnToShow.LongService neq 0>
            LongService,
        </cfif>
        TotalReimbursement,
        <cfif form.period eq 1 or form.period eq 7>
        Shoe,
        </cfif>
        selfothour2,
        selfot2,
        selfothour3,
        selfot3,
        selfothour4,
        selfot4,
        <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
            otadjust,
        </cfif>
        selfothourtotal,
        selfottotal,
        Remark
        FROM getvariabledata
        WHERE workordid='#checkregion.workordid#'
    </cfquery>

    <cfset SpreadSheetAddRows(tempvar, getvariabledata1output)>
        
    <cfif checkoldjoexist.recordcount neq 0>
        <cfset totalline1 = ",,,,,,,,">
    <cfelse>
        <cfset totalline1 = ",,,,,,,">
    </cfif>

    <cfset totalline2 = "">
        
    <cfset SpreadSheetAddRow(tempvar, totalline1&totalline2)>

    <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>
        
    <cfif checkoldjoexist.recordcount neq 0>
    
        <cfset SpreadSheetAddRow(tempvar, ",,,Total Employee Count")>

    <cfelse>

        <cfset SpreadSheetAddRow(tempvar, ",,Total Employee Count")>    

    </cfif>
        
    <cfif checkoldjoexist.recordcount neq 0>
        <!---spreadsheetSetCellFormula(spreadsheetObj, formula, row, column)--->
        <cfloop query="getvariabledata1">
            <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(10+addnewcolumn)##5+getvariabledata1.currentrow#:#numbertoletter(14+addnewcolumn)##5+getvariabledata1.currentrow#)", 5+getvariabledata1.currentrow, 15+addnewcolumn)>
            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(16+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(18+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(20+addcolumn)##5+getvariabledata1.currentrow#", 5+getvariabledata1.currentrow, 22+addcolumn+addotcolumn)>
            <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(17+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(19+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(21+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(22+addcolumn)##5+getvariabledata1.currentrow#", 5+getvariabledata1.currentrow, 23+addcolumn+addotcolumn)>
            <cfelse>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(17+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(19+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(21+addcolumn)##5+getvariabledata1.currentrow#", 5+getvariabledata1.currentrow, 23+addcolumn+addotcolumn)>
            </cfif>
        </cfloop>
                
        <cfloop index="aa" from="9" to="#23+addcolumn+addotcolumn#">
            <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)##6#:#numbertoletter(aa)##5+getvariabledata1.recordcount#)", 5+getvariabledata1.recordcount+1, aa)>  
        </cfloop>
            
        <cfset spreadsheetSetCellFormula(tempvar, "COUNTA(A6:A#5+getvariabledata1.recordcount#)", 5+getvariabledata1.recordcount+3, 5)>  
    <cfelse>
        <!---spreadsheetSetCellFormula(spreadsheetObj, formula, row, column)--->
        <cfloop query="getvariabledata1">
            <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(9+addnewcolumn)##5+getvariabledata1.currentrow#:#numbertoletter(13+addnewcolumn)##5+getvariabledata1.currentrow#)", 5+getvariabledata1.currentrow, 14+addnewcolumn)>
            <!---<cfif form.period eq 12>
                <cfset spreadsheetSetCellFormula(tempvar, "SUM(O#5+getvariabledata1.currentrow#:P#5+getvariabledata1.currentrow#)", 5+getvariabledata1.currentrow, 17)>
            </cfif>--->
            <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(15+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(17+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(19+addcolumn)##5+getvariabledata1.currentrow#", 5+getvariabledata1.currentrow, 21+addcolumn+addotcolumn)>
            <cfif (form.period gte 2 and getmmonth.myear eq 2019) or getmmonth.myear gt 2019>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(16+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(18+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(20+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(21+addcolumn)##5+getvariabledata1.currentrow#", 5+getvariabledata1.currentrow, 22+addcolumn+addotcolumn)>
            <cfelse>
                <cfset spreadsheetSetCellFormula(tempvar, "#numbertoletter(16+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(18+addcolumn)##5+getvariabledata1.currentrow#+#numbertoletter(20+addcolumn)##5+getvariabledata1.currentrow#", 5+getvariabledata1.currentrow, 22+addcolumn+addotcolumn)>
            </cfif>
        </cfloop>
                
        <cfloop index="aa" from="8" to="#22+addcolumn+addotcolumn#">
            <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)##6#:#numbertoletter(aa)##5+getvariabledata1.recordcount#)", 5+getvariabledata1.recordcount+1, aa)>  
        </cfloop>
            
        <cfset spreadsheetSetCellFormula(tempvar, "COUNTA(A6:A#5+getvariabledata1.recordcount#)", 5+getvariabledata1.recordcount+3, 4)>
    </cfif>
        
    <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->    

    <cfif checkoldjoexist.recordcount neq 0>    
        
        <cfset SpreadSheetFormatCellRange(tempvar, s67, 6, 9, getvariabledata1.recordcount+6, 23+addcolumn+addotcolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s28, 6, 1, getvariabledata1.recordcount+6, 24+addcolumn+addotcolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s31, 5, 1, 5, 24+addcolumn+addotcolumn)><!---header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s23, 4, 1, 4, 24+addcolumn+addotcolumn)><!---header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s29, 5, 16+addcolumn, 5, 23+addcolumn+addotcolumn)><!---header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s24, 1, 1, 2, 15+addcolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s30, getvariabledata1.recordcount+6, 1, getvariabledata1.recordcount+6, 24+addcolumn+addotcolumn)>
            
        <cfloop index="i" from="1" to="#24+addcolumn+addotcolumn#">
              <cfset spreadsheetSetColumnWidth(tempvar, i, columnnumbers) >
        </cfloop>
        <cfset spreadsheetSetColumnWidth(tempvar, 4, columnname) >
        <cfset spreadsheetSetColumnWidth(tempvar, 6, columnsection) >
    <cfelse>

        <cfset SpreadSheetFormatCellRange(tempvar, s67, 6, 8, getvariabledata1.recordcount+6, 22+addcolumn+addotcolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s28, 6, 1, getvariabledata1.recordcount+6, 23+addcolumn+addotcolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s31, 5, 1, 5, 23+addcolumn+addotcolumn)><!---header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s23, 4, 1, 4, 23+addcolumn+addotcolumn)><!---header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s29, 5, 15+addcolumn, 5, 22+addcolumn+addotcolumn)><!---header--->
        <cfset SpreadSheetFormatCellRange(tempvar, s24, 1, 1, 2, 15+addcolumn)>
        <cfset SpreadSheetFormatCellRange(tempvar, s30, getvariabledata1.recordcount+6, 1, getvariabledata1.recordcount+6, 23+addcolumn+addotcolumn)>
            
        <cfloop index="i" from="1" to="#23+addcolumn+addotcolumn#">
              <cfset spreadsheetSetColumnWidth(tempvar, i, columnnumbers) >
        </cfloop>
        <cfset spreadsheetSetColumnWidth(tempvar, 3, columnname) >
        <cfset spreadsheetSetColumnWidth(tempvar, 5, columnsection) >

    </cfif>

    <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
    <cfset spreadsheetSetRowHeight(tempvar, 4, 19)>
    <cfset spreadsheetSetRowHeight(tempvar, 5, 58)>
    <cfset SpreadSheetFormatCellRange(tempvar, s26, 1, 14, 2, 14)>
    <cfset SpreadSheetFormatCellRange(tempvar, s27, 1, 15, 2, 15)>
        
    <cfset SpreadSheetFormatCellRange(tempvar, s68, 6, 6, getvariabledata1.recordcount+6, 7)> 
        
    <!---anchor: startRow,startColumn,endRow,endColumn--->
    <cfset SpreadsheetAddImage(tempvar,"#hrootpath#/latest/reports/Variablereport/signature.PNG","#getvariabledata1.recordcount+7#,14,#getvariabledata1.recordcount+16#,21")>

    <cfspreadsheet action="update" sheetname="#checkregion.workordid#" filename="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx" name="tempvar">
        

</cfif>
    
</cfloop>
    
</cfif>   
<!---Add 2nd sheets--->
        
<cfset filename = "VARIABLE REPORT Perm BA #thisperiod# #getmmonth.myear#_#timenow#">
        
<!---End Perm--->
        
<cfelse>
<!---Temp--->   
    
<cfquery name="getvariabledata" datasource="#dts#">
SELECT *,coalesce(backa.backpay,0) as BackPaySalary, (coalesce(xGrossWage,0) + coalesce(backa.backpay,0)) as GrossWage 
FROM (
    SELECT 
    case when count(aa.placementno) >1 then group_concat(aa.placementno) else aa.placementno end current_jo,
    aa.empno,
    p3.name,
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
    ppl.supervisor,workordid<!---Section/Region--->,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dcomm,'1900-01-01')+2 dcomm,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dresign,'1900-01-01')+2 dresign,
    a3.lorealremarks daysworked,
    sum(case when not (coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200 ) then coalesce(a3.custsalary,0) else 0 end) as BasicRate,

    sum(case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200  then coalesce(a3.custsalaryday,0) else 0 end) totalnormalday,<!---Total Normal Working Days--->
    (case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200  then coalesce(a3.custusualpay,0) else 0 end) normalrate,<!---Working on Normal day --->
    sum(
        case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 then coalesce(a3.custsalary,0) else 0 end + case when not (coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = 165 or coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 or coalesce(a3.custusualpay,0) = 1000)  then coalesce(a3.custsalary,0) else 0 end
    ) totalnormal,<!---Total Normal --->

    sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalaryday,0) else 0 end) total_concourse_day,<!---Total Concourse Days--->
    (case when sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalaryday,0) else 0 end) != 0 then 165 else 0 end) working_concourse,<!---Working on Concourse day --->
    sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalary,0) else 0 end) total_concourse,<!---Total Concourse --->    

    sum(case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custsalaryday,0) else 0 end) total_day_ph,
    (case when sum(case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custsalaryday,0) else 0 end) != 0 then 160 else 0 end) working_ph,
    sum(case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custsalary,0) else 0 end) total_ph,
    sum(coalesce(a3.custsalary,0)+coalesce(a4.custsalary,0))+0<!---PH---> as BasicWage,
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
    sum(coalesce(a3.custothour2,0)+coalesce(a4.custothour2,0)) selfothour2,
    sum(coalesce(a3.custot2,0)+coalesce(a4.custot2,0)) selfot2,
    sum(coalesce(a3.custothour3,0)+coalesce(a4.custothour3,0)) selfothour3,
    sum(coalesce(a3.custot3,0)+coalesce(a4.custot3,0)) selfot3,
    sum(coalesce(a3.custothour4,0)+coalesce(a4.custothour4,0)) selfothour4,
    sum(coalesce(a3.custot4,0)+coalesce(a4.custot4,0)) selfot4,(sum(coalesce(a3.custothour2,0))+sum(coalesce(a3.custothour3,0))+sum(coalesce(a3.custothour4,0))+sum(coalesce(a4.custothour2,0))+sum(coalesce(a4.custothour3,0))+sum(coalesce(a4.custothour4,0))) as selfothourtotal,
    sum(coalesce(a3.custottotal,0)+coalesce(a4.custottotal,0)) selfottotal,
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
    ) taxableamt

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
    <!---AND aa.custtotalgross--->
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
    <!---AND custtotalgross--->
    AND month(completedate) <> #form.period# AND jtitle="Maternity Replacement"
    GROUP BY aa.empno
) backa
ON a.empno=backa.empno
    
GROUP BY a.empno
ORDER BY workordid,a.empno
</cfquery>
    
<!---Add 1st sheets--->
<cfset overall = SpreadSheetNew(true)>
    
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

<!---Prepare header 1--->
<cfset header1 = "">
    
<cfset speaces1 = 31>
    
<cfif getmmonth.myear gte 2019>
    <cfif form.period gte 3>
        <cfset speaces1 = speaces1 -3>
    </cfif>
</cfif>

<cfloop index="i" from="1" to="#speaces1#">
    <cfset header1 = header1&",">   
</cfloop>
    
<cfset header1 = header1&"O/T (HOURS/RATE)">
<!---Prepare header 1--->
    
<cfset SpreadSheetAddRow(overall, header1)>
    
<cfset header2 = "Job Order No,Employee ID,Employee Name,NRIC No,Position,Store Name,Requested by,Region,Start Date,End Date,Days Worked,Basic Wage,Total Normal Working Days,Working on Normal day, Total Normal(RM),Total Concourse Day,Working on Concourse,Total RM (Concourse),Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH),Back Pay Salary,Disbursement (Stationery),Total Sales Figure,Incentive,Total Gross Wage,Normal (Hour),Normal (RM),OFF/PH (Hour),OFF/PH (RM),PH Excess (Hour),PH Excess (RM),Total OT (Hour),Total OT (RM)">
    
<cfif getmmonth.myear gte 2019>
    <cfif form.period gte 3>
        <cfset header2 = replace(header2,',Total Working Day (PH),Working on PH,Total RM (PH),Basic Wage (Normal+PH)',',Basic Wage (Normal+Concourse)')>
    </cfif>
</cfif>
    
<cfset SpreadSheetAddRow(overall, header2)>
    
<!---Prepare header 3--->
<cfset header3 = "">

<cfset speaces2 = 27>
    
<cfif getmmonth.myear gte 2019>
    <cfif form.period gte 3>
        <cfset speaces2 = speaces2 -3>
    </cfif>
</cfif>

<cfloop index="i" from="1" to="#speaces2#">
    <cfset header3 = header3&",">   
</cfloop>
    
<cfset header3 = header3&"1.5,1.5,2.0,2.0,3.0,3.0,1.5+2.0+3.0,1.5+2.0+3.0">
<!---Prepare header 3--->
    
<cfset SpreadSheetAddRow(overall, header3)>
    
<cfquery name="getvariabledataoutput" dbtype="query">
    SELECT current_jo, empno, name, nricn, jtitle, worklocation, supervisor, workordid, dcomm, dresign, daysworked, BasicRate, totalnormalday, normalrate, totalnormal, total_concourse_day, working_concourse, total_concourse, 
    <cfif getmmonth.myear lte 2019>
        <cfif form.period lt 3>
        total_day_ph, working_ph, total_ph,
        </cfif>
    </cfif>
    
    BasicWage,BackPaySalary, TotalReimbursement, TotalSalesFigure, Incentive, GrossWage, selfothour2, selfot2, selfothour3, selfot3, selfothour4, selfot4, selfothourtotal, selfottotal
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
<cfset treimburse = 0>
<cfset tincentive = 0>
<cfset tgross = 0>
<cfset ot15hour = 0>
<cfset ot15total = 0>
<cfset ot20hour = 0>
<cfset ot20total = 0>
<cfset ot30hour = 0>
<cfset ot30total = 0>
<cfset othour = 0>
<cfset ottotal = 0>
    
<!---<cfloop query="getvariabledata">
    <cfset tnormalday = val(tnormalday) + val(getvariabledata.totalnormalday)>    
    <cfset tnormal = val(tnormal) + val(getvariabledata.totalnormal)>
    <cfset tconcourseday = val(tconcourseday) + val(getvariabledata.total_concourse_day)>
    <cfset tworkconcourse = val(tworkconcourse) + val(getvariabledata.working_concourse)>
    <cfset tconcourse = val(tconcourse) + val(getvariabledata.total_concourse)>
    <cfset tphday = val(tphday) + val(getvariabledata.total_day_ph)>
    <cfset tph = val(tph) + val(getvariabledata.total_ph)>
    <cfset tbasicwage = val(tbasicwage) + val(getvariabledata.basicwage)>
    <cfset tbackpay = val(tbackpay) + val(getvariabledata.BackPaySalary)>
    <cfset treimburse = val(treimburse) + val(getvariabledata.TotalReimbursement)>
    <cfset tincentive = val(tincentive) + val(getvariabledata.Incentive)>
    <cfset tgross = val(tgross) + val(getvariabledata.GrossWage)>
    <cfset ot15hour = val(ot15hour) + val(getvariabledata.selfothour2)>
    <cfset ot15total = val(ot15total) + val(getvariabledata.selfot2)>
    <cfset ot20hour = val(ot20hour) + val(getvariabledata.selfothour3)>
    <cfset ot20total = val(ot20total) + val(getvariabledata.selfot3)>
    <cfset ot30hour = val(ot30hour) + val(getvariabledata.selfothour4)>
    <cfset ot30total = val(ot30total) + val(getvariabledata.selfot4)>
    <cfset othour = val(othour) + val(getvariabledata.selfothourtotal)>
    <cfset ottotal = val(ottotal) + val(getvariabledata.selfottotal)>
</cfloop>
    
    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
        
<cfset totalline = "">
        
<cfloop index="a" from="1" to="12">
    <cfset totalline = totalline&",">
</cfloop>
        
<cfset SpreadSheetAddRow(overall, "#totalline##tnormalday#,,#tnormal#,#tconcourseday#,,#tconcourse#,#tphday#,,#tph#,#tbasicwage#,#tbackpay#,#treimburse#,,#tincentive#,#tgross#,#ot15hour#,#ot15total#,#ot20hour#,#ot20total#,#ot30hour#,#ot30total#,#othour#,#ottotal#")>--->
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

<cfset SpreadSheetAddRow(overall, ",Total:")>   
    
<cfloop query="getvariabledata">
    <cfset spreadsheetSetCellFormula(overall, "M#10+getvariabledata.currentrow#*N#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,15)>
        
    <cfset spreadsheetSetCellFormula(overall, "P#10+getvariabledata.currentrow#*Q#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,18)>

    <cfif (form.period lt 3 and getmmonth.myear eq 2019) or getmmonth.myear lt 2019>
        <cfset spreadsheetSetCellFormula(overall, "S#10+getvariabledata.currentrow#*T#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,21)>
            
        <cfset spreadsheetSetCellFormula(overall, "L#10+getvariabledata.currentrow#+O#10+getvariabledata.currentrow#+U#10+getvariabledata.currentrow#+R#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,22)>

        <cfset spreadsheetSetCellFormula(overall, "V#10+getvariabledata.currentrow#+W#10+getvariabledata.currentrow#+X#10+getvariabledata.currentrow#+Z#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,27)>

        <cfset spreadsheetSetCellFormula(overall, "AB#10+getvariabledata.currentrow#+AD#10+getvariabledata.currentrow#+AF#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,34)>

        <cfset spreadsheetSetCellFormula(overall, "AC#10+getvariabledata.currentrow#+AE#10+getvariabledata.currentrow#+AG#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,35)>
    <cfelse>
        <cfset spreadsheetSetCellFormula(overall, "L#10+getvariabledata.currentrow#+O#10+getvariabledata.currentrow#+R#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,19)>

        <cfset spreadsheetSetCellFormula(overall, "S#10+getvariabledata.currentrow#+T#10+getvariabledata.currentrow#+U#10+getvariabledata.currentrow#+W#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,24)>

        <cfset spreadsheetSetCellFormula(overall, "Y#10+getvariabledata.currentrow#+AA#10+getvariabledata.currentrow#+AC#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,31)>

        <cfset spreadsheetSetCellFormula(overall, "Z#10+getvariabledata.currentrow#+AB#10+getvariabledata.currentrow#+AD#10+getvariabledata.currentrow#", 10+getvariabledata.currentrow,32)>
    </cfif>
        
</cfloop>
            
<cfset lastcolumn = 35>
    
<cfif getmmonth.myear gte 2019>
    <cfif form.period gte 3>
        <cfset lastcolumn = lastcolumn -3>
    </cfif>
</cfif>
        
<cfloop index="aa" from="12" to="#lastcolumn#">
    <cfif (form.period lt 3 and getmmonth.myear eq 2019) or getmmonth.myear lt 2019>
        <cfif aa neq 14 and aa neq 17 and aa neq 20>
            <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata.recordcount#)", 10+getvariabledata.recordcount+3,aa)>
        </cfif>
    <cfelse>
        <cfif aa neq 14 and aa neq 17>
            <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata.recordcount#)", 10+getvariabledata.recordcount+3,aa)>
        </cfif>
    </cfif>
</cfloop>
        
<cfset spreadsheetSetCellFormula(overall, "COUNTA(A11:A#10+getvariabledata.recordcount#)", 10+getvariabledata.recordcount+3, 3)>    

    
<!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->    
    
<cfset SpreadSheetFormatCellRange(overall, s67, 11, 12, getvariabledata.recordcount+11, lastcolumn)>
<cfset SpreadSheetFormatCellRange(overall, s67, getvariabledata.recordcount+13, 12, getvariabledata.recordcount+13, lastcolumn)>

<cfset SpreadSheetFormatCellRange(overall, s28, 11, 1, getvariabledata.recordcount+10, lastcolumn)>
    
<cfset SpreadSheetFormatCellRange(overall, sTextwrap, 11, 6, getvariabledata.recordcount+10, 6)>
    
<cfset SpreadSheetFormatCellRange(overall, s68, 6, 9, getvariabledata.recordcount+10, 10)> 

<!---Header--->
<cfset SpreadSheetFormatCellRange(overall, s23, 8, 1, 8, 27)>
<cfset SpreadSheetFormatCellRange(overall, s31, 9, 1, 10, lastcolumn)>
    
<cfset startotcolumn = 28>    

<cfif getmmonth.myear gte 2019>
    <cfif form.period gte 3>
        <cfset startotcolumn = startotcolumn -3>
    </cfif>
</cfif>
    
<cfset SpreadSheetFormatCellRange(overall, s34, 8, startotcolumn, 9, lastcolumn)><!---OT section of header--->
<cfset SpreadSheetFormatCellRange(overall, s33, 8, lastcolumn, 8, lastcolumn)><!---OT section of header--->
<cfset SpreadSheetFormatCellRange(overall, s35, 10, startotcolumn, 10, lastcolumn)>
<!---Header--->

<cfloop index="i" from="1" to="#lastcolumn#">
    <cfset spreadsheetSetColumnWidth(overall, i, columnnumbers) >
</cfloop>

<cfset spreadsheetSetColumnWidth(overall, 3, columnname) >
    
<cfset otwordcolumn = 32>
    
<cfif getmmonth.myear gte 2019>
    <cfif form.period gte 3>
        <cfset otwordcolumn = otwordcolumn -3>
    </cfif>
</cfif>

<cfset spreadsheetSetColumnWidth(overall, otwordcolumn, 20) >

<cfset spreadsheetSetColumnWidth(overall, 6, 16) ><!---Store Name Width--->

<cfset spreadsheetSetColumnWidth(overall, 8, 16) ><!---Region Width--->
        
<cfset SpreadSheetFormatCellRange(overall, s32, 1, 25, 2, 26)>

<!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->  
<cfset spreadsheetSetRowHeight(overall, 9, 41)>
    
<!---anchor: startRow,startColumn,endRow,endColumn--->
<cfset SpreadsheetAddImage(overall,"#hrootpath#/latest/reports/Variablereport/signature.PNG","#getvariabledata.recordcount+16#,25,#getvariabledata.recordcount+24#,33")>
    
<cfspreadsheet action="write" sheetname="Variable report" filename="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx" name="overall" overwrite="true">
    
    
<!---Add 1st sheets--->
    
<!---Add 2nd sheets--->
   
<cfquery name="checkregion" dbtype="query">
    SELECT workordid 
    FROM getvariabledata
    WHERE workordid != ''
    GROUP BY workordid     
</cfquery>
    
<cfif checkregion.recordcount gt 1>
    
<cfloop query="checkregion">

<cfquery name="getvariabledata1" dbtype="query">
SELECT current_jo, empno, name, nricn, jtitle, worklocation, supervisor, workordid, dcomm, dresign, daysworked, BasicRate, totalnormalday, normalrate, totalnormal, total_concourse_day, working_concourse, total_concourse, 
    <cfif getmmonth.myear lte 2019>
        <cfif form.period lt 3>
        total_day_ph, working_ph, total_ph,
        </cfif>
    </cfif> 
    BasicWage,BackPaySalary, TotalReimbursement, TotalSalesFigure, Incentive, GrossWage, selfothour2, selfot2, selfothour3, selfot3, selfothour4, selfot4, selfothourtotal, selfottotal
FROM getvariabledata
WHERE workordid='#checkregion.workordid#'
</cfquery>

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

    <!---Prepare header 1--->
    <cfset header1 = "">

    <cfloop index="i" from="1" to="#speaces1#">
        <cfset header1 = header1&",">   
    </cfloop>

    <cfset header1 = header1&"O/T (HOURS/RATE)">
    <!---Prepare header 1--->

    <cfset SpreadSheetAddRow(tempvar, header1)>

    <cfset SpreadSheetAddRow(tempvar, header2)>

    <!---Prepare header 3--->
    <cfset header3 = "">

    <cfloop index="i" from="1" to="#speaces2#">
        <cfset header3 = header3&",">   
    </cfloop>

    <cfset header3 = header3&"1.5,1.5,2.0,2.0,3.0,3.0,1.5+2.0+3.0,1.5+2.0+3.0">
    <!---Prepare header 3--->

    <cfset SpreadSheetAddRow(tempvar, header3)>

    <cfset SpreadSheetAddRows(tempvar, getvariabledata1)>

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
    <cfset ot15hour = 0>
    <cfset ot15total = 0>
    <cfset ot20hour = 0>
    <cfset ot20total = 0>
    <cfset ot30hour = 0>
    <cfset ot30total = 0>
    <cfset othour = 0>
    <cfset ottotal = 0>

    <!---<cfloop query="getvariabledata1">
        <cfset tnormalday = val(tnormalday) + val(getvariabledata1.totalnormalday)>    
        <cfset tnormal = val(tnormal) + val(getvariabledata1.totalnormal)>
        <cfset tconcourseday = val(tconcourseday) + val(getvariabledata1.total_concourse_day)>
        <cfset tworkconcourse = val(tworkconcourse) + val(getvariabledata1.working_concourse)>
        <cfset tconcourse = val(tconcourse) + val(getvariabledata1.total_concourse)>
        <cfset tphday = val(tphday) + val(getvariabledata1.total_day_ph)>
        <cfset tph = val(tph) + val(getvariabledata1.total_ph)>
        <cfset tbasicwage = val(tbasicwage) + val(getvariabledata1.basicwage)>
        <cfset tbackpay = val(tbackpay) + val(getvariabledata.BackPaySalary)>
        <cfset treimburse = val(treimburse) + val(getvariabledata1.TotalReimbursement)>
        <cfset tincentive = val(tincentive) + val(getvariabledata1.Incentive)>
        <cfset tgross = val(tgross) + val(getvariabledata1.GrossWage)>
        <cfset ot15hour = val(ot15hour) + val(getvariabledata1.selfothour2)>
        <cfset ot15total = val(ot15total) + val(getvariabledata1.selfot2)>
        <cfset ot20hour = val(ot20hour) + val(getvariabledata1.selfothour3)>
        <cfset ot20total = val(ot20total) + val(getvariabledata1.selfot3)>
        <cfset ot30hour = val(ot30hour) + val(getvariabledata1.selfothour4)>
        <cfset ot30total = val(ot30total) + val(getvariabledata1.selfot4)>
        <cfset othour = val(othour) + val(getvariabledata1.selfothourtotal)>
        <cfset ottotal = val(ottotal) + val(getvariabledata1.selfottotal)>
    </cfloop>

        <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>
        <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>

    <cfset totalline = "">

    <cfloop index="a" from="1" to="12">
        <cfset totalline = totalline&",">
    </cfloop>

    <cfset SpreadSheetAddRow(tempvar, "#totalline##tnormalday#,,#tnormal#,#tconcourseday#,,#tconcourse#,#tphday#,,#tph#,#tbasicwage#,#tbackpay#,#treimburse#,,#tincentive#,#tgross#,#ot15hour#,#ot15total#,#ot20hour#,#ot20total#,#ot30hour#,#ot30total#,#othour#,#ottotal#")>--->
        
    <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>
    <cfset SpreadSheetAddRow(tempvar, ",,,,,,,,,,,,,,")>

    <cfset SpreadSheetAddRow(tempvar, ",Total:,#getvariabledata1.recordcount#")>   
        
    <cfloop query="getvariabledata1">
        <cfset spreadsheetSetCellFormula(tempvar, "M#10+getvariabledata1.currentrow#*N#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,15)>
            
        <cfset spreadsheetSetCellFormula(tempvar, "P#10+getvariabledata1.currentrow#*Q#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,18)>        
            
        <cfif (form.period lt 3 and getmmonth.myear eq 2019) or getmmonth.myear lt 2019>
            <cfset spreadsheetSetCellFormula(tempvar, "S#10+getvariabledata1.currentrow#*T#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,21)>
                
            <cfset spreadsheetSetCellFormula(tempvar, "L#10+getvariabledata1.currentrow#+O#10+getvariabledata1.currentrow#+U#10+getvariabledata1.currentrow#+R#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,22)>
        
            <cfset spreadsheetSetCellFormula(tempvar, "V#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#+X#10+getvariabledata1.currentrow#+Z#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,27)>

            <cfset spreadsheetSetCellFormula(tempvar, "AB#10+getvariabledata1.currentrow#+AD#10+getvariabledata1.currentrow#+AF#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,34)>

            <cfset spreadsheetSetCellFormula(tempvar, "AC#10+getvariabledata1.currentrow#+AE#10+getvariabledata1.currentrow#+AG#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,35)>
        <cfelse>
            <cfset spreadsheetSetCellFormula(tempvar, "L#10+getvariabledata1.currentrow#+O#10+getvariabledata1.currentrow#+R#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,19)>

            <cfset spreadsheetSetCellFormula(tempvar, "S#10+getvariabledata1.currentrow#+T#10+getvariabledata1.currentrow#+U#10+getvariabledata1.currentrow#+W#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,24)>

            <cfset spreadsheetSetCellFormula(tempvar, "Y#10+getvariabledata1.currentrow#+AA#10+getvariabledata1.currentrow#+AC#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,31)>

            <cfset spreadsheetSetCellFormula(tempvar, "Z#10+getvariabledata1.currentrow#+AB#10+getvariabledata1.currentrow#+AD#10+getvariabledata1.currentrow#", 10+getvariabledata1.currentrow,32)>
        </cfif>

        
    </cfloop>
            
    <cfloop index="aa" from="12" to="35">
        <cfif (form.period lt 3 and getmmonth.myear eq 2019) or getmmonth.myear lt 2019>
        <cfif aa neq 14 and aa neq 17 and aa neq 20>
            <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3,aa)>
        </cfif>
        <cfelse>
            <cfif aa neq 14 and aa neq 17>
                <cfset spreadsheetSetCellFormula(tempvar, "SUM(#numbertoletter(aa)#11:#numbertoletter(aa)##10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3,aa)>
            </cfif>
        </cfif>
    </cfloop>
        
    <cfset spreadsheetSetCellFormula(tempvar, "COUNTA(A11:A#10+getvariabledata1.recordcount#)", 10+getvariabledata1.recordcount+3, 3)>

    <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->    

    <cfset SpreadSheetFormatCellRange(tempvar, s67, 11, 12, getvariabledata1.recordcount+11, lastcolumn)>
    <cfset SpreadSheetFormatCellRange(tempvar, s67, getvariabledata1.recordcount+13, 12, getvariabledata1.recordcount+13, 35)>

    <cfset SpreadSheetFormatCellRange(tempvar, s28, 11, 1, getvariabledata1.recordcount+10, lastcolumn)>
            
    <cfset SpreadSheetFormatCellRange(tempvar, sTextwrap, 11, 6, getvariabledata1.recordcount+10, 6)>
        
    <cfset SpreadSheetFormatCellRange(tempvar, s68, 6, 9, getvariabledata1.recordcount+10, 10)> 

    <!---Header--->
    <cfset SpreadSheetFormatCellRange(tempvar, s23, 8, 1, 8, 27)>
    <cfset SpreadSheetFormatCellRange(tempvar, s31, 9, 1, 10, lastcolumn)>
    <cfset SpreadSheetFormatCellRange(tempvar, s34, 8, startotcolumn, 9, lastcolumn)><!---OT section of header--->
    <cfset SpreadSheetFormatCellRange(tempvar, s33, 8, lastcolumn, 8, lastcolumn)><!---OT section of header--->
    <cfset SpreadSheetFormatCellRange(tempvar, s35, 10, startotcolumn, 10, 34)>
    <!---Header--->

    <cfset SpreadSheetFormatCellRange(tempvar, s32, 1, 25, 2, 26)>

    <cfloop index="i" from="1" to="#lastcolumn#">
        <cfset spreadsheetSetColumnWidth(tempvar, i, columnnumbers) >
    </cfloop>

    <cfset spreadsheetSetColumnWidth(tempvar, 3, columnname) >

    <cfset spreadsheetSetColumnWidth(tempvar, otwordcolumn, 20) >
        
    <cfset spreadsheetSetColumnWidth(tempvar, 6, 16) >
        
    <cfset spreadsheetSetColumnWidth(tempvar, 8, 16) >

    <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
    <cfset spreadsheetSetRowHeight(tempvar, 9, 41)>

    <cfspreadsheet action="update" sheetname="#checkregion.workordid#" filename="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx" name="tempvar">
        

</cfif>
    
</cfloop>
    
</cfif>  
<!---Add 2nd sheets--->
        
<cfset filename = "VARIABLE REPORT for temp #thisperiod# #getmmonth.myear#_#timenow#">
        
<!---End Temp--->   
</cfif>
        
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
<cfif fileExists("#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx") eq false>
    
    <script>
        alert("No File Generated due to no data for the selected month.");
        window.close();
    </script>
    <cfabort>
        
</cfif>
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx">
    
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