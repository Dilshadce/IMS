<cfinvoke component="cfc.dateconvert" method="ndate" olddate="#form.validstart#" returnvariable="validstartdate">
<cfinvoke component="cfc.dateconvert" method="ndate" olddate="#form.validend#" returnvariable="validenddate">

<cfquery name="getrecurrtype" datasource="#dts#">
select recurrtype from recurrgroup where desp='#form.modebill#'
</cfquery>
<cfquery name="insertser" datasource="#dts#">
INSERT INTO serviceagree (servicecode,desp,validstart,validend,modebill,group,created_by,created_on)
VALUES (
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sercode#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.serdesp#">,
"#validstartdate#",
"#validenddate#",
"#getrecurrtype.recurrtype#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.modebill#">,
"#huserid#",
now())
</cfquery>

<cfoutput>
<cfform action="createser.cfm" method="post" name="recreate">
<input type="submit" value="Create another Service Agreement" />&nbsp;&nbsp;&nbsp;<input type="button" value="close"  onclick="closenref();">
</cfform>
</cfoutput>