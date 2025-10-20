<cfajaximport tags="cfform">
<html>
<head>
<title>Edit Item - Grade Opening Quantity</title>
<link rel="stylesheet" type="text/css" href="/stylesheet/table.css" media="all">
<script language="javascript" type="text/javascript" src="/scripts/table.js"></script>
</head>
<body onLoad="document.getElementById('enter_page').focus();document.getElementById('Generate').focus();">
<h1 align="center">Edit Item - Grade Opening Quantity</h1>
<h3>Click on the qty to assign the qty for graded item!</h3>

<cfif isdefined('url.pageno')>
<cfset pageno=url.pageno>
<cfelse>
<cfset pageno=1>
</cfif>

<cfset totcol = 4>
<cfset firstcount = 11>
<cfset maxcounter = 160>
<cfset totalrecord = (maxcounter - firstcount + 1)>
<cfset totrow = ceiling(totalrecord / totcol)>

<cfif isdefined("form.generate") and form.generate eq "Generate">
	<cfquery name="getlocqty" datasource="#dts#">
		select 
		grd#maxcounter#<cfloop from="#firstcount#" to="#maxcounter-1#" index="i">+grd#i#</cfloop> as locqty,itemno,location 
		from logrdob
	</cfquery>
	<cfloop query="getlocqty">
		<cfquery name="checkexist1" datasource="#dts#">
			select * from locqdbf
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getlocqty.itemno#">
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getlocqty.location#">
		</cfquery>
		
		<cfif checkexist1.recordcount eq 0>
			<cfquery name="insert" datasource="#dts#">
				insert into locqdbf 
				(itemno,location)
				values
				(<cfqueryparam cfsqltype="cf_sql_char" value="#getlocqty.itemno#">,
				<cfqueryparam cfsqltype="cf_sql_char" value="#getlocqty.location#">)
			</cfquery>
		</cfif>
		
		<cfquery name="update" datasource="#dts#">
			update locqdbf
			set locqfield = #getlocqty.locqty#
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getlocqty.itemno#">
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getlocqty.location#">
		</cfquery>
	</cfloop>
	
	<cfquery name="getitemqty" datasource="#dts#">
		select itemno,sum(locqfield) as balance from locqdbf group by itemno
	</cfquery>
	<cfloop query="getitemqty">
		<cfquery name="updaticiteme" datasource="#dts#">
			update icitem
			set qtybf= #getitemqty.balance# 
			where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getitemqty.itemno#">
		</cfquery>
	</cfloop>
	
	<h3 align="center">Generate Location - Graded - Item Completed!</h3>
	
</cfif>

<cfquery name="getitem" datasource="#dts#">
	SELECT itemno,wos_group,qtybf FROM icitem
	where graded = 'Y' and wos_group <> ''
    <cfif isdefined('form.catefrom') and isdefined('form.cateto')>
    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
	and category between <cfqueryparam cfsqltype="cf_sql_char" value="#form.catefrom#"> and <cfqueryparam cfsqltype="cf_sql_char" value="#form.cateto#">
	</cfif>
    </cfif>
     <cfif isdefined('form.groupfrom') and isdefined('form.groupto')>
    <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	and wos_group between <cfqueryparam cfsqltype="cf_sql_char" value="#form.groupfrom#"> and <cfqueryparam cfsqltype="cf_sql_char" value="#form.groupto#">
	</cfif>
    </cfif>
     <cfif isdefined('form.productfrom') and isdefined('form.productto')>
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and itemno between <cfqueryparam cfsqltype="cf_sql_char" value="#form.productfrom#"> and <cfqueryparam cfsqltype="cf_sql_char" value="#form.productto#">
	</cfif>
    </cfif>
	order by itemno
</cfquery>

<cfquery name="getlocation" datasource="#dts#">
	SELECT location FROM iclocation where 1 = 1
    <cfif isdefined('form.loc')>
    and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.loc#">
    </cfif>
