<html>
<head>
	<title>CRM - Customer Relationship Management</title>
	<link rel="stylesheet" href="css.css"/>
	<script language="javascript" type="text/javascript" src="SpryEffects.js"></script>
	<script language="javascript" type="text/javascript" src="ajax.js"></script>
	<script type='text/javascript' src='../../../ajax/core/engine.js'></script>
	<script type='text/javascript' src='../../../ajax/core/util.js'></script>
	<script type='text/javascript' src='../../../ajax/core/settings.js'></script>

<!-- insert css -->
<style type="text/css">
	.demoDiv{			
		overflow: hidden;
	}
		
	.hiddenElement{
		display:none;
	}
		
	.styleAdd{
   		font-size:12px;
   		font-family:Tahoma,sans-serif;
   		font-weight:bold;
   		color:#FFFFFF;
   		background-color:#CCCCCC;
   		border-style:outset;
   		border-color:#FFFFFF;
   		border-width:2px;
	}

	.styleEdit{
    	font-size:12px;
   		font-weight:bold;
   		color:#FFFFFF;
   		background-color:#CCCCCC;
   		border-style:ridge;
   		border-color:#FFFFFF;
   		border-width:1px;
	}

	.styleDelete{
   		font-size:12px;
   		font-weight:bold;
   		font-family:Tahoma,sans-serif;
   		color:#FFFFFF;
   		background-color:#CCCCCC;
   		border-style:ridge;
   		border-color:#FFFFFF;
   		border-width:2px;
	}
	
</style>
	
<!-- insert javaScript -->
<script type="text/javascript">
<!-- search -->	
function search()
	{
	var mylist=document.getElementById("myList");
	document.getElementById("favorite").value=mylist.options[mylist.selectedIndex].text;
	}

var observer = {};

observer.nextEffect = false;
observer.onPostEffect = function(e){
	if (this.nextEffect)
	{
		var eff = this.nextEffect;
		setTimeout(function(){eff.start();}, 10);
	}

	this.nextEffect = false;
}

<!-- show/hide slide -->
function myPanelsSlides(currentPanel)
	{
    // The list of all the panels that need sliding
	var panels = [currentPanel];
	var opened = -1;

	// Let's check if we have an effect for each of these sliding panels
	if (typeof effects == 'undefined')
		effects = {};

	for (var i=0; i < panels.length; i++)
		{
		if (typeof effects[panels[i]] == 'undefined'){
			effects[panels[i]] = new Spry.Effect.Fade(panels[i], {from: '0%', to: '100%', toggle: true});
			effects[panels[i]].addObserver(observer);
		}
		 
		if (effects[panels[i]].direction == Spry.forwards && currentPanel != panels[i])
			opened = i;

		//prevent too fast clicks on the buttons
		if (effects[panels[i]].direction == Spry.backwards && effects[panels[i]].isRunning)
			{
			observer.nextEffect = effects[currentPanel];
			return;
			}
	}

	if (opened != -1)
		{
		observer.nextEffect = effects[currentPanel];
		effects[panels[opened]].start();
		} 
	else if (effects[currentPanel].direction != Spry.forwards)
		{
		effects[currentPanel].start();
		}
	};
	
	function confirmdelete(comid){
		if (confirm("Are you sure you want to delete")) {
 			window.location.href='act_company.cfm?type=delete&comid=' + comid;
 		}
	}
	
	function getcustomer(){
		DWREngine._execute(_crmflocation, null, 'customerlookup', getCustomerResult);
	}
	
	function getCustomerResult(customerArray){
		DWRUtil.removeAllOptions("custid");
		DWRUtil.addOptions("custid", customerArray,"KEY", "VALUE");
	}
	
	function init(){
		getcustomer();
	}
</script>
</head>

<body onload="init();">

<!-- set the layout of page 'records' -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td colspan="2" class="header">
		<cfinclude template="heading.cfm">
	</td>
</tr>
<tr>
	<td width="20%" valign="top" class="menu">
		<cfinclude template="menu.cfm">
	</td>
	<td width="80%">
    <br>
    <h2 align="center">IMS Account</h2>
<!-- searchBy -->
<cfquery name="search" datasource="net_crm">
	SELECT a.*,b.custname FROM company as a
    
    left join
    
    (select * from customer) 
    as b on a.custid = b.custid
	order by a.custid,a.comid
</cfquery>

<!--- <cfquery name="getcust" datasource="net_crm">
	SELECT custid,custno,custname FROM customer 
	where custname != ''
	order by custname
</cfquery> --->

