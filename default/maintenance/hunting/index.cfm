
<html>
<head>
<link href="/stylesheet/tabber.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/scripts/tabber.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
</head>
<body>
<h1>
hunting
</h1>


<cfoutput>
<cfquery name = "GetCourses" dataSource = "#dts#">
    SELECT *
    FROM hunting  where 0=0
    <cfif isdefined('url.column') and isdefined('url.text')>
    AND #url.column# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.text#%">
    </cfif>
    ORDER by mill_cert,itemno
</cfquery>
	
<h3></h3>
<i></i>


<!--- cfgrid must be inside a cfform tag. --->
<cfform name="ViewJobForm" format="flash" width="100%" height="500" style="themeColor:##56A1E1; marginRight:-12;">
	<cfformitem type="script">
		

</cfformitem>
	<cfformgroup type="tabNavigator" id="jTabNavigator" >
	<cfformgroup type="page" label="Hunting">
    
   
    
	<cfformgroup type="horizontal" style="horizontalGap:-1;">
    <cfgrid name = "listingGrid" format="Flash"
        height="500" width="450"
        font="Tahoma" fontsize="12"
        query = "GetCourses"  rowheaders="no" onChange="_level0.listingGrid2.selectedIndex = _level0.listingGrid.selectedIndex;">
			<cfgridcolumn name="itemno" 		header="Item No" 			width="150">
            <cfgridcolumn name="desp" 		header="Description" 			width="300">
    </cfgrid>
	<cfgrid name = "listingGrid2" format="Flash" rowheaders="no"
        height="500" width="600"
        font="Tahoma" fontsize="12" selectmode="edit"
        query = "GetCourses" onChange="_level0.listingGrid.selectedIndex = _level0.listingGrid2.selectedIndex;">
		<cfgridcolumn name="itemno" 		header="Item No" 			width="100" display="no">
            <cfgridcolumn name="desp" 		header="Description" 			width="200" display="no">
		<cfgridcolumn name="mill_cert" 		header="Mill Certificate" 			width="150">
        <cfgridcolumn name="owner" 		header="Owner" 			width="150">
        <cfgridcolumn name="summary_cate" 		header="Summary Catergory" 			width="150">
        <cfgridcolumn name="cate" 		header="Category" 			width="150">
        <cfgridcolumn name="OD" 		header="OD (for PIPE)" 			width="150">
		<cfgridcolumn name="OD2" 		header="OD (for Coupling)" 			width="150">
        <cfgridcolumn name="PPF" 		header="PPF" 			width="150">
        <cfgridcolumn name="material_grade" 		header="Material Grade" 			width="150">
        <cfgridcolumn name="range" 		header="Range" 			width="150">
        <cfgridcolumn name="location" 		header="Location" 			width="150">
        <cfgridcolumn name="onhandqty" 		header="Total on Hand Qty" 			width="150">
        <cfgridcolumn name="unit" 		header="UOM" 			width="150">
        <cfgridcolumn name="price" 		header="Avg Unit value: US$" 			width="150">
        <cfgridcolumn name="amt" 		header="Total on Hand Cost US$" 			width="150">
        <cfgridcolumn name="cust_allocation" 		header="Allocation for Customer" 			width="150">
        <cfgridcolumn name="job_allocation" 		header="Allocation for Job No" 			width="150">
        <cfgridcolumn name="qty_allocation" 		header="Allocation QTY" 			width="150">
        <cfgridcolumn name="amt_allocation" 		header="Total Allocation Cost US$" 			width="150">
        <cfgridcolumn name="reject_qty" 		header="Rejected Qty" 			width="150">
        <cfgridcolumn name="reject_amt" 		header="Total Rejected Cost US$" 			width="150">
        <cfgridcolumn name="reject_reason" 		header="Reason of Reject" 			width="150">
        <cfgridcolumn name="avali_qty" 		header="Availablity Stock QTY" 			width="150">
        <cfgridcolumn name="avali_amt" 		header="Total stock Available Cost US$" 			width="150">
        <cfgridcolumn name="slow_common" 		header="Slow Moving / Common Use" 			width="150">
        <cfgridcolumn name="remarks" 		header="Remarks" 			width="150">
    </cfgrid>
	<!--- _root.listingGrid.sortableColumns = false;
				_root.listingGrid2.sortableColumns = false; --->
				 <cfinput type="text" name="trigger" height="0" width="0" visible="No" bind="{(1 != 2) ? function(){
					_root.listingGrid.vScrollPolicy = 'off'; 
					_root.listingGrid.hScrollPolicy = 'off';
					_root.listingGrid2.hScrollPolicy = 'on';
					_root.listingGrid.selectedIndex = _root.listingGrid2.selectedIndex;
                    _root.listingGrid.sortableColumns = false;
					_root.listingGrid2.sortableColumns = false;
					}.call() : null}"> 
					
					<<cfinput type="hidden" name="trigger2" bind="{listingGrid.vPosition = listingGrid2.vPosition}">
	</cfformgroup>
	</cfformgroup>
	</cfformgroup>
</cfform>
</cfoutput>
</body>
</html>