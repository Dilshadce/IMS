<html>
<head>
<title>User Defined Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="submit" default="">

<cfif submit eq 'submit'>
	<cfquery name="getuserpin" datasource="#dts#">
		select * from userpin order by code
	</cfquery>
	
	<cfif isdefined("form.admin")>	
		<cfset cnt = listlen(form.admin)>
		
		<cfquery name="updatepin" datasource="#dts#">
			update userpin set admin = 'F' , super = 'F'
		</cfquery>
		
		<cfloop from="1" to="#cnt#" index="i">			 
			<cfquery name="updateuserpin" datasource="#dts#">
				update userpin set admin = 'T' 
				where code = '#listgetat(form.admin,i)#'
			</cfquery>
			
			<cfquery name="updateuserpin" datasource="#dts#">
				update userpin set super = 'T' 
				where code = '#listgetat(form.admin,i)#'
			</cfquery>			
		</cfloop>
		
		<cfquery datasource='#dts#' name="gethuserpin">
			Select code, admin as level, super as level2 from userpin order by code
		</cfquery>
		
		<cfoutput query="gethuserpin">
			<cfset xcode = "H"&"#code#">
					
			<cfquery name="updatepin" datasource="#dts#">
				update userpin2 set #xcode# = '#level#' where level = 'Admin'
			</cfquery>
			
			<cfquery name="updatepin" datasource="#dts#">
				update userpin2 set #xcode# = '#level2#' where level = 'Super'
			</cfquery>
		</cfoutput>
	</cfif>
	
	<cfif isdefined("form.standard")>	
		<cfset cnt = listlen(form.standard)>
		
		<cfquery name="updatepin" datasource="#dts#">
			update userpin set standard = 'F'
		</cfquery>
		
		<cfloop from="1" to="#cnt#" index="i">			 
			<cfquery name="updateuserpin" datasource="#dts#">
				update userpin set standard = 'T' 
				where code = '#listgetat(form.standard,i)#'
			</cfquery>			
		</cfloop>
		
		<cfquery datasource='#dts#' name="gethuserpin">
			Select code, standard as level from userpin order by code
		</cfquery>
		
		<cfoutput query="gethuserpin">
			<cfset xcode = "H"&"#code#">		
			
			<cfquery name="updatepin" datasource="#dts#">
				update userpin2 set #xcode# = '#level#' where level = 'standard'
			</cfquery>
		</cfoutput>
	</cfif>
	
	<cfif isdefined("form.general")>
		<cfset cnt = listlen(form.general)>
		
		<cfquery name="updatepin" datasource="#dts#">
			update userpin set general = 'F'
		</cfquery>
		
		<cfloop from="1" to="#cnt#" index="i">			 
			<cfquery name="updateuserpin" datasource="#dts#">
				update userpin set general = 'T' 
				where code = '#listgetat(form.general,i)#'
			</cfquery>
		</cfloop>
		
		<cfquery datasource='#dts#' name="gethuserpin">
			Select code, general as level from userpin order by code
		</cfquery>
		
		<cfoutput query="gethuserpin">
			<cfset xcode = "H"&"#code#">		
			
			<cfquery name="updatepin" datasource="#dts#">
				update userpin2 set #xcode# = '#level#' where level = 'general'
			</cfquery>
		</cfoutput>
	</cfif>
	
	<cfif isdefined("form.limited")>
		<cfset cnt = listlen(form.limited)>
		
		<cfquery name="updatepin" datasource="#dts#">
			update userpin set limited = 'F'
		</cfquery>
		
		<cfloop from="1" to="#cnt#" index="i">			 
			<cfquery name="updateuserpin" datasource="#dts#">
				update userpin set limited = 'T' 
				where code = '#listgetat(form.limited,i)#'
			</cfquery>
		</cfloop>
		
		<cfquery datasource='#dts#' name="gethuserpin">
			Select code, limited as level from userpin order by code
		</cfquery>
		
		<cfoutput query="gethuserpin">
			<cfset xcode = "H"&"#code#">		
			<cfquery name="updatepin" datasource="#dts#">
				update userpin2 set #xcode# = '#level#' where level = 'limited'
			</cfquery>
		</cfoutput>
	</cfif>
	
	<cfif isdefined("form.mobile")>
		<cfset cnt=listlen(form.mobile)>
		
		<cfquery name="updatepin" datasource="#dts#">
			update userpin set mobile = 'F'
		</cfquery>
		
		<cfloop from="1" to="#cnt#" index="i">			 
			<cfquery name="updateuserpin" datasource="#dts#">
				update userpin set mobile = 'T' 
				where code = '#listgetat(form.mobile,i)#'
			</cfquery>
		</cfloop>
		
		<cfquery datasource='#dts#' name="gethuserpin">
			Select code, mobile as level from userpin order by code
		</cfquery>
		
		<cfoutput query="gethuserpin">
			<cfset xcode = "H"&"#code#">		
			<cfquery name="updatepin" datasource="#dts#">
				update userpin2 set #xcode# = '#level#' where level = 'mobile'
			</cfquery>
		</cfoutput>
	</cfif>	
</cfif>

<cfquery name="getuserpin" datasource="#dts#">
	select * from userpin order by code
</cfquery>

<body>
<h1 align="center">User Defined Menu</h1>

<form action="" method="post" name="form1">
<table width="70%" border="0" cellspacing="0" cellpadding="2" align="center" class="data">
	<tr>
		<th>Code</th>
      	<th>Desp</th>
      	<th>Administrator</th>
	  	<th>Standard</th>
      	<th>General</th>
      	<th>Limited</th>
	  	<th>Mobile</th>
    </tr>
		
    <cfoutput query="getuserpin">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 
        	<td>#code#</td>
        	<td>#desp#</td>
        	<td><div align="center"><input type="checkbox" name="admin" value="#code#"<cfif admin eq 'T'>checked</cfif>></div></td>
			<td><div align="center"><input type="checkbox" name="standard" value="#code#"<cfif standard eq 'T'>checked</cfif>></div></td>
        	<td><div align="center"><input type="checkbox" name="general" value="#code#"<cfif general eq 'T'>checked</cfif>></div></td>
        	<td><div align="center"><input type="checkbox" name="limited" value="#code#"<cfif limited eq 'T'>checked</cfif>></div></td>
			<td><div align="center"><input type="checkbox" name="mobile" value="#code#"<cfif mobile eq 'T'>checked</cfif>></div></td>
		</tr>
    </cfoutput> 
    
	<tr>
		<td colspan="6"><div align="right"><input type="submit" name="Submit" value="Submit"></div></td>
    </tr>
</table>
</form>

</body>
</html>