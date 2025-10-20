<cfquery name="getperiod" datasource="#dts#">
SELECT lastaccyear FROM gsetup
</cfquery>
<cfset lastdate = getperiod.lastaccyear>

<cfquery name="getlist" datasource="#dts#">
SELECT * FROM (
select empno,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt from assignmentslip where (
claimadd1 = "Y"
or claimadd2 = "Y"
or claimadd3 = "Y"
or claimadd4 = "Y"
or claimadd5 = "Y"
or claimadd6 = "Y")
<!--- and (coalesce(addchargeself,0)+coalesce(addchargeself2,0)+coalesce(addchargeself3,0)+coalesce(addchargeself4,0)+coalesce(addchargeself5,0)+coalesce(addchargeself6,0)) > 0 --->
and chequeno <> "" and chequeno is not null
<cfif form.assignmentfrom neq "" and form.assignmentto neq "">
and chequeno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmentto#">
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and assignmentslipdate between "#dateformat(createdate(year(dateadd('m',form.periodfrom,lastdate)),month(dateadd('m',form.periodfrom,lastdate)),'1'),'YYYY-MM-DD')#" and "#dateformat(createdate(year(dateadd('m',form.periodto,lastdate)),month(dateadd('m',form.periodto,lastdate)),DaysInMonth(dateadd('m',form.periodto,lastdate))),'YYYY-MM-DD')#"
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and assignmentslipdate between "#dateformat(createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2)),'YYYY-MM-DD')#" and "#dateformat(createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2)),'YYYY-MM-DD')#"
</cfif>
order by chequeno
) as a
LEFT JOIN
(
SELECT nricn,bankaccno,name, empno as emp,bankcode,epfno FROM #replace(dts,'_i','_p')#.PMAST
) as b
on a.empno = b.emp
</cfquery>

<cfreport template="printcheq.cfr" format="pdf" query="getlist">
<cfreportparam name="cheqdate" value="#createdate(right(form.cheqdate,4),mid(form.cheqdate,4,2),left(form.cheqdate,2))#">
</cfreport>