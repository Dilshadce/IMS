<table width="400" border="0" cellpadding="5">
	<tr>
    	<td>
    		<cfoutput>
            <table border="0" cellpadding="5" id="item#location#" style="display:none;">
			</cfoutput>
                <tr>
                    <th>Item No</th>
                    <th>Item Description</th>
                    <th>Qty Order</th>
                    <th>Qty Outstanding</th>
                    <th>To Bill</th>
                </tr>	
                <cfquery datasource="#dts#" name="getupdate">
                    Select * from ictran 
                    where refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
                    and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">
                    #msg1#
                    and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#">
                    order by trancode 
                </cfquery> 

				<cfoutput query="getupdate">
                    <cfquery datasource="#dts#" name="getupqty">
                        select sum(qty)as sumqty from iclink where frrefno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
                        and frtype =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#"> 
                        and type in (#ListQualify(tt_type,"'")#) and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
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
                        <td><div align="center">#qtytoful#</div></td>
                        <cfif trim(itemno) eq ''>
                            <!--- Just assign a value, because ColdFusion ignores empty list elements --->
                            <cfset xitemno = 'YHFTOKCF'>
                        <cfelse>
                            <cfset xitemno = itemno>
                        </cfif>
                        
                        <td><input type="checkbox" name="checkbox" id="checkbox_#location#" value=";#convertquote(xitemno)#;#trancode#" checked></td>
                    </tr>
                </cfoutput> 			
        	</table>
        </td>
    </tr>
</table>

