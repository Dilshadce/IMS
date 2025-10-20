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
    
<cfset s28 = StructNew()>
<cfset s28.bottomborder="thin">
<cfset s28.topborder="thin">
<cfset s28.leftborder="thin">
<cfset s28.rightborder="thin">
    
<cfset s39 = StructNew()>    
<cfset s39.underline="true">
<cfset s39.bold="true">
    
<cfset s50 = StructNew()>    
<cfset s50.bold="true">
    
<cfset s51 = StructNew()>    
<cfset s51.topborder="medium">

<cfset s52 = StructNew()>    
<cfset s52.bottomborder="medium">
    
<cfset s53 = StructNew()>    
<cfset s53.leftborder="medium">
    
<cfset s54 = StructNew()>    
<cfset s54.rightborder="medium">

<cfset s55 = StructNew()>    
<cfset s55.alignment="center">
    
<cfset s56 = StructNew()>    
<cfset s56.topborder="thin">
    
<cfset s57 = StructNew()>    
<cfset s57.textwrap="true">
<cfset s57.verticalalignment="vertical_center">
<cfset s57.topborder="thin">
<cfset s57.rightborder="medium">
<cfset s57.bold="true">
<cfset s57.alignment="center">
    
<cfset s58 = StructNew()>    
<cfset s58.alignment="left">
<cfset s58.verticalalignment="vertical_center">
<cfset s58.bold="true">
<cfset s58.topborder="thin">
<cfset s58.rightborder="medium">
    
<cfset s59 = StructNew()>    
<cfset s59.leftborder="thin">
    
<cfset s60 = StructNew()>    
<cfset s60.topborder="double">
    
<cfset s61 = StructNew()>    
<cfset s61.topborder="medium">
<cfset s61.leftborder="medium">
<cfset s61.rightborder="medium">
    
<cfset s100 = StructNew()>    
<cfset s100.topborder="medium">
<cfset s100.bottomborder="medium">
<cfset s100.leftborder="medium">
<cfset s100.rightborder="medium">
    
<cfset s63 = StructNew()>    
<cfset s63.topborder="thin">
<cfset s63.leftborder="medium">
<cfset s63.rightborder="medium">
    
<cfset s64 = StructNew()>    
<cfset s64.rightborder="medium">
<cfset s64.leftborder="medium">    
    
<cfset s65 = StructNew()>    
<cfset s65.topborder="thin">
    
<cfset s66 = StructNew()>    
<cfset s66.alignment="right">
    
<cfset s68 = StructNew()>    
<cfset s68.underline="true">
<!---Excel Format--->
    
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
    
<cfif day(now()) lte 5 and month(now()) eq form.period>
    
<cfquery name="setrow" datasource="#dts#">
    set @row=0;
</cfquery>
    
