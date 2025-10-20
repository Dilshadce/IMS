<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "58,274,65,1121,1096,592,1097,10,805">
<cfinclude template="/latest/words.cfm">

<cfsetting showdebugoutput="no">
<cfset uuid = url.uuid>

<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode asc
</cfquery>

<cfoutput>

<table class="table" border="1">
						<thead>
							<tr>
								<th width="77">#words[58]#</th>
								<th width="69">#words[274]#</th>
								<th width="77">#words[65]#</th>
								<th width="85">#words[1121]#</th>
								<th width="93">#words[1096]#</th>
								<th width="85">#words[592]#</th>
								<th width="93">#words[1097]#</th>
                                <th width="77" style="text-align:center">#words[10]#</th>
							</tr>
						</thead>                      
						<tbody >
                        <cfloop query="getictrantemp">
							<tr>
								<td nowrap><font style="font-size:14px"><label for="no" id="no">#getictrantemp.itemcount#</label></td>
								<td nowrap><font style="font-size:14px"><label for="itemCode" id="itemCode">#getictrantemp.itemno#</label></td>
								<td nowrap><font style="font-size:14px"><label for="desp" id="desp">#getictrantemp.desp#</label></td>
                                <td nowrap align="right"><font style="font-size:14px"><a style="cursor:pointer" data-toggle="modal" data-target=".change" onClick="changeqty('#getictrantemp.trancode#','#numberformat(val(getictrantemp.qty_bil),',.__')#','qty_bil1')">#numberformat(val(getictrantemp.qty_bil),',.__')#</a></font></td>
								<td nowrap align="right"><font style="font-size:14px"><cfif getpin2.h2F00 eq "T"><a style="cursor:pointer" data-toggle="modal" data-target=".change" onClick="changeprice('#getictrantemp.trancode#','#numberformat(val(getictrantemp.price_bil),',.__')#','price_bil1')">#numberformat(val(getictrantemp.price_bil),',.__')#</a><cfelse>#numberformat(val(getictrantemp.price_bil),',.__')#</cfif></font></td>
								<td nowrap align="right"><font style="font-size:14px"><a style="cursor:pointer" data-toggle="modal" data-target=".change" onClick="changediscount('#getictrantemp.trancode#','#getictrantemp.disamt_bil#','disamt_bil1')"><cfif getictrantemp.disamt_bil eq ''>-<cfelse>#getictrantemp.disamt_bil#</cfif></a></font></td>
								<td nowrap align="right"><font style="font-size:14px"><a style="cursor:pointer" data-toggle="modal" data-target=".change" onClick="changeamt('#getictrantemp.trancode#','#numberformat(val(getictrantemp.amt_bil),',.__')#','amt_bil1')">#numberformat(val(getictrantemp.amt_bil),',.__')#</a></font></td>
								<td nowrap align="center"><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are you confirm to delete?')){deleterow('#getictrantemp.trancode#')}" value="#words[805]#"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"></td>
							</tr>
                        </cfloop>
						</tbody>       
					</table>  
</cfoutput>
