<cfif lcase(husergrpid) neq 'super'>
<cfabort>
<cfif url.comid neq hcomid>
<cfabort>
</cfif>
</cfif>

<html>
<head>
<title>View All IMS Users</title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<h4>
	<cfif husergrpid eq "Muser">
		<a href="/home2.cfm"><u>Home</u></a>
	</cfif>
</h4>

<h1>User Maintenance</h1>



<hr>

<cfparam name="start" default="1">

<cfif isdefined("url.all")>
	<cfquery name="getUsers" datasource="main">
		select * 
		from users 
		order by userbranch,usergrpid,userid;
	</cfquery>
<cfelse>
	<cfif husergrpid eq "super">
		<cfquery datasource='main' name="getUsers">
			select * 
			from users 
			where userbranch='#hcomid#' 
			order by usergrpid,userid;
		</cfquery>
	<cfelseif husergrpid eq "admin">
		<cfquery datasource='main' name="getUsers">
			select * 
			from users 
			where userbranch='#hcomid#' and usergrpid <> 'super' and userid not like 'ultra%'
			order by usergrpid,userid;
		</cfquery>
	<cfelse>
		<cfquery datasource='main' name="getUsers">
			select * 
			from users 
			where userid='#huserid#' and userbranch='#hcomid#'; 
		</cfquery>
	</cfif>
</cfif>

<cfif isdefined("url.start")>
	<cfset start = url.start>
</cfif>
			
<cfif isdefined("url.process")>
	<cfoutput><h1>#form.status#</h1></cfoutput><hr>
</cfif>
<cfquery name="getdatabase" datasource="main">
	SELECT usercount,companyid FROM useraccountlimit <cfif isdefined('hcomid')>where companyid='#hcomid#'</cfif> order by companyid
	</cfquery>
    
<cfquery name="getdatabaseAMS" datasource="mainams">
	SELECT usercount,companyid FROM useraccountlimit <cfif isdefined('url.hcomid')>where companyid='#replaceNocase(hcomid,'_i','_a')#'</cfif> order by companyid
	</cfquery>    
    
    
     <cfquery datasource='main' name="getallusercount">
			select * 
			from users 
			where userbranch='#hcomid#' and usergrpid <> 'super'  and userid not like 'ultra%'
			order by usergrpid,userid;
		</cfquery>
        
        
        
        
         <cfquery datasource='mainams' name="getallusercountAMS">
			select * 
			from users 
			where userbranch='#replaceNocase(hcomid,'_i','_a')#' and usergrpid <> 'super'  and userid not like 'ultra%'
			order by usergrpid,userid;
		</cfquery>    
        
        
        
        
        
        <table class="data">
        <tr>
     
    <div align="center"><font size="+1" >   <th>Total IMS Users:</th><td> <cfoutput>#val(getdatabase.usercount)#</cfoutput></td>
</font></div>
</tr>
<cfif getdatabaseAMS.recordcount neq 0>
 <div align="center"><font size="+1" ><th>Total AMS Users: </th></th><td><cfoutput>#val(getdatabaseAMS.usercount)#</cfoutput>
</td>
</font></div>
</tr>
</cfif>
  <tr>
     
<div align="center"><font size="+1" ><th>Current IMS Users:</th><td> <cfoutput>#val(getallusercount.recordcount)#</cfoutput>
</td>
</font></div>
</tr>
<cfif getallusercountAMS.recordcount neq 0>  <tr>
     
 <div align="center"><font size="+1" ><th>Current AMS Users:</th><td> <cfoutput>#val(getallusercountAMS.recordcount)#</cfoutput>
</td>
</font></div>
</tr>
</cfif>





<cfif getdatabaseAMS.recordcount neq 0>
  <tr>
     
<div align="center"><font size="+1" ><th style="border-top:1px grey solid">Balance Users:</th><td style="border-top:1px grey solid; color:red"> <cfoutput>#val(getdatabase.usercount)+val(getdatabaseAMS.usercount)-val(getallusercountAMS.recordcount)-val(getallusercount.recordcount)#</cfoutput>
</td>
</font></div>
</tr>


