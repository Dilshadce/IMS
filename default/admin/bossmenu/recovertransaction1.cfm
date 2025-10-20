<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Change Brand</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='/scripts/ajax.js'></script>

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldrefno.value == ''){
		alert('Please Select A Old Reference No.');
		return false;
	}
	else{
			return true;
		}
	}
}
</script>

</head>
<body>


<cfquery name="checkexist" datasource="#dts#">
	select a.* from ictran as a left join iclink as b on (b.refno=a.refno and b.type=a.type) where frtype='#form.reftype#' and frrefno='#form.oldrefno#'
</cfquery>

<cfquery name="getupdate" datasource="#dts#">
	select * from iclink  where (type!='#checkexist.type#' or refno!='#checkexist.refno#') and (frtype='#form.reftype#' and frrefno='#form.oldrefno#') group by refno
</cfquery>

<cfif getupdate.recordcount neq '0'>

<cfform name="form" action="act_recovertransaction.cfm" method="post">
<H1>Recover Transaction</H1>

<table align="center" width="60%" class="data" border='1'>
<tr> <td>Type</td><td>Ref No</td> <td>Date</td> <td>Tick To Recover</td></tr>
<cfoutput query="getupdate">

            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
               
                <td>#type#</td>
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
                    <input type='hidden' name='type' value='#type#'>
			  		<td><input type="checkbox" name="checkbox" value="#refno#"></td>
            	</tr>
          	</cfoutput>
	<!--- <tr>
		<th>New Item No.</th>
		<td>
			<select name="newjob">
          		<option value="">Choose a product</option>
          		<cfoutput query="getjob">
            	<option value="#convertquote(source)#">#source# - #project#</option>
          		</cfoutput>
			</select>
		</td>
	</tr> --->
    <cfoutput>
	<input type='hidden' name='frtype' id='frtype' value="#form.reftype#">
	<input type='hidden' name='frrefno' id='frrefno' value="#form.oldrefno#">
	</cfoutput>
		<td colspan="100%" align="center">
			<input type="submit" name="submit" value="Submit" onClick="return checkValidate();">
			
		</td>
	</tr>
</table>
</cfform>
<cfelse>
<cfoutput>
<h3>#form.reftype# No. #form.oldrefno# does not have any bills that need to be recover</h3></cfoutput>
</cfif>
</body>
</html>