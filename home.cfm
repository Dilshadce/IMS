<html>
<head>
<title>Inventory Management System</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="stylesheet/stylesheet.css"/>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro 
	from gsetup;
</cfquery>

<body>

<cfoutput>
	<h1>Welcome #HUserName#</h1>
	<h1 align="center">#getgeneral.compro#</h1>
</cfoutput>

<br/><br/><hr><h3>Important Information Board</h3><br><br/>

<!--- <h2>29 August 2008 - </h2>
	If you have any queries, please call to our support line:<br><br>
	Singapore (+65)6223 1157<br>
	Malaysia (+603)78778955<br>
	Hong Kong (+852)22426111
<br/> --->

<h2>29 June 2007 - </h2>
	We will update our system on 30-06-2007 (Saturday)- 11.00 am until 01-07-2007(Monday) - 12.00 am.<br/>
	Please kindly stop your operation while we are doing the updating.<br/>
	System updating included install new server, software, internet security, backup divices, database setting and internet backbone.<br/>
	The new system will be much more faster then previous.</br/>
	New functions will be comming soon...
	Please call (+65)6223 1157 to our support line ,if you have any queries.
<br/>

<h2>16 November 2006 - </h2>
We have add it another security features to keep track of the login. 
In the header page, user would able to view the IP address of the computer that they are using. 
WOS is currently keeping track of all users log in and you will be able to retrieve your last login for last 30 entries.

<cfquery name="getlogindetails" datasource="main">
	select * 
	from userlog 
	where udatabase='#dts#' 
	order by userlogtime desc;
</cfquery>

<br/>

<table align="center" class="data">
	<tr>
		<th width="132">User ID</th>
		<th width="177">Log In Time</th>
		<th width="196">IP Address</th>
		<th width="129">Status</th>
	</tr>
	<cfoutput query="getlogindetails" maxrows="30">
		<tr>
			<td>#userlogid#</td>
			<td>#userlogtime#</td>
			<td>#uipaddress#</td>
			<td>#status#</td>
		</tr>
	</cfoutput>
</table>

<br>
<h2>18 April 2005 - </h2>
This is to inform everyone of the type of User the system can be supported;<br><br>

Administrator - Administrator who has full access of the entire system,<br>
Standard User - User who can access all function except password and user account creation,<br>
General User - User who can access lesser function compared to Standard User,<br>
Limited User - For user who doesn't require maintenance information and reports access and user defined menu setting,<br>
Mobile User - Design for sales person who use PDA to access company information. The screen user 
access is cater for faster downloading.

</body>
</html>