<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfif isdefined('form.replacefifo')>
<cfset tablename = "fifoopq"&"#dateformat(now(),'YYYYMMDD')#"&"#timeformat(now(),'HHMMSS')#">
<cfquery name="dobackup" datasource="#dts#">
CREATE TABLE #tablename# LIKE FIFOOPQ 
</cfquery>
<cfquery name="insertbackup" datasource="#dts#">
INSERT INTO #tablename# SELECT * FROM FIFOOPQ
</cfquery>
<cfquery name="emptytable" datasource="#dts#">
TRUNCATE fifoopq
</cfquery>
</cfif>
<cfquery name="getitem" datasource="#dts#">
SELECT itemno,ucost,qtybf FROM icitem
</cfquery>
<cfset noinsertlist = "">
<cfloop query="getitem">
<cfquery name="checkexist" datasource="#dts#">
SELECT FFQ11 FROM FIFOOPQ WHERE ITEMNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
</cfquery>
<cfif checkexist.recordcount eq 0>
<cfquery name="insertfifo" datasource="#dts#">
INSERT INTO fifoopq (FFQ11,FFC11,FFD11,itemno)
VALUES
(
<cfqueryparam value="#val(getitem.qtybf)#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#val(getitem.ucost)#" cfsqltype="cf_sql_varchar">,
"#dateformat(now(),'YYYY-MM-DD')#",
<cfqueryparam value="#getitem.itemno#" cfsqltype="cf_sql_varchar">
)
</cfquery>
<cfelseif val(checkexist.ffq11) eq 0 >
<cfquery name="updatefifo" datasource="#dts#">
UPDATE FIFOOPQ
SET
FFQ11 = <cfqueryparam value="#val(getitem.qtybf)#" cfsqltype="cf_sql_varchar">,
FFC11 = <cfqueryparam value="#val(getitem.ucost)#" cfsqltype="cf_sql_varchar">,
FFD11 = "#dateformat(now(),'YYYY-MM-DD')#"
WHERE ITEMNO = <cfqueryparam value="#getitem.itemno#" cfsqltype="cf_sql_varchar">
</cfquery>
<cfelse>
<cfset noinsertlist = noinsertlist&getitem.itemno&",">
</cfif>
</cfloop>
<title>Untitled Document</title><cfif noinsertlist eq "">
<h1>UPDATE FIFO SUCCESS</h1>
<cfelse>
<h1>Partial item no updated into FIFO</h1><br/>
Item No: <br />
<cfoutput>
#noinsertlist#
</cfoutput>
</cfif>