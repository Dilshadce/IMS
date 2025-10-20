<html>
<head>
<title>Edit Location Opening Quantity</title>
<link rel="stylesheet" type="text/css" href="/stylesheet/table.css" media="all">
<script language="javascript" type="text/javascript" src="/scripts/table.js"></script>

<script type="text/javascript">
	function AddNew(){
		var opt = 'Width=500px, Height=250px, Top=300px, left=400px, scrollbars=yes, status=no, resizable=1';
		window.open('dsp_location_opening_qty_addnew.cfm', '',opt);
	}
</script>
<cfinclude template="../../../CFC/convert_single_double_quote_script.cfm">
</head>

<cfoutput>
	<cfif isdefined("form.selectlocation") and form.selectlocation eq "Search">
		<form action="location_opening_qty_maintenance_search_location.cfm" name="done" method="post">
			<input type="hidden" name="items" value="#items#">
			<input type="hidden" name="qtybf" value="#qtybf#">
			<input type="hidden" name="minimum" value="#minimum#">
			<input type="hidden" name="reorder" value="#reorder#">
		</form>
		<script language="javascript" type="text/javascript">
			done.submit()
		</script>
	<cfelseif isdefined("form.searchitem") and form.searchitem eq "Search">
		<form action="location_opening_qty_maintenance_search_item.cfm" name="done" method="post">
			<input type="hidden" name="location" value="#location#">
			<input type="hidden" name="qtybf" value="#qtybf#">
			<input type="hidden" name="minimum" value="#minimum#">
			<input type="hidden" name="reorder" value="#reorder#">
		</form>
		<script language="javascript" type="text/javascript">
			done.submit();
		</script>
	</cfif>
</cfoutput>

<cfif isdefined("url.modeaction")>
	<cfset mode = url.modeaction>
</cfif>

<body onLoad="javascript:if(document.getElementById('qtybf')!=undefined){document.getElementById('qtybf').focus();}">
<h1 align="center">Edit Location Opening Quantity (limit to 10,000 record only)</h1>

<cfif isdefined("url.type") and url.type eq "delete">
	<cfquery name="delete_location_item" datasource="#dts#">
		delete from locqdbf 
		where location=<cfqueryparam cfsqltype="cf_sql_char" value="#url.location#">
		and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#url.itemno#">;
	</cfquery>

<cfelseif isdefined("url.type") and url.type eq "edit">
	<cfquery name="edit_location_item" datasource="#dts#">
		update locqdbf set 
		locqfield='#val(form.qtybf)#',
		lminimum='#val(form.minimum)#',
		lreorder='#val(form.reorder)#' 
		where location=<cfqueryparam cfsqltype="cf_sql_char" value="#url.location#"> 
		and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#url.itemno#">;
	</cfquery>

	<h3 align="center">The Location - Item Has Been Edited !</h1>
</cfif>

<cfif isdefined("form.save") and form.save eq "Save">
	<cfif form.location eq "">
		<script language="javascript" type="text/javascript">
			alert("Please Select A Location !");
			javascript:history.back();
		</script>
		<cfabort>
	<cfelseif form.items eq "">
		<script language="javascript" type="text/javascript">
			alert("Please Select An Item !");
			javascript:history.back();
		</script>
		<cfabort>
	<cfelseif not isnumeric(form.qtybf)>
		<script language="javascript" type="text/javascript">
			alert("Please Enter Correct Qty B/F!");
			javascript:history.back();
		</script>
		<cfabort>	
	</cfif>
	
	<cfquery name="checkitem" datasource="#dts#">
		select itemno 
		from icitem 
		where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#form.items#">;
	</cfquery>
	
	<cfif checkitem.recordcount neq 0>
		<cftry>
			<cfquery name="insert_location_item_record" datasource="#dts#">
				insert into locqdbf 
				(
					location,
					itemno,
					locqfield,
					locqactual,
					locqtran,
					lminimum,
					lreorder,
					qty_bal,
					val_bal,
					price,
					wos_group,
					category,
					shelf,
					supp
				)
				values
				(
					<cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#form.items#">,
					'#val(form.qtybf)#',
					<cfqueryparam cfsqltype="cf_sql_char" value="0">,
					<cfqueryparam cfsqltype="cf_sql_char" value="0">,
					'#val(form.minimum)#',
					'#val(form.reorder)#',
					<cfqueryparam cfsqltype="cf_sql_char" value="0">,
					<cfqueryparam cfsqltype="cf_sql_char" value="0">,
					<cfqueryparam cfsqltype="cf_sql_char" value="0">,
					<cfqueryparam cfsqltype="cf_sql_char" value="">,
					<cfqueryparam cfsqltype="cf_sql_char" value="">,
					<cfqueryparam cfsqltype="cf_sql_char" value="">,
					<cfqueryparam cfsqltype="cf_sql_char" value="">
				<!--- '#form.location#','#form.items#','#form.qtybf#','0','0','#form.minimum#','#form.reorder#','0','0','0','','','','' --->
				);
			</cfquery>
			<cfcatch type="database">
				<h3 align="center">The Location - Item Found ! Please Check Again !</h1>
			</cfcatch>
		</cftry>
	<cfelse>
		<cfoutput><h3 align="center">The Location - Item Exist !</h1></cfoutput>
	</cfif>
	<cfset mode = "add">
