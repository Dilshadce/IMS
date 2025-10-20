
<cfset multilocationuuid = createuuid()>
<cfset startfrom = 1>
<cfset totalqty = 0>

<cfloop from="#startfrom#" to="#multitranrecordcount#" index="i">
<cfset addmultilocationqty = evaluate('form.multilocationqty_#i#')>
<cfset addmultilocation = evaluate('form.multilocation_#i#')>

<cfif val(addmultilocationqty) neq 0>
<cfquery name="insertbatchtemp" datasource="#dts#">
INSERT INTO tempmultilocation(uuid,refno,type,itemno,qty,location)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#multilocationuuid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multinexttranno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multitran#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiitemno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#addmultilocationqty#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#addmultilocation#">

)
</cfquery>
<cfset totalqty = totalqty+addmultilocationqty>
</cfif>
</cfloop>
<cfoutput>
<div align="center">
<h1>Save Complete</h1>
<input type="hidden" name="totalmultilocationqty" id="totalmultilocationqty" value="#totalqty#" />
<input type="hidden" name="newmultilocationuuid" id="newmultilocationuuid" value="#multilocationuuid#" />
<input type="button" name="clostbtn" id="closebtn" value="Close" 
onclick="document.getElementById('multilocationuuid_#form.bomlocationcurrentrow#').value='#multilocationuuid#';
document.getElementById('bomqty_#form.bomlocationcurrentrow#').value='#val(totalqty)#';document.getElementById('bomitemno#form.bomlocationcurrentrow#').checked='true';
ColdFusion.Window.hide('bomaddmultilocation');"/>
</div>
</cfoutput>