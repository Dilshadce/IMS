 <!--- <cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' > 
<cfsetting requesttimeout="0" >--->
    <cfif dts eq 'manpowertest_i'>
        <cfsetting showdebugoutput="true">
    </cfif>
<cfset dsname = "#replace(dts,'_i','_p')#">
<cfquery datasource="#dsname#">
	SET SESSION binlog_format = 'MIXED';
</cfquery>
<cfquery datasource="#dts#">
	SET SESSION binlog_format = 'MIXED';
</cfquery>
<!--- QUERY FOR placement no--->
<cfquery name="getComp_qry" datasource="payroll_main">
	SELECT * FROM gsetup WHERE comp_id = "#rereplace(HcomID,'_i','')#"
</cfquery>
<cfquery datasource="#dsname#">
	drop table if exists pay12_m_statutory;
</cfquery>
<!--- modified epfcc and socsocc case when--->
<cfquery datasource="#dsname#">
	create table  pay12_m_statutory as (
select TMONTH,empno,
CASE WHEN SUM(coalesce(EPFCC,0)) < 0 THEN 0 ELSE SUM(coalesce(EPFCC,0)) END as EPFCC,
SUM(coalesce(EPFCC_ADJUSTMENT,0)) as EPFCC_ADJUSTMENT,
SUM(coalesce(EPFWW,0)) as EPFWW,
SUM(coalesce(EPFWW_ADJUSTMENT,0)) AS EPFWW_ADJUSTMENT,
<!---CASE WHEN SUM(SOCSOWW) > 19.75 then 19.75 ELSE SUM(coalesce(SOCSOWW,0)) END as SOCSOWW---> 
SUM(coalesce(SOCSOWW,0)) as SOCSOWW,
    <cfif getComp_qry.myear gte 2018>
    SUM(coalesce(EISWW,0)) as EISWW,
    SUM(coalesce(EISCC,0)) as EISCC,
    <cfelse>
       0.00 as EISWW,
        0.00 as EISCC, 
    </cfif>
SUM(coalesce(ded115,0)) as ded115,
<!---CASE WHEN SUM(SOCSOCC) > 69.05 then 69.05 ELSE SUM(SOCSOCC) END as SOCSOCC---> 
CASE WHEN SUM(SOCSOCC) < 0 THEN 0 ELSE SUM(coalesce(SOCSOCC,0)) END as SOCSOCC from (
select * FROM pay1_12m_fig
where TMONTH = "#form.period#"
union all 
select * FROM pay2_12m_fig where TMONTH = "#form.period#") t group by empno,TMONTH) ;
</cfquery>
        
<cfquery datasource="#dsname#">
    ALTER TABLE pay12_m_statutory ADD INDEX (empno,TMONTH)
</cfquery>
        
<cfquery name="preparepay12_m_statutory" datasource="#dsname#">
ALTER TABLE pay12_m_statutory ENGINE=MyISAM
</cfquery>
        
<cfif form.period eq getComp_qry.mmonth and dts eq 'manpower_i'>
    <cfif getComp_qry.myear gte 2018>
	   <cfset p_table = "(select empno, entity, sum(epfww) epfww, sum(epfcc) epfcc, sum(socsoww) socsoww, sum(socsocc) socsocc, SUM(EISWW) as EISWW,
    SUM(EISCC) as EISCC, tmonth, epf_pay_a from #dsname#.payout_stat group by empno) pay ON pay.empno = a.empno ">
    <cfelse>
       <cfset p_table = "(select empno, entity, sum(epfww) epfww, sum(epfcc) epfcc, sum(socsoww) socsoww, sum(socsocc) socsocc, 0.00 as EISWW,
    0.00 as EISCC, tmonth, epf_pay_a from #dsname#.payout_stat group by empno) pay ON pay.empno = a.empno ">
    </cfif>
<cfelse>
	<cfset p_table = "#dsname#.pay12_m_statutory pay ON pay.TMONTH = #form.period# AND pay.empno = a.empno ">
</cfif>
    
<cfquery datasource="#dts#">
    DROP TABLE IF EXISTS assignmentslip_gp
</cfquery>

<cfquery datasource="#dts#">
    CREATE TABLE assignmentslip_gp LIKE assignmentslip
</cfquery>

