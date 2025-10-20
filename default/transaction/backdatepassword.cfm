<cfprocessingdirective pageencoding="UTF-8">

<cfoutput>
<div align="center">
<cfif getpin2.H2Z00 eq "T">
<cfform name="form" action="/default/transaction/backdatePasswordProcess.cfm?tran=#tran#&nexttranno=#nexttranno#" method="post">
<h4>Please Key in Password for Back Date</h4>
Password :<cfinput type="password" name="passwordString" selected required="yes" validateat="onsubmit" message="Password is Required">
<br/>
<br/>
Remark :       <cfinput type="text" name="backdateremark" selected required="yes">
<br/><br />

<input type="submit" name="btn_sub" value="Submit">
 </cfform>
 <cfelse>
 <h2>This User Is Not Allowed To Open Back Date Bills!</h2>
 </cfif>
</div>
</cfoutput>