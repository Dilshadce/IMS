<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1238,1239,1240,1223,1224,1225,1226,1227,1228,1229,1230,1241,1242,1243,1244,1245,1246,1247,1235,1234,1248,1249,1232,1233,1236,1250">
<cfinclude template="/latest/words.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfoutput>
<cfif isdefined('url.result')>
	<cfif url.result eq "success">
		<cfset msg = "#words[1238]#">
    <cfelseif url.result eq "no">
		<cfset msg = "#words[1239]#">
    <cfelseif url.result eq "fail">
		<cfset msg = "#words[1240]#">
    <cfelse>
		<cfset msg = "">
    </cfif>
	<script type="text/javascript">
		alert('#msg#');
    </script>
</cfif>
</cfoutput>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
	function checkalllist(chk) {
		if(document.assigndriver.checkall.value=="checkall"){
			for (i = 0; i < chk.length; i++)
				chk[i].checked = true ;
			document.assigndriver.checkall.value="uncheckall";
		}else{
			for (i = 0; i < chk.length; i++)
				chk[i].checked = false ;
			document.assigndriver.checkall.value="checkall";
		}
	}
</script>
<title><cfoutput>#words[1223]#</cfoutput></title>
</head>

<body style="width:1000px; margin: 0 auto; text-align:left">
<cfoutput>
<h4>
	<a href="/default/transaction/packinglist/packinglistmain.cfm">#words[1224]#</a> || 
	<a href="/default/transaction/packinglist/listpackingmain.cfm">#words[1225]#</a> || 
	<a href="/default/transaction/packinglist/assigndrivermain.cfm">#words[1226]#</a>||
    <a href="/default/transaction/packinglist/deliveryrecord/checkdelivered.cfm">#words[1227]#</a>||
    <a href="/default/transaction/packinglist/standardreport.cfm">#words[1228]#</a>||
    <a href="/default/transaction/packinglist/packinglistreportmenu.cfm">#words[1229]#</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">#words[1230]#</a>
</h4>
<cfquery name="getDriver" datasource="#dts#">
    SELECT * 
    FROM driver
</cfquery>
<h1>#words[1226]#</h1>
<cfquery name="getPackList" datasource="#dts#">
    SELECT * 
    FROM packlist 
    WHERE driver IS NULL OR driver = "" 
    ORDER BY created_on 
</cfquery>
<br/>
<table width="800px">
    <tr>
        <th>#words[1241]#</th>
    </tr>
    <tr>
        <td>#words[1242]#</td>
        <td>
        <select name="packidfrom" id="packidfrom">
            <option value="">#words[1243]#</option>
            <cfloop query="getPackList">
                <option value="#getPackList.packID#">#getPackList.packID#</option>
            </cfloop>
        </select>
        </td>
        <td>#words[1244]# (DD/MM/YYYY)</td>
        <td>
        <input type="text" id="datepackfrom" name="datepackfrom" value="" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datepackfrom);">
        </td>
    </tr>
    <tr>
        <td>#words[1245]#</td>
        <td>
        <select name="packidto" id="packidto">
            <option value="">#words[1243]#</option>
            <cfloop query="getPackList">
                <option value="#getPackList.packID#">#getPackList.packID#</option>
            </cfloop>
        </select></td>
        <td>#words[1246]# (DD/MM/YYYY)</td>
        <td>
        <input type="text" id="datepackto" name="datepackto" value="" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datepackto);">
        </td>
    </tr>
    <tr>
        <td colspan="4" align="center"><input type="button" name="GO" id="GO" value="#words[1247]#" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'assigndrivermainAjax.cfm?datepackfrom='+document.getElementById('datepackfrom').value+'&datepackto='+document.getElementById('datepackto').value+'&packidfrom='+document.getElementById('packidfrom').value+'&packidto='+document.getElementById('packidto').value);"  /></td>
    </tr>
</table>
<div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
        #words[1235]#
    </div>
</div>
<form name="assigndriver" id="assigndriver" action="/default/transaction/packinglist/assigndriverprocess.cfm" method="post">
    <table width="800px">
        <tr>
            <th>#words[1234]#</th>
            <td>:</td>
            <td>
            <select name="driver" id="driver">
                <cfloop query="getDriver">
                    <option value="#getDriver.DRIVERNO#">#getDriver.DRIVERNO#-#getDriver.NAME#</option>
                </cfloop>
            </select>
            </td>
            <th>#words[1248]#</th>
            <td>:</td>
            <td><input type="text" id="deliverydate" name="deliverydate" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverydate);">&nbsp;(DD/MM/YYYY)</td>
            <th>#words[1249]#</th>
            <td><input type="text" id="trip" name="trip" value=""></td>
        </tr>
    </table>
    <table width="800px">
        <tr>
            <th width="100">#UCase(words[1232])#</th>
            <th width="150">#UCase(words[1233])#</th>
            <th width="150">#UCase(words[1236])#</th>
            <th width="100">
            <input type="checkbox" name="checkall" id="checkall" onClick="checkalllist(document.assigndriver.packID)" value="checkall"  >#words[1250]#
            </th>
        </tr>
    </table>
    <div id="ajaxField">
        <table width="800px">
            <cfloop query="getPackList">
                <tr>
                    <td width="100">#getPackList.packID#</td>
                    <cfif getPackList.Created_on lt getPackList.updated_on >
                        <cfset datepacked = getPackList.updated_on>
                    <cfelse>
                        <cfset datepacked = getPackList.Created_on>
                    </cfif>
                    <td width="150">#datepacked#</td>
                    <cfif getPackList.updated_by neq "">
                        <cfset packedby = getPackList.updated_by>
                    <cfelse>
                        <cfset packedby = getPackList.created_by>
                    </cfif>
                    <td width="150">#packedby#</td>
                    <td width="100"><input type="checkbox" name="packID" id="packID" value="#getPackList.packID#"  /></td>
                </tr>
            </cfloop>
            <tr>
                <td colspan="4">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="4" align="center"><input type="submit" name="SUBMIT" id="SUBMIT" value="#words[1250]#"  /></td>
            </tr>
        </table>
    </div>
</form>
</cfoutput>
</body>
</html>