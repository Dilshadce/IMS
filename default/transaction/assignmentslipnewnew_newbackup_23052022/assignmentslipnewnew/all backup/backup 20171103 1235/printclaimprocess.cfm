<cfquery name="getperiod" datasource="#dts#">
SELECT lastaccyear FROM gsetup
</cfquery>
<cfset lastdate = getperiod.lastaccyear>
<cfquery name="getlist" datasource="#dts#">
SELECT * FROM (
select empno,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt, concat(
if(coalesce(addchargeself,0) != 0 and claimadd1 = 'Y',concat(addchargedesp,CHAR(10 using utf8)),''),
if(coalesce(addchargeself2,0) != 0 and claimadd2 = 'Y',concat(addchargedesp2,CHAR(10 using utf8)),''),
if(coalesce(addchargeself3,0) != 0 and claimadd3 = 'Y',concat(addchargedesp3,CHAR(10 using utf8)),''),
if(coalesce(addchargeself4,0) != 0 and claimadd4 = 'Y',concat(addchargedesp4,CHAR(10 using utf8)),''),
if(coalesce(addchargeself5,0) != 0 and claimadd5 = 'Y',concat(addchargedesp5,CHAR(10 using utf8)),''),
if(coalesce(addchargeself6,0) != 0 and claimadd6 = 'Y',addchargedesp6,'')
) as chargedesp,

concat(
if(coalesce(addchargeself,0) != 0 and claimadd1 = 'Y',concat(round(coalesce(addchargeself,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself2,0) != 0 and claimadd2 = 'Y',concat(round(coalesce(addchargeself2,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself3,0) != 0 and claimadd3 = 'Y',concat(round(coalesce(addchargeself3,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself4,0) != 0 and claimadd4 = 'Y',concat(round(coalesce(addchargeself4,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself5,0) != 0 and claimadd5 = 'Y',concat(round(coalesce(addchargeself5,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself6,0) != 0 and claimadd6 = 'Y',round(coalesce(addchargeself6,0),2),'')
) as chargeamt,refno,placementno,chequeno
 from assignmentslip where (
claimadd1 = "Y"
or claimadd2 = "Y"
or claimadd3 = "Y"
or claimadd4 = "Y"
or claimadd5 = "Y"
or claimadd6 = "Y")
<!--- and (coalesce(addchargeself,0)+coalesce(addchargeself2,0)+coalesce(addchargeself3,0)+coalesce(addchargeself4,0)+coalesce(addchargeself5,0)+coalesce(addchargeself6,0)) > 0 --->
<cfif form.assignmentfrom neq "" and form.assignmentto neq "">
and chequeno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmentto#">
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and assignmentslipdate between "#dateformat(createdate(year(dateadd('m',form.periodfrom,lastdate)),month(dateadd('m',form.periodfrom,lastdate)),'1'),'YYYY-MM-DD')#" and "#dateformat(createdate(year(dateadd('m',form.periodto,lastdate)),month(dateadd('m',form.periodto,lastdate)),DaysInMonth(dateadd('m',form.periodto,lastdate))),'YYYY-MM-DD')#"
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and assignmentslipdate between "#dateformat(createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2)),'YYYY-MM-DD')#" and "#dateformat(createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2)),'YYYY-MM-DD')#"
</cfif>
) as a
LEFT JOIN
(
SELECT nricn,bankaccno,name, empno as emp FROM #replace(dts,'_i','_p')#.PMAST
) as b
on a.empno = b.emp
LEFT JOIN
(
SELECT location,placementno as plno FROM placement
) as c
on a.placementno = c.plno
LEFT JOIN
(
SELECT area,desp from icarea
) as d
on c.location = d.area
order by a.chequeno
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
SELECT compro FROM gsetup
</cfquery>

<cfreport template="claimvoucher.cfr" format="pdf" query="getlist">
<cfreportparam name="compro" value="#getgsetup.compro#">
<cfreportparam name="cheqdate" value="#createdate(right(form.cheqdate,4),mid(form.cheqdate,4,2),left(form.cheqdate,2))#">
</cfreport>