<cfif isdefined('form.asnrefno')>
<cfset dts2=replace(dts,'_i','','all')>
<cfinclude template="/object/dateobject.cfm">
  <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
   </cfquery> 
    <cfset datenow =  createdate(val(getmonth.myear),val(getmonth.mmonth),1)>
    <cfquery name="getalias" datasource="main">
    SELECT userEmail FROM users WHERE 
    userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
    and userbranch = "#dts#"
    </cfquery>
    
    <cfif getalias.useremail neq "" and len(getalias.useremail) eq "2">
    <cfset  batchstart = UCASE(getalias.useremail)>
    <cfelse>
    <cfset batchstart = UCASE(left(getauthuser(),2))>
    </cfif>
    
    <cfset batchstart = batchstart&dateformat(datenow,'MMYY')>
    
    <cfquery name="getlatest" datasource="#dts#">
    SELECT max(right(batches,3)) as maxbatches FROM assignmentslip WHERE left(batches,6) = "#batchstart#"
    </cfquery>
    
    <cfif getlatest.recordcount eq 0>
    <cfset batchstart = batchstart&"001">
	<cfelse>
    <cfset batchstart = batchstart&numberformat(val(getlatest.maxbatches)+1,'000')>  
	</cfif>

<cfquery name="checkassignment" datasource="#dts#">
SELECT batches,refno FROM assignmentslip WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asnrefno#" list="yes" separator=",">) and batches <> "" and batches is not null
</cfquery>

<cfif checkassignment.recordcount neq 0>
<cfoutput>
    <cfloop query="checkassignment">
    #checkassignment.refno# - #checkassignment.batches#<br>
    </cfloop>
</cfoutput>
<cfabort>
</cfif>

<cfquery name="checkassignnew" datasource="#dts#">
SELECT paydate,empno,assignmentslipdate FROM assignmentslip WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asnrefno#" list="yes" separator=",">)
</cfquery>

<cfquery name="checksamepay" datasource="#dts#">
SELECT refno,batches,empno FROM assignmentslip WHERE refno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asnrefno#" list="yes" separator=",">)
and paydate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkassignnew.paydate#">
and empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(checkassignnew.empno)#" list="yes" separator=",">)
and month(assignmentslipdate) = "#dateformat(checkassignnew.assignmentslipdate,'m')#"
and year(assignmentslipdate) = "#dateformat(checkassignnew.assignmentslipdate,'yyyy')#"
</cfquery>

<cfif checksamepay.recordcount neq 0>
<cfoutput>
<cfset translist = "">
<cfloop query="checksamepay">
<cfset translist = translist&"\n"&checksamepay.refno&" - "&checksamepay.empno>
<cfif checksamepay.batches neq "">
<cfset translist = translist&"("&checksamepay.batches&")">
</cfif>
</cfloop>
<script type="text/javascript">
alert("There have multiple assignment for employee below fall on same pay day but didnt assign to same batches#translist#");
history.go(-1);
</script>
<cfabort>
</cfoutput>
</cfif>


<cfquery name="updateassignment" datasource="#dts#">
UPDATE assignmentslip SET 
batches = "#batchstart#" 
,giropaydate = "#dateformatnew(form.giropaydate,'yyyy-mm-dd')#"
WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.asnrefno#" list="yes" separator=",">) and (batches = "" or batches is null)
</cfquery>

<cfloop list="#form.asnrefno#" index="a">
<cfquery name="insertbatches" datasource="#dts#">
INSERT INTO assignbatches (batches,refno,created_by,created_on,paydate) 
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#batchstart#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#a#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
now(),
"#dateformatnew(form.giropaydate,'yyyy-mm-dd')#"
)
</cfquery>
</cfloop>
<cfoutput>
<script type="text/javascript">
alert('Batches Assigned! Batch Number is #batchstart#');
window.location.href='batchassignment.cfm';
</script>
</cfoutput>
<cfelse>
<script type="text/javascript">
alert('No Assignmentslip Selected! Please Reselect');
history.go(-1);
</script>
</cfif>