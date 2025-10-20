<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfoutput>
<form action="" method="post" onsubmit="" name="ccformremark"  id="ccformremark">
<table width="570px" >
<tr>
<th colspan="100%"><div align="center">Remarks</div></th>
</tr>
<tr>
<td style="font-size:16px;">#getgsetup.rem5#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem5" id="hidrem5" value="" maxlength="80" size="50" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem6#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem6" id="hidrem6" value="" maxlength="80" size="50" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem7#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem7" id="hidrem7" value="" maxlength="80" size="50" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem8#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem8" id="hidrem8" value="" maxlength="80" size="50" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem9#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem9" id="hidrem9" value="" maxlength="80" size="50" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem10#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem10" id="hidrem10" value="" maxlength="40" size="50" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem11#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem11" id="hidrem11" value="" maxlength="40" size="50"/>
</td>
</tr>

<tr>
<td align="center" colspan="3"><input type="button" name="remarkbtn" id="remarkbtn" value="Accept" onclick="updateremark();ColdFusion.Window.hide('remarks');"/></td>
</tr>
</table>
</form>

</cfoutput>