<form action="/default/transaction/assignmentslipnewnew/generateinv.cfm">
<cfoutput>
<h1 style="color:##F00">Only Super User allow to generate invoice!</h1>
</cfoutput>
<cfif HUserGrpID eq 'super'>   
<label>Enter Ref. no: </label>    
<input type="text" name="list" id="list" value="">
<br><input type="submit" value="Submit">
</cfif>

</form>