<cfquery name="getdata" datasource="#dts#">
SELECT @row := @row + 1 as row_number,sortquery.* 
FROM (
    SELECT empno,empname,nricn,workordid,DateofHire,DateofCessation,Basic,
    Incentive,GALLOW,0 GALLOWAjd,
    <cfif form.period eq 1>
    Bonus,
    Shoe,
    ExcellenceAward, LongServiceAward,    
    <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
    Shoe,
    </cfif>    
    CarMaintenance,UPL,BackPaySalary,BackPayGA,GrossWage,
    EPFYER,SOCSOYER,EISYER,AdminFee,
    (GrossWage + EPFYER + SOCSOYER + EISYER + AdminFee) TotalBilling,
    (
        <cfif (getmmonth.myear eq 2018 and form.period gte 9) or getmmonth.myear gt 2018>
            AdminFee*0.06
        <cfelse>
            (GrossWage + EPFYER + SOCSOYER + EISYER + AdminFee)*<cfif form.period gte 6 and getmmonth.myear eq 2018 and form.period lte 8>0<cfelse>0.06</cfif>
        </cfif>
    ) GST,
    (
            (GrossWage + EPFYER + SOCSOYER + EISYER + AdminFee)+
            <cfif (getmmonth.myear eq 2018 and form.period gte 9) or getmmonth.myear gt 2018>
                AdminFee*0.06
            <cfelse>
                (GrossWage + EPFYER + SOCSOYER + EISYER + AdminFee)*<cfif form.period gte 6 and getmmonth.myear eq 2018 and form.period lte 8>0<cfelse>0.06</cfif>
            </cfif>
    ) TotalBillingGST
    
    FROM (
        SELECT pl.empno,pl.empname,
        case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
        workordid,date_format(dcomm,'%e-%b-%y') DateofHire,date_format(dresign,'%e-%b-%y') DateofCessation,
        sum(case when day(dcomm)<=10 and month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear#
        then 
            coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
        else 
            case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear#
            then 
                coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
            else cast(employee_rate_1 as decimal(15,5)) 
            end 
        end) as Basic,
        case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# then 0 else 1000 end Incentive,
        case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear# and jtitle != 'Supervisor' 
        then coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*100 as decimal(15,5)),2),0) 
        else 
            case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# and jtitle != 'Supervisor' 
            then coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*100 as decimal(15,5)),2),0)  else 
                case when ((#form.period#>6 and #getmmonth.myear#=2018) or #getmmonth.myear#>2018) and jtitle='Supervisor' 
                then 0 else 100 end
            end
        end GALLOW,
        0 GALLOWAjd,
        <cfif form.period eq 1>
        0 Bonus,
        case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='supervisor' then 0 else 60 end Shoe,
        0 ExcellenceAward, 0 LongServiceAward,
        
        <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
        case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='supervisor' then 0 else 60 end Shoe,
        </cfif>
        case when jtitle='supervisor' then 300 else 0 end CarMaintenance,0 UPL,
            case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear#
            then 
                round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2) 
            else 0
            end as BackPaySalary,
            case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear# and allowanceamt1 > 0
            then 
                round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(allowanceamt1 as decimal(15,5)) as decimal(15,5)),2) 
            else 0
            end as BackPayGA,
        sum(0
            + case when day(dcomm)<=10 and month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear#
            then 
                coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
            else 
                case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear#
                then 
                    coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
                else cast(employee_rate_1 as decimal(15,5)) 
                end 
            end
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# then 0 else 1000 end
            + case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear# and jtitle != 'Supervisor' 
            then coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*100 as decimal(15,5)),2),0) 
            else 
                case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# and jtitle != 'Supervisor' 
                then coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*100 as decimal(15,5)),2),0)  else 
                    case when ((#form.period#>6 and #getmmonth.myear#=2018) or #getmmonth.myear#>2018) and jtitle='Supervisor' 
                    then 0 else 100 end
                end
            end
            + 0 <!---GALLOWAjd--->            
            <cfif form.period eq 1>
            + 0 <!---Bonus--->
            + 0 <!---ExcellenceAward--->
            + 0 <!---LongServiceAward--->
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            </cfif>
            + case when jtitle='Supervisor' then 300 else 0 end
            + 0 <!---UPL--->
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear#
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear# and allowanceamt1 > 0
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(allowanceamt1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
        ) GrossWage,
        sum(0
            + case when day(dcomm)<=10 and month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear#
            then 
                coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
            else 
                case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear#
                then 
                    coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
                else cast(employee_rate_1 as decimal(15,5)) 
                end 
            end
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# then 0 else 1000 end
            + case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear# and jtitle != 'Supervisor' 
            then coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*100 as decimal(15,5)),2),0) 
            else 
                case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# and jtitle != 'Supervisor' 
                then coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*100 as decimal(15,5)),2),0)  else 
                    case when ((#form.period#>6 and #getmmonth.myear#=2018) or #getmmonth.myear#>2018) and jtitle='Supervisor' 
                    then 0 else 100 end
                end
            end
            + 0 <!---GALLOWAjd--->            
            <cfif form.period eq 1>
            + 0 <!---Bonus--->
            + 0 <!---ExcellenceAward--->
            + 0 <!---LongServiceAward--->
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            </cfif>
            + case when jtitle='Supervisor' then 300 else 0 end
            + 0 <!---UPL--->
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear#
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear# and allowanceamt1 > 0
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(allowanceamt1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
        )*0.13 EPFYER, 
        sum(0
            + case when day(dcomm)<=10 and month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear#
            then 
                coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
            else 
                case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear#
                then 
                    coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
                else cast(employee_rate_1 as decimal(15,5)) 
                end 
            end
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# then 0 else 1000 end
            + case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear# and jtitle != 'Supervisor' 
            then coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*100 as decimal(15,5)),2),0) 
            else 
                case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# and jtitle != 'Supervisor' 
                then coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*100 as decimal(15,5)),2),0)  else 
                    case when ((#form.period#>6 and #getmmonth.myear#=2018) or #getmmonth.myear#>2018) and jtitle='Supervisor' 
                    then 0 else 100 end
                end
            end
            + 0 <!---GALLOWAjd--->            
            <cfif form.period eq 1>
            + 0 <!---Bonus--->
            + 0 <!---ExcellenceAward--->
            + 0 <!---LongServiceAward--->
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            </cfif>
            + case when jtitle='Supervisor' then 300 else 0 end
            + 0 <!---UPL--->
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear#
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear# and allowanceamt1 > 0
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(allowanceamt1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
        )*0.02 SOCSOYER,
        sum(0
            + case when day(dcomm)<=10 and month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear#
            then 
                coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
            else 
                case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear#
                then 
                    coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2),0) 
                else cast(employee_rate_1 as decimal(15,5)) 
                end 
            end
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# then 0 else 1000 end
            + case when month(dresign)=#form.period# and year(dresign)=#getmmonth.myear# and jtitle != 'Supervisor' 
            then coalesce(round(cast((DAY(LAST_DAY(dresign))-(DATEDIFF(LAST_DAY(dresign),dresign)))/DAY(LAST_DAY(dresign))*100 as decimal(15,5)),2),0) 
            else 
                case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# and jtitle != 'Supervisor' 
                then coalesce(round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*100 as decimal(15,5)),2),0)  else 
                    case when ((#form.period#>6 and #getmmonth.myear#=2018) or #getmmonth.myear#>2018) and jtitle='Supervisor' 
                    then 0 else 100 end
                end
            end
            + 0 <!---GALLOWAjd--->            
            <cfif form.period eq 1>
            + 0 <!---Bonus--->
            + 0 <!---ExcellenceAward--->
            + 0 <!---LongServiceAward--->
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
            + case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end
            </cfif>
            + case when jtitle='Supervisor' then 300 else 0 end
            + 0 <!---UPL--->
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear#
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(employee_rate_1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
            + case when day(dcomm)>=10 and month(dcomm)=#lastperiodnum# and year(dcomm)=#lastyear# and allowanceamt1 > 0
                then 
                    round(cast((DATEDIFF(LAST_DAY(dcomm),dcomm)+1)/DAY(LAST_DAY(dcomm))*cast(allowanceamt1 as decimal(15,5)) as decimal(15,5)),2) 
                else 0
                end
        )*0.002 EISYER,
        80 AdminFee

        FROM placement pl
        LEFT JOIN #dts_p#.pmast pm
        ON pl.empno=pm.empno
        WHERE jobpostype in (3,5)
        AND workordid != ""
        AND jobstatus=2
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND ((month(dresign )>= #form.period# and year(dresign) >= #getmmonth.myear#) or dresign="0000-00-00") 
        AND cast(employee_rate_1 as decimal(15,5)) <>0
        AND completedate>=#createdate(getmmonth.myear,form.period,1)#
        <!---AND (
        (startdate > #createdate(getmmonth.myear,form.period,10)# AND startdate <= #createdate(getmmonth.myear,form.period,daysinmonth(createdate(getmmonth.myear,form.period,1)))#)
        OR startdate <= #createdate(getmmonth.myear,form.period,daysinmonth(createdate(getmmonth.myear,form.period,1)))#)--->
        AND startdate <= #createdate(getmmonth.myear,form.period,10)#
        GROUP BY pl.empno 
        ORDER BY workordid,pl.empno 
        ) aa
    ) sortquery
    ORDER BY row_number
</cfquery>   
                
<cfelse>
    
    <cfquery name="getdata" datasource="#dts#">
        SELECT id, empno, empname, nricn, workordid, DateofHire, DateofCessation, Basic, Incentive, GALLOW, GALLOWAjd, 
        <cfif form.period eq 1>
            Bonus, ExcellenceAward, LongServiceAward, Shoe, 
        <cfelseif (form.period eq 7 and getmmonth.myear gt 2018) or getmmonth.myear gt 2018>
            Shoe,
        </cfif>
        CarMaintenance, UPL, BackPaySalary, BackPayGA, GrossWage, EPFYER, SOCSOYER, EISYER, AdminFee, TotalBilling, GST, TotalBillingGST
        FROM lorealadvance
        WHERE tmonth=#form.period# and tyear=#getmmonth.myear#
    </cfquery>
    
</cfif>
                
<!---<cfif form.period lte 11 and getmmonth.myear eq 2018>--->
<cfset reimburselist  = "6,30,1002,119,1001,120,121,122,123,1000">
<cfset grosslist  = "19,78,6,3,124,112,111,110,129,128,79,14,9,118">
                
<cfquery name="getpayrolldata" datasource="#dts#">
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
        <cfif getmmonth.myear eq 2018 and form.period gte 11>
        <cfloop index="i" list="#reimburselist#">
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
            </cfloop>
        </cfloop>
        </cfif>
            + coalesce(a.adminfee,0)
            +bp.AdminFee
        ) AS DECIMAL(15,5)))*a2.taxper/100) as TotalGST,<!---6% GST--->
        (sum(coalesce(a.custtotalgross,0)+ coalesce(bp.custtotalgross,0))+(sum(( CAST((0
        <cfif getmmonth.myear eq 2018 and form.period gte 11>
        <cfloop index="i" list="#reimburselist#">
            <cfloop  index="a" from="1" to="6">
                + coalesce(case when a.fixawcode#a#= #i# then coalesce(a.fixawer#a#,0) else 0 end,0)
            </cfloop>
            <cfloop  index="a" from="1" to="18">
                + coalesce(case when a.allowance#a#= #i# then coalesce(a.awer#a#,0) else 0 end,0)
            </cfloop>
        </cfloop>
        </cfif>
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
        
<cfquery name="getinvoiceno" datasource="#dts#">
    SELECT invoiceno FROM assignmentslip 
    WHERE payrollperiod<>99
    AND month(assignmentslipdate)=#form.period#
    AND empname LIKE "%Advance Salary Permanent%"
    AND day(assignmentslipdate) between 1 and 15
</cfquery>
    
<cfquery name="getactinvoiceno" dbtype='query'>
    SELECT invoiceno FROM getpayrolldata 
    WHERE invoiceno != ''
</cfquery>
        
<!---Total line process--->
<cfset tbasic = 0> 
<cfset tincentive = 0> 
<cfset tgallow = 0>         
<cfset tgallowadj = 0>  

<cfif form.period eq 1>
    <cfset tbonus = 0>  
    <cfset tLongService = 0>
    <cfset texcellence = 0> 
    <cfset tshoe = 0> 
<cfelseif (form.period eq 7 and getmmonth.myear gt 2018) or getmmonth.myear gt 2018>
    <cfset tshoe = 0>  
</cfif>

<cfset tannualleaveinlieu = 0>
<cfset tcarmain = 0>
<cfset tupl = 0>
<cfset tBackPaySalary = 0>
<cfset tBackPayGA = 0>
<cfset tGross = 0>
<cfset tepf = 0>
<cfset tsocso = 0>
<cfset teis = 0>
<cfset tadmin = 0>
<cfset tbilling = 0>
<cfset tGst = 0>
<cfset tBillingGST = 0>    

<cfloop query="getdata">
    <cfset tbasic = tbasic + val(getdata.Basic)> 
    <cfset tincentive = tincentive + val(getdata.Incentive)> 
    <cfset tgallow = tgallow + val(getdata.GALLOW)>          
    <cfset tgallowadj = tgallowadj + val(getdata.GALLOWAjd)>          

    <cfif form.period eq 1>
        <cfset tbonus = tbonus + val(getdata.Bonus)>  
        <cfset tLongService = tLongService + val(getdata.LongServiceAward)>
        <cfset texcellence = texcellence + val(getdata.ExcellenceAward)> 
        <cfset tshoe = tshoe + val(getdata.Shoe)> 
    <cfelseif (form.period eq 7 and getmmonth.myear gt 2018) or getmmonth.myear gt 2018>
        <cfset tshoe = tshoe + val(getdata.Shoe)>  
    </cfif>            

    <cfset tcarmain = tcarmain + val(getdata.CarMaintenance)> 
    <cfset tupl = tupl + val(getdata.UPL)> 
    <cfset tBackPaySalary = tBackPaySalary + val(getdata.BackPaySalary)> 
    <cfset tBackPayGA = tBackPayGA + val(getdata.BackPayGA)> 
    <cfset tGross = tGross + val(getdata.GrossWage)> 
    <cfset tepf = tepf + val(getdata.EPFYER)> 
    <cfset tsocso = tsocso + val(getdata.SOCSOYER)> 
    <cfset teis = teis + val(getdata.EISYER)> 
    <cfset tadmin = tadmin + val(getdata.AdminFee)> 
    <cfset tbilling = tbilling + val(getdata.TotalBilling)> 
    <cfset tGst = tGst + val(getdata.GST)> 
    <cfset tBillingGST = tBillingGST + val(getdata.TotalBillingGST)>   
</cfloop>
        
<cfset actbasic = 0>
<cfset actgallow = 0>
<cfset actgallowadj = 0>    
<cfset actexcellence = 0>
<cfset actlongserv = 0>
<cfset actincentive = 0>
<cfset actbonus = 0>
<cfset actcar = 0>
<cfset actreimburse = 0>
<cfset actshoe = 0>
<cfset actannualleaveinlieu = 0>
<cfset act15h = 0>
<cfset act15amt = 0>
<cfset act20h = 0>
<cfset act20amt = 0>
<cfset act30h = 0>
<cfset act30amt = 0>
<cfset actotamt = 0>
<cfset actnpl = 0>
<cfset actbackpay = 0>
<cfset actbackpayga = 0>
<cfset actgross = 0>
<cfset actepf = 0>
<cfset actsocso = 0>
<cfset acteis = 0>
<cfset actadminfee = 0>
<cfset actbilling = 0>
<cfset actgst = 0>
<cfset acttotalwgst = 0>

<cfloop query="getpayrolldata">
    <cfset actbasic = val(actbasic) + val(getpayrolldata.BasicRate)>
    <cfset actgallow = val(actgallow) + val(getpayrolldata.GALLOW)>
    <cfset actgallowadj = val(actgallowadj) + val(getpayrolldata.GALLOWAdj)>    
    <cfset actexcellence = val(actexcellence) + val(getpayrolldata.ExcellenceAward)>
    <cfset actlongserv = val(actlongserv) + val(getpayrolldata.LongService)>
    <cfset actincentive = val(actincentive) + val(getpayrolldata.Incentive)>
    <cfset actbonus = val(actbonus) + val(getpayrolldata.Bonus)>
    <cfset actreimburse = val(actreimburse) + val(getpayrolldata.Reimbursement)>
    <cfset actcar = val(actcar) + val(getpayrolldata.CarMaintenance)>
    <cfset actshoe = val(actshoe) + val(getpayrolldata.Shoe)>
    <cfset actannualleaveinlieu = val(actannualleaveinlieu) + val(getpayrolldata.AnnualLeaveinLieu)>
    <cfset act15h = val(act15h) + val(getpayrolldata.custothour2)>
    <cfset act15amt = val(act15amt) + val(getpayrolldata.custot2)>
    <cfset act20h = val(act20h) + val(getpayrolldata.custothour3)>
    <cfset act20amt = val(act20amt) + val(getpayrolldata.custot3)>
    <cfset act30h = val(act30h) + val(getpayrolldata.custothour4)>
    <cfset act30amt = val(act30amt) + val(getpayrolldata.custot4)>
    <cfset actotamt = val(actotamt) + val(getpayrolldata.custottotal)>
    <cfset actnpl = val(actnpl) + val(getpayrolldata.UnpaidLeave)>
    <cfset actbackpay = val(actbackpay) + val(getpayrolldata.BackPayWage)>
    <cfset actbackpayga = val(actbackpayga) + val(getpayrolldata.BackPayGA)>
    <cfset actgross = val(actgross) + val(getpayrolldata.GrossWage)>
    <cfset actepf = val(actepf) + val(getpayrolldata.ER_EPF)>
    <cfset actsocso = val(actsocso) + val(getpayrolldata.ER_SOCSO)>
    <cfset acteis = val(acteis) + val(getpayrolldata.ER_EIS)>
    <cfset actadminfee = val(actadminfee) + val(getpayrolldata.adminfee)>
    <cfset actbilling = val(actbilling) + val(getpayrolldata.TotalBilling)>
    <cfset actgst = val(actgst) + val(getpayrolldata.TotalGST)>
    <cfset acttotalwgst = val(acttotalwgst) + val(getpayrolldata.TotalBillingWGST)>
</cfloop>
        
<!---Total line process--->
        
<cfif form.period eq 1>
    <cfset itemlist = "Basic Salary,Grooming Allowance,Grooming Allowance - Adjustment">

    <cfif tbonus neq 0>
        <cfset itemlist = itemlist&",Bonus">
    </cfif>

    <cfif tshoe neq 0>
        <cfset itemlist = itemlist&",Shoe">
    </cfif>

    <cfif texcellence neq 0>
        <cfset itemlist = itemlist&",Excellence Award">
    </cfif>

    <cfif tLongService neq 0>
        <cfset itemlist = itemlist&",Long Service Award">
    </cfif>

    <cfset itemlist = itemlist&",Incentive,Annual Leave in Lieu,Car Maintenance,Misc Expenses,Overtime,No Pay Leave,Backpay Overtime,Backpay Salary,Backpay Grooming Allowance,Notice in Lieu,EPF,Socso,EIS">

<cfelseif (form.period eq 7 and getmmonth.myear gt 2018) or getmmonth.myear gt 2018>
    <cfset itemlist = "Basic Salary,Grooming Allowance,Grooming Allowance - Adjustment">

    <cfif tshoe neq 0>
        <cfset itemlist = itemlist&",Shoe">
    </cfif>

    <cfset itemlist = itemlist&",Incentive,Annual Leave in Lieu,Car Maintenance,Misc Expenses,Overtime,No Pay Leave,Backpay Overtime,Backpay Salary,Backpay Grooming Allowance,Notice in Lieu,EPF,Socso,EIS">
<cfelse>
    <cfset itemlist = "Basic Salary,Grooming Allowance,Grooming Allowance - Adjustment,Incentive,Annual Leave in Lieu,Car Maintenance,Misc Expenses,Overtime,No Pay Leave,Backpay Overtime,Backpay Salary,Backpay Grooming Allowance,Notice in Lieu,EPF,Socso,EIS">
        
    <cfif actbonus neq 0>
        <cfset itemlist = replacenocase(itemlist,"Incentive,","Incentive,Bonus,")>
    </cfif>
</cfif>
    
<cfquery name="getPOno" datasource="#dts#">
    SELECT po_no FROM placement pl
    LEFT JOIN #dts_p#.pmast pm
    ON pl.empno=pm.empno
    WHERE jobpostype in (3,5)
    AND workordid != ""
    AND jobstatus=2
    AND (custname like "%l'oreal%"  or custname like "%loreal%")
    AND ((month(dresign )>= #form.period# and year(dresign) >= #getmmonth.myear#) or dresign="0000-00-00") 
    AND cast(employee_rate_1 as decimal(15,5)) <>0
    AND completedate>=#createdate(getmmonth.myear,form.period,daysinmonth(createdate(getmmonth.myear,form.period,1)))#
    AND (
    (startdate > #createdate(getmmonth.myear,form.period,10)# AND startdate <= #createdate(getmmonth.myear,form.period,daysinmonth(createdate(getmmonth.myear,form.period,1)))#)
    OR startdate <= #createdate(getmmonth.myear,form.period,daysinmonth(createdate(getmmonth.myear,form.period,1)))#)
</cfquery>
    
<cfset empty = 0> 
        
        
<!---Add 2nd sheets--->
    <cfquery name="getregion" dbtype="query">
        SELECT workordid,count(empno) c,sum(TotalBillingWGST) TotalBillingGST FROM getpayrolldata
        WHERE workordid != ''
        GROUP BY workordid
    </cfquery>
        
    <cfset headerlist1 = "GL CODE,FIN CODE,Description :,LMSB,MANPOWER,Variance">
        
    <cfset headerlistarray1 = listtoarray(headerlist1)>
        
    <cfset headerlist2 = " , ,HEADCOUNT,PO No.,Inv No.,DN/CN No.">
        
    <cfset headerlistarray2 = listtoarray(headerlist2)>
        
    <cfset itemlistarray = listtoarray(itemlist)>
        
    <cfset adminfeeline = "707150,200-1101,Management Fee (RM80/HC),0">
        
    <cfset adminfeelinearray = listtoarray(adminfeeline)>
        
    <cfset gstline = "306020,200-1101,GST,0">
    
    <!---<cfif getmmonth.myear gte 2018 and form.period gte 6>
        <cfset gstline = "306020,200-1101,GST,0">
    <cfelse>
        <cfset gstline = "306020,200-1101,GST (6%),0">
    </cfif>--->
        
    <cfif getmmonth.myear gte 2018 and form.period gte 6 and form.period lte 8>
        <cfset gstline = "306020,200-1101,GST,0">
    <cfelseif getmmonth.myear lte 2018 and form.period lte 6>
        <cfset gstline = "306020,200-1101,GST (6%),0">
    <cfelse>
        <cfset gstline = "707150,200-1101,SST (6%),0">
    </cfif>
        
    <cfset gstlinearray = listtoarray(gstline)>
        
    <cfset tablewidth = 1>
        
    <cfset rowtoprint = 3>
        
    <cfset secondpage = SpreadSheetNew(true)>  
        
    <cfset SpreadSheetAddRow(secondpage, "Reconciliation report")>
        
    <cfset spreadsheetAddColumn(secondpage, "Month:", 1, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, " #thisperiod# #getmmonth.myear#", 1, 12, false)>
        
    <cfset actualsumcell = "">
        
    <cfset advancesumcell = "">
        
    <cfloop query="getregion">
        
        <cfif getregion.workordid neq ''>
            
            <cfquery name="getregiondata" dbtype="query">
                SELECT * FROM getdata
                WHERE workordid='#getregion.workordid#'
            </cfquery>   
            
            <cfquery name="getactregiondata" dbtype="query">
                SELECT * FROM getpayrolldata
                WHERE workordid='#getregion.workordid#'
            </cfquery>  
            
            <cfset headerlist3 = " , ,#getactregiondata.recordcount#,#getPOno.po_no#,#getinvoiceno.invoiceno#,#getactinvoiceno.invoiceno#">
        
            <cfset headerlistarray3 = listtoarray(headerlist3)>

            <!---rt: Region Total--->
            <cfset rtbasic = 0> 
            <cfset rtincentive = 0> 
            <cfset rtgallow = 0>         
            <cfset rtgallowadj = 0>  
            <cfset rtbonus = 0>  
            <cfset rtLongService = 0>
            <cfset rtexcellence = 0> 
            <cfset rtshoe = 0>  

            <cfset rtannualleaveinleiu = 0>
            <cfset rtcarmain = 0>
            <cfset rtupl = 0>
            <cfset rtBackPaySalary = 0>
            <cfset rtBackPayGA = 0>
            <cfset rtotamt = 0>
            <cfset rtreimburse = 0>
            <cfset rtGross = 0>
            <cfset rtepf = 0>
            <cfset rtsocso = 0>
            <cfset rteis = 0>
            <cfset rtadmin = 0>
            <cfset rtbilling = 0>
            <cfset rtGst = 0>
            <cfset rtBillingGST = 0>    

            <cfloop query="getregiondata">
                <cfset rtbasic = rtbasic + val(getregiondata.Basic)> 
                <cfset rtincentive = rtincentive + val(getregiondata.Incentive)> 
                <cfset rtgallow = rtgallow + val(getregiondata.GALLOW)>          
                <cfset rtgallowadj = rtgallowadj + val(getregiondata.GALLOWAjd)>          

                <cfif form.period eq 1>
                    <cfset rtbonus = rtbonus + val(getregiondata.Bonus)>  
                    <cfset rtLongService = rtLongService + val(getregiondata.LongServiceAward)>
                    <cfset rtexcellence = rtexcellence + val(getregiondata.ExcellenceAward)> 
                    <cfset rtshoe = rtshoe + val(getregiondata.Shoe)> 
                <cfelseif (form.period eq 7 and getmmonth.myear gt 2018) or getmmonth.myear gt 2018>
                    <cfset rtshoe = rtshoe + val(getregiondata.Shoe)>  
                </cfif>            

                <cfset rtcarmain = rtcarmain + val(getregiondata.CarMaintenance)> 
                <cfset rtupl = rtupl + val(getregiondata.UPL)> 
                <cfset rtBackPaySalary = rtBackPaySalary + val(getregiondata.BackPaySalary)> 
                <cfset rtBackPayGA = rtBackPayGA + val(getregiondata.BackPayGA)> 
                <cfset rtGross = rtGross + val(getregiondata.GrossWage)> 
                <cfset rtepf = rtepf + val(getregiondata.EPFYER)> 
                <cfset rtsocso = rtsocso + val(getregiondata.SOCSOYER)> 
                <cfset rteis = rteis + val(getregiondata.EISYER)> 
                <cfset rtadmin = rtadmin + val(getregiondata.AdminFee)> 
                <cfset rtbilling = rtbilling + val(getregiondata.TotalBilling)> 
                <cfset rtGst = rtGst + val(getregiondata.GST)> 
                <cfset rtBillingGST = rtBillingGST + val(getregiondata.TotalBillingGST)>   
            </cfloop>
                    
            <cfset ractbasic = 0>
            <cfset ractgallow = 0>
            <cfset ractgallowadj = 0>    
            <cfset ractexcellence = 0>
            <cfset ractlongserv = 0>
            <cfset ractincentive = 0>
            <cfset ractbonus = 0>
            <cfset ractcarmain = 0>
            <cfset ractreimburse = 0>
            <cfset ractshoe = 0>
            <cfset ractannualleaveinleiu = 0>
            <cfset ract15h = 0>
            <cfset ract15amt = 0>
            <cfset ract20h = 0>
            <cfset ract20amt = 0>
            <cfset ract30h = 0>
            <cfset ract30amt = 0>
            <cfset ractotamt = 0>
            <cfset ractupl = 0>
            <cfset ractBackPaySalary = 0>
            <cfset ractbackpayga = 0>
            <cfset ractgross = 0>
            <cfset ractepf = 0>
            <cfset ractsocso = 0>
            <cfset racteis = 0>
            <cfset ractadmin = 0>
            <cfset ractbilling = 0>
            <cfset ractgst = 0>
            <cfset ractBillingGST = 0>

            <cfloop query="getactregiondata">
                <cfset ractbasic = val(ractbasic) + val(getactregiondata.BasicRate)>
                <cfset ractgallow = val(ractgallow) + val(getactregiondata.GALLOW)>
                <cfset ractgallowadj = val(ractgallowadj) + val(getactregiondata.GALLOWAdj)>    
                <cfset ractexcellence = val(ractexcellence) + val(getactregiondata.ExcellenceAward)>
                <cfset ractlongserv = val(ractlongserv) + val(getactregiondata.LongService)>
                <cfset ractincentive = val(ractincentive) + val(getactregiondata.Incentive)>
                <cfset ractbonus = val(ractbonus) + val(getactregiondata.Bonus)>
                <cfset ractreimburse = val(ractreimburse) + val(getactregiondata.Reimbursement)>
                <cfset ractcarmain = val(ractcarmain) + val(getactregiondata.CarMaintenance)>
                <cfset ractshoe = val(ractshoe) + val(getactregiondata.Shoe)>
                <cfset ractannualleaveinleiu = val(ractannualleaveinleiu) + val(getactregiondata.AnnualLeaveinLieu)>
                <cfset ract15h = val(ract15h) + val(getactregiondata.custothour2)>
                <cfset ract15amt = val(ract15amt) + val(getactregiondata.custot2)>
                <cfset ract20h = val(ract20h) + val(getactregiondata.custothour3)>
                <cfset ract20amt = val(ract20amt) + val(getactregiondata.custot3)>
                <cfset ract30h = val(ract30h) + val(getactregiondata.custothour4)>
                <cfset ract30amt = val(ract30amt) + val(getactregiondata.custot4)>
                <cfset ractotamt = val(ractotamt) + val(getactregiondata.custottotal)+ val(getactregiondata.otadjust)>
                <cfset ractupl = val(ractupl) + val(getactregiondata.UnpaidLeave)>
                <cfset ractBackPaySalary = val(ractBackPaySalary) + val(getactregiondata.BackPayWage)>
                <cfset ractbackpayga = val(ractbackpayga) + val(getactregiondata.BackPayGA)>
                <cfset ractgross = val(ractgross) + val(getactregiondata.GrossWage)>
                <cfset ractepf = val(ractepf) + val(getactregiondata.ER_EPF)>
                <cfset ractsocso = val(ractsocso) + val(getactregiondata.ER_SOCSO)>
                <cfset racteis = val(racteis) + val(getactregiondata.ER_EIS)>
                <cfset ractadmin = val(ractadmin) + val(getactregiondata.adminfee)>
                <cfset ractbilling = val(ractbilling) + val(getactregiondata.TotalBilling)>
                <cfset ractgst = val(ractgst) + val(getactregiondata.TotalGST)>
                <cfset ractBillingGST = val(ractBillingGST) + val(getactregiondata.TotalBillingWGST)>
            </cfloop>
            <!---End rt: Region Total--->
                    
            <cfif form.period eq 1>
        
            <cfset ramtlist = "rtbasic,rtgallow,rtgallowadj">

            <cfif rtbonus neq 0>
                <cfset ramtlist = ramtlist&",rtbonus">
            </cfif>

            <cfif rtshoe neq 0>
                <cfset ramtlist = ramtlist&",rtshoe">
            </cfif>

            <cfif rtexcellence neq 0>
                <cfset ramtlist = ramtlist&",rtexcellence">
            </cfif>

            <cfif rtLongService neq 0>
                <cfset ramtlist = ramtlist&",rtLongService">
            </cfif>

            <cfset ramtlist = ramtlist&",rtincentive,rtannualleaveinleiu,rtcarmain,rtreimburse,rtotamt,rtupl,empty,rtBackPaySalary,rtBackPayGA,empty,rtepf,rtsocso,rteis,rtadmin,rtGst,rtBillingGST">

            <cfelseif (form.period eq 7 and getmmonth.myear gt 2018) or getmmonth.myear gt 2018>
                <cfset ramtlist = "rtbasic,rtgallow,rtgallowadj">

                <cfif rtshoe neq 0>
                    <cfset ramtlist = ramtlist&",rtshoe">
                </cfif>

                <cfset ramtlist = ramtlist&",rtincentive,rtannualleaveinleiu,rtcarmain,rtreimburse,rtotamt,rtupl,empty,rtBackPaySalary,rtBackPayGA,empty,rtepf,rtsocso,rteis,rtadmin,rtGst,rtBillingGST">
            <cfelse>
                <cfset ramtlist = "rtbasic,rtgallow,rtgallowadj,rtincentive,rtannualleaveinleiu,rtcarmain,rtreimburse,rtotamt,rtupl,empty,rtBackPaySalary,rtBackPayGA,empty,rtepf,rtsocso,rteis,rtadmin,rtGst,rtBillingGST">  
                
                <cfset ramtlist = replacenocase(ramtlist,"rtincentive,","rtincentive,rtbonus,")>
            </cfif>

            <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
            <cfif getregion.currentrow mod 2 eq 1>
                <cfloop index="i" from="1" to="#listlen(headerlist1)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray1[i]#", rowtoprint, 0+i, false)>
                </cfloop>
                <cfset spreadsheetAddColumn(secondpage, "Description : #getregion.workordid#", rowtoprint, 3, false)>
                    
                <cfloop index="i" from="1" to="#listlen(headerlist2)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray2[i]#", rowtoprint+1, 0+i, false)>
                </cfloop>
                    
                <cfloop index="i" from="1" to="#listlen(headerlist3)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray3[i]#", rowtoprint+2, 0+i, false)>
                </cfloop>
                    
                <!---Add body items--->                    
                <cfloop index="i" from="1" to="#listlen(itemlist)#">
                    <cfset spreadsheetAddColumn(secondpage, "#itemlistarray[i]#", rowtoprint+2+i, 3, false)>
                </cfloop>
                    
                <cfset last2row = rowtoprint+2+listlen(itemlist)>    
                    
                <cfloop index="i" from="1" to="#listlen(adminfeeline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#adminfeelinearray[i]#", last2row+1, 0+i, false)>
                </cfloop>
                    
                <cfloop index="i" from="1" to="#listlen(gstline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#gstlinearray[i]#", last2row+2, 0+i, false)>
                </cfloop>
                    
                <cfset startrow = 3>
                <cfset currentrow = 0>

                <cfloop index="a" list="#ramtlist#">        
                    <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
                    <cfif currentrow lt listlen(ramtlist)-3>
                        <cfset spreadsheetAddColumn(secondpage, "701370", rowtoprint+startrow+currentrow, 1, false)>
                        <cfset spreadsheetAddColumn(secondpage, "200-1101", rowtoprint+startrow+currentrow, 2, false)>
                    </cfif>
                    <cfset spreadsheetAddColumn(secondpage, "#evaluate('#replace(a,'rt','ract')#')#", rowtoprint+startrow+currentrow, 4, false)>
                    <cfset spreadsheetAddColumn(secondpage, "#evaluate(a)#", rowtoprint+startrow+currentrow, 5, false)>
                    <!---<cfset spreadsheetAddColumn(secondpage, "#evaluate('#replace(a,'rt','ract')#') - evaluate(a)#", rowtoprint+startrow+currentrow, 6, false)>--->
                    <cfset spreadsheetSetCellFormula(secondpage, "-E#rowtoprint+startrow+currentrow# + D#rowtoprint+startrow+currentrow#", rowtoprint+startrow+currentrow, 6)>
                        

                     <cfset currentrow += 1>
                </cfloop>  
                        
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(D#rowtoprint+startrow#:D#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 4)>
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(E#rowtoprint+startrow#:E#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 5)>
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(F#rowtoprint+startrow#:F#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 6)>
                    
                <cfif actualsumcell eq "">
                    <cfset actualsumcell = "D#rowtoprint+startrow+currentrow-1#">
                <cfelse>
                    <cfset actualsumcell = actualsumcell&"+D#rowtoprint+startrow+currentrow-1#">
                </cfif>
                    
                <cfif advancesumcell eq "">
                    <cfset advancesumcell = "E#rowtoprint+startrow+currentrow-1#">
                <cfelse>
                    <cfset advancesumcell = advancesumcell&"+E#rowtoprint+startrow+currentrow-1#">
                </cfif>
                <!---Add body items--->
                        
                <!---Format Table--->  
                <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+startrow+currentrow-1, 1, rowtoprint+startrow+currentrow-1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint, 1, rowtoprint, 6)>                
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+1, 1, rowtoprint+1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s63, rowtoprint+2, 4, rowtoprint+2, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+2, 1, rowtoprint+2, 3)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+3, 1, rowtoprint+3, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+4, 1, rowtoprint+startrow+currentrow-2, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint, 1, rowtoprint+2, 6)>  
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+3, 6, rowtoprint+startrow+currentrow-1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+startrow+currentrow-1, 4, rowtoprint+startrow+currentrow-1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+3, 4, rowtoprint+startrow+currentrow, 6)>
                <!---Format Header--->
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint, 1, rowtoprint+startrow+currentrow-1, 2)>
        
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-1, 3, rowtoprint+startrow-1, 6)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-2, 3, rowtoprint+startrow-2, 6)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 4, rowtoprint+startrow-3, 6)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 1, rowtoprint+startrow-3, 2)>
                <!---End Format Header--->
                <!---Format Table--->        
                    
            <cfelse>
                <cfloop index="i" from="1" to="#listlen(headerlist1)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray1[i]#", rowtoprint, 7+i, false)>
                </cfloop>
                <cfset spreadsheetAddColumn(secondpage, "Description : #getregion.workordid#", rowtoprint, 10, false)>
                    
                <cfloop index="i" from="1" to="#listlen(headerlist2)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray2[i]#", rowtoprint+1, 7+i, false)>
                </cfloop>
                    
                <cfloop index="i" from="1" to="#listlen(headerlist3)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray3[i]#", rowtoprint+2, 7+i, false)>
                </cfloop>
                    
                <!---Add body items--->
                <cfloop index="i" from="1" to="#listlen(itemlist)#">
                    <cfset spreadsheetAddColumn(secondpage, "#itemlistarray[i]#", rowtoprint+2+i, 10, false)>
                </cfloop>
                    
                <cfset last2row = rowtoprint+2+listlen(itemlist)>    
                    
                <cfloop index="i" from="1" to="#listlen(adminfeeline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#adminfeelinearray[i]#", last2row+1, 7+i, false)>
                </cfloop>
                    
                <cfloop index="i" from="1" to="#listlen(gstline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#gstlinearray[i]#", last2row+2, 7+i, false)>
                </cfloop>
                    
                <cfset startrow = 3>
                <cfset currentrow = 0>

                <cfloop index="a" list="#ramtlist#">        
                    <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
                    <cfif currentrow lt listlen(ramtlist)-3>
                        <cfset spreadsheetAddColumn(secondpage, "701370", rowtoprint+startrow+currentrow, 8, false)>
                        <cfset spreadsheetAddColumn(secondpage, "200-1101", rowtoprint+startrow+currentrow, 9, false)>
                    </cfif>
                    <cfset spreadsheetAddColumn(secondpage, "#evaluate('#replace(a,'rt','ract')#')#", rowtoprint+startrow+currentrow, 11, false)>
                    <cfset spreadsheetAddColumn(secondpage, "#evaluate(a)#", rowtoprint+startrow+currentrow, 12, false)>
                    <!---<cfset spreadsheetAddColumn(secondpage, "#evaluate('#replace(a,'rt','ract')#') - evaluate(a)#", rowtoprint+startrow+currentrow, 13, false)>--->
                    <cfset spreadsheetSetCellFormula(secondpage, "-L#rowtoprint+startrow+currentrow# + K#rowtoprint+startrow+currentrow#", rowtoprint+startrow+currentrow, 13)>

                     <cfset currentrow += 1>
                </cfloop> 
                        
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(K#rowtoprint+startrow#:K#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 11)>
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(L#rowtoprint+startrow#:L#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 12)>
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(M#rowtoprint+startrow#:M#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 13)>
                    
                <cfset actualsumcell = actualsumcell&"+K#rowtoprint+startrow+currentrow-1#">
                    
                <cfset advancesumcell = advancesumcell&"+L#rowtoprint+startrow+currentrow-1#">
                <!---Add body items--->     
                        
                <!---Format Table--->  
                <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+startrow+currentrow-1, 8, rowtoprint+startrow+currentrow-1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint, 8, rowtoprint, 13)>                
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+1, 8, rowtoprint+1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s63, rowtoprint+2, 11, rowtoprint+2, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+2, 8, rowtoprint+2, 10)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+3, 8, rowtoprint+3, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+4, 8, rowtoprint+startrow+currentrow-2, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint, 8, rowtoprint+2, 13)>  
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+3, 13, rowtoprint+startrow+currentrow-1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+startrow+currentrow-1, 11, rowtoprint+startrow+currentrow-1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+3, 11, rowtoprint+startrow+currentrow, 13)>
                <!---Format Header--->
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint, 8, rowtoprint+startrow+currentrow-1, 9)>
        
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-1, 10, rowtoprint+startrow-1, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-2, 10, rowtoprint+startrow-2, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 11, rowtoprint+startrow-3, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 8, rowtoprint+startrow-3, 9)>
                <!---End Format Header--->
                <!---Format Table--->    

                <cfset rowtoprint += (listlen(itemlist)+7)>
            </cfif>
                
        </cfif>
    </cfloop>
                    
    <cfif getregion.recordcount mod 2 eq 1>
        <cfset rowtoprint += (listlen(itemlist)+7)>
    </cfif>
                            
    <!---Signature Area---> 
    <cfset spreadsheetAddColumn(secondpage, "Prepared By:", rowtoprint+1, 1, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Verified By:", rowtoprint+11, 1, false)>
    <cfset spreadsheetAddColumn(secondpage, "Checked & Verified By:", rowtoprint+21, 1, false)>
    <cfset spreadsheetAddColumn(secondpage, "2nd Approved By:", rowtoprint+31, 1, false)>
        
    <cfset position = "3,13,23,33">
        
    <cfloop index="a" list="#position#">
        <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+a, 5, false)>
    </cfloop>
            
    <cfset spreadsheetAddColumn(secondpage, "Janet Leong", rowtoprint+8, 3, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Payroll & Billing Executive", rowtoprint+9, 3, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "#dateformat(createdate(getmmonth.myear,form.period,28),'d-mmm-yy')#", rowtoprint+7, 5, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Piriya Rajikeli", rowtoprint+18, 3, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Manager Pay and Bill", rowtoprint+19, 3, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "#dateformat(createdate(getmmonth.myear,form.period,28),'d-mmm-yy')#", rowtoprint+17, 5, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Joey Wong", rowtoprint+28, 3, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Payroll & Administrative Executive", rowtoprint+29, 3, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Nur Haida Binti Mohd Khalid", rowtoprint+38, 3, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Compensation & Benefits Manager (MY/SG)", rowtoprint+39, 3, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Actual Amount", rowtoprint+1, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "#acttotalwgst#", rowtoprint+1, 11, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Advance Billing", rowtoprint+2, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "#tBillingGST#", rowtoprint+2, 11, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Total Amount Due to MP", rowtoprint+4, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "#val(acttotalwgst)-val(tBillingGST)#", rowtoprint+4, 11, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "BREAKDOWN SUMMARY FOR TOTAL AMOUNT DUE TO MP - BY REGION", rowtoprint+8, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "No.", rowtoprint+9, 9, false)>
    <cfset spreadsheetAddColumn(secondpage, "By Region", rowtoprint+9, 10, false)>
    <cfset spreadsheetAddColumn(secondpage, "HEADCOUNT", rowtoprint+9, 11, false)>
    <cfset spreadsheetAddColumn(secondpage, "Total", rowtoprint+9, 12, false)>
        
    <cfloop index="a" from="1" to="#getregion.recordcount#">
        <cfset spreadsheetAddColumn(secondpage, "#a#", rowtoprint+9+a, 9, false)>
    </cfloop>
        
    <cfset theadcount = 0>
    <cfset totalbilling = 0>
        
    <cfloop query="getregion">
        <cfset spreadsheetAddColumn(secondpage, "#getregion.workordid#", rowtoprint+9+getregion.currentrow, 10, false)>  
        <cfset spreadsheetAddColumn(secondpage, "#getregion.c#", rowtoprint+9+getregion.currentrow, 11, false)>
        <!---<cfset spreadsheetAddColumn(secondpage, "#getregion.TotalBillingGST#", rowtoprint+9+getregion.currentrow, 12, false)>--->
        <cfset spreadsheetSetCellFormula(secondpage, "#listGetAt(replacenocase(replacenocase(actualsumcell,'D','F','all'),'K','M','all'),getregion.currentrow,'+')#", rowtoprint+9+getregion.currentrow, 12)><!---Total for each region in Breakdown section--->
            
        <cfset theadcount += val(getregion.c)>
            
        <cfset totalbilling += val(getregion.TotalBillingGST)>
        
    </cfloop>
            
    <cfset spreadsheetAddColumn(secondpage, "TOTAL", rowtoprint+9+getregion.recordcount+1, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "#theadcount#", rowtoprint+9+getregion.recordcount+1, 11, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "#totalbilling#", rowtoprint+9+getregion.recordcount+1, 12, false)>
        
    <cfset spreadsheetSetCellFormula(secondpage, "SUM(K#rowtoprint+10#:K#rowtoprint+9+getregion.recordcount#)", rowtoprint+9+getregion.recordcount+1, 11)>
        
    <cfset spreadsheetSetCellFormula(secondpage, "SUM(L#rowtoprint+10#:L#rowtoprint+9+getregion.recordcount#)", rowtoprint+9+getregion.recordcount+1, 12)>
        
    <cfset spreadsheetAddColumn(secondpage, "1st Approved By:", rowtoprint+24, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Jasmine Teo", rowtoprint+27, 11, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Retail HR Manager", rowtoprint+28, 11, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+26, 13, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Division Controller (CPD) :", rowtoprint+30, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Luke Tan ", rowtoprint+36, 11, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+35, 13, false)>
        
    <cfset spreadsheetSetCellFormula(secondpage, "ROUND((#actualsumcell#),2)", rowtoprint+1, 11)>
        
    <cfset spreadsheetSetCellFormula(secondpage, "#advancesumcell#", rowtoprint+2, 11)>
        
    <cfset spreadsheetSetCellFormula(secondpage, "K#rowtoprint+1# - K#rowtoprint+2#", rowtoprint+4, 11)>
        
    <!---anchor: startRow,startColumn,endRow,endColumn--->
    <cfset imagepath1 = "#hrootpath#/latest/reports/AdvanceBilling/Signature1.PNG">
        
    <cfset imagepath2 = "#hrootpath#/latest/reports/AdvanceBilling/Signature2.PNG">
        
    <cfset SpreadsheetAddImage(secondpage,"#imagepath1#","#rowtoprint+3#,3,#rowtoprint+7#,4")>

    <cfset SpreadsheetAddImage(secondpage,"#imagepath2#","#rowtoprint+14#,3,#rowtoprint+18#,4")>
        
    <!---End Signature Area--->
        
    <!---Last Format Table--->
    <cfset SpreadSheetFormatCellRange(secondpage, s39, 1, 1, 1, 1)>   
    <cfset SpreadSheetFormatCellRange(secondpage, s50, 1, 12, 1, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+8, 9, rowtoprint+9, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+9, 9, rowtoprint+9+getregion.recordcount, 9)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+9, 11, rowtoprint+9+getregion.recordcount+1, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+9+getregion.recordcount+1, 11, rowtoprint+9+getregion.recordcount+1, 12)>
       
    <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+1, 11, rowtoprint+2, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+4, 11, rowtoprint+4, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+4, 11, rowtoprint+4, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s60, rowtoprint+5, 11, rowtoprint+5, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+9, 12, rowtoprint+10+getregion.recordcount, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+8, 9, rowtoprint+9+getregion.recordcount, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+8, 9, rowtoprint+9+getregion.recordcount, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+10+getregion.recordcount, 9, rowtoprint+10+getregion.recordcount, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+8, 3, rowtoprint+8, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+8, 5, rowtoprint+8, 5)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+18, 3, rowtoprint+18, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+18, 5, rowtoprint+18, 5)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+28, 3, rowtoprint+28, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+28, 5, rowtoprint+28, 5)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+38, 3, rowtoprint+38, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+38, 5, rowtoprint+38, 5)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+27, 11, rowtoprint+27, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+36, 11, rowtoprint+36, 11)>
    <!---spreadsheetMergeCells(spreadsheetObj, startrow, endrow, startcolumn, endcolumn)--->
    
    <cfset spreadsheetMergeCells(secondpage, rowtoprint+8, rowtoprint+8, 9, 12)>
        
    <cfset cellwidth = "8,10,33,18,12,15">
    <cfset checkpoint = 1>
        
    <cfloop index="i" from="0" to="2">
        <cfif checkpoint neq 7>
            <cfloop index="ii" list="#cellwidth#">
                <cfset spreadsheetSetColumnWidth(secondpage, checkpoint, ii) >
                <cfset checkpoint += 1>
            </cfloop>
        <cfelse>
            <cfset spreadsheetSetColumnWidth(secondpage, checkpoint, 3) >
            <cfset checkpoint += 1>
        </cfif>
    </cfloop>
    <!---Last Format Table--->
        
    <cfspreadsheet action="write" sheetname="Reconciliation report" filename="#HRootPath#\Excel_Report\Loreal_Reconciliation_#timenow#.xlsx" name="secondpage" overwrite="true"> 
        
    <cfif isdefined('secondpage')>
        <cfset StructDelete(Variables,"secondpage")>
    </cfif>
        
    <cfset filename = "Reconciliation report #thisperiod# #getmmonth.myear#_#timenow#">
        
