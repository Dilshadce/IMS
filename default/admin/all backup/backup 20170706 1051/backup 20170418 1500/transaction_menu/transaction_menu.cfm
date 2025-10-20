<html>
<head>
<title>Transaction Menu</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/tab.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="/scripts/tabpane.js"></script>
<script language="javascript" type="text/javascript">
	function setup_pane_page()
	{
		tp1 = new WebFXTabPane(document.getElementById("tabPane1"));
		tp1.addTabPage(document.getElementById("tabPage1"));
		tp1.addTabPage(document.getElementById("tabPage2"));
		tp1.addTabPage(document.getElementById("tabPage3"));
		tp1.addTabPage(document.getElementById("tabPage4"));
	}	
</script>
</head>

<body onLoad="setup_pane_page()">

<h4>
	<cfif getpin2.h5110 eq "T"><a href="../comprofile.cfm">Company Profile</a> </cfif>
    <cfif getpin2.h5120 eq "T">|| <a href="../lastusedno.cfm">Last Used No</a> </cfif>
    <cfif getpin2.h5130 eq "T">|| <a href="../transaction.cfm">Transaction Setup</a> </cfif>
    <cfif getpin2.h5140 eq "T">|| <a href="../Accountno.cfm">AMS Accounting Default Setup</a> </cfif> 
    <cfif getpin2.h5150 eq "T">|| <a href="../userdefine.cfm">User Defined</a> </cfif>
    <cfif getpin2.h5160 eq "T">||<a href="../dealer_menu/dealer_menu.cfm">Dealer Menu</a> </cfif> 
    <cfif getpin2.h5170 eq "T">||Transaction Menu</cfif> 
    <cfif getpin2.h5180 eq "T">||<a href="../userdefineformula.cfm">User Define - Formula</a></cfif>
     <cfif husergrpid eq "super">||<a href="../modulecontrol.cfm">Module Control</a></cfif>
    <cfif getpin2.h5130 eq "T">||<a href="../displaysetup.cfm">Listing Setup</a></cfif>
    <cfif getpin2.h5130 eq "T">||<a href="../displaysetup2.cfm">Display Detail</a></cfif>
</h4>

<h1 align="center">General Setup - Transaction Menu</h1>

<cfquery name="get_transaction_menu_setting" datasource="#dts#">
	select 
	* 
	from transaction_menu;
</cfquery>

<div class="tab-pane" id="tabPane1">
	<cfform name="transaction_menu" action="update_transaction_menu.cfm" method="post">
		<cfinput name="company_id" type="hidden" value="#get_transaction_menu_setting.company_id#">
		<div class="tab-page" id="tabPage1">
			<h2 class="tab" align="center">Add Header</h2>
			
			<cfinclude template = "transaction_menu_add_header.cfm">
		</div>
		
		<div class="tab-page" id="tabPage2">
			<h2 class="tab" align="center">Add Body</h2>
			
			<cfinclude template = "transaction_menu_add_body.cfm">
		</div>
		
		<div class="tab-page" id="tabPage3">
			<h2 class="tab" align="center">Add Footer</h2>

			<cfinclude template = "transaction_menu_add_footer.cfm">
		</div>
		
		<div class="tab-page" id="tabPage4">
			<h2 class="tab" align="center">Others</h2>
			
			<cfinclude template = "transaction_menu_other.cfm">
		</div>
		
		<table align="center" class="data" width="50%">
			<tr>
				<td align="center">
					<input name="Save" type="submit" value="Save">
					<input name="Reset" type="reset" value="Reset">
				</td>
			</tr>
		</table>
	</cfform>
</div>

</script>
</body>
</html>