<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<!---cfquery name="getgeneral" datasource="#dts#">
	select invno,invno_2,invno_3,invno_4,invno_5,invno_6 from gsetup
</cfquery--->

<!--- ADD ON 200608 --->
<!--- <cfquery name="getRefnoset" datasource="main">
	select * from refnoset
	where userDept = '#dts#'
	and type = '#t2#'
	order by counter
</cfquery> --->

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<cfquery name="getRefnoset" datasource="#dts#">
	select * from refnoset
	where type = '#t2#'
	order by counter
</cfquery>

<cfif t2 eq "INV">
	<cfset refnoname = gettranname.lINV>
<cfelseif t2 eq "RC">
	<cfset refnoname = gettranname.lRC>
<cfelseif t2 eq "PR">
	<cfset refnoname = gettranname.lPR>
<cfelseif t2 eq "DO">
	<cfset refnoname = gettranname.lDO>
<cfelseif t2 eq "CS">
	<cfset refnoname = gettranname.lCS>
<cfelseif t2 eq "CN">
	<cfset refnoname = gettranname.lCN>
<cfelseif t2 eq "DN">
	<cfset refnoname = gettranname.lDN>
<cfelseif t2 eq "ISS">
	<cfset refnoname = "Issue">
<cfelseif t2 eq "PO">
	<cfset refnoname = gettranname.lPO>
<cfelseif t2 eq "SO">
	<cfset refnoname = gettranname.lSO>
<cfelseif t2 eq "QUO">
	<cfset refnoname = gettranname.lQUO>
<cfelseif t2 eq "ASSM">
	<cfset refnoname = "Assembly">
<cfelseif t2 eq "TR">
	<cfset refnoname = "Transfer">
<cfelseif t2 eq "OAI">
	<cfset refnoname = "Adjustment Increase">
<cfelseif t2 eq "OAR">
	<cfset refnoname = "Adjustment Reduce">
<cfelseif t2 eq "SAM">
	<cfset refnoname = gettranname.lSAM>
</cfif>

<body>

<cfform action="updateA.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&refno=#URLEncodedFormat(refno)#" method="post">
	<h2>Please choose 1 set of <cfoutput>#refnoname#</cfoutput> number to continue:</h2>

	<cfoutput>
	<table width="40%" border="0" cellpadding="3" align="center" class="data">
    	<tr>
      		<th>#refnoname# No</th>
      		<th>Selection</th>
		</tr>
		
		<cfloop query="getRefnoset">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td>Set <cfif lcase(hcomid) eq "kjcpl_i">
			<cfif t2 eq 'INV'>
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
            <cfif t2 eq 'DO'>
            <cfif getRefnoset.counter eq '1'>
            Delivery Order-M
            <cfelse>
            Set #getRefnoset.counter#
            </cfif>
			</cfif>
            <cfelseif lcase(hcomid) eq "mlpl_i">
            <cfif t2 eq 'INV'>
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
			<cfelse>Set #getRefnoset.counter#</cfif> -<cfif getRefnoset.refnocode neq '' and getRefnoset.presuffixuse eq '1'>#getRefnoset.refnocode#</cfif> #getRefnoset.lastUsedNo#<cfif getRefnoset.refnocode2 neq '' and getRefnoset.presuffixuse eq '1'>#getRefnoset.refnocode2#</cfif></td>
    		<td align="center"><input name="invset" type="radio" value="#getRefnoset.counter#" <cfif getRefnoset.counter eq 1>checked</cfif>></td>
		</tr>
		</cfloop>
		
  		<!---tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td>Set 1- #getgeneral.invno#</td>
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
 	 	<tr>
    		<td></td>
    		<td align="center"><input type="submit" name="submit" value="submit"></td>
  		</tr>
	</table>
	</cfoutput>
</cfform>
</body>
</html>