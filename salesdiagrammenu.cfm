<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>News</title>
</head>

<body style="background-repeat: repeat-y;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #336699;
	scrollbar-face-color:#CFCED2;
	scrollbar-shadow-color:#CFCED2;
	scrollbar-highlight-color:#F6F6F7;
	scrollbar-3dlight-color:#B3B3B3;
	scrollbar-darkshadow-color:#919194;
	scrollbar-track-color:#E5E5E5;
	scrollbar-arrow-color:#000000;
	background-color: #C0CFE2;">
 	<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script type="text/javascript">
	
	
	</script>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<img src="images/SALES.jpg" alt="Sales" usemap="#salesmap" style="border:none">

 <map name="salesmap">
 	<cfif getpin2.h1300 eq "T">
   	<area shape="rect" coords="50,70,134,135" href="/default/maintenance/s_icitem.cfm?type=icitem" alt="Item">
    </cfif>
    <cfif getpin2.h2870 eq "T">
   	<area shape="rect" coords="255,70,345,135" href="/default/transaction/transaction.cfm?tran=quo" alt="Quotation">
	</cfif>
	<cfif getpin2.h1200 eq "T">
    <area shape="rect" coords="451,70,533,135" href="/default/maintenance/linkPage.cfm?type=Customer" alt="Customer">
	</cfif>
    
    <cfif getpin2.h4300 eq "T">
   	<area shape="rect" coords="50,280,134,350" href="/default/report-sales/salesmenu.cfm" alt="Sales Report">
    </cfif>
    
    <cfif getpin2.h4J00 eq "T">
   	<area shape="rect" coords="50,430,134,520" href="/default/report-chart/saleschart.cfm" alt="Sales Chart">
    </cfif>
    
    <cfif getpin2.h2880 eq "T">
   	<area shape="rect" coords="255,210,345,300" href="/default/transaction/transaction.cfm?tran=so" alt="Sales Order">
	</cfif>
    
	<cfif getpin2.h2300 eq "T">
   	<area shape="rect" coords="255,350,345,440" href="/default/transaction/transaction.cfm?tran=do" alt="Delivery Order">
	</cfif>
    
    <cfif getpin2.h2400 eq "T">
   	<area shape="rect" coords="255,510,345,600" href="/default/transaction/transaction.cfm?tran=inv" alt="Invoice">
	</cfif>
    
    <cfif getpin2.h2810 eq 'T'>
    <cfif getGeneralInfo.assm_oneset neq '1'>
    <area shape="rect" coords="480,280,560,370" href="/default/transaction/assm0.cfm" alt="Assemble">
    <cfelse>
   	<area shape="rect" coords="480,280,560,370" href="/default/transaction/assm1.cfm" alt="Assemble">
    </cfif>
	</cfif>

	<cfif getpin2.h4F00 eq "T">
   	<area shape="rect" coords="600,280,680,370" href="/default/report-manufacturing/manufacturingmenu.cfm" alt="Assemble Report">
	</cfif>	
    
    <cfif getpin2.h2700 eq "T">
   	<area shape="rect" coords="385,515,470,600" href="/default/transaction/transaction.cfm?tran=dn" alt="Debit Note">
	</cfif>	
    
    <cfif getpin2.h2600 eq "T">
   	<area shape="rect" coords="510,515,600,600" href="/default/transaction/transaction.cfm?tran=cn" alt="Credit Note">
	</cfif>	

 </map> 


</body>
</html>
