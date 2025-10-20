<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "961,1307,1309,1308,1088,666,668,673,185,690,665,664,188,689,667,1270,1310,1311">
<cfinclude template="/latest/words.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><cfoutput>#words[1308]#</cfoutput></title>
</head>
<cfoutput>
<body>
<h3>#words[1307]#</h3>
<cfform action="itemcombineprocess.cfm" method="post" name="combineform">
 <table width="100%">
    <tr>
    <th colspan="7">#words[1309]#</th>
    </tr>
    <tr>
    <th>#words[1088]#</th>
    <td>:</td>
    <td><select name="tran" id="tran">
        <option value="INV">#words[666]#</option>
        <option value="QUO">#words[668]#</option>
        <option value="SO">#words[673]#</option>
        <option value="CS">#words[185]#</option>
        <option value="PO">#words[690]#</option>
        <option value="DO">#words[665]#</option>
        <option value="RC">#words[664]#</option>
        <option value="PR">#words[188]#</option>
        <option value="RQ">#words[961]#</option>
        <option value="CN">#words[689]#</option>
        <option value="DN">#words[667]#</option>
        </select></td>
	<td></td>
    <th>#words[1270]#</th>
    <td>:</td>
    <td>
    <cfselect name="billno" id="billno" bind="cfc:billno.getlist({tran},'#dts#')" bindonload="yes" value="refno" display="billdesp" required="yes" message="Please select a Bill" />
    </td>
    </tr>
    <tr>
      <th colspan="7">#words[1310]#</th>
    </tr>
    <tr>
          <td colspan="7" align="center"><input type="submit" name="combine" id="combine" value="#words[1311]#" /></td>
    </tr>
    </table>
</cfform>
</body>
</cfoutput>
</html>
