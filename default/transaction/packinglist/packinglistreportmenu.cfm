<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1263,1264,1229,1265">
<cfinclude template="/latest/words.cfm">
<cfoutput>
<html>
<head>
<title>#words[1263]#</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1><center>#words[1263]#</center></h1>
<br><br>#words[1264]#<br><br>
<table width="85%" border="0" class="data" align="center">
	<tr>
    	<td colspan="5"><div align="center">#words[1229]#</div></td>
  	</tr>
  	<tr>
    	<td><a href="packingreport.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">#words[1229]#</a></td>
        <td><a href="packingreportbydriver.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">#words[1265]#</a></td>
  	</tr>
</table>
</body>
</html>
</cfoutput>