<cfsetting enablecfoutputonly="no">
<html>
<head>
	<link rel="stylesheet" href="/stylesheet/modal-message.css" type="text/css">
	<link rel="stylesheet" href="/stylesheet/stylesheet.css"/>
	<script type="text/javascript" src="/scripts/modal-message/ajax.js"></script>
	<script type="text/javascript" src="/scripts/modal-message/modal-message.js"></script>
	<script type="text/javascript" src="/scripts/modal-message/ajax-dynamic-content.js"></script>
</head>
<body>
<!--- <cfquery name="getinfo" datasource="main">
	select * from startupwarning
	where comid='#dts#'
</cfquery> --->
<cfquery name="getinfo" datasource="main">
	SELECT * FROM startupwarning
	WHERE (comid='#dts#' or comid='all')
	limit 1
</cfquery>

<script type="text/javascript">
	<cfoutput>
		var disptime=#getinfo.disp_time#;
		var dispwidth=#getinfo.disp_width#;
		var dispheight=#getinfo.disp_height#;
	</cfoutput>
	
	messageObj = new DHTML_modalMessage();	// We only create one object of this class
	messageObj.setShadowOffset(5);	// Large shadow
	displayMessage('/startupwarning/startupwarning2.cfm');

	function displayMessage(url)
	{
		
		messageObj.setSource(url);
		messageObj.setCssClassMessageBox(false);
		messageObj.setSize(dispwidth,dispheight);
		messageObj.setShadowDivVisible(true);	// Enable shadow for these boxes
		messageObj.display();
	}
	
	function closeMessage()
	{
		messageObj.close();	
		window.location.href = '/index.cfm?check=';
	}
	
	var timer=parseInt(disptime)*1000;
	setTimeout('showButton()', timer); 
		
	function showButton(){
		document.getElementById("btnContinue").disabled=false;
	}
</script>

</body>
</html>