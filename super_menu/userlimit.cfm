<html>
<head>
<title>AMS User</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<h4>
	<cfif husergrpid eq "Muser">
		<a href="/home2.cfm"><u>Home</u></a>
	</cfif>
</h4>

<cfif isdefined("form.submit")>
	<cfquery name="getdatabase" datasource="main">
	SELECT usercount,companyid FROM useraccountlimit order by companyid
	</cfquery>
    <cfloop query="getdatabase">
    <cfquery name="updatenouser" datasource="main">
    UPDATE useraccountlimit SET usercount = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(evaluate('form.#getdatabase.companyid#'))#">,remark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#getdatabase.companyid#_remark')#">
    WHERE companyid = "#getdatabase.companyid#"
    </cfquery>
    </cfloop>
    
	
	<script language="javascript" type="text/javascript">
		alert("Your Setting Has Been Saved !");
		//top.frames[1].location.href=top.frames[1].location.href;
		top.frames[0].frames[1].location.href=top.frames[0].frames[1].location.href;
	</script>
</cfif>

<cfquery name="getdatabase" datasource="main">
	SELECT usercount,companyid,remark FROM useraccountlimit order by companyid
</cfquery>

<form name="imsuser" action="userlimit.cfm" method="post">
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
    	<tr align="center">
      		<td colspan="2"><h2>Please key in account user limit.</h2></td>
            <td><div align="center"><h2>Remark</h2></div></td>
    	</tr>
    	<cfoutput query="getdatabase">
				<tr bgcolor="FFFFFF" onMouseOut="JavaScript:this.style.backgroundColor='';" onMouseOver="JavaScript:this.style.backgroundColor='99FF00';">
					<td align="center"><font face="Times New Roman, Times, serif" size="2">#getdatabase.companyid#</font></td>
					<td align="left"><input name="#getdatabase.companyid#" type="text" value="#val(getdatabase.usercount)#" checked></td>
					<td align="center"><input name="#getdatabase.companyid#_remark" size="40" type="text" value="#getdatabase.remark#" maxlength="100"></td>
                </tr>
				<tr>
					<td></td>
				</tr>
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