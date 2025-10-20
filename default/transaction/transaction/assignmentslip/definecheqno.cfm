<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Defined Cheque No</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfoutput>
<body>

<h4>
		<a href="Assignmentsliptable2.cfm?type=Create">Create Assignment Slip</a> 
		|| <a href="Assignmentsliptable.cfm?">List all Assignment Slip</a> 
		|| <a href="s_Assignmentsliptable.cfm?type=Assignmentslip">Search For Assignment Slip</a>
        ||  <a href="printcheque.cfm">Print Claim Cheque</a>
        || <a href="printclaim.cfm">Print Claim Voucher</a>
        || <a href="generatecheqno.cfm">Record Claim Cheque No</a>
        || <a href="definecheqno.cfm">Predefined Cheque No</a>
        	</h4>
            
            <cfif isdefined('form.cheqno')>
            <cfquery name="updatecheq" datasource="#dts#">
            UPDATE gsetup SET chequeno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cheqno#">
			</cfquery>
            <script type="text/javascript">
			alert('Update Success!');
            </script>
			</cfif>
            <cfquery name="getcheqno" datasource="#dts#">
            SELECT chequeno FROM gsetup
            </cfquery>
             <h1 align="center">Predefined Auto Cheque No</h1>
             <cfform name="cheqnoform" id="cheqnoform" action="" method="post"><div align="center"> Cheque No :
             <cfinput type="text" name="cheqno" id="cheqno" required="yes" message="Cheque No is Required" align="middle" value="#getcheqno.chequeno#"><br/><input type="submit" name="sub_btn" id="sub_btn" value="Save" /></div> 
             
             </cfform>
</body>
</cfoutput>
</html>