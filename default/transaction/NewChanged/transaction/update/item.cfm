<table width="350" border="0" cellpadding="5">
	<tr>
    	<td colspan="4">
    		<cfoutput><table border="0" cellpadding="5" id="item#location#_#refno#" style="display:none;"></cfoutput>
				<tr>
          			<th>Item No</th>
			        <th>Item Description</th>
			        <th>Qty Order</th>
			        <th>To Bill</th>
			    </tr>				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#refno#' and type = '#t1#' and (shipped+writeoff) < qty 
						and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
						order by trancode 
					</cfquery> 

					<cfoutput query="getupdate">

						<cfquery datasource="#dts#" name="getupqty">
							select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
							and frtype = '#t1#' and (type = 'INV' or type = 'DO') and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
						</cfquery>
					
						<cfif getupqty.sumqty neq "">
							<cfset upqty = getupqty.sumqty>
						<cfelse>
							<cfset upqty = 0>
						</cfif>
	
						<cfif getupdate.recordcount gt 0>
							<cfset order = getupdate.qty - val(getupdate.writeoff)>
						<cfelse>
							<cfset order = 0>
						</cfif>
					
						<cfset qtytoful = order - upqty>
	        			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					        <td>#itemno#</td>
					        <td>#desp#</td>
					        <td><div align="center">#QTY#</div></td>
	         				<cfif trim(itemno) eq ''>
				          		<!--- Just assign a value, because ColdFusion ignores empty list elements --->
				          		<cfset xitemno = 'YHFTOKCF'>
				        	<cfelse>
				          		<cfset xitemno = itemno>
				        	</cfif>
				        	
	         				<td><input type="checkbox" name="checkbox" id="checkbox_#refno#_#location#" value=";#refno#;#convertquote(xitemno)#;#trancode#" checked></td>
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#'
							</cfquery>	
	        			</tr>
	        		</cfoutput> 
				</cfloop>  
        	</table>
		</td>
  </tr>
</table>

