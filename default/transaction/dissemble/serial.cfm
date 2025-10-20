		<cfquery name="getinfo" datasource="#dts#">
	select itemno,type,refno,batchcode,
	location
	from receivetemp where trancode='#url.trancode#' and uuid='#url.uuid#'
</cfquery>
        
        <cfquery name="gettempserialno" datasource="#dts#">
		select * from iserialtemp where uuid='#url.uuid#' and trancode='#url.trancode#'
		</cfquery>
        
        <h1>Serial No Selection Screen</h1>
		<br>
		<cfform name="form1" action="" method="post">
        <cfoutput>
        <table class="data">
            <tr>
              <th rowspan="4" width="100px"><cfoutput>getgsetup.lserial</cfoutput></th>
              <th width="150px">Prefix :</th>
              <td><input type="text" name="prefix" id="prefix" value="#getinfo.batchcode#" size="10" /></td>
            </tr>
            <tr>
              <th>Running Number From :</th>
              <td><cfinput type="text" name="runningnumfr" id="runningnumfr" value="" size="10" /></td>
            </tr>
            <tr>
              <th>Running Number To :</th>
              <td><cfinput type="text" name="runningnumto" id="runningnumto" value="" size="10" /></td>
            </tr>
            <tr>
              <th>End Fix :</th>
              <td><input type="text" name="endfix" id="endfix" size="5" /></td>
              <td><input type="button" name="add_text2" value="Add" onClick="ajaxFunction(document.getElementById('addserialajaxfield'),'/default/transaction/dissemble/serialajax.cfm?uuid=#url.uuid#&trancode=#url.trancode#&itemno='+escape(encodeURI(document.getElementById('serialitemno').value))+'&prefix='+document.getElementById('prefix').value+'&runningnumfr='+document.getElementById('runningnumfr').value+'&runningnumto='+document.getElementById('runningnumto').value+'&endfix='+document.getElementById('endfix').value+'&type=multiadd');"></td>
            </tr>
          </table>
        </cfoutput>
        
        <table class="data">
		<tr>
			<th width="50">No</th>
			<th>Serial No</th>
			<th width="70">Action</th>
		</tr>
        <cfoutput>
		<tr>
			<td>New</td>
			<td align="right"><input type="hidden" name="serialitemno" id="serialitemno" value="#getinfo.itemno#"><input type="text" name="text_serialno" id="text_serialno" maxlength="100" size="30"></td>
			<td><input type="button" name="add_text" value="Add" onClick="ajaxFunction(document.getElementById('addserialajaxfield'),'/default/transaction/dissemble/serialajax.cfm?uuid=#url.uuid#&trancode=#url.trancode#&itemno='+escape(encodeURI(document.getElementById('serialitemno').value))+'&serialno='+document.getElementById('text_serialno').value+'&type=add');"></td>
	
		</tr>
        </cfoutput>
		</table>
        <div id="addserialajaxfield">
		<table class="data">
		<tr>
			<th>Serial No</th>
            <th>Action</th>
		</tr>
		<cfoutput>
        <cfloop query="gettempserialno">
		<tr>
			<td>#gettempserialno.serialno#</td>
            <td><input type="button" name="add_text" value="Delete" onClick="ajaxFunction(document.getElementById('addserialajaxfield'),'/default/transaction/dissemble/serialajax.cfm?uuid=#url.uuid#&trancode=#url.trancode#&itemno='+escape(encodeURI(document.getElementById('serialitemno').value))+'&serialno=#gettempserialno.serialno#&type=delete');"></td>
		</tr>
        </cfloop>
		</cfoutput>
		</table>
		</div>
        <div align="center"><input type="button" value="Close" onClick="ColdFusion.Window.hide('rcserial');"></div>
	</cfform>
