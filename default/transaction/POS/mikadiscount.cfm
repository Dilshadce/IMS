

<cfoutput>
<div align="center">
<cfform action="mikadiscountprocess.cfm?type=#type#" method="post">
<h4>Please Key in Password for Allow Discount</h4>
<input type="hidden" name="mikadiscountvalue" id="mikadiscountvalue" value="#url.discount#" />
<cfinput type="password" name="passwordString" id="passwordString" required="yes" validateat="onsubmit" message="Password is Required"><br/><br />
<input type="submit" name="btn_sub" value="Submit">&nbsp;&nbsp;
<cfif type eq "1">
<input type="button" name="can_sub" value="Cancel" onClick="ColdFusion.Window.hide('mikadiscountpassword');">
<cfelse>
<input type="button" name="can_sub" value="Cancel" onClick="ColdFusion.Window.hide('mikadiscountpassword2');">
</cfif>
</cfform>
</div>
</cfoutput>