<!---Add 2nd sheets--->
        
<cfelse> 
                
<cfquery name="getdata" datasource="#dts#">
SELECT *,coalesce(backa.backpay,0) as BackPaySalary, (coalesce(xGrossWage,0) + coalesce(backa.backpay,0)) as GrossWage
FROM 
(
    SELECT 
    case when count(aa.placementno) > 1 then group_concat(aa.placementno) else aa.placementno end current_jo,
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
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dcomm,'1900-01-01')+2 dcomm,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dresign,'1900-01-01')+2 dresign,
    a3.lorealremarks daysworked,
    sum(case when not (coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200 or coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160) then coalesce(a3.custsalary,0) else 0 end) as BasicRate,

    sum(case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200 then coalesce(a3.custsalaryday,0) else 0 end) totalnormalday,<!---Total Normal Working Days--->
    (case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = round(200/8,2) or coalesce(a3.custusualpay,0) = 200 then coalesce(a3.custusualpay,0) else 0 end) normalrate,<!---Working on Normal day --->
    sum(
        case when coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 115 then coalesce(a3.custsalary,0) else 0 end + case when not (coalesce(a3.custusualpay,0) = 115/8 or coalesce(a3.custusualpay,0) = round(115/8,2) or coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 115 or coalesce(a3.custusualpay,0) = 165 or coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 or coalesce(a3.custusualpay,0) = 1000)  then coalesce(a3.custsalary,0) else 0 end
    ) totalnormal,<!---Total Normal --->

    sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalaryday,0) else 0 end) total_concourse_day,<!---Total Concourse Days--->
    (case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custusualpay,0) else 0 end) working_concourse,<!---Working on Concourse day --->
    sum(case when coalesce(a3.custusualpay,0) = 165/8 or coalesce(a3.custusualpay,0) = round(165/8,2) or coalesce(a3.custusualpay,0) = 165 then coalesce(a3.custsalary,0) else 0 end) total_concourse,<!---Total Concourse --->    

    sum(case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custsalaryday,0) else 0 end) total_day_ph,
    (case when coalesce(a3.custusualpay,0) = 160/8 or coalesce(a3.custusualpay,0) = round(160/8,2) or coalesce(a3.custusualpay,0) = 160 then coalesce(a3.custusualpay,0) else 0 end) working_ph,
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
    ppl.po_no,
    aa.invoiceno

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
    <!---AND custtotalgross--->
    AND month(completedate) <> #form.period# AND jtitle="Maternity Replacement"
    GROUP BY aa.empno
) backa
ON a.empno=backa.empno

