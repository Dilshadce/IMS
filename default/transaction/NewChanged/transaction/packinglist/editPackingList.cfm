<cfset packid = url.packid>
<cfquery name="getPackId" datasource="#dts#">
SELECT * from packlist where packid = "#packid#"
</cfquery>
<cfoutput>
<h1>EDIT PACKING LIST #packid#</h1>
<cfform action="/default/transaction/packinglist/editPackingListProcess.cfm" method="post">
<input type="hidden" name="packid" id="packid" value="#packid#" >
<table width="400px">
<tr>
<th width="70px">Pack ID</th>
<td width="70px">#packid#</td>
<th width="70px">Action</th>
<td width="190px"><input type="button" name="ADDSO" id="ADDSO" value="Add More #getpackid.reftype#" onclick="javascript:ColdFusion.Window.show('addSO');"  />&nbsp;<input type="button" name="deletepacklist" id="deletepacklist" value="Delete Pack List" onclick="deletePackList('#packid#');ColdFusion.Window.hide('editPackList');"  /></td>
</tr>
</table>
<table width="400px">
<tr><th colspan="2" align="center">#getPackId.reftype#</th></tr>
<cfloop list="#getPackId.totalbill#" index="i">
<tr><td>#i#</td><td><input type="checkbox" name="packidlist" id="packidlist" value="#i#" checked="checked"  /></td></tr>
</cfloop>
</table>
<table id="myTable" width="400px">
  <tbody>
  </tbody>
</table>
<table width="400px">
<tr><td colspan="2" align="center"><input type="submit" name="submitbtn" id="submitbtn" value="SUBMIT"  /></td></tr>
</table>

</cfform>
</cfoutput>