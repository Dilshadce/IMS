<html>
<head>
<title>AMS Settup</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfif isdefined("form.submit")>
	<cfquery name="updateamssettup" datasource="main">
		update amssetup set 
		amsid=#form.amsid#,
		amsipaddress=(select aes_encrypt('#form.hostname#',#form.amsid#)),
		amsportno=(select aes_encrypt('#form.portno#',#form.amsid#)),
		amsusername=(select aes_encrypt('#form.uesrname#',#form.amsid#)),
		amspassword=(select aes_encrypt('#form.password#',#form.amsid#)) 
		where amsid=amsid;
	</cfquery>

	<script language="javascript" type="text/javascript">
		alert("Your Setting Has Been Saved !");
		top.frames[1].location.href=top.frames[1].location.href;
		window.location="amssetup.cfm";
	</script>
<cfelse>
	<cfquery name="getamssetup" datasource="main">
		select amsid,
		aes_decrypt(amsipaddress,amsid) as amsipaddress,
		aes_decrypt(amsportno,amsid) as amsportno,
		aes_decrypt(amsusername,amsid) as amsusername,
		aes_decrypt(amspassword,amsid) as amspassword 
		from amssetup;
	</cfquery>
	
	<cfform name="amssetup" action="amssetup.cfm" method="post">
		<table align="center" class="data" width="50%">
			<tr>
				<td><h2 align="center">Setup AMS Server</h2></td>
			</tr>
			<tr>
				<th>AMS ID:</th>
				<td><cfinput name="amsid" type="text" value="#getamssetup.amsid#" tabindex="1" required="yes" validate="integer" message="Please Enter A Correct Number !" size="2" maxlength="15"></td>
			</tr>
			<tr>
				<th>AMS Host Name:</th>
				<td><cfinput name="hostname" type="text" value="#getamssetup.amsipaddress#" tabindex="2" required="yes" size="30" maxlength="15"></td>
			</tr>
			<tr>
				<th>AMS Port No:</th>
				<td><cfinput name="portno" type="text" value="#getamssetup.amsportno#" tabindex="3" required="yes" size="30" maxlength="4"></td>
			</tr>
			<tr>
				<th>AMS User Name:</th>
				<td><cfinput name="uesrname" type="text" value="#getamssetup.amsusername#" tabindex="4" required="yes" size="30" maxlength="50"></td>
			</tr>
			<tr>
				<th>AMS Password:</th>
				<td><cfinput name="password" type="password" value="#getamssetup.amspassword#" tabindex="5" required="yes" size="30" maxlength="50"></td>
			</tr>
		</table>
		<table align="center" class="data" width="50%">
			<tr align="center">
				<td>
					<input name="submit" type="submit" value="Submit" tabindex="6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="reset" type="reset" value="Reset" tabindex="7">
				</td>
			</tr>
		</table>
	</cfform>
</cfif>

</body>
</html>