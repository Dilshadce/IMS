<cfsetting showdebugoutput="no">
<cfset dts1 = replace(dts,'_i','_p','All')>
<cfquery name="getList_qry" datasource="#dts1#">
SELECT a.empno,b.empno,name,epfno,epfww,epfwwext,epfcc,epfccext,epfcat,b.brate
FROM pmast AS a LEFT JOIN #url.tabletype# AS b ON a.empno=b.empno
WHERE a.empno='#url.empno#' AND paystatus = "A"
</cfquery>

<cfoutput>
<input type="hidden" name="employeebrate" id="employeebrate" value="#getList_qry.brate#" />
</cfoutput>