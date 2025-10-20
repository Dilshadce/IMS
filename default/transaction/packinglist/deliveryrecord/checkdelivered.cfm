<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1238,1239,1240,1223,1224,1225,1226,1227,1228,1229,1230,1255,1241,1242,1243,1244,1245,1246,1247,1235,1248,1232,1251,1252,1253,1254">
<cfinclude template="/latest/words.cfm">
<cfajaximport tags="cfform">
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
		if(document.assigndriver.checkall.value=="checkall") {
			for (i = 0; i < chk.length; i++)
				chk[i].checked = true ;
			document.assigndriver.checkall.value="uncheckall";
		}else {
			for (i = 0; i < chk.length; i++)
				chk[i].checked = false ;
			document.assigndriver.checkall.value="checkall";
		}
	}
	function setID(comid) {
		document.getElementById("hiddentext").value = comid;
	}
	function vericheck(fieldvar,opvar,valvar) {
		var button1 = fieldvar+valvar;
		var button2 = opvar + valvar;
		var btnobj1 = document.getElementById(button1);
		var btnobj2 = document.getElementById(button2);
		if(btnobj1.checked == true) {
			btnobj2.checked = false;
		}
	}
	function closewindow() {
		ajaxFunction1(document.getElementById('ajaxField'),'checkdeliveredajax.cfm?datepackfrom='+document.getElementById('datepackfrom').value+'&datepackto='+document.getElementById('datepackto').value+'&packidfrom='+document.getElementById('packidfrom').value+'&packidto='+document.getElementById('packidto').value);
		ColdFusion.Window.hide('deliverlist');
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
    <a href="/default/transaction/packinglist/packingreport.cfm">#words[1229]#</a>||
    <a href="/default/transaction/packinglist/customerreport.cfm">#words[1230]#</a>

</h4>
<cfquery name="getDriver" datasource="#dts#">
    SELECT * 
    FROM driver
</cfquery>
<h1>#words[1255]#</h1>
<cfquery name="getPackList" datasource="#dts#">
    SELECT * 
    FROM packlist 
    WHERE (driver <> "") AND (delivered_on = "0000-00-00" OR delivered_on IS NULL) AND (delivered_by IS NULL OR delivered_by = "")
    ORDER BY packid 
    LIMIT 100
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
        <td><select name="packidto" id="packidto">
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
        <td colspan="4" align="center"><input type="button" name="GO" id="GO" value="#words[1247]#" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'checkdeliveredajax.cfm?datepackfrom='+document.getElementById('datepackfrom').value+'&datepackto='+document.getElementById('datepackto').value+'&packidfrom='+document.getElementById('packidfrom').value+'&packidto='+document.getElementById('packidto').value);"  />
        </td>
    </tr>
</table>
<div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
        #words[1235]#
    </div>
</div>
<form name="assigndriver" id="assigndriver" action="checkdeliveredpro.cfm" method="post">
    <table width="800px">
        <tr>
            <th>#UCase(words[1248])#</th>
            <td>:</td>
            <td><input type="text" id="deliverydate" name="deliverydate" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverydate);">&nbsp;(DD/MM/YYYY)</td>
        </tr>
    </table>
    <table width="800px">
        <tr>
            <th width="100">#UCase(words[1232])#</th>
            <th width="150">#UCase(words[1251])#</th>
            <th width="150">#UCase(words[1252])#</th>
            <th width="100">#UCase(words[1253])#</th>
        </tr>
    </table>
    <div id="ajaxField">
        <table width="800px">
            <cfloop query="getPackList">
				<tr onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getPackList.packID#');" onMouseOut="javascript:this.style.backgroundColor='';">
                    <td width="100">
                    <u><a onMouseOver="style.cursor='hand'" onClick="javascript:ColdFusion.Window.show('deliverlist');">#getPackList.packID#</a></u>
                    </td>
                    <td width="150">#dateformat(getPackList.delivery_on,'YYYY-MM-DD')#</td>
                    <cfquery name="getdriver" datasource="#dts#">
                        SELECT Name
                        FROM driver 
                        WHERE driverno = "#getPackList.driver#" 
                    </cfquery>
                    <td width="150">#getdriver.name#</td>
                    <td width="100"><input type="checkbox" name="packID" id="packID" value="#getPackList.packID#"  /></td>
            </tr>
            </cfloop>
            <tr>
            	<td colspan="4">&nbsp;</td>
            </tr>
			<tr>
				<td colspan="4" align="center"><input type="submit" name="SUBMIT" id="SUBMIT" value="#words[1254]#"  /></td>
            </tr>
        </table>
    </div>
    <input type="hidden" name="hiddentext" id="hiddentext" value=""  />
</form>
<cfwindow center="true" width="400" height="400" name="deliverlist" refreshOnShow="true"
        title="Delivery List" initshow="false"
        source="/default/transaction/packinglist/deliveryrecord/listdeliver.cfm?packid={hiddentext}" modal="true" />
</cfoutput>
</body>
</html>
