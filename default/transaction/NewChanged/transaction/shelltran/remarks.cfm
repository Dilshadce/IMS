<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getextraremark" datasource="#dts#">
select * from extraremark
</cfquery>

<cfoutput>
<cfform action="" method="post" onsubmit="" name="ccformremark"  id="ccformremark">
<table width="570px" >
<tr style="display:none">
<th colspan="100%"><div align="center">Delivery Address</div></th>
</tr>
<tr style="display:none">
<td width="250px" style="font-size:16px;" height="30px">Name</td>
<td width="20px" style="font-size:16px;">:</td>
<td width="300px" align="left" style="font-size:16px;">
<cfquery name="getcust" datasource="#dts#">
select name,name2,daddr1,daddr2,daddr3,daddr4,dattn,dphone,dfax from #target_arcust# where custno='#url.custno#'
</cfquery>
<input type="text" name="delname" id="delname" value="#getcust.name#" maxlength="40" size="50" /> <input type="button" name="changedaddr" id="changedaddr" onClick="ColdFusion.Window.show('changedaddr');" value="Change Del Add">
</td>
</tr>
<tr style="display:none">
<td width="250px" style="font-size:16px;" height="30px"></td>
<td width="20px" style="font-size:16px;"></td>
<td width="300px" align="left" style="font-size:16px;"><input type="text" name="delname2" id="delname2" value="#getcust.name2#" maxlength="40" size="50" /></td>
</tr>
<tr style="display:none">
<td style="font-size:16px; color:##000;">Delivery Address</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="deladd1" id="deladd1" value="#getcust.daddr1#" maxlength="40" size="50" />
</td>
</tr>

<tr style="display:none">
<td style="font-size:16px; color:##000;"></td>
<td style="font-size:16px;"></td>
<td style="font-size:16px;" align="left">
<input type="text" name="deladd2" id="deladd2" value="#getcust.daddr2#" maxlength="40" size="50" />
</td>
</tr>

<tr style="display:none">
<td style="font-size:16px; color:##000;"></td>
<td style="font-size:16px;"></td>
<td style="font-size:16px;" align="left">
<input type="text" name="deladd3" id="deladd3" value="#getcust.daddr3#" maxlength="40" size="50" />
</td>
</tr>

<tr style="display:none">
<td style="font-size:16px; color:##000;"></td>
<td style="font-size:16px;"></td>
<td style="font-size:16px;" align="left">
<input type="text" name="deladd4" id="deladd4" value="#getcust.daddr4#" maxlength="40" size="50" />
</td>
</tr>
<tr style="display:none">
<td style="font-size:16px; color:##000;">Delivery Attention</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="delattn" id="delattn" value="#getcust.dattn#" maxlength="40" size="50" />
</td>
</tr>
<tr style="display:none">
<td style="font-size:16px; color:##000;">Delivery Tel</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="deltel" id="deltel" value="#getcust.dphone#" maxlength="40" size="50" />
</td>
</tr>
<tr style="display:none">
<td style="font-size:16px; color:##000;">Delivery Fax</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="delfax" id="delfax" value="#getcust.dfax#" maxlength="40" size="50" />
</td>
</tr>


</tr>
<tr>
<th colspan="100%"><div align="center">Remarks</div></th>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem6#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<cfinput type="text" name="hidrem6" id="hidrem6" value="" maxlength="80" size="20" onblur="validatetime('hidrem6')"/>
<input type="button" name="generatedatetime" id="generatedatetime" onclick="document.getElementById('hidrem6').value='#dateformat(now(),'DD/MM/YYYY')#'+' #timeformat(now(),'HH:MM')#'" value="Start Time" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem7#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<cfinput type="text" name="hidrem7" id="hidrem7" value="" maxlength="80" size="20" onblur="validatetime('hidrem7')"/>
<cfinput type="button" name="generatedatetime2" id="generatedatetime2" onclick="document.getElementById('hidrem7').value='#dateformat(now(),'DD/MM/YYYY')#'+' #timeformat(now(),'HH:MM')#'" value="Complete Time" />
</td>
</tr>

<tr style="display:none">
<td style="font-size:16px;">#getgsetup.rem8#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem8" id="hidrem8" value="" maxlength="80" size="20" onblur="validatedate('hidrem8')"/>
<!---<select name="rem8selectbox" id="rem8selectbox" onchange="DateAdd('m',this.value,Format(document.getElementById('wos_date').value.substring(3,5)+'/'+document.getElementById('wos_date').value.substring(0,2)+'/'+document.getElementById('wos_date').value.substring(6,10),'mm-dd-yyyy'));">
<option value="0">Select Month</option>
<option value="3">3 Month</option>
<option value="6">6 Month</option>
</select>--->
</td>
</tr>

<tr style="display:none">
<td style="font-size:16px;">#getgsetup.rem9#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem9" id="hidrem9" value="" maxlength="80" size="50" />
</td>
</tr>

<tr style="display:none">
<td style="font-size:16px;">#getgsetup.rem10#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem10" id="hidrem10" value="" maxlength="80" size="50" />
</td>
</tr>

<tr>
<td style="font-size:16px;">#getgsetup.rem11#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem11" id="hidrem11" value="" maxlength="200" size="50"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">#getextraremark.rem30#</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<input type="text" name="hidrem30" id="hidrem30" value="" maxlength="200" size="50"/>
</td>
</tr>

<tr>
<td align="center" colspan="3"><input type="button" name="remarkbtn" id="remarkbtn" value="Accept" onclick="updateremark();ColdFusion.Window.hide('remarks');"/></td>
</tr>
</table>
</cfform>

</cfoutput>