<!---Loreal Report Version 3.0 with formula added--->

<cfoutput>
    
<cfset dts_p = replace(dts,'_i','_p')>
    
<cfquery name="getComp_qry" datasource="#dts#">
	SELECT * FROM gsetup
</cfquery>
    
<cfquery name="getmmonth" datasource="#dts#">
    SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
    
<cfset sys_date = Createdate(getmmonth.MYEAR,getmmonth.MMONTH,1)>
    
<!---Prepare temp excel file to write data--->
<cfset currentDirectory = "#Hrootpath#\Excel_Report\">
    
<cfset timenow = "#DateTimeFormat(now(), 'yyyymmddhhnnss')#">
    
<cfif DirectoryExists(currentDirectory) eq false>
    <cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<!---Prepare temp excel file to write data--->
    
<!---Prepare period wording--->
<cfset thisperiod = ucase(left(monthAsString(form.period),3))>
    
<cfset lastperiod = form.period-1>
<cfset lastyear = getmmonth.myear>    

<cfif form.period eq 1>
    <cfset lastperiod = 12>
    <cfset lastyear = getmmonth.myear-1>
</cfif>
        
<cfset lastperiodnum = lastperiod>
    
<cfset nextperiod = form.period+1>
<cfset nextyear = getmmonth.myear>    

<cfif form.period eq 12>
    <cfset nextperiod = 1>
    <cfset nextyear = getmmonth.myear+1>
</cfif>
        
<cfset nextperiodnum = nextperiod>
    
<cfset nextperiod = ucase(left(monthAsString(nextperiod),3))>
<!---Prepare period wording--->
    
<!---Excel Format--->    
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
<cfset s57.rightborder="thin">
<cfset s57.bold="true">
<cfset s57.alignment="center">
    
<cfset s58 = StructNew()>    
<cfset s58.alignment="left">
<cfset s58.verticalalignment="vertical_center">
<cfset s58.bold="true">
<cfset s58.topborder="thin">
<cfset s58.rightborder="thin">
    
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
    
<cfset s65 = StructNew()>    
<cfset s65.leftborder="medium">
    
<cfset s66 = StructNew()>    
<cfset s66.rightborder="thin">
    
<cfset s67 = StructNew()>
<cfset s67.dataformat="_(* ##,####0.00_);_(* (##,####0.00);_(* \-??_);_(@_)">
    
<cfset s68 = StructNew()>
<cfset s68.dataformat = "d-mmm-yy">
<!---Excel Format--->
    
<!---Added 20180824 by Nieo, to Freeze data after report sent--->

<cfquery name="checklorealadvance" datasource="#dts#">
    SELECT * FROM lorealadvance
    WHERE tmonth=#form.period# and tyear=#getmmonth.myear#
</cfquery>
    
<cfif (day(now()) lte 5 and month(now()) eq form.period) or checklorealadvance.recordcount eq 0>
    
<cfquery name="clearDataForOverwriteSameMonth" datasource="#dts#">
    DELETE FROM lorealadvance
    WHERE tmonth=#form.period# and tyear=#getmmonth.myear#
</cfquery>
                
<cfquery name="setrow" datasource="#dts#">
    set @row=0;
</cfquery>
                
