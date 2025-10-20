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

<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lastaccyear from gsetup
</cfquery>

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
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:icitemforecastlist.getitemColumns('#dts#')"
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
								bind="cfc:icitemforecastlist.geticitemforecastlist({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
                                onchange="cfc:icitemforecastlist.edititem({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete" appendkey="no">
    <cfgridcolumn name="itemno" header="Item No" select="No" width="100">
    <cfgridcolumn name="desp" header="Description" select="no" width="350">
    
    <cfgridcolumn name="period1" header="Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period2" header="Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period3" header="Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period4" header="Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period5" header="Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period6" header="Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period7" header="Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period8" header="Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period9" header="Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period10" header="Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period11" header="Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period12" header="Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period13" header="Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period14" header="Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period15" header="Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period16" header="Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period17" header="Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="period18" header="Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#" select="no" width="150">
    
    <cfgridcolumn name="created_by" header="Created By" select="no" width="100">
    <cfgridcolumn name="created_on" header="Created On" select="no" width="150">
    <cfgridcolumn name="updated_by" header="Updated By" select="no" width="100">
    <cfgridcolumn name="updated_on" header="Updated On" select="no" width="150">
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