GROUP BY a.empno
ORDER BY workordid,a.empno
</cfquery>
        
<cfset secondpage = SpreadSheetNew(true)> 
    
<!---Header--->
    
<cfset SpreadSheetAddRow(secondpage, "Manpower Business Solutions (M) Sdn Bhd")>
    
<cfset SpreadSheetAddRow(secondpage, ",,")><!--empty line--->
    
<cfset SpreadSheetAddRow(secondpage, "Part Timer Cycle 1")>
    
<cfset spreadsheetAddColumn(secondpage, "Comm/Inct Report frm Brand", 1, 11, false)>

<cfset spreadsheetAddColumn(secondpage, "Manpower payroll month", 2, 11, false)>
    
<cfset spreadsheetAddColumn(secondpage, "Invoices to L'Oreal", 3, 11, false)>
    
<cfset spreadsheetAddColumn(secondpage, "#lastperiod#-#right(getmmonth.myear,2)#", 1, 12, false)>

<cfset spreadsheetAddColumn(secondpage, "#lastperiod#-#right(getmmonth.myear,2)#", 2, 12, false)>
    
<cfset spreadsheetAddColumn(secondpage, "#thisperiod#-#right(getmmonth.myear,2)#", 3, 12, false)>
    
<!---End Header--->
    
