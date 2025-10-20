<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfoutput>
<form action="" method="post" onsubmit="" name="ccformremark"  id="ccformremark">
<table width="570px" >
<tr>
<th>Customer Name</th>
<td><input type="text" name="b_hidname" id="b_hidname" value="" maxlength="35" size="40"/></td>
<th>Delivery Name</th><td ><input type="text" name="d_hidname" id="d_hidname" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td><input type="text" name="b_hidname2" id="b_hidname2" value="" maxlength="35" size="40"/></td>
<th></th><td ><input type="text" name="d_hidname2" id="d_hidname2" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Address</th>
<td>
<input type="text" name="b_hidadd1" id="b_hidadd1" value="" maxlength="35" size="40"></td>
<th >Address</th><td ><input type="text" name="d_hidadd1" id="d_hidadd1" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_hidadd2" id="b_hidadd2" value="" maxlength="35" size="40"></td>
<th></th><td><input type="text" name="d_hidadd2" id="d_hidadd2" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_hidadd3" id="b_hidadd3" value="" maxlength="35" size="40"></td>
<th ></th><td ><input type="text" name="d_hidadd3" id="d_hidadd3" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_hidadd4" id="b_hidadd4" value="" maxlength="35" size="40"></td>
<th ></th><td ><input type="text" name="d_hidadd4" id="d_hidadd4" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Tel</th>
<td>
<input type="text" name="b_hidphone" id="b_hidphone" value="" maxlength="25" size="40"></td>
<th >Tel</th><td ><input type="text" name="d_hidphone" id="d_hidphone" value="" maxlength="25" size="40"></td>
</tr>

<tr>
<th>Hp</th>
<td>
<input type="text" name="b_hidphone2" id="b_hidphone2" value="" maxlength="25" size="40"></td>
<th >Hp</th><td ><input type="text" name="d_hidphone2" id="d_hidphone2" value="" maxlength="25" size="40"></td>
</tr>

<tr>
<th>Fax</th>
<td>
<input type="text" name="b_hidfax" id="b_hidfax" value="" maxlength="25" size="40"></td>
<th >Fax</th>
<td ><input type="text" name="d_hidfax" id="d_hidfax" value="" maxlength="25" size="40"></td>
</tr>
<tr>
<th>Attention</th>
<td>
<input type="text" name="b_hidattn" id="b_hidattn" value="" maxlength="35" size="40"></td>
<th >Attention</th>
<td ><input type="text" name="d_hidattn" id="d_hidattn" value="" maxlength="35" size="40"></td>
</tr>

<tr>
<td align="center" colspan="3"><input type="button" name="addbtn" id="addbtn" value="Accept" onclick="updateaddress();ColdFusion.Window.hide('address');"/></td>
</tr>
</table>
</form>

</cfoutput>