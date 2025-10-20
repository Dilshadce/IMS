<cfoutput>
<h3>Print Letter and Status Update</h3>
<table>
<tr>
<th></th>
<th>Interview</th>
<th>Offer</th>
<th>Confirmation</th>
<th>Resignation</th>
</tr>
<tr>
<th>Date</th>
<td> <input type="text" name="dateint" id="dateint" value="#dateformat(now(),'dd/mm/yyyy')#" readonly size="12" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateint'));"> </td><td> <input type="text" name="dateapp" id="dateapp" value="#dateformat(now(),'dd/mm/yyyy')#" readonly size="12" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateapp'));"> </td>
<td> <input type="text" name="dateconf" id="dateconf" value="#dateformat(now(),'dd/mm/yyyy')#" readonly size="12" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateconf'));"> </td>

<td> <input type="text" name="datereg" id="datereg" value="#dateformat(now(),'dd/mm/yyyy')#" readonly size="12" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateapp'));"> </td>
</tr>
<tr>
<th>
Letter Reference
</th>
<td>
</td><td>
<input type="text" name="apprefno" id="apprefno" value="">
</td>
<td>
<input type="text" name="confrefno" id="confrefno" value="">
</td>

<td>
<input type="text" name="regrefno" id="regrefno" value="">
</td>
</tr>
<tr>
<th>Print Letter</th>
<td></td><td>
<a style="cursor:pointer">Print Offer Letter</a>
</td>
<td>
<a style="cursor:pointer" onClick="window.open('printconf.cfm?placementno=#url.placementno#&refno='+escape(document.getElementById('confrefno').value)+'&date='+escape(document.getElementById('dateconf').value));">Print Confirmation Letter</a>
</td>

<td>
<a style="cursor:pointer" onClick="window.open('printreg.cfm?placementno=#url.placementno#&refno='+escape(document.getElementById('regrefno').value)+'&date='+escape(document.getElementById('datereg').value));">Print Resignation Letter</a>
</td>
</tr>

<tr>
<th>Mark Completed</th>
<td align="center">
<input type="checkbox" name="intcheck" id="intcheck">
</td>
<td align="center">
<input type="checkbox" name="appcheck" id="appcheck">
</td>
<td align="center">
<input type="checkbox" name="confcheck" id="confcheck">
</td>
<td align="center">
<input type="checkbox" name="regcheck" id="regcheck">
</td>
</tr><tr>
<td colspan="100%"><div align="center"><input type="button" name="sub_btn" id="sub_btn" onClick="alert('This is demo unit only! You can't save anything into demo unit! Please kindly contact system admistartor!')" value="Save" ></div></td>
</tr>
</table>
</cfoutput>