<cfsetting showdebugoutput="no">
<cfset dts1 = replace(dts,'_i','_p','All')>
<cfquery name="getList_qry" datasource="#dts1#">
SELECT a.empno,b.empno,name,epfno,epfww,epfwwext,epfcc,epfccext,epfcat 
FROM pmast AS a LEFT JOIN #url.tabletype# AS b ON a.empno=b.empno
WHERE a.empno='#url.empno#' AND paystatus = "A"
</cfquery>

<cfset totalemp = int(val(getList_qry.epfww)) + int(val(getList_qry.epfwwext))>	
<cfset totalempy = round(val(getList_qry.epfcc)) + round(val(getList_qry.epfccext))>	
<cfoutput>
<input type="hidden" name="employeecpf" id="employeecpf" value="#totalemp#" />
<input type="hidden" name="employercpf" id="employercpf" value="#totalempy#" />
</cfoutput>