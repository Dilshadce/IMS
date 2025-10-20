<cfif isdefined('form.emptydb')>
<cfquery name="getlist" datasource="#dts#">
show tables from #dts#
</cfquery>
<cfloop query="getlist">
<cfset tablename = evaluate('getlist.tables_in_#dts#')>
<cfquery name="getcolumns" datasource="#dts#">
show columns FROM #tablename#
</cfquery>

<cfquery name="truncateempty" datasource="#dts#">
truncate #form.emptydb#.#tablename#
</cfquery>

<cfquery name="insertall" datasource="#dts#">
INSERT INTO #form.emptydb#.#tablename# 
(
<cfloop query="getcolumns">
`#getcolumns.field#`<cfif getcolumns.recordcount neq getcolumns.currentrow>,</cfif>
</cfloop>
)
SELECT
<cfloop query="getcolumns">
`#getcolumns.field#`<cfif getcolumns.recordcount neq getcolumns.currentrow>,</cfif>
</cfloop>
FROM
#tablename#
</cfquery>

</cfloop>
</cfif>
<cfform name="form1" id="form1" action="" method="post">
<input type="text" name="emptydb" id="emptydb">
<input type="submit" name="sub_btn" id="sub_btn" value="Submit">
</cfform>
