<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Trace Refno 2 duplicate</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<cfquery datasource="#dts#" name="getitem">
	select refno,refno2,custno from artran where type='RC' and (void='' or void is null) and fperiod!='99'
    and refno2!=''
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select lcategory,lgroup from gsetup
</cfquery>


<body>
<h1><center>Trace Refno 2 duplicate</center></h1>
<cfoutput>
	<table align="center" class="data" width="95%">
		<tr> 
    		<th>Ref No.</th>
            <th>Ref No. 2</th>
    		<th>Date</th>
            <th>Supplier No</th>
            <th>Name</th>
           
		</tr>
		<cfloop query="getitem">
        <cfquery datasource="#dts#" name="getitem2">
		select refno,refno2,wos_date,custno,name from artran where type='RC' and (void='' or void is null) and 		fperiod!='99'
    and refno2='#getitem.refno2#' and custno='#getitem.custno#' and refno!='#getitem.refno#' order by refno2
		</cfquery>
        <cfloop query="getitem2">
		<tr> 
     	 	<td>#getitem2.refno#</td>
      		<td>#getitem2.refno2#</td>
	  		<td>#dateformat(getitem2.wos_date,'DD/MM/YYYY')#</td>
	  		<td>#getitem2.custno#</td>
            <td>#getitem2.name#</td>
         
    	</tr></cfloop></cfloop>
	</table>
</cfoutput>

<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>