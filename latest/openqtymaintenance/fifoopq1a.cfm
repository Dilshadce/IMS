<html>
<head>
<title>Edit Item Opening Quantity/Cost</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfoutput>

<cfparam name="Submit" default="">
<cfparam name="ttqty" default="0">
<cfset itemno = "#urldecode(url.itemno)#">
<cfif submit eq "submit">
    <cfquery name="updateicitem" datasource="#dts#">
		update icitem set 
		ucost='#fixed#',
		avcost='#average#',
		avcost2='#moving#' 
		where itemno='#itemno#';
	</cfquery>	
    <cflocation url="fifoopq.cfm">
    
<cfelseif isdefined("form.submit") and form.submit eq "FIFO">
	<form name="done" action="fifoopq2.cfm?itemno=#urlencodedformat(itemno)#" method="post">
		<input name="fixed" type="hidden" value="#fixed#">
		<input name="average" type="hidden" value="#average#">
		<input name="moving" type="hidden" value="#moving#">
		<input type="hidden" name="itemno" value="#itemno#">
	</form>
	<script language="javascript" type="text/javascript">
		done.submit();
	</script>
    
<cfelseif isdefined("form.submit") and form.submit eq "GRADED"> 
	<form name="done" action="graded.cfm" method="post">
		<input type="hidden" name="itemno" value="#urldecode(url.itemno)#">
	</form>
	<script language="javascript" type="text/javascript">
		done.submit();
	</script>
</cfif>

<cfquery name="insert" datasource="#dts#">
	insert ignore into fifoopq (itemno) values ('#urldecode(url.itemno)#');
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno,unit,qtybf,ucost,avcost,avcost2,graded 
	from icitem 
	where itemno='#url.itemno#';
</cfquery>

<body>
<h1 align="center">Item Opening Quantity</h1>

<form name="form" method="post" action="fifoopq1.cfm?itemno=#urlencodedformat(itemno)#">
<table width="85%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
	<tr>
    	<th>Item No.</th>
    	<th>Unit</th>
    	<th>Qty B/f</th>
    	<th>Fixed Cost</th>
    	<th>Mth.Ave.Cost</th>
    	<th>Mov.Ave.Cost</th>
    	<th>FIFO</th>
		<cfif getitem.graded eq "Y">
			<th>GRADED</th>
		</cfif>
  	</tr>
  	
	<cfloop query="getitem">
  	<tr>
    	<td>#itemno#</td>
    	<td><div align="center">#unit#</div></td>
    	<td><div align="right">#qtybf#</div></td>
    	<td><div align="center"><input name="fixed" type="text" value="#numberformat(ucost,",_.____")#" size="10" maxlength="10"></div></td>
    	<td><div align="center"><input name="average" type="text" value="#numberformat(avcost,",_.____")#" size="10" maxlength="10"></div></td>
    	<td><div align="center"><input name="moving" type="text" value="#numberformat(avcost2,",_.____")#" size="10" maxlength="10"></div></td>
    	<td align="center"><input type="submit" name="submit" value="FIFO"></td>
		<input type="hidden" name="itemno" value="#urldecode(url.itemno)#">
		<cfif getitem.graded eq "Y">
			<td align="center"><input type="submit" name="submit" value="GRADED"></td>
		</cfif>
  	</tr>
  	</cfloop>
</table>
</cfoutput>

<table align="center">
	<tr>
		<td><input name="Submit" type="submit" value="Submit"></td>
		<td><input type="button" name="button" value="Back" onClick="javascript:history.back();"></td>
	</tr>
</table>
</form>

</body>
</html>