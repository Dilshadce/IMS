<cfajaximport tags="cfform">
<html>
<head>
<cfajaxproxy bind="javascript:getrowpromo({usersgrid.id})">
<link href="/stylesheet/tabber.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/scripts/tabber.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>

<script type="text/javascript">
function editfinishedgood()
{
ColdFusion.Window.show('createfisnishedgood');
}
function getrowpromo(id)
{
document.getElementById('fghid').value = id;
}
function formsubmit()
{
reinsert.submit();
}
</script>
</head>
<body>
<h1>
Finished Goods 
</h1>
<h4>
<a href="index.cfm">Create Finished Goods</a>&nbsp;&nbsp;||&nbsp;&nbsp;<a href="listfinish.cfm">List Finished Goods</a>&nbsp;&nbsp;||&nbsp;&nbsp;<a href="finishedgoodreport.cfm">Finished Goods Report</a>&nbsp;&nbsp;||&nbsp;&nbsp;<a href="finishedgoodreport2.cfm">Finished Goods Summary</a></h4>	
<cfform name="promotionform" action="" method="post">
<table width="100%">
<tr>
					<td>
                    
						Filter By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:finishedgood.getfinishedgoodColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter" name="filter">
						<cfinput type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('usersgrid',false)">
                        <cfinput type="hidden" name="fghid" id="fghid" value="" />
					</td>
					
				</tr>
<tr>
<td>
<div style="min-heigh:200px;">
  <cfgrid name="usersgrid" pagesize="10" format="html" width="100%" height="280"
								bind="cfc:finishedgood.getfinishedgood({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')" 
                                onchange="cfc:finishedgood.editfinishedgood({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#')"
                            textcolor="##000000" delete="yes" deletebutton="Delete" appendkey="no" selectmode="edit">
    <cfgridcolumn name="id" header="ID" select="No" width="100" href="javascript:editfinishedgood();" >
    <cfgridcolumn name="project" header="SALES ORDER" select="no" width="200">
    <cfgridcolumn name="itemno" header="ITEM" select="no" width="200">
    <cfgridcolumn name="aitemno" header="PRODUCT CODE" select="no" width="200">
    <cfgridcolumn name="quantity" header="QUANTITY" select="no" width="100">
    <cfgridcolumn name="rcno" header="RECEIVE REFNO" select="no" width="100">
  </cfgrid>
</div></td>
</tr>
</table>

</table>
<input type="hidden" name="fgrefno" id="fgicid" value="">

</cfform>
</body>
<cfwindow name="createfisnishedgood" center="true" source="finishedgood.cfm?id={fghid}" modal="true" closable="true" width="900" height="450" refreshonshow="true" title="Finished Good Assemble List" />
<cfwindow name="addothercode" center="true" source="othercode.cfm?id={fgicid}" modal="true" closable="true" width="900" height="450" refreshonshow="true" title="Add Other Code" />
</html>
</html>