<cfoutput>
<div align="center">
<cfquery datasource='#dts#' name="getartran">
	select * from artran where refno='#refno#' and type = "#tran#"
</cfquery>

<cfform action="editbillcontrolprocess.cfm?tran=#url.tran#&ttype=Edit&refno=#url.refno#" method="post">
<h4>Please Key in Password for Allow Edit Bill</h4>
<cfinput type="password" name="passwordString" id="passwordString" required="yes" validateat="onsubmit" message="Password is Required"><br/><br />
<input type="submit" name="btn_sub" value="Submit">&nbsp;&nbsp;<input type="button" name="can_sub" value="Cancel" onClick="window.close();">
 </cfform>
</div>
</cfoutput>

<script type="text/javascript">
document.getElementById('passwordString').focus();
</script>