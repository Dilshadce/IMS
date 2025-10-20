<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1155,16,23,29,1165,40,42,300,1166,120,65,482,1097,58,227,1096,592,1097">
<cfinclude template="/latest/words.cfm">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<cfquery name="getgsetup" datasource="#dts#">
    SELECT * 
    FROM gsetup
</cfquery>

<cfquery name="getrepairservice" datasource="#dts#">
    SELECT * 
    FROM repairtran 
    WHERE repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
</cfquery>

<cfquery name="getrepairservicebody" datasource="#dts#">
    SELECT * 
    FROM repairdet 
    WHERE repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
</cfquery>

<cfoutput>
<cfform name="createrepairdoform" id="createrepairdoform" action="createrepairDOprocess.cfm" method="post">
    <table width="100%">
        <tr>
            <th >
            <div align="left">Return date</div>
            <input type="hidden" name="repairno" id="repairno" value="#url.repairno#" />
            </th>
            <td colspan="3">
            <cfinput type="text" name="dodate" id="dodate"  value="#dateformat(now(),'DD/MM/YYYY')#" validate="eurodate" required="yes" maxlength="10" size="10">&nbsp;&nbsp;
            <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dodate'));"> (DD/MM/YYYY)
            </td>
        </tr>
        <tr>
            <th><div align="left">Issue BY</div></th>
            <td colspan="3"><cfinput type="text" name="rem30" id="rem30"  value="#huserid#"></td>
        </tr>
        <tr>
            <th><div align="left">Inv. Ref</div></th>
            <td colspan="3"><cfinput type="text" name="refno2" id="refno2"  value=""></td>
        </tr>
        <tr>
            <th><div align="left">#words[1155]#</div></th>
            <td colspan="3">#getrepairservice.repairno#</td>
        </tr>
        <tr>
            <th><div align="left">#words[16]#</div></th>
            <td colspan="3">#getrepairservice.custno#</td>
        </tr>
        <tr>
            <th width="20%"><div align="left">#words[23]#</div></th>
            <td width="30%">#getrepairservice.name#</td>
            <th width="20%"><div align="left">#words[29]#</div></th>
            <td width="30%">#getrepairservice.agent#<input type="hidden" name="agent" id="agent" value="#getrepairservice.agent#" /></td>
        </tr>
        <tr>
            <th><div align="left">Customer Address</div></th>
            <td>#getrepairservice.add1#</td>
            <th><div align="left">Estimated Completion Date</div></th>
            <td>#dateformat(getrepairservice.completedate,"dd/mm/yyyy")#</td>
        </tr>
        <tr>
            <th><div align="left"></div></th>
            <td>#getrepairservice.add2#</td>
            <th><div align="left">#words[1165]#</div></th>
            <td>#getrepairservice.deliverystatus#</td>
        </tr>
        <tr>
            <th><div align="left"></div></th>
            <td>#getrepairservice.add3#</td>
            <th><div align="left">#getgsetup.rem5#</div></th>
            <td>#getrepairservice.rem5#</td>
        </tr>
        <tr>
            <th><div align="left"></div></th>
            <td>#getrepairservice.add4#</td>
            <th><div align="left">#getgsetup.rem6#</div></th>
            <td>#getrepairservice.rem6#</td>
        </tr>
        <tr>
            <th><div align="left">#words[40]#</div></th>
            <td>#getrepairservice.phone#</td>
            <th><div align="left">#getgsetup.rem7#</div></th>
            <td>#getrepairservice.rem7#</td>
        </tr>
        <tr>
            <th><div align="left">#words[42]#</div></th>
            <td>#getrepairservice.phonea#</td>
            <th><div align="left">#getgsetup.rem8#</div></th>
            <td>#getrepairservice.rem8#</td>
        </tr>
        <tr>
            <th><div align="left">#words[300]#</div></th>
            <td>#getrepairservice.fax#</td>
            <th><div align="left">#getgsetup.rem9#</div></th>
            <td>#getrepairservice.rem9#</td>
        </tr>
        <tr>
            <th></th>
            <td></td>
            <th><div align="left">#getgsetup.rem10#</div></th>
            <td>#getrepairservice.rem10#</td>
        </tr>
        <tr>
            <th><div align="left"></div></th>
            <td></td>
            <th><div align="left">#getgsetup.rem11#</div></th>
            <td>#getrepairservice.rem11#</td>
        </tr>
        <tr>
            <th colspan="100%"><div align="center">#words[1166]#</div></th>
        </tr>
        <tr>
            <th>#words[120]#</th>
            <td>#getrepairservice.repairitem#</td>
        </tr>
        <tr>
            <th>#words[65]#</th>
            <td>#getrepairservice.desp#</td>
        </tr>
        <tr>
            <th>#words[482]#</th>
            <td>#getrepairservice.location#</td>
        </tr>
        <tr>
            <th>#words[1097]#</th>
            <td>#numberformat(getrepairservice.grossamt,',_.__')#</td>
        </tr>
        <tr>
            <td colspan="4">
            <table width="100%">
                <tr>
                    <th width="2%">#words[58]#</th>
                    <th width="15%">#words[120]#</th>
                    <th width="30%">#words[65]#</th>
                    <th width="10%">#words[227]#</th>
                    <th width="8%">#words[1096]#</th>
                    <th width="8%">#words[592]#</th>
                    <th width="8%">#words[1097]#</th>
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
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4" align="center"><input type="submit" name="createdobtn" id="createdobtn" value="Create Delivery"  /></td>
        </tr>
    </table>
</cfform>
</cfoutput>