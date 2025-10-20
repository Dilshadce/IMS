<cfoutput>
<cfset datestart = dateadd('d',-1,now())>

<cfquery name="checkyearend" datasource="loadbal">
SELECT id,comstatus,yearend_by FROM yearend WHERE date(submited_on) Between "#dateformat(datestart,'YYYY-MM-DD')#" AND "#dateformat(now(),'YYYY-MM-DD')#" and companyid = "#dts#"
ORDER BY submited_on desc
</cfquery>

<cfif checkyearend.yearend_by neq "">
<cfif checkyearend.comstatus eq "Year End Completed" and url.fperiod gte "13">
<cfelse>
<cfif checkyearend.comstatus neq "Year End Completed">
<cfoutput>
<H3>YEAR END IN PROGRESS!</H3>
</cfoutput>
<cfelse>
<cfoutput>
<H3>YEAR END SUCCESS!</H3>
</cfoutput>
</cfif>
<cfabort>
</cfif>
</cfif>

<cfif checkyearend.yearend_by eq "" and checkyearend.comstatus eq "Proceed Year End">
<cfquery name="get_gsetup" datasource="#dts#">
	select lastaccyear,period from gsetup
</cfquery>
<h3>Dear Valued Users,</h3>
<h4>Your year end checking is completed and there has no error found. <font size="+1">Please kindly take note that once year end in progress, system will not be available and all the user will be log out automatically.</font> You may proceed year end as the step below.
</h4>
<br>
<cfform name="yearendform" id="yearendform" action="/checkyearend/proceedyearend.cfm" method="post" onsubmit="return checkconfirm('#get_gsetup.period#');">
<input type="hidden" name="yearendid" id="yearendid" value="#checkyearend.id#">
<table align="center">
<tr>
<th>Enter your password to start year end.</th>
<td><cfinput type="password" name="passfield" id="passfield" validateat="onsubmit" value="" required="yes" size="15" message="Password is required for confirmation!"> </td>
</tr>
<tr>
<th>Current Financial Start Date : </th>
<td>#dateformat(dateadd('d',1,get_gsetup.lastaccyear),'YYYY-MMMM-DD')#</td>
</tr>
<tr>
<th>Closing Months : </th>
<td>#get_gsetup.period#</td>
</tr>
<tr>
<th>New Financial Start Date : </th>
<td><div id="ajfield">#dateformat(dateadd('m',12,dateadd('d',1,get_gsetup.lastaccyear)),'YYYY-MMMM-DD')#</div></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" name="confirmbutton" id="confirmbutton" value="Confirm To Proceed Year End"></td>
</tr>
</table>
</cfform>
<h4>Thank you and have a nice day!</h4>

<h3>Best Regards,<br>

MP4U Team</h3>
<cfabort>
<cfelseif checkyearend.yearend_by eq "" and checkyearend.comstatus eq "Queuing">
<h3>Dear Valued Customers,</h3>
<h4>Your year end checking is in progress! Please kindly wait for few minutes for checking result!
</h4>
<br><br>
<h4>Thank you and have a nice day!</h4>

<h3>Best Regards,<br>

MP4U Team</h3>
<cfabort>
</cfif>

<cfquery name="get_gsetup" datasource="#dts#">
	select lastaccyear,period from gsetup
</cfquery>

<cfset datenow = now()>
<cfset datelast = dateadd('m',18,get_gsetup.lastaccyear)>
<cfset dateget = datediff('d',datenow,datelast)>
        
<h3>Dear Valued Users,</h3>
<cfif checkyearend.yearend_by eq "" and checkyearend.comstatus eq "Error Found">
<h4>Your year end checking is completed and there has error found. <font size="+1">Please kindly refer to the year end checking result email and if you have resolved those error, please kindly proceed to year end closing as step below.</font>
</h4>
<cfelse>
<h4>Your system has <font size="+1">over period 12</font> which required closing as you may face some difficulty is using the system if the system has over period 18. Current system period is <font size="+1">#url.fperiod#</font> and your system has <cfif dateget gte 0><font size="+1">#dateget# days</font> before over period 18<cfelse>already<font size="+1"> over #abs(dateget)# days</font></cfif>. Please kindly proceed to year end closing as the step below. 

</h4>
</cfif>
<br><br>
<cfform name="yearendform" id="yearendform" action="/checkyearend/updateemailprocess.cfm" method="post">
<cfquery name="checkemail" datasource="main">
SELECT useremail FROM users WHERE userid = "#getauthuser()#"
</cfquery>
<table align="center">
<tr>
<th><cfif findnocase('netiquette',checkemail.useremail) neq 0 or checkemail.useremail eq "">Please Kindly Fill In Your Email Address<cfelse>Please Kindly Double Confirm Your Email Address as Below : </cfif></th>
<td><cfinput type="text" name="updateemailladdress" id="updateemailaddress" validate="email" validateat="onsubmit" value="#checkemail.useremail#" required="yes" size="40" message="Email Address is Invalid"> </td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" name="submitbutton" id="submitbutton" value="Click Here To Proceed Year End Checking">
</tr>
</table>
</cfform>
<h4>Thank you and have a nice day!</h4>

<h3>Best Regards,<br>

MP4U Team</h3>
</cfoutput>