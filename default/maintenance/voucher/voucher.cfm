<cfajaximport tags="cfform">
<html>
<head>
	<!--- <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.6.0/build/button/assets/skins/sam/button.css">
	<!-- Individual YUI CSS files -->  
	<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.6.0/build/datatable/assets/skins/sam/datatable.css"> 
   
	<!-- Individual YUI JS files -->  
	<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/yahoo-dom-event/yahoo-dom-event.js"></script>  
	<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/element/element-beta-min.js"></script>  
	<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/button/button-min.js"></script> --->
	<cfajaxproxy bind="javascript:getrowbatch({usersgrid.batch})">

	<script type="text/javascript">
	function getrowbatch(batch)
	{
	document.getElementById('rowbatch').value = batch;
	ColdFusion.Grid.refresh('detailgrid',false);
	}
	function closenref()
	{
	ColdFusion.Window.hide('createvoucher');
	ColdFusion.Grid.refresh('usersgrid',false);
	}
	
	function setadd(name,add)
	{
	document.getElementById('custname').value = name;
	document.getElementById('custadd').value = add;
	}
    </script>
	<!--- <style>
		
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
		
	</style>   --->

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
		
		function IsNumeric(sText)
		{
		   var ValidChars = "0123456789.";
		   var IsNumber=true;
		   var Char;
		
		 
		   for (i = 0; i < sText.length && IsNumber == true; i++) 
			  { 
			  Char = sText.charAt(i); 
			  if (ValidChars.indexOf(Char) == -1) 
				 {
				 IsNumber = false;
				 }
			  }
		   return IsNumber;
		   
		   }

		
		function validateform()
		{
		var numfr = document.getElementById('runningnumfr').value;
		var numto = document.getElementById('runningnumto').value;
		var value = document.getElementById('value').value;
		var msg = "";
		if (numfr == "")
		{
		msg = msg + "\nRunning Number From is Required";
		}
		if (numto == "")
		{
		msg = msg + "\nRunning Number To is Required";
		}
		if (value == "")
		{
		msg = msg + "\nAmount is Required";
		}
		if (IsNumeric(numfr) == false)
		{
		msg = msg + "\nNumber From is Not Valid";
		}
		if (IsNumeric(numto) == false)
		{
		msg = msg + "\nNumber To is Not Valid";
		}
		if (IsNumeric(value) == false)
		{
		msg = msg + "\nAmount is Not Valid";
		}
		
		if (IsNumeric(numfr) == true && IsNumeric(numto) == true)
		{
		if(Math.abs(numfr - numto) > 10000)
		{
		msg = msg + "\nThe maximum limit of generate voucher is 10000 piece each time, limit exceed.";
		}
		}
		
		if(msg != "")
		{
		alert(msg);
		return false;
		}
		else
		{
		return true;
		}
		
		}
		
		
	</script>
	<title>voucher Page</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/stylesheet/style.css"/>
	<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<title>Voucher Maintenance</title>
</head>

<body>
<h1>Voucher Maintenance</h1>
<h4>
<a onClick="ColdFusion.Window.show('createvoucher');" onMouseOver="this.style.cursor='hand'">Create Voucher</a>|<a href="p_voucher.cfm">Voucher Listing</a>|<a href="vouchermaintenance.cfm">Voucher Maintenance</a><cfif getpin2.h1R10 eq "T">|<a href="voucherapprove.cfm">Voucher Approval</a></cfif>|<a href="voucherusage.cfm">Voucher Usage Report</a>|<a href="voucherprefix.cfm">Voucher Prefix</a></h4>	
 <cfoutput>
		<cfform>
			<table border="1" width="90%" align="center">
				<tr>
					<td>
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:voucher.getBatchColumns('#dts#')"
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
								bind="cfc:voucher.getBatchs({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
                                onchange="cfc:voucher.editBatch({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete">
								<cfgridcolumn name="voucherid" header="Voucher ID" select="no" width="50" display="no">
                                <cfgridcolumn name="batch" header="Batch" width="150" select="no" >
								<cfgridcolumn name="desp" header="Description" width="300">
								<cfgridcolumn name="type" header="Type" values="Value,Percent" width="70">
                                <cfgridcolumn name="value" header="Amount" width="100">
                                <cfgridcolumn name="custno" header="Customer" width="100" select="no">
							</cfgrid>
						</div>			
					</td>
				</tr>
			</table>
		</cfform>
        
        <cfform name="voucherdetail" action="" method="post">
        
        <table border="1" width="90%" align="center">
        <tr><td><input type="text" name="rowbatch" id="rowbatch" readonly /></td></tr>
        <tr>
					<td id="gridtd" style="padding-top:10px;">
						<div style="min-heigh:200px;">
							<cfgrid name="detailgrid" pagesize="15" format="html" width="1000" height="360"
								bind="cfc:voucherdetail.getBatchs({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{rowbatch},'#dts#')"
                                onchange="cfc:voucherdetail.editBatch({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete">
								<cfgridcolumn name="voucherid" header="Voucher ID" select="no" width="50" display="no">
                                <cfgridcolumn name="voucherno" header="Voucher No" width="150" >
								<cfgridcolumn name="desp" header="Description" width="300">
								<cfgridcolumn name="type" header="Type" values="Value,Percent" width="70">
                                <cfgridcolumn name="value" header="Amount" width="100">
                                <cfgridcolumn name="used" header="Used" values="Y,N" width="70">
                                <cfgridcolumn name="invoiceno" header="Invoice Number" width="100" select="no">
							</cfgrid>
						</div>			
					</td>
				</tr>
			</table>
        </cfform>
	
</cfoutput>


<cfset AjaxOnLoad("getGrid")>
</body>
<cfwindow name="createvoucher" center="true" source="createvoucher.cfm" modal="true" closable="true" width="630" height="500" refreshonshow="true" title="Create New Voucher" />
</html>