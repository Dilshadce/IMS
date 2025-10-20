<cfoutput>
 <cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'m')>
    
<cfif isdefined('url.month')>
  <cfif val(startdate) neq 0>
    <cfquery name="getbatch" datasource="#dts#">
    SELECT batches,giropaydate FROM assignmentslip WHERE 
    year(assignmentslipdate) = "#getmonth.myear#"
    and payrollperiod = "#url.month#"
    and batches <> "" and batches is not null
    Group By Batches
    order by batches
    </cfquery>
    

    <cfquery name="getvalidbatch" datasource="#dts#">
    SELECT batchno FROM argiro WHERE 
    batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
    and (appstatus = "Approved")
    </cfquery>
    <cfset submitedlist = valuelist(getvalidbatch.batchno)>
    <cfquery name="getvalidbatch2" datasource="#dts#">
    SELECT batchno FROM argiro WHERE 
    batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
    and appstatus = "Pending"
    </cfquery>
    <cfset submitedlist2 = valuelist(getvalidbatch2.batchno)>


    
    <cfloop query="getbatch">
    <input type="checkbox" name="batches" id="batches" value="#getbatch.batches#">&nbsp;&nbsp;#getbatch.batches#-#dateformat(getbatch.giropaydate,'dd/mm/yyyy')#<cfif listfindnocase(submitedlist,getbatch.batches) neq 0>&nbsp;(Approved)</cfif><cfif listfindnocase(submitedlist2,getbatch.batches) neq 0>&nbsp;(Submitted)</cfif><br>

    </cfloop>
	</cfif>
</cfif>
</cfoutput>