<html>
<head>
<title>FeedBack</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/stylesheet/stylesheet.css"/>
<link href="/stylesheet/default.css" rel="stylesheet" type="text/css" />
<link href="/stylesheet/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="/scripts/swfobject.js"></script>
<script type="text/javascript" src="/scripts/jquery.uploadify.v2.1.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
$('#uploadfiles').uploadify({
'uploader': '/feedback/images/uploadify.swf',
'script': '/feedback/uploadify.cfm',
'folder': '/feedback/uploaded',
'auto' : true,
'cancelImg': '/feedback/images/cancel.png'
});
});
</script>
</head>
<body>
<h1>FeedBack</h1>
<cfform method="post" action="/feedback/feedbackmail.cfm" enctype="multipart/form-data"  >
<table class="data" align="center">
<tr>
<th width="150px">Feed Back Type</th>
<td width="500px">

<cfselect name="feedbacktype" id="feedbacktype" >
<option value="Suggestion">Suggestion</option>
<option value="Bug">System Error or Bug</option>
<option value="QUESTION">Question</option>
</cfselect>
</td>
<td width="200px" rowspan="7">
<IFRAME height=60 src="http://www.google.com/talk/service/badge/Show?tk=z01q6amlquhmou3q64ahk07m5c4faijrgj4gcjpd7d82igiff0dfo2qu48sgvl92v99fhje8rvpcot2ff7jepmgp98l7klu8bgqbtfnf8rki2fv0j46jrnbm8mm5nnpntdc63t4ri5jdfrav6kqubhg7ne78sgbolvnd6knsdagp09pba2r0qc6i8hc510ocgic&amp;w=130&amp;h=60" frameBorder=0 width=130 allowTransparency></IFRAME>
</td>
</tr>
<tr>
<th>Email:</th>
<td><cfinput type="text" name="email" id="email" validate="email" required="yes" validateat="onsubmit" ></td>
</tr>
<tr>
<th>Contact:</th>
<td><cfinput type="text" name="contact" id="contact" > </td>
</tr>
<tr>
<th>Details</th>
<td><textarea name="detail" id="detail" cols="40" rows="10">
</textarea></td>
</tr>
<tr>
<th>Upload Files</th>
<td>	<div id="uploadfiles">You have a problem with your javascript</div>
		<a href="javascript:$('#uploadfiles').fileUploadClearQueue()">Cancel Upload or Queue</a></td>
</tr>
<tr>
<th>Uploaded File</th>
<td><input readonly type="text" id="uploadedfile" name="uploadedfile" size="50" value="" ></td>
</tr>
<tr>
<td colspan="2">
<input type="submit" value="Submit" >
</td>
</tr>
</table> 
</cfform>
</body>
</html>