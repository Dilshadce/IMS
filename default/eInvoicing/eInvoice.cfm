<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1199,1200,1201,953,1207,1202,1204,1203,1205,1208,1184,1183,1209,1210,1211,1212,1213,1214,1206">
<cfinclude template="/latest/words.cfm">
<html>
<cfquery name="getgeneral" datasource="#dts#">
	SELECT lastaccyear 
    FROM gsetup
</cfquery>
<cfset dts2=replace(dts,'_i','','all')>
<cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth 
    FROM gsetup 
    WHERE comp_id = "#dts2#"
</cfquery>
<cftry>
	<cfset payrolldate=createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1)))>
<cfcatch type="any">
	<cfset payrolldate = dateadd('d',1,createdate(year(getgeneral.lastaccyear),month(getgeneral.lastaccyear),day(getgeneral.lastaccyear)))>
</cfcatch>
</cftry>
<cfset lastaccdate = dateadd('d',1,createdate(year(getgeneral.lastaccyear),month(getgeneral.lastaccyear),day(getgeneral.lastaccyear)))>
<cfset currentperiod = datediff('m',lastaccdate,payrolldate)+1>
<head>
<title><cfoutput>#words[1199]#</cfoutput></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfoutput>
<script type="text/javascript">
	function searchSel(fieldid,textid) {
		var input=document.getElementById(textid).value.toLowerCase();
		var output=document.getElementById(fieldid).options;
		for(var i=0;i<output.length;i++) {
			if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
				output[i].selected=true;
				if(fieldid == 'invfrm')  {
					document.getElementById('invto').options[i].selected=true;
				}
				break;
			}
			if(document.getElementById(textid).value==''){
				output[0].selected=true;
			}
		}
	}
	function checkalllist(chk) {
		if(document.einvoice.checkall.value=="checkall"){
			for (i = 0; i < chk.length; i++)
				chk[i].checked = true ;
			document.einvoice.checkall.value="uncheckall";
		}
		else{
			for (i = 0; i < chk.length; i++)
				chk[i].checked = false ;
			document.einvoice.checkall.value="checkall";
		}
	}
	function getList() {
		var invfrom = document.getElementById('invfrm').value;
		var invto = document.getElementById('invto').value;
		var comfrom = document.getElementById('comfrm').value;
		var comto = document.getElementById('comto').value;
		var periodfrom = document.getElementById('periodfrom').value;
		var periodto = document.getElementById('periodto').value;
		var datefrom = document.getElementById('datestart').value;
		var dateto = document.getElementById('dateend').value;
		var userfrom = document.getElementById('createdfrm').value;
		var userto = document.getElementById('createdto').value;
		var urllist = "/default/eInvoicing/eInvoiceListAjax.cfm?";
		if (invfrom != "") {
			urllist = urllist + "invfrom=" + invfrom + "&";
		}
		if (invto != "") {
			urllist = urllist + "invto=" + invto + "&";
		}
		if (comfrom != "") {
			urllist = urllist + "comfrom=" + comfrom + "&";
		}
		if (comto != "") {
			urllist = urllist + "comto=" + comto + "&";
		}
		if (periodfrom != "") {
			urllist = urllist + "periodfrom=" + periodfrom + "&";
		}
		if (periodto != "") {
			urllist = urllist + "periodto=" + periodto + "&";
		}
		if (datefrom != "") {
			urllist = urllist + "datefrom=" + datefrom + "&";
		}
		if (dateto != "") {
			urllist = urllist + "dateto=" + dateto + "&";
		}
		if(document.getElementById('submitedinvoice').checked == true) {
			urllist = urllist + "showsubmited=true&";
		}
		if(document.getElementById('excludegeneratedinvoice').checked == true) {
			urllist = urllist + "excludegeneratedinvoice=true&";
		}
		if (userfrom != "") {
			urllist = urllist + "userfrom=" + userfrom + "&";
		}
		if (userto != "") {
			urllist = urllist + "userto=" + userto + "&";
		}
		ajaxFunction(document.getElementById('ajaxField'),urllist);
	}
	function periodmonth(fperiod,column) {
		var fperiod = fperiod * 1;
		var lyear = '#year(getgeneral.lastaccyear)#';
		var lmonth = '#month(getgeneral.lastaccyear)#';
		var nmonth = lmonth + fperiod;
		var nyear = lyear;
		var m_names = new Array("Jan", "Feb", "Mar", "Apr", "May", "June", "Jul", "Aug", "Sept", "Oct","Nov", "Dec");
		while (nmonth > 12) {
			nmonth = nmonth - 12;
			nyear = nyear + 1;
		}
		if (column == "from") {
			document.getElementById('periodfrm').value = m_names[nmonth-1] + " " + nyear;
		}
		if (column == "to") {
			document.getElementById('prdto').value = m_names[nmonth-1] + " " + nyear;
		}
	}
	function selectlist(custno,fieldtype){
		for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) {
			if (custno==document.getElementById(fieldtype).options[idx].value) {
				document.getElementById(fieldtype).options[idx].selected=true;
			}
		}
	}
