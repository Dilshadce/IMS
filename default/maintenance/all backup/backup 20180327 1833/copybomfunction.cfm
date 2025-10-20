<html>
<head>
<title>Copy BOM </title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfquery name="getitem" datasource="#dts#">
	SELECT * FROM icitem where (nonstkitem<>'T' or nonstkitem is null)
</cfquery>
</head>

<cfset itemno=urldecode(itemno)>
<cfset bomno=urldecode(bomno)>

<body width="100%">
<br>
<cfoutput>
<cfform name="form" method="post" action="copybomfunctionprocess.cfm" target="_self">
	 <input type="hidden" id="counter" name="counter" value="1">
     <input type="hidden" id="itemno" name="itemno" value="#itemno#">
     <input type="hidden" id="bomno" name="bomno" value="#bomno#">
    <table class="data" align="center" width="200px">
    	<tr><td height="10" colspan="100%"></td></tr>
        <tr>
        	<th width="40%">Item No</th>
           	<td width="60%">
            <cfselect name="newitemno" id="newitemno" required="yes">
            <option value="">Choose a Item</option>
            <cfloop query="getitem">
            <option value="#getitem.itemno#">#getitem.itemno#</option>
            </cfloop>
            </cfselect>
            </td>
        </tr>
       
        <tr>
        	<th width="40%">Ref No.</th>
           	<td width="60%">
            <cfinput type="text" name="newbomno" id="newbomno" bind="cfc:copybom.getbomno({newitemno},'#dts#')" bindonload="yes" value="">
            </td>
        </tr>
        
        <tr>
        	<td colspan="100%"><div align="right">
        		<input type="submit" value="Copy">
                &nbsp;
                <input type="button" value="Cancel" onClick="window.close();">
            </div></td>
        </tr>
    </table>
</cfform>
</cfoutput>
</body>
</html>
