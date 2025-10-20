<cfoutput>
<cfif hlinkams neq "Y">
<h1>You System is Limited To This Access</h1>
<cfabort>
</cfif>
<cfif isdefined('form.batchp1')>
<cfquery name="updaterec" datasource="#dts#">
UPDATE stockbatches SET
<cfloop from="1" to="18" index="i">
p#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.batchp#i#')#"><cfif i neq 18>,</cfif>
</cfloop>
</cfquery>
</cfif>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<h1>Preset Stock Batches</h1>
<cfform name="batchform" id="batchform" method="post" action="">
<table>
<cfquery name="getaccno" datasource="#replace(dts,'_i','_a')#">
SELECT "" as recno, "Choose a Batch" as desp
UNION ALL
select RECNO,concat(recno, ' - ', desp) as desp from glbatch 
</cfquery>
<cfquery name="getbatches" datasource="#dts#">
SELECT * FROM stockbatches
</cfquery>
<cfloop from="1" to="18" index="i">
<tr><th>Period #i#</th><td><cfselect name="batchp#i#" id="batchp#i#"selected="#evaluate('getbatches.p#i#')#">
<cfloop query="getaccno">
<option value="#tostring(getaccno.recno)#" <cfif evaluate('getbatches.p#i#') eq tostring(getaccno.recno)>Selected</cfif>>#tostring(getaccno.desp)#</option>
</cfloop>
</cfselect></td></tr>
</cfloop>
<tr>
<td colspan="2" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Submit">
</td>
</tr>
</table>
</cfform>
</cfoutput>