<cfelse>  <tr>
     
<div align="center"><font size="+1" ><th style="border-top:1px grey solid">Balance Users:</th><td style="border-top:1px grey solid; color:red">  <cfoutput>#val(getdatabase.usercount-getallusercount.recordcount)#</cfoutput>
</td>
</font></div>
</tr>
</cfif>
</table>


<table align="center" class="data" width="100%">
	<tr>
    <th>No.</th>
		<cfif husergrpid eq "admin" or husergrpid eq "super">
			<th>Delete</th>
		</cfif>
		<th>Edit</th>
		<th>Name</th>
		<th>ID</th>
		<th>Company</th>
        <th>Multi Company</th>
		<th>Group</th>
		<th>Email</th>
		<cfif husergrpid eq "super">
			<th>Lastlogin</th>
            <th>Created_by</th>
			<th>Reactivate</th>
		</cfif>
	</tr>
	<cfloop query="getUsers">
		<cfoutput>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <td>#getUsers.currentrow#</td>
			<cfif husergrpid eq "admin" or husergrpid eq "super">
				<td><a href="user.cfm?type=Delete&userId=#getUsers.userId#">Go</a></td>
			</cfif>
			<td><a href="user.cfm?type=Edit&userId=#getUsers.userId#">Go</a></td>
			<td>#getUsers.userName#</td>
			<td>#getUsers.userId#</td>
			<td>#getUsers.userbranch#</td>
            <cfquery name="getmulticompany" datasource="main">
            	select * from multicomusers where userid="#getUsers.userId#"
            </cfquery>
            <td><cfloop list="#getmulticompany.comlist#" index="i"> #i#,</cfloop></td>
			<td>
				<cfif getUsers.usergrpid eq "admin">
					Administrator
				</cfif>
				<cfif getUsers.usergrpid eq "suser">
					Standard
				</cfif>
				<cfif getUsers.usergrpid eq "guser">
					General User
				</cfif>
				<cfif getUsers.usergrpid eq "muser">
					Mobile User
				</cfif>
				<cfif getUsers.usergrpid eq "luser">
					Limited User
				</cfif>
				<cfif getUsers.usergrpid eq "super">
					Super User
                <cfelse>
                	#getUsers.usergrpid#
				</cfif>
			</td>
			<td>#getUsers.userEmail#</td>
			<cfif husergrpid eq "super">
				<td nowrap>#lastlogin#</td>
                <td nowrap>#Created_by#</td>
				<td><a href="reactivate.cfm?userid=#userid#">Go</a></td>
			</cfif>
		</tr>
		</cfoutput>
	</cfloop>
</table>
<cfif husergrpid eq "Super" and isdefined("hcomid")>
<br>
To create user, click <cfoutput><a href="user.cfm?type=Create&hcomid=#hcomid#">Here</a> </cfoutput>
<cfelseif husergrpid eq "admin" and isdefined("hcomid")>
<!--- <cfquery name="getusercount" datasource="main">
select count(userid) as totaluser from users where userbranch = "#dts#" and usergrpid <> "super" group by userbranch
</cfquery>
<cfquery name="getuserlimit" datasource="main">
SELECT usercount FROM useraccountlimit where companyid = "#dts#"
</cfquery> --->



<cfif getdatabaseAMS.recordcount neq 0>
<cfset currentU = val(getdatabase.usercount)+val(getdatabaseAMS.usercount)-val(getallusercountAMS.recordcount)-val(getallusercount.recordcount)>

<cfelse>
<cfset currentU = val(getdatabase.usercount)-val(getallusercount.recordcount)>
</cfif>

<cfif currentU gt 0>
<br>
To create user, click <cfoutput><a href="user.cfm?type=Create&hcomid=#dts#">Here</a> </cfoutput>
</cfif>
</cfif>
</body>
</html>