<cfelseif isdefined("form.add") and form.add eq "Add">
	<cfset mode = "add">
<cfelseif isdefined("form.cancel") and form.cancel eq "Cancel">
	<cfset mode = "cancel">
<cfelseif isdefined("form.generate") and form.generate eq "Generate">
	<cfquery name="get_all_location_item" datasource="#dts#">
		update icitem,(select location,itemno,sum(locqfield) as balance from locqdbf group by itemno) as location_item_info 
		set icitem.qtybf=location_item_info.balance 
		where icitem.itemno=location_item_info.itemno;
	</cfquery>
	
	<h3 align="center">Generate Location - Item Completed!</h1>
	<cfset mode = "no">
<cfelseif isdefined("form.deleteunwanted") and form.deleteunwanted eq "Delete Unused Location-Item">
	<cfif lcase(HcomID) eq "migif_i">
		<cfquery name="getlocqdbf" datasource="#dts#">
			select location,itemno from locqdbf
			where locqfield=0 
			and location <>'AAA-WAREHOUSE'
		</cfquery>
		<cfloop query="getlocqdbf">
			<cfset thisloc=getlocqdbf.location>
			<cfset thisitem=getlocqdbf.itemno>
			
			<cfquery name="checkexist" datasource="#dts#">
				select location,itemno from ictran
				where itemno='#thisitem#'
				and location='#thisloc#'
				and linecode=''
				limit 1
			</cfquery>
			<cfif checkexist.recordcount eq 0>
				<cfquery name="delete" datasource="#dts#">
					delete from locqdbf
					where location='#thisloc#'
					and itemno='#thisitem#'
				</cfquery>
			</cfif>
		</cfloop>
	<cfelse>
		<cfquery name="getlocqdbf" datasource="#dts#">
			select location,itemno from locqdbf
			where locqfield=0 
		</cfquery>
		<cfloop query="getlocqdbf">
			<cfset thisloc=getlocqdbf.location>
			<cfset thisitem=getlocqdbf.itemno>
			
			<cfquery name="checkexist" datasource="#dts#">
				select location,itemno from ictran
				where itemno='#thisitem#'
				and location='#thisloc#'
				limit 1
			</cfquery>
			<cfif checkexist.recordcount eq 0>
				<cfquery name="delete" datasource="#dts#">
					delete from locqdbf
					where location='#thisloc#'
					and itemno='#thisitem#'
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
	<cfset mode = "no">
</cfif>

<cfif lcase(HcomID) eq "migif_i">
	<!--- <cfquery name="delete_unwanted_location_item" datasource="#dts#">
		delete 
		a 
		from
		locqdbf as a,
		(
			select location,itemno
			from ictran
			where location<>'' and location <>'AAA-WAREHOUSE'
			and linecode=''
			group by location,itemno
			order by location,itemno
		) as b 
		where a.locqfield='' 
		and a.location<>b.location 
		and a.itemno<>b.itemno;
	</cfquery> --->
	
	<cfquery name="insert_new_location_item" datasource="#dts#">
		insert ignore into locqdbf 
		(
			itemno,
			location
		)
		(
			select 
			itemno,
			location 
			from ictran 
			where location<>'' and location <> 'AAA-WAREHOUSE'
			group by location,itemno
			order by location,itemno
		)
	</cfquery>
	
	<cfquery name="insert_new_location_item" datasource="#dts#">
		insert ignore into locqdbf 
		select 
		itemno,
		'AAA-WAREHOUSE',
		'','','','','','','','','','','','' 
		from icitem
	</cfquery>
<cfelse>
	<!--- <cfquery name="delete_unwanted_location_item" datasource="#dts#">
		delete 
		a 
		from
		locqdbf as a,
		(
			select location,itemno
			from ictran
			where location<>''
			and linecode=''
			group by location,itemno
			order by location,itemno
		) as b 
		where a.locqfield='' 
		and a.location<>b.location 
		and a.itemno<>b.itemno;
	</cfquery>  --->
	
	<cfquery name="insert_new_location_item" datasource="#dts#">
		insert ignore into locqdbf 
		(
			itemno,
			location
		)
		(
			select 
			itemno,
			location 
			from ictran 
			where location<>'' 
			group by location,itemno
			order by location,itemno
		)
	</cfquery>
