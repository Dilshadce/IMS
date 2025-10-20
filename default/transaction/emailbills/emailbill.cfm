<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "2145,54,55,2146">
<cfinclude template="/latest/words.cfm">

<cfoutput>

<cfform name="emailbill" action="/default/transaction/emailbills/emailbillprocess.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" method="post">
<table align="center">
<tr><th colspan="2">#words[2145]#</th></tr>
<input type="hidden" name="sendbill2" id="sendbill2" value="" />
<tr><td align="center"><input type="submit" name="sendbill" id="sendbill" value="#words[54]#" onclick="document.getElementById('sendbill2').value='Yes';" /></td><td align="center"><input type="submit" name="sendbill" id="sendbill" value="#words[55]#" onclick="document.getElementById('sendbill2').value='No';" /></td></tr>
<tr><td align="left" colspan="2"><input type="checkbox" name="donotshow" id="donotshow" value="Y" />#words[2146]# #url.tran#</td></tr>

</table>
</cfform>

</cfoutput>