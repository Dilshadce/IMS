<cfajaximport tags="cfform">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.6.0/build/button/assets/skins/sam/button.css">
	<!-- Individual YUI CSS files -->  
	<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.6.0/build/datatable/assets/skins/sam/datatable.css"> 
   
	<!-- Individual YUI JS files -->  
	<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/yahoo-dom-event/yahoo-dom-event.js"></script>  
	<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/element/element-beta-min.js"></script>  
	<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/button/button-min.js"></script>
	<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
	<script type="text/javascript">
	function selectlist(custno){		
	for (var idx=0;idx<document.getElementById('custcode').options.length;idx++) 
	{
        if (custno==document.getElementById('custcode').options[idx].value) 
		{
            document.getElementById('custcode').options[idx].selected=true;
			
        }
    }
	ajaxFunction(document.getElementById('ajaxField1'),'addvehicleAjax.cfm?custno='+document.getElementById('custcode').value); 
	}
	function closenref()
	{
	ColdFusion.Window.hide('createveh');
	ColdFusion.Grid.refresh('usersgrid',false);
	}
	
	function setadd(name,add)
	{
	document.getElementById('custname').value = name;
	document.getElementById('custadd').value = add;
	}
    </script>
	<style>
		
		.yui-skin-sam .yui-button  {
			background:#ffffff;
		    color: #071b45;
		    border-color:#a3a3a3;    
		}
		
		.yui-skin-sam .yui-button button,
		.yui-skin-sam .yui-button a {
		   font-size: 75%;
		   color:#071b45;
		   		   
		}
		
		.yui-skin-sam .yui-button-hover {
    		background: #DDDDDD;  
			color:#071b45;  		
		}
		
		.yui-skin-sam .yui-radio-button-checked .first-child,
		.yui-skin-sam .yui-checkbox-button-checked .first-child {
		    border-color:#a3a3a3;	
		}
		
		.yui-skin-sam .yui-radio-button-checked,
		.yui-skin-sam .yui-checkbox-button-checked {
			border-color:#a3a3a3;		    
		    background:#DDDDDD;
		    color:#071b45;	    		    
		}
		
	</style>  

	<script>
		function showColumn(e)
		{	
			//alert(this.get("value"));			
			var showColId = this.get("value");		
			showCol = cols.getColumnById(showColId);
			if(showCol.hidden == false)
			{
				showCol.hidden = true;
			}else
			{
				showCol.hidden = false;
			}
			grid.reconfigure(grid.getDataSource(),cols);
		}
		
		function getGrid()
		{
			grid = ColdFusion.Grid.getGridObject('usersgrid');
			cols = grid.getColumnModel();
			for(var i=0; i<cols.getColumnCount();i++)
			{
				colid = cols.getColumnId(i);
				column = cols.getColumnById(colid);
				if(column.hidden == true && column.header != 'CFGRIDROWINDEX')
				{
					var showButton = new YAHOO.widget.Button({ 
                            type: "checkbox", 
                            label: column.header, 
                            id: column.header, 
                            name: column.header, 
                            value: colid, 
                            container: "buttons",
                            title: "Show Column",                            
                            checked: false });
                            
                    showButton.addListener("click",showColumn)
				}
			}
		}
		
		
	</script>
	<title>Customer Page</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/stylesheet/style.css"/>
	<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<title>Vehicles Maintenance</title>
</head>

<body>
<cfquery name="getvehicle" datasource="#dts#">
	select *
	from vehicles 
	order by carno;
</cfquery>

<h1>Vehicles Profile Maintenance</h1>
<h4>
<a onClick="ColdFusion.Window.show('createveh');" onMouseOver="this.style.cursor='hand'">Create Vehicles Profile</a>||<a href="p_vehicles.cfm">Vehicles Listing</a>||<a href="vehiclereport.cfm">Vehicles History Report</a>||<a href="vehiclerenew.cfm">Vehicles Renew Report</a></h4>	
<cfset gender = "male,female,others">
<cfoutput>
		<cfform>
			<table border="1" width="90%" align="center">
				<tr>
					<td>
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:vehicles.getBatchColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter" name="filter">
						<cfinput type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('usersgrid',false)">
					</td>
					
				</tr>
				<tr>
					<td id="gridtd" style="padding-top:10px;">
						<div style="min-heigh:200px;">
							<cfgrid name="usersgrid" pagesize="10" format="html" width="1000" height="280"
								bind="cfc:vehicles.getBatchs({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
                                onchange="cfc:vehicles.editBatch({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete">
                                <cfgridcolumn name="carno" header="Vehicles No" select="No" href="editveh.cfm?carno=#getvehicle.carno#" hrefkey="carno">
                                <cfgridcolumn name="scheme" header="Scheme" values="OPC,NORMAL">
                                <cfgridcolumn name="make" header="Make">
                                <cfgridcolumn name="model" header="Model">
                                <cfgridcolumn name="chasisno" header="Chasis No">
                                <cfgridcolumn name="yearmade" header="Year of Manufacture">
                                <cfgridcolumn name="oriregdate" header="Original Registration Date">
                                <cfgridcolumn name="capacity" header="Capacity">
                                <cfgridcolumn name="coveragetype" header="Type of Coverage">
                                <cfgridcolumn name="excess" header="Excess">
                                <cfgridcolumn name="suminsured" header="Sum Insured">
                                <cfgridcolumn name="insurance" header="Insurance">
                                <cfgridcolumn name="premium" header="Premium">
                                <cfgridcolumn name="financecom" header="Finance Company">
                                <cfgridcolumn name="commission" header="Commission">
                                <cfgridcolumn name="contract" header="Contract">
                                <cfgridcolumn name="payment" header="Payment">
                                <cfgridcolumn name="custrefer" header="Referred By">
								<cfgridcolumn name="entryno" header="ENTRY" select="no" width="50" display="no">
                                <cfgridcolumn name="custcode" header="Customer Code" select="no" >
								<cfgridcolumn name="custname" header="Customer Name">
								<cfgridcolumn name="custadd" header="Customer Address">
								<cfgridcolumn name="gender" header="Gender" width="50" values="#gender#">
								<cfgridcolumn name="marstatus" header="Marital Status" values="single,married,others" > 
								<cfgridcolumn name="dob"  header="DOB">
								<cfgridcolumn name="licdate" header="License Date" >
								<cfgridcolumn name="ncd" header="NCD" values="0%,10%,15%,20%,30%,50%">	
                                <cfgridcolumn name="com" header="COM" values="yes,no">
                                <cfgridcolumn name="inexpdate" header="Insurance Expire Date">
                                
							</cfgrid>
						</div>			
					</td>
				</tr>
			</table>
		</cfform>
	
</cfoutput>

<cfset AjaxOnLoad("getGrid")>
</body>
<cfwindow name="createveh" center="true" source="createveh.cfm" modal="true" closable="true" width="800" height="500" refreshonshow="true" title="Create New Vehicles" />
<cfwindow center="true" width="520" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer" initshow="false"
        source="/default/maintenance/vehicles/findCustomer.cfm?type=Customer&dbtype=#target_arcust#" />
</html>