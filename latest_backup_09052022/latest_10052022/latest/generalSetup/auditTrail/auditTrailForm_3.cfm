<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1816, 877, 1817, 29, 122, 123, 1818, 1819, 1234, 146, 120, 475, 506, 1820, 294">
<cfinclude template="/latest/words.cfm">

<cfset pageTitle = "#words[1816]#">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<cfoutput>
    <title>#pageTitle#</title>
    </cfoutput>
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
    
</head>

<body class="container">
<cfoutput>
	<form class="formContainer form2Button" name="auditTrailForm_3" id="auditTrailForm_3" action="report3.cfm" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
            <table> 
                <tr id="one" style="display:inline-block;">
                    <th><label for="type">#words[877]#</label></th>			
                    <td>
                        <select id= "type"name="type">
                            <option value="">#words[1817]#</option>
                            <option value="changeagent">#words[29]#</option>
                            <option value="changebrand">#words[122]#</option>
                            <option value="changecategory">#words[123]#</option>
                            <option value="changecustsupp">#words[1818]#</option>
                            <option value="changedate">#words[1819]#</option>
                            <option value="changeenduser">#words[1234]#</option>
                            <option value="changegroup">#words[146]#</option>
                            <option value="changeitemno">#words[120]#</option>
                            <option value="changejob">#words[475]#</option>
                            <option value="changeproject">#words[506]#</option>
                            <option value="changerefno">#words[1820]#</option>
                            <option value="changeservice">#words[294]#</option>
						</select>
                    </td>
                </tr> 
            </table>
        </div>
        <div>
            <input type="submit" name="submit" id="submit" value="SUBMIT">
            <input type="button" name="back" id="back" value="BACK" onclick="history.go(-1);"> 
        </div>
    </form>
</cfoutput>
</body>
</html>