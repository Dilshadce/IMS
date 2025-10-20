<cfoutput>
<cfform name="disclimitvalidatepass1" id="disclimitvalidatepass1" action="disclimitvalidatepassprocess.cfm" >
<table align="center">
<td align="center">
<h3>Discount Limit Reached!<br/>Please key in password to by pass</h3>
<cfinput type="password" name="pass_word" id="pass_word" value="" required="yes" message="Password is required!"/>
<input type="submit" name="sub_btn" id="sub_btn" value="GO">
</td>
</cfform>
</cfoutput>