</script>
</cfoutput>
</head>

<body>
<cfif left(hcomid,4) eq "beps">
    <cfquery name="geteinv" datasource="#dts#">
        SELECT refno FROM assignmentslip WHERE assignmenttype='einvoice'
        UNION ALL
        SELECT refno 
        FROM artran 
        WHERE left(refno,2) = "BE"
    </cfquery>
</cfif>
<cfquery name="getInvoice" datasource="#dts#">
    SELECT refno 
    FROM artran 
    WHERE type = "INV" AND fperiod <> 99 AND (void = "" or void is null)
    <cfif Huserloc neq "All_loc">
        AND (userid IN (
        	SELECT userid 
            FROM main.users 
            WHERE userDept = '#dts#' AND location='#Huserloc#'))
    </cfif>
    <cfif left(hcomid,4) eq "beps">
        AND refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(geteinv.refno)#" list="yes" separator=",">)
    </cfif>
</cfquery>
<cfquery name="getCust" datasource="#dts#">
    SELECT * 
    FROM #target_arcust#
</cfquery>
<cfoutput>
<h1><center>#words[1199]#</center></h1>
<br><br>
<table width="75%" border="0" class="data" align="center">
    <tr>
        <th width="100px">#words[1200]#<input type="hidden" name="fromto" id="fromto" value="" /></th>
        <td width="20px">:</td>
        <td>
        <select name="invfrm" id="invfrm"  onChange="document.getElementById('invto').selectedIndex=this.selectedIndex;">
            <option value="">#words[1201]#</option>
            <cfloop query="getInvoice">
                <option value="#getInvoice.refno#">#getInvoice.refno#</option>
            </cfloop>
        </select>&nbsp;<input type="text" name="searchinvfrom" id="searchinvfrom" onKeyUp="searchSel('invfrm','searchinvfrom')" size="10" />&nbsp;
        <input type="button" size="10" value="#words[953]#" onClick="document.getElementById('fromto').value='frm';ColdFusion.Window.show('findbill');" />
        </td>
        <th width="100px">#words[1207]#</th>
        <td width="20px">:</td>
        <td>
        <select name="invto" id="invto">
            <option value="">#words[1201]#</option>
            <cfloop query="getInvoice">
                <option value="#getInvoice.refno#">#getInvoice.refno#</option>
            </cfloop>
        </select>&nbsp;<input type="text" name="searchinvto" id="searchinvto" onKeyUp="searchSel('invto','searchinvto')" size="10" />&nbsp;
        <input type="button" size="10" value="#words[953]#" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findbill');" />
        </td>
    </tr>
    <tr>
        <th>#words[1202]#</th>
        <td>:</td>
        <td>
        <select name="comfrm" id="comfrm" onChange="document.getElementById('comto').selectedIndex=this.selectedIndex;">
            <option value="">#words[1204]#</option>
            <cfloop query="getCust">
                <option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
            </cfloop>
        </select>&nbsp;
        <input type="button" size="10" value="#words[953]#" onClick="document.getElementById('fromto').value='frm';ColdFusion.Window.show('findcustomer');" />
        </td>
        <th>#words[1203]#</th>
        <td>:</td>
        <td>
        <select name="comto" id="comto">
            <option value="">#words[1204]#</option>
            <cfloop query="getCust">
                <option value="#getCust.custno#">#getCust.custno#-#getCust.name#</option>
            </cfloop>
        </select>&nbsp;
        <input type="button" size="10" value="#words[953]#" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findcustomer');" />
        </td>
    </tr>
    <cfquery name="userlist" datasource="#dts#">
        SELECT userid 
        FROM main.users 
        WHERE userbranch = "#dts#" AND usergrpid <> "super"
        ORDER BY userid
    </cfquery>
	<tr>
        <th>#words[1205]#</th>
        <td>:</td>
        <td>
        <select name="createdfrm" id="createdfrm" onChange="document.getElementById('createdto').selectedIndex=this.selectedIndex;">
            <option value="">#words[1208]#</option>
            <cfloop query="userlist">
                <option value="#userlist.userid#">#userlist.userid#</option>
            </cfloop>
        </select>
        </td>
        <th>#words[1206]#</th>
        <td>:</td>
        <td>
        <select name="createdto" id="createdto">
            <option value="">#words[1208]#</option>
            <cfloop query="userlist">
                <option value="#userlist.userid#">#userlist.userid#</option>
            </cfloop>
        </select>
        </td>
    </tr>
    <tr>
        <th>#words[1184]#</th>
        <td>:</td>
        <td>
        <select name="periodfrom" id="periodfrom"  onChange="document.getElementById('periodto').selectedIndex=this.selectedIndex;periodmonth(this.value,'from');periodmonth(this.value,'to');">
            <option value="">#words[1183]#</option>
            <cfloop from="1" to="18" index="i">
                <option value="#i#" <cfif currentperiod eq i>Selected</cfif>>#i#</option>
            </cfloop>
        </select>&nbsp;<input type="text" name="periodfrm" id="periodfrm" value="" size="10" readonly></td>
        <th>#words[1209]#</th>
        <td>:</td>
        <td>
        <select name="periodto" id="periodto"  onChange="periodmonth(this.value,'to')">
            <option value="">#words[1183]#</option>
            <cfloop from="1" to="18" index="i">
                <option value="#i#" <cfif currentperiod eq i>Selected</cfif>>#i#</option>
            </cfloop>
        </select>&nbsp;<input type="text" name="prdto" id="prdto" value="" size="10" readonly></td>
    </tr>
	<tr>
        <th>#words[1210]#</th>
        <td>:</td>
        <td><input type="text" readonly name="datestart" id="datestart" maxlength="10" size="10">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datestart);">(DD/MM/YYYY)</td>
        <th>#words[1211]#</th>
        <td>:</td>
        <td><input type="text" readonly name="dateend" id="dateend" maxlength="10" size="10">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateend);">(DD/MM/YYYY)</td>
    </tr>
    <tr>
        <th>#words[1212]#</th>
        <td>:</td>
        <td><input type="checkbox" name="submitedinvoice" id="submitedinvoice" value="show" ></td>
        <th>#words[1213]#</th>
        <td>:</td>
        <td><input type="checkbox" name="excludegeneratedinvoice" id="excludegeneratedinvoice" value="show" ></td>
    </tr>
    <tr>
        <td colspan="6" align="center">
            <input type="button" name="listinvoice" id="listinvoice" value="#words[1214]#" onClick="getList()" >
        </td>
    </tr>
</table>
<br/>
<div id="ajaxField" width="80%" align="center"></div>
<cfwindow center="true" width="550" height="400" name="findbill" refreshOnShow="true"
    title="Find Bill" initshow="false"
    source="findbill.cfm?type=Bill&fromto={fromto}" />
<cfwindow center="true" width="650" height="500" name="findcustomer" refreshOnShow="true"
    title="Find Customer" initshow="false"
    source="findcustomer.cfm?type=target_arcust&fromto={fromto}" />
</cfoutput>
<cfoutput>
<script type="text/javascript">
	periodmonth('#currentperiod#','from');
	periodmonth('#currentperiod#','to');
</script>
</cfoutput>
</body>
</html>