<cfquery name="logdata" datasource="#dts#">
    INSERT INTO lorealadvance
    (tmonth, id, empno, empname, nricn, workordid, DateofHire, DateofCessation, Basic, Incentive, GALLOW, GALLOWAjd, Bonus, ExcellenceAward, LongServiceAward, Shoe, CarMaintenance, UPL, BackPaySalary, BackPayGA, GrossWage, EPFYER, SOCSOYER, EISYER, AdminFee, TotalBilling, GST, TotalBillingGST,tyear)
    SELECT "#form.period#" as tmonth,@row := @row + 1 as row_number,sortquery.*,"#getmmonth.myear#" as tyear 
    FROM (
    SELECT empno,empname,nricn,workordid,DateofHire,DateofCessation,Basic,
    Incentive,GALLOW,0 GALLOWAjd,
    Bonus,
    ExcellenceAward, LongServiceAward,  
    Shoe,
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
        workordid,DATEDIFF(dcomm,'1900-01-01')+2 DateofHire,
        DATEDIFF(dresign,'1900-01-01')+2 DateofCessation,
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
        case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end Shoe,
        <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
        case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end Shoe,
        <cfelse>
            0 Bonus,
            0 Shoe,
        </cfif>
        0 ExcellenceAward, 0 LongServiceAward,
        case when jtitle='Supervisor' then 300 else 0 end CarMaintenance,0 UPL,
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
        case when year(#sys_date#) - year(dbirth) < 60 then
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
        )*0.002
        else 
                0
        end as EISYER,
        <cfif (form.period gte 5 and getmmonth.myear eq 2020) or  getmmonth.myear gt 2020>
            180 AdminFee
        <cfelse>
            80 AdminFee
        </cfif>

        FROM placement pl
        LEFT JOIN #dts_p#.pmast pm
        ON pl.empno=pm.empno
        WHERE jobpostype in (3,5)
        AND workordid != ""
        AND jobstatus=2
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND ((month(dresign)>= #form.period# and year(dresign) >= #getmmonth.myear#) or dresign="0000-00-00") 
        AND cast(employee_rate_1 as decimal(15,5)) <>0
        AND completedate>=#createdate(getmmonth.myear,form.period,1)#
        AND startdate <= #createdate(getmmonth.myear,form.period,10)#
        GROUP BY pl.empno 
        ORDER BY workordid,pl.empno 
        ) aa
    ) sortquery
    ORDER BY row_number
</cfquery>
</cfif>
<!---Added 20180824 by Nieo, to Freeze data after report sent--->
    
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
        workordid,DATEDIFF(dcomm,'1900-01-01')+2 DateofHire,
        DATEDIFF(dresign,'1900-01-01')+2 DateofCessation,
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
        case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end Shoe,
        0 ExcellenceAward, 0 LongServiceAward,
        
        <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
        case when month(dcomm)=#form.period# and year(dcomm)=#getmmonth.myear# or jtitle='Supervisor' then 0 else 60 end Shoe,
        </cfif>
        case when jtitle='Supervisor' then 300 else 0 end CarMaintenance,0 UPL,
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
        case when year(#sys_date#) - year(dbirth) < 60 then
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
            + case when jtitle='Supervisor' then 300 else 0 end <!---Car Maintenance, for Supervisor Only--->
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
        )*0.002
        else 
                0
        end as EISYER,
        <cfif (form.period gte 5 and getmmonth.myear eq 2020) or  getmmonth.myear gt 2020>
            180 AdminFee
        <cfelse>
            80 AdminFee
        </cfif>

        FROM placement pl
        LEFT JOIN #dts_p#.pmast pm
        ON pl.empno=pm.empno
        WHERE jobpostype in (3,5)
        AND workordid != ""
        AND jobstatus=2
        AND (custname like "%l'oreal%"  or custname like "%loreal%")
        AND ((month(dresign)>= #form.period# and year(dresign) >= #getmmonth.myear#) or dresign="0000-00-00") 
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
        <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
            Shoe,
        </cfif>
        CarMaintenance, UPL, BackPaySalary, BackPayGA, GrossWage, EPFYER, SOCSOYER, EISYER, AdminFee, TotalBilling, GST, TotalBillingGST
        FROM lorealadvance
        WHERE tmonth=#form.period# and tyear=#getmmonth.myear#
    </cfquery>
    
</cfif>
                
<cfquery name="getinvoiceno" datasource="#dts#">
    SELECT invoiceno FROM assignmentslip 
    WHERE month(assignmentslipdate)=#form.period#
    AND empname LIKE "%Advance %"
    AND payrollperiod <> 99
    AND custtotalgross > 0
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
<cfelseif form.period eq 7 and getmmonth.myear gt 2018>
    <cfset tshoe = 0>  
</cfif>

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
    <cfset tbasic = tbasic + val(Basic)> 
    <cfset tincentive = tincentive + val(Incentive)> 
    <cfset tgallow = tgallow + val(GALLOW)>          
    <cfset tgallowadj = tgallowadj + val(GALLOWAjd)>          

    <cfif form.period eq 1>
        <cfset tbonus = tbonus + val(Bonus)>  
        <cfset tLongService = tLongService + val(LongServiceAward)>
        <cfset texcellence = texcellence + val(ExcellenceAward)> 
        <cfset tshoe = tshoe + val(Shoe)> 
    <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
        <cfset tshoe = tshoe + val(Shoe)>  
    </cfif>            

    <cfset tcarmain = tcarmain + val(CarMaintenance)> 
    <cfset tupl = tupl + val(UPL)> 
    <cfset tBackPaySalary = tBackPaySalary + val(BackPaySalary)> 
    <cfset tBackPayGA = tBackPayGA + val(BackPayGA)> 
    <cfset tGross = tGross + val(GrossWage)> 
    <cfset tepf = tepf + val(EPFYER)> 
    <cfset tsocso = tsocso + val(SOCSOYER)> 
    <cfset teis = teis + val(EISYER)> 
    <cfset tadmin = tadmin + val(AdminFee)> 
    <cfset tbilling = tbilling + val(TotalBilling)> 
    <cfset tGst = tGst + val(GST)> 
    <cfset tBillingGST = tBillingGST + val(TotalBillingGST)>   
</cfloop>
        
<!---Total line process--->
        
<cfset checkfilename = "#HRootPath#\Excel_Report\Loreal_Advance_Billing_#timenow#.xlsx">
  
<!---Add 1st sheets--->
    
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

    <cfset itemlist = itemlist&",Incentive,Car Maintenance,Misc Expenses,Overtime,No Pay Leave,Backpay Overtime,Backpay Salary,Backpay Grooming Allowance,Notice in Lieu,EPF,Socso,EIS">

<cfelseif form.period eq 7 and getmmonth.myear gt 2018>
    <cfset itemlist = "Basic Salary,Grooming Allowance,Grooming Allowance - Adjustment">

    <cfif tshoe neq 0>
        <cfset itemlist = itemlist&",Shoe">
    </cfif>

    <cfset itemlist = itemlist&",Incentive,Car Maintenance,Misc Expenses,Overtime,No Pay Leave,Backpay Overtime,Backpay Salary,Backpay Grooming Allowance,Notice in Lieu,EPF,Socso,EIS">
<cfelse>
    <cfset itemlist = "Basic Salary,Grooming Allowance,Grooming Allowance - Adjustment,Incentive,Car Maintenance,Misc Expenses,Overtime,No Pay Leave,Backpay Overtime,Backpay Salary,Backpay Grooming Allowance,Notice in Lieu,EPF,Socso,EIS">
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
    <!---AND (
    (startdate > #createdate(getmmonth.myear,form.period,10)# AND startdate <= #createdate(getmmonth.myear,form.period,daysinmonth(createdate(getmmonth.myear,form.period,1)))#)
    OR startdate <= #createdate(getmmonth.myear,form.period,daysinmonth(createdate(getmmonth.myear,form.period,1)))#)--->
    AND startdate <= #createdate(getmmonth.myear,form.period,10)#
</cfquery>
    
<cfset empty = 0>
    
<cfset actualsumcell = "">

<cfset advancesumcell = "">
        
<cfif form.result eq "Advance cash">
        
    <cfset firstpage = SpreadSheetNew(true)>
      
    <cfset SpreadSheetAddRow(firstpage, ",,,,ADVANCE BILLING")>    
    
    <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
    <cfset spreadsheetAddColumn(firstpage, "Month:", 1, 9, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "#thisperiod#-#right(getmmonth.myear,2)#", 1, 11, false)>
        
    <cfset SpreadSheetAddRow(firstpage, ",,")>
        
    <cfset SpreadSheetAddRow(firstpage, ",,")>
    
    <cfset SpreadSheetAddRow(firstpage, ",,")>
        
    <!---Add Header---> 
    <cfset SpreadSheetAddRow(firstpage, ",,,,GL CODE,FIN CODE,Description: CPD - BA,LMSB,MANPOWER,Variance")>    
        
    <cfset SpreadSheetAddRow(firstpage, ",,,,,,HEADCOUNT,PO No.,Inv No.,DN/DN No.")>
    
        
    <cfset SpreadSheetAddRow(firstpage, ",,,,,,#getdata.recordcount#,#getPOno.po_no#,#getinvoiceno.invoiceno#,")> 
    <!---End Add Header---> 
        
    <!---Table Body--->
        
    <!---Name of items in Table Body--->    
    
    <cfloop index="a" list="#itemlist#">
        <cfset SpreadSheetAddRow(firstpage, ",,,,701370,200-1101,#a#,0")> 
    </cfloop>
        
    <cfset SpreadSheetAddRow(firstpage, ",,,,707150,200-1101,Management Fee (RM80/HC),0")> 
    
    <cfif getmmonth.myear eq 2018 and form.period gte 6 and form.period lte 8>
        <cfset SpreadSheetAddRow(firstpage, ",,,,306020,200-1101,GST,0")> 
    <cfelseif getmmonth.myear eq 2018 and form.period lt 6>
        <cfset SpreadSheetAddRow(firstpage, ",,,,306020,200-1101,GST (6%),0")> 
    <cfelse>
        <cfset SpreadSheetAddRow(firstpage, ",,,,707150,200-1101,SST (6%),0")> 
    </cfif>
        
    <cfset SpreadSheetAddRow(firstpage, ",,,,,,,0")> 
    <!---End Name of items in Table Body--->

    <!---Amount of items in Table Body--->
    <cfif form.period eq 1>
        
        <cfset amtlist = "tbasic,tgallow,tgallowadj">
            
        <cfif tbonus neq 0>
            <cfset amtlist = amtlist&",tbonus">
        </cfif>
            
        <cfif tshoe neq 0>
            <cfset amtlist = amtlist&",tshoe">
        </cfif>
            
        <cfif texcellence neq 0>
            <cfset amtlist = amtlist&",texcellence">
        </cfif>
            
        <cfif tLongService neq 0>
            <cfset amtlist = amtlist&",tLongService">
        </cfif>
            
        <cfset amtlist = amtlist&",tincentive,tcarmain,empty,empty,tupl,empty,tBackPaySalary,tBackPayGA,empty,tepf,tsocso,teis,tadmin,tGst,tBillingGST">
            
    <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
        <cfset amtlist = "tbasic,tgallow,tgallowadj">
            
        <cfif tshoe neq 0>
            <cfset amtlist = amtlist&",tshoe">
        </cfif>
            
        <cfset amtlist = amtlist&",tincentive,tcarmain,empty,empty,tupl,empty,tBackPaySalary,tBackPayGA,empty,tepf,tsocso,teis,tadmin,tGst,tBillingGST">
    <cfelse>
        <cfset amtlist = "tbasic,tgallow,tgallowadj,tincentive,tcarmain,empty,empty,tupl,empty,tBackPaySalary,tBackPayGA,empty,tepf,tsocso,teis,tadmin,tGst,tBillingGST">  
    </cfif>
        
    <cfset startrow = 8>
    <cfset currentrow = 0>
        
    <cfloop index="a" list="#amtlist#">        
        <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
        <cfset spreadsheetAddColumn(firstpage, "#evaluate(a)#", startrow+currentrow, 9, false)>
        <!---<cfset spreadsheetAddColumn(firstpage, "#evaluate(a)#", startrow+currentrow, 10, false)>--->
            
        <cfset spreadsheetSetCellFormula(firstpage, "I#startrow+currentrow#", startrow+currentrow, 10)>
            
         <cfset currentrow += 1>
    </cfloop>    
            
    <cfset spreadsheetSetCellFormula(firstpage, "SUM(H#startrow#:H#startrow+currentrow-2#)", startrow+currentrow-1, 8)>
    <cfset spreadsheetSetCellFormula(firstpage, "SUM(I#startrow#:I#startrow+currentrow-2#)", startrow+currentrow-1, 9)>
    <cfset spreadsheetSetCellFormula(firstpage, "SUM(J#startrow#:J#startrow+currentrow-2#)", startrow+currentrow-1, 10)>
    
    <!---End Amount of items in Table Body--->    
            
    <!---Signature Area---> 
            
    <cfset SpreadSheetAddRow(firstpage, ",,")> 
        
    <cfset SpreadSheetAddRow(firstpage, "Prepared By:")> 
    <cfset spreadsheetAddColumn(firstpage, "Verified By:", startrow+currentrow+1, 9, false)>
        
    <cfset SpreadSheetAddRow(firstpage, ",,")> 
        
    <cfset spreadsheetAddColumn(firstpage, "Date:-", startrow+currentrow+3, 8, false)>
    <cfset spreadsheetAddColumn(firstpage, "Date:-", startrow+currentrow+3, 14, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "Banu Priya Kunnasiger", startrow+currentrow+8, 5, false)>
    <cfset spreadsheetAddColumn(firstpage, "Payroll & Billing Executive", startrow+currentrow+9, 5, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "#dateformat(createdate(getmmonth.myear,form.period,5),'d-mmm-yy')#", startrow+currentrow+7, 8, false)> 
        
    <cfset spreadsheetAddColumn(firstpage, "Piriya Rajikeli", startrow+currentrow+8, 11, false)>    
    <cfset spreadsheetAddColumn(firstpage, "Manager Pay and Bill", startrow+currentrow+9, 11, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "#dateformat(createdate(getmmonth.myear,form.period,5),'d-mmm-yy')#", startrow+currentrow+7, 14, false)> 
        
    <cfset spreadsheetAddColumn(firstpage, "Checked & Verified By:", startrow+currentrow+14, 1, false)>        
    <cfset spreadsheetAddColumn(firstpage, "1st Approved By:", startrow+currentrow+14, 9, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "Date:-", startrow+currentrow+16, 8, false)>
    <cfset spreadsheetAddColumn(firstpage, "Date:-", startrow+currentrow+16, 14, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "Joey Wong", startrow+currentrow+21, 5, false)>
    <cfset spreadsheetAddColumn(firstpage, "Payroll & Administrative Executive", startrow+currentrow+22, 5, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "Jasmine Teo", startrow+currentrow+21, 11, false)>    
    <cfset spreadsheetAddColumn(firstpage, "Retail HR Manager", startrow+currentrow+22, 11, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "2nd Approved By:", startrow+currentrow+23, 1, false)>        
    <cfset spreadsheetAddColumn(firstpage, "Division Controller (CPD):", startrow+currentrow+23, 9, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "Date:-", startrow+currentrow+25, 8, false)>
    <cfset spreadsheetAddColumn(firstpage, "Date:-", startrow+currentrow+25, 14, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "Nur Haida Binti Mohd Khalid", startrow+currentrow+30, 5, false)>
    <cfset spreadsheetAddColumn(firstpage, "Compensation & Benefits Manager (MY/SG)", startrow+currentrow+31, 5, false)>
        
    <cfset spreadsheetAddColumn(firstpage, "Luke Tan", startrow+currentrow+30, 11, false)>  
        
        
    <!---anchor: startRow,startColumn,endRow,endColumn--->
    <cfset imagepath1 = "#hrootpath#/latest/reports/AdvanceBilling/Signature1p1.PNG">
        
    <cfset imagepath2 = "#hrootpath#/latest/reports/AdvanceBilling/Signature2.PNG">
        
    <cfset SpreadsheetAddImage(firstpage,"#imagepath1#","#startrow+currentrow+3#,5,#startrow+currentrow+7#,7")>

    <cfset SpreadsheetAddImage(firstpage,"#imagepath2#","#startrow+currentrow+4#,11,#startrow+currentrow+8#,12")>
            
    <!---End Signature Area---> 
    
    <!---Format table--->
    <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
    <cfset SpreadSheetFormatCellRange(firstpage, s39, 1, 5, 1, 5)>
    <cfset SpreadSheetFormatCellRange(firstpage, s50, 1, 11, 1, 11)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s50, 5, 5, 7, 10)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s50, 8, 10, startrow+currentrow-1, 10)>
    <cfset SpreadSheetFormatCellRange(firstpage, s50, startrow+currentrow-1, 9, startrow+currentrow-1, 9)>
        
    <!---Draw horizontal line--->
    <cfset SpreadSheetFormatCellRange(firstpage, s51, 5, 5, 5, 10)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s51, startrow, 5, startrow, 10)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s56, startrow-1, 8, startrow-1, 10)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s51, startrow+currentrow-1, 5, startrow+currentrow-1, 10)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s51, startrow+currentrow, 5, startrow+currentrow, 10)>
    
    <cfset formatline = "8,21,30">
        
    <cfloop index="a" list="#formatline#">
        
        <cfset SpreadSheetFormatCellRange(firstpage, s56, startrow+currentrow+a, 5, startrow+currentrow+a, 6)>

        <cfset SpreadSheetFormatCellRange(firstpage, s56, startrow+currentrow+a, 8, startrow+currentrow+a, 8)>

        <cfset SpreadSheetFormatCellRange(firstpage, s56, startrow+currentrow+a, 11, startrow+currentrow+a, 12)>

        <cfset SpreadSheetFormatCellRange(firstpage, s56, startrow+currentrow+a, 14, startrow+currentrow+a, 14)>
        
    </cfloop>
    
    <!---Draw horizontal line--->
        
    <!---Draw vertical line--->
    <cfset SpreadSheetFormatCellRange(firstpage, s53, 5, 5, startrow+currentrow-1, 11)>
    <!---Draw vertical line--->
        
    <!---Set dataformat--->
    <cfset SpreadSheetFormatCellRange(firstpage, s67, startrow, 8, startrow+currentrow-1, 10)>
    <!---Set dataformat--->
        
    <!---Set table width--->
    <cfloop index="a" from="1" to="6">
        <cfset spreadsheetSetColumnWidth(firstpage, a, 11) >   
    </cfloop>
        
    <cfloop index="a" from="8" to="10">
        <cfset spreadsheetSetColumnWidth(firstpage, a, 14) >   
    </cfloop>
        
    <cfset spreadsheetSetColumnWidth(firstpage, 14, 14) >  
    <!---Set table width--->        
    
    <cfset SpreadSheetFormatCellRange(firstpage, s55, startrow, 5, startrow+currentrow-1, 6)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s55, startrow-1, 7, startrow-1, 9)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s55, startrow-2, 7, startrow-2, 10)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s55, startrow-3, 8, startrow-3, 10)>
        
    <cfset SpreadSheetFormatCellRange(firstpage, s55, startrow-3, 5, startrow-3, 6)>
    
    <!---Format table--->
        
    <!---End Table Body--->
        
        
    <cfspreadsheet action="write" sheetname="Advance cash" filename="#HRootPath#\Excel_Report\Loreal_Advance_Billing_sheet1_#timenow#.xlsx" name="firstpage" overwrite="true"> 
        
    <cfif isdefined('firstpage')>
        <cfset StructDelete(Variables,"firstpage")>
    </cfif>
        
    <cfset checkfilename = "#HRootPath#\Excel_Report\Loreal_Advance_Billing_sheet1_#timenow#.xlsx">
        
    <cfset filename = "L'Oreal Advance Billing #thisperiod# #getmmonth.myear# - Advance cash_#timenow#">
        
