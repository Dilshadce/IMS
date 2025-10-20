<cfajaximport tags="cfform">
<html>
<head>
<title>Service Agreement</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script type="text/javascript">
function closenref()
	{
	ColdFusion.Window.hide('createservice');
	ColdFusion.Grid.refresh('Contract',false);
	}
	
	function closeexp()
	{
	ColdFusion.Window.hide('showexp');
	}
	
</script>
</head>
<body>




<h1>Service Agreement Maintenance</h1>
<h4>
<a onClick="ColdFusion.Window.show('createservice');" onMouseOver="this.style.cursor='hand'">Create Service Agreement</a>||<a href="servicelisting.cfm">Service Agreement Listing</a>||<a href="p_contract.cfm">Pro Server Agreement Record</a>||<a href="p_contract2.cfm">Collection Schedule Report</a></h4>
<cfwindow name="createservice" center="true" source="createser.cfm" modal="true" closable="true" width="500" height="250" refreshonshow="true" title="Create New Service Agreement" />
<cfoutput>
<cfform name="listser" action="" method="post">
<table border="1" width="90%" align="center">
				<tr>
					<td>
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:contract.getContractColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter" name="filter">
						<cfinput type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('Contract',false)">
					</td>
					
				</tr>
				<tr>
					<td id="gridtd" style="padding-top:10px;">
						<div style="min-heigh:200px;">
							<cfgrid name="Contract" pagesize="10" format="html" width="100%" height="280"
								bind="cfc:Contract.getContract({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
                                onchange="cfc:Contract.editContract({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete">
                               <cfgridcolumn name="id" header="ID" display="no">
                               <cfgridcolumn name="servicecode" header="Service Code" select="no" width="200">
                               <cfgridcolumn name="desp" header="Description" width="250">
                               <cfgridcolumn name="validstart" header="Validity Start" type="string_nocase" width="100" >
                               <cfgridcolumn name="validend" header="Validity End" type="string_nocase" width="100">
                               <cfgridcolumn name="modebill" header="Group" width="250">
                               <cfgridcolumn name="created_By" header="Created By" select="no" width="100">
							</cfgrid>
						</div>			
					</td>
				</tr>
			</table>
</cfform>

<cfset edate=dateformat(dateadd('yyyy',1,now()),'YYYY/MM/DD')>

<cfquery name="getexpire" datasource="#dts#">
select * from serviceagree where validend < '#edate#'
</cfquery>
<cfif getexpire.recordcount neq 0>

<cfajaximport tags="cfform">
<cfwindow center="true" width="700" height="500" name="showexp" refreshOnShow="true" closable="true" modal="true" title="Service Agreement that are going to expire" initshow="true"
        source="showexpire.cfm" />
</cfif>
</cfoutput>
</body>
</html>