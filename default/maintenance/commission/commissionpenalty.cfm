<html>
<head>
<title>Commission Penalty</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfif isdefined('url.done')>
		<cfquery datasource='#dts#' name="checkexist">
			Select * from commissionpenalty
		</cfquery>
        <cfif checkexist.recordcount eq 0>
        <cfquery datasource='#dts#' name="updatecommissionpenalty">
			insert into commissionpenalty (days35,days45,days60,days90) values ('#form.days35#','#form.days45#','#form.days60#','#form.days90#')
		</cfquery>
        <cfelse>
        <cfquery datasource='#dts#' name="updatecommissionpenalty">
			update commissionpenalty set days35='#form.days35#',days45='#form.days45#',days60='#form.days60#',days90='#form.days90#'
		</cfquery>
        </cfif>
        
<h3>Amendment has been done</h3>
</cfif>
<cfoutput>
		<cfquery datasource='#dts#' name="getitem">
			Select * from commissionpenalty
		</cfquery>
		<cfif getitem.recordcount eq 0>
        <cfset days35=0>
		<cfset days45=0>
		<cfset days60=0>
        <cfset days90=0>
        <cfelse>
		<cfset days35=getitem.days35>
		<cfset days45=getitem.days45>
		<cfset days60=getitem.days60>
        <cfset days90=getitem.days90>
        </cfif>

	<h4>
<a onClick="ColdFusion.Window.show('createcomm');" onMouseOver="this.style.cursor='hand'">Create Commission</a>||<a href="commissionpenalty.cfm">Set Commission Penalty</a>||<a href="p_commission.cfm">Commission Listing</a>||<a href="commReport.cfm">Commission Report</a></h4>
</cfoutput> 

<cfform name="ProjectForm" action="commissionpenalty.cfm?done=1" method="post" onsubmit="return validate()">
  <cfoutput> 
  </cfoutput> 
  <h1 align="center">Commission Penalty Maintenance</h1>
  <table align="center" class="data" width="400">
    <cfoutput> 
      <tr> 
        <td>Less than 35 days</td>
        <td colspan="4">
				<cfinput type="text" size="20" name="days35" value="#days35#" range="-100,100" message="Enter Numbers Only" maxlength="4">%
		</td>
      </tr>
      <tr> 
        <td>Less than 45 days</td>
        <td colspan="4">
				<cfinput type="text" size="20" name="days45" value="#days45#"  range="-100,100" message="Enter Numbers Only" maxlength="4">%
		</td>
      </tr>
      <tr> 
        <td>Less than 60 days</td>
        <td colspan="4">
				<cfinput type="text" size="20" name="days60" value="#days60#" range="-100,100" message="Enter Numbers Only" maxlength="4">%
		</td>
      </tr>
      <tr> 
        <td>Less than 90 days</td>
        <td colspan="4">
				<cfinput type="text" size="20" name="days90" value="#days90#"  range="-100,100" message="Enter Numbers Only" maxlength="4">%
		</td>
      </tr>

    </cfoutput> 
    <tr> 
      <td height="23"></td>
      <td colspan="4" align="right"><cfoutput> 
          <input name="submit" type="submit" value="Save">
        </cfoutput></td>
    </tr>
  </table>
</cfform>
</body>
</html>