<!-- Add New Record Form -->
<form action="act_company.cfm?type=add" method="post">
<div id="slide1" class="hiddenElement"><div class="demoDiv" id="ajaxtest">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td>
            Customer
		</td>
		<td>
			:
		</td>
		<td>
			<select name="custid">
				<option value="" selected>Select a Customer</option>
				<!--- <cfoutput query="getcust"><option value="#getcust.custid#">#getcust.custno# - #getcust.custname#</option></cfoutput> --->
        	</select>
		</td>
	</tr>
    <tr>
		<td>
            Company ID
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="comid" size="50">
		</td>
	</tr>
	<tr>
		<td>
            Company Name
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="comname" size="50">
		</td>
	</tr>
	<tr>
		<td>
			Attn
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="attn" size="50">
		</td>
	</tr>
	<tr>
		<td>
			Contact No
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="contactNo" size="50">
		</td>
	</tr>
    <tr>
		<td>
			Support Staff
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="supportStaff" size="50">
		</td>
	</tr>
    <tr>
		<td>
			Programmer
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="programmer" size="50">
		</td>
	</tr>
    <tr>
		<td>
			Active Status
		</td>
		<td>
			:
		</td>
		<td>
			<select name="status">
				<option value="Yes" selected>Yes</option>
				<option value="No">No</option>
        	</select>
		</td>
	</tr>
    <tr><td colspan="3" height="5"></td></tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td>
			<input type="submit" value="Submit">
			<input type="button" value="Cancel" onClick="window.location.href='company.cfm';">
		</td>
	</tr>
	</table>
</div></div>

</form>

<form action="act_company.cfm?type=edit" method="post">
<div id="slide2" class="hiddenElement"></div>
</form>

<!-- Add New Record Button -->
<cfoutput>
<form name="">
<table>
<tr>
	<td>
		<input type="button" class="styleAdd" value="Add New Record" style="width:110px" onClick="myPanelsSlides('slide1');"/>
	</td> 
</tr>
</table>
</form>
<!-- search by drop down combo box -->
<form action="" method="post">
<table width="100%">
<tr>
	<td width="30%">Search by :
		<select id="myList" name="myList" 
			onChange="ajaxFunction(document.getElementById('ajaxField'),'com_category.cfm?c='+this.options[this.selectedIndex].value);">
			<option value="default">Search By</option>
			<option value="custname">Customer Name</option>
            <option value="comid">Company ID</option>
            <option value="comname">Company Name</option>
            <option value="status">Active Status</option>
		</select>
	</td>
	<td width="70%">
		<div id="ajaxField" name="ajaxField">
			<input type="text" value="" name="searchtext" id="searchtext" readonly="">
		</div>
	</td>
<tr>
<!-- display the table of search result -->
	<td colspan="2">
		<div  id="ajaxFAField" name="ajaxFAField" style="width:800px;height:200px;overflow:auto;">
			<table border="0" width="100%">
			<tr class="style4">
            	<th width="15%" align="center">
					Customer Name
                </th>
            	<th width="10%" align="center">
					Company ID
                </th>
				<th width="30%" align="center">
					Company Name
				</th>
				<th width="10%" align="center">
					Attn
				</th>
				<th width="10%" align="center">
					Contact No
				</th>
                <th width="10%" align="center">
					Active Status
				</th>
                <th width="15%" align="center">
					Action
				</th>
			</tr>
		<cfloop query="search">	
			<tr class="style3">
            	<td>
					<cfoutput>#search.custname#</cfoutput>
				</td>
				<td align="center">
					<cfoutput>#search.comid#</cfoutput>
				</td>
				<td>
					<cfoutput>#search.comname#</cfoutput>
				</td>
				<td>
					<cfoutput>#search.attn#</cfoutput>
				</td>
                <td>
					<cfoutput>#search.contactNo#</cfoutput>
				</td>
                <td align="center">
					<cfoutput>#search.status#</cfoutput>
				</td>
				<td align="center">
                    <!--- <input type="button" class="styleEdit" value="Edit" onClick="myPanelsSlides('slide2');ajaxFunction(window.document.getElementById('slide2'),'dsp_company.cfm?comid=#search.comid#');">
					<input type="button" class="styleDelete" value="Delete" Onclick="window.location.href='act_company.cfm?type=delete&comid=<cfoutput>#search.comid#</cfoutput>';"> --->
					<img src="images/iedit.gif" alt="Edit" style="cursor: hand;" onclick="myPanelsSlides('slide2');ajaxFunction(window.document.getElementById('slide2'),'dsp_company.cfm?comid=#search.comid#');">
					<img src="images/idelete.gif" alt="Delete" style="cursor: hand;" onclick="confirmdelete('#search.comid#');">
					<img src="images/archive.gif" alt="Customized Function" style="cursor: hand;" onclick="window.location.href='customized_function.cfm?comid=#search.comid#';">
					<img src="images/view.gif" alt="View Details" style="cursor: hand;" onclick="window.open('companyinfo.cfm?comid=#search.comid#', 'windowname1', 'width=1200, height=600, left=20,top=100' );">
				</td>
			</tr>
		</cfloop>
			</table>
		</div>
	</td>
		<!-- search result table end -->
</tr>
</table>
</form>
</cfoutput>
</td>
</tr>
<tr>
	<td colspan="2">
		<hr>
	</td>
</tr>
<tr>
	<td colspan="2" class="footer">
		<cfinclude template="footer.cfm">
	</td>
</tr>
</table>

</body>

</html>