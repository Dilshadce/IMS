
<cfif isdefined('form.generategroup') eq false>
<cfset olddate = form.date>
<cfset ndate = createdate(right(olddate,4),mid(olddate,4,2),left(olddate,2))>
	<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="readperiod"/>
<cfquery name="updatedate" datasource="#dts#">
UPDATE currartran SET
wos_date = "#dateformat(ndate,'YYYY-MM-DD')#",
fperiod = "#readperiod#",
posted = "",
toinv = ""
WHERE (eInvoice_Submited = "" or eInvoice_Submited is null)
</cfquery>
<cfquery name="updatedate2" datasource="#dts#">
UPDATE currictran as a, currartran as b SET
a.wos_date = "#dateformat(ndate,'YYYY-MM-DD')#",
a.fperiod = "#readperiod#",
a.toinv = "",
a.shipped = 0,
a.writeoff = 0
where 
a.refno = b.refno 
and a.type = b.type 
and a.custno = b.custno
and (b.eInvoice_Submited = "" or b.eInvoice_Submited is null)
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
select * from (
SELECT eInvoice_Submited
from currartran
where (eInvoice_Submited <> "" or eInvoice_Submited is not null) group by eInvoice_Submited ) as a left join recurrgroup as b on a.eInvoice_submited = b.groupid
</cfquery>
<cfloop query="getgroup">
<cfset ndategroup = getgroup.nextdate >
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndategroup,'yyyy-mm-dd')#" returnvariable="readperiodgroup"/>

<cfquery name="updatedate" datasource="#dts#">
UPDATE currartran SET
wos_date = "#dateformat(ndategroup,'YYYY-MM-DD')#",
fperiod = "#readperiodgroup#",
posted = "",
toinv = ""
WHERE eInvoice_Submited = "#getgroup.eInvoice_Submited#"
</cfquery>
<cfquery name="updatedate2" datasource="#dts#">
UPDATE currictran as a,currartran as b SET
a.wos_date = "#dateformat(ndategroup,'YYYY-MM-DD')#",
a.fperiod = "#readperiodgroup#",
a.toinv = "",
a.shipped = 0,
a.writeoff = 0
WHERE
a.refno = b.refno 
and a.type = b.type 
and a.custno = b.custno
and b.eInvoice_Submited = "#getgroup.eInvoice_Submited#"
</cfquery>
<cfset nextdatenew = dateadd('m',"#val(getgroup.recurrtype)#",ndategroup)>
<cfquery name="updategroupdate" datasource="#dts#">
UPDATE recurrgroup
SET
lastdate = "#dateformat(ndategroup,'YYYY-MM-DD')#",
nextdate = "#dateformat(nextdatenew,'YYYY-MM-DD')#",
lastgeneratedby = "#huserid#",
lastgeneratedon = now()
WHERE groupid = "#getgroup.eInvoice_Submited#"
</cfquery>

</cfloop>

<cfquery name="getartranbill" datasource="#dts#">
SELECT refno,type,counter,custno from currartran
</cfquery>

<cfelse>

<cfquery name="getgroup" datasource="#dts#">
select * from (
SELECT eInvoice_Submited
from currartran
where eInvoice_Submited= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupid2#">) as a left join recurrgroup as b on a.eInvoice_submited = b.groupid
</cfquery>
<cfloop query="getgroup">
<cfset ndategroup = getgroup.nextdate >
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndategroup,'yyyy-mm-dd')#" returnvariable="readperiodgroup"/>

<cfquery name="updatedate" datasource="#dts#">
UPDATE currartran SET
wos_date = "#dateformat(ndategroup,'YYYY-MM-DD')#",
fperiod = "#readperiodgroup#",
posted = "",
toinv = ""
WHERE eInvoice_Submited = "#getgroup.eInvoice_Submited#"
</cfquery>
<cfquery name="updatedate2" datasource="#dts#">
UPDATE currictran as a,currartran as b SET
a.wos_date = "#dateformat(ndategroup,'YYYY-MM-DD')#",
a.fperiod = "#readperiodgroup#",
a.toinv = "",
a.shipped = 0,
a.writeoff = 0
WHERE a.refno = b.refno 
and a.type = b.type 
and a.custno = b.custno
and b.eInvoice_Submited = "#getgroup.eInvoice_Submited#"
</cfquery>
<cfset nextdatenew = dateadd('m',"#val(getgroup.recurrtype)#",ndategroup)>
<cfquery name="updategroupdate" datasource="#dts#">
UPDATE recurrgroup
SET
lastdate = "#dateformat(ndategroup,'YYYY-MM-DD')#",
nextdate = "#dateformat(nextdatenew,'YYYY-MM-DD')#",
lastgeneratedby = "#huserid#",
lastgeneratedon = now()
WHERE groupid = "#getgroup.eInvoice_Submited#"
</cfquery>
</cfloop>



