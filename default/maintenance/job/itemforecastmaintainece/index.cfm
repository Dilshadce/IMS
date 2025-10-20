<cfajaximport tags="cfform">
<html>
<head>
<cfajaxproxy bind="javascript:getrowpromo({usersgrid.itemno})">
<link href="/stylesheet/tabber.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/scripts/tabber.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>

<script type="text/javascript">
function editpromo()
{
ColdFusion.Window.show('createpromotion');
}
function assignitem()
{
ColdFusion.Window.show('assignitem');
}
function getrowpromo(itemno)
{
document.getElementById('itemnohid').value = itemno;
}
function additem1(type1)
{
var valueget = document.getElementById(type1).value; 
ajaxFunction(document.getElementById('ajaxFieldPro'),'additemprocess.cfm?type='+type1+'&valueget='+escape(valueget)+'&itemno='+document.getElementById('itemnohid').value+'&price='+escape(document.getElementById('newpricing').value));
setTimeout("ColdFusion.Grid.refresh('itemlist',false);",1000);
}
</script>
</head>
<body>
<h1>
Item Forecast Maintainese
</h1>
<h4>
	<a href="index.cfm" onMouseOver="this.style.cursor='hand'">Assign Item Forecast</a>||<a href="icitemforecasttable.cfm">Item Forecast Listing</a>||<a href="p_item.cfm">Item Forecast Report</a></h4>
<cfform name="promotionform" action="" method="post">
<table width="100%">
<tr>
<td></td>
</tr>
<tr>
					<td>
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:icitemlist.getitemColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter" name="filter">
						<cfinput type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('usersgrid',false)">
                        <cfinput type="hidden" name="itemnohid" id="itemnohid" value="" />
					</td>
					
				</tr>
<tr>
<td>
<div style="min-heigh:200px;">
  <cfgrid name="usersgrid" pagesize="10" format="html" width="100%" height="280"
								bind="cfc:icitemlist.geticitemlist({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
                                onchange="cfc:icitemlist.edititem({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" appendkey="no">
    <cfgridcolumn name="itemno" header="Item No" select="No" width="100">
    <cfgridcolumn name="desp" header="Description" select="no" width="350">
    <cfgridcolumn name="created_by" header="Created By" select="no" width="100">
    <cfgridcolumn name="created_on" header="Created On" select="no" width="150">
    <cfgridcolumn name="assign" header="Assign Item" select="no" width="250" href="javascript:assignitem();">
  </cfgrid>
</div></td>
</tr>
</table>

</table>
</cfform>
</body>
<cfwindow name="assignitem" center="true" source="additem.cfm?itemno={itemnohid}" modal="true" closable="true" width="1000" height="500" refreshonshow="true" title="Assign Item Amount For Item Forecast" />
</html>
</html>