</cfquery>
<cfset loc = getlocation.recordcount + 2>
<table id="page" align="center" class="example table-autosort table-stripeclass:alternate table-autopage:20 table-page-number:t1page table-page-count:t1pages table-filtered-rowcount:t1filtercount table-rowcount:t1allcount table-autofilter">
	<thead>
    
		<tr>
			<th class="table-sortable:default filterable" rowspan="2">Item No.</th>
			<th rowspan="2" align="center"><div align="center">Group</div></th>
			<cfoutput><th colspan="#loc#"><div align="center">Qty B/f</div></th></cfoutput>
		</tr>
		<tr>
			<th class="table-sortable:numeric">All</th>
			<cfoutput query="getlocation">
				<th class="table-sortable:numeric">#getlocation.location#</th>
			</cfoutput>
			<th class="table-sortable:numeric">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
	<cfoutput query="getitem">
		<cfset thisitem = getitem.itemno>
		<cfset thisgroup = getitem.wos_group>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        	<td>#getitem.itemno#</td>
            <td align="center">#getitem.wos_group#</td>
            <td>#getitem.qtybf#</td>
			<cfset totlocqty = 0>
			<cfloop query="getlocation">
				<cfset thisloc = getlocation.location>
				<cfquery name="getlocqtybf" datasource="#dts#">
					select locqfield from locqdbf
					where itemno = '#thisitem#'
					and location = '#thisloc#'
				</cfquery>
				<cfif getlocqtybf.recordcount GT 0>
					<cfset locqtybf = getlocqtybf.locqfield>
				<cfelse>
					<cfset locqtybf = 0>
				</cfif>
				<td>
					<div align="center">
						<cfif val(locqtybf) GT 0>
							<a <cfif isdefined('form.loc')>style="cursor:pointer" onClick="
                document.getElementById('itemno1').value='#URLEncodedFormat(thisitem)#';
                document.getElementById('location1').value='#URLEncodedFormat(thisloc)#';
                document.getElementById('qtybf1').value='#locqtybf#';
                document.getElementById('wos_group1').value='#URLEncodedFormat(thisgroup)#';
                ColdFusion.Window.show('editgrade');"<cfelse>href="dsp_editgrade.cfm?itemno=#URLEncodedFormat(thisitem)#&location=#URLEncodedFormat(thisloc)#&qtybf=#locqtybf#&wos_group=#URLEncodedFormat(thisgroup)#&pageno=#round(getitem.currentrow/20)+1#" target="_blank"</cfif>>#locqtybf#</a>
						<cfelse>
							<a <cfif isdefined('form.loc')>style="cursor:pointer" onClick="
                document.getElementById('itemno1').value='#URLEncodedFormat(thisitem)#';
                document.getElementById('location1').value='#URLEncodedFormat(thisloc)#';
                document.getElementById('qtybf1').value='#locqtybf#';
                document.getElementById('wos_group1').value='#URLEncodedFormat(thisgroup)#';
                ColdFusion.Window.show('editgrade');"<cfelse>href="dsp_editgrade.cfm?itemno=#URLEncodedFormat(thisitem)#&location=#URLEncodedFormat(thisloc)#&qtybf=#locqtybf#&wos_group=#URLEncodedFormat(thisgroup)#&pageno=#round(getitem.currentrow/20)+1#" target="_blank"</cfif>>#locqtybf#</a>
						</cfif>
					</div>
					<div id="divmessage_#thisloc#_#thisitem#" style="display:none;">
						hello
					</div>
				</td>
				<cfset totlocqty = totlocqty + locqtybf>
			</cfloop>
			<cfset balqty = val(getitem.qtybf) - totlocqty>
			<td>
				<a   <cfif isdefined('form.loc')>style="cursor:pointer" onClick="
                document.getElementById('itemno1').value='#URLEncodedFormat(thisitem)#';
                document.getElementById('location1').value='';
                document.getElementById('qtybf1').value='#balqty#';
                document.getElementById('wos_group1').value='#URLEncodedFormat(thisgroup)#';
                ColdFusion.Window.show('editgrade');"<cfelse>href="dsp_editgrade.cfm?itemno=#URLEncodedFormat(thisitem)#&location=&qtybf=#balqty#&wos_group=#URLEncodedFormat(thisgroup)#&pageno=#round(getitem.currentrow/20)+1#" target="_blank"</cfif>>#balqty#</a>
			</td>
        </tr>
	</cfoutput>
	</tbody>
	<cfset counter = loc - 2>
	<tfoot>
		<tr>
			<td onClick="javascript:pageexample(0);document.getElementById('enter_page').value=1;javascript:pageexample(document.getElementById('enter_page').value-1);return false;">First Page</td>
			<td ><a onClick="document.getElementById('enter_page').value=document.getElementById('enter_page').value-1;javascript:pageexample(document.getElementById('enter_page').value-1);"><<< Previous</a></td>
			<cfoutput><td colspan="#counter#" style="text-align:center;">Page <span id="t1page"></span> &nbsp; of <span id="t1pages"></span></td></cfoutput>
			<td><a onClick="document.getElementById('enter_page').value=(document.getElementById('enter_page').value*1)+1;javascript:pageexample(document.getElementById('enter_page').value-1);">>Next >>></a></td>
			<td onClick="javascript:pageexample(parseInt(document.getElementById('t1pages').innerHTML));document.getElementById('enter_page').value=parseInt(document.getElementById('t1pages').innerHTML);return false;">Last Page</td>
		</tr>
		<tr>
			<td colspan="100%">
				Please Enter Page No >>>
                <cfoutput>
				<input id="enter_page" size="8" onKeyUp="javascript:pageexample(this.value-1);return false;" onBlur="javascript:pageexample(this.value-1);return false;"  value="#pageno#">
                </cfoutput>
			</td>
		</tr>
	</tfoot>