<cfquery datasource="#dts#">
    INSERT INTO assignmentslip_gp select * 
    FROM assignmentslip 
    WHERE 1=1
    <cfif form.period neq ''>
        AND payrollperiod = #form.period#
    </cfif>
    AND created_on > #createdate(getComp_qry.myear,1,7)#
</cfquery>
    
<!---<cfquery name="prepareassignmentslip_gp" datasource="#dts#">
ALTER TABLE assignmentslip_gp ENGINE=INNODB
</cfquery>
    
<cfquery datasource="#dts#">
    DROP TABLE IF EXISTS assignmentslip_gp
</cfquery>

<cfquery datasource="#dts#">
    CREATE TABLE assignmentslip_gp LIKE assignmentslip
</cfquery>

<cfquery datasource="#dts#">
    INSERT INTO assignmentslip_gp select * 
    FROM assignmentslip 
    WHERE 1=1
    <cfif form.period neq ''>
        AND payrollperiod = #form.period#
    </cfif>
    AND year(assignmentslipdate) = #getComp_qry.myear#
</cfquery>
    
<cfquery name="prepareassignmentslip_gp" datasource="#dts#">
ALTER TABLE assignmentslip_gp ENGINE=INNODB
</cfquery>--->
    
<!---<cfquery datasource="#dts#">
drop table if exists placement_gp
</cfquery>

<cfquery datasource="#dts#">
create table if not exists placement_gp like placement
</cfquery>

<cfquery name="prepareplacement_gp" datasource="#dts#">
ALTER TABLE placement_gp ENGINE=INNODB
</cfquery>
    
<cfquery datasource="#dts#">
insert into placement_gp select * from placement where year(completedate) >= #getComp_qry.myear#-2
</cfquery>--->

