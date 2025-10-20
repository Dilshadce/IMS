<cfajaximport tags="cfform">
<html>
<head>
<cfajaxproxy bind="javascript:getrowpromo({usersgrid.promoid})">
<link href="/stylesheet/tabber.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/scripts/tabber.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>

<script type="text/javascript">
function editpromo()
{
ColdFusion.Window.show('createpromotion');
}
function assignitem()
{
ColdFusion.Window.show('assignitem');
}
function assignlocation()
{
ColdFusion.Window.show('assignlocation');
}
function getrowpromo(promoid)
{
document.getElementById('promoidhid').value = promoid;
}
function additem1(type1)
{
var valueget = document.getElementById(type1).value; 
ajaxFunction(document.getElementById('ajaxFieldPro'),'additemprocess.cfm?type='+type1+'&valueget='+escape(valueget)+'&promoid='+document.getElementById('promoidhid').value+'&price='+escape(document.getElementById('newpricing').value));
setTimeout("ColdFusion.Grid.refresh('itemlist',false);",1000);
}

function addmultiitem()
	{
	var itemlisting='';
	<cfoutput>
	for (k=1;k<=50;k=k+1)
	{
		
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
	if (document.getElementById('additem_'+k).checked == true)
	{
	var itemlisting=itemlisting+"&servicecode"+k+"="+document.getElementById('additem_'+k).value;
	}
	}
	}
	
	var promoid = document.getElementById('promoidhid').value;
	
	var ajaxurl2 = '/default/maintenance/promotion/addmultiproductsAjax.cfm?promoid='+escape(promoid)+itemlisting;
	
	<!---
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl2);
setTimeout("ColdFusion.Grid.refresh('itemlist',false);",1000);
	--->
	
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		setTimeout("ColdFusion.Grid.refresh('itemlist',false);",1000);
        }
      })
	</cfoutput>
	}

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
									
			function deletepromotionlocation(promoid,location){
				
				var ajaxurl = 'promotionlocationajax.cfm?proces=Delete&promoid='+escape(promoid)+'&location='+escape(location);
				  ajaxFunction(document.getElementById('promolocajaxFieldPro'),ajaxurl);
			}
			
			
			function addpromotionlocation(promoid){
				var location = document.getElementById('promotionlocation').value;
				
				var ajaxurl = 'promotionlocationajax.cfm?proces=add&promoid='+escape(promoid)+'&location='+escape(location);
				
				ajaxFunction(document.getElementById('promolocajaxFieldPro'),ajaxurl);
				
			}
									
</script>
</head>
<body>
<h1>
PROMOTION
</h1>
<h4>
<a onClick="document.getElementById('promoidhid').value = 0;ColdFusion.Window.show('createpromotion');" onMouseOver="this.style.cursor='hand'">Create Promotion</a>||<a href="p_vehicles.cfm">Promotion Listing</a>||<a href="p_promoitem.cfm">Promotion Item Listing</a></h4>	
<cfform name="promotionform" action="" method="post">
<table width="100%">
<tr>
<td>
<input type="button" name="onbtn" id="onbtn" value="On Going" size="12" onClick="document.getElementById('promolist').value = this.value;ColdFusion.Grid.refresh('usersgrid',false);" />&nbsp;&nbsp;
<input type="button" name="upbtn" id="upbtn" value="Up Coming" size="12" onClick="document.getElementById('promolist').value = this.value;ColdFusion.Grid.refresh('usersgrid',false);"/>&nbsp;&nbsp;
<input type="button" name="upbtn" id="upbtn" value="Ended" size="12" onClick="document.getElementById('promolist').value = this.value;ColdFusion.Grid.refresh('usersgrid',false);" />&nbsp;&nbsp;
</td>
</tr>
<tr>
					<td>
                    Promotion listed: <input type="text" readonly name="promolist" id="promolist" value="On Going" />
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:promotion.getPromoColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter" name="filter">
						<cfinput type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('usersgrid',false)">
                        <cfinput type="hidden" name="promoidhid" id="promoidhid" value="" />
					</td>
					
				</tr>
<tr>
<td>
<div style="min-heigh:200px;">
  <cfgrid name="usersgrid" pagesize="10" format="html" width="1200" height="280"
								bind="cfc:promotion.getPromotion({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#',{promolist})"
                                onchange="cfc:promotion.editPromotion({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete" appendkey="no">
    <cfgridcolumn name="promoid" header="Promotion ID" select="No" width="100" href="javascript:editpromo();">
    <cfgridcolumn name="type" header="Promotion Type" select="no" width="100">
    <cfgridcolumn name="description" header="Promotion Desp" select="no" width="100">
    <cfgridcolumn name="periodfrom" header="Period From" select="no" width="100">
    <cfgridcolumn name="periodto" header="Period To" select="no" width="100">
    <cfgridcolumn name="priceamt" header="Price / Percent" select="no" width="100">
    <cfgridcolumn name="customer" header="Customer" select="no" width="100">
    <cfgridcolumn name="created_by" header="Created By" select="no" width="100">
    <cfgridcolumn name="created_on" header="Created On" select="no" width="150">
    <cfgridcolumn name="assign" header="Assign Item" select="no" width="150" href="javascript:assignitem();">
    <cfgridcolumn name="assign2" header="Assign Location" select="no" width="150" href="javascript:assignlocation();">
  </cfgrid>
</div></td>
</tr>
</table>

</table>
</cfform>
</body>
<cfwindow name="createpromotion" center="true" source="promotion.cfm?promoid={promoidhid}" modal="true" closable="true" width="850" height="500" refreshonshow="true" title="Create New Promotion" />
<cfwindow name="assignitem" center="true" source="additem.cfm?promoid={promoidhid}" modal="true" closable="true" width="1000" height="500" refreshonshow="true" title="Assign Item For Promotion" />
<cfwindow name="assignlocation" center="true" source="promotionlocation.cfm?promoid={promoidhid}" modal="true" closable="true" width="1100" height="500" refreshonshow="true" title="Assign Location For Promotion" />
<cfwindow center="true" width="750" height="550" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/maintenance/promotion/searchitem.cfm?promoid={promoidhid}" />

</html>
</html>