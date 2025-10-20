<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<cfset nowdate = dateformat(now(), "dd-mm-yyyy")>
<cfset datenow=CreateDate(year(now()),month(now()),day(now()))>
<cfset nowdate2 = DateAdd("d", 1 , datenow)>
<cfset nowdate3 = DateAdd("d", 1 , nowdate2)>
<cfset nowdate4 = DateAdd("d", 1 , nowdate3)>
<cfset nowdate5 = DateAdd("d", 1 , nowdate4)>

<cfquery name="getcso" datasource="#dts#">
	Select * from cso
</cfquery>

<h1>View Schedule</h1>
<br><hr>

<cfif isdefined("form.status")>
	<cfoutput><h2>#form.status#</h2></cfoutput>
</cfif>
<br>

<table align="center" class="data">
	<tr> 
  		<cfoutput>
			<th>&nbsp;</th>
    		<th>#dayofweekasstring(dayofweek(now()))# #nowdate#</th>
    		<th>#dayofweekasstring(dayofweek(nowdate2))# #dateformat(nowdate2, "dd-mm-yyyy")#</th>
   	 		<th>#dayofweekasstring(dayofweek(nowdate3))# #dateformat(nowdate3, "dd-mm-yyyy")#</th>
   	 		<th>#dayofweekasstring(dayofweek(nowdate4))# #dateformat(nowdate4, "dd-mm-yyyy")#</th>
    		<th>#dayofweekasstring(dayofweek(nowdate5))# #dateformat(nowdate5, "dd-mm-yyyy")#</th>
  		</cfoutput>
  	</tr>
	<cfloop query="getcso">
		<cfset thiscso=getcso.csoid>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<th><cfoutput>#getcso.desp#</cfoutput></th>
		  	<cfquery datasource='#dts#' name="getangiejobs1">
				select custno,servicetype,apptime,s_status,
				(CASE apptime 
					WHEN '9.00AM' THEN 1
					WHEN '9.30AM' THEN 2
					WHEN '10.00AM' THEN 3
					WHEN '10.30AM' THEN 4
					WHEN '11.00AM' THEN 5
					WHEN '12.00NN' THEN 6
					WHEN '2.00PM' THEN 7
					WHEN '2.30PM' THEN 8
					WHEN '3.00PM' THEN 9
					WHEN '3.30PM' THEN 10
					WHEN '4.00PM' THEN 11
					WHEN '4.30PM' THEN 12
					ELSE 99
				 END) as app 
				from service_tran 
				where csoid ='#thiscso#' and servicedate = #datenow#
				order by app
			</cfquery>
			<cfquery datasource='#dts#' name="getangiejobs2">
				select custno,servicetype,apptime,s_status,
				(CASE apptime 
					WHEN '9.00AM' THEN 1
					WHEN '9.30AM' THEN 2
					WHEN '10.00AM' THEN 3
					WHEN '10.30AM' THEN 4
					WHEN '11.00AM' THEN 5
					WHEN '12.00NN' THEN 6
					WHEN '2.00PM' THEN 7
					WHEN '2.30PM' THEN 8
					WHEN '3.00PM' THEN 9
					WHEN '3.30PM' THEN 10
					WHEN '4.00PM' THEN 11
					WHEN '4.30PM' THEN 12
					ELSE 99
				 END) as app  
				from service_tran 
				where csoid ='#thiscso#' and servicedate = #nowdate2#
				order by app
			</cfquery>
			<cfquery datasource='#dts#' name="getangiejobs3">
				select custno,servicetype,apptime,s_status,
				(CASE apptime 
					WHEN '9.00AM' THEN 1
					WHEN '9.30AM' THEN 2
					WHEN '10.00AM' THEN 3
					WHEN '10.30AM' THEN 4
					WHEN '11.00AM' THEN 5
					WHEN '12.00NN' THEN 6
					WHEN '2.00PM' THEN 7
					WHEN '2.30PM' THEN 8
					WHEN '3.00PM' THEN 9
					WHEN '3.30PM' THEN 10
					WHEN '4.00PM' THEN 11
					WHEN '4.30PM' THEN 12
					ELSE 99
				 END) as app  
				from service_tran 
				where csoid ='#thiscso#' and servicedate = #nowdate3#
				order by app
			</cfquery>
			<cfquery datasource='#dts#' name="getangiejobs4">
				select custno,servicetype,apptime,s_status,
				(CASE apptime 
					WHEN '9.00AM' THEN 1
					WHEN '9.30AM' THEN 2
					WHEN '10.00AM' THEN 3
					WHEN '10.30AM' THEN 4
					WHEN '11.00AM' THEN 5
					WHEN '12.00NN' THEN 6
					WHEN '2.00PM' THEN 7
					WHEN '2.30PM' THEN 8
					WHEN '3.00PM' THEN 9
					WHEN '3.30PM' THEN 10
					WHEN '4.00PM' THEN 11
					WHEN '4.30PM' THEN 12
					ELSE 99
				 END) as app  
				from service_tran 
				where csoid ='#thiscso#' and servicedate = #nowdate4#
				order by app
			</cfquery>
			<cfquery datasource='#dts#' name="getangiejobs5">
				select custno,servicetype,apptime,s_status,
				(CASE apptime 
					WHEN '9.00AM' THEN 1
					WHEN '9.30AM' THEN 2
					WHEN '10.00AM' THEN 3
					WHEN '10.30AM' THEN 4
					WHEN '11.00AM' THEN 5
					WHEN '12.00NN' THEN 6
					WHEN '2.00PM' THEN 7
					WHEN '2.30PM' THEN 8
					WHEN '3.00PM' THEN 9
					WHEN '3.30PM' THEN 10
					WHEN '4.00PM' THEN 11
					WHEN '4.30PM' THEN 12
					ELSE 99
				 END) as app  
				from service_tran 
				where csoid ='#thiscso#' and servicedate = #nowdate5#
				order by app
			</cfquery>
		  	<td>
		  		<cfoutput query="getangiejobs1">
			  		<cfif getangiejobs1.s_status eq "1">
						<cfset this_status="New">
					<cfelseif getangiejobs1.s_status eq "2">
						<cfset this_status="Follow Up">
					<cfelseif getangiejobs1.s_status eq "3">
						<cfset this_status="Closed">
					<cfelseif getangiejobs1.s_status eq "4">
						<cfset this_status="Unsolved">
					<cfelseif getangiejobs1.s_status eq "5">
						<cfset this_status="Cancel">
					</cfif>
					#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype# (#this_status#)<br><br>
				</cfoutput>
			</td>
			<td>
		  		<cfoutput query="getangiejobs2">
			  		<cfif getangiejobs2.s_status eq "1">
						<cfset this_status="New">
					<cfelseif getangiejobs2.s_status eq "2">
						<cfset this_status="Follow Up">
					<cfelseif getangiejobs2.s_status eq "3">
						<cfset this_status="Closed">
					<cfelseif getangiejobs2.s_status eq "4">
						<cfset this_status="Unsolved">
					<cfelseif getangiejobs2.s_status eq "5">
						<cfset this_status="Cancel">
					</cfif>
					#getangiejobs2.custno# - #getangiejobs2.apptime#<br>#getangiejobs2.servicetype# (#this_status#)<br><br>
				</cfoutput>
			</td>
			<td>
		  		<cfoutput query="getangiejobs3">
			  		<cfif getangiejobs3.s_status eq "1">
						<cfset this_status="New">
					<cfelseif getangiejobs3.s_status eq "2">
						<cfset this_status="Follow Up">
					<cfelseif getangiejobs3.s_status eq "3">
						<cfset this_status="Closed">
					<cfelseif getangiejobs3.s_status eq "4">
						<cfset this_status="Unsolved">
					<cfelseif getangiejobs3.s_status eq "5">
						<cfset this_status="Cancel">
					</cfif>
					#getangiejobs3.custno# - #getangiejobs3.apptime#<br>#getangiejobs3.servicetype# (#this_status#)<br><br>
				</cfoutput>
			</td>
			<td>
		  		<cfoutput query="getangiejobs4">
			  		<cfif getangiejobs4.s_status eq "1">
						<cfset this_status="New">
					<cfelseif getangiejobs4.s_status eq "2">
						<cfset this_status="Follow Up">
					<cfelseif getangiejobs4.s_status eq "3">
						<cfset this_status="Closed">
					<cfelseif getangiejobs4.s_status eq "4">
						<cfset this_status="Unsolved">
					<cfelseif getangiejobs4.s_status eq "5">
						<cfset this_status="Cancel">
					</cfif>
					#getangiejobs4.custno# - #getangiejobs4.apptime#<br>#getangiejobs4.servicetype# (#this_status#)<br><br>
				</cfoutput>
			</td>
			<td>
		  		<cfoutput query="getangiejobs5">
			  		<cfif getangiejobs5.s_status eq "1">
						<cfset this_status="New">
					<cfelseif getangiejobs5.s_status eq "2">
						<cfset this_status="Follow Up">
					<cfelseif getangiejobs5.s_status eq "3">
						<cfset this_status="Closed">
					<cfelseif getangiejobs5.s_status eq "4">
						<cfset this_status="Unsolved">
					<cfelseif getangiejobs5.s_status eq "5">
						<cfset this_status="Cancel">
					</cfif>
					#getangiejobs5.custno# - #getangiejobs5.apptime#<br>#getangiejobs5.servicetype# (#this_status#)<br><br>
				</cfoutput>
			</td>
		</tr>
	</cfloop>
	<!--- <tr>
		<th>Edwin</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "Edwin" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<th>Daphne</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "Daphne" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<th>Krystal</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "Krystal" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<th>Larry</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "Larry" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<th>Jun Yong</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "JunYong" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<th>Wee Siong</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "WeeSiong" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<th>Zu Lee</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "ZuLee" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<th>Others</th>
	  	<cfquery datasource='#dts#' name="getangiejobs1">
			select custno,servicetype,apptime from service_tran where csoid = "others" and servicedate >= now();
		</cfquery>
	  	<td>
	  		<cfoutput query="getangiejobs1">
				#getangiejobs1.custno# - #getangiejobs1.apptime#<br>#getangiejobs1.servicetype#<br><br>
			</cfoutput>
		</td>
	</tr> --->
</table>
</body>
</html>
