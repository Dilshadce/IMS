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

function getlevel3(code){
	parent.thirdframe.location.href="dsp_frame3.cfm?selectedcode=" + code + "&groupname=" + document.itemform.groupname.value;
}

function updaterights(groupid,pincode){
	<!--- var x = document.getElementById('cb_' + pincode);
	x.style.backgroundColor  = 'red';
 	document.all.feedcontact1.dataurl="databind/updaterights.cfm?groupid=" + groupid + "&pincode=" + pincode;
	//prompt("D",document.all.feedcontact1.dataurl);
	document.all.feedcontact1.charset=document.charset;
	document.all.feedcontact1.reset(); --->
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
<body>
<cfparam name="selectedcode" default="9999">
<cfif len(selectedcode) gt 4 and selectedcode neq "10000">
	<cfset tempcode = left(selectedcode,2)>	
<cfelse>
	<cfset tempcode = left(selectedcode,1)>	
</cfif>

<cfquery name="getlanguage" datasource="#dts#">
        SELECT dflanguage
        FROM gsetup
</cfquery>
<cfset language = getlanguage.dflanguage>
<cfif hlang neq "">
<cfset language = hlang>
</cfif>

<cfquery name="getuserpin2" datasource="#dts#">
	SELECT a.code,b.desp
    FROM userpin as a
    LEFT JOIN (select code,#language# as desp from main.userpinlang)as b on a.code=b.code
    WHERE <cfif len(selectedcode) GT 4>
    (LENGTH(a.code)=5 OR LENGTH(a.code)=6
    <cfif selectedcode eq "10000">
    OR a.code in ('1T00')
    </cfif>  
    ) AND
            
          <cfelse>
          	a.code LIKE '%00' AND
          </cfif> 
    a.code LIKE '#tempcode#%' 
    AND a.code NOT LIKE <cfif len(selectedcode) GT 4>
    					'%0000'
                      <cfelse>
                      	'%000'
                      </cfif>       
          
	UNION
        SELECT a.code,b.desp
        FROM userpin as a
        LEFT JOIN (select code,#language# as desp from main.userpinlang)as b on a.code=b.code
        WHERE a.code LIKE 'C%' 
        AND a.code LIKE '#tempcode#%' 
        AND a.code NOT LIKE '%000'
        
    ORDER BY code;    
</cfquery>

<form id="itemform" name="itemform">
	<cfoutput><input type="hidden" value="#groupname#" name="groupname"></cfoutput>
<table width="100%" height="100%" class="data">
	<tr><td height="10" colspan="5">&nbsp;</td></tr>
	<cfoutput>
	<cfloop query="getuserpin2">
		<cfset xcode = "H"&"#getuserpin2.code#">
		<cfquery name="getrights" datasource="#dts#">
			select #xcode# as xpin 
            from userpin2 
            where level='#groupname#'
		</cfquery>
		<tr id="getuserpin2.code">
			<td>&nbsp;</td>
			<td>#getuserpin2.code#&nbsp;</td>
			<td onClick="getlevel3('#getuserpin2.code#');" style="cursor: hand;"><u>#getuserpin2.desp#</u></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" id="cb_#xcode#" value="" onChange="updaterights('#groupname#','#xcode#');" <cfif getrights.xpin eq "T">checked</cfif>></td>
		</tr>
	</cfloop>
	</cfoutput>
</table>
</form>
</body>
</html>
