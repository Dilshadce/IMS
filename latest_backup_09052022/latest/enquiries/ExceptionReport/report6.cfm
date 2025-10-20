<html>
<head>
<title>Bills With No Serial No Selected Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>


<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="data">
	<tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Bills With No Serial No Selected Report</strong></font></div></td>
	</tr>
    <tr> 
      	<td colspan="4"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></td>
      	<td colspan="8"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
    <tr>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Type</strong></font></div></td>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Ref No</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Date</strong></font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Item No</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Qty</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Serial Qty</strong></font></div></td>
        
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>

	<cfquery name="getitem" datasource="#dts#">
		select itemno from icitem where wserialno="T"
	</cfquery>
    
    <cfset itemlist=valuelist(getitem.itemno)>
	
    <cfquery name="gettran" datasource="#dts#">
		SELECT * FROM(
            SELECT a.wos_date,a.itemno,a.qty,a.refno,a.type,ifnull(b.serialqty,0) as serialqty from ictran as a
            LEFT JOIN
            (	SELECT count(sign) as serialqty,refno,type,trancode,itemno 
                FROM iserial 
                GROUP BY type,refno,trancode,itemno 
            )as b on a.type=b.type and a.refno=b.refno and a.trancode=b.trancode and a.itemno=b.itemno 
           	WHERE a.itemno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
         )AS aa
         WHERE qty != serialqty
         ORDER BY type,wos_date;
	</cfquery>
    
    
    
    
	<cfloop query="gettran">
    
   
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.type#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.refno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#dateformat(gettran.wos_date,'dd/mm/yyyy')#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.itemno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.qty#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.serialqty#</font></div></td>
    </tr>
    
		<tr><td><br></td></tr>
	</cfloop>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	
</table>

</cfoutput>

<cfif gettran.recordcount eq 0>
	<h3 style="color:red">Sorry, No records were found.</h3>
</cfif>

<br><br>

<div align="right">
	<font  face="Arial,Helvetica,sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>

<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>

</body>
</html>