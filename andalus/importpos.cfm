<html>
<head>
	<title>Import POS Transaction</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<cfform action="posimportprocess.cfm" method="post" enctype="multipart/form-data" onsubmit="if(document.getElementById('uploadkpi').value !=''){ColdFusion.Window.show('processing')}else{alert('Upload file is required!');return false;};">
<table align="center">
<tr>
<th width="300px">Upload POS Transaction Excel</th>
<td width="500px">
<cfinput type="file" name="uploadkpi" id="uploadkpi"  />
</td>
</tr>
<tr>
<th><label id="uploadfilename"></label></th>
<td><input type="submit" name="uploadbtn" id="uploadbtn" value="Upload & Import"  />
</td>
</tr>
</table>
</cfform>
</cfoutput>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Importing....Please Wait" modal="true" resizable="false" >
<h1>Importing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
<div id="ajaxcontrol"></div>
</cfwindow>
</body>
</html>