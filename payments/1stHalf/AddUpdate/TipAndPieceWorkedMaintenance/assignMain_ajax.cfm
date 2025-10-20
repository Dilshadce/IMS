<cfquery name="tipPoint_qry" datasource="#dts#">
SELECT a.empno,a.brate,a.name,a.payrtype,a.dcomm,a.dresign,
b.empno,b.tippoint 
FROM pmast AS a LEFT JOIN paytra1 AS b ON a.empno=b.empno WHERE a.paystatus = "A" <cfif c neq "default">
 and a.empno = '#url.c#'</cfif>
</cfquery>


<form name="eForm" action="assignMain_add.cfm" method="post">
		<table class="form" border="0">	
		<tr>
			<th width="160px">Employee No.</th>
			<th width="120px">Basic Rate</th>
			<th width="120px">Tip Point</th>
		</tr>
		<cfoutput query="tipPoint_qry">
		<tr onclick="showFoot('#tipPoint_qry.currentrow#');">
			<td>
				<input type="text" id="empno" name="empno" value="#tipPoint_qry.empno#" size="25" readonly="yes" />
			</td>
			<td>
				<input type="text" name="brate" value="#tipPoint_qry.brate#" size="18" readonly="yes" />
			</td>
			<td>
				<input type="text" name="tippoint__r#tipPoint_qry.empno#" value="#tipPoint_qry.tippoint#" size="18" maxlength="10" />
			</td>
			
				<input type="hidden" name="empno" id="empno" value="#tippoint_qry.empno#">
				<input type="hidden" name="name_#tippoint_qry.currentrow#" id="name_#tippoint_qry.currentrow#" value="#tippoint_qry.name#">
				<input type="hidden" name="dcomm_#tippoint_qry.currentrow#" id="dcomm_#tippoint_qry.currentrow#" value="#DateFormat(tippoint_qry.dcomm, "dd-mm-yyyy")#">
				<input type="hidden" name="payrtype_#tippoint_qry.currentrow#" id="payrtype_#tippoint_qry.currentrow#" value="<cfif #tippoint_qry.payrtype# eq "M">Monthly<cfelseif #tippoint_qry.payrtype# eq "D">Daily<cfelseif #tippoint_qry.payrtype# eq "H">Hourly</cfif>">
				<input type="hidden" name="dresign_#tippoint_qry.currentrow#" id="dresign_#tippoint_qry.currentrow#" value="#DateFormat(tippoint_qry.dresign, "dd-mm-yyyy")#">
				
		</tr>
		</cfoutput>
		</table>
		<br />
		
		<table border="1">
			<tr>
				<td>Name</td>
				<td>:</td>
				<td width="200"><label id="ename"></label></td>
				<td></td>
				<td>Date Commence</td>
				<td>:</td>
				<td width="125"><label id="edcomm"></label></td>
			</tr>
			<tr>
				<td>Pay Rate Type</td>
				<td>:</td>
				<td><label id="epayrtype"></label></td>
				<td></td>
				<td>Date Resign</td>
				<td>:</td>
				<td><label id="edresign"></label></td>
			</tr>
		</table>
		<br />	
		
	<center>
		<input type="submit" name="save" value="Save">
		<input type="button" name="cancel" value="Cancel" onclick="window.location.href='tnpList.cfm';">
	</center>
	</form>