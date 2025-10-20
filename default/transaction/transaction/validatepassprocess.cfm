<cfif isdefined('form.pass_word')>
<cfoutput>
<cfquery name="getpass" datasource="#dts#">
    select priceminpass from gsetup
</cfquery>
<cfif form.pass_word eq getpass.priceminpass>
<script type="text/javascript">
document.getElementById('pricemincontrol').value=1;
alert('By Pass Success! You may continue adding item.');
ColdFusion.Window.hide('validatepass');
</script>
<cfelse>
<cfform name="returnform" id="returnform1" action="/default/transaction/validatepass.cfm?itemprice=#numberformat(val(form.price_min),',.__')#" method="post">
<div align="center">
<h2>Password is Incorrect</h2>
<input type="submit" name="sub_return" id="sub_return" value="Go Back">
</div>
</cfform>
</cfif>
</cfoutput>
</cfif>