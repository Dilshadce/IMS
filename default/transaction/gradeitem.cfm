<html>
<head>
<title>Enter Qty For Graded Item</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfif isdefined('form.location')>
<cfquery name="getitem" datasource="#dts#">
	select * from logrdob where itemno = '#form.items#' and location='#form.location#'
</cfquery>
<cfelse>
<cfquery name="getitem" datasource="#dts#">
	select * from itemgrd where itemno = '#form.items#'
</cfquery>
</cfif>
<cfquery name="getigrade" datasource="#dts#">
	select * from igrade where type='#tran#' and refno='#nexttranno#' and itemno='#form.items#'
</cfquery>

<cfoutput>
<h1 align="center">Enter Qty For Graded Item <font color="red">#form.items#</font></h1>
<form name="entergradeitem" method="post" action="transaction4.cfm?itemno=#URLEncodedFormat(items)#&hmode=#URLEncodedFormat(hmode)#&tran=#URLEncodedFormat(tran)#
&type1=#URLEncodedFormat(type1)#&nexttranno=#URLEncodedFormat(nexttranno)#&itemcount=#URLEncodedFormat(itemcount)#&service=#URLEncodedFormat(service)#
&agenno=#URLEncodedFormat(agenno)#&currrate=#URLEncodedFormat(currrate)#&refno3=#URLEncodedFormat(refno3)#">
<table align="center" class="data" width="600">
	<input type="hidden" name="items" value="#items#">
	<input type="hidden" name="hmode" value="#hmode#">
	<input type="hidden" name="tran" value="#tran#">
	<input type="hidden" name="type1" value="#type1#">
	<input type="hidden" name="nexttranno" value="#nexttranno#">
	<input type="hidden" name="itemcount" value="#itemcount#">
	<input type="hidden" name="service" value="#service#">
	<input type="hidden" name="agenno" value="#agenno#">
	<input type="hidden" name="currrate" value="#currrate#">
	<input type="hidden" name="refno3" value="#refno3#">
	<input type="hidden" name="location" value="#location#">
	<tr align="center">
		<td>1  .<input name="grd11" type="text" value="#numberformat(getigrade.grd11,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd11 + getitem.bgrd11,".___")#" disabled size="15" maxlength="15"></td>
		<td>16.<input name="grd26" type="text" value="#numberformat(getigrade.grd26,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd26 + getitem.bgrd26,".___")#" disabled size="15" maxlength="15"></td>
		<td>31.<input name="grd41" type="text" value="#numberformat(getigrade.grd41,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd41 + getitem.bgrd41,".___")#" disabled size="15" maxlength="15"></td>
		<td>46.<input name="grd56" type="text" value="#numberformat(getigrade.grd56,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd56 + getitem.bgrd56,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>2  .<input name="grd12" type="text" value="#numberformat(getigrade.grd12,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd12 + getitem.bgrd12,".___")#" disabled size="15" maxlength="15"></td>
		<td>17.<input name="grd27" type="text" value="#numberformat(getigrade.grd27,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd27 + getitem.bgrd27,".___")#" disabled size="15" maxlength="15"></td>
		<td>32.<input name="grd42" type="text" value="#numberformat(getigrade.grd42,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd42 + getitem.bgrd42,".___")#" disabled size="15" maxlength="15"></td>
		<td>47.<input name="grd57" type="text" value="#numberformat(getigrade.grd57,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd57 + getitem.bgrd57,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>3  .<input name="grd13" type="text" value="#numberformat(getigrade.grd13,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd13 + getitem.bgrd13,".___")#" disabled size="15" maxlength="15"></td>
		<td>18.<input name="grd28" type="text" value="#numberformat(getigrade.grd28,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd28 + getitem.bgrd28,".___")#" disabled size="15" maxlength="15"></td>
		<td>33.<input name="grd43" type="text" value="#numberformat(getigrade.grd43,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd43 + getitem.bgrd43,".___")#" disabled size="15" maxlength="15"></td>
		<td>48.<input name="grd58" type="text" value="#numberformat(getigrade.grd58,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd58 + getitem.bgrd58,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>4  .<input name="grd14" type="text" value="#numberformat(getigrade.grd14,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd14 + getitem.bgrd14,".___")#" disabled size="15" maxlength="15"></td>
		<td>19.<input name="grd29" type="text" value="#numberformat(getigrade.grd29,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd29 + getitem.bgrd29,".___")#" disabled size="15" maxlength="15"></td>
		<td>34.<input name="grd44" type="text" value="#numberformat(getigrade.grd44,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd44 + getitem.bgrd44,".___")#" disabled size="15" maxlength="15"></td>
		<td>49.<input name="grd59" type="text" value="#numberformat(getigrade.grd59,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd59 + getitem.bgrd59,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>5  .<input name="grd15" type="text" value="#numberformat(getigrade.grd15,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd15 + getitem.bgrd15,".___")#" disabled size="15" maxlength="15"></td>
		<td>20.<input name="grd30" type="text" value="#numberformat(getigrade.grd30,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd30 + getitem.bgrd30,".___")#" disabled size="15" maxlength="15"></td>
		<td>35.<input name="grd45" type="text" value="#numberformat(getigrade.grd45,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd45 + getitem.bgrd45,".___")#" disabled size="15" maxlength="15"></td>
		<td>50.<input name="grd60" type="text" value="#numberformat(getigrade.grd60,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd60 + getitem.bgrd60,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>6  .<input name="grd16" type="text" value="#numberformat(getigrade.grd16,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd16 + getitem.bgrd16,".___")#" disabled size="15" maxlength="15"></td>
		<td>21.<input name="grd31" type="text" value="#numberformat(getigrade.grd31,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd31 + getitem.bgrd31,".___")#" disabled size="15" maxlength="15"></td>
		<td>36.<input name="grd46" type="text" value="#numberformat(getigrade.grd46,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd46 + getitem.bgrd46,".___")#" disabled size="15" maxlength="15"></td>
		<td>51.<input name="grd61" type="text" value="#numberformat(getigrade.grd61,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd61 + getitem.bgrd61,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>7  .<input name="grd17" type="text" value="#numberformat(getigrade.grd17,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd17 + getitem.bgrd17,".___")#" disabled size="15" maxlength="15"></td>
		<td>22.<input name="grd32" type="text" value="#numberformat(getigrade.grd32,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd32 + getitem.bgrd32,".___")#" disabled size="15" maxlength="15"></td>
		<td>37.<input name="grd47" type="text" value="#numberformat(getigrade.grd47,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd47 + getitem.bgrd47,".___")#" disabled size="15" maxlength="15"></td>
		<td>52.<input name="grd62" type="text" value="#numberformat(getigrade.grd62,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd62 + getitem.bgrd62,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>8  .<input name="grd18" type="text" value="#numberformat(getigrade.grd18,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd18 + getitem.bgrd18,".___")#" disabled size="15" maxlength="15"></td>
		<td>23.<input name="grd33" type="text" value="#numberformat(getigrade.grd33,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd33 + getitem.bgrd33,".___")#" disabled size="15" maxlength="15"></td>
		<td>38.<input name="grd48" type="text" value="#numberformat(getigrade.grd48,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd48 + getitem.bgrd48,".___")#" disabled size="15" maxlength="15"></td>
		<td>53.<input name="grd63" type="text" value="#numberformat(getigrade.grd63,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd63 + getitem.bgrd63,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>9  .<input name="grd19" type="text" value="#numberformat(getigrade.grd19,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd19 + getitem.bgrd19,".___")#" disabled size="15" maxlength="15"></td>
		<td>24.<input name="grd34" type="text" value="#numberformat(getigrade.grd34,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd34 + getitem.bgrd34,".___")#" disabled size="15" maxlength="15"></td>
		<td>39.<input name="grd49" type="text" value="#numberformat(getigrade.grd49,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd49 + getitem.bgrd49,".___")#" disabled size="15" maxlength="15"></td>
		<td>54.<input name="grd64" type="text" value="#numberformat(getigrade.grd64,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd64 + getitem.bgrd64,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>10.<input name="grd20" type="text" value="#numberformat(getigrade.grd20,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd20 + getitem.bgrd20,".___")#" disabled size="15" maxlength="15"></td>
		<td>25.<input name="grd35" type="text" value="#numberformat(getigrade.grd35,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd35 + getitem.bgrd35,".___")#" disabled size="15" maxlength="15"></td>
		<td>40.<input name="grd50" type="text" value="#numberformat(getigrade.grd50,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd50 + getitem.bgrd50,".___")#" disabled size="15" maxlength="15"></td>
		<td>55.<input name="grd65" type="text" value="#numberformat(getigrade.grd65,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd65 + getitem.bgrd65,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>11.<input name="grd21" type="text" value="#numberformat(getigrade.grd21,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd21 + getitem.bgrd21,".___")#" disabled size="15" maxlength="15"></td>
		<td>26.<input name="grd36" type="text" value="#numberformat(getigrade.grd36,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd36 + getitem.bgrd36,".___")#" disabled size="15" maxlength="15"></td>
		<td>41.<input name="grd51" type="text" value="#numberformat(getigrade.grd51,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd51 + getitem.bgrd51,".___")#" disabled size="15" maxlength="15"></td>
		<td>56.<input name="grd66" type="text" value="#numberformat(getigrade.grd66,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd66 + getitem.bgrd66,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>12.<input name="grd22" type="text" value="#numberformat(getigrade.grd22,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd22 + getitem.bgrd22,".___")#" disabled size="15" maxlength="15"></td>
		<td>27.<input name="grd37" type="text" value="#numberformat(getigrade.grd37,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd37 + getitem.bgrd37,".___")#" disabled size="15" maxlength="15"></td>
		<td>42.<input name="grd52" type="text" value="#numberformat(getigrade.grd52,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd52 + getitem.bgrd52,".___")#" disabled size="15" maxlength="15"></td>
		<td>57.<input name="grd67" type="text" value="#numberformat(getigrade.grd67,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd67 + getitem.bgrd67,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>13.<input name="grd23" type="text" value="#numberformat(getigrade.grd23,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd23 + getitem.bgrd23,".___")#" disabled size="15" maxlength="15"></td>
		<td>28.<input name="grd38" type="text" value="#numberformat(getigrade.grd38,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd38 + getitem.bgrd38,".___")#" disabled size="15" maxlength="15"></td>
		<td>43.<input name="grd53" type="text" value="#numberformat(getigrade.grd53,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd53 + getitem.bgrd53,".___")#" disabled size="15" maxlength="15"></td>
		<td>58.<input name="grd68" type="text" value="#numberformat(getigrade.grd68,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd68 + getitem.bgrd68,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>14.<input name="grd24" type="text" value="#numberformat(getigrade.grd24,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd24 + getitem.bgrd24,".___")#" disabled size="15" maxlength="15"></td>
		<td>29.<input name="grd39" type="text" value="#numberformat(getigrade.grd39,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd39 + getitem.bgrd39,".___")#" disabled size="15" maxlength="15"></td>
		<td>44.<input name="grd54" type="text" value="#numberformat(getigrade.grd54,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd54 + getitem.bgrd54,".___")#" disabled size="15" maxlength="15"></td>
		<td>59.<input name="grd69" type="text" value="#numberformat(getigrade.grd69,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd69 + getitem.bgrd69,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<td>15.<input name="grd25" type="text" value="#numberformat(getigrade.grd25,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd25 + getitem.bgrd25,".___")#" disabled size="15" maxlength="15"></td>
		<td>30.<input name="grd40" type="text" value="#numberformat(getigrade.grd40,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd40 + getitem.bgrd40,".___")#" disabled size="15" maxlength="15"></td>
		<td>45.<input name="grd55" type="text" value="#numberformat(getigrade.grd55,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd55 + getitem.bgrd55,".___")#" disabled size="15" maxlength="15"></td>
		<td>60.<input name="grd70" type="text" value="#numberformat(getitem.grd70,".____")#" size="15" maxlength="15" onClick="select();"></td>
		<td><input name="" type="text" value="#numberformat(getitem.grd70 + getitem.bgrd70,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr>
		<td colspan="8"><hr></td>
	</tr>
	<tr align="center">
		<td></td>
		<td></td>
		<td></td>
		<td align="center"><input name="Enter" type="submit" value="Enter"></td>
		<td align="center"><input name="back" type="button" value="Back" onClick="javascript:history.back();javascript:history.back();"></td>
	</tr>
</table>
</form>
</cfoutput>
</body>
</html>