<cfoutput>
<cfquery name="getGP" datasource="#dts#">
SELECT *,(coalesce(t2.sale,0) - coalesce(t2.pay,0) - coalesce(t2.epf,0) - coalesce(t2.socso,0) - coalesce(t2.eis,0) - coalesce(t2.Oth,0)) as GP,
	CASE WHEN ROUND(((coalesce(t2.sale,0) - coalesce(t2.pay,0) - coalesce(t2.epf,0) - coalesce(t2.socso,0) - coalesce(t2.eis,0) - coalesce(t2.Oth,0))/coalesce(t2.sale,0)) * 100,2) IS NULL THEN 0 ELSE
	 ROUND(((coalesce(t2.sale,0) - coalesce(t2.pay,0) - coalesce(t2.epf,0) - coalesce(t2.socso,0) - coalesce(t2.eis,0) - coalesce(t2.Oth,0))/coalesce(t2.sale,0)) * 100,2) END
	 as GPPercent FROM (
    
	SELECT 
    <cfif isdefined('form.group')>
        group_concat(distinct refno) as refno,group_concat(distinct branch) as branch,type,group_concat(distinct consultant) as consultant,group_concat(distinct custno) as custno,level,group_concat(distinct custname) as custname,empname,group_concat(distinct job) as job,group_concat(distinct startdate) as startdate,group_concat(distinct completedate) as completedate,group_concat(distinct jobskill) as jobskill,group_concat(distinct orderstatus) as orderstatus,
        candidateType,empno,case when right(group_concat(distinct INV),1)=',' or left(group_concat(distinct INV),1)=',' then replace(INV,',','') else replace(group_concat(distinct INV),',,',',') end as INV,
    <cfelse>
        refno,branch,type,consultant,custno,level,custname,empname,job,startdate,completedate,jobskill,orderstatus,
	candidateType,empno,INV,
    </cfif>
	sum(coalesce(CASE WHEN totalhours IS NULL THEN 0 ELSE totalhours end,0)) as totalhours,
	sum(coalesce(case when SALE is null then 0 ELSE sale end,0)) as sale,
	sum(coalesce(case when pay is null then 0 else pay end,0)) as pay,
	coalesce(case when EPF is null then 0 else epf end,0) as epf
	<!--- EPF --->,
	sum(coalesce(case when EPFCC_ADJUSTMENT is null then 0 else EPFCC_ADJUSTMENT end,0)) as EPFCC_ADJUSTMENT,
	coalesce(case when socso is null then 0 else socso end,0) as socso
	<!--- SOCSO --->,
    coalesce(case when EIS is null then 0 else EIS end,0) as EIS,
	sum(coalesce(case when oth is null then 0 else oth end,0)) as oth
	FROM (
		 SELECT
        a.invoiceno as refno,
		 p.location as branch,
		  case when p.jobpostype ='1' 
        then "Temp" 
        else 
            case when p.jobpostype ='2' 
            then "Contract" 
            else 
                case when p.jobpostype ='3' 
                then "Perm" 
                else
                    case when p.jobpostype ='5' 
                    then "Wage Master" 
                    else "" end
                end
            end
        end as 'type',
		 p.consultant,
		 p.custno,
		 '' as level,
		 p.custname as custname,
		 p.empname as empname,
		 a.selfsalaryhrs
        <cfloop index="a" from="1" to="8">
        + a.selfothour#a#
        </cfloop> as totalHours,
		 p.placementno as `job`,
		 p.startdate,
		 p.completedate,
		 p.jobskillgrp as `jobSkill`,
		 CASE WHEN p.jostatus = 1 THEN 'NEW'
		 WHEN p.jostatus = 2 THEN 'RENEW'
		 ELSE 'REPLACE' END as orderStatus,
		 (SELECT CASE WHEN national = 'MY' THEN 'local' ELSE 'Foreigner' END FROM #dsname#.pmast WHERE empno = p.empno) as 'candidateType',

		 invoiceno as INV,
		 a.empno as empno,
		 a.custtotalgross as SALE,
        <!---payas.PAY--->
		 coalesce(a.selftotal,0) +
		 coalesce(a.selfsdf,0) + coalesce(a.selfcpf,0) + coalesce(a.selfeis,0)
		 <cfloop from="1" to="18" index="i">
		 - case when a.allowance#i#= '53' then coalesce(a.awee#i#,0) else 0 end
		 - case when a.allowance#i#= '40' then coalesce(a.awee#i#,0) else 0 end
        - case when a.allowancedesp#i# like '%tax refund%' then coalesce(a.awee#i#,0) else case when a.allowance#i#= '1003' then coalesce(a.awee#i#,0) else 0 end end
		 </cfloop>

		 <cfloop from="1" to="3" index="i">
			 <cfif #i# eq 1>
		 		- case when a.addchargecode= '17' then coalesce(a.addchargeself,0) else 0 end
                - case when a.addchargedesp like '%tax refund%' then coalesce(a.addchargeself,0) else case when a.addchargecode= '1003' then coalesce(a.addchargeself,0) else 0 end end
		 	 <cfelse>
		 	 	- case when a.addchargecode#i#= '17' then coalesce(a.addchargeself#i#,0) else 0 end
                - case when a.addchargedesp#i# like '%tax refund%' then coalesce(a.addchargeself#i#,0) else case when a.addchargecode#i#= '1003' then coalesce(a.addchargeself#i#,0) else 0 end end
		 	 </cfif>
		 </cfloop> as Pay,
		 coalesce(EPFCC,0) as EPF
		 <!--- a.custcpf as EPF --->,
		 coalesce(SOCSOCC,0) as SOCSO
		 <!--- a.custsdf as SOCSO --->,
        coalesce(EISCC,0) as EIS,
		 0 as EPFCC_ADJUSTMENT,
		 0 as Oth<!---,
        (
        SELECT appstatus from #replace(dts,'_p','_i')#.argiro 
        WHERE batchno = batches 
        and appstatus ='approved'  
        and year(approved_on)=#getComp_qry.myear# 
        and ((month(approved_on)=#val(form.period)+1# and day(approved_on)<=07) 
        or (month(approved_on)=#val(form.period)# and day(approved_on)>=08)) 
        limit 1
        ) as approve--->
             
        FROM assignmentslip_gp a 
        left join placement p
        on a.placementno = p.placementno
        <!---left join 
             (
                SELECT empno,payrollperiod,sum(selftotal +
                 selfsdf + selfcpf
                 <cfloop from="1" to="18" index="i">
                 - case when allowancedesp#i# like '%deposit deduction%' then awee#i# else 0 end
                 - case when allowancedesp#i# like '%advance pay%' then awee#i# else 0 end
                 </cfloop>

                 <cfloop from="1" to="6" index="i">
                     <cfif #i# eq 1>
                        - case when addchargedesp like '%+med benefit reimburse%' then addchargeself else 0 end
                     <cfelse>
                        - case when addchargedesp#i# like '%+med benefit reimburse%' then addchargeself#i# else 0 end
                     </cfif>
                 </cfloop>) as Pay
                FROM assignmentslip_gp
                GROUP BY empno,payrollperiod
             ) payas
        on a.empno=payas.empno and payas.payrollperiod = a.payrollperiod--->
        left join #p_table#
             
		 WHERE 1 =1  AND batches in (select batchno from argiro where appstatus='approved') 
                        <!---AND a.invoiceno != ''--->
                        AND a.created_on > #createdate(getComp_qry.myear,1,7)#
						<cfif form.customer neq '' >
						AND p.custno = '#form.customer#'
						</cfif>
						<cfif form.dateFrom neq '' >
						AND a.assignmentslipdate >= '#form.dateFrom#'
						</cfif>
						<cfif form.dateTo neq '' >
						AND a.assignmentslipdate <= '#form.dateTo#'
						</cfif>
						<cfif form.placementNoFrom neq ''>
						AND a.placementno >= '#form.placementNoFrom#'
						</cfif>
						<cfif form.placementNoTo neq ''>
						AND a.placementno <= '#form.placementNoTo#'
						</cfif>
						<cfif form.period neq ''>
						AND a.payrollperiod = #form.period#
						</cfif>
        <!---HAVING approve='approved'--->
        UNION ALL
         
        <!---CN DN for GP report--->
        SELECT
        ic.refno  as refno,
        p.location as branch,
		case when p.jobpostype ='1' 
        then "Temp" 
        else 
            case when p.jobpostype ='2' 
            then "Contract" 
            else 
                case when p.jobpostype ='3' 
                then "Perm" 
                else
                    case when p.jobpostype ='5' 
                    then "Wage Master" 
                    else "" end
                end
            end
        end as 'type',
		 p.consultant,
		 p.custno,
		 '' as level,
		 p.custname as custname,
		 p.empname as empname,
		 assign.selfsalaryhrs 
        <cfloop index="a" from="1" to="8">
        + assign.selfothour#a#
        </cfloop> as totalHours,
		 p.placementno as `job`,
		 p.startdate,
		 p.completedate,
		 p.jobskillgrp as `jobSkill`,
		 CASE WHEN p.jostatus = 1 THEN 'NEW'
		 WHEN p.jostatus = 2 THEN 'RENEW'
		 ELSE 'REPLACE' END as orderStatus,
		 (SELECT CASE WHEN national = 'MY' THEN 'local' ELSE 'Foreigner' END FROM #dsname#.pmast WHERE empno = p.empno) as 'candidateType',

		 ic.refno as INV,
		 p.empno as empno,
		 coalesce(ic.custtotalgross,0.00) as SALE,
		 0.00 as Pay,
        0.00 as EPF
		 <!--- a.custcpf as EPF --->,
		 0.00 as SOCSO
		 <!--- a.custsdf as SOCSO --->,
        0.00 as EIS,
		 0.00 as EPFCC_ADJUSTMENT,
		 0 as Oth
             
        FROM 
        (
            select *,sum(amt_bil) custtotalgross from ictran 
            where refno in 
                    (
                    select refno from artran 
                    where rem40 is not null and (type='cn' or type='dn')
                    and (void is null or void ='')
                    <cfif form.period neq ''>
                    and fperiod = #numberformat(form.period,'00')#
                    </cfif>
                    )
            and (type='cn' or type='dn')
            and (void is null or void ='')
            group by refno,case when brem6 = '' or brem6 is null then brem1 else brem6 end
        )ic
        left join artran ar
        on ic.refno=ar.refno
        left join assignmentslip assign
        on assign.refno=ic.brem6
        left join placement p
        on <cfif getComp_qry.myear gte 2018>
                ic.brem1=p.placementno 
            <cfelse>
                case when (ic.brem1 is null or ic.brem1='') 
                then assign.placementno = p.placementno 
                else ic.brem1=p.placementno 
                end
            </cfif>
             
		 WHERE 1 =1 
                        <cfif getComp_qry.myear gte 2018>
                            AND ar.wos_date > #createdate(getComp_qry.myear,1,7)#
                        <cfelse>
                            AND year(ic.wos_date) = #getComp_qry.myear#
                        </cfif>
						<cfif form.customer neq '' >
						AND ar.custno = '#form.customer#'
						</cfif>
						<cfif form.dateFrom neq '' >
						AND ar.wos_date >= '#form.dateFrom#'
						</cfif>
						<cfif form.dateTo neq '' >
						AND ar.wos_date <= '#form.dateTo#'
						</cfif>
						<cfif form.placementNoFrom neq ''>
						AND assign.placementno >= '#form.placementNoFrom#'
						</cfif>
						<cfif form.placementNoTo neq ''>
						AND assign.placementno <= '#form.placementNoTo#'
						</cfif>
						<cfif form.period neq ''>
						AND ic.fperiod = #numberformat(form.period,'00')#
						</cfif>
        <!---CN DN for GP report--->
        UNION ALL
        <!---Perm for GP report---> 
        SELECT
        ic.refno  as refno,
        arc.arrem1 as branch,
		 case when p.jobpostype ='1' 
        then "Temp" 
        else 
            case when p.jobpostype ='2' 
            then "Contract" 
            else 
                case when p.jobpostype ='3' 
                then "Perm" 
                else
                    case when p.jobpostype ='5' 
                    then "Wage Master" 
                    else "" end
                end
            end
        end as 'type',
		 p.consultant,
		 ic.custno as custno,
		 '' as level,
		 case when ic.name='' then arc.name else ic.name end  as custname,
		 p.empname as empname,
		 0.00 as totalHours,
		 p.placementno as `job`,
		 p.startdate,
		 p.completedate,
		 p.jobskillgrp as `jobSkill`,
		 CASE WHEN p.jostatus = 1 THEN 'NEW'
		 WHEN p.jostatus = 2 THEN 'RENEW'
		 ELSE 'REPLACE' END as orderStatus,
		 (SELECT CASE WHEN national = 'MY' THEN 'local' ELSE 'Foreigner' END FROM #dsname#.pmast WHERE empno = p.empno) as 'candidateType',
		 ic.refno as INV,
        p.empno as empno,
		 ic.custtotalgross as SALE,
		 0.00 as Pay,
        0.00 as EPF
		 <!--- a.custcpf as EPF --->,
		 0.00 as SOCSO
		 <!--- a.custsdf as SOCSO --->,
        0.00 as EIS,
		 0.00 as EPFCC_ADJUSTMENT,
		 0 as Oth
             
        FROM 
        (
             select *,sum(amt_bil) custtotalgross from ictran 
            where refno in 
                            (
                            select refno from artran 
                            where rem40 is null and (type='inv' or type='cn' or type='dn')
                            and (void is null or void ='')
                            <cfif form.period neq ''>
                            and fperiod = #numberformat(form.period,'00')#
                            </cfif>
                            )
            <cfif form.period neq ''>
            and fperiod = #numberformat(form.period,'00')#
            </cfif>
            group by refno,fperiod,type,brem1
        )ic
        left join artran ar
        on ic.refno=ar.refno
        left join arcust arc
        on ic.custno=arc.custno
        left join placement p
        on  ic.brem1=p.placementno 
             
		 WHERE 1 =1 
                        and (ic.void is null or ic.void ='')
                        <cfif getComp_qry.myear gte 2018>
                            AND ar.wos_date > #createdate(getComp_qry.myear,1,7)#
                        <cfelse>
                            AND year(ic.wos_date) = #getComp_qry.myear#
                        </cfif>
						<cfif form.customer neq '' >
						AND ar.custno = '#form.customer#'
						</cfif>
						<cfif form.dateFrom neq '' >
						AND ar.wos_date >= '#form.dateFrom#'
						</cfif>
						<cfif form.dateTo neq '' >
						AND ar.wos_date <= '#form.dateTo#'
						</cfif>
						<cfif form.period neq ''>
						AND ic.fperiod = #numberformat(form.period,'00')#
						</cfif>
        <!---Perm for GP report--->
        

				) t 
                GROUP BY <cfif isdefined('form.group')>empno<cfelse>empno,type,refno,pay,sale</cfif>
                HAVING Pay != 0 OR SALE != 0            
                ORDER BY empno,refno,job
				) t2
        

</cfquery>
                      
</cfoutput>
<!-- ============ SETTING table headers for excel file ==================== --->
<cfset headerFields = [
	"Branch",
	"Type",
	"StaffCode",
	"ClientID",
	"Level",
	"Company",
	"Candidate Name",
	"Total Hour",
	"Job",
	"Start Date",
	"End date",
	"Job Skill",
	"Order Status",
	"Candidate Type",
	"Candidate No",
	"Inv",
	"SALE",
	"PAY",
	"EPF",
	"EPF_ADJUSTMENT",
	"SOCSO",
    "EIS",
	"Oth Burdens",
	"GP(RM)",
	"GP%"
	] />
<cfscript>
					sumHours = 0;
					sumSales = 0;
					sumPay = 0;
					sumEPF = 0;
					sumEPF_adjustment = 0;
					sumSOCSO = 0;
                    sumEIS = 0;
					sumOth = 0;
					sumGP = 0;
					sumGPPercent = 0;
		</cfscript>
<cfset colList = getGP.columnList >
<!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
<cfxml variable="data">
	<cfinclude template="/excel_template/excel_header.cfm">
	<Worksheet ss:Name="GPbyBranch-JobType Report">
	<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
		<Column ss:Width="64.5"/>
		<Column ss:Width="60.25"/>
		<Column ss:Width="183.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="60"/>
		<Column ss:Width="47.25"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfloop array="#headerFields#" index="field" >
				<Cell ss:StyleID="s27">
					<Data ss:Type="String">
						<cfoutput>
							#field#
						</cfoutput>
					</Data>
				</Cell>
			</cfloop>
		</Row>
		<cfloop query="#getGP#" >
			<cfscript>
					if(getGP.currentRow > 1){
						if(getGP['empno'][getGP.currentRow] == getGP['empno'][getGP.currentRow -1]){
							getGP.EPF = 0;
							getGP.EPFCC_ADJUSTMENT = 0;
							getGP.SOCSO = 0;
                            getGP.EIS = 0;
						}
					}
						sumHours += val(getGP.totalHours);
						sumSales = val(sumSales) + val(getGP.SALE);
						sumPay = val(sumPay) + val(getGP.PAY);
						sumEPF = val(sumEPF) + val(getGP.EPF);
						sumEPF_adjustment = val(sumEPF_adjustment) + val(getGP.EPFCC_ADJUSTMENT);
						sumSOCSO = val(sumSOCSO) + val(getGP.SOCSO);
                        sumEIS = val(sumEIS) + val(getGP.EIS);
						sumOth = val(sumOth) + val(getGP.Oth);
                        currentGP = val(trim(getGP.SALE)) - val(trim(getGP.PAY)) - val(trim(getGP.EPF)) - val(trim(getGP.SOCSO)) - val(trim(getGP.EIS)) - val(trim(getGP.Oth));
						sumGP = val(sumGP) + val(currentGP);
						if(val(getGP.SALE) > 0){
							C_GPPercent = (val(getGP.SALE) - val(getGP.PAY) - val(getGP.EPF) -val(getGP.SOCSO) - val(getGP.EIS) - val(getGP.Oth)) / val(getGP.SALE);


						}else{
							C_GPPercent = 0;
						}
						sumGPPercent += val(C_GPPercent);                
                        
                        if(isdefined('form.group')){
                            data = [
                                getGP.branch,
                                getGP.type,
                                getGP.consultant,
                                getGP.custno,
                                getGP.level,
                                getGP.custname,
                                getGP.empname,
                                getGP.totalHours,
                                getGP.job,
                                getGP.startdate,
                                getGP.completedate,
                                getGP.jobskill,
                                getGP.orderstatus,
                                getGP.candidatetype,
                                getGP.empno,
                                getGP.inv,
                                getGP.SALE,
                                getGP.PAY,
                                getGP.EPF,
                                getGP.EPFCC_ADJUSTMENT,
                                getGP.SOCSO,
                                getGP.EIS,
                                getGP.Oth,
                                currentGP,
                                val(C_GPPercent)
                            ];

                        }else{
                            data = [
                                getGP.branch,
                                getGP.type,
                                getGP.consultant,
                                getGP.custno,
                                getGP.level,
                                getGP.custname,
                                getGP.empname,
                                getGP.totalHours,
                                getGP.job,
                                dateFormat(getGP.startdate,"YYYY-MM-DD"),
                                dateFormat(getGP.completedate,"YYYY-MM-DD"),
                                getGP.jobskill,
                                getGP.orderstatus,
                                getGP.candidatetype,
                                getGP.empno,
                                getGP.inv,
                                getGP.SALE,
                                getGP.PAY,
                                getGP.EPF,
                                getGP.EPFCC_ADJUSTMENT,
                                getGP.SOCSO,
                                getGP.EIS,
                                getGP.Oth,
                                currentGP,
                                val(C_GPPercent)
                            ];

                        }
						
					</cfscript>
			<Row>
				<cfloop from='1' to='#ArrayLen(data)#' index="i">
                    <cfif isNumeric(data[i])>
                        <Cell>
                            <Data ss:Type="Number"><cfoutput>#numberformat(data[i],'0.00')#</cfoutput></Data>
                        </Cell>
                    <cfelse>
                        <cfwddx action = "cfml2wddx" input = "#data[i]#" output = "wddxText#i#">
                        <Cell>
                            <Data ss:Type="String"><cfoutput>#evaluate("wddxText#i#")#</cfoutput></Data>
                        </Cell>
                    </cfif>
				</cfloop>
			</Row>
			<cfset isNextRowSameCustomer = true>
			<cfif getGP.currentRow neq getGP.RecordCount>
				<cfif getGP['custno'][getGP.currentRow] neq getGP['custno'][getGP.currentRow +1]>
					<cfset isNextRowSameCustomer = false>
				</cfif>
			<cfelse>
				<cfset isNextRowSameCustomer = false>
			</cfif>
			<cfif isNextRowSameCustomer neq true>
				<Row>
					<!---- SPACING ------>
					<cfloop from='1' to="7" index='i'>
						<Cell>
							<Data ss:Type="String">
							</Data>
						</Cell>
					</cfloop>
					<Cell>
						<Data ss:Type="Number"><cfoutput>#val(sumHours)#</cfoutput></Data>
					</Cell>
					<!---- SPACING ------>
					<cfloop from='1' to="8" index='i'>
						<Cell>
							<Data ss:Type="String">
							</Data>
						</Cell>
					</cfloop>
					<Cell>
						<Data ss:Type="Number"><cfoutput>#val(sumSales)#</cfoutput></Data>
					</Cell>
					<Cell>
						<Data ss:Type="Number"><cfoutput>#val(sumPay)#</cfoutput></Data>
					</Cell>
					<Cell>
                        <Data ss:Type="Number"><cfoutput>#val(sumEPF)#</cfoutput></Data>
					</Cell>
					<Cell>
                        <Data ss:Type="Number"><cfoutput>#val(sumEPF_adjustment)#</cfoutput></Data>
					</Cell>
					<Cell>
                        <Data ss:Type="Number"><cfoutput>#val(sumSOCSO)#</cfoutput></Data>
					</Cell>
                    <Cell>
                        <Data ss:Type="Number"><cfoutput>#val(sumEIS)#</cfoutput></Data>
					</Cell>
					<Cell>
                        <Data ss:Type="Number"><cfoutput>#val(sumOth)#</cfoutput></Data>
					</Cell>
					<Cell>
                        <Data ss:Type="Number"><cfoutput>#val(sumGP)#</cfoutput></Data>
					</Cell>
					<Cell>
                        <Data ss:Type="Number"><cfoutput>#val(sumGPPercent)#</cfoutput></Data>
					</Cell>
				</Row>
				<Row>
				</Row>
				<cfset sumHours = 0>
				<cfset sumSales = 0>
				<cfset sumPay = 0>
				<cfset sumEPF = 0>
				<cfset sumEPF_adjustment = 0>
				<cfset sumSOCSO = 0>
                <cfset sumEIS = 0>
				<cfset sumOth = 0>
				<cfset sumGP = 0>
				<cfset sumGPPercent = 0>
			</cfif>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</Table>
	<cfinclude template="/excel_template/excel_footer.cfm">
</cfxml>
<cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\GP_Report#timenow#.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=GP_Report_#huserid#_#dts#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\GP_Report#timenow#.xls">
