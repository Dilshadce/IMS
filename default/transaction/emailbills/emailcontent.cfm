<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1597,22,2147,2148,2149,2150,352,808">
<cfinclude template="/latest/words.cfm">

<cfquery name="getformat" datasource="#dts#">
	SELECT * FROM customized_format WHERE type='#url.tran#'
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * FROM gsetup
</cfquery>

<cfquery name="getuserdetail" datasource="main">
	SELECT emailsignature,useremail FROM users	WHERE 
    userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#"> and
    userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#dts#">
</cfquery>

<cfquery name="getbilldetail" datasource="#dts#">
	SELECT * FROM artran WHERE 
    refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#"> and
    type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
</cfquery>

<cfoutput>

<cfform name="emailcontent" action="/default/transaction/emailbills/emailcontentprocess.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" method="post">
<table align="center">
<tr><th>#words[1597]# :</th><td>
<select name="billname" id="billname">
<cfif getGsetup.wpitemtax EQ ''>
<cfif getGsetup.compro6 EQ 'Malaysia' OR getGsetup.bcurr EQ 'MYR'>
<option value="dfnongstitem">Default Format(Non GST)</option>
<option value="dfgstitem">Default Format(GST)</option>
<cfelse>
<option value="dfnormalitem">Default Format</option>
</cfif>
<cfelse>

<cfif getGsetup.compro6 EQ 'Malaysia' OR getGsetup.bcurr EQ 'MYR'>
<option value="dfnongstbill">Default Format(Non GST)</option>
<option value="dfgstbill">Default Format(GST)</option>
<cfelse>
<option value="dfnormalbill">Default Format</option>
</cfif>

</cfif>

<cfloop query="getformat">
<option value="#getformat.FILE_NAME#">#getformat.display_name#</option>
</cfloop>
</select>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<th>
    	#words[22]#:
    </th>
	<td>
    	<cfinput type="text" name="emailto" id="emailto" value="#getbilldetail.e_mail#" size="75" required="yes" message="Please Key In Email To!" />
    </td>
</tr>

<tr>
	<th>
    	#words[2147]#:
    </th>
	<td>
    	<input type="text" name="emailcc" id="emailcc" value="" size="75" />
    </td>
</tr>
<tr>
	<th>
    	BCC:
    </th>
	<td>
    	<input type="text" name="emailbcc" id="emailbcc" value="#getuserdetail.useremail#" size="75" />
    </td>
</tr>

<tr>
	<th>
    	#words[2148]#:
    </th>
	<td>
    	<input type="text" name="emailreplyto" id="emailreplyto" value="#getuserdetail.useremail#" size="75" />
    </td>
</tr>
<tr>
	<th>
    	#words[2149]#:
    </th>
	<td>
    	<input type="text" name="emailsubject" id="emailsubject" value="#url.tran#-#url.nexttranno#" size="75" />
    </td>
</tr>
<tr>
	<th>
    	#words[2150]#:
    </th>
	<td>
    	<textarea name="emaildetail" id="emaildetail" cols="76" rows="15"></textarea>
    </td>
</tr>

<tr><td align="center" colspan="2"><input type="submit" name="submit" id="submit" value="#words[808]#" /></td></tr>


</table>
</cfform>

</cfoutput>