<html>
<head>
<title>Edit Item Opening Quantity/Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="Submit" default="">
<cfparam name="ttqty" default="0">

<cfif submit eq "submit">
	<cfset cnt = 50>
	
  	<cfloop index="i" from="1" to="40"> 
		
		<cfset ndatecreate = listgetat(form.ffd,i)>
        <cfif listgetat(form.ffd,i) neq "00/00/0000">
        
		<cfset dd=dateformat(listgetat(form.ffd,i), 'DD')>
		
		<cfif dd greater than '12'>
			<cfset nDateCreate=dateformat(listgetat(form.ffd,i),"YYYYMMDD")>
		<cfelse>
			<cfset nDateCreate=dateformat(listgetat(form.ffd,i),"YYYYDDMM")>
		</cfif>
        <cfelse>
        <cfset nDateCreate= "0000-00-00">
		</cfif>	
		<cfset ffq = "ffq"&"#cnt#">
		<cfset ffc = "ffc"&"#cnt#">
		<cfset ffd = "ffd"&"#cnt#">
		
		<cfquery name="getopq" datasource="#dts#">
			update fifoopq set 
			#ffq#='#listgetat(form.ffq,i)#',
			#ffc#='#listgetat(form.ffc,i)#',
			#ffd#='#ndatecreate#' 
			where itemno = '#CFGRIDKEY#';
		</cfquery>
		
		<cfset ttqty = ttqty + listgetat(form.ffq,i)>
		<cfset cnt = cnt - 1>
  	</cfloop>
	
	<cfquery name="updateicitem" datasource="#dts#">
		update icitem set 
		qtybf='#ttqty#' 
		where itemno='#CFGRIDKEY#';
	</cfquery>
<cfelse>
	<cfquery name="updateicitem" datasource="#dts#">
		update icitem set 
		ucost='#val(replace(form.fixed,",",""))#',
		avcost='#val(replace(form.average,",",""))#',
		avcost2='#val(replace(form.moving,",",""))#' 
		where itemno='#CFGRIDKEY#';
	</cfquery>	
</cfif>

<body>
<h2 align="center">Item No - <cfoutput>#CFGRIDKEY#</cfoutput></h2>
<h2 align="right"><a href="fifoopq.cfm"><u>Exit</u></a></h2>

<form name="form" method="post" action="">
	<table width="70%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
  		<tr>
    		<th>&nbsp;</th>
    		<th>Qty</th>
    		<th>Cost</th>
    		<th>Date (DD/MM/YYYY)</th>
  		</tr>
		
		<cfset cnt = 50>
  		
		<cfloop condition="cnt gte 11">  
  			<cfset ffq = "ffq"&"#cnt#">
			<cfset ffc = "ffc"&"#cnt#">
			<cfset ffd = "ffd"&"#cnt#">
  			
			<cfquery name="getopq" datasource="#dts#">
				select #ffq# as xffq, #ffc# as xffc, #ffd# as xffd 
				from fifoopq 
				where itemno='#CFGRIDKEY#';
			</cfquery>
	
			<cfif getopq.xffq eq "">
				<cfset vffq = 0>
			<cfelse>
				<cfset vffq = getopq.xffq>
			</cfif>
			
			<cfif getopq.xffc eq "">
				<cfset vffc = 0>
			<cfelse>
				<cfset vffc = getopq.xffc>
			</cfif>
			
			<cfif getopq.xffd eq "">
				<cfset vffd = "00/00/0000">
			<cfelse>
				<cfset vffd = dateformat(getopq.xffd,"dd/mm/yyyy")>
			</cfif>
			
			<cfoutput>
  				<cfset cnt2 = cnt -10>
  				
				<tr>
    				<td><cfif cnt eq 50>OLDEST<cfelse>#cnt2#</cfif></td>
    				<td><input name="ffq" type="text" value="#vffq#" size="21" maxlength="21"></td>
					<td><input name="ffc" type="text" value="#vffc#" size="21" maxlength="21"></td>
					<td><input name="ffd" type="text" value="#vffd#" size="10" maxlength="10"></td>
  				</tr>
  			</cfoutput>
  			
			<cfset cnt = cnt -1>
  		</cfloop>
  		
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><input name="itemno" type="hidden" value="#CFGRIDKEY#"></td>
			<td><input name="Submit" type="submit" value="Submit"></td>
  		</tr>   
	</table>
</form>

</body>
</html>