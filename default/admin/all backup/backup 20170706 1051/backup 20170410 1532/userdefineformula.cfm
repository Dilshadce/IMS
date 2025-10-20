<html>
<head>
<title>User Defined</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function test(){
		var s = "The+dog-whose*name/is(Fido)is%here";
		var word_list = s.split(/\W/);
		for(i=0;i<word_list.length;i++){
			alert(word_list[i]);
		}
	}
	
	function verify(fieldname,s){
		var word_list = s.split(/\W/);
		for(i=0;i<word_list.length;i++){
			if(word_list[i].search(/\D/)!='-1'){
				if(word_list[i].toLowerCase() !='xqty1' && word_list[i].toLowerCase() !='xqty2' && word_list[i].toLowerCase() !='xqty3' && word_list[i].toLowerCase() !='xqty4' && word_list[i].toLowerCase() !='xqty5' && word_list[i].toLowerCase() !='xqty6' && word_list[i].toLowerCase() !='xqty7' && word_list[i].toLowerCase() !='xfactor1' && word_list[i].toLowerCase() !='xfactor2' && word_list[i].toLowerCase() !='round' && word_list[i].toLowerCase() !='int' && word_list[i].toLowerCase() !='iif'){
					alert('Variable '+word_list[i]+' is not found!');
					document.getElementById(fieldname).focus();
					break;
				}
			}			
		}
	}
	
</script>
</head>

<cfif isdefined("url.type")>
	<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update gsetup set 
		xqty1='#form.xqty1#',
		xqty2='#form.xqty2#',
		xqty3='#form.xqty3#',
		xqty4='#form.xqty4#',
		xqty5='#form.xqty5#',
		xqty6='#form.xqty6#',
		xqty7='#form.xqty7#',
		qtyformula='#form.qtyformula#',
		priceformula='#form.priceformula#'
		where companyid='IMS';
	</cfquery>
</cfif>

<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup
</cfquery>

<body>

<h4>
	<cfif getpin2.h5110 eq "T"><a href="comprofile.cfm">Company Profile</a> </cfif>
    <cfif getpin2.h5120 eq "T">|| <a href="lastusedno.cfm">Last Used No</a> </cfif>
    <cfif getpin2.h5130 eq "T">|| <a href="transaction.cfm">Transaction Setup</a> </cfif>
    <cfif getpin2.h5140 eq "T">|| <a href="Accountno.cfm">AMS Accounting Default Setup</a> </cfif> 
    <cfif getpin2.h5150 eq "T">|| <a href="userdefine.cfm">User Defined</a> </cfif>
    <cfif getpin2.h5160 eq "T">||<a href="dealer_menu/dealer_menu.cfm">Dealer Menu</a> </cfif> 
    <cfif getpin2.h5170 eq "T">||<a href="transaction_menu/transaction_menu.cfm">Transaction Menu</a> </cfif> 
    <cfif getpin2.h5180 eq "T">||User Define - Formula</cfif>
     <cfif husergrpid eq "super">||<a href="modulecontrol.cfm">Module Control</a></cfif>
    <cfif getpin2.h5130 eq "T">||<a href="displaysetup.cfm">Listing Setup</a></cfif>
    <cfif getpin2.h5130 eq "T">||<a href="displaysetup2.cfm">Display Detail</a></cfif>
</h4>

<h1>General Setup - User Define - Formula</h1>
<cfoutput>
<form name="form" action="userdefineformula.cfm?type=save" method="post">
	<table width="600" align="center" class="data" cellspacing="0">
		<tr> 
      		<td colspan="100%"><div><h3>Formula for Qtye,Pricee</h3></div></td>
    	</tr>
		<tr> 
		  	<th>Qtye</th>
		  	<td><input name="qtyformula" type="text" size="60" value="#getGeneralInfo.qtyformula#" onBlur="verify('qtyformula',this.value);"></td>
		</tr>
		<tr> 
		  	<th>Pricee</th>
		  	<td><input name="priceformula" type="text" size="60" value="#getGeneralInfo.priceformula#" onBlur="verify('priceformula',this.value);"></td>
		</tr>
		<tr><td colspan="100%"><hr></td></tr>
		<tr>
			<td colspan="100%"><div><h3>User Define</h3></div></td>
		</tr>
		<tr>
			<td>xqty1=</td>
			<td><input type="text" name="xqty1" value="#getGeneralInfo.xqty1#"></td>
		</tr>
		<tr>
			<td>xqty2=</td>
			<td><input type="text" name="xqty2" value="#getGeneralInfo.xqty2#"></td>
		</tr>
		<tr>
			<td>xqty3=</td>
			<td><input type="text" name="xqty3" value="#getGeneralInfo.xqty3#"></td>
		</tr>
		<tr>
			<td>xqty4=</td>
			<td><input type="text" name="xqty4" value="#getGeneralInfo.xqty4#"></td>
		</tr>
		<tr>
			<td>xqty5=</td>
			<td><input type="text" name="xqty5" value="#getGeneralInfo.xqty5#"></td>
		</tr>
		<tr>
			<td>xqty6=</td>
			<td><input type="text" name="xqty6" value="#getGeneralInfo.xqty6#"></td>
		</tr>
		<tr>
			<td>xqty7=</td>
			<td><input type="text" name="xqty7" value="#getGeneralInfo.xqty7#"></td>
		</tr>
		<tr> 
		  	<td colspan="100%" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</form>
</cfoutput>
</body>
</html>