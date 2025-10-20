<cfoutput>
    <table width="680px">
	<tr>
    <th>Comment</th>
    <td><textarea name="extendedcomment" id="extendedcomment" cols="80" rows="30">#url.comm5#</textarea></td>
    </tr>
    <tr>
    <td colspan="2" align="center"><input type="button" name="Button" value="Done" onClick="document.getElementById('comm5').value = unescape(decodeURI(document.getElementById('extendedcomment').value));ColdFusion.Window.hide('extendcomment');" /></td>
    </tr>
    </table>
    </cfoutput>