</cfif>

<cfquery name="get_location_item" datasource="#dts#">
	select location,itemno,locqfield,lreorder,lminimum 
	from locqdbf 
	order by location,itemno limit 10000;
</cfquery>

<cfif get_location_item.recordcount eq 0>
	<cfset mode = "firstadd">
	<h3 align="center">No Location - Item Record Found ! Please Add a Record !</h3>
</cfif>

<cfif get_location_item.recordcount neq 0>
	<table id="page" align="center" class="example table-autosort table-stripeclass:alternate table-autopage:20 table-page-number:t1page table-page-count:t1pages table-filtered-rowcount:t1filtercount table-rowcount:t1allcount table-autofilter">
		<thead>
			<tr>
				<th class="table-sortable:default filterable">Location</th>
				<th class="table-sortable:default">Item No.</th>
				<th class="table-sortable:numeric">Qty B/f</th>
				<th class="table-sortable:numeric">Reorder</th>
				<th class="table-sortable:numeric">Minimum</th>
				<th>Action</th>
			</tr>
			<tr>
				<th><input name="filter" size="8" onKeyUp="javascript:Table.filter(this,this);"></th>
				<th><input name="filter" size="8" onKeyUp="javascript:Table.filter(this,this);"></th>
				<th>
					<select onChange="javascript:Table.filter(this,this);">
						<option value="function(){return true;}">All</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))>0;}">> 0</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))==0;}">= 0</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))<0;}">< 0</option>
					</select>
				</th>
				<th>
					<select onChange="javascript:Table.filter(this,this);">
						<option value="function(){return true;}">All</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))>0;}">> 0</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))==0;}">= 0</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))<0;}">< 0</option>
					</select>
				</th>
				<th>
					<select onChange="javascript:Table.filter(this,this);">
						<option value="function(){return true;}">All</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))>0;}">> 0</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))==0;}">= 0</option>
						<option value="function(val){return parseFloat(val.replace(/\$/,''))<0;}">< 0</option>
					</select>
				</th>
				<th>&lt;&lt;&lt; Filters</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="get_location_item">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td nowrap><div align="left">#get_location_item.location#</div></td>
				<td nowrap><div align="left">#get_location_item.itemno#</div></td>
				<td nowrap><div align="right">#get_location_item.locqfield#</div></td>
				<td nowrap><div align="right">#get_location_item.lreorder#</div></td>
				<td nowrap><div align="right">#get_location_item.lminimum#</div></td>
				<td nowrap><div align="center">
				<a href="location_opening_qty_maintenance.cfm?type=delete&modeaction=#mode#&location=#URLEncodedFormat(get_location_item.location)#&itemno=#URLEncodedFormat(get_location_item.itemno)#" onClick="javascript:return confirm('Are You Sure ?');">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
				<a href="edit_location_item.cfm?type=edit&modeaction=#mode#&location=#URLEncodedFormat(get_location_item.location)#&itemno=#URLEncodedFormat(get_location_item.itemno)#">
				<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>
				</div></td>
			</tr>
			</cfoutput>
		</tbody>
		<tfoot>
			<tr>
				<td onClick="javascript:pageexample(0);return false;">First Page</td>
				<td class="table-page:previous"><<< Previous</td>
				<td colspan="2" style="text-align:center;">Page <span id="t1page"></span> &nbsp; of <span id="t1pages"></span></td>
				<td class="table-page:next">Next >>></td>
				<td onClick="javascript:pageexample(parseInt(document.getElementById('t1pages').innerHTML));return false;">Last Page</td>
			</tr>
			<tr>
				<td colspan="6"><span id="t1filtercount"></span> &nbsp; of <span id="t1allcount"></span> &nbsp; rows match filter(s)</td>
			</tr>
			<tr>
				<td colspan="6">
					Please Enter Page No >>>
					<input id="enter_page" size="8" onKeyUp="javascript:pageexample(this.value-1);return false;" onFocusOut="javascript:this.value=''">
				</td>
			</tr>
		</tfoot>
	</table>
