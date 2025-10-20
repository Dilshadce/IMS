<cfquery name="detail_qry" datasource="#dts#">
SELECT 	empno,name,payrtype,dcomm,dresign FROM pmast <cfif c neq "default">
WHERE empno = '#url.c#' </cfif>
</cfquery>
	
	<table class="form" border="0">	
		<tr>
			<th>Name</td>
			<th>Pay Rate Type</td>
			<th>Date Commence</td>
			<th>Date Resign</td>
		</tr>
		<cfoutput query="detail_qry">
		<tr>
			<td><input type="text" name="" value="#detail_qry.name#"></td>
			<td><input type="text" name="" value="#detail_qry.payrtype#"></td>
			<td><input type="text" name="" value="#lsdateformat(detail_qry.dcomm,"dd/mm/yyyy")#"></td>
			<td><input type="text" name="" value="#lsdateformat(detail_qry.dresign,"dd/mm/yyyy")#"></td>
		</tr>
		</cfoutput>
	</table>
