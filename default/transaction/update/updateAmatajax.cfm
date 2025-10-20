<cfquery name="getgsetup" datasource='#dts#'>
  	Select * from gsetup
</cfquery>

<cfif url.updatemat eq '1'>
<cfquery datasource="#dts#" name="getupdate">
			Select b.* from artran a, ictranmat b where a.refno = b.refno and a.type = b.type and a.custno = '#url.custno#' and a.type = '#url.t1#'
			and a.exported = '' and b.exported = '' <cfif getgsetup.updatetopo neq 'Y'>and a.order_cl = '' and b.toinv = ''</cfif> and (b.void = '' or b.void is null) group by a.refno order by a.refno
	  	</cfquery>
<cfelse>
<cfquery datasource="#dts#" name="getupdate">
			Select b.* from artran a, ictran b where a.refno = b.refno and a.type = b.type and a.custno = '#url.custno#' and a.type = '#url.t1#'
			and a.exported = '' and b.exported = '' <cfif getgsetup.updatetopo neq 'Y'>and a.order_cl = '' and b.toinv = ''</cfif> and (b.void = '' or b.void is null) group by a.refno order by a.refno
	  	</cfquery>
</cfif>		
<cfoutput>
            <table class="data" align="center">
            	<tr>
              		<th>Sales Order</th>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>To Bill</th>
             	 	<th>User</th>
           	 	</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
              		<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#'
              		</cfquery>

					<td>#getid.userid#</td>
            	</tr>
          </cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
               	 		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
</table>