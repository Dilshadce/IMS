<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "2160,965,48,67,849,851,11,2154,793,782,664,188,665,666,185,689,667,690,668,673,674,961,835,2151,721,718,719,720,722,723,724,980,692,726,725,727,728,2152,698,960,2153,745,694,748,1782,1849,813,696,814,815,816,817,818,819,820,821,822,697,698,749,106,704,16,702,29,703,40,795,752,441,300,753,506,475,754,759,1692,1358,695,757,65,887,668,781,784,783,892,785,786,787,788,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1716,1717,1288,705,706,10,3,808,848,2155,806,805,804">
<cfinclude template="/latest/words.cfm">

<cfquery name="getgeneral" datasource="#dts#">
	select invno,invno_2,invno_3,invno_4,invno_5,invno_6,refno2#tran# as refno2valid from gsetup
</cfquery>

<html>
<head>
	<title>Transaction 0</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<!--- ADD ON 200608 --->
<!--- <cfquery name="getRefnoset" datasource="main">
	select * from refnoset
	where userDept = '#dts#'
	and type = '#tran#'
	order by counter
</cfquery> --->

<cfquery name="getRefnoset" datasource="#dts#">
	select * from refnoset
	where type = '#tran#'
	order by counter
</cfquery>

<cfif lcase(hcomid) eq "solidlogic_i" and tran eq "INV">
	<cfset defaultset="2">
<cfelse>
	<cfset defaultset="1">
</cfif>

<cfif tran eq "INV">
	<cfset refnoname = words[666]>
<cfelseif tran eq "RC">
	<cfset refnoname = words[664]>
<cfelseif tran eq "PR">
	<cfset refnoname = words[188]>
<cfelseif tran eq "DO">
	<cfset refnoname = words[665]>
<cfelseif tran eq "CS">
	<cfset refnoname = words[185]>
<cfelseif tran eq "CN">
	<cfset refnoname = words[689]>
<cfelseif tran eq "DN">
	<cfset refnoname = words[667]>
<cfelseif tran eq "ISS">
	<cfset refnoname = "Issue">
<cfelseif tran eq "PO">
	<cfset refnoname = words[690]>
<cfelseif tran eq "SO">
	<cfset refnoname = words[673]>
<cfelseif tran eq "QUO">
	<cfset refnoname = words[668]>
<cfelseif tran eq "ASSM">
	<cfset refnoname = "Assembly">
<cfelseif tran eq "TR">
	<cfset refnoname = "Transfer">
<cfelseif tran eq "OAI">
	<cfset refnoname = "Adjustment Increase">
<cfelseif tran eq "OAR">
	<cfset refnoname = "Adjustment Reduce">
<cfelseif tran eq "SAM">
	<cfset refnoname = words[674]>
<cfelseif tran eq "RQ">
	<cfset refnoname = words[961]> 
<!---<cfelseif tran eq "ASSM">
	<cfset refnoname = "Assembly/Disassembly"> --->       
</cfif>
<body>
<cfoutput>
<cfform name="form1" action="transaction1.cfm?ttype=create&nexttranno=&tran=#tran#&first=0" method="post">
	<h2>#words[2160]#: (<cfoutput>#refnoname#</cfoutput>)</h2>

	<table width="40%" class="data" cellpadding="3" align="center">
	<tr>
		<th>#refnoname# No</th>
		<th>#words[965]#</th>
	</tr>
	<cfloop query="getRefnoset">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td>
			<cfif lcase(hcomid) eq "kjcpl_i">
			<cfif tran eq 'INV'>
            <cfif getRefnoset.counter eq '1'>
            Invoice-B
            <cfelseif getRefnoset.counter eq '2'>
            Invoice-G
            <cfelseif getRefnoset.counter eq '3'>
            Invoice-S
            <cfelseif getRefnoset.counter eq '4'>
            Invoice-A
            <cfelseif getRefnoset.counter eq '5'>
            Invoice-M
            <cfelse>
            Set #getRefnoset.counter#
            </cfif>
			</cfif>
            <cfif tran eq 'DO'>
            <cfif getRefnoset.counter eq '1'>
            Delivery Order-M
            <cfelse>
            Set #getRefnoset.counter#
            </cfif>
			</cfif>
            <cfelseif lcase(hcomid) eq "mlpl_i">
            <cfif tran eq 'INV'>
            <cfif getRefnoset.counter eq '1'>
            Invoice-C
            <cfelseif getRefnoset.counter eq '2'>
            Invoice-P
            <cfelseif getRefnoset.counter eq '3'>
            Invoice-M
            <cfelse>
            Set #getRefnoset.counter#
            </cfif>
			</cfif>
			<cfelse>Set #getRefnoset.counter#</cfif> - <cfif getRefnoset.refnocode neq '' and getRefnoset.presuffixuse eq '1'>#getRefnoset.refnocode#</cfif>#getRefnoset.lastUsedNo#<cfif getRefnoset.refnocode2 neq '' and getRefnoset.presuffixuse eq '1'>#getRefnoset.refnocode2#</cfif></td>
    		<td align="center"><input name="invset" type="radio" value="#getRefnoset.counter#" <cfif getRefnoset.counter eq defaultset>checked</cfif>></td>
		</tr>
	</cfloop>
	<!--- REMARK ON 200608 --->
  	<!---tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      	<td>Set 1 - #getgeneral.invno#</td>
    	<td align="center"><input name="invset" type="radio" value="invno" checked></td>
	</tr>
  	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>Set 2 - #getgeneral.invno_2#</td>
    	<td align="center"><input name="invset" type="radio" value="invno_2"></td>
   </tr>
  	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>Set 3 - #getgeneral.invno_3#</td>
    	<td align="center"><input name="invset" type="radio" value="invno_3"></td>
  	</tr>
  	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>Set 4 - #getgeneral.invno_4#</td>
    	<td align="center"><input name="invset" type="radio" value="invno_4"></td>
  	</tr>
  	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>Set 5 - #getgeneral.invno_5#</td>
    	<td align="center"><input name="invset" type="radio" value="invno_5"></td>
 	</tr>
  	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>Set 6 - #getgeneral.invno_6#</td>
    	<td align="center"><input name="invset" type="radio" value="invno_6"></td>
  	</tr--->
<cfif getgeneral.refno2valid eq "1">
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<th>Refno 2</th>
<td></td>
</tr>
	<cfloop query="getRefnoset">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td>Set #getRefnoset.counter# - #getRefnoset.lastUsedNo#</td>
    		<td align="center"><input name="invset2" type="radio" value="#getRefnoset.counter#" <cfif getRefnoset.counter eq defaultset>checked</cfif>></td>
		</tr>
	</cfloop>
</cfif>
  	<tr>
    	<td></td>
    	<td align="center"><input type="submit" name="submit" value="submit"></td>
  	</tr>

</table>

</cfform>
</cfoutput>
</body>
</html>