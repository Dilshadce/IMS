<html>
<head>
<title>Service Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript"><!--- Ignored --->
	function validate()
	{
		if(document.form.servi.value=='')
		{
			alert("Your Service's No. cannot be blank.");
			document.form.servi.focus();
			return false;
		}
		return true;
	}
</script>

<body>


<cfset servi = "">
<cfset desp = "">
<cfset despa = "">
<cfset SALEC = "">
<cfset SALECSC = "">
<cfset SALECNC = "">
<cfset PURC = "">
<cfset PURPRC = "">
<cfset mode = "Create">
<cfset title = "Create Item">
<cfset button = "Create">

<cfoutput>
	<h1>#title#</h1>
		
	<form name="form" action="act_createservice.cfm" method="post">
		<input type="hidden" name="mode" value="#mode#">
		
		<h1 align="center">Service File Maintenance</h1>
 		<table align="center" class="data" width="500">
    		<tr> 
        		<td width="20%">Service :</td>
        		<td colspan="4">
            		<input type="text" size="10" name="servi" value="#servi#" maxlength="8">
				</td>
      		</tr>
      		<tr> 
        		<td>Description:</td>
        		<td colspan="4"><input type="text" size="40" name="desp" value="#desp#" maxlength="40"></td>
      		</tr>
      		<tr> 
        		<td></td>
        		<td colspan="4"><input type="text" size="40" name="despa" value="#despa#" maxlength="40"></td>
      		</tr>
    		<tr> 
      			<td colspan="5"><hr></td>
    		</tr>
    		<tr> 
     	 		<th colspan="5"><div align="center"><strong>Product Details</strong></div></th>
    		</tr>
      		<tr> 
        		<td height="22">Credit Sales</td>
        		<td width="152"><input name="SALEC" type="text" id="SALEC" value="#SALEC#" size="8" maxlength="8"></td>
        		<td width="53" colspan="-1">&nbsp;</td>
        		<td width="118" colspan="-1">Purchase</td>
        		<td width="317" nowrap><input name="PURC" type="text" id="PURC" value="#PURC#" size="8" maxlength="8"></td>
      		</tr>
      		<tr> 
        		<td nowrap>Cash Sales</td>
        		<td><input name="SALECSC" type="text" id="SALECSC" value="#SALECSC#" size="8" maxlength="8"></td>
        		<td colspan="-1">&nbsp;</td>
        		<td colspan="-1">Purchase Return</td>
        		<td><input name="PURPRC" type="text" id="PURPRC" value="#PURPRC#" size="8" maxlength="8"></td>
      		</tr>
	  		<tr>
        		<td nowrap>Sales Return</td>
        		<td><input name="SALECNC" type="text" id="SALECNC" value="#SALECNC#" size="8" maxlength="8"></td>
        		<td colspan="-1">&nbsp;</td>
        		<td colspan="-1">&nbsp;</td>
        		<td>&nbsp;</td>
      		</tr>
    		<tr> 
      			<td height="23"></td>
      			<td colspan="4" align="right"><input name="submit" type="submit" value="  #button#  "></td>
    		</tr>
  		</table>
	</form>
</cfoutput>

</body>
</html>