<cfif isdefined('url.pno') and url.type eq "create">
        
<cfquery name="gettimesheet" datasource="#replace(dts,'_i','_p')#">
SELECT min(pdate) as first,max(pdate) as last FROM timesheet WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
AND tmonth = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
ORDER BY tsrowcount
</cfquery>
<cfset firstday = gettimesheet.first>
<cfset lastday = gettimesheet.last>
<!---to override first and last day so it get one month instead of 2 month when 2 month submitted at the same month, [20170322, Alvin]--->
<!---<cfif IsDefined('url.firstday')>
	<cfset firstday = dateformat(url.firstday, 'yyyy-mm-dd')> 
</cfif>
<cfif IsDefined('url.lastday')>
	<cfset lastday = dateformat(url.lastday, 'yyyy-mm-dd')>  
</cfif>--->
<!---to override--->

<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype,iname,supervisor,invoicegroup from placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
        </cfquery>
        
         <cfquery name="getbillref" datasource="#dts#">
    SELECT arrem10 FROM arcust WHERE custno = "#getitemno.xcustno#"
    </cfquery>
    
        <cfquery name="getlastworkingdate" datasource="#dts#">
        select completedate as assignmentslipdate from assignmentslip where empno='#getitemno.xempno#' order by assignmentslipdate desc
    </cfquery>
    <cfquery name="getemployeename" datasource="#dts#">
	SELECT name,paystatus,dbirth
	FROM #dts1#.pmast where empno='#getitemno.xempno#'
	</cfquery>
<cfset valplacementno =    getitemno.xplacementno>
<cfset valcustno = getitemno.xcustno>
<cfset valempno = getitemno.xempno>
<cfset valpaymenttype = getitemno.clienttype>
<cfset valpaymenttype2 = getitemno.clienttype>
<cfset vallastworkingdate = dateformat(getlastworkingdate.assignmentslipdate,'DD/MM/YYYY')>
<cfset valempname = getemployeename.name>

<cfif getbillref.arrem10 eq '0'>
<cfif trim(getitemno.invoicegroup) neq ''>
<cfset valassignmenttype = getitemno.invoicegroup>
<cfelse>
<cfset valassignmenttype = getitemno.xcustno>
</cfif>
<cfelse>
<cfset valassignmenttype = 'invoice'>
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