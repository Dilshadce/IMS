<cfajaximport tags="cfform">
<cfajaxproxy bind="javascript:getrowcomm({comm.commname})">
<html>
<head>
<title>Commission Maintenance</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
function closenref()
	{
	ColdFusion.Window.hide('createcomm');
	ColdFusion.Grid.refresh('comm',false);
	}
function getrowcomm(commid)
	{
	document.getElementById('commidfilter').value = commid;
	ColdFusion.Grid.refresh('commRangefile',false);
	}
function AddRate()
	{
	var rangeFrom = document.getElementById('rFrom').value;
	var rangeTo = document.getElementById('rTo').value;
	var commRate = document.getElementById('cRate').value;
	
	if (commRate == "" || rangeFrom == "" || rangeTo == "")
	{
	alert("All Field is Required");
	}
	else
	{
	ajaxFunction(document.getElementById('AjaxAdd'),"addRange.cfm?commname="+document.getElementById('commidfilter').value+"&rFrom="+rangeFrom+"&rTo="+rangeTo+"&cRate="+commRate);
	setTimeout("ColdFusion.Grid.refresh('commRangefile',false);",1000);
	}
	}
</script>
</head>
<body>
<h1>Commission Maintenance</h1>
<h4>
<a onClick="ColdFusion.Window.show('createcomm');" onMouseOver="this.style.cursor='hand'">Create Commission</a>||<a href="commissionpenalty.cfm">Set Commission Penalty</a>||<a href="p_commission.cfm">Commission Listing</a>||<a href="commReport.cfm">Commission Report</a>||<a href="commReport2.cfm">Commission Report 2</a></h4>
<cfform>
			<table border="1" width="90%" align="center">
				<tr>
					<td>
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:comm.getCommColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter" name="filter">
						<cfinput type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.comm.refresh('usersgrid',false)">
					</td>
					
				</tr>
				<tr>
					<td id="gridtd" style="padding-top:10px;">
						<div style="min-heigh:200px;">
							<cfgrid name="comm" pagesize="10" format="html" width="1000" height="280"
								bind="cfc:comm.getComm({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')" onchange="cfc:comm.editComm({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" 
                                textcolor="##000000"  delete="yes" deletebutton="Delete">
                                <cfgridcolumn name="commname" header="Commision Name" select="no" width="200" >
                                <cfgridcolumn name="commdesp" header="Description" select="no" width="300">
                                <cfgridcolumn name="wos_group" header="Group" select="no" width="150">
                                <cfgridcolumn name="cate" header="Category" select="no" width="150">
                                <cfgridcolumn name="brand" header="Brand" select="no" width="150">
                                <cfgridcolumn name="created_by" header="Created By" select="no" width="150">
							</cfgrid>
						</div>			
					</td>
				</tr>
			</table>
		</cfform>
        <br/>
        <br/>
        <cfform name="commRangelist" method="post" action="">
        	<table border="1" width="90%" align="center">
				<tr>
					<th colspan="10" align="center">
						Commision <cfinput type="text" id="commidfilter" name="commidfilter" readonly="yes">
					</th>
					
				</tr>
                <tr>
                <th>
                Range From
                </th>
                <td>
                <input type="text" name="rFrom" id="rFrom" value="" />
                </td>
                <th>
                Range To
                </th>
                <td>
                <input type="text" name="rTo" id="rTo" value="" />
                </td>
                <th>
                Rate
                </th>
                <td>
                <input type="text" name="cRate" id="cRate" value=""/>
                </td>
                <td>
                <input type="button" name="add_btn" id="add_btn" value="Add" onClick="AddRate();" />
                </td>
                <td colspan="2" width="300px">&nbsp;</td>
          
                </tr>
				<tr>
					<td id="gridtd" style="padding-top:10px;" colspan="10">
						<div style="min-heigh:150px;">
							<cfgrid name="commRangefile" pagesize="6" format="html" width="1000" height="180"
								bind="cfc:commrange.getCommRange({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{commidfilter},'#dts#')" onchange="cfc:commrange.editCommRange({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" 
                                textcolor="##000000"  delete="yes" deletebutton="Delete">
                                <cfgridcolumn name="rangefrom" header="Range From" width="150" >
                                <cfgridcolumn name="rangeto" header="Range To" width="150">
                                <cfgridcolumn name="rate" header="Rate (%)"  width="150">
                                <cfgridcolumn name="type" header="Type" select="no" width="150">
                                <cfgridcolumn name="typeid" header="Type ID" select="no" width="150">
                                <cfgridcolumn name="commrateid" header="Commision Id" select="no" display="no" width="150">
                               
							</cfgrid>
						</div>			
					</td>
				</tr>
			</table>
        </cfform>
<div id="AjaxAdd">

</div>
        
<cfwindow name="createcomm" center="true" source="createcomm.cfm" modal="true" closable="true" width="800" height="500" refreshonshow="true" title="Create Commission" />
</body>
</html>
