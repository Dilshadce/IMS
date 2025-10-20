<cfquery name="getcostcode" datasource="#dts#">
SELECT * FROM costcodesetup
</cfquery>
<cfoutput>
<cfform name="changecostcodeform" id="changecostcodeform" method="post" action="costcodesetupprocess.cfm">
<table>
<tr>
<th>1</th>
<td><cfinput type="text" name="costcode1" id="costcode1" value="#getcostcode.costcode1#"/>
</td>
</tr>
<tr>
<th>2</th>
<td><cfinput type="text" name="costcode2" id="costcode2" value="#getcostcode.costcode2#"/>
</td>
</tr>
<tr>
<th>3</th>
<td><cfinput type="text" name="costcode3" id="costcode3" value="#getcostcode.costcode3#"/>
</td>
</tr>
<tr>
<th>4</th>
<td><cfinput type="text" name="costcode4" id="costcode4" value="#getcostcode.costcode4#"/>
</td>
</tr>
<tr>
<th>5</th>
<td><cfinput type="text" name="costcode5" id="costcode5" value="#getcostcode.costcode5#"/>
</td>
</tr>
<tr>
<th>6</th>
<td><cfinput type="text" name="costcode6" id="costcode6" value="#getcostcode.costcode6#"/>
</td>
</tr>
<tr>
<th>7</th>
<td><cfinput type="text" name="costcode7" id="costcode7" value="#getcostcode.costcode7#"/>
</td>
</tr>
<tr>
<th>8</th>
<td><cfinput type="text" name="costcode8" id="costcode8" value="#getcostcode.costcode8#"/>
</td>
</tr>
<tr>
<th>9</th>
<td><cfinput type="text" name="costcode9" id="costcode9" value="#getcostcode.costcode9#"/>
</td>
</tr>
<tr>
<th>0</th>
<td><cfinput type="text" name="costcode0" id="costcode0" value="#getcostcode.costcode0#"/>
</td>
</tr>
<tr>
<th>.</th>
<td><cfinput type="text" name="costcodedot" id="costcodedot" value="#getcostcode.costcodedot#"/>
</td>
</tr>
<tr>
<td colspan="2">
<input type="submit" name="sub_btn" id="sub_btn" value="Update" />
</td>
</tr>
</table>

</cfform>
</cfoutput>
