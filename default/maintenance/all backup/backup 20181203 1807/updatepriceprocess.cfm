

<cfif form.radio1 eq 'preview'>
<html>
<head>
<title>Item Needed to Generate Transfer Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfparam name="row" default="0">
<cfparam name="ttpoohso" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfquery name="getitem" datasource="#dts#">
select * from icitem where wos_group=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemgroup#">
</cfquery>
<body>

<table width="100%" border="0" align="center" cellspacing="0">
	<cfoutput>
    <tr>
    	<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Update Item Price Preview</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq "">
          	<font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font> </cfif></td>
      	<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr><td colspan="100%"><br></td></tr>
  	</cfoutput>
  	<tr>
    	<td colspan="100%"><hr></td>
  	</tr>
  	<tr>
	    <td><font size="2" face="Times New Roman, Times, serif">ITEM NO</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">FOREIGN PRICE</font></td>
         <td><font size="2" face="Times New Roman, Times, serif">CURRENT LOCAL PRICE</font></td>
	    <td><font size="2" face="Times New Roman, Times, serif">AFTER UPDATE LOCAL PRICE</font></td>
        
	</tr>
  	<tr>
    	<td colspan="100%"><hr></td>
  	</tr>
  	<tr>
    	<td colspan="5"></td>
    </tr>
	<cfoutput query="getitem">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.fprice),',_.__')#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.price),',_.__')#</font></td>
            <cfset localprice=val(getitem.fprice)*val(form.sellingrate)>
            <td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(localprice),',_.__')#</font></td>
	</tr>
    
  </cfoutput>
</table>
</body>
</html>
<cfelse>

<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfset localprice=0>

<cfquery name="getitem" datasource="#dts#">
select * from icitem where wos_group=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemgroup#">
</cfquery>

<cfloop query="getitem">

<cfset localprice=val(getitem.fprice)*val(form.sellingrate)>

<cfquery name="updateitem" datasource="#dts#">
update icitem set price='#localprice#' where itemno='#getitem.itemno#'
</cfquery>

</cfloop>

<cfoutput>
	<h2>Local Price has been updated for all items in group #form.itemgroup#</h2>
</cfoutput>
</cfif>