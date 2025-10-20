<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1442,1439,352">
<cfinclude template="/latest/words.cfm">
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfparam name="alown" default="0">
<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfset pageTitle = "#words[1442]#">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><cfoutput>#pageTitle#</cfoutput></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<cfquery name="getgeneral" datasource="#dts#">
	SELECT lastaccyear 
    FROM gsetup
</cfquery>

<!---TRY: To check if got perform year end before--->
<cftry>

    <cfquery name="getprevlastaccyear" datasource="#dts#">
        SELECT LastAccDate,ThisAccDate 
        FROM icitem_last_year 
        GROUP BY LastAccDate,ThisAccDate 
        ORDER BY LastAccDate DESC
    </cfquery>
    
    <body class="container">
		<cfoutput>
            <cfform class="formContainer form3Button" name="itemform" id="itemform" action="location_stockcard_stock_card.cfm" method="post">
                <div>#pageTitle#</div>
                <div>
                <table>
                    <tr> 
                        <th><label for="transactionrange">#words[1439]#</label></th>			
                        <td>
                        <cfoutput>
                        <select name="lastaccdaterange">
                        <option value="">#dateformat(getgeneral.lastaccyear,"dd/mm/yyy")# - #dateformat(now(),"dd/mm/yyy")#</option>
                        <cfloop query="getprevlastaccyear">
                        <option value="#getprevlastaccyear.LastAccDate#">#dateformat(getprevlastaccyear.LastAccDate,"dd/mm/yyy")# - #dateformat(getprevlastaccyear.ThisAccDate,"dd/mm/yyy")#</option>
                        </cfloop>
                    </select>
                    </cfoutput>
                        </td>
                    </tr>
                    </table>
                </div>
                <div>
                    <input type="submit" name="result" id="result" value="#words[352]#"  />
                </div>
            </cfform>
        </cfoutput>
	</body>
    <cfcatch>
        <cfoutput>
            <script language="javascript">
                   window.location = "location_stockcard_stock_card.cfm"   
            </script>
        </cfoutput>
    </cfcatch> 
</cftry>  
</html>