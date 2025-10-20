<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>

<cfquery name="getgsetup" datasource="#dts#">
    select * from gsetup
</cfquery>

<cfquery name="getrepairservice" datasource="#dts#">
    select * from repairtran where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
</cfquery>

<cfquery name="getrepairservicebody" datasource="#dts#">
        select * from repairdet where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
        </cfquery>

<cfoutput>
<cfform name="createrepairdoform" id="createrepairdoform" action="createrepairDOprocess.cfm" method="post">
<table width="100%">
<tr>
<th ><div align="left">RETURN DATE</div><input type="hidden" name="repairno" id="repairno" value="#url.repairno#" /></th>
<td colspan="3"><cfinput type="text" name="dodate" id="dodate"  value="#dateformat(now(),'DD/MM/YYYY')#" validate="eurodate" required="yes" maxlength="10" size="10">&nbsp;&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dodate'));"> (DD/MM/YYYY)</td>
</tr>
<tr>
<th><div align="left">ISSUE BY</div></th><td colspan="3"><cfinput type="text" name="rem30" id="rem30"  value="#huserid#"></td>
</tr>
<tr>
<th><div align="left">INV REF</div></th><td colspan="3"><cfinput type="text" name="refno2" id="refno2"  value=""></td>
</tr>

<tr>
<th><div align="left">Repair No</div></th><td colspan="3">#getrepairservice.repairno#</td>
</tr>
<tr>
<th><div align="left">Customer No</div></th><td colspan="3">#getrepairservice.custno#</td>
</tr>
<tr>
<th width="20%"><div align="left">Name</div></th><td width="30%">#getrepairservice.name#</td>
<th width="20%"><div align="left">Agent</div></th><td width="30%">#getrepairservice.agent#<input type="hidden" name="agent" id="agent" value="#getrepairservice.agent#" /></td>
</tr>
<tr>
<th><div align="left">Customer Address</div></th><td>#getrepairservice.add1#</td>
<th><div align="left">Estimated Completion Date</div></th><td>#dateformat(getrepairservice.completedate,"dd/mm/yyyy")#</td>
</tr>
<tr>
<th><div align="left"></div></th><td>#getrepairservice.add2#</td>
<th><div align="left">Delivery Status</div></th><td>#getrepairservice.deliverystatus#</td>
</tr>
<tr>
<th><div align="left"></div></th><td>#getrepairservice.add3#</td>
<th><div align="left">#getgsetup.rem5#</div></th><td>#getrepairservice.rem5#</td>
</tr>
<tr>
<th><div align="left"></div></th><td>#getrepairservice.add4#</td>
<th><div align="left">#getgsetup.rem6#</div></th><td>#getrepairservice.rem6#</td>
</tr>
<tr>
<th><div align="left">Phone</div></th><td>#getrepairservice.phone#</td>
<th><div align="left">#getgsetup.rem7#</div></th><td>#getrepairservice.rem7#</td>
</tr>
<tr>
<th><div align="left">HP</div></th><td>#getrepairservice.phonea#</td>
<th><div align="left">#getgsetup.rem8#</div></th><td>#getrepairservice.rem8#</td>
</tr>
<tr>
<th><div align="left">Fax</div></th><td>#getrepairservice.fax#</td>
<th><div align="left">#getgsetup.rem9#</div></th><td>#getrepairservice.rem9#</td>
</tr>
<tr>
<th></th><td></td>
<th><div align="left">#getgsetup.rem10#</div></th><td>#getrepairservice.rem10#</td>
</tr>
<tr>
<th><div align="left"></div></th><td></td>
<th><div align="left">#getgsetup.rem11#</div></th><td>#getrepairservice.rem11#</td>
</tr>

<tr>
            <th colspan="100%"><div align="center">Item To Repair</div></th>
            </tr>
            <tr>
        		<th>Item No</th>
        		<td>#getrepairservice.repairitem#
				</td>
      		</tr>
            <tr>
        		<th>Description</th>
        		<td>#getrepairservice.desp#
				</td>
      		</tr>
            <tr>
        		<th>Location</th>
        		<td>
                #getrepairservice.location#
				</td>
      		</tr>
            <tr>
            <th>Amount</th>
            <td>#numberformat(getrepairservice.grossamt,',_.__')#</td>
            
            </tr>
<tr>
			<td colspan="4">

			<table width="100%">
			<tr>
			<th width="2%">No</th>
			<th width="15%">Item Code</th>
			<th width="30%">Description</th>
			<th width="10%">Quantity</th>
			<th width="8%">Price</th>
			<th width="8%">Discount</th>
			<th width="8%">Amount</th>
			</tr>
            <cfloop query="getrepairservicebody">
            <tr>
			<td width="2%">#getrepairservicebody.trancode#</td>
			<td width="15%">#getrepairservicebody.itemno#</td>
			<td width="30%">#getrepairservicebody.desp#</td>
			<td width="10%">#getrepairservicebody.qty_bil#</td>
			<td width="8%">#numberformat(getrepairservicebody.price_bil,',_.__')#</td>
			<td width="8%">#numberformat(getrepairservicebody.disamt_bil,',_.__')#</td>
			<td width="8%">#numberformat(getrepairservicebody.amt_bil,',_.__')#</td>
			</tr>
            </cfloop>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td colspan="4" align="center"><input type="submit" name="createdobtn" id="createdobtn" value="Create Delivery"  /></td>
</tr>

</table>
</cfform>
</cfoutput>