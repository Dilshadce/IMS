<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfquery name="getitem" datasource="#dts#">
	select itemno,desp 
	from icitem 
	order by itemno
</cfquery>
	
<cfquery name="getlocation" datasource="#dts#">
	select location,desp 
	from iclocation 
	order by location
</cfquery>

<html>
<head>
	<title>LOCATION OPENING QTY - ADD NEW</title>
	<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript">
	
	function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
		function validation(){
			if(document.form.location.value == ""){
				alert("Please Select A Location !");
				return false;
			}
			else if(document.form.items.value == ""){
				alert("Please Select An Item !");
				return false;
			}
			else if(document.form.qtybf.value == ""){
				alert("Please Enter Correct Qty B/F !");
				return false;
			}
			<!---else if(document.form.qtybf.value == "0"){
				alert("Qty B/F: Not Allowed Zero !");
				return false;
			}--->
			else{
				if(document.form.minimum.value == ""){
					document.form.minimum.value = '0';
				}
				if(document.form.reorder.value == ""){
					document.form.reorder.value = '0';
				}
				return true;
			}
		}

		function checkqtybf(evt)
		{
			var e = event || evt; // for trans-browser compatibility
			var charCode = e.which || e.keyCode;
		
			if (charCode > 31 && (charCode < 48 || charCode > 57) && (event.keyCode != 46)){
				alert("Please Enter Correct Qty B/F!");
				return false;
			}
					
			return true;	
		}
		
		function checkmin(evt)
		{
			var e = event || evt; // for trans-browser compatibility
			var charCode = e.which || e.keyCode;
		
			if (charCode > 31 && (charCode < 48 || charCode > 57) && (event.keyCode != 46)){
				alert("Please Enter Correct Minimum Value !");
				return false;
			}
					
			return true;	
		}
		
		function checkreorder(evt)
		{
			var e = event || evt; // for trans-browser compatibility
			var charCode = e.which || e.keyCode;
		
			if (charCode > 31 && (charCode < 48 || charCode > 57) && (event.keyCode != 46)){
				alert("Please Enter Correct Reorder Value !");
				return false;
			}
					
			return true;	
		}
	</script>
</head>

<body> 
<h1 align="center">Location Opening Qty - Add New Record</h1>
<table align="center">
	<form name="form" action="act_location_opening_qty_addnew.cfm" method="post">
	<tr align="left">
		<th>Location</th>
		<td nowrap>
			<select name="location">
				<option value="">Please Select a Location</option>
				<cfoutput query="getlocation">
					<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr align="left">
	<th>Item No</th>
		<td nowrap>
			<select name="items">
				<option value="">Please Select a Item</option>
				<cfoutput query="getitem">
						<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
				</cfoutput>
			</select>
            <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('finditem');" />
		</td>
	</tr>
	<tr align="left">
		<th>QTY B/F</th>
		<td nowrap>
			<input name="qtybf" type="text" size="5" maxlength="10" onKeyPress="return checkqtybf();">
		</td>
	</tr>
	<tr align="left">
		<th>Minimum</th>
		<td nowrap>
			<input name="minimum" type="text" size="8" maxlength="17" onKeyPress="return checkmin();">
		</td>
	</tr>
	<tr>
		<th>Reorder</th>
		<td nowrap>
			<input name="reorder" type="text" size="10" maxlength="10" onKeyPress="return checkreorder();">
		</td>
	</tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" value="Save" onClick="return validation();">
			<input type="button" value="Cancel" onClick="javascript:window.close();">
		</td>
	</tr>
	</form>
</table>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Item" />
</body>
</html>