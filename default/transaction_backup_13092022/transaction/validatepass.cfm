<cfoutput>
<cfform name="validatepass1" id="valudatepass1" action="validatepassprocess.cfm" >
<table align="center">
<td align="center">
<h3>Item Price is Below Minimum Selling Price - #numberformat(val(url.itemprice),',.__')#<br/>Please key in password to by pass</h3>
<cfinput type="password" name="pass_word" id="pass_word" value="" required="yes" message="Password is required!"/>
<input type="hidden" name="price_min" id="price_min" value="#numberformat(val(url.itemprice),',.__')#">
<input type="submit" name="sub_btn" id="sub_btn" value="GO">
</td>
</cfform>
</cfoutput>