<cfquery name="getartranbill" datasource="#dts#">
SELECT refno,type,counter,custno from currartran where eInvoice_Submited= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupid2#">
</cfquery>

</cfif>

<cfloop query="getartranbill">
<cfquery name="checkvoid" datasource="#dts#">
select void from currartran where type="#getartranbill.type#" and refno="#getartranbill.refno#" and custno = "#getartranbill.custno#"
</cfquery>

<cfquery name="updatecurrictran" datasource="#dts#">
update currictran set void ='#checkvoid.void#' where type="#getartranbill.type#" and refno="#getartranbill.refno#" and custno = "#getartranbill.custno#"
</cfquery>


<cfif checkvoid.void neq 'Y'>
<cfif getartranbill.counter eq "">
<cfset varval = getartranbill.type&"refno">
<cfset getartranbill.counter = form[varval]>
</cfif>
<cfset validtranno = 0>
<cfloop condition="validtranno eq 0">
<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#getartranbill.type#'
			and counter = '<cfif getartranbill.counter eq "">1<cfelse>#getartranbill.counter#</cfif>'
		</cfquery>
<cfif getGeneralInfo.recordcount eq 0>
<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#getartranbill.type#'
			and counter = '1'
		</cfquery>
</cfif>
<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
    <cfset actual_nexttranno = newnextNum>
    <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
        <cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
    <cfelse>
        <cfset nexttranno = actual_nexttranno>
    </cfif>
    <cfset tranarun_1 = getGeneralInfo.arun>
<cfset nexttranno = tostring(nexttranno)>
<cfquery name="checktranno" datasource="#dts#">
SELECT refno FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#"> and type = "#getartranbill.type#"
</cfquery>

<cfif checktranno.recordcount  neq 0>
<cfquery name="updaterefno" datasource="#dts#">
Update refnoset SET
lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#" >
WHERE
counter = '<cfif getartranbill.counter eq "">1<cfelse>#getartranbill.counter#</cfif>' and type = "#getartranbill.type#"
</cfquery>
<cfelse>
<cfset validtranno = 1>
</cfif>

</cfloop>
<cfquery name="updatetranno" datasource="#dts#">
UPDATE currartran SET 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#" >,
userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,
created_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,
created_on = now()
WHERE
type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartranbill.type#" >
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartranbill.refno#" >
and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartranbill.custno#" >
</cfquery>

<cfquery name="updatetranno" datasource="#dts#">
UPDATE currictran SET 
userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#" >
WHERE
type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartranbill.type#" >
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartranbill.refno#" >
and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartranbill.custno#" >
</cfquery>


<cfquery name="updaterefno" datasource="#dts#">
Update refnoset SET
lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#actual_nexttranno#" >
WHERE
counter = '<cfif getartranbill.counter eq "">1<cfelse>#getartranbill.counter#</cfif>' and type = "#getartranbill.type#"
</cfquery>
</cfif>
</cfloop>

<cfquery name="showcolumns" datasource="#dts#">
show columns from currartran
</cfquery>

<cfset columnsname = "">
<cfloop query="showcolumns">
<cfset columnsname = columnsname&showcolumns.field>
<cfif showcolumns.recordcount neq showcolumns.currentrow>
<cfset columnsname = columnsname&",">
</cfif>
</cfloop>

<cfquery name="getartran" datasource="#dts#">
INSERT INTO artran (#columnsname#) SELECT #columnsname# FROM currartran WHERE (void is null or void = "")
<cfif isdefined('form.generategroup') neq false>
and eInvoice_Submited= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupid2#">
</cfif>
</cfquery>

<cfquery name="showcolumns1" datasource="#dts#">
show columns from currictran
</cfquery>

<cfset columnsname1 = "">
<cfloop query="showcolumns1">
<cfset columnsname1 = columnsname1&"a."&showcolumns1.field>
<cfif showcolumns1.recordcount neq showcolumns1.currentrow>
<cfset columnsname1 = columnsname1&",">
</cfif>
</cfloop>

<cfquery name="getartran" datasource="#dts#">
INSERT INTO ictran (#replacenocase(columnsname1,"a.","","all")#) SELECT #columnsname1# FROM currictran as a <cfif isdefined('form.generategroup') neq false>,currartran as b</cfif> WHERE (a.void is null or a.void = "")<cfif isdefined('form.generategroup') neq false>and a.refno=b.refno and a.type = b.type and b.eInvoice_Submited= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupid2#"></cfif>

</cfquery>

<script type="text/javascript">
alert('Generate Success!');
window.location = '/default/transaction/recurringtran/index.cfm';
</script>
