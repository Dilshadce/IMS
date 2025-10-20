<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Quotation</title>
<link rel="stylesheet" type="text/css" href="/newinterface/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>
<body class="openerp">
<cfoutput>
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">
<li onClick="SwitchMenu('sub1')">
<a class="oe_secondary_menu_item" style="cursor:pointer">
Quotation
</a>
</li>
<span id="sub1" style="display:block"  class="submenu">
<li>
    <a class="oe_secondary_submenu_item" href="/default/transaction/transaction0.cfm?tran=QUO" target="mainFrame">
       Create Quotation
    </a>
</li>
<li>
    <a class="oe_secondary_submenu_item" href="/default/transaction/transaction.cfm?tran=QUO" target="mainFrame">
       Quotation List
    </a>
</li>
<li>
    <a class="oe_secondary_submenu_item" href="/default/transaction/update/update.cfm?t1=QUO&t2=SO" target="mainFrame">
        Success Deal
    </a>
</li>
</span>



</div>
</div>
</div>
</cfoutput>
</body>
</html>