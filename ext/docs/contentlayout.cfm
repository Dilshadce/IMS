<html lang="en">
<head> 
	 <link rel="stylesheet" type="text/css" href="resources/css/reset-min.css" />
    <link rel="stylesheet" type="text/css" href="resources/welcome.css"/>
</head>
<body>
<cfif url.menu_id eq "search">
	<cfif isDefined ("form.keyword")>
		<cfif #form.keyword# eq "">
		Please key in a value.
		<cfelse>
			<cfquery name="getresult" datasource="main">
			SELECT *
			FROM help
			WHERE title LIKE '%#form.keyword#%' limit 20
			</cfquery>
		<cfoutput>
		<h3>Your search for #form.keyword# returned #getresult.recordcount# results.</h3>
		</cfoutput>
		<cfoutput query="getresult">
		
		<a href="contentlayout.cfm?menu_id=#getresult.menu_id#"><i><b>&nbsp;#title#</b></i></a><br>
		&nbsp;&nbsp;&nbsp;&nbsp;*#simple_desp#<br>
		<td colspan="2"><hr/></td>
		</cfoutput>
		</cfif>
	</cfif>

<cfelse>
	
	<cfquery datasource="main" name="getcontent">
			select title,content from help 
			where menu_id='#url.menu_id#';
			
	</cfquery>		
			
    <title></title>
  

<div><font size='+1'><cfoutput><b>#getcontent.title#</b></cfoutput></font></div><br/><br/>

<cfoutput>#getcontent.content#</cfoutput>

       
           <!---  <em>Pg.01</em> --->

    
</body>
</html>

</cfif>	