<cfif isdefined('url.placementno') and url.type eq "create">
<cfset firstday = createdate(2016,5,1)>
<cfset lastday = createdate(2016,5,31)>  
      
<cfquery name="getdatedetails" datasource="#dts#">
select K,createdrefno from importdata.exceldata1 where f <> ""
AND f = "#url.placementno#"
AND id <= "#url.auto2#"
</cfquery>

<cfif getdatedetails.createdrefno neq "">
<cfabort>
</cfif>

<cfif getdatedetails.K neq "">
<cfset startdatedata = listfirst(getdatedetails.k,'-')>
<cfset enddatedata = listlast(getdatedetails.k,'-')>
<cfset startdatevar = createdate(2016,listlast(startdatedata,'/'),listfirst(startdatedata,'/'))>
<cfset enddatevar = createdate(listlast(enddatedata,'/'),listgetat(enddatedata,2,'/'),listfirst(enddatedata,'/'))>

<cfif month(enddatevar) eq 5 and year(enddatevar) eq 2016>
<cfset firstday = startdatevar>
<cfset lastday = enddatevar>
</cfif>

</cfif>

<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype,iname,supervisor,invoicegroup from placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">
        </cfquery>
        <cfquery name="getlastworkingdate" datasource="#dts#">
        select completedate as assignmentslipdate from assignmentslip where empno='#getitemno.xempno#' order by assignmentslipdate desc
    </cfquery>
    <cfquery name="getemployeename" datasource="#dts#">
	SELECT name,paystatus,dbirth
	FROM #dts1#.pmast where empno='#getitemno.xempno#'
	</cfquery>
    <cfif firstday lt getitemno.startdate and month(firstday) eq month(getitemno.startdate)>
    <cfset firstday = getitemno.startdate>
	</cfif>
    <cfif lastday gt getitemno.completedate and month(lastday) eq month(getitemno.completedate)>
    <cfset lastday = getitemno.completedate>
    </cfif>
<cfset valplacementno =    getitemno.xplacementno>
<cfset valcustno = getitemno.xcustno>
<cfset valempno = getitemno.xempno>
<cfset valpaymenttype = getitemno.clienttype>
<cfset valpaymenttype2 = getitemno.clienttype>
<cfset vallastworkingdate = dateformat(getlastworkingdate.assignmentslipdate,'DD/MM/YYYY')>
<cfset valempname = getemployeename.name>
<cfif trim(getitemno.invoicegroup) neq ''>
<cfset valassignmenttype = getitemno.invoicegroup>
<cfelse>
<cfset valassignmenttype = "invoice">
</cfif>
<cfset valxcustname = getitemno.xcustname>
<cfset valcustname = getitemno.xcustname>
<cfset valcustname2 = getitemno.xcustname>
<cfset valiname = getitemno.iname>
<cfset valsupervisor = getitemno.supervisor>
<cfoutput>
<script type="text/javascript">
setTimeout(function(){ getpanel('#getitemno.xplacementno#'); }, 800);
</script>
</cfoutput>
</cfif>