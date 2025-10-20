<cfif IsDefined("form.submit")>
	<cftry>
		<cfquery name="gtransno" datasource="#dts#">
			SELECT * FROM glpost
			WHERE reference LIKE '*****%'
		</cfquery>
		<cfloop query="gtransno">
			<cfquery name="delgtrans" datasource="#dts#">
				delete from glpost where entry = '#gtransno.entry#'
			</cfquery>
			<cfquery name="updategtrans" datasource="#dts#">
				update glpost set tranno = tranno-1 where
				entry > '#gtransno.entry#' and batchno = '#gtransno.batchno#'
			</cfquery>
		</cfloop>
		<cfquery name="updateartrans" datasource="#dts#">
			update arpost as a left join glpost as b
			on a.entry=b.entry
			set a.tranno=b.tranno
		</cfquery>
		<cfquery name="updateaptrans" datasource="#dts#">
			update appost as a left join glpost as b
			on a.entry=b.entry
			set a.tranno=b.tranno
		</cfquery>
		<cfquery name="artransno" datasource="#dts#">
			SELECT * FROM arpost
			WHERE reference LIKE '*****%'
		</cfquery>
		<cfquery name="aptransno" datasource="#dts#">
			SELECT * FROM appost
			WHERE reference LIKE '*****%'
		</cfquery>
		<cfquery name="delartrans" datasource="#dts#">
			DELETE FROM arpost WHERE reference LIKE '*****%'
		</cfquery>
		<cfquery name="delaptrans" datasource="#dts#">
			DELETE FROM appost WHERE reference LIKE '*****%'
		</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Fail to delete transaction.\nError Message: <cfoutput>#cfcatch.message#</cfoutput>');
			</script>
		</cfcatch>
	</cftry>
	<cfoutput>
		<script type="text/javascript">	
			alert(
				'#gtransno.recordcount# transactions are deleted from general transaction table.\n'+
				'#artransno.recordcount# transactions are deleted from customer transaction table.\n'+
				'#aptransno.recordcount# transactions are deleted from creditor transaction table.'
			);
		</script>
	</cfoutput>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Delete Unwanted Transaction</title>
<link rel="stylesheet" href="/latest/css/form.css" />
<style>
	h3,p{
		text-align:left;
	}
</style>
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<!--[if (gte IE 6)&(lte IE 8)]>
	<script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
  	<noscript><link rel="stylesheet" href="" /></noscript>
<![endif]-->
</head>
<body class="container">
<cfoutput>
<form class="formContainer form1Button" action="/latest/admin/deletetransaction.cfm" method="post" onsubmit="return confirm('Are you sure you want to delete all transacions with the assigned criteria(s)?\n\nWarning: This step is not reversible.')">
	<div>Delete Unwanted Transaction</div>
	<div>
		<h3 class="formLabel">Delete all transactions where:</h3>
		<p class="formLabel">* Reference No: Contain more than 5 Asterisks (*);</p>
		<p class="formLabel">* Debit Amount: Zero Value;</p>
		<p class="formLabel">* Credit Amount: Zero Value</p>
		<p class="formLabel"></p>
	</div>
	<div><input type="submit" id="submit" name="submit" value="Delete Unwanted Transaction" /></div>
</form>
</cfoutput>
</body>
</html>