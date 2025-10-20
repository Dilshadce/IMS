<cfoutput>
<div align="center">
<cfform action="/default/transaction/exampass/examPassProcess.cfm?type=#url.type#" method="post">
<cfset task = "">
<cfif url.type eq "delete">
<cfset task = "Delete">
<cfelseif url.type eq "printing">
<cfset task = "Second Printing">
</cfif>
<h4>Please Key in Password for #task#</h4>
<cfinput type="password" name="passwordString" required="yes" validateat="onsubmit" message="Password is Required"><br/><br />
<input type="submit" name="btn_sub" value="Submit">
 </cfform>
</div>
</cfoutput>