</cfif>
        
<!---Add 1st sheets--->
        
<!---Add 2nd sheets--->
        
<cfif form.result eq "Advance Invoice">
    
    <cfquery name="getregion" dbtype="query">
        SELECT workordid,count(empno) c,sum(TotalBillingGST) TotalBillingGST FROM getdata
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
    
    <cfif getmmonth.myear eq 2018 and form.period gte 6 and form.period lte 8>
        <cfset gstline = "306020,200-1101,GST,0">
    <cfelseif getmmonth.myear eq 2018 and form.period lte 6>
        <cfset gstline = "306020,200-1101,GST (6%),0">
    <cfelse>
        <cfset gstline = "707150,200-1101,SST (6%),0">
    </cfif>
        
    <cfset gstlinearray = listtoarray(gstline)>
        
    <cfset tablewidth = 1>
        
    <cfset rowtoprint = 3>
        
    <cfset secondpage = SpreadSheetNew(true)>  
        
    <cfset SpreadSheetAddRow(secondpage, "ADVANCE BILLING")>
        
    <cfset spreadsheetAddColumn(secondpage, "Month:", 1, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, " #thisperiod# #getmmonth.myear#", 1, 12, false)>
        
    <cfloop query="getregion">
        
        <cfif getregion.workordid neq ''>
            
            <cfquery name="getregiondata" dbtype="query">
                SELECT * FROM getdata
                WHERE workordid='#getregion.workordid#'
            </cfquery>   
            
            <cfset headerlist3 = " , ,#getregiondata.recordcount#,#getPOno.po_no#,#getinvoiceno.invoiceno#">
        
            <cfset headerlistarray3 = listtoarray(headerlist3)>

            <!---rt: Region Total--->
            <cfset rtbasic = 0> 
            <cfset rtincentive = 0> 
            <cfset rtgallow = 0>         
            <cfset rtgallowadj = 0>  

            <cfif form.period eq 1>
                <cfset rtbonus = 0>  
                <cfset rtLongService = 0>
                <cfset rtexcellence = 0> 
                <cfset rtshoe = 0> 
            <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
                <cfset rtshoe = 0>  
            </cfif>

            <cfset rtcarmain = 0>
            <cfset rtupl = 0>
            <cfset rtBackPaySalary = 0>
            <cfset rtBackPayGA = 0>
            <cfset rtGross = 0>
            <cfset rtepf = 0>
            <cfset rtsocso = 0>
            <cfset rteis = 0>
            <cfset rtadmin = 0>
            <cfset rtbilling = 0>
            <cfset rtGst = 0>
            <cfset rtBillingGST = 0>    

            <cfloop query="getregiondata">
                <cfset rtbasic = rtbasic + val(Basic)> 
                <cfset rtincentive = rtincentive + val(Incentive)> 
                <cfset rtgallow = rtgallow + val(GALLOW)>          
                <cfset rtgallowadj = rtgallowadj + val(GALLOWAjd)>          

                <cfif form.period eq 1>
                    <cfset rtbonus = rtbonus + val(Bonus)>  
                    <cfset rtLongService = rtLongService + val(LongServiceAward)>
                    <cfset rtexcellence = rtexcellence + val(ExcellenceAward)> 
                    <cfset rtshoe = rtshoe + val(Shoe)> 
                <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
                    <cfset rtshoe = rtshoe + val(Shoe)>  
                </cfif>            

                <cfset rtcarmain = rtcarmain + val(CarMaintenance)> 
                <cfset rtupl = rtupl + val(UPL)> 
                <cfset rtBackPaySalary = rtBackPaySalary + val(BackPaySalary)> 
                <cfset rtBackPayGA = rtBackPayGA + val(BackPayGA)> 
                <cfset rtGross = rtGross + val(GrossWage)> 
                <cfset rtepf = rtepf + val(EPFYER)> 
                <cfset rtsocso = rtsocso + val(SOCSOYER)> 
                <cfset rteis = rteis + val(EISYER)> 
                <cfset rtadmin = rtadmin + val(AdminFee)> 
                <cfset rtbilling = rtbilling + val(TotalBilling)> 
                <cfset rtGst = rtGst + val(GST)> 
                <cfset rtBillingGST = rtBillingGST + val(TotalBillingGST)>   
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

            <cfset ramtlist = ramtlist&",rtincentive,rtcarmain,empty,empty,rtupl,empty,rtBackPaySalary,rtBackPayGA,empty,rtepf,rtsocso,rteis,rtadmin,rtGst,rtBillingGST">

            <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
                <cfset ramtlist = "rtbasic,rtgallow,rtgallowadj">

                <cfif rtshoe neq 0>
                    <cfset ramtlist = ramtlist&",rtshoe">
                </cfif>

                <cfset ramtlist = ramtlist&",rtincentive,rtcarmain,empty,empty,rtupl,empty,rtBackPaySalary,rtBackPayGA,empty,rtepf,rtsocso,rteis,rtadmin,rtGst,rtBillingGST">
            <cfelse>
                <cfset ramtlist = "rtbasic,rtgallow,rtgallowadj,rtincentive,rtcarmain,empty,empty,rtupl,empty,rtBackPaySalary,rtBackPayGA,empty,rtepf,rtsocso,rteis,rtadmin,rtGst,rtBillingGST">  
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
                    <cfset spreadsheetAddColumn(secondpage, "0", rowtoprint+startrow+currentrow, 4, false)>
                    <cfset spreadsheetAddColumn(secondpage, "#evaluate(a)#", rowtoprint+startrow+currentrow, 5, false)>
                    <!---<cfset spreadsheetAddColumn(secondpage, "#evaluate(a)#", rowtoprint+startrow+currentrow, 6, false)>--->       
                    <cfset spreadsheetSetCellFormula(secondpage, "E#rowtoprint+startrow+currentrow#", rowtoprint+startrow+currentrow, 6)>                    

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
                <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+3, 4, rowtoprint+startrow+currentrow, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint, 1, rowtoprint+2, 6)>  
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+3, 6, rowtoprint+startrow+currentrow-1, 6)>  
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+startrow+currentrow-1, 5, rowtoprint+startrow+currentrow-1, 5)>  
                   
                <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+startrow+currentrow-1, 1, rowtoprint+startrow+currentrow-1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint, 1, rowtoprint, 6)>                
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+1, 1, rowtoprint+1, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s63, rowtoprint+2, 4, rowtoprint+2, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+2, 1, rowtoprint+2, 3)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+3, 1, rowtoprint+3, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+4, 1, rowtoprint+startrow+currentrow-2, 6)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint, 7, rowtoprint+startrow+currentrow-1, 7)>
                <cfset SpreadSheetFormatCellRange(secondpage, s65, rowtoprint, 1, rowtoprint+startrow+currentrow-1, 1)>
                
                <!---Format Header--->
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint, 1, rowtoprint+startrow+currentrow-1, 2)>
        
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-1, 3, rowtoprint+startrow-1, 5)>

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
                    <!---<cfset spreadsheetAddColumn(secondpage, "#evaluate(a)#", rowtoprint+startrow+currentrow, 13, false)>--->
                    <cfset spreadsheetSetCellFormula(secondpage, "L#rowtoprint+startrow+currentrow#", rowtoprint+startrow+currentrow, 13)>  

                     <cfset currentrow += 1>
                </cfloop> 
                   
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(K#rowtoprint+startrow#:K#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 11)> 
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(L#rowtoprint+startrow#:L#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 12)> 
                <cfset spreadsheetSetCellFormula(secondpage, "SUM(M#rowtoprint+startrow#:M#rowtoprint+startrow+currentrow-2#)", rowtoprint+startrow+currentrow-1, 13)> 
                    
                    
                <cfset advancesumcell = advancesumcell&"+L#rowtoprint+startrow+currentrow-1#">
                <!---Add body items--->    
                        
                <!---Format Table--->  
                <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+3, 11, rowtoprint+startrow+currentrow, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint, 8, rowtoprint+2, 13)>  
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+3, 13, rowtoprint+startrow+currentrow-1, 13)> 
                <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+startrow+currentrow-1, 12, rowtoprint+startrow+currentrow-1, 12)> 
                
                <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+startrow+currentrow-1, 8, rowtoprint+startrow+currentrow-1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint, 8, rowtoprint, 13)>                
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+1, 8, rowtoprint+1, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s63, rowtoprint+2, 11, rowtoprint+2, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+2, 8, rowtoprint+2, 10)>
                <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+3, 8, rowtoprint+3, 13)>
                <cfset SpreadSheetFormatCellRange(secondpage, s64, rowtoprint+4, 8, rowtoprint+startrow+currentrow-2, 13)>
                    
                <!---Format Header--->
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint, 8, rowtoprint+startrow+currentrow-1, 9)>
        
                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-1, 10, rowtoprint+startrow-1, 12)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-2, 10, rowtoprint+startrow-2, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 11, rowtoprint+startrow-3, 13)>

                <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+startrow-3, 8, rowtoprint+startrow-3, 9)>
                <!---End Format Header--->
                <!---Format Table---> 

                <cfset rowtoprint += (listlen(itemlist)+7)>
            </cfif>
                
        </cfif>
    </cfloop>
                            
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
        
    <cfset spreadsheetAddColumn(secondpage, "#dateformat(createdate(getmmonth.myear,form.period,5),'d-mmm-yy')#", rowtoprint+7, 5, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Piriya Rajikeli", rowtoprint+18, 3, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Manager Pay and Bill", rowtoprint+19, 3, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "#dateformat(createdate(getmmonth.myear,form.period,5),'d-mmm-yy')#", rowtoprint+17, 5, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Joey Wong", rowtoprint+28, 3, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Payroll & Administrative Executive", rowtoprint+29, 3, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Nur Haida Binti Mohd Khalid", rowtoprint+38, 3, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Compensation & Benefits Manager (MY/SG)", rowtoprint+39, 3, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Advance Billing", rowtoprint+2, 9, false)>
        
    <!---<cfset spreadsheetAddColumn(secondpage, "#tBillingGST#", rowtoprint+2, 11, false)>--->
        
    <cfset spreadsheetSetCellFormula(secondpage, "#advancesumcell#", rowtoprint+2, 11)>
        
    <cfset spreadsheetAddColumn(secondpage, "Total Amount Due to MP", rowtoprint+4, 9, false)>
        
    <!---<cfset spreadsheetAddColumn(secondpage, "#tBillingGST#", rowtoprint+4, 11, false)>--->
        
    <cfset spreadsheetSetCellFormula(secondpage, "K#rowtoprint+2#", rowtoprint+4, 11)>
        
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
        <cfset spreadsheetSetCellFormula(secondpage, "#listGetAt(replacenocase(replacenocase(advancesumcell,'D','F','all'),'K','M','all'),getregion.currentrow,'+')#", rowtoprint+9+getregion.currentrow, 12)><!---Total for each region in Breakdown section--->
            
        <cfset theadcount += getregion.c>
            
        <cfset totalbilling += getregion.TotalBillingGST>
        
    </cfloop>
            
    
            
    <cfset spreadsheetAddColumn(secondpage, "TOTAL", rowtoprint+9+getregion.recordcount+1, 9, false)>
        
    <!---<cfset spreadsheetAddColumn(secondpage, "#theadcount#", rowtoprint+9+getregion.recordcount+1, 11, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "#totalbilling#", rowtoprint+9+getregion.recordcount+1, 12, false)>--->
        
    <cfset spreadsheetSetCellFormula(secondpage, "SUM(K#rowtoprint+10#:K#rowtoprint+9+getregion.recordcount#)", rowtoprint+9+getregion.recordcount+1, 11)>
        
    <cfset spreadsheetSetCellFormula(secondpage, "SUM(L#rowtoprint+10#:L#rowtoprint+9+getregion.recordcount#)", rowtoprint+9+getregion.recordcount+1, 12)>
        
    <cfset spreadsheetAddColumn(secondpage, "1st Approved By:", rowtoprint+24, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Jasmine Teo", rowtoprint+27, 11, false)> 
    <cfset spreadsheetAddColumn(secondpage, "Retail HR Manager", rowtoprint+28, 11, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+25, 13, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Division Controller (CPD):", rowtoprint+30, 9, false)>
        
    <cfset spreadsheetAddColumn(secondpage, "Luke Tan", rowtoprint+36, 11, false)> 
        
    <cfset spreadsheetAddColumn(secondpage, "Date:-", rowtoprint+34, 13, false)>
        
    <!---anchor: startRow,startColumn,endRow,endColumn--->
    <cfset imagepath1 = "#hrootpath#/latest/reports/AdvanceBilling/Signature1.PNG">
        
    <cfset imagepath2 = "#hrootpath#/latest/reports/AdvanceBilling/Signature2.PNG">
        
    <cfset SpreadsheetAddImage(secondpage,"#imagepath1#","#rowtoprint+3#,3,#rowtoprint+7#,4")>

    <cfset SpreadsheetAddImage(secondpage,"#imagepath2#","#rowtoprint+14#,3,#rowtoprint+18#,4")>
        
    <!---End Signature Area--->
       
    <!---Last Format Table--->
    <cfset spreadsheetMergeCells(secondpage,rowtoprint+8,rowtoprint+8,9,12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s39, 1, 1, 1, 1)>   
    <cfset SpreadSheetFormatCellRange(secondpage, s50, 1, 12, 1, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+8, 9, rowtoprint+9, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+9, 11, rowtoprint+9, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+9, 9, rowtoprint+9+getregion.recordcount, 9)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s55, rowtoprint+9, 11, rowtoprint+9+getregion.recordcount+1, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s50, rowtoprint+9+getregion.recordcount+1, 11, rowtoprint+9+getregion.recordcount+1, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+1, 11, rowtoprint+2, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+4, 11, rowtoprint+4, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+4, 11, rowtoprint+4, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s60, rowtoprint+5, 11, rowtoprint+5, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+8, 3, rowtoprint+8, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+8, 5, rowtoprint+8, 5)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+18, 3, rowtoprint+18, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+18, 5, rowtoprint+18, 5)>
    
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+28, 3, rowtoprint+28, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+28, 5, rowtoprint+28, 5)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+38, 3, rowtoprint+38, 3)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+38, 5, rowtoprint+38, 5)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+27, 11, rowtoprint+27, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s56, rowtoprint+36, 11, rowtoprint+36, 11)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+9, 12, rowtoprint+10+getregion.recordcount, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+8, 9, rowtoprint+9+getregion.recordcount, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s61, rowtoprint+8, 9, rowtoprint+9+getregion.recordcount, 12)>
        
    <cfset SpreadSheetFormatCellRange(secondpage, s100, rowtoprint+10+getregion.recordcount, 9, rowtoprint+10+getregion.recordcount, 12)>
        
    <!---spreadsheetMergeCells(spreadsheetObj, startrow, endrow, startcolumn, endcolumn)--->
    
    
        
    <cfset cellwidth = "8,10,33,18,14,15">
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
            
    <cfset SpreadSheetFormatCellRange(secondpage, s67, rowtoprint+9, 12, rowtoprint+10+getregion.recordcount, 12)>
    <!---Last Format Table--->
        
    <cfspreadsheet action="write" sheetname="Advance Invoice" filename="#HRootPath#\Excel_Report\Loreal_Advance_Billing_sheet2_#timenow#.xlsx" name="secondpage" overwrite="true">
        
    <cfif isdefined('secondpage')>
        <cfset StructDelete(Variables,"secondpage")>
    </cfif>
        
    <cfset checkfilename = "#HRootPath#\Excel_Report\Loreal_Advance_Billing_sheet2_#timenow#.xlsx">
        
    <cfset filename = "L'Oreal Advance Billing #thisperiod# #getmmonth.myear# - Advance Invoice_#timenow#">
        
