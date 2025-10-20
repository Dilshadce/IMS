<html>
<head>
<title>Add Special Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfif isdefined("form.submit")>
	<cfquery name="truncate_customize_transaction" datasource="main">
		truncate customize_transaction;
	</cfquery>
	
	<cfif isdefined("form.customized_transaction")>
		<cfset sql = "">
		
		<cfloop list="#form.customized_transaction#" index="a" delimiters=",">
			<cfset sql = sql&"("&chr(34)&jsstringformat(preservesinglequotes(a))&chr(34)&"),">
		</cfloop>
		
		<cfset sql = removechars(sql,len(sql),1)>
		
		<cfquery name="insert_customize_transaction" datasource="main">
			insert into customize_transaction 
			(
				company_id
			)
			
			values
			#sql#
			;
		</cfquery>
	</cfif>
	<script language="javascript" type="text/javascript">
		alert("Your Setting Has Been Saved !");
		top.frames[1].location.href=top.frames[1].location.href;
	</script>
</cfif>

<cfquery name="getdatabase" datasource="main">
	select 
	ucase(a.userbranch) as userbranch,
	b.customized
	from users as a 
	left join 
	(
		select 
		company_id,
		'Y' as customized 
		from customize_transaction
		order by company_id
	) as b on a.userbranch=b.company_id
	group by a.userbranch 
	order by b.customized desc,a.userbranch;
</cfquery>

<form name="defineddatabase" action="add_special_transaction.cfm" method="post">
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
    	<tr align="center">
      		<td colspan="2"><h2>Add Special Transaction</h2></td>
    	</tr>

    	<cfoutput query="getdatabase">
			<cfif getdatabase.customized eq "Y">
				<tr bgcolor="FFFFFF" onMouseOut="JavaScript:this.style.backgroundColor='';" onMouseOver="JavaScript:this.style.backgroundColor='99FF00';">
					<td align="center"><font face="Times New Roman,Times,serif" size="2">#getdatabase.userbranch#</font></td>
					<td align="left"><input name="customized_transaction" type="checkbox" value="#getdatabase.userbranch#" checked></td>
				</tr>
				<tr>
					<td></td>
				</tr>
			<cfelse>
				<tr bgcolor=#iif((getdatabase.currentrow mod 2) eq 1,DE('"9999FF"'),DE('"99FF99"'))# onMouseOut="JavaScript:this.style.backgroundColor='';" onMouseOver="JavaScript:this.style.backgroundColor='99FF00';">
					<td align="center"><font face="Times New Roman,Times,serif" size="2">#getdatabase.userbranch#</font></td>
					<td align="left"><input name="customized_transaction" type="checkbox" value="#getdatabase.userbranch#"></td>
				</tr>
				<tr>
					<td></td>
				</tr>
			</cfif>
    	</cfoutput>
  	</table>
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
		<tr align="center">
			<td>
				<input name="submit" type="submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</form>
	
</body>
</html>