</table>
<form name="itemform" action="grade_opening_qty_maintenance.cfm" method="post">
	<table align="center">
		<tr align="center">
			<td nowrap><input type="submit" value="Generate" name="generate" alt="Generate Opening Qty From Location"></td>
		</tr>
        
	</table>
<input type="hidden" name="itemno1" id="itemno1"  value="">
<input type="hidden" name="wos_group1" id="wos_group1" value="">   
<input type="hidden" name="location1" id="location1" value="">  
<input type="hidden" name="qtybf1" id="qtybf1" value="">  
</form>

<cfwindow center="true" width="700" height="500" name="editgrade" refreshOnShow="true"
        title="Edit Grade Openning Qty" initshow="false"
        source="dsp_editgrade1.cfm?itemno={itemno1}&location={location1}&qtybf={qtybf1}&wos_group={wos_group1}" />
        
	<script type="text/javascript">
		function checkqty(){
			var exactqty = document.getElementById('qtybf').value;
			var firstcount = document.getElementById('firstcount').value;
			var maxcounter = document.getElementById('maxcounter').value;
			
			var totqty = 0;
			varlist = document.getElementById('varlist').value;
			var newArray = varlist.split(",");
			
			newlistvalue = "";
			for(i=0;i<newArray.length;i++){
				totqty = totqty + parseInt(document.getElementById(newArray[i]).value);
				if(i==0){
					newlistvalue = document.getElementById(newArray[i]).value;
				}
				else{
					newlistvalue = newlistvalue + "," + document.getElementById(newArray[i]).value;
				}
			}
			document.getElementById('qtybflist').value = newlistvalue;
			//if(totqty > exactqty){
				//alert("The total qty cannot more than " + exactqty);
				//return false;
			//}
			//else{
				//return true;
			//}
		}
	</script>
</body>
</html>
