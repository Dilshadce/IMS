<cfquery name="getgrade" datasource="#dts#">
	select * from icgroup
	where wos_group = <cfqueryparam cfsqltype="cf_sql_char" value="#wos_group#">
</cfquery>
<cfquery name="getqtybf" datasource="#dts#">
	select * from logrdob
	where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	and location = <cfqueryparam cfsqltype="cf_sql_char" value="#location#">
</cfquery>
<html>
<head>
	<title>Edit Item - Grade Opening Quantity</title>
	<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function checkqty(){
			var exactqty = document.itemform.qtybf.value;
			var firstcount = document.itemform.firstcount.value;
			var maxcounter = document.itemform.maxcounter.value;
			
			var totqty = 0;
			varlist = document.itemform.varlist.value;
			var newArray = varlist.split(",");
			
			newlistvalue = "";
			for(i=0;i<newArray.length;i++){
				totqty = totqty + parseInt(document.getElementById(newArray[i]).value);
				if(i==0){
					newlistvalue = document.getElementById(newArray[i]).value;
				}
				else{
					newlistvalue = newlistvalue + "," + document.getElementById(newArray[i]).value;
				}
			}
			document.itemform.qtybflist.value = newlistvalue;
			//if(totqty > exactqty){
				//alert("The total qty cannot more than " + exactqty);
				//return false;
			//}
			//else{
				//return true;
			//}
		}
	</script>
</head>
<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<body> 
<h1 align="center"><cfoutput>#wos_group# - Edit Item <font color="red">#itemno#</cfoutput></font> - Grade Opening Quantity <cfif location neq "">(Location - <cfoutput><font color="red">#location#</cfoutput></font>)</cfif></h1>
<h2 align="right"><a style="cursor:pointer" onClick="window.close()"><u>Exit</u></a></h2>
<cfset totcol = 5>
<cfset firstcount = 11>
<cfset maxcounter = 310>
<cfset totalrecord = (maxcounter - firstcount + 1)>
<cfset totrow = ceiling(totalrecord / totcol)>

<cfloop from="#firstcount#" to="#maxcounter#" index="i">
	<cfif i eq firstcount>
		<cfset mylist = i>
		<cfset varlist = "grd"&i>
	<cfelse>
		<cfset mylist = mylist&","&i>
		<cfset varlist = varlist&",grd"&i>
	</cfif>	
</cfloop>

<cfset myArray = ListToArray(mylist,",")>
<cfoutput>
<form name="itemform" action="act_editgrade.cfm?pageno=#url.pageno#" method="post">

	<input type="hidden" name="itemno" value="#convertquote(itemno)#">
	<input type="hidden" name="location" value="#location#">
	<input type="hidden" name="qtybf" value="#qtybf#">
	<input type="hidden" name="firstcount" value="#firstcount#">
	<input type="hidden" name="maxcounter" value="#maxcounter#">
	<input type="hidden" name="totalrecord" value="#totalrecord#">
	<input type="hidden" name="varlist" value="#varlist#">
	<input type="hidden" name="qtybflist" value="">

<table border="0" align="center" width="80%" class="data">
	<cfloop from="1" to="#totrow#" index="i">
		<tr>
			<cfloop from="0" to="#totcol-1#" index="j">
				<cfset thisrecord = i+(j*totrow)>
				<cfif thisrecord LTE totalrecord>
			
						<cfif Evaluate("getgrade.GRADD#myArray[thisrecord]#") neq "">
								
							<td>#thisrecord#. #Evaluate("getgrade.GRADD#myArray[thisrecord]#")#</td>
							<td>
								<cfif getqtybf.recordcount neq 0>
									<cfset thisqtybf = Evaluate("getqtybf.GRD#myArray[thisrecord]#")>
								<cfelse>
									<cfset thisqtybf = 0>
								</cfif>
								<input type="text" value="#thisqtybf#" size="10" id="grd#myArray[thisrecord]#" name="grd#myArray[thisrecord]#" onBlur="if(this.value==''){this.value = '0'}">
							</td>
						<cfelse>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<input type="hidden" value="0" size="10" id="grd#myArray[thisrecord]#" name="grd#myArray[thisrecord]#">
						</cfif>
				
				</cfif>
			</cfloop>
		</tr>
	</cfloop>
	<tr><td colspan="100%" align="center" height="10"></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" value="Save" onClick="return checkqty();">
		</td>
	</tr>
</table>
</form>
</cfoutput>
</body>
</html>