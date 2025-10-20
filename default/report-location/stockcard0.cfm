<html>
<head>
<title>Location Stock Card Report</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>


<!---TRY: To check if got perform year end before--->
<cftry>
    <cfquery name="getgeneral" datasource="#dts#">
        select lastaccyear from gsetup
    </cfquery>
    
    <cfquery name="getprevlastaccyear" datasource="#dts#">
        select LastAccDate,ThisAccDate FROM icitem_last_year group by LastAccDate,ThisAccDate order by LastAccDate desc
    </cfquery>
    
    
    <body>
    <h1 align="center">
    View Location Stock Card Report
    </h1>
    <form name="itemform" action="location_stockcard_stock_card.cfm" method="post">
    <table border="0" align="center" width="65%" class="data">
        <tr>
            <th width="20%">Transaction Range</th>
            <td width="*">&nbsp;
                <cfoutput>
                <select name="lastaccdaterange">
                    <option value="">#dateformat(getgeneral.lastaccyear,"dd/mm/yyy")# - #dateformat(now(),"dd/mm/yyy")#</option>
                    <cfloop query="getprevlastaccyear">
                    <option value="#getprevlastaccyear.LastAccDate#">#dateformat(getprevlastaccyear.LastAccDate,"dd/mm/yyy")# - #dateformat(getprevlastaccyear.ThisAccDate,"dd/mm/yyy")#</option>
                    </cfloop>
                </select>
                </cfoutput>
                &nbsp;&nbsp;<input type="submit" value="Submit">
            </td>
        </tr>
    </table>
    </form>
    </body>
    </html>
    
<cfcatch type="any">
	<cfoutput>
		<script language="javascript">
            window.location = "location_stockcard_stock_card.cfm"
        </script>
    </cfoutput>
</cfcatch>    
</cftry>    