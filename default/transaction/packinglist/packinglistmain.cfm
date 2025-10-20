<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1223,1224,1225,1226,1227,1228,1229,1230,1223,1088,690,673,665,666,185,1210,1211,1235">
<cfinclude template="/latest/words.cfm">
<html>
<head>
<title><cfoutput>#words[1223]#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
	function checkalllist(chk) {
		if(document.packinglist.checkall.value=="checkall") {
			for (i = 0; i < chk.length; i++)
				chk[i].checked = true ;
			document.packinglist.checkall.value="uncheckall";
		}
		else{
			for (i = 0; i < chk.length; i++)
				chk[i].checked = false ;
			document.packinglist.checkall.value="checkall";
		}
	}
</script>
</head>

<body>
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
<div align="center" >  
    <h1>#words[1223]#</h1>
    <table >
        <tr>
            <th>#words[1088]#</th>
            <td>:</td>
            <td><select name='reftype' id='reftype'>
                <option value='PO'>#words[690]#</option>
                <option value='SO' selected>#words[673]#</option>
                <option value='DO'>#words[665]#</option>
                <option value='INV'>#words[666]#</option>
                <option value='CS'>#words[185]#</option>
            </select>
            </td>
            <td></td>
            <th>Last Used Pack No</th>
            <cfquery name="getlas" datasource="#dts#">
                SELECT lastusedno,refnoused 
                FROM refnoset 
                WHERE type = "PACK" 
            </cfquery>
            <td>:</td>
            <cfif getlas.refnoused neq "1">
                <td><input type="text" name="packno1" id="packno1" maxlength="12" /></td>
            <cfelse>
                <td>#getlas.lastusedno#</td>
            </cfif>
            <td></td>
        </tr>
        <tr>
            <th>#words[1210]#</th><td>:</td><td><input type="text" id="datefrom" name="datefrom" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;
            <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">&nbsp;(DD/MM/YYYY)</td> 
            <td>&nbsp;
            
            </td>
            <th>#words[1211]#</th>
            <td>:</td>
            <td><input type="text" id="dateto" name="dateto" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;
            <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">&nbsp;(DD/MM/YYYY)</td>
            <td>&nbsp;</td>
            <td><input type="button" name="Go" id="Go" value="GO" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'packinglistmainajax.cfm?datefrom='+document.getElementById('datefrom').value+'&dateto='+document.getElementById('dateto').value+'&reftype='+document.getElementById('reftype').value);" ></td>
        </tr>
    </table>
    <div id="ajaxField"></div>
    <div id="loading" style="visibility:hidden">
        <div class="loading-indicator">
            #words[1235]#
        </div>
    </div>
    <div id="ajaxField2"></div>
</div>
</cfoutput>
</body>
</html>