</cfif>
<br><br><br>
<table align="center">
<cfoutput>
<cfform name="locationitemform" action="location_opening_qty_maintenance.cfm?modeaction=#urlencodedformat(url.modeaction)#" method="post">
	<cfif mode eq "firstadd" or mode eq "add" or mode eq "delete">
	
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp 
		from icitem 
		order by itemno;
	</cfquery>
	
	<cfquery name="getlocation" datasource="#dts#">
		select location,desp 
		from iclocation 
		order by location;
	</cfquery>

	<tr align="left">
		<th>Location</th>
		<td nowrap>
			<select name="location">
				<option value="">Please Select a Location</option>
				<cfoutput>
				<cfloop query="getlocation">
					<cfif isdefined("form.select1") and form.select1 eq getlocation.location>
						<option value="#getlocation.location#" selected>#getlocation.location# - #getlocation.desp#</option>
					<cfelseif isdefined("form.select2") and form.select2 eq getlocation.location>
						<option value="#getlocation.location#" selected>#getlocation.location# - #getlocation.desp#</option>
					<cfelseif isdefined("form.select3") and form.select3 eq getlocation.location>
						<option value="#getlocation.location#" selected>#getlocation.location# - #getlocation.desp#</option>
					<cfelseif isdefined("form.location") and form.location eq getlocation.location>
						<option value="#getlocation.location#" selected>#getlocation.location# - #getlocation.desp#</option>
					<cfelse>
						<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
					</cfif>
				</cfloop>
				</cfoutput>
			</select>
			<input type="submit" name="selectlocation" value="Search">
		</td>
	</tr>
	<tr align="left">
	<th>Item No</th>
		<td nowrap>
			<select name="items">
				<option value="">Please Select a Item</option>
				<cfoutput>
				<cfloop query="getitem">
					<cfif isdefined("form.item1") and form.item1 eq getitem.itemno>
						<option value="#convertquote(getitem.itemno)#" selected>#getitem.itemno# - #getitem.desp#</option>
					<cfelseif isdefined("form.item2") and form.item2 eq getitem.itemno>
						<option value="#convertquote(getitem.itemno)#" selected>#getitem.itemno# - #getitem.desp#</option>
					<cfelseif isdefined("form.item3") and form.item3 eq getitem.itemno>
						<option value="#convertquote(getitem.itemno)#" selected>#getitem.itemno# - #getitem.desp#</option>
					<cfelseif isdefined("form.items") and form.items eq getitem.itemno>
						<option value="#convertquote(getitem.itemno)#" selected>#getitem.itemno# - #getitem.desp#</option>
					<cfelse>
						<option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
					</cfif>
				</cfloop>
				</cfoutput>
			</select>
			<input type="submit" name="searchitem" value="Search">
		</td>
	</tr>
	<tr align="left">
		<th>QTY B/F</th>
		<td nowrap>
			<cfif isdefined("form.qtybf")>
				<cfinput name="qtybf" type="text" size="5" maxlength="5" validate="integer" message="The Qty B/F Must Be Integer" value="#form.qtybf#">
			<cfelse>
				<cfinput name="qtybf" type="text" size="5" maxlength="5" validate="integer" message="The Qty B/F Must Be Integer">
			</cfif>
		</td>
	</tr>
	<tr align="left">
		<th>Minimum</th>
		<td nowrap>
			<cfif isdefined("form.minimum")>
				<cfinput name="minimum" type="text" size="8" maxlength="17" validate="float" message="Please Enter Correct Minimum Value !" value="#form.minimum#">
			<cfelse>
				<cfinput name="minimum" type="text" size="8" maxlength="17" validate="float" message="Please Enter Correct Minimum Value !">
			</cfif>
		</td>
	</tr>
	<tr>
		<th>Reorder</th>
		<td nowrap>
			<cfif isdefined("form.reorder")>
				<cfinput name="reorder" type="text" size="10" maxlength="10" validate="float" message="Please Enter Correct Reorder Value !" value="#form.reorder#">
			<cfelse>
				<cfinput name="reorder" type="text" size="10" maxlength="10" validate="float" message="Please Enter Correct Reorder Value !">
			</cfif>	
		</td>
	</tr>
	</cfif>
</table>

<table align="center">
	<tr align="center">
		<cfif mode eq "no" or mode eq "delete">
			<!--- <td nowrap><cfinput name="add" type="submit" value="Add"></td> ---> 
			<td nowrap><input name="add" type="button" value="Add" onClick="AddNew();"></td>
			<td nowrap><cfinput name="generate" type="submit" value="Generate"></td>
			<td nowrap><input name="deleteunwanted" type="submit" value="Delete Unused Location-Item"></td>
		</cfif>
		<cfif mode eq "firstadd" or mode eq "add">
			<td nowrap><cfinput name="save" type="submit" value="Save"></td>
		</cfif>
		<cfif mode neq "firstadd" and mode eq "add">
			<td nowrap><input name="cancel" type="button" value="Cancel" onClick="window.location='location_opening_qty_maintenance.cfm?modeaction=no'"></td>
		</cfif>
		<td nowrap><input name="print" type="button" value="Print" onClick="window.open('location_opening_qty_maintenance_print.cfm')">
	</tr>
</table>
</cfform>
</cfoutput>

</body>
</html>