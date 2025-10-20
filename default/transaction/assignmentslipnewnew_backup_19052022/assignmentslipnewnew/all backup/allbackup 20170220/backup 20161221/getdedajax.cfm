<cfsetting showdebugoutput="no">
<cfset dts1 = replace(dts,'_i','_p','All')>

<cfquery name="getded" datasource="#dts1#">
SELECT tded from #url.tabletype# where empno='#url.empno#'
</cfquery>

<cfoutput>
<input type="hidden" name="employeeded" id="employeeded" value="#val(getded.tded)#" />
</cfoutput>