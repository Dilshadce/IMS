<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../../stylesheet/stylesheet.css"/>

<!--- <OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_reply(this.recordset);</script> --->
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<script language="JavaScript">

function getlevel2(code){
	//alert(code);
	parent.secondframe.location.href="dsp_frame2.cfm?selectedcode=" + code + "&groupname=" + document.itemform.groupname.value;
}
 
function updaterights(groupid,pincode){
	<!--- var x = document.getElementById('cb_' + pincode).value;
	x.style.backgroundColor  = 'red'; --->
 	<!--- document.all.feedcontact1.dataurl="databind/updaterights.cfm?groupid=" + groupid + "&pincode=" + pincode;
	document.all.feedcontact1.charset=document.charset;
	document.getElementById(feedcontact1).reset(); --->
	ajaxFunction(document.getElementById('updateajaxfield'),"updaterightsAjax.cfm?groupid=" + groupid + "&pincode=" + pincode);
		
 }
 
<!---  function show_reply(rset){
 	rset.MoveFirst();
 	var codeid = 'cb_' + rset.fields("codeid").value;
 	var x = document.getElementById(codeid);
 	x.style.backgroundColor  = '';
 } --->
</script>

</head>
<body bgcolor="#CCCCFF">


<cfquery name="getlanguage" datasource="#dts#">
        SELECT dflanguage
        FROM gsetup
</cfquery>
<cfset language = getlanguage.dflanguage>
<cfif hlang neq "">
<cfset language = hlang>
</cfif>
<cfif language eq "english">
<cfset language = "desp">
</cfif>
	
<cfquery name="getuserpin" datasource="#dts#">
	SELECT a.code,b.desp
    FROM userpin as a
    LEFT JOIN (select code,#language# as desp from main.userpinlang)as b on a.code=b.code
    WHERE a.code LIKE '%000'
    AND a.code != '1000'
    ORDER BY SUBSTRING(a.code,1,1) ASC
</cfquery>

<form id="itemform" name="itemform">
	<cfoutput>
    	<input type="hidden" value="#groupname#" name="groupname" id="groupname">
	</cfoutput>
<table width="100%" height="100%" class="data" cellpadding="0" cellspacing="0">
	<tr><td height="10" colspan="5">&nbsp;</td></tr>
	<cfoutput>
	<cfloop query="getuserpin">
		<cfset xcode = "H"&"#getuserpin.code#">
		<cfquery name="getrights" datasource="#dts#">
			SELECT #xcode# as xpin 
            FROM userpin2 
            WHERE level='#groupname#';
		</cfquery>
		<tr id="getuserpin.code">
			<td>&nbsp;</td>
			<td>#getuserpin.code#&nbsp;</td>
			<td onClick="getlevel2('#getuserpin.code#');" style="cursor: hand;"><u>#getuserpin.desp#</u></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" name="cb_#xcode#" id="cb_#xcode#" value="cb_#xcode#" onChange="updaterights('#groupname#','#xcode#');" <cfif getrights.xpin eq "T">checked</cfif>></td>
			
		</tr>
	</cfloop>
	</cfoutput>
</table>
</form>
</body>
</html>
