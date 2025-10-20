<cfoutput>
<cfif form.empno neq ''>
<cfset totaldedval=0>
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfif #url.type# eq "moreDED">
	
		<cfquery name="mDED_qry" datasource="#dts1#">
			UPDATE paytra1
			SET <cfloop from=101 to=115 index="i">DED#i# = "#val(evaluate('form.DED#i#'))#"<cfif i neq "115">,</cfif></cfloop>
			WHERE empno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
		</cfquery>
	
	<cfloop from=101 to=115 index="i">
    <cfset totaldedval=totaldedval+val(evaluate('form.DED#i#'))>
	</cfloop>
    
	</cfif>
    
    <input type="hidden" name="totaldedamt" id="totaldedamt" value="#totaldedval#" />
    
    <input type="button" name="close" value="Close" onClick="document.getElementById('selfdeduction').value=document.getElementById('totaldedamt').value;document.getElementById('custdeduction').value=document.getElementById('totaldedamt').value;ColdFusion.Window.hide('calempded');">
    <cfelse>
    <h2>Invalid Emp No</h2>
     <input type="button" name="close" value="Close" onClick="ColdFusion.Window.hide('calempded');">
    </cfif>
    
</cfoutput>