<!---Body Data--->
    
<cfset itemlist = "Wages,Backpay Salary,Expenses,UPL,Incentive,Overtime,EPF,Socso,EIS">
    
<cfset ramtlist = "rtbasic,rtbackpay,empty,rtupl,rtincentive,rtottotal,rtepf,rtsocso,rteis,rtadmin,rtGst,rtBillingGST">  

<cfquery name="getregion" dbtype="query">
    SELECT workordid,count(empno) c,sum(TotalBill) TotalBillingGST FROM getdata
    WHERE workordid != ''
    GROUP BY workordid
</cfquery>

<cfif getregion.recordcount neq 0>
    
    <cfif getregion.workordid neq ''>
    
        <cfset headerlist1 = "GL CODE,FIN CODE,Description :,LMSB,MANPOWER,Variance">

        <cfset headerlistarray1 = listtoarray(headerlist1)>

        <cfset headerlist2 = " , ,HEADCOUNT,PO No.,Inv No.,DN/CN No.">

        <cfset headerlistarray2 = listtoarray(headerlist2)>

        <cfset itemlistarray = listtoarray(itemlist)>

        <cfset adminfeeline = "707150,200-1101,Admin Fee,0">

        <cfset adminfeelinearray = listtoarray(adminfeeline)>

        <cfset gstline = "306020,200-1101,GST,0">

        <cfif getmmonth.myear gte 2018 and form.period gte 6 and form.period lte 8>
            <cfset gstline = "306020,200-1101,GST,0">
        <cfelseif getmmonth.myear lte 2018 and form.period lte 6>
            <cfset gstline = "306020,200-1101,GST (6%),0">
        <cfelse>
            <cfset gstline = "707150,200-1101,SST (6%),0">
        </cfif>

        <cfset gstlinearray = listtoarray(gstline)>

        <cfset processingfeeline = "707150,200-1101,Processing Fee,0">

        <cfset tablewidth = 1>

        <cfset rowtoprint = 6>

        <cfset advancesumcell = "">
        
        <cfset empty = 0>

        <cfloop query="getregion">
            
            <cfquery name="getregiondata" dbtype="query">
                SELECT * FROM getdata
                WHERE workordid='#getregion.workordid#'
            </cfquery> 
            
            <cfset headerlist3 = " , ,#getregiondata.recordcount#,#getregiondata.po_no#,#getregiondata.invoiceno#,0">
        
            <cfset headerlistarray3 = listtoarray(headerlist3)>

            <cfset rtbasic = 0> 
            <cfset rtbackpay = 0> 
            <cfset rtupl = 0> 
            <cfset rtincentive = 0> 
            <cfset rtottotal = 0> 
            <cfset rtepf = 0>
            <cfset rtsocso = 0>
            <cfset rteis = 0>
            <cfset rtadmin = 0>
            <cfset rtGst = 0>
            <cfset rtBillingGST = 0>    

            <cfloop query="getregiondata">
                <cfset rtbasic = rtbasic + val(BasicWage)> 
                <cfset rtbackpay = rtbackpay + val(BackPaySalary)> 
                <cfset rtupl = rtupl + val(UPL)> 
                <cfset rtincentive = rtincentive + val(Incentive)> 
                <cfset rtottotal = rtottotal + val(custottotal)> 
                <cfset rtepf = rtepf + val(custcpf)> 
                <cfset rtsocso = rtsocso + val(custsdf)> 
                <cfset rteis = rteis + val(custeis)> 
                <cfset rtadmin = rtadmin + val(AdminFee)> 
                <cfset rtGst = rtGst + val(GST)> 
                <cfset rtBillingGST = rtBillingGST + val(TotalBill)>   
            </cfloop>

            <cfif getregion.currentrow mod 2 eq 1>
                <cfloop index="i" from="1" to="#listlen(headerlist1)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray1[i]#", rowtoprint, 0+i, false)>
                </cfloop>
                <cfset spreadsheetAddColumn(secondpage, "Description : #getregion.workordid#", rowtoprint, 3, false)>

                <cfloop index="i" from="1" to="#listlen(headerlist2)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray2[i]#", rowtoprint+1, 0+i, false)>
                </cfloop>

                <cfloop index="i" from="1" to="#listlen(headerlist3)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray3[i]#", rowtoprint+2, 0+i, false)>
                </cfloop>

                <!---Add body items--->                    
                <cfloop index="i" from="1" to="#listlen(itemlist)#">
                    <cfset spreadsheetAddColumn(secondpage, "#itemlistarray[i]#", rowtoprint+2+i, 3, false)>
                </cfloop>

                <cfset last2row = rowtoprint+2+listlen(itemlist)>    

                <cfloop index="i" from="1" to="#listlen(adminfeeline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#adminfeelinearray[i]#", last2row+1, 0+i, false)>
                </cfloop>

                <cfloop index="i" from="1" to="#listlen(gstline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#gstlinearray[i]#", last2row+2, 0+i, false)>
                </cfloop>

                <cfset startrow = 3>
                <cfset currentrow = 0>

                <cfloop index="a" list="#ramtlist#">        
                    <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
                    <cfif currentrow lt listlen(ramtlist)-3>
                        <cfset spreadsheetAddColumn(secondpage, "701370", rowtoprint+startrow+currentrow, 1, false)>
                        <cfset spreadsheetAddColumn(secondpage, "200-1101", rowtoprint+startrow+currentrow, 2, false)>
                    </cfif>
                    <cfset spreadsheetAddColumn(secondpage, "0", rowtoprint+startrow+currentrow, 4, false)>
                    <cfset spreadsheetAddColumn(secondpage, "#evaluate(a)#", rowtoprint+startrow+currentrow, 5, false)>
                    <!---<cfset spreadsheetAddColumn(secondpage, "#evaluate('#replace(a,'rt','ract')#') - evaluate(a)#", rowtoprint+startrow+currentrow, 6, false)>--->
                    <cfset spreadsheetSetCellFormula(secondpage, "E#rowtoprint+startrow+currentrow# - D#rowtoprint+startrow+currentrow#", rowtoprint+startrow+currentrow, 6)>


                     <cfset currentrow += 1>
                </cfloop>  

                <cfset spreadsheetSetCellFormula(secondpage, "SUM(D#rowtoprint+startrow#:D#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 4)> 
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(E#rowtoprint+startrow#:E#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 5)>
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(F#rowtoprint+startrow#:F#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 6)>

                <cfif advancesumcell eq "">
                    <cfset advancesumcell = "E#rowtoprint+startrow+currentrow-1#">
                <cfelse>
                    <cfset advancesumcell = advancesumcell&"+E#rowtoprint+startrow+currentrow-1#">
                </cfif>
                <!---Add body items--->

                <!---Format Table--->  
                <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+startrow+currentrow-1, 1, rowtoprint+startrow+currentrow-1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint, 1, rowtoprint, 6)>                
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+1, 1, rowtoprint+1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s63, rowtoprint+2, 4, rowtoprint+2, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+2, 1, rowtoprint+2, 3)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+3, 1, rowtoprint+3, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+4, 1, rowtoprint+startrow+currentrow-2, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint, 1, rowtoprint+2, 6)>  
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+3, 6, rowtoprint+startrow+currentrow-1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+startrow+currentrow-1, 4, rowtoprint+startrow+currentrow-1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+3, 4, rowtoprint+startrow+currentrow-3, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s69, rowtoprint+startrow+currentrow-2, 4, rowtoprint+startrow+currentrow, 6)>
                <!---Format Header--->
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint, 1, rowtoprint+startrow+currentrow-1, 2)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-1, 3, rowtoprint+startrow-1, 6)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-2, 3, rowtoprint+startrow-2, 6)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 4, rowtoprint+startrow-3, 6)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 1, rowtoprint+startrow-3, 2)>
                <!---End Format Header--->
                <!---Format Table--->        

            <cfelse>
                <cfloop index="i" from="1" to="#listlen(headerlist1)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray1[i]#", rowtoprint, 7+i, false)>
                </cfloop>
                <cfset spreadsheetAddColumn(secondpage, "Description : #getregion.workordid#", rowtoprint, 10, false)>

                <cfloop index="i" from="1" to="#listlen(headerlist2)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray2[i]#", rowtoprint+1, 7+i, false)>
                </cfloop>

                <cfloop index="i" from="1" to="#listlen(headerlist3)#">
                    <cfset spreadsheetAddColumn(secondpage, "#headerlistarray3[i]#", rowtoprint+2, 7+i, false)>
                </cfloop>

                <!---Add body items--->
                <cfloop index="i" from="1" to="#listlen(itemlist)#">
                    <cfset spreadsheetAddColumn(secondpage, "#itemlistarray[i]#", rowtoprint+2+i, 10, false)>
                </cfloop>

                <cfset last2row = rowtoprint+2+listlen(itemlist)>    

                <cfloop index="i" from="1" to="#listlen(adminfeeline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#adminfeelinearray[i]#", last2row+1, 7+i, false)>
                </cfloop>

                <cfloop index="i" from="1" to="#listlen(gstline)#">
                    <cfset spreadsheetAddColumn(secondpage, "#gstlinearray[i]#", last2row+2, 7+i, false)>
                </cfloop>

                <cfset startrow = 3>
                <cfset currentrow = 0>

                <cfloop index="a" list="#ramtlist#">        
                    <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
                    <cfif currentrow lt listlen(ramtlist)-3>
                        <cfset spreadsheetAddColumn(secondpage, "701370", rowtoprint+startrow+currentrow, 8, false)>
                        <cfset spreadsheetAddColumn(secondpage, "200-1101", rowtoprint+startrow+currentrow, 9, false)>
                    </cfif>
                    <cfset spreadsheetAddColumn(secondpage, "0", rowtoprint+startrow+currentrow, 11, false)>
                    <cfset spreadsheetAddColumn(secondpage, "#evaluate(a)#", rowtoprint+startrow+currentrow, 12, false)>
                    <!---<cfset spreadsheetAddColumn(secondpage, "#evaluate('#replace(a,'rt','ract')#') - evaluate(a)#", rowtoprint+startrow+currentrow, 13, false)>--->
                    <cfset spreadsheetSetCellFormula(secondpage, "L#rowtoprint+startrow+currentrow# - K#rowtoprint+startrow+currentrow#", rowtoprint+startrow+currentrow, 13)>

                     <cfset currentrow += 1>
                </cfloop> 

                <cfset spreadsheetSetCellFormula(secondpage, "SUM(K#rowtoprint+startrow#:K#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 11)> 
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(L#rowtoprint+startrow#:L#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 12)>
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(M#rowtoprint+startrow#:M#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 13)>

                <cfset advancesumcell = advancesumcell&"+L#rowtoprint+startrow+currentrow-1#">
                <!---Add body items--->     

                <!---Format Table--->  
                <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+startrow+currentrow-1, 8, rowtoprint+startrow+currentrow-1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint, 8, rowtoprint, 13)>                
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+1, 8, rowtoprint+1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s63, rowtoprint+2, 11, rowtoprint+2, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+2, 8, rowtoprint+2, 10)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+3, 8, rowtoprint+3, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+4, 8, rowtoprint+startrow+currentrow-2, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint, 8, rowtoprint+2, 13)>  
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+3, 13, rowtoprint+startrow+currentrow-1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+startrow+currentrow-1, 11, rowtoprint+startrow+currentrow-1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+3, 11, rowtoprint+startrow+currentrow-3, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s69, rowtoprint+startrow+currentrow-2, 11, rowtoprint+startrow+currentrow, 13)>
                <!---Format Header--->
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint, 8, rowtoprint+startrow+currentrow-1, 9)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-1, 10, rowtoprint+startrow-1, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-2, 10, rowtoprint+startrow-2, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 11, rowtoprint+startrow-3, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 8, rowtoprint+startrow-3, 9)>
                <!---End Format Header--->
                <!---Format Table--->    

                <cfset rowtoprint += (listlen(itemlist)+7)>
                
            </cfif>
                
            <!---<cfif getregion.recordcount eq 1>
                <cfset rowtoprint += (listlen(itemlist)+7)>
            </cfif>--->

        </cfloop>
                    
        <cfif getregion.recordcount mod 2 eq 1>
            <cfset rowtoprint += (listlen(itemlist)+7)>
        </cfif>
                    
        <!---Signature Area---> 
        <cfset spreadsheetAddColumn(secondpage, "Prepared By:", rowtoprint+1, 1, false)> 
        <cfset spreadsheetAddColumn(secondpage, "Verified By:", rowtoprint+9, 1, false)>
        <cfset spreadsheetAddColumn(secondpage, "Checked & Verified By:", rowtoprint+17, 1, false)>
        <cfset spreadsheetAddColumn(secondpage, "2nd Approved By:", rowtoprint+26, 1, false)>

        <cfset position = "1,9,17,26">

        <cfloop index="a" list="#position#">
            <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+a, 5, false)>
        </cfloop>
            
        <cfset spreadsheetAddColumn(secondpage, "Janet Leong", rowtoprint+6, 3, false)> 
        <cfset spreadsheetAddColumn(secondpage, "Payroll & Billing Executive", rowtoprint+7, 3, false)> 
            
        <cfset spreadsheetAddColumn(secondpage, "#dateformat(createdate(getmmonth.myear,form.period,28),'d-mmm-yy')#", rowtoprint+5, 5, false)> 

        <cfset spreadsheetAddColumn(secondpage, "Piriya Rajikeli", rowtoprint+14, 3, false)> 
        <cfset spreadsheetAddColumn(secondpage, "Manager Pay and Bill", rowtoprint+15, 3, false)> 
            
        <cfset spreadsheetAddColumn(secondpage, "#dateformat(createdate(getmmonth.myear,form.period,28),'d-mmm-yy')#", rowtoprint+13, 5, false)> 

        <cfset spreadsheetAddColumn(secondpage, "Joey Wong", rowtoprint+22, 3, false)> 
        <cfset spreadsheetAddColumn(secondpage, "Payroll & Administrative Executive", rowtoprint+23, 3, false)> 

        <cfset spreadsheetAddColumn(secondpage, "Nur Haida Binti Mohd Khalid", rowtoprint+31, 3, false)> 
        <cfset spreadsheetAddColumn(secondpage, "Compensation & Benefits Manager (MY/SG)", rowtoprint+32, 3, false)> 
            
        <cfset spreadsheetAddColumn(secondpage, "Total Partimer Wages", rowtoprint+1, 9, false)>
            
        <cfset spreadsheetSetCellFormula(secondpage, "#advancesumcell#", rowtoprint+1, 12)>
            
        <cfset spreadsheetAddColumn(secondpage, "Invoice to LMSD", rowtoprint+3, 9, false)>
            
        
            
        <cfset spreadsheetAddColumn(secondpage, "INVOICE SUMMARY FOR PARTIMER WITH STATUTORY DEDUCTION", rowtoprint+5, 8, false)>
        
        <cfset spreadsheetAddColumn(secondpage, "No.", rowtoprint+6, 8, false)>
        <cfset spreadsheetAddColumn(secondpage, "Invoice No.", rowtoprint+6, 9, false)>
        <cfset spreadsheetAddColumn(secondpage, "Brand", rowtoprint+6, 11, false)>
        <cfset spreadsheetAddColumn(secondpage, "Total", rowtoprint+6, 13, false)>

        <cfloop index="a" from="1" to="#getregion.recordcount#">
            <cfset spreadsheetAddColumn(secondpage, "#a#", rowtoprint+6+a, 8, false)>
        </cfloop>

        <cfset theadcount = 0>
        <cfset totalbilling = 0>

        <cfloop query="getregion">
            <cfset spreadsheetAddColumn(secondpage, "TEMPLO0415-#getregion.workordid#", rowtoprint+6+getregion.currentrow, 9, false)>  
            <cfset spreadsheetAddColumn(secondpage, "#getregion.workordid#", rowtoprint+6+getregion.currentrow, 11, false)>
            <cfset spreadsheetAddColumn(secondpage, "#getregion.c#", rowtoprint+6+getregion.currentrow, 12, false)>
            <!---<cfset spreadsheetAddColumn(secondpage, "#getregion.TotalBillingGST#", rowtoprint+9+getregion.currentrow, 12, false)>--->
            <cfset spreadsheetSetCellFormula(secondpage, "#listGetAt(replacenocase(replacenocase(advancesumcell,'D','F','all'),'K','M','all'),getregion.currentrow,'+')#", rowtoprint+6+getregion.currentrow, 13)><!---Total for each region in Breakdown section--->

            <cfset theadcount += val(getregion.c)>

            <cfset totalbilling += val(getregion.TotalBillingGST)>
                
            <cfset spreadsheetMergeCells(secondpage, rowtoprint+6+getregion.currentrow, rowtoprint+6+getregion.currentrow, 9, 10)>

        </cfloop>
                
        <cfset spreadsheetAddColumn(secondpage, "TOTAL", rowtoprint+6+getregion.recordcount+1, 9, false)>
            
        <cfset spreadsheetSetCellFormula(secondpage, "SUM(L#rowtoprint+7#:L#rowtoprint+6+getregion.recordcount#)", rowtoprint+6+getregion.recordcount+1, 12)>
        
        <cfset spreadsheetSetCellFormula(secondpage, "SUM(M#rowtoprint+7#:M#rowtoprint+6+getregion.recordcount#)", rowtoprint+6+getregion.recordcount+1, 13)>

        <cfset spreadsheetSetCellFormula(secondpage, "M#rowtoprint+6+getregion.recordcount+1#", rowtoprint+3, 12)>
            
        <cfset spreadsheetAddColumn(secondpage, "1st Approved By:", rowtoprint+17, 8, false)>
        
        <cfset spreadsheetAddColumn(secondpage, "Jasmine Teo", rowtoprint+22, 10, false)> 
        <cfset spreadsheetAddColumn(secondpage, "Retail HR Manager", rowtoprint+23, 10, false)>

        <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+17, 12, false)>

        <cfset spreadsheetAddColumn(secondpage, "Division Controller (CPD) :", rowtoprint+26, 8, false)>

        <cfset spreadsheetAddColumn(secondpage, "Luke Tan ", rowtoprint+31, 10, false)> 

        <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+26, 12, false)>
            
        <!---anchor: startRow,startColumn,endRow,endColumn--->
        <cfset imagepath1 = "#hrootpath#/latest/reports/AdvanceBilling/Signature1.PNG">

        <cfset imagepath2 = "#hrootpath#/latest/reports/AdvanceBilling/Signature2.PNG">

        <cfset SpreadsheetAddImage(secondpage,"#imagepath1#","#rowtoprint+2#,3,#rowtoprint+6#,4")>

        <cfset SpreadsheetAddImage(secondpage,"#imagepath2#","#rowtoprint+10#,3,#rowtoprint+14#,4")>
            
        <!---End Signature Area--->
            
        <!--Format data--->
        
        <cfset SpreadSheetFormatCellRange(secondpage, s50, 1, 1, 3, 1)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+6, 8, rowtoprint+6+getregion.recordcount, 8)>
        
        <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+6, 11, rowtoprint+6+getregion.recordcount+1, 11)>

        <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+6+getregion.recordcount+1, 9, rowtoprint+6+getregion.recordcount+1, 13)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+3, 12, rowtoprint+3, 12)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s60, rowtoprint+4, 12, rowtoprint+4, 12)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s66, 1, 11, 3, 11)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+5, 8, rowtoprint+6, 13)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s68, rowtoprint+5, 8, rowtoprint+6, 13)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s69, rowtoprint+6, 13, rowtoprint+6+getregion.recordcount, 13)><!---Individual Line of regions under INVOICE SUMMARY FOR PARTIMER WITH STATUTORY DEDUCTION--->
            
        <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+7+getregion.recordcount, 13, rowtoprint+7+getregion.recordcount, 13)><!---Line of Total all Region under INVOICE SUMMARY FOR PARTIMER WITH STATUTORY DEDUCTION--->
            
        <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+1, 12, rowtoprint+1, 12)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+3, 12, rowtoprint+3, 12)>
        
        <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+5, 8, rowtoprint+6+getregion.recordcount, 13)>

        <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+5, 8, rowtoprint+6+getregion.recordcount, 13)>

        <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+7+getregion.recordcount, 8, rowtoprint+7+getregion.recordcount, 13)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+6, 3, rowtoprint+6, 3)>
        
        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+6, 5, rowtoprint+6, 5)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+14, 3, rowtoprint+14, 3)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+14, 5, rowtoprint+14, 5)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+22, 3, rowtoprint+22, 3)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+22, 5, rowtoprint+22, 5)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+31, 3, rowtoprint+31, 3)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+31, 5, rowtoprint+31, 5)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+22, 10, rowtoprint+22, 10)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+22, 12, rowtoprint+22, 12)>

        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+31, 10, rowtoprint+31, 10)>
            
        <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint+31, 12, rowtoprint+31, 12)>
            
        <!---spreadsheetMergeCells(spreadsheetObj, startrow, endrow, startcolumn, endcolumn)--->
    
        <cfset spreadsheetMergeCells(secondpage, rowtoprint+5, rowtoprint+5, 8, 13)>
            
        <cfset spreadsheetMergeCells(secondpage, rowtoprint+6, rowtoprint+6, 9, 10)>
            
        <cfset spreadsheetMergeCells(secondpage, rowtoprint+7+getregion.recordcount, rowtoprint+7+getregion.recordcount, 9, 10)>
            
        <cfset cellwidth = "8,10,33,18,12,15">
        <cfset checkpoint = 1>

        <cfloop index="i" from="0" to="2">
            <cfif checkpoint neq 7>
                <cfloop index="ii" list="#cellwidth#">
                    <cfset spreadsheetSetColumnWidth(secondpage, checkpoint, ii) >
                    <cfset checkpoint += 1>
                </cfloop>
            <cfelse>
                <cfset spreadsheetSetColumnWidth(secondpage, checkpoint, 3) >
                <cfset checkpoint += 1>
            </cfif>
        </cfloop>
            
        <!--End Format data--->    

        <cfspreadsheet action="write" sheetname="Reconciliation report" filename="#HRootPath#\Excel_Report\Loreal_Reconciliation_#timenow#.xlsx" name="secondpage" overwrite="true"> 

        <cfif isdefined('secondpage')>
            <cfset StructDelete(Variables,"secondpage")>
        </cfif>
            
    </cfif>
        
</cfif>
<!---Body Data--->
                
<cfset filename = "PO Wages Part Timer Cycle_ temp BA #thisperiod# #getmmonth.myear#_#timenow#">
    
<!---Add 2nd sheets--->
    
</cfif>
        
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
<cfif fileExists("#HRootPath#\Excel_Report\Loreal_Reconciliation_#timenow#.xlsx") eq false>
    
    <script>
        alert("No File Generated due to no data for the selected month.");
        window.close();
    </script>
    <cfabort>
        
</cfif>
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#HRootPath#\Excel_Report\Loreal_Reconciliation_#timenow#.xlsx">
    
</cfoutput>