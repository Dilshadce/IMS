<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<!--- <cfparam name="Add" default=""> --->
<cfparam name="Save" default="">
<cfparam name="Finish" default="">
<cfparam name="xbom" default=""> 
<cfparam name="xitem" default="">
<cfparam name="xqty" default="1">
<cfparam name="xlocation" default="">
<cfparam name="xgroup" default="">
<!--- <cfparam name="xitemno" default=""> --->
<cfparam name="mode" default="">

		<cfquery name="getbomdata" datasource="#dts#">
			select *,(select ucost from icitem where itemno=a.bmitemno)as ucost from billmat as a where bomno = '#url.bomno#' 
            and itemno = '#sitemno#'
            order by bomno,bmitemno
		</cfquery>
		<cfset xbom = "#url.bomno#">
		<cfset xitem = "">
		<cfset xqty = "1">
		<cfset xlocation = "">
		<cfset xgroup = "">
        
		<cfquery name="getitem" datasource="#dts#">
			select itemno,desp 
            from icitem 
            where itemno <> '#sitemno#' 
            order by itemno
		</cfquery>		
    
		<cfquery name="getbomcost" datasource="#dts#">
			select bom_cost 
            from icitem 
            where itemno = '#url.sitemno#'
		</cfquery>
		
<cfquery name="getlocation" datasource="#dts#">
	select location 
    from iclocation 
    order by location
</cfquery>
<cfoutput>
<h1 align="center">Item No : #url.bomno#</h1>


 	<h2 align="center">#url.sitemno#</h2>
	<p align="center"><font size="2">Miscellaneous Cost :</font> 
    <input type="text" name="mcost" id="mcost" size="10" maxlength="10" value="#getbomcost.bom_cost#" onBlur="updateMiscCost()">&nbsp;
	<input type="hidden" name="sitemno" value="#url.sitemno#">
	<!--- <cflocation url="vbom.cfm"> --->



<table width="80%" border="0" align="center" class="data">

  <tr>
      <th>Bom No</th>
	  <th>Item No</th>
	  <th>Quantity</th>
	  <th>Location</th>
	  <th>Assm Group</th>
      <th>Cost</th>
	  <th>Action</th>
  </tr>
  <cfloop query="getbomdata">
  <tr>
    <td>#getbomdata.bomno#</td>
    <td>#getbomdata.bmitemno#</td>
    <td><input type="text" size="7" id="update_qty_#getbomdata.bomno#_#getbomdata.bmitemno#" name="update_qty_#getbomdata.bmitemno#" value="#getbomdata.bmqty#" onBlur="updateitem('#getbomdata.bomno#','#getbomdata.bmitemno#')"></td>
    <td> 
    <select name="update_location_#getbomdata.bomno#_#getbomdata.bmitemno#" id="update_location_#getbomdata.bomno#_#getbomdata.bmitemno#" onBlur="updateitem('#getbomdata.bomno#','#getbomdata.bmitemno#')">
		<option value="#getbomdata.bmlocation#">Please choose a Location</option>
		<cfloop query="getlocation"><option value="#location#"<cfif #getbomdata.Bmlocation# eq location>selected</cfif>>#location#</option></cfloop>
	</select>
    
    <!--<input type="text" id="update_location_#getbomdata.bomno#_#getbomdata.bmitemno#" name="update_location_#getbomdata.bmitemno#" value="#getbomdata.bmlocation#" onBlur="updateitem('#getbomdata.bomno#','#getbomdata.bmitemno#')"></td>-->
    <td>#getbomdata.assm_group#</td>
    <td align="right">#numberformat(getbomdata.ucost,'.__')#</td>
	<td align="center">
    	<input type="button" name="button" id='delete_item_#getbomdata.bomno#_#getbomdata.bmitemno#' value="DELETE" title='#getbomdata.bmitemno#' onClick='deleteItem("#getbomdata.bomno#",this.title);' />
		
	</td>
  </tr>
  </cfloop>
</table>

<br>

<table width="60%" border="0" align="center" class="data">

  <tr> 
      <th width="37%"> Item No :</th>
    <td width="63%"><select name="sitem" id="sitem">
		<option value="">Choose an Item</option>
        <cfloop query="getitem">
          <option value="#convertquote(itemno)#"<cfif xitem eq itemno>selected</cfif>>#itemno# - #desp#</option>
        </cfloop> </select>
        <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('finditem');" />
      </td>
  </tr>
  <tr> 
      <th>Quantity :</th>
    <td><input type="text" name="qty" id="qty" size="5" value="#xqty#" maxlength="5"></td>
  </tr>
  <tr> 
      <th>Location :</th>
    <td><select name="locat" id="locat">
		<option value="">Please choose a Location</option>
		<cfloop query="getlocation"><option value="#location#"<cfif xlocation eq location>selected</cfif>>#location#</option></cfloop>
	</select></td>
  </tr>
  <tr> 
    <th>Assembly Group :</th>
    <td><input type="text" name="sgroup" id="sgroup" maxlength="40" value="#xgroup#">
        
		<input type="hidden" name="sitemno" value="#convertquote(bomno)#">
		<input type="hidden" name="misc" value="#getbomcost.bom_cost#">
		</td>
  </tr>
  <tr>
  <td></td><td><input type="button" name="addbtn" id="addbtn" value="Add" onClick="additem();"></td>
  </tr>
</table>
<div align="center"><input type="Submit" name="Finish" value="Finish"></div>
</cfoutput>