</cfif>
        
<!---Add 2nd sheets--->
    
<!---Add 3rd sheets--->
        
<cfif form.result eq "List of BA">
        
    <cfif isdefined('overall')>
        <cfset StructDelete(Variables,"overall")>
    </cfif>
        
    <cfset overall = SpreadSheetNew(true)>  
        
    <cfset SpreadSheetAddRow(overall, "Company Name:L'OREAL MALAYSIA SDN BHD")>

    <cfset SpreadSheetAddRow(overall, "Report ID: Advance Billing Report")>

    <cfset SpreadSheetAddRow(overall, "Report Title: Advance Billing Report")>

    <cfset SpreadSheetAddRow(overall, "Month: #thisperiod# #getmmonth.myear#")>
        
    <cfset SpreadSheetAddRow(overall, ",,")>
        
    <cfset SpreadSheetAddRow(overall, ",,")>
    
    <!---Add Header--->    
        
    <cfset headerline1 = "">
        
    <cfset headerline2 = "">
        
    <cfif form.period lt 9 and getmmonth.myear lte 2018>
        <cfif form.period eq 1>
            <cfset addcolumn = 4>

            <cfset headerline1 = ",,,,,,,701370,701370,701370,701370,701370,701370,701370,701370,701370,701370,701370,701370,,701370,701370,701370,707150,,306020">    

            <cfset headerline2 = "No.,Employee ID,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Incentive,GALLOW,GALLOW Adj,Bonus,Shoe,Excellence Award,Long Service Award,Car Maintenance,UPL,Back Pay Salary,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,ER EIS Contri,Admin Fee,Total Billing,GST,Total Billing with GST">        
        <cfelseif form.period eq 7 and getmmonth.myear gte 2018>
            <cfset addcolumn = 1>

            <cfset headerline1 = ",,,,,,,701370,701370,701370,701370,701370,701370,701370,701370,701370,,701370,701370,701370,707150,,306020">   

            <cfset headerline2 = "No.,Employee ID,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Incentive,GALLOW,GALLOW Adj,Shoe,Car Maintenance,UPL,Back Pay Salary,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,ER EIS Contri,Admin Fee,Total Billing,GST,Total Billing with GST">
        <cfelse>
            <cfset addcolumn = 0>

            <cfset headerline1 = ",,,,,,,701370,701370,701370,701370,701370,701370,701370,701370,,701370,701370,701370,707150,,306020">   

            <cfset headerline2 = "No.,Employee ID,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Incentive,GALLOW,GALLOW Adj,Car Maintenance,UPL,Back Pay Salary,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,ER EIS Contri,Admin Fee,Total Billing,GST,Total Billing with GST">
        </cfif>
    <cfelse>
        <cfif form.period eq 1>
            <cfset addcolumn = 4>

            <cfset headerline1 = ",,,,,,,701370,701370,701370,701370,701370,701370,701370,701370,701370,701370,701370,701370,,701370,701370,701370,707150,,707150">    

            <cfset headerline2 = "No.,Employee ID,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Incentive,GALLOW,GALLOW Adj,Bonus,Shoe,Excellence Award,Long Service Award,Car Maintenance,UPL,Back Pay Salary,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,ER EIS Contri,Admin Fee,Total Billing,SST,Total Billing with SST">        
        <cfelseif form.period eq 7>
            <cfset addcolumn = 1>

            <cfset headerline1 = ",,,,,,,701370,701370,701370,701370,701370,701370,701370,701370,701370,,701370,701370,701370,707150,,707150">   

            <cfset headerline2 = "No.,Employee ID,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Incentive,GALLOW,GALLOW Adj,Shoe,Car Maintenance,UPL,Back Pay Salary,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,ER EIS Contri,Admin Fee,Total Billing,SST,Total Billing with SST">
        <cfelse>
            <cfset addcolumn = 0>

            <cfset headerline1 = ",,,,,,,701370,701370,701370,701370,701370,701370,701370,701370,,701370,701370,701370,707150,,707150">   

            <cfset headerline2 = "No.,Employee ID,Employee Name,NRIC No,Region,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Incentive,GALLOW,GALLOW Adj,Car Maintenance,UPL,Back Pay Salary,Back Pay GA,Total Gross Wage,Cur ER Man EPF,ER SOCSO Contri,ER EIS Contri,Admin Fee,Total Billing,SST,Total Billing with SST">
        </cfif>
    </cfif>
            
    <cfset SpreadSheetAddRow(overall, headerline1)>
        
    <cfset SpreadSheetAddRow(overall, headerline2)>
    <!---End Add Header--->    
        
    <cfset SpreadSheetAddRows(overall, getdata)>
        
    <cfif form.period eq 1>
        <cfset SpreadSheetAddRow(overall, ",,,,,,,#tbasic#,#tincentive#,#tgallow#,#tgallowadj#,#tbonus#,#tshoe#,#texcellence#,#tLongService#,#tcarmain#,#tupl#,#tBackPaySalary#,#tBackPayGA#,#tGross#,#tepf#,#tsocso#,#teis#,#tadmin#,#tbilling#,#tGst#,#tBillingGST#")>    
    <cfelseif form.period eq 7 and getmmonth.myear gt 2018>
        <cfset SpreadSheetAddRow(overall, ",,,,,,,#tbasic#,#tincentive#,#tgallow#,#tgallowadj#,#tshoe#,#tcarmain#,#tupl#,#tBackPaySalary#,#tBackPayGA#,#tGross#,#tepf#,#tsocso#,#teis#,#tadmin#,#tbilling#,#tGst#,#tBillingGST#")>  
    <cfelse>
        <cfset SpreadSheetAddRow(overall, ",,,,,,,#tbasic#,#tincentive#,#tgallow#,#tgallowadj#,#tcarmain#,#tupl#,#tBackPaySalary#,#tBackPayGA#,#tGross#,#tepf#,#tsocso#,#teis#,#tadmin#,#tbilling#,#tGst#,#tBillingGST#")> 
    </cfif>  
        
    <cfloop index="a" from="1" to="5">
        <cfset SpreadSheetAddRow(overall, ",,,,,,,")> 
    </cfloop>
        
    <cfset SpreadSheetAddRow(overall, ",,Total Employee Count:")> 
    <cfset SpreadSheetAddRow(overall, ",,#getdata.recordcount#")> 
        
    <cfloop query="getdata">
            
        <cfset grosslist = "">
            
        <cfloop index="aa" from="8" to="#16+addcolumn-1#">
            <cfif grosslist eq "">
                <cfset grosslist = "#numbertoletter(aa)##8+getdata.currentrow#">
            <cfelse>
                <cfset grosslist = grosslist&"+#numbertoletter(aa)##8+getdata.currentrow#">
            </cfif>
            
        </cfloop>
            
        <cfset spreadsheetSetCellFormula(overall, "#grosslist#", 8+getdata.currentrow, 16+addcolumn)>
            
        <cfset totalbilllist = "">
            
        <cfloop index="aa" from="#16+addcolumn#" to="#21+addcolumn-1#">
            <cfif totalbilllist eq "">
                <cfset totalbilllist = "#numbertoletter(aa)##8+getdata.currentrow#">
            <cfelse>
                <cfset totalbilllist = totalbilllist&"+#numbertoletter(aa)##8+getdata.currentrow#">
            </cfif>
            
        </cfloop>
            
        <cfset spreadsheetSetCellFormula(overall, "#totalbilllist#", 8+getdata.currentrow, 21+addcolumn)>
            
        <cfset grandlist = "">
            
        <cfloop index="aa" from="#21+addcolumn#" to="#23+addcolumn-1#">
            <cfif grandlist eq "">
                <cfset grandlist = "#numbertoletter(aa)##8+getdata.currentrow#">
            <cfelse>
                <cfset grandlist = grandlist&"+#numbertoletter(aa)##8+getdata.currentrow#">
            </cfif>
            
        </cfloop>
            
        <cfset spreadsheetSetCellFormula(overall, "#grandlist#", 8+getdata.currentrow, 23+addcolumn)>
    </cfloop>
                    
    <cfloop index="i" from="8" to="#23+addcolumn#">
        <cfset spreadsheetSetCellFormula(overall, "SUM(#numbertoletter(i)#8:#numbertoletter(i)##8+getdata.recordcount#)", 8+getdata.recordcount+1, i)>        
    </cfloop>
        
    <cfset spreadsheetSetCellFormula(overall, "COUNTA(A9:A#8+getdata.recordcount#)", 8+getdata.recordcount+8, 3)>  
        
    <!---Format table--->
        
    <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
    <cfset SpreadSheetFormatCellRange(overall, s28, 9, 1, 9+getdata.recordcount-1, listlen(headerline2))>
    
    <cfset SpreadSheetFormatCellRange(overall, s51, 7, 1, 7, listlen(headerline2))>
        
    <cfset SpreadSheetFormatCellRange(overall, s66, 7, 7, 7, listlen(headerline2))>
        
    <cfset SpreadSheetFormatCellRange(overall, s57, 8, 1, 8, listlen(headerline2))>
        
    <cfset SpreadSheetFormatCellRange(overall, s58, 8, 3, 8, 3)>
        
    <cfset SpreadSheetFormatCellRange(overall, s56, 8, 1, 8, listlen(headerline2))>
        
    <cfset SpreadSheetFormatCellRange(overall, s55, 7, 1, 7, listlen(headerline2))>
        
    <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
    <cfset spreadsheetSetRowHeight(overall, 8, 44)>
        
    <cfloop index="a" from="1" to="#listlen(headerline2)#">
        <cfset spreadsheetSetColumnWidth(overall, a, 12)>
    </cfloop>
        
    <cfset spreadsheetSetColumnWidth(overall, 1, 4)>
        
    <cfset spreadsheetSetColumnWidth(overall, 3, 36)>
        
    <cfset spreadsheetSetColumnWidth(overall, 4, 15)>
        
    <cfset spreadsheetSetColumnWidth(overall, 5, 17)> 
        
    <cfset SpreadSheetFormatCellRange(overall, s67, 9, 8, 9+getdata.recordcount, listlen(headerline2))> 
        
    <cfset SpreadSheetFormatCellRange(overall, s68, 9, 6, 9+getdata.recordcount, 7)> 
    
    <cfset SpreadSheetFormatCellRange(overall, s60, 10+getdata.recordcount, 8, 10+getdata.recordcount, listlen(headerline2))>
    
    <!---Format table--->
        
    <cfspreadsheet action="write" sheetname="List of BA" filename="#HRootPath#\Excel_Report\Loreal_Advance_Billing_sheet3_#timenow#.xlsx" name="overall" overwrite="true"> 
        
    <cfif isdefined('overall')>
        <cfset StructDelete(Variables,"overall")>
    </cfif>
        
    <cfset checkfilename = "#HRootPath#\Excel_Report\Loreal_Advance_Billing_sheet3_#timenow#.xlsx">
        
    <cfset filename = "L'Oreal Advance Billing #thisperiod# #getmmonth.myear# - List of BA_#timenow#">
        
</cfif>
        
<!---End Add 3rd sheets--->
        
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
<cfif fileExists(checkfilename) eq false>
    
    <script>
        alert("No File Generated due to no data for the selected month.");
        window.close();
    </script>
    <cfabort>
        
</cfif>
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#checkfilename#">
    
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