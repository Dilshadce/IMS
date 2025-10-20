<html>
<head>
	<title>CRM - Customer Relationship Management</title>
	<link rel="stylesheet" href="css.css"/>
	<script language="javascript" type="text/javascript" src="SpryEffects.js"></script>
	<script language="javascript" type="text/javascript" src="ajax.js"></script>

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
	
	function confirmdelete(cfid){
		var comid = document.form1.comid.value; 
		if (confirm("Are you sure you want to delete")) {
 			window.location.href='act_customized.cfm?type=delete&cfid=' + cfid + '&comid=' + comid;
 		}
	}
</script>
</head>

<body>

<!-- set the layout of page 'records' -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td colspan="2" class="header">
		<cfinclude template="heading.cfm">
	</td>
</tr>
<tr>
	<td width="12%" valign="top" class="menu">
		<cfinclude template="menu.cfm">
	</td>
	<td>
    <br>
    <h2 align="center">Customized Function</h2>
<!-- searchBy -->
<cfquery name="search" datasource="net_crm">
	SELECT * FROM customized_function
	where comid = '#comid#'
</cfquery>

<!-- Add New Record Form -->
<form action="act_customized.cfm?type=add" method="post">
<div id="slide1" class="hiddenElement"><div class="demoDiv" id="ajaxtest">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			Company ID
		</td>
		<td>
			:
		</td>
		<td>
			<cfoutput><input type="text" name="comid" size="50" value="#comid#" readonly></cfoutput>
		</td>
	</tr>
	<tr>
		<td>
			Customized Function
		</td>
		<td>
			:
		</td>
		<td>
			<input type="text" name="function" size="50">
		</td>
	</tr>
	<tr>
		<td>
			Description
		</td>
		<td>
			:
		</td>
		<td>
			<textarea cols="50" rows="5" wrap="hard" name="desp"></textarea>
		</td>
	</tr>
	<tr>
		<td>&nbsp;
			
		</td>
		<td>&nbsp;
			
		</td>
		<td>
			<input type="submit" value="Submit">
			<cfoutput><input type="button" value="Cancel" onClick="window.location.href='customized_function.cfm?comid=#comid#';"></cfoutput>
		</td>
	</tr>
	</table>
</div></div>

</form>

<form action="act_customized.cfm?type=edit" method="post">
<div id="slide2" class="hiddenElement"></div>
</form>

<!-- Add New Record Button -->
<cfoutput>
<form name="">
<table>
<tr>
	<td>
		<input type="button" class="styleAdd" value="Add New Record" style="width:110px" onClick="myPanelsSlides('slide1');"/>
		<input type="button" class="styleAdd" value="Back" onclick="window.location.href='company.cfm';">
	</td> 
</tr>
</table>
</form>
<!-- search by drop down combo box -->
<form name="form1" method="post">
<cfoutput><input type="hidden" name="comid" value="#comid#"></cfoutput>
<table width="100%">
<tr>
<!-- display the table of search result -->
	<td colspan="2">
		<div  id="ajaxFAField" name="ajaxFAField" style="width:800px;height:200px;overflow:auto;">
			<table border="0" width="100%">
			<tr class="style4">
            	<th width="5%" align="center">
					No
                </th>
				<th width="25%" align="center">
					Customized Function
				</th>
				<th width="55%" align="center">
					Description
				</th>
                <th width="15%" align="center">
					Action
				</th>
			</tr>
		<cfloop query="search">	
			<tr class="style3">
            	<td align="center">
					<cfoutput>#search.currentrow#.</cfoutput>
				</td>
				<td>
					<cfoutput>#search.function#</cfoutput>
				</td>
				<td>
					<cfoutput><pre class="style3">#search.desp#</pre></cfoutput>
				</td>
				<td align="center">
					<!---input type="button" class="styleEdit" value="Edit" Onclick="window.open('editRecord.cfm?type=edit&custid=<cfoutput>#search.custid#</cfoutput>', 'windowname1', 'width=500, height=280, left=200,top=100' );"--->
                    <input type="button" class="styleEdit" value="Edit" onClick="myPanelsSlides('slide2');ajaxFunction(window.document.getElementById('slide2'),'dsp_customized.cfm?cfid=#search.cfid#');">
					<input type="button" class="styleDelete" value="Delete" Onclick="confirmdelete('#search.cfid#');">
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